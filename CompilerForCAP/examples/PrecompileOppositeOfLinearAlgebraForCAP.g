#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "LinearAlgebraForCAP" );

#! @Example

QQ := HomalgFieldOfRationals( );;

# be careful not to use `MatrixCategory` because attributes are not supported
category_constructor := function( field )
    
    return Opposite( MATRIX_CATEGORY(
        field :
        FinalizeCategory := true,
        enable_compilation := false
    ) ); end;;

given_arguments := [ QQ ];;
compiled_category_name := "OppositeOfMatrixCategoryPrecompiled";;
package_name := "LinearAlgebraForCAP";;
operations := Intersection(
    ListPrimitivelyInstalledOperationsOfCategory( MatrixCategory( QQ ) ),
    CAP_JIT_INTERNAL_SAFE_OPERATIONS
);;
# The output for Lift/ColiftOrFail differs between GAP 4.11 and GAP 4.12, see
# https://github.com/gap-system/gap/issues/4523
operations := Difference( operations, [ "LiftOrFail", "ColiftOrFail" ] );;

filepath := "precompiled_categories/OppositeOfMatrixCategoryPrecompiled.gi";;
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

ReadPackage(
    "LinearAlgebraForCAP",
    "gap/precompiled_categories/OppositeOfMatrixCategoryPrecompiled.gi"
);;
OppositeOfMatrixCategoryPrecompiled( QQ );
#! Opposite of Category of matrices over Q

#! @EndExample
