gap> START_TEST( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> dummy := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "IdentityMorphism",
>     ],
> ) : FinalizeCategory := false );;

#
gap> AddIsProjective( dummy, ReturnTrue );

#
gap> Finalize( dummy );;

#
gap> Display( CapJitCompiledFunction(
>     { cat, obj } -> IsProjective( cat, obj ),
>     dummy
> ) );
function ( cat_1, obj_1 )
    return RETURN_TRUE( cat_1, obj_1 );
end

#
gap> STOP_TEST( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree" );
