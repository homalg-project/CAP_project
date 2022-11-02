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

precompile_CategoryOfColumns := function( homalg_ring, name )
    
    CapJitPrecompileCategoryAndCompareResult(
        homalg_ring -> CategoryOfColumnsAsOppositeOfCategoryOfRows(
            homalg_ring
        ),
        [ homalg_ring ],
        "FreydCategoriesForCAP",
        Concatenation(
            "CategoryOfColumnsAsOppositeOfCategoryOfRowsOf",
            name,
            "Precompiled"
        ) :
        operations := "primitive",
        number_of_objectified_objects_in_data_structure_of_object := 1,
        number_of_objectified_morphisms_in_data_structure_of_object := 0,
        number_of_objectified_objects_in_data_structure_of_morphism := 2,
        number_of_objectified_morphisms_in_data_structure_of_morphism := 1
    ); end;;

precompile_CategoryOfColumns( QQ, "Field" );;
precompile_CategoryOfColumns( QQxy, "CommutativeRing" );;
precompile_CategoryOfColumns( EQQxy, "HomalgExteriorRingOverField" );;
precompile_CategoryOfColumns( R, "ArbitraryRing" );;

CategoryOfColumns( QQ )!.precompiled_functions_added;
#! true
CategoryOfColumns( QQxy )!.precompiled_functions_added;
#! true
CategoryOfColumns( EQQxy )!.precompiled_functions_added;
#! true
CategoryOfColumns( R )!.precompiled_functions_added;
#! true

#! @EndExample
