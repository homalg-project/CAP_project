# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

InstallGlobalFunction( StopCompilationAtCategory, function ( category )
    
    Assert( 0, IsCapCategory( category ) );
    
    category!.stop_compilation := true;
    
end );

InstallGlobalFunction( ContinueCompilationAtCategory, function ( category )
    
    Assert( 0, IsCapCategory( category ) );
    
    category!.stop_compilation := false;
    
end );

InstallGlobalFunction( StopCompilationAtPrimitivelyInstalledOperationsOfCategory, function ( category )
    
    Assert( 0, IsCapCategory( category ) );
    
    category!.stop_compilation_at_primitively_installed_operations := true;
    
end );

InstallGlobalFunction( ContinueCompilationAtPrimitivelyInstalledOperationsOfCategory, function ( category )
    
    Assert( 0, IsCapCategory( category ) );
    
    category!.stop_compilation_at_primitively_installed_operations := false;
    
end );

CAP_JIT_DATA_TYPE_INFERENCE_ENABLED := true;

InstallGlobalFunction( CapJitDisableDataTypeInference, function ( )
    
    CAP_JIT_DATA_TYPE_INFERENCE_ENABLED := false;
    
end );

InstallGlobalFunction( CapJitEnableDataTypeInference, function ( )
    
    CAP_JIT_DATA_TYPE_INFERENCE_ENABLED := true;
    
end );

CAP_JIT_RESOLVE_ONE_LEVEL_ONLY := false;

InstallGlobalFunction( CapJitEnableStepByStepCompilation, function ( )
    
    CAP_JIT_RESOLVE_ONE_LEVEL_ONLY := true;
    
end );

InstallGlobalFunction( CapJitDisableStepByStepCompilation, function ( )
    
    CAP_JIT_RESOLVE_ONE_LEVEL_ONLY := false;
    
end );

CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED := false;

InstallGlobalFunction( CapJitEnableProofAssistantMode, function ( )
    
    CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED := true;
    
end );

InstallGlobalFunction( CapJitDisableProofAssistantMode, function ( )
    
    CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED := false;
    
end );

InstallGlobalFunction( CapJitCompiledFunction, function ( func, args... )
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        Info( InfoCapJit, 1, "<func> is a operation or kernel function, this is not supported yet." );
        return func;
        
    fi;
    
    return ENHANCED_SYNTAX_TREE_CODE( CallFuncList( CapJitCompiledFunctionAsEnhancedSyntaxTree, Concatenation( [ func, "with_post_processing" ], args ) ) );
    
end );

CAP_JIT_INTERNAL_COMPILATION_IN_PROGRESS := false;

BindGlobal( "CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK", [ ] );

