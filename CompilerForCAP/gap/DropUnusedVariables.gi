# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitDroppedUnusedVariables, function ( tree, args... )
  local single_pass, func_path, condition_func, path, pre_func, func, name_is_used, name, unused_names, pos;
    
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
        condition_func := function ( tree, path )
            
            if tree.type = "EXPR_FUNC" and not (IsBound( tree.CAP_JIT_NO_UNUSED_VARIABLES ) and tree.CAP_JIT_NO_UNUSED_VARIABLES) then
                
                return true;

            fi;
            
            return false;
            
        end;
        
        func_path := CapJitFindNodeDeep( tree, condition_func );
        
        if func_path = fail then
            
            # reset CAP_JIT_NO_UNUSED_VARIABLES
            pre_func := function ( tree, additional_arguments )
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
    # we can ignore args:
    # * if this function is part of a function call, all arguments have been inlined anyway
    # * if this function is not part of a function call, we cannot optimize unused arguments

    # modified inplace
    name_is_used := rec( );
    
    for name in func.nams{[ 1 .. func.narg ]} do
        
        name_is_used.(name) := true;
        
    od;
    
    for name in func.nams{[ func.narg + 1 .. func.narg + func.nloc ]} do
        
        name_is_used.(name) := false;
        
    od;
    
    pre_func := function ( tree, additional_arguments )
      local level;
        
        if IsRecord( tree ) then
            
            level := fail;
            
            # STAT_ASS_FVAR does not count as using the variable and EXPR_ISB_FVAR and STAT_UNB_FVAR are forbidden
            if tree.type = "EXPR_REF_FVAR" and tree.func_id = func.id then
                
                Assert( 0, IsBound( name_is_used.(tree.name) ) );
                
                name_is_used.(tree.name) := true;
                
            fi;
            
        fi;
            
        return tree;
        
    end;
    
    CapJitIterateOverTree( func, pre_func, ReturnTrue, ReturnTrue, true );
    
    unused_names := Filtered( func.nams, name -> not name_is_used.(name) );
    
    if Length( unused_names ) = 0 then
    
        func.CAP_JIT_NO_UNUSED_VARIABLES := true;
    
    else
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Dropping the following unused variables:" );
        Info( InfoCapJit, 1, unused_names );
        
        func.nams := Filtered( func.nams, name -> name_is_used.(name) );
        func.nloc := func.nloc - Length( unused_names );
        
        Assert( 0, Length( func.nams ) = func.narg + func.nloc );
        
        # remove STAT_ASS_FVAR
        pre_func := function ( tree, additional_arguments )
            
            if IsRecord( tree ) and tree.type = "STAT_SEQ_STAT" then
                
                tree.statements := Filtered( tree.statements, function ( statement )
                    
                    if statement.type = "STAT_ASS_FVAR" and statement.func_id = func.id and not name_is_used.(statement.name) then
                        
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
