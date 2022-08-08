#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        # general category
        "PreCompose",
        "IdentityMorphism",
        "IsEqualForMorphisms",
        "IsEqualForMorphismsOnMor",
        "IsWellDefinedForMorphisms",
        
        # computable
        "IsCongruentForMorphisms",
        
        # pre-additive
        "AdditionForMorphisms",
        "SubtractionForMorphisms",
        "AdditiveInverseForMorphisms",
        "ZeroMorphism",
        
        # with zero object
        "ZeroObject",
        "UniversalMorphismIntoZeroObject",
        "UniversalMorphismFromZeroObject",
        "ZeroObjectFunctorial",
        
        # additive
        "DirectSum",
        "DirectSumFunctorial",
        "ProjectionInFactorOfDirectSum",
        "UniversalMorphismIntoDirectSum",
        "InjectionOfCofactorOfDirectSum",
        "UniversalMorphismFromDirectSum",
        
        # colifts
        "IsColiftable"
    ],
    properties := [
        "IsAdditiveCategory",
    ],
) );;

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

CapJitPrecompileCategoryAndCompareResult(
    underlying_category -> CoFreydCategoryAsOppositeOfFreydCategoryOfOpposite(
        underlying_category
    ),
    [ dummy ],
    "FreydCategoriesForCAP",
    "CoFreydCategoryAsOppositeOfFreydCategoryOfOppositePrecompiled" :
    operations := "primitive",
    number_of_objectified_objects_in_data_structure_of_object := 1,
    number_of_objectified_morphisms_in_data_structure_of_object := 0,
    number_of_objectified_objects_in_data_structure_of_morphism := 2,
    number_of_objectified_morphisms_in_data_structure_of_morphism := 1
);

#! @EndExample
