#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "AdditiveClosuresForCAP", false );
#! true
ReadPackage( "AdditiveClosuresForCAP",
    "gap/CategoryOfRows_as_AdditiveClosure_RingAsCategory_CompilerLogic.gi");
#! true

homalg_field := DummyHomalgField( );;
commutative_homalg_ring := DummyCommutativeHomalgRing( );;
homalg_ring := DummyHomalgRing( );;

QQ := HomalgFieldOfRationalsInSingular( );;
QQxy := QQ * "x,y";;
EQQxy := KoszulDualRing( QQxy );;

precompile_CategoryOfRows := function( homalg_ring, name )
    
    CapJitPrecompileCategoryAndCompareResult(
        homalg_ring -> CategoryOfRows(
            homalg_ring
        ),
        [ homalg_ring ],
        "AdditiveClosuresForCAP",
        Concatenation(
            "CategoryOfRows_as_AdditiveClosure_RingAsCategory_",
            name,
            "_precompiled"
        ) :
        operations := "primitive",
        number_of_objectified_objects_in_data_structure_of_object := 1,
        number_of_objectified_morphisms_in_data_structure_of_object := 0,
        number_of_objectified_objects_in_data_structure_of_morphism := 2,
        number_of_objectified_morphisms_in_data_structure_of_morphism := 1
    ); end;;

precompile_CategoryOfRows( homalg_field, "Field" );;
precompile_CategoryOfRows( commutative_homalg_ring, "CommutativeRing" );;
precompile_CategoryOfRows( EQQxy, "HomalgExteriorRingOverField" );;
precompile_CategoryOfRows( homalg_ring, "ArbitraryRing" );;

CategoryOfRows( homalg_field )!.precompiled_functions_added;
#! true
CategoryOfRows( commutative_homalg_ring )!.precompiled_functions_added;
#! true
CategoryOfRows( EQQxy )!.precompiled_functions_added;
#! true
CategoryOfRows( homalg_ring )!.precompiled_functions_added;
#! true

#! @EndExample
