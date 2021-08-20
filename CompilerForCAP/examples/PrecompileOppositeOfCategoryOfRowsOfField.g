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
operations := Intersection(
    ListPrimitivelyInstalledOperationsOfCategory( CategoryOfColumns( QQ ) ),
    CAP_JIT_INTERNAL_SAFE_OPERATIONS
);;
operations := Filtered(
    operations,
    o -> PositionSublist( o, "HomomorphismStructure" ) = fail
);;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := operations
);;

#! @EndExample
