#
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CAP_JIT_INTERNAL_FUNCTION_CAN_BE_INLINED, function( tree )
  local statements, statements_to_check, branch_statements, branch, result_func;
    
    # currently only functions
    # a) ending with a return statement, or
    # b) ending with an if-(elif)-else-statement with return statements at the end of all branches
    # and not containing other return statements can be inlined
    
    statements := tree.stats.statements;

    statements_to_check := fail;
    
    if Last( statements ).type = "STAT_RETURN_OBJ" then
        
        statements_to_check := statements{[ 1 .. Length( statements ) - 1 ]};

    elif Last( statements ).type in [ "STAT_IF_ELSE", "STAT_IF_ELIF_ELSE" ] and ForAll( Last( statements ).branches, b -> Last( b.body.statements ).type = "STAT_RETURN_OBJ" ) then
        
        Assert( 0, Last( Last( statements ).branches ).condition.type = "EXPR_TRUE" );
        
        statements_to_check := statements{[ 1 .. Length( statements ) - 1 ]};

        for branch in Last( statements ).branches do
            
            branch_statements := branch.body.statements;
            statements_to_check := Concatenation( statements_to_check, branch_statements{[ 1 .. Length( branch_statements ) - 1 ]} );
            
        od;
        
    fi;
    
    if statements_to_check = fail then
        
        Info( InfoCapJit, 1, "Function does neither end with a return statement nor an if-(elif)-else-statement" );
        
        return false;
        
    fi;
    
    # check if another return statement occurs
    result_func := function( tree, result, additional_arguments )
        
        if IsList( tree ) then
            
            return true in result;
            
        elif IsRecord( tree ) then
            
            if tree.type = "EXPR_FUNC" then
                
                # return statements inside of another function do not matter
                return false;
                
            elif tree.type = "STAT_RETURN_OBJ" then
                
                return true;
                
            fi;
            
            return ForAny( RecNames( result ), key -> result.(key) );
            
        else
            
            Error( "this should never happen" );
            
        fi;
        
    end;

    if CapJitIterateOverTree( statements_to_check, ReturnFirst, result_func, ReturnTrue, true ) then
        
        Info( InfoCapJit, 1, "Function contains another return statement." );
        
        return false;
        
    fi;
    
    return true;
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID, function( tree, source_func_id, target_func_id, offset )
  local result_func, additional_arguments_func;
  
    result_func := function( tree, result, additional_arguments )
      local key, level;
        
        if IsList( result ) then
            
            return result;

        elif IsRecord( result ) then
            
            tree := ShallowCopy( tree );
            
            for key in RecNames( result ) do
                
                tree.(key) := result.(key);

            od;

            if PositionSublist( tree.type, "FVAR" ) <> fail then
                
                if tree.func_id = source_func_id then
                    
                    tree.func_id := target_func_id;
                    tree.pos := tree.pos + offset;
                    
                fi;
                
            fi;
            
            return tree;
            
        else
            
            Error( "this should never happen" );
            
        fi;
        
    end;

    return CapJitIterateOverTree( tree, ReturnFirst, result_func, ReturnTrue, true );
    
end );

