#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "ModulePresentationsForCAP", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true

ReadPackage( "LinearAlgebraForCAP", "gap/CompilerLogic.gi" );
#! true

homalg_field := DummyHomalgField( );;
commutative_homalg_ring := DummyCommutativeHomalgRing( );;
homalg_ring := DummyHomalgRing( );;

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
    [ #"AssociatorLeftToRightWithGivenTensorProducts",
      #"AssociatorRightToLeftWithGivenTensorProducts",
      #"BraidingWithGivenTensorProducts",
      #"CoevaluationMorphismWithGivenRange",
      #"Colift",
      #"ColiftOrFail",
      #"EvaluationMorphismWithGivenSource",
      #"InternalHomOnMorphismsWithGivenInternalHoms",
      #"InternalHomOnObjects",
      #"IsColiftable",
      #"IsLiftable",
      #"LeftUnitorWithGivenTensorProduct",
      #"Lift",
      #"LiftOrFail",
      "MultiplyWithElementOfCommutativeRingForMorphisms",
      #"RightUnitorWithGivenTensorProduct",
      #"TensorProductOnMorphismsWithGivenTensorProducts",
      #"TensorProductOnObjects",
      #"TensorUnit",
    ]
);;

precompile_LeftPresentations := function( ring, name, operations )
    
    CapJitPrecompileCategoryAndCompareResult(
        ring -> LeftPresentations_as_FreydCategory_CategoryOfRows( ring ),
        [ ring ],
        "ModulePresentationsForCAP",
        Concatenation(
            "LeftPresentations_as_FreydCategory_CategoryOfRows_",
            name,
            "_precompiled"
        ) :
        operations := operations
    ); end;;

precompile_LeftPresentations(
    homalg_field, "Field", operations_for_commutative_ring
);;
precompile_LeftPresentations(
    commutative_homalg_ring, "CommutativeRing", operations_for_commutative_ring
);;
precompile_LeftPresentations(
    homalg_ring, "ArbitraryRing", operations_for_arbitrary_ring
);;

precompile_RightPresentations := function( ring, name, operations )
    
    CapJitPrecompileCategoryAndCompareResult(
        ring -> RightPresentations_as_FreydCategory_CategoryOfColumns( ring ),
        [ ring ],
        "ModulePresentationsForCAP",
        Concatenation(
            "RightPresentations_as_FreydCategory_CategoryOfColumns_",
            name,
            "_precompiled"
        ) :
        operations := operations,
        number_of_objectified_objects_in_data_structure_of_object := 1,
        number_of_objectified_morphisms_in_data_structure_of_object := 0,
        number_of_objectified_objects_in_data_structure_of_morphism := 2,
        number_of_objectified_morphisms_in_data_structure_of_morphism := 1
    ); end;;

precompile_RightPresentations(
    homalg_field, "Field", operations_for_commutative_ring
);;
precompile_RightPresentations(
    commutative_homalg_ring, "CommutativeRing", operations_for_commutative_ring
);;
precompile_RightPresentations(
    homalg_ring, "ArbitraryRing", operations_for_arbitrary_ring
);;


LeftPresentations( homalg_field )!.precompiled_functions_added;
#! true

LeftPresentations( commutative_homalg_ring )!.precompiled_functions_added;
#! true

LeftPresentations( homalg_ring )!.precompiled_functions_added;
#! true

RightPresentations( homalg_field )!.precompiled_functions_added;
#! true

RightPresentations( commutative_homalg_ring )!.precompiled_functions_added;
#! true

RightPresentations( homalg_ring )!.precompiled_functions_added;
#! true

# put the letter 'V' here to work around
# https://github.com/frankluebeck/GAPDoc/pull/61

#! @EndExample
