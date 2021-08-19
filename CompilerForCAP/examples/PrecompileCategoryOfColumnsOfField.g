#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true

QQ := HomalgFieldOfRationals( );;

category_constructor :=
    field -> CategoryOfColumns( field );;
given_arguments := [ QQ ];;
compiled_category_name := "CategoryOfColumnsOfFieldPrecompiled";;
package_name := "FreydCategoriesForCAP";;
operations := Intersection(
    ListPrimitivelyInstalledOperationsOfCategory( CategoryOfColumns( QQ ) ),
    CAP_JIT_INTERNAL_SAFE_OPERATIONS
);;
operations := Filtered(
    operations,
    o -> PositionSublist( o, "HomomorphismStructure" ) = fail
);;

filepath :=
    "precompiled_categories/CategoryOfColumnsOfFieldPrecompiled.gi";;
old_file_content := ReadFileFromPackageForHomalg( package_name, filepath );;

CapJitPrecompileCategory(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := operations
);

new_file_content := ReadFileFromPackageForHomalg( package_name, filepath );;

old_file_content = new_file_content;
#! true

#! @EndExample
