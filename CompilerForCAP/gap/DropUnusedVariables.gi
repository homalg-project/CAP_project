#
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitDroppedUnusedVariables, function( tree, args... )
  local single_pass, func_path, condition_func, path, pre_func, func, used_nams, used_positions, unused_positions, pos;
    
    if not Length( args ) in [ 0, 1 ] then
        
        Error( "CapJitDroppedUnusedVariables cannot be called with more than two arguments" );
        
    fi;

    if Length( args ) = 1 then
        
        Assert( 0, IsList( args[1] ) );
        
        func_path := args[1];
        
        single_pass := true;
        
    else
        
        func_path := fail;
        
        single_pass := false;
        
    fi;
    
    tree := StructuralCopy( tree );
    
    if func_path = fail then
        
        # find EXPR_FUNC
        condition_func := function( tree, path )
            
            if tree.type = "EXPR_FUNC" and not (IsBound( tree.CAP_JIT_NO_UNUSED_VARIABLES ) and tree.CAP_JIT_NO_UNUSED_VARIABLES) then
                
                return true;

            fi;
            
            return false;
            
        end;
        
        func_path := CapJitFindNodeDeep( tree, condition_func );
        
        if func_path = fail then
            
            # reset CAP_JIT_NO_UNUSED_VARIABLES
            pre_func := function( tree, additional_arguments )
              local level, pos;
                
                if IsRecord( tree ) and IsBound( tree.CAP_JIT_NO_UNUSED_VARIABLES ) then
                    
                    Unbind( tree.CAP_JIT_NO_UNUSED_VARIABLES );
                    
                fi;
                    
                return tree;
                
            end;
            
            CapJitIterateOverTree( tree, pre_func, ReturnTrue, ReturnTrue, true );
            
            return tree;
            
        fi;

    fi;

    func := CapJitGetNodeByPath( tree, func_path );

    if Last( func_path ) = "funcref" and func.narg <> 0 then
        
        Error( "please inline arguments first" );
        
    fi;

    # find unused variables
    # we can ignore args: if this function is part of a function call, all arguments have been inlined anyway
    #                     if this function is not part of a function call, we cannot optimize unused arguments

    # modified inplace
    used_nams := Concatenation( ListWithIdenticalEntries( func.narg, true ), ListWithIdenticalEntries( func.nloc, false ) );
    
    pre_func := function( tree, additional_arguments )
      local level;
        
        if IsRecord( tree ) then
            
            level := fail;
            
            # STAT_ASS_FVAR does not count as using the variable and EXPR_ISB_FVAR and STAT_UNB_FVAR are forbidden
            if tree.type = "EXPR_REF_FVAR" and tree.func_id = func.id then
                
                used_nams[tree.pos] := true;
                    
            fi;
            
        fi;
            
        return tree;
        
    end;
    
    CapJitIterateOverTree( func, pre_func, ReturnTrue, ReturnTrue, true );
    
    used_positions := PositionsProperty( used_nams, x -> x = true );
    unused_positions := PositionsProperty( used_nams, x -> x = false );
    
    if ForAny( func.nams{used_positions}, n -> StartsWith( n, "_UNUSED_" ) ) then
        
        Error( "a variable marked as _UNUSED_ is used" );
        
    fi;

    # do not consider variables already marked as _UNUSED_
    unused_positions := Filtered( unused_positions, i -> not StartsWith( func.nams[i], "_UNUSED_" ) );
    
    if Length( unused_positions ) = 0 then
    
        func.CAP_JIT_NO_UNUSED_VARIABLES := true;
    
    else
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Dropping the following unused variables:" );
        Info( InfoCapJit, 1, func.nams{unused_positions} );
        
        for pos in unused_positions do
            
            func.nams[pos] := Concatenation( "_UNUSED_", func.nams[pos] );
            
        od;
        
        # remove STAT_ASS_FVAR
        pre_func := function( tree, additional_arguments )
            
            if IsRecord( tree ) and tree.type = "STAT_SEQ_STAT" then
                
                tree.statements := Filtered( tree.statements, function( statement )
                    
                    if statement.type = "STAT_ASS_FVAR" and statement.func_id = func.id and statement.pos in unused_positions then
                        
                        return false;
                        
                    fi;

                    return true;
                
                end );
                
            fi;
                
            return tree;
            
        end;
        
        CapJitIterateOverTree( func, pre_func, ReturnTrue, ReturnTrue, true );
        
    fi;
    
    if single_pass then
        
        Unbind( func.CAP_JIT_NO_UNUSED_VARIABLES );
        
        return tree;
        
    fi;
    
    return CapJitDroppedUnusedVariables( tree );
    
end );
