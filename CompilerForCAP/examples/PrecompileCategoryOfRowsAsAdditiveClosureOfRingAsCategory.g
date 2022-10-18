#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true
ReadPackage( "FreydCategoriesForCAP",
    "gap/CategoryOfRowsAsAdditiveClosureOfRingAsCategory_CompilerLogic.gi");
#! true

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EQQxy := KoszulDualRing( QQxy );;
R := KoszulDualRing( HomalgRingOfIntegersInSingular( ) * "x,y" );;

hom_structure_operations := [
    "DistinguishedObjectOfHomomorphismStructure",
    "HomomorphismStructureOnObjects",
    "HomomorphismStructureOnMorphismsWithGivenObjects",
    Concatenation(
        "InterpretMorphismAsMorphismFromDistinguishedObject",
        "ToHomomorphismStructureWithGivenObjects"
    ),
    Concatenation(
        "InterpretMorphismFromDistinguishedObject",
        "ToHomomorphismStructureAsMorphism"
    ),
];;

precompile_CategoryOfRows := function( homalg_ring, name, operations )
    
    CapJitPrecompileCategoryAndCompareResult(
        homalg_ring -> CategoryOfRowsAsAdditiveClosureOfRingAsCategory(
            homalg_ring
        ),
        [ homalg_ring ],
        "FreydCategoriesForCAP",
        Concatenation(
            "CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOf",
            name,
            "Precompiled"
        ) :
        operations := operations,
        number_of_objectified_objects_in_data_structure_of_object := 1,
        number_of_objectified_morphisms_in_data_structure_of_object := 0,
        number_of_objectified_objects_in_data_structure_of_morphism := 2,
        number_of_objectified_morphisms_in_data_structure_of_morphism := 1
    ); end;;


precompile_CategoryOfRows(
    QQ, "Field", hom_structure_operations
);;
precompile_CategoryOfRows(
    QQxy, "CommutativeRing", hom_structure_operations
);;
precompile_CategoryOfRows(
    EQQxy, "HomalgExteriorRingOverField", hom_structure_operations
);;
precompile_CategoryOfRows(
    R, "ArbitraryRing", [ ]
);;

#! @EndExample
