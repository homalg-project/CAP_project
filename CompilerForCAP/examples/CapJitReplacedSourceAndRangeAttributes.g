#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "LinearAlgebraForCAP" );
#! true

func := { cat, matrix } -> [
    VectorSpaceMorphism( cat, ObjectConstructor( cat, NumberRows( matrix ) ),
        matrix, ObjectConstructor( cat, NrCols( matrix ) ) ),
    VectorSpaceMorphism( cat, ObjectConstructor( cat, NumberRows( matrix ) ),
        matrix, ObjectConstructor( cat, NrCols( matrix ) ) ),
];;

QQ := HomalgFieldOfRationals( );;

cat := MatrixCategory( QQ );;

Display( CapJitCompiledFunction( func, [ cat ] ) );
#! function ( cat_1, matrix_1 )
#!     local morphism_attr_1_1, morphism_attr_2_1;
#!     morphism_attr_2_1 := matrix_1;
#!     morphism_attr_1_1 := matrix_1;
#!     return [ ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!                ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
#!                  ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), 
#!            ObjectifyObjectForCAPWithAttributes( rec(
#!                  ), cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), 
#!            UnderlyingMatrix, morphism_attr_1_1 ), 
#!         ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!                ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
#!                  ), cat_1, Dimension, NumberRows( morphism_attr_2_1 ) ), 
#!            ObjectifyObjectForCAPWithAttributes( rec(
#!                  ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), 
#!            UnderlyingMatrix, morphism_attr_2_1 ) ];
#! end

#! @EndExample
