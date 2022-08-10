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
    
    return ENHANCED_SYNTAX_TREE_CODE( CallFuncList( CapJitCompiledFunctionAsEnhancedSyntaxTree, Concatenation( [ func ], args ) ) );
    
end );

InstallGlobalFunction( CapJitCompiledFunctionAsEnhancedSyntaxTree, function ( func, args... )
  local debug, debug_idempotence, category_as_first_argument, category, type_signature, filter_list, arguments_data_types, return_type, return_data_type, tree, resolving_phase_functions, orig_tree, compiled_func, tmp, rule_phase_functions, f;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Start compilation." );
    
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
        
    od;
    
    # rule phase
    rule_phase_functions := [
        CapJitInferredDataTypes,
        CapJitAppliedLogic,
        CapJitDroppedUnusedBindings,
        CapJitDroppedHandledEdgeCases,
        CapJitInlinedArguments,
        CapJitInlinedSimpleFunctionCalls,
        CapJitInlinedFunctionCalls,
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
        
    fi;
    
    if debug then
        
        # COVERAGE_IGNORE_BLOCK_START
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
        
        Display( compiled_func );
        
        Error( "compilation finished" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Compilation finished." );
    
    return tree;
    
end );
