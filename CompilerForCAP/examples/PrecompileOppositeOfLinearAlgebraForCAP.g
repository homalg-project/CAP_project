#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "LinearAlgebraForCAP" );

#! @Example

QQ := HomalgFieldOfRationals( );;

# be careful not to use `MatrixCategory` because attributes are not supported
category_constructor := function( field )
    return Opposite(
        MATRIX_CATEGORY(
            field :
            no_precompiled_code := true, FinalizeCategory := true
        ) :
        only_primitive_operations := true
    ); end;;

given_arguments := [ QQ ];;
compiled_category_name := "OppositeOfMatrixCategoryPrecompiled";;
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
    "gap/precompiled_categories/OppositeOfMatrixCategoryPrecompiled.gi"
);;
OppositeOfMatrixCategoryPrecompiled( QQ );
#! Opposite of Category of matrices over Q

#! @EndExample
