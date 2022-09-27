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
  local debug, debug_idempotence, category_as_first_argument, category, type_signature, filter_list, arguments_data_types, return_type, return_data_type, tree, resolving_phase_functions, orig_tree, compiled_func, tmp, rule_phase_functions, tree_without_post_processing, changed, pre_func, f;
    
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
        
        Remove( rule_phase_functions, Position( rule_phase_functions, CapJitInferredDataTypes ) );
        
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
            
            # Simplify `List( list, func )[index]` to `func( list[index] )`.
            # We do not want to do this during compilation because of the following situation:
            # expr1 := List( [ 1 .. var1 ], x -> very_expensive_operation( x ) ); expr2 := List( [ 1 .. var2 ], y -> List( [ 1 .. var1 ], x -> expr1[x][y] ) );
            # If we inline and transform this to
            # expr2 := List( [ 1 .. var2 ], y -> List( [ 1 .. var1 ], x -> very_expensive_operation( x )[y] ) );
            # we cannot simply hoist `very_expensive_operation( x )`. One solution would be "generalized hoisting": We can detect that the subexpression
            # `very_expensive_operation( x )` and its domain `[ 1 .. var1 ]` are independent of `y` and thus extract `expr1` from `expr2` again.
            # However, this only improves the runtime if looping over `[ 1 .. var1 ]` is less expensive than the additional computations of `very_expensive_operation( x )`
            # in the inlined expression. CompilerForCAP cannot decide this.
            # Another solution would be to only transform `List( list, func )[index]` if `List( list, func )` depends on the same function levels as `index` and can thus not
            # be hoisted anyway. However, the function levels on which `List( list, func )` depends can change during the compilation due to cancellation.
            # Thus, we use the brute-force algorithm here: If we encounter `List( list, func )[index]` during post-processing and after inlining and hoisting,
            # simplifying it to `func( list[index] )` always makes sense. This simplification might lead to new instances of `List( list, func )[index]`,
            # so we repeat the process until no occurrences of `List( list, func )[index]` remain. In principle, we should rerun the whole rule phase, but this would
            # rewrite `func( list[index] )` to `List( list, func )[index]` again, so we only run a subset of functions of the rule phase.
            # As a consequence, one cannot apply logic to the result of this simplification.
            while true do
                
                changed := false;
                
                pre_func := function ( tree, additional_arguments )
                    
                    if CapJitIsCallToGlobalFunction( tree, "[]" ) and CapJitIsCallToGlobalFunction( tree.args.1, "List" ) and tree.args.1.args.length = 2 then
                        
                        changed := true;
                        
                        # func( CAP_JIT_INCOMPLETE_LOGIC( list[index] ) )
                        return rec(
                            type := "EXPR_FUNCCALL",
                            funcref := tree.args.1.args.2, # func
                            args := AsSyntaxTreeList( [
                                rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := rec(
                                        type := "EXPR_REF_GVAR",
                                        gvar := "CAP_JIT_INCOMPLETE_LOGIC",
                                    ),
                                    args := AsSyntaxTreeList( [
                                        rec(
                                            type := "EXPR_FUNCCALL",
                                            funcref := rec(
                                                type := "EXPR_REF_GVAR",
                                                gvar := "[]",
                                            ),
                                            args := AsSyntaxTreeList( [
                                                tree.args.1.args.1, # list
                                                tree.args.2, # index
                                            ] ),
                                        ),
                                    ] ),
                                ),
                            ] ),
                        );
                        
                    fi;
                    
                    return tree;
                    
                end;
                
                tree := CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
                
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
