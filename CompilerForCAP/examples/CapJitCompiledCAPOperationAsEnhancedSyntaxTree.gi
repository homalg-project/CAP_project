#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IdentityMorphism",
    ],
) : FinalizeCategory := false );;

AddIsProjective( dummy, ReturnTrue );

Finalize( dummy );;

Display( CapJitCompiledFunction(
    { cat, obj } -> IsProjective( cat, obj ),
    dummy
) );
#! function ( cat_1, obj_1 )
#!     return RETURN_TRUE( cat_1, obj_1 );
#! end

#! @EndExample
