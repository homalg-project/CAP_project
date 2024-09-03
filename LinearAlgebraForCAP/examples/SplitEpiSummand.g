#! @Chapter Examples and Tests

#! @Section Split epi summand

#! @Example
LoadPackage( "LinearAlgebraForCAP", false );
#! true
Q := HomalgFieldOfRationals();;
Qmat := MatrixCategory( Q );;
a := MatrixCategoryObject( Qmat, 3 );;
b := MatrixCategoryObject( Qmat, 4 );;
homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );;
alpha := VectorSpaceMorphism( a, homalg_matrix, b );;
beta := SomeReductionBySplitEpiSummand( alpha );;
IsWellDefinedForMorphisms( beta );
#! true
Dimension( Source( beta ) );
#! 0
Dimension( Range( beta ) );
#! 1
gamma := SomeReductionBySplitEpiSummand_MorphismFromInputRange( alpha );;
Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( gamma ) ) );
#! [ [ 0 ], [ 1 ], [ -1/2 ], [ 1 ] ]
#! @EndExample

#! @Example
# @drop_example_in_Julia: differences in the output of (Safe)RightDivide, see https://github.com/homalg-project/MatricesForHomalg.jl/issues/50
delta := SomeReductionBySplitEpiSummand_MorphismToInputRange( alpha );;
Display( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( delta ) ) );
#! [ [ 0, 1, 0, 0 ] ]
#! @EndExample
