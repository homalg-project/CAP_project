#! @Chapter Examples and tests

#! @Section Tests

#! @Example

#! #@if String({}->1-[1-1]) = "function (  ) return 1 - [ (1 - 1) ]; end"

LoadPackage( "FreydCategoriesForCAP", false );
#! true
ReadPackage( "FreydCategoriesForCAP",
    "gap/CategoryOfRows_as_AdditiveClosure_RingAsCategory_CompilerLogic.gi");
#! true

homalg_field := DummyHomalgField( );;
commutative_homalg_ring := DummyCommutativeHomalgRing( );;
homalg_ring := DummyHomalgRing( );;

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EQQxy := KoszulDualRing( QQxy );;

precompile_CategoryOfColumns := function( homalg_ring, name )
    
    CapJitPrecompileCategoryAndCompareResult(
        homalg_ring -> CategoryOfColumns(
            homalg_ring
        ),
        [ homalg_ring ],
        "FreydCategoriesForCAP",
        Concatenation(
            "CategoryOfColumns_as_Opposite_CategoryOfRows_",
            name,
            "_precompiled"
        ) :
        operations := "primitive",
        number_of_objectified_objects_in_data_structure_of_object := 1,
        number_of_objectified_morphisms_in_data_structure_of_object := 0,
        number_of_objectified_objects_in_data_structure_of_morphism := 2,
        number_of_objectified_morphisms_in_data_structure_of_morphism := 1
    ); end;;

precompile_CategoryOfColumns( homalg_field, "Field" );;
precompile_CategoryOfColumns( commutative_homalg_ring, "CommutativeRing" );;
precompile_CategoryOfColumns( EQQxy, "HomalgExteriorRingOverField" );;
precompile_CategoryOfColumns( homalg_ring, "ArbitraryRing" );;

CategoryOfColumns( homalg_field )!.precompiled_functions_added;
#! true
CategoryOfColumns( commutative_homalg_ring )!.precompiled_functions_added;
#! true
CategoryOfColumns( EQQxy )!.precompiled_functions_added;
#! true
CategoryOfColumns( homalg_ring )!.precompiled_functions_added;
#! true
#! #@fi

#! @EndExample
