#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true

QQ := HomalgFieldOfRationals( );;

category_constructor :=
    field -> CategoryOfColumnsAsOppositeOfCategoryOfRows( field );;
given_arguments := [ QQ ];;
compiled_category_name := "OppositeOfCategoryOfRowsOfFieldPrecompiled";;
package_name := "FreydCategoriesForCAP";;
operations := "primitive";;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := operations
);;

#! @EndExample
