#! @Chapter Examples and Tests

#! @Section MatrixCategoryAsAdditiveClosureOfRingAsCategory

#! @Example

#! #@if IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2021.12-02" )

LoadPackage( "LinearAlgebraForCAP", false );
#! true

QQ := HomalgFieldOfRationals();;

vec := MatrixCategoryAsAdditiveClosureOfRingAsCategory( QQ );
#! Category of matrices over Q

a := MatrixCategoryObject( vec, 3 );
#! <A vector space object over Q of dimension 3>
HasIsProjective( a ) and IsProjective( a );
#! true
b := MatrixCategoryObject( vec, 4 );
#! <A vector space object over Q of dimension 4>
DirectSum( a, b );
#! <A vector space object over Q of dimension 7>

ZeroObject( vec );
#! <A vector space object over Q of dimension 0>

ZeroMorphism( a, b );
#! <A zero morphism in Category of matrices over Q>

homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                 [ 0, 1, 0, -1 ],
                                 [ -1, 0, 2, 1 ] ], 3, 4, QQ );
#! <A 3 x 4 matrix over an internal ring>
alpha := VectorSpaceMorphism( a, homalg_matrix, b );
#! <A morphism in Category of matrices over Q>
Display( alpha );
#! [ [   1,   0,   0,   0 ],
#!   [   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1 ] ]
#! 
#! A morphism in Category of matrices over Q

homalg_matrix := HomalgMatrix( [ [ 1, 1, 0, 0 ],
                                 [ 0, 1, 0, -1 ],
                                 [ -1, 0, 2, 1 ] ], 3, 4, QQ );
#! <A 3 x 4 matrix over an internal ring>
beta := VectorSpaceMorphism( a, homalg_matrix, b );
#! <A morphism in Category of matrices over Q>

gamma := UniversalMorphismIntoDirectSum( [ alpha, alpha ] );;
Display( gamma );
#! [ [   1,   0,   0,   0,   1,   0,   0,   0 ],
#!   [   0,   1,   0,  -1,   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1,  -1,   0,   2,   1 ] ]
#! 
#! A morphism in Category of matrices over Q
IsEqualForMorphisms( ComponentOfMorphismIntoDirectSum( gamma, [ b, b ], 1 ), alpha );
#! true
IsEqualForMorphisms( ComponentOfMorphismIntoDirectSum( gamma, [ b, b ], 2 ), alpha );
#! true

gamma := UniversalMorphismFromDirectSum( [ beta, beta ] );;
Display( gamma );
#! [ [   1,   1,   0,   0 ],
#!   [   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1 ],
#!   [   1,   1,   0,   0 ],
#!   [   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1 ] ]
#! 
#! A morphism in Category of matrices over Q
IsEqualForMorphisms( ComponentOfMorphismFromDirectSum( gamma, [ a, a ], 1 ), beta );
#! true
IsEqualForMorphisms( ComponentOfMorphismFromDirectSum( gamma, [ a, a ], 2 ), beta );
#! true

#! #@fi

#! @EndExample
