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
gap> cat := DummyCategory( rec( list_of_operations_to_install := [ "IsCongruentForMorphisms", "PreComposeList" ] ) );;
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( cat );
gap> Display( CapJitCompiledFunction( func, cat, [ "category", "morphism", "morphism" ], "morphism" ) );
function ( cat_1, mor1_1, mor2_1 )
    return PreComposeList( cat_1, Source( mor1_1 ), [ mor1_1, mor2_1 ], 
       Range( mor2_1 ) );
end

# resolve CAP operations without category as first argument (list input)
gap> func := { cat, obj1, obj2 } -> DirectProduct( [ obj1, obj2 ] );;
gap> cat := DummyCategory( rec( properties := [ "IsAdditiveCategory" ], list_of_operations_to_install := [ "IsCongruentForMorphisms", "IsomorphismFromDirectProductToDirectSum" ] ) );;
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( cat );
gap> Display( CapJitCompiledFunction( func, cat, [ "category", "object", "object" ], "object" ) );
function ( cat_1, obj1_1, obj2_1 )
    return 
     Source( IsomorphismFromDirectProductToDirectSum( cat_1, 
         [ obj1_1, obj2_1 ] ) );
end

# test CAP_JIT_INTERNAL_WARN_ABOUT_SIMILAR_METHODS for IsEqualForObjects
gap> func := { cat, obj1, obj2 } -> IsEqualForObjects( obj1, obj2 );;
gap> cat := DummyCategory( rec( list_of_operations_to_install := [ "IsIsomorphicForObjects" ], properties := [ "IsSkeletalCategory" ] ) );;
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( cat );
gap> Display( CapJitCompiledFunction( func, cat, [ "category", "object", "object" ], "bool" ) );
function ( cat_1, obj1_1, obj2_1 )
    return IsIsomorphicForObjects( cat_1, obj1_1, obj2_1 );
end

#
gap> func := { cat, obj1, obj2 } -> IsEqualForObjects( cat, obj1, obj2 );;
gap> cat := DummyCategory( rec( list_of_operations_to_install := [ "IsIsomorphicForObjects" ], properties := [ "IsSkeletalCategory" ] ) );;
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( cat );
gap> Display( CapJitCompiledFunction( func, cat, [ "category", "object", "object" ], "bool" ) );
function ( cat_1, obj1_1, obj2_1 )
    return IsIsomorphicForObjects( cat_1, obj1_1, obj2_1 );
end

#
gap> CapJitDisableProofAssistantMode( );

#
gap> STOP_TEST( "CapJitResolvedOperations" );
