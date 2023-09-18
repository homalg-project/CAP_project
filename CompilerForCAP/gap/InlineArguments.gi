# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitInlinedArguments, function ( tree )
  local pre_func, additional_arguments_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Inlining function arguments." );
    
    pre_func := function ( tree, additional_arguments )
      local func, args, j;
        
        if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_DECLARATIVE_FUNC" and tree.funcref.narg <> 0 then
            
            tree := ShallowCopy( tree );
            func := ShallowCopy( tree.funcref );
            
            if func.variadic then
                
                Assert( 0, tree.args.length >= func.narg - 1 );
                
            else
                
                Assert( 0, tree.args.length = func.narg );
                
            fi;
            
            args := ShallowCopy( tree.args );
            
            if func.variadic then
                
                args.(func.narg) := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "NTuple",
                    ),
                    args := ConcatenationForSyntaxTreeLists( [
                        AsSyntaxTreeList( [ rec(
                            type := "EXPR_INT",
                            value := args.length - func.narg + 1,
                        ) ] ),
                        Sublist( args, [ func.narg .. args.length ] )
                    ] ),
                );
                
            fi;
            
            func.bindings := ShallowCopy( func.bindings );
            func.bindings.names := ShallowCopy( func.bindings.names );
            
            for j in [ 1 .. func.narg ] do
                
                CapJitAddBinding( func.bindings, func.nams[j], args.(j) );
                
            od;
            
            func.narg := 0;
            func.variadic := false;
            
            tree.funcref := func;
            tree.args := AsSyntaxTreeList( [ ] );
            
            Info( InfoCapJit, 1, "####" );
            Info( InfoCapJit, 1, "Inlined arguments of a single function." );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
