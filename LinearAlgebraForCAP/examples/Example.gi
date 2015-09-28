#! @Chapter Examples and Tests

#! @Section Basic Commands

LoadPackage( "LinearAlgebraForCAP" );;

#! @Example
Q := HomalgFieldOfRationals();;
a := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
b := VectorSpaceObject( 4, Q );
#! <A vector space object over Q of dimension 4>
homalg_matrix := HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                  [ 0, 1, 0, -1 ],
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );
#! <A matrix over an internal ring>
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
                                  [ -1, 0, 2, 1 ] ], 3, 4, Q );
#! <A matrix over an internal ring>
beta := VectorSpaceMorphism( a, homalg_matrix, b );
#! <A morphism in Category of matrices over Q>
CokernelObject( alpha );
#! <A vector space object over Q of dimension 1>
c := CokernelProjection( alpha );;
Display( c );
#! [ [     0 ],
#!   [     1 ],
#!   [  -1/2 ],
#!   [     1 ] ]
#!
#! A split epi morphism in Category of matrices over Q
gamma := UniversalMorphismIntoDirectSum( [ c, c ] );;
Display( gamma );
#! [ [     0,     0 ],
#!   [     1,     1 ],
#!   [  -1/2,  -1/2 ],
#!   [     1,     1 ] ]
#! 
#! A morphism in Category of matrices over Q
colift := CokernelColift( alpha, gamma );;
IsEqualForMorphisms( PreCompose( c, colift ), gamma );
#! true
FiberProduct( alpha, beta );
#! <A vector space object over Q of dimension 2>
F := FiberProduct( alpha, beta );
#! <A vector space object over Q of dimension 2>
p1 := ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 );
#! <A morphism in Category of matrices over Q>
Display( PreCompose( p1, alpha ) );
#! [ [   0,   1,   0,  -1 ],
#!   [  -1,   0,   2,   1 ] ]
#! 
#! A morphism in Category of matrices over Q
Pushout( alpha, beta );
#! <A vector space object over Q of dimension 5>
i1 := InjectionOfCofactorOfPushout( [ alpha, beta ], 1 );
#! <A morphism in Category of matrices over Q>
i2 := InjectionOfCofactorOfPushout( [ alpha, beta ], 2 );
#! <A morphism in Category of matrices over Q>
u := UniversalMorphismFromDirectSum( [ b, b ], [ i1, i2 ] );
#! <A morphism in Category of matrices over Q>
Display( u );
#! [ [     0,     1,     1,     0,     0 ],
#!   [     1,     0,     1,     0,    -1 ],
#!   [  -1/2,     0,   1/2,     1,   1/2 ],
#!   [     1,     0,     0,     0,     0 ],
#!   [     0,     1,     0,     0,     0 ],
#!   [     0,     0,     1,     0,     0 ],
#!   [     0,     0,     0,     1,     0 ],
#!   [     0,     0,     0,     0,     1 ] ]
#! 
#! A morphism in Category of matrices over Q
#! @EndExample