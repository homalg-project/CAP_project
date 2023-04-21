# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
InstallGlobalFunction( CapJitInlinedSimpleFunctionCalls, function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Inline simple function calls." );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_DECLARATIVE_FUNC" and tree.funcref.bindings.names = [ "RETURN_VALUE" ] then
            
            if not (tree.args.length = 0 and tree.funcref.narg = 0) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "found function call with arguments, please inline arguments first" );
                
            fi;
            
            Info( InfoCapJit, 1, "####" );
            Info( InfoCapJit, 1, "Inlined simple function call." );
            
            return tree.funcref.bindings.BINDING_RETURN_VALUE;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
