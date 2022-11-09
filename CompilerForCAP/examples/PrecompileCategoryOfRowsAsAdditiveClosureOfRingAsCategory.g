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

precompile_CategoryOfRows := function( homalg_ring, name )
    
    CapJitPrecompileCategoryAndCompareResult(
        homalg_ring -> CategoryOfRows(
            homalg_ring
        ),
        [ homalg_ring ],
        "FreydCategoriesForCAP",
        Concatenation(
            "CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOf",
            name,
            "Precompiled"
        ) :
        operations := "primitive",
        number_of_objectified_objects_in_data_structure_of_object := 1,
        number_of_objectified_morphisms_in_data_structure_of_object := 0,
        number_of_objectified_objects_in_data_structure_of_morphism := 2,
        number_of_objectified_morphisms_in_data_structure_of_morphism := 1
    ); end;;

precompile_CategoryOfRows( QQ, "Field" );;
precompile_CategoryOfRows( QQxy, "CommutativeRing" );;
precompile_CategoryOfRows( EQQxy, "HomalgExteriorRingOverField" );;
precompile_CategoryOfRows( R, "ArbitraryRing" );;

CategoryOfRows( QQ )!.precompiled_functions_added;
#! true
CategoryOfRows( QQxy )!.precompiled_functions_added;
#! true
CategoryOfRows( EQQxy )!.precompiled_functions_added;
#! true
CategoryOfRows( R )!.precompiled_functions_added;
#! true

#! @EndExample
