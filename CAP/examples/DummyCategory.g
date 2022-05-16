#! @Chapter Examples and Tests

#! @Section Dummy category

#! @Example

LoadPackage( "CAP", false );
#! true

dummy := DummyCategory( rec(
    list_of_operations_to_install := [ "PreCompose", "IdentityMorphism", "DirectSum" ],
    properties := [ "IsAdditiveCategory" ],
) );;

CanCompute( dummy, "DirectSum" );
#! true
IsAdditiveCategory( dummy );
#! true

#! @EndExample
