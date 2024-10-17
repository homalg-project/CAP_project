gap> START_TEST( "CapJitReplacedSourceAndRangeAttributes" );

#
gap> LoadPackage( "LinearAlgebraForCAP", false );
true

#
gap> func := { cat, matrix } -> [
>   VectorSpaceMorphism( cat,
>       ObjectConstructor( cat, NumberRows( matrix ) - RowRankOfMatrix( matrix ) ),
>       SyzygiesOfRows( matrix ),
>       ObjectConstructor( cat, NumberColumns( matrix ) )
>   ),
>   VectorSpaceMorphism( cat,
>       ObjectConstructor( cat, NumberRows( matrix ) ),
>       SyzygiesOfColumns( matrix ),
>       ObjectConstructor( cat, NumberColumns( matrix ) - ColumnRankOfMatrix( matrix ) )
>   ),
> ];;

#
gap> QQ := HomalgFieldOfRationals( );;

#
gap> cat := MatrixCategory( QQ );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, matrix_1 )
    local morphism_attr_1_1, morphism_attr_2_1;
    morphism_attr_2_1 := SyzygiesOfColumns( matrix_1 );
    morphism_attr_1_1 := SyzygiesOfRows( matrix_1 );
    return 
     [ 
        AsCapCategoryMorphism( cat_1, 
           AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), 
           morphism_attr_1_1, 
           AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) ),
        AsCapCategoryMorphism( cat_1, 
           AsCapCategoryObject( cat_1, NumberRows( morphism_attr_2_1 ) ), 
           morphism_attr_2_1, 
           AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_2_1 ) ) ) 
       ];
end

#
gap> STOP_TEST( "CapJitReplacedSourceAndRangeAttributes" );
