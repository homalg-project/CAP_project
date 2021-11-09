#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "ModulePresentationsForCAP", false );
#! true

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EEE := KoszulDualRing( QQxy * "a,b" );;

# CAUTION: when adding new operations make sure that they are compatible
# with the ones added manually in `ADD_FUNCTIONS_FOR_LEFT/RIGHT_PRESENTATION`.
operations_for_arbitrary_ring := [
    "AdditionForMorphisms",
    "AdditiveInverseForMorphisms",
    #"AssociatorLeftToRightWithGivenTensorProducts",
    #"AssociatorRightToLeftWithGivenTensorProducts",
    #"BraidingWithGivenTensorProducts",
    #"CoevaluationMorphismWithGivenRange",
    "CokernelColiftWithGivenCokernelObject",
    "CokernelProjection",
    #"Colift",
    #"ColiftOrFail",
    "DirectSum",
    "EpimorphismFromSomeProjectiveObject",
    #"EvaluationMorphismWithGivenSource",
    "IdentityMorphism",
    "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
    #"InternalHomOnMorphismsWithGivenInternalHoms",
    #"InternalHomOnObjects",
    #"IsColiftable",
    "IsCongruentForMorphisms",
    "IsEqualForMorphisms",
    #"IsEqualForObjects",
    #"IsLiftable",
    #"IsWellDefinedForMorphisms",
    #"IsWellDefinedForObjects",
    "IsZeroForMorphisms",
    #"KernelEmbedding",
    #"LeftUnitorWithGivenTensorProduct",
    #"Lift",
    #"LiftAlongMonomorphism",
    #"LiftOrFail",
    #"MultiplyWithElementOfCommutativeRingForMorphisms",
    #"PreCompose",
    "ProjectionInFactorOfDirectSumWithGivenDirectSum",
    #"RightUnitorWithGivenTensorProduct",
    #"TensorProductOnMorphismsWithGivenTensorProducts",
    #"TensorProductOnObjects",
    #"TensorUnit",
    "UniversalMorphismFromDirectSumWithGivenDirectSum",
    "UniversalMorphismFromZeroObjectWithGivenZeroObject",
    "UniversalMorphismIntoDirectSumWithGivenDirectSum",
    "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
    "ZeroMorphism",
    "ZeroObject" 
];;

operations_for_commutative_ring := Concatenation(
    operations_for_arbitrary_ring,
    [ "MultiplyWithElementOfCommutativeRingForMorphisms" ]
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
        operations := operations
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
        operations := operations
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


# check that the compiled code is loaded automatically
# for this, we use the name of the argument of `ZeroObject`:
# for non-compiled code it is "cat", while for compiled code it is "cat_1"

cat := LeftPresentations( QQ );;
NamesLocalVariablesFunction( Last( cat!.added_functions.ZeroObject )[1] )[1]
    = "cat_1";
#! true

cat := LeftPresentations( QQxy );;
NamesLocalVariablesFunction( Last( cat!.added_functions.ZeroObject )[1] )[1]
    = "cat_1";
#! true

cat := LeftPresentations( EEE );;
NamesLocalVariablesFunction( Last( cat!.added_functions.ZeroObject )[1] )[1]
    = "cat_1";
#! true

cat := RightPresentations( QQ );;
NamesLocalVariablesFunction( Last( cat!.added_functions.ZeroObject )[1] )[1]
    = "cat_1";
#! true

cat := RightPresentations( QQxy );;
NamesLocalVariablesFunction( Last( cat!.added_functions.ZeroObject )[1] )[1]
    = "cat_1";
#! true

cat := RightPresentations( EEE );;
NamesLocalVariablesFunction( Last( cat!.added_functions.ZeroObject )[1] )[1]
    = "cat_1";
#! true


#! @EndExample
