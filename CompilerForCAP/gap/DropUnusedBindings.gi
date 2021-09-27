# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitDroppedUnusedBindings, function ( tree )
  local pre_func;
    
    pre_func := function ( tree, additional_arguments )
      local name_is_used, func_id, pre_func, name;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # find unused bindings
            # we can ignore args because those must never be bound explicitly
            
            # modified inplace
            name_is_used := rec( );
            
            for name in tree.nams{[ 1 .. tree.narg ]} do
                
                name_is_used.(name) := true;
                
            od;
            
            for name in tree.nams{[ tree.narg + 1 .. Length( tree.nams ) ]} do
                
                name_is_used.(name) := false;
                
            od;
            
            func_id := tree.id;
            
            pre_func := function ( tree, additional_arguments )
                
                if tree.type = "EXPR_REF_FVAR" and tree.func_id = func_id then
                    
                    Assert( 0, IsBound( name_is_used.(tree.name) ) );
                    
                    name_is_used.(tree.name) := true;
                    
                fi;
                
                return tree;
                
            end;
            
            CapJitIterateOverTree( tree, pre_func, ReturnTrue, ReturnTrue, true );
            
            # RETURN_VALUE must never be explicitly used but is always implictely used
            Assert( 0, name_is_used.RETURN_VALUE = false );
            name_is_used.RETURN_VALUE := true;
            
            Info( InfoCapJit, 1, "####" );
            Info( InfoCapJit, 1, "Dropping the following unused variables:" );
            Info( InfoCapJit, 1, Filtered( tree.nams, name -> not name_is_used.(name) ) );
            
            tree := ShallowCopy( tree );
            
            tree.bindings := ShallowCopy( tree.bindings );
            
            # tree.bindings.names is modified by CapJitUnbindBinding -> make a copy
            for name in ShallowCopy( tree.bindings.names ) do
                
                Assert( 0, name in tree.nams );
                
                if not name_is_used.(name) then
                    
                    CapJitUnbindBinding( tree.bindings, name );
                    
                fi;
                
            od;
            
            tree.nams := Filtered( tree.nams, name -> name_is_used.(name) );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
