#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

# make tests deterministic
original_func_id := CAP_JIT_INTERNAL_FUNCTION_ID;;
CAP_JIT_INTERNAL_FUNCTION_ID := 1;;

# check that CapJitInlinedFunctionCalls is idempotent
func := function ( )
    
    return (function ( )
        return (function ( )
            return 1; end)( ); end)( ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;

tree := CapJitInlinedFunctionCalls( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
#! function (  )
#!     local inline_2_RETURN_VALUE_1, inline_2_inline_3_RETURN_VALUE_1;
#!     inline_2_inline_3_RETURN_VALUE_1 := 1;
#!     inline_2_RETURN_VALUE_1 := inline_2_inline_3_RETURN_VALUE_1;
#!     return inline_2_RETURN_VALUE_1;
#! end

tree2 := CapJitInlinedFunctionCalls( tree );;
Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
#! function (  )
#!     local inline_2_RETURN_VALUE_1, inline_2_inline_3_RETURN_VALUE_1;
#!     inline_2_inline_3_RETURN_VALUE_1 := 1;
#!     inline_2_RETURN_VALUE_1 := inline_2_inline_3_RETURN_VALUE_1;
#!     return inline_2_RETURN_VALUE_1;
#! end

tree = tree2;
#! true

CAP_JIT_INTERNAL_FUNCTION_ID := original_func_id;;

#! @EndExample
