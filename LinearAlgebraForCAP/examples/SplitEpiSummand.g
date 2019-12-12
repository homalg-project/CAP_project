#! @Chapter Examples and Tests

#! @Section Split epi summand

LoadPackage( "LinearAlgebraForCAP" );;

#! @Example
Q := HomalgFieldOfRationals();;
a := VectorSpaceObject( 3, Q );;
b := VectorSpaceObject( 4, Q );;
homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );;
alpha := VectorSpaceMorphism( a, homalg_matrix, b );;
Display( SomeReductionBySplitEpiSummand( alpha ) );
#! (an empty 0 x 1 matrix)
#! 
#! A zero, split monomorphism in Category of matrices over Q
Display( SomeReductionBySplitEpiSummand_MorphismFromInputRange( alpha ) );
#! [ [     0 ],
#!   [     1 ],
#!   [  -1/2 ],
#!   [     1 ] ]
#! 
#! A split epimorphism in Category of matrices over Q
Display( SomeReductionBySplitEpiSummand_MorphismToInputRange( alpha ) );
#! [ [  0,  1,  0,  0 ] ]
#! 
#! A morphism in Category of matrices over Q
#! @EndExample