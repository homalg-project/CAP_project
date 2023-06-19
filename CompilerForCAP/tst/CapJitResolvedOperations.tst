gap> START_TEST( "CapJitResolvedOperations" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

# function call without arguments
gap> Display( CapJitCompiledFunction( {} -> ReturnTrue( ) ) );
function (  )
    return RETURN_TRUE(  );
end

#
gap> CapJitEnableProofAssistantMode( );

# resolve CAP operations without category as first argument
gap> func := { cat, mor1, mor2 } -> PreCompose( mor1, mor2 );;
gap> cat := DummyCategory( rec( list_of_operations_to_install := [ "PreComposeList" ] ) );;
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( cat );
gap> Display( CapJitCompiledFunction( func, cat, [ "category", "morphism", "morphism" ], "morphism" ) );
function ( cat_1, mor1_1, mor2_1 )
    return PreComposeList( cat_1, [ mor1_1, mor2_1 ] );
end

# resolve CAP operations without category as first argument (list input)
gap> func := { cat, mor1, mor2 } -> PreComposeList( [ mor1, mor2 ] );;
gap> cat := DummyCategory( rec( list_of_operations_to_install := [ "PreCompose" ] ) );;
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( cat );
gap> Display( CapJitCompiledFunction( func, cat, [ "category", "morphism", "morphism" ], "morphism" ) );
function ( cat_1, mor1_1, mor2_1 )
    return PreCompose( cat_1, mor1_1, mor2_1 );
end

#
gap> CapJitDisableProofAssistantMode( );

#
gap> STOP_TEST( "CapJitResolvedOperations" );
