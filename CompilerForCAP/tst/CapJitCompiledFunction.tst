gap> START_TEST( "CapJitCompiledFunction" );

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> LoadPackage( "LinearAlgebraForCAP", false );
true

#
gap> Q := HomalgFieldOfRationals();;
gap> vec := MATRIX_CATEGORY( Q );;

# test CapJitCompiledFunction with explicit type signature
gap> Display(
>     CapJitCompiledFunction(
>         cat -> ZeroObject( cat ),
>         [
>             [
>                 rec(
>                     filter := IsCapCategory,
>                     category := vec
>                 )
>             ],
>             fail,
>         ]
>     )
> );
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
end

#
gap> STOP_TEST( "CapJitCompiledFunction" );
