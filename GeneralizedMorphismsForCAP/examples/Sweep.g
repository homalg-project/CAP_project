#! @Chapter Examples and Tests

#! @Section Sweep

#! $\href{https://terrytao.wordpress.com/2015/10/07/sweeping-a-matrix-rotates-its-graph/}{\textrm{Geometric interpretation of sweeping a matrix by Terence Tao.}}$

LoadPackage( "LinearAlgebraForCAP" );
LoadPackage( "GeneralizedMorphismsForCAP" );

#! @Example
Q := HomalgFieldOfRationals();;
V := VectorSpaceObject( 3, Q );;
mat := HomalgMatrix( [ [ 9, 8, 7 ], [ 6, 5, 4 ], [ 3, 2, 1 ] ], 3, 3, Q );;
alpha := VectorSpaceMorphism( V, mat, V );;
graph := FiberProductEmbeddingInDirectSum( 
            [ alpha, IdentityMorphism( V ) ] );;
Display( graph );
#! [ [     1,    -2,     1,     0,     0,     0 ],
#!   [  -4/3,   7/3,     0,     2,     1,     0 ],
#!   [   5/3,  -8/3,     0,    -1,     0,     1 ] ]
#! 
#! A morphism in Category of matrices over Q
D := DirectSum( V, V );;
rotmat := HomalgMatrix( [ [ 0, 0, 0, -1, 0, 0 ],
                             [ 0, 1, 0, 0, 0, 0 ],
                             [ 0, 0, 1, 0, 0, 0 ],
                             [ 1, 0, 0, 0, 0, 0 ],
                             [ 0, 0, 0, 0, 1, 0 ],
                             [ 0, 0, 0, 0, 0, 1 ] ],
                             6, 6, Q );;
rot := VectorSpaceMorphism( D, rotmat, D );;
p := PreCompose( graph, rot );;
Display( p );
#! [ [     0,    -2,     1,    -1,     0,     0 ],
#!   [     2,   7/3,     0,   4/3,     1,     0 ],
#!   [    -1,  -8/3,     0,  -5/3,     0,     1 ] ]
#! 
#! A morphism in Category of matrices over Q
pi1 := ProjectionInFactorOfDirectSum( [ V, V ], 1 );;
pi2 := ProjectionInFactorOfDirectSum( [ V, V ], 2 );;
reversed_arrow := PreCompose( p, pi1 );;
arrow := PreCompose( p, pi2 );;
g := GeneralizedMorphismBySpan( reversed_arrow, arrow );;
IsHonest( g );
#! true
sweep_1_alpha := HonestRepresentative( g );;
Display( sweep_1_alpha );
#! [ [  -1/9,   8/9,   7/9 ],
#!   [   2/3,  -1/3,  -2/3 ],
#!   [   1/3,  -2/3,  -4/3 ] ]
#! 
#! A morphism in Category of matrices over Q
Display( alpha );
#! [ [  9,  8,  7 ],
#!   [  6,  5,  4 ],
#!   [  3,  2,  1 ] ]
#! 
#! A morphism in Category of matrices over Q
#! @EndExample
