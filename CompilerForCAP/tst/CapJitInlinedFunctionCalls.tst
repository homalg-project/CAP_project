gap> START_TEST( "CapJitInlinedFunctionCalls" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

# make tests deterministic
gap> original_func_id := CAP_JIT_INTERNAL_FUNCTION_ID;;
gap> CAP_JIT_INTERNAL_FUNCTION_ID := 1;;

# check that CapJitInlinedFunctionCalls is idempotent
gap> func := function ( )
>     
>     return (function ( )
>         return (function ( )
>             return 1; end)( ); end)( ); end;;

#
gap> tree := ENHANCED_SYNTAX_TREE( func );;

#
gap> tree := CapJitInlinedFunctionCalls( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
function (  )
    local inline_2_RETURN_VALUE_1, inline_2_inline_3_RETURN_VALUE_1;
    inline_2_inline_3_RETURN_VALUE_1 := 1;
    inline_2_RETURN_VALUE_1 := inline_2_inline_3_RETURN_VALUE_1;
    return inline_2_RETURN_VALUE_1;
end

#
gap> tree2 := CapJitInlinedFunctionCalls( tree );;
gap> Display( ENHANCED_SYNTAX_TREE_CODE( tree2 ) );
function (  )
    local inline_2_RETURN_VALUE_1, inline_2_inline_3_RETURN_VALUE_1;
    inline_2_inline_3_RETURN_VALUE_1 := 1;
    inline_2_RETURN_VALUE_1 := inline_2_inline_3_RETURN_VALUE_1;
    return inline_2_RETURN_VALUE_1;
end

#
gap> tree = tree2;
true

#
gap> CAP_JIT_INTERNAL_FUNCTION_ID := original_func_id;;

#
gap> STOP_TEST( "CapJitInlinedFunctionCalls" );
