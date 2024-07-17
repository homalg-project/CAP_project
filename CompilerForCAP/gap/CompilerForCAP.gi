# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
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

InstallGlobalFunction( CapJitSetDebugLevel, function ( level )
    
    # COVERAGE_IGNORE_BLOCK_START
    Assert( 0, IsInt( level ) );
    
    CAP_JIT_INTERNAL_DEBUG_LEVEL := level;
    # COVERAGE_IGNORE_BLOCK_END
    
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
  local category, type_signature, filter_list, arguments_data_types, return_data_type, tree;
    
    Add( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK, func );
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<func> is a operation or kernel function, this is not supported yet." );
        
    fi;
    
    category := fail;
    
    if Length( args ) = 0 then
        
        type_signature := fail;
        
    elif Length( args ) = 1 then
        
        if IsCapCategory( args[1] ) then
            
            type_signature := fail;
            
            category := args[1];
            
        elif IsList( args[1] ) and Length( args[1] ) = 2 and IsList( args[1][1] ) and Length( args[1][1] ) = NumberArgumentsFunction( func ) then
            
            type_signature := args[1];
            
            if NumberArgumentsFunction( func ) > 0 and IsSpecializationOfFilter( IsCapCategory, type_signature[1][1].filter ) then
                
                category := type_signature[1][1].category;
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "the second argument of CapJitCompiledFunction(AsEnhancedSyntaxTree) must be a CAP category or a valid type signature" );
            
        fi;
        
    elif Length( args ) = 3 then
        
        if IsCapCategory( args[1] ) and IsList( args[2] ) and Length( args[2] ) = NumberArgumentsFunction( func ) then
            
            category := args[1];
            
            filter_list := args[2];
            
            if filter_list[1] <> "category" then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "the first input filter must be \"category\"" );
                
            fi;
            
            arguments_data_types := CAP_INTERNAL_GET_DATA_TYPES_FROM_STRINGS( filter_list, category );
            
            return_data_type := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( args[3], category );
            
            if fail in arguments_data_types then
                
                type_signature := fail;
                
            else
                
                type_signature := Pair( arguments_data_types, return_data_type );
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "the second argument of CapJitCompiledFunction(AsEnhancedSyntaxTree) must be a CAP category, the third a list of input filters (as in `filter_list` in the method name record) for the given function, and the fourth an output filter (as in `return_type` in the method name record) for the given function" );
            
        fi;
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "CapJitCompiledFunction(AsEnhancedSyntaxTree) must be called with one, two, or four arguments" );
        
    fi;
    
    if category <> fail then
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true, given_arguments := [ category ] );
        
    else
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true );
        
    fi;
    
    if type_signature <> fail then
        
        Assert( 0, IsList( type_signature ) and Length( type_signature ) = 2 and IsList( type_signature[1] ) and Length( type_signature[1] ) = tree.narg and (type_signature[2] = fail or IsRecord( type_signature[2] )) );
        
        tree.data_type := rec(
            filter := IsFunction,
            signature := type_signature
        );
        
    fi;
    
    tree := CAP_JIT_INTERNAL_COMPILED_ENHANCED_SYNTAX_TREE( tree, with_or_without_post_processing, category );
    
    Remove( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
    return tree;
    
end );
    
