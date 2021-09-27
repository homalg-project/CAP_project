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
  local debug, tree, orig_tree, compiled_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Start compilation." );
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        Error( "<func> is a operation or kernel function, this is not supported yet." );
        
    fi;
    
    debug := false;
    
    if debug then
        Display( func );
        Error( "start compilation" );
    fi;
    
    if Length( jit_args ) > 0 and IsCapCategory( jit_args[1] ) then
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true, given_arguments := [ jit_args[1] ] );
        
    else
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true );
        
    fi;
    
    # resolving phase
    orig_tree := rec( );
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Start resolving." );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "start resolving" );
        fi;
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitResolvedOperations" );
        fi;
        
        tree := CapJitResolvedOperations( tree, jit_args );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitInlinedArguments" );
        fi;
        
        tree := CapJitInlinedArguments( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitDroppedUnusedBindings" );
        fi;
        
        tree := CapJitDroppedUnusedBindings( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitInlinedBindings (for global variables only)" );
        fi;
        
        tree := CapJitInlinedBindings( tree : inline_gvars_only := true );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitResolvedGlobalVariables" );
        fi;
        
        tree := CapJitResolvedGlobalVariables( tree );
        
    od;
    
    # rule phase
    orig_tree := rec( );
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Apply rules." );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply rules" );
        fi;
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitAppliedLogic" );
        fi;
        
        tree := CapJitAppliedLogic( tree, jit_args );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitDroppedHandledEdgeCases" );
        fi;
        
        tree := CapJitDroppedHandledEdgeCases( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitInlinedArguments" );
        fi;
        
        tree := CapJitInlinedArguments( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitInlinedSimpleFunctionCalls" );
        fi;
        
        tree := CapJitInlinedSimpleFunctionCalls( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitInlinedFunctionCalls" );
        fi;
        
        tree := CapJitInlinedFunctionCalls( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitDroppedUnusedBindings" );
        fi;
        
        tree := CapJitDroppedUnusedBindings( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitInlinedBindings" );
        fi;
        
        tree := CapJitInlinedBindings( tree );
        
    od;
    
    # post-processing
    
    if Length( jit_args ) > 0 and IsCapCategory( jit_args[1] ) then
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitAppliedCompilerHints" );
        fi;
        
        tree := CapJitAppliedCompilerHints( tree, jit_args[1] );
        
    fi;
    
    if debug then
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
        Display( compiled_func );
        Error( "apply CapJitHoistedExpressions" );
    fi;
    
    tree := CapJitHoistedExpressions( tree );
    
    if debug then
        
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
        
        Display( compiled_func );
        
        Assert( 0, CallFuncList( compiled_func, jit_args ) = CallFuncList( func, jit_args ) );
        
        Error( "compilation finished" );
        
    fi;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Compilation finished." );
    
    return tree;
    
end );
