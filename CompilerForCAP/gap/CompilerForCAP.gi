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

InstallGlobalFunction( CapJitCompiledFunction, function ( func, jit_args )
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        Info( InfoCapJit, 1, "<func> is a operation or kernel function, this is not supported yet." );
        return func;
        
    fi;
    
    return ENHANCED_SYNTAX_TREE_CODE( CapJitCompiledFunctionAsEnhancedSyntaxTree( func, jit_args ) );
    
end );

InstallGlobalFunction( CapJitCompiledFunctionAsEnhancedSyntaxTree, function ( func, jit_args )
  local debug, debug_idempotence, tree, resolving_phase_functions, orig_tree, compiled_func, tmp, rule_phase_functions, f;
    
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
    
    if Length( jit_args ) > 0 and IsCapCategory( jit_args[1] ) then
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true, given_arguments := [ jit_args[1] ] );
        
    else
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true );
        
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
            
            if NumberArgumentsFunction( f ) = 1 then
                
                tree := f( tree );
                
            elif NumberArgumentsFunction( f ) = 2 then
                
                tree := f( tree, jit_args );
                
            else
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "this should never happen" );
                
            fi;
            
            if debug_idempotence then
                
                # COVERAGE_IGNORE_BLOCK_START
                tmp := StructuralCopy( tree );
                
                if NumberArgumentsFunction( f ) = 1 then
                    
                    tree := f( tree );
                    
                elif NumberArgumentsFunction( f ) = 2 then
                    
                    tree := f( tree, jit_args );
                    
                else
                    
                    Error( "this should never happen" );
                    
                fi;
                
                if tmp <> tree then
                    
                    Error( NameFunction( f ), " is not idempotent" );
                    
                fi;
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
        od;
        
    od;
    
    # rule phase
    rule_phase_functions := [
        CapJitAppliedLogic,
        CapJitDroppedHandledEdgeCases,
        CapJitInlinedArguments,
        CapJitInlinedSimpleFunctionCalls,
        CapJitInlinedFunctionCalls,
        CapJitDroppedUnusedBindings,
        CapJitInlinedBindings,
        CapJitDroppedUnusedBindings,
    ];
    
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
            
            if NumberArgumentsFunction( f ) = 1 then
                
                tree := f( tree );
                
            elif NumberArgumentsFunction( f ) = 2 then
                
                tree := f( tree, jit_args );
                
            else
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "this should never happen" );
                
            fi;
            
            if debug_idempotence then
                
                # COVERAGE_IGNORE_BLOCK_START
                tmp := StructuralCopy( tree );
                
                if NumberArgumentsFunction( f ) = 1 then
                    
                    tree := f( tree );
                    
                elif NumberArgumentsFunction( f ) = 2 then
                    
                    tree := f( tree, jit_args );
                    
                else
                    
                    Error( "this should never happen" );
                    
                fi;
                
                if tmp <> tree then
                    
                    Error( NameFunction( f ), " is not idempotent" );
                    
                fi;
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
        od;
        
    od;
    
    # post-processing
    
    if Length( jit_args ) > 0 and IsCapCategory( jit_args[1] ) then
        
        if debug then
            # COVERAGE_IGNORE_BLOCK_START
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitAppliedCompilerHints" );
            # COVERAGE_IGNORE_BLOCK_END
        fi;
        
        tree := CapJitAppliedCompilerHints( tree, jit_args[1] );
        
    fi;
    
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
    
    if debug then
        
        # COVERAGE_IGNORE_BLOCK_START
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
        
        Display( compiled_func );
        
        if NumberArgumentsFunction( func ) = Length( jit_args ) then
            
            Assert( 0, CallFuncList( compiled_func, jit_args ) = CallFuncList( func, jit_args ) );
            
        fi;
        
        Error( "compilation finished" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Compilation finished." );
    
    return tree;
    
end );
