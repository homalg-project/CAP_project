# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitResolvedOperations, function ( tree )
  local pre_func;
    
    pre_func := function ( tree, additional_arguments )
      local operation, operation_name, info, category, resolved_tree, known_methods, known_method, similar_methods;
        
        if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" then
            
            operation := ValueGlobal( tree.funcref.gvar );
            
            operation_name := NameFunction( operation );
            
            # check if this is a CAP operation which is not a convenience method or if we know methods for this operation
            if (operation_name in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) and tree.args.length = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list )) or operation_name in RecNames( CAP_JIT_INTERNAL_KNOWN_METHODS ) then
                
                if CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED and operation_name in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) then
                    
                    info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
                    
                    if not IsBound( info.compatible_with_congruence_of_morphisms ) then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Print( "WARNING: please check if the CAP operation ", operation_name, " is compatible with the congruence of morphisms and add this information to the method name record.\n" );
                        
                    elif info.compatible_with_congruence_of_morphisms <> true then
                        
                        Print( "WARNING: the CAP operation ", operation_name, " is not compatible with the congruence of morphisms. Keep this in mind when writing logic templates.\n" );
                        
                    fi;
                    
                fi;
                
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
                        
                        known_method := known_methods[1];
                        
                        # look for GAP methods with the same number of arguments and first filter implying known_method.filters[1] or being implied by it
                        similar_methods := Filtered( MethodsOperation( operation, tree.args.length ), m ->
                            IS_SUBSET_FLAGS( WITH_IMPS_FLAGS( m.argFilt[1] ), WITH_IMPS_FLAGS( FLAGS_FILTER( known_method.filters[1] ) ) ) or
                            IS_SUBSET_FLAGS( WITH_IMPS_FLAGS( FLAGS_FILTER( known_method.filters[1] ) ), WITH_IMPS_FLAGS( m.argFilt[1] ) )
                        );
                        
                        # we should always find the method installed using Install(Other)MethodForCompilerForCAP
                        Assert( 0, not IsEmpty( similar_methods ) );
                        
                        if Length( similar_methods ) > 1 then
                            
                            # COVERAGE_IGNORE_BLOCK_START
                            Print(
                                "WARNING: A method for ", operation_name, " with ", Length( known_method.filters ), " arguments and first filter ", known_method.filters[1], " was installed using Install(Other)MethodForCompilerForCAP ",
                                "but additional methods with the same number of arguments and the same first filter (or a filter implying or being implied by it) have been installed (using Install(Other)Method). ",
                                "If such an additional method is used in the code, CompilerForCAP will resolve the wrong method.\n"
                            );
                            # COVERAGE_IGNORE_BLOCK_END
                            
                        fi;
                        
                        # precompile known methods and cache the result
                        
                        if not IsBound( category!.compiled_known_methods_trees ) then
                            
                            category!.compiled_known_methods_trees := rec( );
                            
                        fi;
                        
                        if not IsBound( category!.compiled_known_methods_trees.(operation_name) ) then
                            
                            category!.compiled_known_methods_trees.(operation_name) := [ ];
                            
                        fi;
                        
                        if not IsBound( category!.compiled_known_methods_trees.(operation_name)[tree.args.length] ) then
                            
                            category!.compiled_known_methods_trees.(operation_name)[tree.args.length] := CapJitCompiledFunctionAsEnhancedSyntaxTree( known_method.method, category );
                            
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