BindGlobal( "CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER", 1 );
MakeReadWriteGlobal( "CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER" );
InstallGlobalFunction( CapJitInlinedFunctionCalls, function( tree )
  local pre_func, additional_arguments_func;
    
    pre_func := function( tree, current_func )
      local statements, i, statement, search_key, search_tree, condition_func, found_path, path, func_call, inline_func, counter, new_nams, inline_func_stats, offset, inline_return_statement, return_value_lvar, inline_return_statements, inlined_original_statement, ref_return_value_lvar, parent;
        
        tree := StructuralCopy( tree );
        
        if IsRecord( tree ) and tree.type = "STAT_SEQ_STAT" then
            
            statements := tree.statements;
            
            i := 1;
            
            while i <= Length( statements ) do
                
                statement := statements[i];
                
                if statement.type = "STAT_ASS_FVAR" then
                    
                    search_key := "rhs";
                    
                elif statement.type = "STAT_RETURN_OBJ" then
                    
                    search_key := "obj";
                    
                else
                    
                    i := i + 1;
                    continue;
                    
                fi;
                
                search_tree := statement.(search_key);
                
                condition_func := function( tree, path )
                    
                    if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_FUNC" then
                        
                        # we only want to find function calls inside of the current function, not other functions
                        return not "stats" in path;
                        
                    fi;
                    
                    return false;
                    
                end;
                
                found_path := CapJitFindNodeDeep( search_tree, condition_func );
                
                if found_path = fail then
                    
                    i := i + 1;
                    continue;
                    
                fi;

                path := Concatenation( [ search_key ], found_path );
                
                func_call := CapJitGetNodeByPath( statement, path );
                inline_func := func_call.funcref;
                
                if not ( Length( func_call.args ) = 0 and inline_func.narg = 0 ) then
                    
                    Error( "found function call with arguments, please inline arguments first" );
                    
                fi;
                
                if IsBound( inline_func.name ) then
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, Concatenation( "Try to inline ", inline_func.name ) );
                    
                else
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, "Try to inline function with the following arguments:" );
                    Info( InfoCapJit, 1, inline_func.nams );
                    
                fi;

                if CAP_JIT_INTERNAL_FUNCTION_CAN_BE_INLINED( func_call.funcref ) then
                    
                    counter := CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER;
                    
                    # create new local variables
                    new_nams := List( [ 1 .. inline_func.nloc ], i -> Concatenation( "inline_", String( counter ), "_", inline_func.nams[i] ) );
                    Add( new_nams, Concatenation( "inline_", String( counter ), "_return_value" ) );

                    Assert( 0, IsDuplicateFree( new_nams ) );
                    
                    # prepare function statements for inlining
                    inline_func_stats := StructuralCopy( inline_func.stats );

                    offset := current_func.narg + current_func.nloc;

                    inline_func_stats := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( inline_func_stats, inline_func.id, current_func.id, offset );

                    # find and modify the return statements
                    return_value_lvar := offset + inline_func.nloc + 1;
                    
                    Assert( 0, return_value_lvar = Length( current_func.nams ) + Length( new_nams ) );
                    
                    if Last( inline_func_stats.statements ).type = "STAT_RETURN_OBJ" then
                        
                        inline_return_statements := [ Last( inline_func_stats.statements ) ];
                    
                    elif Last( inline_func_stats.statements ).type in [ "STAT_IF_ELSE", "STAT_IF_ELIF_ELSE" ] then
                        
                        inline_return_statements := List( Last( inline_func_stats.statements ).branches, b -> Last( b.body.statements ) );
                        
                    else
                        
                        Error( "this should never happen" );
                        
                    fi;
                    
                    for inline_return_statement in inline_return_statements do
                    
                        inline_return_statement.type := "STAT_ASS_FVAR";
                        inline_return_statement.func_id := current_func.id;
                        inline_return_statement.pos := return_value_lvar;
                        inline_return_statement.initial_name := Last( new_nams );
                        inline_return_statement.rhs := inline_return_statement.obj;
                        Unbind( inline_return_statement.obj );

                    od;
                    
                    # modify original statement
                    inlined_original_statement := StructuralCopy( statement );
                    ref_return_value_lvar := rec(
                        type := "EXPR_REF_FVAR",
                        func_id := current_func.id,
                        pos := return_value_lvar,
                        initial_name := Last( new_nams ),
                    );
                    
                    parent := CapJitGetNodeByPath( inlined_original_statement, path{[ 1 .. (Length( path ) - 1) ]} );
                    if IsList( parent ) then
                        parent[Last( path )] := ref_return_value_lvar;
                    else
                        parent.(Last( path )) := ref_return_value_lvar;
                    fi;
                    
                    statements := Concatenation( statements{[ 1 .. i-1 ]}, inline_func_stats.statements, [ inlined_original_statement ], statements{[ i+1 .. Length( statements ) ]} );
                    
                    current_func.nloc := current_func.nloc + inline_func.nloc + 1;
                    
                    current_func.nams := Concatenation( current_func.nams, new_nams );

                    Assert( 0, Length( current_func.nams ) = current_func.narg + current_func.nloc );

                    Assert( 0, IsDuplicateFreeList( current_func.nams ) );
                    
                    CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER := CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER + 1;

                    Info( InfoCapJit, 1, "Successfully inlined." );
    
                else
                    
                    i := i + 1;
                    
                fi;
                
            od;
            
            tree.statements := statements;
            
        fi;

        return tree;
        
    end;

    additional_arguments_func := function( tree, key, current_func )
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNC" then
            
            return tree;
        
        else
            
            return current_func;
            
        fi;
        
    end;

    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, fail );
    
end );
