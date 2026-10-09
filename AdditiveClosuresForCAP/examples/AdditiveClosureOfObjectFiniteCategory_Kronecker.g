#! @BeginChunk AddClosureObjFinKronecker

#! @Example
LoadPackage( "AdditiveClosuresForCAP", false );
#! true
Q := HomalgFieldOfRationals();;
R := RingAsCategory( Q );;
A := AdditiveClosureOfObjectFiniteCategory( R );;
u := TensorUnit( A );;
mor1 := [ [ 1 / R, 2 / R ] ] / A;;
mor2 := [ [ 3 / R, 4 / R ] ] / A;;
T := TensorProduct( mor1, mor2 );;
Display( T );
#! A 1 x 4 matrix with entries in RingAsCategory( Q )
#! 
#! [1,1]: <3>
#! [1,2]: <4>
#! [1,3]: <6>
#! [1,4]: <8>
Display( Range( T ) );
#! A formal direct sum consisting of 4 objects:
#! 4 times: *
#! @EndExample
