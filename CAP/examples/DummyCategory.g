#! @Chapter Examples and Tests

#! @Section Dummy implementations

#! @Subsection Dummy categories

#! @Example

LoadPackage( "CAP", false );
#! true

list_of_operations_to_install := [
    "ObjectConstructor",
    "MorphismConstructor",
    "ObjectDatum",
    "MorphismDatum",
    "IsCongruentForMorphisms",
    "PreCompose",
    "IdentityMorphism",
    "DirectSum",
];;

dummy := DummyCategory( rec(
    list_of_operations_to_install := list_of_operations_to_install,
    properties := [ "IsAdditiveCategory" ],
) );;

ForAll( list_of_operations_to_install, o -> CanCompute( dummy, o ) );
#! true
IsAdditiveCategory( dummy );
#! true

#! @EndExample
