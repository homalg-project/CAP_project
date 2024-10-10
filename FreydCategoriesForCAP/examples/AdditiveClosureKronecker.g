#! @Chapter Examples and Tests

#! @Section Monoidal structure of AdditiveClosure

#! @Example
LoadPackage( "FreydCategoriesForCAP", false );
#! true
Q := HomalgFieldOfRationals();
#! Q
R := RingAsCategory( Q );
#! RingAsCategory( Q )
A := AdditiveClosure( R );
#! AdditiveClosure( RingAsCategory( Q ) )
u := TensorUnit( A );
#! <An object in AdditiveClosure( RingAsCategory( Q ) )
#!  defined by 1 underlying objects>
mor1 := [ [ 1 / R, 2 / R ] ] / A;
#! <A morphism in AdditiveClosure( RingAsCategory( Q ) )
#!  defined by a 1 x 2 matrix of underlying morphisms>
mor2 := [ [ 3 / R, 4 / R ] ] / A;
#! <A morphism in AdditiveClosure( RingAsCategory( Q ) )
#!  defined by a 1 x 2 matrix of underlying morphisms>
T := TensorProduct( mor1, mor2 );
#! <A morphism in AdditiveClosure( RingAsCategory( Q ) )
#!  defined by a 1 x 4 matrix of underlying morphisms>
Display( T );
#! A 1 x 4 matrix with entries in RingAsCategory( Q )
#! 
#! [1,1]: <3>
#! [1,2]: <4>
#! [1,3]: <6>
#! [1,4]: <8>
#! @EndExample
