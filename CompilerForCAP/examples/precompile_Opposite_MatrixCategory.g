#! @Chapter Examples and tests

#! @Section Tests

#! @Example

#! #@if String({}->1-[1-1]) = "function (  ) return 1 - [ (1 - 1) ]; end"

LoadPackage( "LinearAlgebraForCAP", false );
#! true
LoadPackage( "RingsForHomalg", false );
#! true

CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER := 1;;
homalg_field := DummyHomalgField( );;

category_constructor := function( field )
    return Opposite(
        MatrixCategory(
            field :
            no_precompiled_code := false, FinalizeCategory := true
        ) :
        only_primitive_operations := true
    ); end;;

given_arguments := [ homalg_field ];;
compiled_category_name := "Opposite_MatrixCategory_precompiled";;
package_name := "LinearAlgebraForCAP";;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := "primitive",
    number_of_objectified_objects_in_data_structure_of_object := 2,
    number_of_objectified_morphisms_in_data_structure_of_object := 0,
    number_of_objectified_objects_in_data_structure_of_morphism := 6,
    number_of_objectified_morphisms_in_data_structure_of_morphism := 2
);;

ReadPackage(
    "LinearAlgebraForCAP",
    "gap/precompiled_categories/Opposite_MatrixCategory_precompiled.gi"
);;
Opposite_MatrixCategory_precompiled( homalg_field );
#! Opposite( Category of matrices over Dummy homalg field 1 )
#! #@fi

#! @EndExample
