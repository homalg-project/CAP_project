gap> START_TEST( "do_not_resolve_CAP_operations_statically" );

#
gap> LoadPackage( "LinearAlgebraForCAP", false );
true

#
gap> Q := HomalgFieldOfRationals();;
gap> vec := MATRIX_CATEGORY( Q );;

#
gap> func := function ( cat, x )
>     #% CAP_JIT_RESOLVE_FUNCTION
>     return ZeroObject( cat ); end;;

# make sure that ZeroObject( cat ) is not resolved to a global variable
gap> Display( CapJitCompiledFunction( { cat, x } -> func( cat, x ), vec ) );
function ( cat_1, x_1 )
    return AsCapCategoryObject( cat_1, 0 );
end

#
gap> STOP_TEST( "do_not_resolve_CAP_operations_statically" );
