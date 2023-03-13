gap> START_TEST( "CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER" );

#
gap> LoadPackage( "CAP", false );
true

#
gap> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( rec( filter := IsFunction, signature := [ [ rec( filter := IsInt ) ], fail ] ), [ "test value" ] )( x -> x );
gap> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( rec( filter := IsList, element_type := rec( filter := IsList, element_type := rec( filter := IsInt ) ) ), [ "test value" ] )( [ [ 1, 2, 3, 4 ] ] );
gap> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( rec( filter := IsNTuple, element_types := [ rec( filter := IsInt ), rec( filter := IsStringRep ) ] ), [ "test value" ] )( Pair( 1, "2" ) );
gap> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( CapJitDataTypeOfCategory( CapCat ), [ "test value" ] )( CapCat );
gap> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( CapJitDataTypeOfObjectOfCategory( CapCat ), [ "test value" ] )( TerminalObject( CapCat ) );
gap> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( CapJitDataTypeOfMorphismOfCategory( CapCat ), [ "test value" ] )( IdentityMorphism( TerminalObject( CapCat ) ) );
gap> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( CapJitDataTypeOfTwoCellOfCategory( CapCat ), [ "test value" ] )( NaturalTransformation( IdentityMorphism( TerminalObject( CapCat ) ), IdentityMorphism( TerminalObject( CapCat ) ) ) );
gap> CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( rec( filter := IsInt ), [ "test value" ] )( 1 );

#
gap> STOP_TEST( "CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER" );
