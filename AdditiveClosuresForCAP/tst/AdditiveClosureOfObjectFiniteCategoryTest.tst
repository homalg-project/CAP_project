gap> START_TEST("AddClosureObjFinTest.tst");

gap> LoadPackage( "LinearClosuresForCAP", false );
true
gap> D := FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] );;
gap> Q := HomalgFieldOfRationals( );;
gap> L := LinearClosure( Q, D );;
gap> A := AdditiveClosureOfObjectFiniteCategory( L );;
gap> a := ObjectConstructor( A, [1,[1,0]] );;
gap> b := ObjectConstructor( A, [1,[0,1]] );;
gap> ObjectDatum( a );
[ 1, [ 1, 0 ] ]
gap> Display( b );
A formal direct sum consisting of 1 object:

0 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
1 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
gap> Display( ZeroObject( A ) );
A formal direct sum consisting of 0 objects:

0 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
0 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
gap> aab := ObjectConstructor( A, [3,[2,1]] );;
gap> aab = DirectSum( [ a, b, a ] );
true
gap> aab[1] = D[1] / L;
true
gap> aab[2] = D[1] / L;
true
gap> aab[3] = D[2] / L;
true
gap> id_aab := IdentityMorphism( aab );;
gap> z := ZeroMorphism( aab, b );;
gap> MorphismDatum( z );
[ [ 0 ], [ 0 ], [ 0 ] ]
gap> Display( z );
A 3 x 1 matrix with entries in LinearClosure( FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] ) )

[1,1]: 0
[2,1]: 0
[3,1]: 0
gap> IsZeroForMorphisms( z );
true
gap> z_aab := ZeroMorphism( aab, aab );;
gap> IsEqualForMorphisms( id_aab, z_aab );
false
gap> IsEqualForMorphisms( id_aab, id_aab );
true
gap> IsCongruentForMorphisms( id_aab, z_aab );
false
gap> IsCongruentForMorphisms( id_aab, id_aab );
true
gap> PreCompose( id_aab, z_aab );
<A morphism in AdditiveClosureOfObjectFiniteCategory( LinearClosure( FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] ) ) ) defined by a 3 x 3 matrix of underlying morphisms>
gap> Display( AdditionForMorphisms( id_aab, id_aab ) );
A 3 x 3 matrix with entries in LinearClosure( FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] ) )

[1,1]: (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>) + (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
[1,2]: 0
[1,3]: 0
[2,1]: 0
[2,2]: (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>) + (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
[2,3]: 0
[3,1]: 0
[3,2]: 0
[3,3]: (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>) + (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
gap> Display( SumOfMorphisms( Source( id_aab ), [ id_aab, z_aab, id_aab ], Target( id_aab ) ) );
A 3 x 3 matrix with entries in LinearClosure( FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] ) )

[1,1]: (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>) + (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
[1,2]: 0
[1,3]: 0
[2,1]: 0
[2,2]: (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>) + (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
[2,3]: 0
[3,1]: 0
[3,2]: 0
[3,3]: (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>) + (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
gap> Display( AdditiveInverseForMorphisms( id_aab ) );
A 3 x 3 matrix with entries in LinearClosure( FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] ) )

[1,1]: (-1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
[1,2]: 0
[1,3]: 0
[2,1]: 0
[2,2]: (-1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
[2,3]: 0
[3,1]: 0
[3,2]: 0
[3,3]: (-1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
gap> diag := [ a, a, b ];;
gap> pr1 := ProjectionInFactorOfDirectSum( diag, 1 );;
gap> pr2 := ProjectionInFactorOfDirectSum( diag, 2 );;
gap> pr3 := ProjectionInFactorOfDirectSum( diag, 3 );;
gap> u := UniversalMorphismIntoDirectSumWithGivenDirectSum( diag, [ pr1, pr2, pr3 ], aab );;
gap> IsWellDefinedForMorphisms( u );
true
gap> inj1 := InjectionOfCofactorOfDirectSum( diag, 1 );;
gap> inj2 := InjectionOfCofactorOfDirectSum( diag, 2 );;
gap> inj3 := InjectionOfCofactorOfDirectSum( diag, 3 );;
gap> u := UniversalMorphismFromDirectSumWithGivenDirectSum( diag, [ inj1, inj2, inj3 ], aab  );;
gap> IsWellDefinedForMorphisms( u );
true
gap> comp := ComponentOfMorphismIntoDirectSum( inj1, [ a, a, b ], 3 );;
gap> IsWellDefined( comp );
true
gap> Display( comp );
A 1 x 1 matrix with entries in LinearClosure( FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] ) )

[1,1]: 0
gap> comp := ComponentOfMorphismFromDirectSum( pr3, [ a, a, b ], 1 );;
gap> IsWellDefined( comp );
true
gap> Display( comp );
A 1 x 1 matrix with entries in LinearClosure( FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] ) )

[1,1]: 0
gap> Display( MultiplyWithElementOfCommutativeSemiringForMorphisms( 10 / Q, id_aab ) );;
A 3 x 3 matrix with entries in LinearClosure( FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] ) )

[1,1]: (10*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
[1,2]: 0
[1,3]: 0
[2,1]: 0
[2,2]: (10*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
[2,3]: 0
[3,1]: 0
[3,2]: 0
[3,3]: (10*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 2 ] )>)
gap> D[1] / L / A;;
gap> IdentityMorphism( D[1] / L ) / A;;
gap> [ D[1] / L, D[2] / L, D[1] / L ] / A;;

#
gap> STOP_TEST("AddClosureObjFinTest.tst", 1);
