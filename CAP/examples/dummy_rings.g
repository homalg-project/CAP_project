#! @Chapter Examples and Tests

#! @Section Dummy implementations

#! @Subsection Dummy rings

#! @Example

LoadPackage( "CAP", false );
#! true

DummyRing( );
#! Dummy ring 1
DummyRing( );
#! Dummy ring 2
IsRing( DummyRing( ) );
#! true

DummyCommutativeRing( );
#! Dummy commutative ring 1
DummyCommutativeRing( );
#! Dummy commutative ring 2
IsRing( DummyCommutativeRing( ) );
#! true
IsCommutative( DummyCommutativeRing( ) );
#! true

DummyField( );
#! Dummy field 1
DummyField( );
#! Dummy field 2
IsRing( DummyField( ) );
#! true
IsField( DummyField( ) );
#! true

#! @EndExample
