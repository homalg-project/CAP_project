#! @Chapter Examples and tests

#! @Section Examples

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

ReadPackage( "LinearAlgebraForCAP", "gap/CompilerLogic.gi" );
#! true

QQ := HomalgFieldOfRationals( );;

category_constructor := field -> MatrixCategoryAsCategoryOfRows( field );;
given_arguments := [ QQ ];;
compiled_category_name := "MatrixCategoryPrecompiled";;
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

MatrixCategoryPrecompiled( QQ );
#! Category of matrices over Q

MatrixCategory( QQ )!.precompiled_functions_added;
#! true

#! @EndExample