InstallGlobalFunction( CapJitCompiledFunctionAsEnhancedSyntaxTree, function ( func, with_or_without_post_processing, args... )
  local debug, debug_idempotence, category_as_first_argument, category, type_signature, filter_list, arguments_data_types, return_type, return_data_type, tree, resolving_phase_functions, orig_tree, compiled_func, tmp, rule_phase_functions, tree_without_post_processing, changed, pre_func, domains, additional_arguments_func, f;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Start compilation." );
    
    Add( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK, func );
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<func> is a operation or kernel function, this is not supported yet." );
        
    fi;
    
    debug := false;
    debug_idempotence := false;
    
    if debug then
        # COVERAGE_IGNORE_BLOCK_START
        Display( func );
        Error( "start compilation" );
        # COVERAGE_IGNORE_BLOCK_END
    fi;
    
    category_as_first_argument := false;
    category := fail;
    
    if Length( args ) = 0 then
        
        type_signature := fail;
        
    elif Length( args ) = 1 then
        
        if IsCapCategory( args[1] ) then
            
            type_signature := fail;
            
            category_as_first_argument := true;
            category := args[1];
            
        elif IsList( args[1] ) and Length( args[1] ) = 2 and IsList( args[1][1] ) and Length( args[1][1] ) = NumberArgumentsFunction( func ) then
            
            type_signature := args[1];
            
            if NumberArgumentsFunction( func ) > 0 and type_signature[1][1].filter = IsCapCategory then
                
                category_as_first_argument := true;
                category := type_signature[1][1].category;
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "the second argument of CapJitCompiledFunction(AsEnhancedSyntaxTree) must be a CAP category or a valid type signature" );
            
        fi;
        
    elif Length( args ) = 3 then
        
        if IsCapCategory( args[1] ) and IsList( args[2] ) and Length( args[2] ) = NumberArgumentsFunction( func ) then
            
            category_as_first_argument := true;
            category := args[1];
            
            filter_list := args[2];
            
            arguments_data_types := List( filter_list, filter_or_string -> CAP_JIT_INTERNAL_GET_DATA_TYPE_FROM_FILTER_OR_STRING( filter_or_string, category ) );
            
            return_type := args[3];
            
            return_data_type := CAP_JIT_INTERNAL_GET_DATA_TYPE_FROM_FILTER_OR_STRING( return_type, category );
            
            if fail in arguments_data_types then
                
                type_signature := fail;
                
            else
                
                type_signature := [ arguments_data_types, return_data_type ];
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "the second argument of CapJitCompiledFunction(AsEnhancedSyntaxTree) must be a CAP category, the third a list of input filters (as in `filter_list` in the method name record) for the given function, and the fourth an output filter (as in `return_type` in the method name record) for the given function" );
            
        fi;
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "CapJitCompiledFunction(AsEnhancedSyntaxTree) must be called with one, two, or four arguments" );
        
    fi;
    
    if category_as_first_argument then
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true, given_arguments := [ category ], type_signature := type_signature );
        
    else
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true, type_signature := type_signature );
        
    fi;
    
    if CAP_JIT_RESOLVE_ONE_LEVEL_ONLY then
        
        if CAP_JIT_INTERNAL_COMPILATION_IN_PROGRESS then
            
            if with_or_without_post_processing = "without_post_processing" or with_or_without_post_processing = "with_post_processing" then
                
                return tree;
                
            elif with_or_without_post_processing = "with_and_without_post_processing" then
                
                return Pair( tree, tree );
                
            else
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "with_or_without_post_processing must be one of \"without_post_processing\", \"with_post_processing\" or \"with_and_without_post_processing\" but is ", with_or_without_post_processing );
                
            fi;
            
        else
            
            CAP_JIT_INTERNAL_COMPILATION_IN_PROGRESS := true;
            
        fi;
        
    fi;
    
    # resolving phase
    resolving_phase_functions := [
        CapJitResolvedOperations,
        CapJitInlinedArguments,
        CapJitDroppedUnusedBindings,
        CapJitInlinedBindingsToVariableReferences,
        CapJitResolvedGlobalVariables,
    ];
    
    orig_tree := rec( );
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Start resolving." );
        
        if debug then
            # COVERAGE_IGNORE_BLOCK_START
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "start resolving" );
            # COVERAGE_IGNORE_BLOCK_END
        fi;
        
        for f in resolving_phase_functions do
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
                Display( compiled_func );
                # use Concatenation so one can easily replace "Error" by "Display"
                Error( Concatenation( "next step: apply ", NameFunction( f ) ) );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            tree := f( tree );
            
            if debug_idempotence then
                
                # COVERAGE_IGNORE_BLOCK_START
                tmp := StructuralCopy( tree );
                
                tree := f( tree );
                
                if tmp <> tree then
                    
                    Error( NameFunction( f ), " is not idempotent" );
                    
                fi;
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
        od;
        
        if CAP_JIT_RESOLVE_ONE_LEVEL_ONLY then
            
            break;
            
        fi;
        
    od;
    
    # rule phase
    rule_phase_functions := [
        CapJitInferredDataTypes,
        CapJitAppliedLogic,
        CapJitDroppedHandledEdgeCases,
        CapJitInlinedArguments,
        CapJitInlinedSimpleFunctionCalls,
        CapJitInlinedFunctionCalls,
        CapJitDroppedUnusedBindings,
        CapJitHoistedBindings,
        CapJitOutlinedWrappedArguments,
        CapJitInlinedBindings,
    ];
    
    if type_signature = fail or not CAP_JIT_DATA_TYPE_INFERENCE_ENABLED then
        
        Remove( rule_phase_functions, SafeUniquePosition( rule_phase_functions, CapJitInferredDataTypes ) );
        
    fi;
    
    orig_tree := rec( );
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Apply rules." );
        
        if debug then
            # COVERAGE_IGNORE_BLOCK_START
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply rules" );
            # COVERAGE_IGNORE_BLOCK_END
        fi;
        
        for f in rule_phase_functions do
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
                Display( compiled_func );
                # use Concatenation so one can easily replace "Error" by "Display"
                Error( Concatenation( "next step: apply ", NameFunction( f ) ) );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            tree := f( tree );
            
            # Hack: the tree might lose its type because we avoid partial typings.
            # However, in many cases it can be typed later in the compilation process (after inlining etc.).
            # Thus, we add the type back manually here.
            if type_signature <> fail and not IsBound( tree.data_type ) then
                
                tree.data_type := rec(
                    filter := IsFunction,
                    signature := type_signature,
                );
                
            fi;
            
            if debug_idempotence then
                
                # COVERAGE_IGNORE_BLOCK_START
                tmp := StructuralCopy( tree );
                
                tree := f( tree );
                
                if tmp <> tree then
                    
                    Error( NameFunction( f ), " is not idempotent" );
                    
                fi;
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
        od;
        
    od;
    
    # post-processing
    if with_or_without_post_processing = "with_post_processing" or with_or_without_post_processing = "with_and_without_post_processing" then
        
        tree_without_post_processing := StructuralCopy( tree );
        
        if debug then
            # COVERAGE_IGNORE_BLOCK_START
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitInlinedBindingsFully" );
            # COVERAGE_IGNORE_BLOCK_END
        fi;
        
        tree := CapJitInlinedBindingsFully( tree );
        
        if category_as_first_argument then
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
                Display( compiled_func );
                Error( "apply CapJitAppliedCompilerHints" );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            tree := CapJitAppliedCompilerHints( tree, category );
            
        fi;
        
        # do not hoist/deduplicate expressions in proof assistant mode
        if not CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED then
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
                Display( compiled_func );
                Error( "apply CapJitExtractedExpensiveOperationsFromLoops" );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            tree := CapJitExtractedExpensiveOperationsFromLoops( tree );
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
                Display( compiled_func );
                Error( "apply CapJitHoistedExpressions" );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            tree := CapJitHoistedExpressions( tree );
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
                Display( compiled_func );
                Error( "apply CapJitDeduplicatedExpressions" );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            tree := CapJitDeduplicatedExpressions( tree );
            
            # Generalized loop fusion: Simplify `List( list, func )[index]` to `func( list[index] )`
            # We do not want to do this during compilation because of the following situation:
            # expr1 := List( [ 1 .. var1 ], x -> very_expensive_operation( x ) ); expr2 := List( [ 1 .. var2 ], y -> List( [ 1 .. var1 ], x -> expr1[x][y] ) );
            # If we inline and transform this to
            # expr2 := List( [ 1 .. var2 ], y -> List( [ 1 .. var1 ], x -> very_expensive_operation( x )[y] ) );
            # we cannot simply hoist `very_expensive_operation( x )`.
            # One solution is "generalized hoisting" (see CapJitExtractedExpensiveOperationsFromLoops): We can detect that the subexpression
            # `very_expensive_operation( x )` and its domain `[ 1 .. var1 ]` are independent of `y` and thus extract `expr1` from `expr2` again.
            # However, this only improves the runtime if looping over `[ 1 .. var1 ]` is less expensive than the additional computations of `very_expensive_operation( x )`
            # in the inlined expression. This information has to be passed to CompilerForCAP explicitly via CAP_JIT_EXPENSIVE_FUNCTION_NAMES.
            # The general case is the following:
            # hoisted_expr := List( domain, func ); result := List( enclosing_domain_1, x -> List( enclosing_domain_2, y -> hoisted_expr[i] ) );
            # where of course there can be more or fewer enclosing domains. It makes sense to transform this into
            # result := List( enclosing_domain_1, x -> List( enclosing_domain_2, y -> func( domain[i] ) ) );
            # if and only if looping over `domain` is more expensive than looping over the cartesian product of the enclosing domains (assuming that `hoisted_expr` was
            # not deduplicated, i.e. is not used multiple times. If it is, the argument is not correct).
            # In particular, this depends on the level to which `hoisted_expr` can be hoisted. However, the function levels on which `hoisted_expr` depends can
            # change during the compilation due to cancellation. So we can only do this optimization here at the end.
            # This might lead to new instances of `List( list, func )[index]`, so we repeat the process until no occurrences of `List( list, func )[index]` remain
            # In principle, we should rerun the whole rule phase, but this could rewrite `func( list[index] )` to `List( list, func )[index]` again,
            # so we only run a subset of functions of the rule phase. As a consequence, one cannot apply logic to the result of this simplification.
            # For now, we only consider two special cases below: The cases of no or a single enclosing domain.
            # This simplifies checking if looping over `domain` is more expensive than looping over the cartesian product of the enclosing domains:
            # If there is no domain, this is true trivially. If there is a single enclosing domain, we only have to compare that to `domain`, see `is_shorter_than`.
            # The implementation of `is_shorter_than` only covers special cases.
            # In the case with a single enclosing domain we do not check if `hoisted_expr` was deduplicated, i.e. is used multiple times, yet.
            # However, in this case we might not want to apply the simplification.
            # Note: In the case of a single enclosing domain which is equal to the domain, this would more or less correspond to the traditional concept of loop fusion.
            # That is why we call it "generalized loop fusion".
            while true do
                
                changed := false;
                
                # fuse loops with the same domain
                domains := rec( );
                
                pre_func := function ( tree, func_stack )
                  local value_of_binding_iterated, is_shorter_than, list_call, domain, simplify, enclosing_domain;
                    
                    value_of_binding_iterated := function ( tree )
                      local func;
                        
                        if tree.type = "EXPR_REF_FVAR" then
                            
                            func := SafeUniqueEntry( func_stack, f -> f.id = tree.func_id );
                            
                            if SafeUniquePosition( func.nams, tree.name ) > func.narg then
                                
                                return value_of_binding_iterated( CapJitValueOfBinding( func.bindings, tree.name ) );
                                
                            fi;
                            
                        fi;
                        
                        return tree;
                        
                    end;
                    
                    is_shorter_than := function ( domain1, domain2 )
                      local last, minuend;
                        
                        domain1 := value_of_binding_iterated( domain1 );
                        domain2 := value_of_binding_iterated( domain2 );
                        
                        if CapJitIsEqualForEnhancedSyntaxTrees( domain1, domain2 ) then
                            
                            return true;
                            
                        fi;
                        
                        # `[ 0 .. Length( list ) - 1 ]` is as long as `list`
                        if domain1.type = "EXPR_RANGE" and domain1.first.type = "EXPR_INT" and domain1.first.value = 0 then
                            
                            last := value_of_binding_iterated( domain1.last );
                            
                            if CapJitIsCallToGlobalFunction( last, "-" ) and last.args.2.type = "EXPR_INT" and last.args.2.value = 1 then
                                
                                minuend := value_of_binding_iterated( last.args.1 );
                                
                                if CapJitIsCallToGlobalFunction( minuend, "Length" ) then
                                    
                                    return is_shorter_than( minuend.args.1, domain2 );
                                    
                                fi;
                                
                            fi;
                            
                        fi;
                        
                        # `Filtered( list, func )` is shorter than `list`
                        if CapJitIsCallToGlobalFunction( domain1, "Filtered" ) and CapJitIsEqualForEnhancedSyntaxTrees( value_of_binding_iterated( domain1.args.1 ), domain2 ) then
                            
                            return true;
                            
                        fi;
                        
                        return fail;
                        
                    end;
                    
                    if CapJitIsCallToGlobalFunction( tree, "[]" ) then
                        
                        list_call := value_of_binding_iterated( tree.args.1 );
                        
                        if CapJitIsCallToGlobalFunction( list_call, "List" ) and list_call.args.length = 2 then
                            
                            domain := list_call.args.1;
                            
                            simplify := false;
                            
                            # case: no enclosing domain, i.e. not hoisted, and not deduplicated
                            if tree.args.1.type <> "EXPR_REF_FVAR" then
                                
                                Assert( 0, IsIdenticalObj( list_call, tree.args.1 ) );
                                
                                simplify := true;
                                
                            # case: a single enclosing domain
                            elif tree.args.1.type = "EXPR_REF_FVAR" and Length( func_stack ) >= 2 and tree.args.1.func_id = func_stack[Length( func_stack ) - 1].id and IsBound( domains.(Last( func_stack ).id) ) then
                                
                                enclosing_domain := domains.(Last( func_stack ).id);
                                
                                # In the future, we should also take into account if the list_call was deduplicated, i.e. appears multiple times.
                                # In this case, we might not want simplify.
                                if is_shorter_than( enclosing_domain, domain ) = true then
                                    
                                    simplify := true;
                                    
                                fi;
                                
                            fi;
                            
                            if simplify then
                                
                                changed := true;
                                
                                # List( domain, func )[index] => func( CAP_JIT_INCOMPLETE_LOGIC( domain[index] ) )
                                return rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := CapJitCopyWithNewFunctionIDs( list_call.args.2 ), # func
                                    args := AsSyntaxTreeList( [
                                        rec(
                                            type := "EXPR_FUNCCALL",
                                            funcref := rec(
                                                type := "EXPR_REF_GVAR",
                                                gvar := "CAP_JIT_INCOMPLETE_LOGIC", # CAP_JIT_INCOMPLETE_LOGIC
                                            ),
                                            args := AsSyntaxTreeList( [
                                                rec(
                                                    type := "EXPR_FUNCCALL",
                                                    funcref := rec(
                                                        type := "EXPR_REF_GVAR",
                                                        gvar := "[]",
                                                    ),
                                                    args := AsSyntaxTreeList( [
                                                        CapJitCopyWithNewFunctionIDs( domain ), # domain
                                                        tree.args.2, # index
                                                    ] ),
                                                ),
                                            ] ),
                                        ),
                                    ] ),
                                );
                                
                            fi;
                            
                        fi;
                        
                    fi;
                    
                    return tree;
                    
                end;
                
                additional_arguments_func := function ( tree, key, func_stack )
                    
                    if CapJitIsCallToGlobalFunction( tree, gvar -> gvar in CAP_JIT_INTERNAL_NAMES_OF_LOOP_FUNCTIONS ) and tree.args.length = 2 and tree.args.2.type = "EXPR_DECLARATIVE_FUNC" then
                        
                        domains.(tree.args.2.id) := tree.args.1;
                        
                    fi;
                    
                    if tree.type = "EXPR_DECLARATIVE_FUNC" then
                        
                        func_stack := Concatenation( func_stack, [ tree ] );
                        
                    fi;
                    
                    return func_stack;
                    
                end;
                
                tree := CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ ] );
                
                if not changed then
                    
                    break;
                    
                fi;
                
                tree := CapJitInlinedArguments( tree );
                tree := CapJitInlinedSimpleFunctionCalls( tree );
                tree := CapJitInlinedFunctionCalls( tree );
                tree := CapJitInlinedBindingsFully( tree );
                # simplifying `List( list, x -> false )[1]` might lead to edge cases which can be dropped
                tree := CapJitDroppedHandledEdgeCases( tree );
                # CapJitExtractedExpensiveOperationsFromLoops cannot handle ListWithKeys yet, so it cannot be executed more than once.
                #tree := CapJitExtractedExpensiveOperationsFromLoops( tree );
                # CapJitInlinedBindingsFully drops unused bindings and the output of CapJitDroppedHandledEdgeCases is still fully inlined -> no new bindings
                tree := CapJitHoistedExpressions( tree );
                tree := CapJitDeduplicatedExpressions( tree );
                
            od;
            
        fi;
        
    fi;
    
    if debug then
        
        # COVERAGE_IGNORE_BLOCK_START
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
        
        Display( compiled_func );
        
        Error( "compilation finished" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    Remove( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Compilation finished." );
    
    if CAP_JIT_RESOLVE_ONE_LEVEL_ONLY then
        
        CAP_JIT_INTERNAL_COMPILATION_IN_PROGRESS := false;
        
    fi;
    
    if with_or_without_post_processing = "without_post_processing" or with_or_without_post_processing = "with_post_processing" then
        
        return tree;
        
    elif with_or_without_post_processing = "with_and_without_post_processing" then
        
        return Pair( tree_without_post_processing, tree );
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "with_or_without_post_processing must be one of \"without_post_processing\", \"with_post_processing\" or \"with_and_without_post_processing\" but is ", with_or_without_post_processing );
        
    fi;
    
end );
