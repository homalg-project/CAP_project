#! @Chapter Examples and tests

#! @Section Examples

#! @Example

#! #@if String({}->1-[1-1]) = "function (  ) return 1 - [ (1 - 1) ]; end"

LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

ReadPackage( "LinearAlgebraForCAP", "gap/CompilerLogic.gi" );
#! true

CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER := 1;;
homalg_field := DummyHomalgField( );;

category_constructor := field -> MatrixCategory_as_CategoryOfRows( field );;
given_arguments := [ homalg_field ];;
compiled_category_name := "MatrixCategory_precompiled";;
package_name := "LinearAlgebraForCAP";;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    number_of_objectified_objects_in_data_structure_of_object := 1,
    number_of_objectified_morphisms_in_data_structure_of_object := 0,
    number_of_objectified_objects_in_data_structure_of_morphism := 2,
    number_of_objectified_morphisms_in_data_structure_of_morphism := 1
);;

MatrixCategory_precompiled( homalg_field );
#! Category of matrices over Dummy homalg field 1

MatrixCategory( homalg_field )!.precompiled_functions_added;
#! true
#! #@fi

#! @EndExample
