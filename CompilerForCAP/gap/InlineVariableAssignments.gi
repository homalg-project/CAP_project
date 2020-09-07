#
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitInlinedVariableAssignments, function ( tree, args... )
  local inline_gvars_only, condition_func, path, lvar_path, lvar_assignment, parent_path, parent, inline_tree, subsequent_child, inline_tree_path, inline_tree_parent, func_path, func, func_id, number_of_assignments, pre_func, rhs, number_of_uses, modified_inline_tree;
    
    if not Length( args ) in [ 0, 1 ] then
        
        Error( "CapJitInlinedVariableAssignments cannot be called with more than two arguments" );
        
    fi;

    if Length( args ) = 1 then
        
        Assert( 0, IsBool( args[1] ) );
        
        inline_gvars_only := args[1];
        
    else
        
        inline_gvars_only := false;
        
    fi;
  
    tree := StructuralCopy( tree );
    
    # find STAT_ASS_FVAR
    condition_func := function ( tree, path )
        
        if tree.type = "STAT_ASS_FVAR" and (not inline_gvars_only or tree.rhs.type = "EXPR_REF_GVAR") then
            
            if IsBound( tree.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT ) and tree.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT then
                
                return false;
                
            fi;
            
            return true;
            
        fi;
        
        return false;
        
    end;
    
    lvar_path := CapJitFindNodeDeep( tree, condition_func );
    
    if lvar_path = fail then
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Inlined all variables, finished." );

        # reset CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT
        pre_func := function ( tree, additional_arguments )
          local level, pos;
            
            if IsRecord( tree ) and IsBound( tree.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT ) then
                
                Unbind( tree.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT );
                
            fi;
                
            return tree;
            
        end;
        
        CapJitIterateOverTree( tree, pre_func, ReturnTrue, ReturnTrue, true );
        
        return tree;
        
    fi;

    lvar_assignment := CapJitGetNodeByPath( tree, lvar_path );
    parent_path := lvar_path{[ 1 .. Length( lvar_path ) - 1 ]};
    parent := CapJitGetNodeByPath( tree, parent_path );

    # assert that parent is a STAT_SEQ_STAT
    Assert( 0, IsInt( Last( lvar_path ) ) and Last( parent_path ) = "statements" and IsList( parent ) );
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, Concatenation( "Try to inline variable with initial name ", lvar_assignment.initial_name ), "." );
    
    # we want to ignore the variable in the next iteration in any case
    lvar_assignment.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT := true;
    
    inline_tree := fail;
    
    if Length( parent ) >= Last( lvar_path ) + 1 then
        
        subsequent_child := parent[Last( lvar_path ) + 1];

        # detect "rapid reassignment"
        if subsequent_child.type = "STAT_ASS_FVAR" and subsequent_child.func_id = lvar_assignment.func_id and subsequent_child.pos = lvar_assignment.pos then
            
            Info( InfoCapJit, 1, "Found rapid reassignment." );
            
            inline_tree := subsequent_child.rhs;
            inline_tree_path := Concatenation( parent_path, [ Last( lvar_path ) + 1, "rhs" ] );
            inline_tree_parent := subsequent_child;
            
        else
            
            inline_tree_path := parent_path;
            inline_tree := parent;
            inline_tree_parent := CapJitGetNodeByPath( tree, parent_path{[ 1 .. Length( parent_path ) - 1 ]} );
            
        fi;
        
    else
        
        Info( InfoCapJit, 1, "Variable assignment is the last statement in STAT_SEQ_STAT. Skip inlining..." );
        
        return CapJitInlinedVariableAssignments( tree, inline_gvars_only );
        
    fi;

    # replace all references to lvar by rhs
    rhs := lvar_assignment.rhs;
    number_of_uses := 0;
    
    pre_func := function ( tree, additional_arguments )
        
        if IsRecord( tree ) then
            
            if PositionSublist( tree.type, "FVAR" ) <> fail and tree.func_id = lvar_assignment.func_id and tree.pos = lvar_assignment.pos then
                
                if tree.type = "EXPR_REF_FVAR" then
                    
                    number_of_uses := number_of_uses + 1;

                    return StructuralCopy( rhs );
                
                fi;
                
            fi;

        fi;
            
        return tree;
        
    end;
    
    modified_inline_tree := CapJitIterateOverTree( inline_tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );

    if number_of_uses = 0 then

        Info( InfoCapJit, 1, "Variable is unused." );
        
    else
        
        Info( InfoCapJit, 1, "Success." );
        
        # replace inline_tree
        if IsInt( Last( inline_tree_path ) ) then
            
            Assert( 0, IsList( inline_tree_parent ) );
            
            inline_tree_parent[Last( inline_tree_path )] := modified_inline_tree;
            
        else
            
            Assert( 0, IsRecord( inline_tree_parent ) );
            
            inline_tree_parent.(Last( inline_tree_path )) := modified_inline_tree;
            
        fi;
        
    fi;

    # drop lvar assignment if possible

    # get func containing lvar assignment
    func_path := ShallowCopy( lvar_path );
    
    # find "stats"
    while Last( func_path ) <> "stats" do
        
        Remove( func_path );
        
    od;
    
    # remove "stats"
    Remove( func_path );
    
    Info( InfoCapJit, 1, "Try to drop variable assignment:" );
        
    tree := CapJitDroppedUnusedVariables( tree, func_path );
    
    return CapJitInlinedVariableAssignments( tree, inline_gvars_only );
    
end );
