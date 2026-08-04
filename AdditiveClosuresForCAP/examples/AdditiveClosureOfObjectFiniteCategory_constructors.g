#! @BeginChunk AddClosureObjFinConstruction

#! @Example
LoadPackage( "LinearClosuresForCAP", false );
#! true
D := FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] );;
Q := HomalgFieldOfRationals( );;
L := LinearClosure( Q, D );;
A := AdditiveClosureOfObjectFiniteCategory( L );;
source := AdditiveClosureObject( A, [ 3, [ 2, 1, 0, 0 ] ] );;
source = [ D[1] / L, D[2] / L, D[1] / L ] / A;
#! true
Display( source );
#! A formal direct sum consisting of 3 objects:
#! 
#! 2 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] )>)
#! 1 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] )>)
#! 0 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] )>)
#! 0 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] )>)
target := AdditiveClosureObject( A, [ 2, [ 0, 1, 1, 0 ] ] );;
Display( target );
#! A formal direct sum consisting of 2 objects:
#! 
#! 0 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] )>)
#! 1 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] )>)
#! 1 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] )>)
#! 0 times: LinearClosureObject(<An object in FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] )>)
id_2 := IdentityMorphism( D[2] / L );;
zero_12 := ZeroMorphism( L, D[1] / L, D[2] / L );;
zero_13 := ZeroMorphism( L, D[1] / L, D[3] / L );;
zero_23 := ZeroMorphism( L, D[2] / L, D[3] / L );;
matrix := [ [ zero_12, zero_13 ], [ zero_12, zero_13 ], [ id_2, zero_23] ];;
m := AdditiveClosureMorphism( A, source, matrix, target );;
m = matrix / A;
#! true
Display( m );
#! A 3 x 2 matrix with entries in LinearClosure( FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] ) )
#! 
#! [1,1]: 0
#! [1,2]: 0
#! [2,1]: 0
#! [2,2]: 0
#! [3,1]: (1*<An identity morphism in FiniteSkeletalDiscreteCategory( [ 1 .. 4 ] )>)
#! [3,2]: 0
#! @EndExample
#! @EndChunk

