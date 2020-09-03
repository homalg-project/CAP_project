#
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

InstallGlobalFunction( StopCompilationAtCategory, function( category )
    
    Assert( 0, IsCapCategory( category ) );
    
    category!.stop_compilation := true;
    
end );

InstallGlobalFunction( ContinueCompilationAtCategory, function( category )
    
    Assert( 0, IsCapCategory( category ) );
    
    category!.stop_compilation := false;
    
end );

InstallGlobalFunction( CapJitCompiledFunction, function( func, jit_args )
  local debug, tree, orig_tree, compiled_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Start compilation." );
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        Info( InfoCapJit, 1, "<func> is a operation or kernel function, this is not supported yet." );
        return func;
        
    fi;
    
    debug := false;
    
    if debug then
        Display( func );
        Error( "start compilation" );
    fi;
    
    tree := ENHANCED_SYNTAX_TREE( func, true );
    
    # resolving phase
    orig_tree := rec();
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Start resolving." );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "start resolving" );
        fi;
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitResolvedOperations" );
        fi;
        
        tree := CapJitResolvedOperations( tree, jit_args );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitAppliedLogicTemplates" );
        fi;
        
        tree := CapJitAppliedLogicTemplates( tree, jit_args, true );
        
        # new functions might be resolved -> test for side effects
        CapJitThrowErrorOnSideEffects( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitInlinedArguments" );
        fi;
        
        tree := CapJitInlinedArguments( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitDroppedUnusedVariables" );
        fi;
        
        tree := CapJitDroppedUnusedVariables( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitInlinedVariableAssignments" );
        fi;
        
        tree := CapJitInlinedVariableAssignments( tree, true );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitResolvedGlobalVariables" );
        fi;
        
        tree := CapJitResolvedGlobalVariables( tree );
        
    od;
    
    # rule phase
    orig_tree := rec();
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Apply rules." );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply rules" );
        fi;
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitAppliedLogic" );
        fi;
        
        tree := CapJitAppliedLogic( tree, jit_args );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitDroppedHandledEdgeCases" );
        fi;
        
        tree := CapJitDroppedHandledEdgeCases( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitInlinedArguments" );
        fi;
        
        tree := CapJitInlinedArguments( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitInlinedSimpleFunctionCalls" );
        fi;
        
        tree := CapJitInlinedSimpleFunctionCalls( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitInlinedFunctionCalls" );
        fi;
        
        tree := CapJitInlinedFunctionCalls( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitDroppedUnusedVariables" );
        fi;
        
        tree := CapJitDroppedUnusedVariables( tree );
        
        if debug then
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display(compiled_func);
            Error( "apply CapJitInlinedVariableAssignments" );
        fi;
        
        tree := CapJitInlinedVariableAssignments( tree );
        
    od;
    
    if debug then
        
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
        
        Display( compiled_func );
        
        Assert( 0, CallFuncList( compiled_func, jit_args ) = CallFuncList( func, jit_args ) );
        
        Error( "compilation finished" );
        
    fi;
    
    compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Compilation finished." );
    
    return compiled_func;
    
end );
