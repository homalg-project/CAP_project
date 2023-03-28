#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "ModulePresentationsForCAP", false );
#! true

ReadPackage( "LinearAlgebraForCAP", "gap/CompilerLogic.gi" );
#! true

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EEE := KoszulDualRing( QQxy * "a,b" );;

# CAUTION: when adding new operations make sure that they are compatible
# with the ones added manually in `ADD_FUNCTIONS_FOR_LEFT/RIGHT_PRESENTATION`.
operations_for_arbitrary_ring := [
    "AdditionForMorphisms",
    "AdditiveInverseForMorphisms",
    "CokernelColiftWithGivenCokernelObject",
    "CokernelProjection",
    "DirectSum",
    "EpimorphismFromSomeProjectiveObject",
    "IdentityMorphism",
    "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
    "IsCongruentForMorphisms",
    "IsEqualForMorphisms",
    "IsEqualForObjects",
    #"IsWellDefinedForMorphisms",
    #"IsWellDefinedForObjects",
    "IsZeroForMorphisms",
    #"KernelEmbedding",
    #"LiftAlongMonomorphism",
    "PreCompose",
    "ProjectionInFactorOfDirectSumWithGivenDirectSum",
    "UniversalMorphismFromDirectSumWithGivenDirectSum",
    "UniversalMorphismFromZeroObjectWithGivenZeroObject",
    "UniversalMorphismIntoDirectSumWithGivenDirectSum",
    "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
    "ZeroMorphism",
    "ZeroObject",
];;

operations_for_commutative_ring := Concatenation(
    operations_for_arbitrary_ring,
    [ "AssociatorLeftToRightWithGivenTensorProducts",
      "AssociatorRightToLeftWithGivenTensorProducts",
      "BraidingWithGivenTensorProducts",
      "CoevaluationMorphismWithGivenRange",
      #"Colift",
      #"ColiftOrFail",
      "EvaluationMorphismWithGivenSource",
      "InternalHomOnMorphismsWithGivenInternalHoms",
      "InternalHomOnObjects",
      #"IsColiftable",
      #"IsLiftable",
      "LeftUnitorWithGivenTensorProduct",
      #"Lift",
      #"LiftOrFail",
      "MultiplyWithElementOfCommutativeRingForMorphisms",
      "RightUnitorWithGivenTensorProduct",
      "TensorProductOnMorphismsWithGivenTensorProducts",
      "TensorProductOnObjects",
      "TensorUnit",
    ]
);;

precompile_LeftPresentations := function( ring, name, operations )
    
    CapJitPrecompileCategoryAndCompareResult(
        ring -> LeftPresentationsAsFreydCategoryOfCategoryOfRows( ring ),
        [ ring ],
        "ModulePresentationsForCAP",
        Concatenation(
            "LeftPresentationsAsFreydCategoryOfCategoryOfRowsOf",
            name,
            "Precompiled"
        ) :
        operations := "InternalHomOnMorphismsWithGivenInternalHoms",
        number_of_objectified_objects_in_data_structure_of_object := 1,
        number_of_objectified_morphisms_in_data_structure_of_object := 0,
        number_of_objectified_objects_in_data_structure_of_morphism := 2,
        number_of_objectified_morphisms_in_data_structure_of_morphism := 1
    ); end;;

precompile_LeftPresentations(
    QQ, "Field", operations_for_commutative_ring
);;
precompile_LeftPresentations(
    QQxy, "CommutativeRing", operations_for_commutative_ring
);;
precompile_LeftPresentations(
    EEE, "ArbitraryRing", operations_for_arbitrary_ring
);;

precompile_RightPresentations := function( ring, name, operations )
    
    CapJitPrecompileCategoryAndCompareResult(
        ring -> RightPresentationsAsFreydCategoryOfCategoryOfColumns( ring ),
        [ ring ],
        "ModulePresentationsForCAP",
        Concatenation(
            "RightPresentationsAsFreydCategoryOfCategoryOfColumnsOf",
            name,
            "Precompiled"
        ) :
        operations := "InternalHomOnMorphismsWithGivenInternalHoms",
        number_of_objectified_objects_in_data_structure_of_object := 1,
        number_of_objectified_morphisms_in_data_structure_of_object := 0,
        number_of_objectified_objects_in_data_structure_of_morphism := 2,
        number_of_objectified_morphisms_in_data_structure_of_morphism := 1
    ); end;;

precompile_RightPresentations(
    QQ, "Field", operations_for_commutative_ring
);;
precompile_RightPresentations(
    QQxy, "CommutativeRing", operations_for_commutative_ring
);;
precompile_RightPresentations(
    EEE, "ArbitraryRing", operations_for_arbitrary_ring
);;


LeftPresentations( QQ )!.precompiled_functions_added;
#! true

LeftPresentations( QQxy )!.precompiled_functions_added;
#! true

LeftPresentations( EEE )!.precompiled_functions_added;
#! true

RightPresentations( QQ )!.precompiled_functions_added;
#! true

RightPresentations( QQxy )!.precompiled_functions_added;
#! true

RightPresentations( EEE )!.precompiled_functions_added;
#! true

# put the letter 'V' here to work around
# https://github.com/frankluebeck/GAPDoc/pull/61

#! @EndExample
