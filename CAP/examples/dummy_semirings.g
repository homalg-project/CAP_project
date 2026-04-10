#! @Chapter Examples and Tests

#! @Section Dummy implementations

#! @Subsection Dummy semirings

#! @Example

LoadPackage( "CAP", false );
#! true

DummyCommutativeSemiring( );
#! Dummy commutative semiring 1
DummyCommutativeSemiring( );
#! Dummy commutative semiring 2
IsSemiring( DummyCommutativeSemiring( ) );
#! true
IsCommutative( DummyCommutativeSemiring( ) );
#! true

#! @EndExample
