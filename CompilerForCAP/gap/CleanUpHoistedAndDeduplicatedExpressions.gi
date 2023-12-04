# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
InstallGlobalFunction( CapJitCleanedUpHoistedAndDeduplicatedExpressions, function ( tree )
  local variable_references, pre_func, result_func, additional_arguments_func;
    
    # variable references will be modified inline
    tree := StructuralCopy( tree );
    
    variable_references := rec( );
    
    pre_func := function ( tree, func_stack )
        
        if tree.type = "EXPR_REF_FVAR" then
            
            if not IsBound( variable_references.(tree.func_id) ) then
                
                variable_references.(tree.func_id) := rec( );
                
            fi;
            
            if not IsBound( variable_references.(tree.func_id).(tree.name) ) then
                
                variable_references.(tree.func_id).(tree.name) := [ ];
                
            fi;
            
            Add( variable_references.(tree.func_id).(tree.name), tree );
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, func_stack )
      local func, name, value, pos, new_name, new_key, key, ref;
        
        if tree.type = "FVAR_BINDING_SEQ" then
            
            func := Last( func_stack );
            
            if IsBound( variable_references.(func.id) ) then
                
                for key in keys do
                    
                    if key = "BINDING_RETURN_VALUE" then
                        
                        continue;
                        
                    fi;
                    
                    # 9 = Length( "BINDING_" ) + 1
                    name := key{[ 9 .. Length( key ) ]};
                    
                    Assert( 0, IsBound( variable_references.(func.id).(name) ) );
                    
                    if StartsWith( name, "hoisted_" ) then
                        
                        value := CapJitValueOfBinding( func.bindings, name );
                        
                        if value.type = "EXPR_REF_FVAR" then
                            
                            # the binding is simply a reference to another binding -> remove and replace by the other binding
                            
                            Assert( 0, StartsWith( value.name, "deduped_" ) );
                            
                            for ref in variable_references.(func.id).(name) do
                                
                                ref.name := value.name;
                                
                            od;
                            
                            pos := SafeUniquePosition( func.nams, name );
                            Remove( func.nams, pos );
                            
                            CapJitUnbindBinding( func.bindings, name );
                            
                        elif Length( variable_references.(func.id).(name) ) > 1 then
                            
                            # The hoisted value is used more than once -> rename "hoisted_..." to "deduped_...".
                            # Note: Even if a hoisted value is used more than once during CapJitHoistedExpressions,
                            # it is not necessarily used more than once after CapJitDeduplicatedExpressions because
                            # the places where it was used might have been deduplicated themselves.
                            
                            # 9 = Length( "hoisted_" ) + 1
                            new_name := Concatenation( "deduped_", name{[ 9 .. Length( name ) ]} );
                            
                            for ref in variable_references.(func.id).(name) do
                                
                                ref.name := new_name;
                                
                            od;
                            
                            pos := SafeUniquePosition( func.nams, name );
                            func.nams[pos] := new_name;
                            
                            # replace inplace instead of removing the old binding and adding a new one to keep the order intact
                            pos := SafeUniquePosition( func.bindings.names, name );
                            func.bindings.names[pos] := new_name;
                            
                            new_key := Concatenation( "BINDING_", new_name );
                            
                            Assert( 0, not IsBound( func.bindings.(new_key) ) );
                            
                            func.bindings.(new_key) := func.bindings.(key);
                            Unbind( func.bindings.(key) );
                            
                        fi;
                        
                    elif StartsWith( name, "deduped_" ) then
                        
                        value := CapJitValueOfBinding( func.bindings, name );
                        
                        Assert( 0, value.type <> "EXPR_REF_FVAR" );
                        Assert( 0, Length( variable_references.(func.id).(name) ) > 1 );
                        
                        # WARNING: If we would actually do something here, we would have to move the variable references when replacing `hoisted_...` by `deduped_...` above!
                        
                    fi;
                    
                od;
                
            fi;
            
        fi;
        
        return true;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    CapJitIterateOverTreeWithCachedBindingResults( tree, pre_func, result_func, additional_arguments_func, [ ] );
    
    return tree;
    
end );
