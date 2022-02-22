# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitDroppedUnusedBindings, function ( tree )
  local result_func;
    
    # we have to use result_func instead of pre_func to drop bindings which are used by unused bindings further down the function stack
    result_func := function ( tree, result, keys, additional_arguments )
      local used_by_bindings, func, pre_func, unused_names, binding_name, key;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # first drop unused names
            tree.nams := Filtered( tree.nams, name -> Position( tree.nams, name ) <= tree.narg or name in tree.bindings.names );
            
            # find unused bindings
            
            # modified inplace
            used_by_bindings := rec( );
            
            for binding_name in tree.bindings.names do
                
                used_by_bindings.(binding_name) := [ ];
                
            od;
            
            func := tree;
            
            for binding_name in tree.bindings.names do
                
                pre_func := function ( tree, additional_arguments )
                    
                    # we can ignore arguments because those are never bound
                    if tree.type = "EXPR_REF_FVAR" and tree.func_id = func.id and tree.name in func.bindings.names then
                        
                        Assert( 0, IsBound( used_by_bindings.(tree.name) ) );
                        
                        Add( used_by_bindings.(tree.name), binding_name );
                        
                    fi;
                    
                    return tree;
                    
                end;
                
                CapJitIterateOverTree( CapJitValueOfBinding( tree.bindings, binding_name ), pre_func, ReturnTrue, ReturnTrue, true );
                
            od;
            
            # RETURN_VALUE must never be explicitly used but is always implictely used
            Assert( 0, IsEmpty( used_by_bindings.RETURN_VALUE ) );
            used_by_bindings.RETURN_VALUE := [ "RETURN_VALUE" ];
            
            # drop unused bindings
            
            while true do
                
                unused_names := Filtered( tree.bindings.names, name -> IsEmpty( used_by_bindings.(name) ) );
                
                if IsEmpty( unused_names ) then
                    
                    break;
                    
                else
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, "Dropping the following unused variables:" );
                    Info( InfoCapJit, 1, unused_names );
                    
                    tree := ShallowCopy( tree );
                    
                    tree.bindings := ShallowCopy( tree.bindings );
                    
                    for binding_name in unused_names do
                        
                        CapJitUnbindBinding( tree.bindings, binding_name );
                        
                    od;
                    
                    tree.nams := Filtered( tree.nams, name -> not name in unused_names );
                    
                    for binding_name in tree.bindings.names do
                        
                        used_by_bindings.(binding_name) := Difference( used_by_bindings.(binding_name), unused_names );
                        
                    od;
                    
                fi;
                
            od;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, ReturnTrue, true );
    
end );
