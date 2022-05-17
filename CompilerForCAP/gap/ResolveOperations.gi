# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitResolvedOperations, function ( tree )
  local pre_func;
    
    pre_func := function ( tree, additional_arguments )
      local operation, operation_name, category, resolved_tree, known_methods;
        
        if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" then
            
            operation := ValueGlobal( tree.funcref.gvar );
            
            operation_name := NameFunction( operation );
            
            # check if this is a CAP operation which is not a convenience method or if we know methods for this operation
            if (operation_name in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) and tree.args.length = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list )) or operation_name in RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) then
                
                # we can resolve operations if and only if the category is known, i.e., stored in a global variable
                if tree.args.1.type = "EXPR_REF_GVAR" then
                    
                    category := ValueGlobal( tree.args.1.gvar );
                    
                    Assert( 0, IsCapCategory( category ) );
                    
                    if IsBound( category!.stop_compilation ) and category!.stop_compilation = true then
                        
                        return tree;
                        
                    fi;
                    
                    if IsBound( category!.stop_compilation_at_primitively_installed_operations ) and category!.stop_compilation_at_primitively_installed_operations = true and operation_name in ListPrimitivelyInstalledOperationsOfCategory( category ) then
                        
                        return tree;
                        
                    fi;
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, Concatenation( "Resolve ", operation_name, "." ) );
                    
                    # check if this is a CAP operation which is not a convenience method
                    if operation_name in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) and tree.args.length = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list ) then
                        
                        Assert( 0, CanCompute( category, operation_name ) );
                        
                        Info( InfoCapJit, 1, "This is a CAP operation, recurse compilation." );
                        
                        resolved_tree := CapJitCompiledCAPOperationAsEnhancedSyntaxTree( category, operation_name );
                        
                    # check if we know methods for this operation
                    elif operation_name in RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) then
                        
                        Info( InfoCapJit, 1, "Methods are known for this operation." );
                        
                        known_methods := Filtered( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name),
                            m -> Length( m.filters ) = tree.args.length and m.filters[1]( category )
                        );
                        
                        if IsEmpty( known_methods ) then
                            
                            return tree;
                            
                        fi;
                        
                        if Length( known_methods ) > 1 then
                            
                            # COVERAGE_IGNORE_NEXT_LINE
                            Error( "Found more than one known method for ", operation_name, " with correct length and category filter" );
                            
                        fi;
                        
                        # precompile known methods and cache the result
                        
                        if not IsBound( category!.compiled_known_methods_trees ) then
                            
                            category!.compiled_known_methods_trees := rec( );
                            
                        fi;
                        
                        if not IsBound( category!.compiled_known_methods_trees.(operation_name) ) then
                            
                            category!.compiled_known_methods_trees.(operation_name) := [ ];
                            
                        fi;
                        
                        if not IsBound( category!.compiled_known_methods_trees.(operation_name)[tree.args.length] ) then
                            
                            category!.compiled_known_methods_trees.(operation_name)[tree.args.length] := CapJitCompiledFunctionAsEnhancedSyntaxTree( known_methods[1].method, category );
                            
                        fi;
                        
                        resolved_tree := CapJitCopyWithNewFunctionIDs( category!.compiled_known_methods_trees.(operation_name)[tree.args.length] );
                        
                    else
                        
                        Error( "this should never happen" );
                        
                    fi;
                    
                    if IsBound( tree.funcref.does_not_return_fail ) and tree.funcref.does_not_return_fail = true then
                        
                        resolved_tree := CapJitRemovedReturnFail( resolved_tree );
                        
                    fi;
                    
                    tree := ShallowCopy( tree );
                    tree.funcref := resolved_tree;
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
