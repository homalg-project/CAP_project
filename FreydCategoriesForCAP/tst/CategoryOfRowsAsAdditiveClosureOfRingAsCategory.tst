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
gap> a := RandomObject( vec, 100 );;
gap> b := RandomObject( vec, [100] );;
gap> IsEqualForObjects( Range( RandomMorphismWithFixedSourceAndRange( a, b, 10 ) ), b ) and IsEqualForObjects( Source( RandomMorphismWithFixedSourceAndRange( a, b, [10] ) ), a );
true
gap> IsEqualForObjects( Source( RandomMorphismWithFixedSource( a, 10 ) ), a ) and IsEqualForObjects( Source( RandomMorphismWithFixedSource( a, [10] ) ), a );
true
gap> IsEqualForObjects( Range( RandomMorphismWithFixedRange( b, 10 ) ), b ) and IsEqualForObjects( Range( RandomMorphismWithFixedRange( b, [10] ) ), b );
true
gap> IsWellDefinedForMorphisms( RandomMorphism( vec, 10 ) ) and IsWellDefinedForMorphisms( RandomMorphism( vec, [10] ) );
true
gap> a := RandomObject( ModelingCategory( vec ), 20 );;
gap> b := RandomObject( ModelingCategory( vec ), [10,[5]] );;
gap> IsEqualForObjects( Range( RandomMorphismWithFixedSourceAndRange( a, b, 10 ) ), b ) and IsEqualForObjects( Source( RandomMorphismWithFixedSourceAndRange( a, b, [10] ) ), a );
true
gap> IsEqualForObjects( Source( RandomMorphismWithFixedSource( a, 10 ) ), a ) and IsEqualForObjects( Source( RandomMorphismWithFixedSource( a, [[10,[5]],[5]] ) ), a );
true
gap> IsEqualForObjects( Range( RandomMorphismWithFixedRange( b, 10 ) ), b ) and IsEqualForObjects( Range( RandomMorphismWithFixedRange( b, [[10,[5]],[5]] ) ), b );
true
gap> IsWellDefinedForMorphisms( RandomMorphism( ModelingCategory( vec ), 10 ) ) and IsWellDefinedForMorphisms( RandomMorphism( ModelingCategory( vec ), [[10,[5]],[10,[5]],[10]] ) );
true

# hom structure for exterior algebras over fields
gap> QQ := HomalgFieldOfRationalsInSingular( );;
gap> QQxy := QQ * "x,y";;
gap> EQQxy := KoszulDualRing( QQxy );;
gap> rows := CategoryOfRows( EQQxy );;
gap> mor := IdentityMorphism( CategoryOfRowsObject( rows, 5 ) );;
gap> distinguished_object := DistinguishedObjectOfHomomorphismStructure( rows );;
gap> object := HomomorphismStructureOnObjects( Source( mor ), Source( mor ) );;
gap> HomomorphismStructureOnMorphisms( mor, mor );;
gap> HomomorphismStructureOnMorphismsWithGivenObjects( object, mor, mor, object );;
gap> iota := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( mor );;
gap> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( distinguished_object, mor, object );;
gap> beta := InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( mor ), Range( mor ), iota );;
gap> IsCongruentForMorphisms( mor, beta );
true

#
gap> STOP_TEST( "CategoryOfRowsAsAdditiveClosureOfRingAsCategory" );
