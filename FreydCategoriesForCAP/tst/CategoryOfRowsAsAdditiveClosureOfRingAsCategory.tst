gap> START_TEST( "CategoryOfRowsAsAdditiveClosureOfRingAsCategory" );

#
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> QQ := HomalgFieldOfRationals( );;
gap> vec := CategoryOfRowsAsAdditiveClosureOfRingAsCategory( QQ );
Rows( Q )
gap> a := CategoryOfRowsObject( vec, 3 );
<A row module over Q of rank 3>
gap> HasIsProjective( a ) and IsProjective( a );
true
gap> b := CategoryOfRowsObject( vec, 4 );
<A row module over Q of rank 4>
gap> DirectSum( a, b );
<A row module over Q of rank 7>
gap> ZeroObject( vec );
<A row module over Q of rank 0>
gap> ZeroMorphism( a, b );
<A zero morphism in Rows( Q )>
gap> homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
>                                  [ 0, 1, 0, -1 ],
>                                  [ -1, 0, 2, 1 ] ], 3, 4, QQ );
<A 3 x 4 matrix over an internal ring>
gap> alpha := CategoryOfRowsMorphism( a, homalg_matrix, b );
<A morphism in Rows( Q )>
gap> Display( alpha );
Source: 
A row module over Q of rank 3

Matrix: 
[ [   1,   0,   0,   0 ],
  [   0,   1,   0,  -1 ],
  [  -1,   0,   2,   1 ] ]

Range: 
A row module over Q of rank 4

A morphism in Rows( Q )
gap> homalg_matrix := HomalgMatrix( [ [ 1, 1, 0, 0 ],
>                                  [ 0, 1, 0, -1 ],
>                                  [ -1, 0, 2, 1 ] ], 3, 4, QQ );
<A 3 x 4 matrix over an internal ring>
gap> beta := CategoryOfRowsMorphism( a, homalg_matrix, b );
<A morphism in Rows( Q )>
gap> gamma := UniversalMorphismIntoDirectSum( [ alpha, alpha ] );;
gap> Display( gamma );
Source: 
A row module over Q of rank 3

Matrix: 
[ [   1,   0,   0,   0,   1,   0,   0,   0 ],
  [   0,   1,   0,  -1,   0,   1,   0,  -1 ],
  [  -1,   0,   2,   1,  -1,   0,   2,   1 ] ]

Range: 
A row module over Q of rank 8

A morphism in Rows( Q )
gap> IsEqualForMorphisms( ComponentOfMorphismIntoDirectSum( gamma, [ b, b ], 1 ), alpha );
true
gap> IsEqualForMorphisms( ComponentOfMorphismIntoDirectSum( gamma, [ b, b ], 2 ), alpha );
true
gap> gamma := UniversalMorphismFromDirectSum( [ beta, beta ] );;
gap> Display( gamma );
Source: 
A row module over Q of rank 6

Matrix: 
[ [   1,   1,   0,   0 ],
  [   0,   1,   0,  -1 ],
  [  -1,   0,   2,   1 ],
  [   1,   1,   0,   0 ],
  [   0,   1,   0,  -1 ],
  [  -1,   0,   2,   1 ] ]

Range: 
A row module over Q of rank 4

A morphism in Rows( Q )
gap> IsEqualForMorphisms( ComponentOfMorphismFromDirectSum( gamma, [ a, a ], 1 ), beta );
true
gap> IsEqualForMorphisms( ComponentOfMorphismFromDirectSum( gamma, [ a, a ], 2 ), beta );
true

#
gap> STOP_TEST( "CategoryOfRowsAsAdditiveClosureOfRingAsCategory" );