InstallGlobalFunction( CAP_JIT_INTERNAL_COMPILED_ENHANCED_SYNTAX_TREE, function ( tree, with_or_without_post_processing, category )
  local debug_idempotence, func, resolving_phase_functions, orig_tree, tmp, rule_phase_functions, tree_without_post_processing, changed, pre_func, domains, additional_arguments_func, f;
    
    debug_idempotence := false;
    
    Assert( 0, tree.type = "EXPR_DECLARATIVE_FUNC" );
    
    Assert( 0, not IsEmpty( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK ) );
    
    func := Last( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
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
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Start compilation." );
    
    if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 1 then
        
        # COVERAGE_IGNORE_BLOCK_START
        Print( "######## Start compilation of\n" );
        Print( "# ", NameFunction( func ), "\n" );
        Display( CapJitPrettyPrintFunction( func ) );
        Print( "\n" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    # resolving phase
    resolving_phase_functions := [
        CapJitInferredDataTypes,
        CapJitResolvedOperations,
        CapJitInlinedArguments,
        CapJitDroppedUnusedBindings,
        CapJitInlinedBindingsToVariableReferences,
        CapJitResolvedGlobalVariables,
        CapJitInferredDataTypes,
    ];
    
    if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 1 then
        
        # COVERAGE_IGNORE_BLOCK_START
        Print( "#### Continue compilation of\n" );
        Print( "# ", NameFunction( func ), "\n" );
        Print( "# current state:\n" );
        Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
        Print( "## start of resolving phase\n" );
        Print( "\n" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    orig_tree := rec( );
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        for f in resolving_phase_functions do
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "#### Continue compilation of\n" );
                Print( "# ", NameFunction( func ), "\n" );
                Print( "# apply ", NameFunction( f ), "\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            tree := f( tree );
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "# result:\n" );
                Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
                Print( "\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
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
    
    if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 1 then
        
        # COVERAGE_IGNORE_BLOCK_START
        Print( "#### Continue compilation of\n" );
        Print( "# ", NameFunction( func ), "\n" );
        Print( "# finished resolving phase, current state:\n" );
        Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
        Print( "## start of rule phase\n" );
        Print( "\n" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    orig_tree := rec( );
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        for f in rule_phase_functions do
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "#### Continue compilation of\n" );
                Print( "# ", NameFunction( func ), "\n" );
                Print( "# apply ", NameFunction( f ), "\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            #Display(ENHANCED_SYNTAX_TREE_CODE( tree ) );
            
            tree := f( tree );
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "# result:\n" );
                Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
                Print( "\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
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
        
        if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 1 then
            
            # COVERAGE_IGNORE_BLOCK_START
            Print( "#### Continue compilation of\n" );
            Print( "# ", NameFunction( func ), "\n" );
            Print( "# finished rule phase, current state:\n" );
            Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
            Print( "## start of post-processing\n" );
            Print( "\n" );
            # COVERAGE_IGNORE_BLOCK_END
            
        fi;
        
        tree_without_post_processing := StructuralCopy( tree );
        
        if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
            
            # COVERAGE_IGNORE_BLOCK_START
            Print( "#### Continue compilation of\n" );
            Print( "# ", NameFunction( func ), "\n" );
            Print( "# apply CapJitInlinedBindingsFully\n" );
            # COVERAGE_IGNORE_BLOCK_END
            
        fi;
        
        tree := CapJitInlinedBindingsFully( tree );
        
        if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
            
            # COVERAGE_IGNORE_BLOCK_START
            Print( "# result:\n" );
            Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
            Print( "\n" );
            # COVERAGE_IGNORE_BLOCK_END
            
        fi;
        
        if category <> fail then
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "#### Continue compilation of\n" );
                Print( "# ", NameFunction( func ), "\n" );
                Print( "# apply CapJitAppliedCompilerHints\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            tree := CapJitAppliedCompilerHints( tree, category );
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "# result:\n" );
                Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
                Print( "\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
        fi;
        
        # do not hoist/deduplicate expressions in proof assistant mode
        if not CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED then
            
            # CapJitExtractedExpensiveOperationsFromLoops
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "#### Continue compilation of\n" );
                Print( "# ", NameFunction( func ), "\n" );
                Print( "# apply CapJitExtractedExpensiveOperationsFromLoops\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            tree := CapJitExtractedExpensiveOperationsFromLoops( tree );
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "# result:\n" );
                Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
                Print( "\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            # CapJitHoistedExpressions
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "#### Continue compilation of\n" );
                Print( "# ", NameFunction( func ), "\n" );
                Print( "# apply CapJitHoistedExpressions\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            tree := CapJitHoistedExpressions( tree );
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "# result:\n" );
                Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
                Print( "\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            # CapJitDeduplicatedExpressions
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "#### Continue compilation of\n" );
                Print( "# ", NameFunction( func ), "\n" );
                Print( "# apply CapJitDeduplicatedExpressions\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            tree := CapJitDeduplicatedExpressions( tree );
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "# result:\n" );
                Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
                Print( "\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            # CapJitCleanedUpHoistedAndDeduplicatedExpressions
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "#### Continue compilation of\n" );
                Print( "# ", NameFunction( func ), "\n" );
                Print( "# apply CapJitCleanedUpHoistedAndDeduplicatedExpressions\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
            tree := CapJitCleanedUpHoistedAndDeduplicatedExpressions( tree );
            
            if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                
                # COVERAGE_IGNORE_BLOCK_START
                Print( "# result:\n" );
                Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
                Print( "\n" );
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
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
                  local value_of_binding_iterated, value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated, is_shorter_than, list_call, domain, simplify, enclosing_domain, index, resolved_domain, resolved_index, element, element_type;
                    
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
                    
                    value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated := function ( tree )
                      local func;
                        
                        if CapJitIsCallToGlobalFunction( tree, "CAP_JIT_INCOMPLETE_LOGIC" ) then
                            
                            return value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( tree.args.1 );
                            
                        fi;
                        
                        if tree.type = "EXPR_REF_FVAR" then
                            
                            func := SafeUniqueEntry( func_stack, f -> f.id = tree.func_id );
                            
                            if SafeUniquePosition( func.nams, tree.name ) > func.narg then
                                
                                return value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( CapJitValueOfBinding( func.bindings, tree.name ) );
                                
                            fi;
                            
                        fi;
                        
                        return tree;
                        
                    end;
                    
                    is_shorter_than := function ( domain1, domain2 )
                      local last, minuend;
                        
                        domain1 := value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( domain1 );
                        domain2 := value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( domain2 );
                        
                        if CapJitIsEqualForEnhancedSyntaxTrees( domain1, domain2 ) then
                            
                            return true;
                            
                        fi;
                        
                        # `[ 0 .. Length( list ) - 1 ]` is as long as `list`
                        if domain1.type = "EXPR_RANGE" and domain1.first.type = "EXPR_INT" and domain1.first.value = 0 then
                            
                            last := value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( domain1.last );
                            
                            if CapJitIsCallToGlobalFunction( last, "-" ) and last.args.2.type = "EXPR_INT" and last.args.2.value = 1 then
                                
                                minuend := value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( last.args.1 );
                                
                                if CapJitIsCallToGlobalFunction( minuend, "Length" ) then
                                    
                                    return is_shorter_than( minuend.args.1, domain2 );
                                    
                                fi;
                                
                            fi;
                            
                        fi;
                        
                        # `[ 1 .. Length( list ) ]` is as long as `list`
                        if domain1.type = "EXPR_RANGE" and domain1.first.type = "EXPR_INT" and domain1.first.value = 1 then
                            
                            last := value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( domain1.last );
                            
                            if CapJitIsCallToGlobalFunction( last, "Length" ) then
                                
                                return is_shorter_than( last.args.1, domain2 );
                                
                            fi;
                            
                        fi;
                        
                        # `Filtered( list, func )` is shorter than `list`
                        if CapJitIsCallToGlobalFunction( domain1, "Filtered" ) and CapJitIsEqualForEnhancedSyntaxTrees( value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( domain1.args.1 ), domain2 ) then
                            
                            return true;
                            
                        fi;
                        
                        return fail;
                        
                    end;
                    
                    # simplify nested CAP_JIT_INCOMPLETE_LOGIC
                    while CapJitIsCallToGlobalFunction( tree, "CAP_JIT_INCOMPLETE_LOGIC" ) and CapJitIsCallToGlobalFunction( value_of_binding_iterated( tree.args.1 ), "CAP_JIT_INCOMPLETE_LOGIC" ) do
                        
                        tree := tree.args.1;
                        
                    od;
                    
                    if CapJitIsCallToGlobalFunction( tree, "[]" ) then
                        
                        list_call := tree.args.1;
                        
                        if list_call.type = "EXPR_REF_FVAR" and StartsWith( list_call.name, "deduped_" ) then
                            
                            # list call has been deduplicated -> do nothing
                            return tree;
                            
                        fi;
                        
                        list_call := value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( list_call );
                        
                        if CapJitIsCallToGlobalFunction( list_call, "List" ) and list_call.args.length = 2 then
                            
                            domain := list_call.args.1;
                            
                            simplify := false;
                            
                            # If domain is hoisted and wrapped in `CAP_JIT_INCOMPLETE_LOGIC`, `CAP_JIT_INCOMPLETE_LOGIC` is also hoisted,
                            # so to distinguish between the hoisted and non-hoisted case, we do not have to take `CAP_JIT_INCOMPLETE_LOGIC` into account.
                            
                            # case: no enclosing domain, i.e. not hoisted
                            if tree.args.1.type <> "EXPR_REF_FVAR" then
                                
                                simplify := true;
                                
                            # case: a single enclosing domain
                            elif tree.args.1.type = "EXPR_REF_FVAR" and Length( func_stack ) >= 2 and tree.args.1.func_id = func_stack[Length( func_stack ) - 1].id and IsBound( domains.(Last( func_stack ).id) ) then
                                
                                enclosing_domain := domains.(Last( func_stack ).id);
                                
                                if is_shorter_than( enclosing_domain, domain ) = true then
                                    
                                    simplify := true;
                                    
                                fi;
                                
                            fi;
                            
                            if simplify then
                                
                                changed := true;
                                
                                # List( domain, func )[index] => func( domain[index] )
                                # This might open up opportunities for more optimizations: e.g. `domain[index]` could be simplified further,
                                # or the return value of `func` could be used for simplifications in the surrounding context.
                                # However, we do not apply logic anymore (see comment above).
                                # To make the user aware of this, we wrap `func( domain[index] )` and `domain[index]` in calls to `CAP_JIT_INCOMPLETE_LOGIC`.
                                
                                index := tree.args.2;
                                
                                resolved_domain := value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( domain );
                                resolved_index := value_of_binding_and_CAP_JIT_INCOMPLETE_LOGIC_iterated( index );
                                
                                # [ 1 .. last ][x] => x
                                if resolved_domain.type = "EXPR_RANGE" and resolved_domain.first.type = "EXPR_INT" and resolved_domain.first.value = 1 then
                                    
                                    element := index;
                                    
                                # [ 0 .. last ][1 + x] => x
                                elif resolved_domain.type = "EXPR_RANGE" and resolved_domain.first.type = "EXPR_INT" and resolved_domain.first.value = 0 and CapJitIsCallToGlobalFunction( resolved_index, "+" ) and resolved_index.args.1.type = "EXPR_INT" and resolved_index.args.1.value = 1 then
                                    
                                    element := resolved_index.args.2;
                                    
                                else
                                    
                                    # domain[index]
                                    element := rec(
                                        type := "EXPR_FUNCCALL",
                                        funcref := rec(
                                            type := "EXPR_REF_GVAR",
                                            gvar := "[]",
                                        ),
                                        args := AsSyntaxTreeList( [
                                            CapJitCopyWithNewFunctionIDs( domain ), # domain
                                            index, # index
                                        ] ),
                                    );
                                    
                                    if IsBound( domain.data_type ) and IsBound( index.data_type ) then
                                        
                                        element_type := CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES( "[]", [ domain.data_type, index.data_type ] );
                                        
                                        if element_type = fail then
                                            
                                            #Error( "could not determine element_type" );
                                            
                                        elif IsFunction( element_type ) then
                                            
                                            #Error( "cannot infer parametric output type by arguments types only" );
                                            
                                        # COVERAGE_IGNORE_NEXT_LINE
                                        else
                                            
                                            element.data_type := element_type;
                                            
                                            element.funcref.data_type := rec(
                                                filter := IsFunction,
                                                signature := Pair(
                                                    [
                                                        domain.data_type,
                                                        index.data_type
                                                    ],
                                                    element_type
                                                )
                                            );
                                            
                                        fi;
                                        
                                    fi;
                                    
                                fi;
                                
                                return rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := rec(
                                        type := "EXPR_REF_GVAR",
                                        gvar := "CAP_JIT_INCOMPLETE_LOGIC", # CAP_JIT_INCOMPLETE_LOGIC
                                    ),
                                    args := AsSyntaxTreeList( [
                                        rec(
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
                                                        element,
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
                
                if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                    
                    # COVERAGE_IGNORE_BLOCK_START
                    Print( "#### Continue compilation of\n" );
                    Print( "# ", NameFunction( func ), "\n" );
                    Print( "# apply generalized loop fusion\n" );
                    # COVERAGE_IGNORE_BLOCK_END
                    
                fi;
                
                tree := CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ ] );
                
                if not changed then
                    
                    if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                        
                        # COVERAGE_IGNORE_BLOCK_START
                        Print( "# no change\n\n" );
                        # COVERAGE_IGNORE_BLOCK_END
                        
                    fi;
                    
                    break;
                    
                fi;
                
                if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                    
                    # COVERAGE_IGNORE_BLOCK_START
                    Print( "# result:\n" );
                    Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
                    Print( "# clean up\n" );
                    # COVERAGE_IGNORE_BLOCK_END
                    
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
                tree := CapJitCleanedUpHoistedAndDeduplicatedExpressions( tree );
                
                if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 2 then
                    
                    # COVERAGE_IGNORE_BLOCK_START
                    Print( "# result:\n" );
                    Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
                    Print( "\n" );
                    # COVERAGE_IGNORE_BLOCK_END
                    
                fi;
                
            od;
            
        fi;
        
        if CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED then
            
            # the post-processing steps might not set data types, but in proof assistant mode having data types is important
            tree := CapJitInferredDataTypes( tree );
            
        fi;
        
    fi;
    
    if CAP_JIT_INTERNAL_DEBUG_LEVEL >= 1 then
        
        # COVERAGE_IGNORE_BLOCK_START
        Print( "######## Finished compilation of\n" );
        Print( "# ", NameFunction( func ), "\n" );
        Print( "# result:\n" );
        Display( CapJitPrettyPrintFunction( ENHANCED_SYNTAX_TREE_CODE( tree ) ) );
        Print( "\n" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
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
