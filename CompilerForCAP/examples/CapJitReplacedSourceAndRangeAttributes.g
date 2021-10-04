#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "LinearAlgebraForCAP" );
#! true

func := { cat, matrix } -> [
    VectorSpaceMorphism( cat, ObjectConstructor( cat, NrRows( matrix ) ),
        matrix, ObjectConstructor( cat, NrCols( matrix ) ) ),
    VectorSpaceMorphism( cat, ObjectConstructor( cat, NrRows( matrix ) ),
        matrix, ObjectConstructor( cat, NrCols( matrix ) ) ),
];;

QQ := HomalgFieldOfRationals( );;

cat := MatrixCategory( QQ );;

Display( CapJitCompiledFunction( func, [ cat ] ) );
#! function ( cat_1, matrix_1 )
#!     local cap_jit_morphism_attribute_1_1, cap_jit_morphism_attribute_2_1;
#!     cap_jit_morphism_attribute_1_1 := matrix_1;
#!     cap_jit_morphism_attribute_2_1 := matrix_1;
#!     return [ ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!                ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
#!                  ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 
#!                ) ), ObjectifyObjectForCAPWithAttributes( rec(
#!                  ), cat_1, Dimension, 
#!              NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, 
#!            cap_jit_morphism_attribute_1_1 ), 
#!         ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!                ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
#!                  ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_2_1 
#!                ) ), ObjectifyObjectForCAPWithAttributes( rec(
#!                  ), cat_1, Dimension, 
#!              NrColumns( cap_jit_morphism_attribute_2_1 ) ), UnderlyingMatrix, 
#!            cap_jit_morphism_attribute_2_1 ) ];
#! end

#! @EndExample
