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
# IsZeroForMorphisms tries to resolve IsZero and IsZero has a new
# installation in GAP 4.12, so this causes slight differences in the output
operations := Difference( operations, [ "IsZeroForMorphisms" ] );;
# The output for Lift and Colift differs between GAP 4.11 and GAP 4.12, see
# https://github.com/gap-system/gap/issues/4523
operations := Difference( operations, [ "Lift", "Colift" ] );;

filepath := "precompiled_categories/OppositeOfMatrixCategoryPrecompiled.gi";;
old_file_content := ReadFileFromPackageForHomalg( package_name, filepath );;

# set CAP_JIT_INTERNAL_FUNCTION_ID and
# CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER
# to known values for a stable output
CAP_JIT_INTERNAL_FUNCTION_ID < 20000;
#! true
CAP_JIT_INTERNAL_FUNCTION_ID := 20000;;

CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER < 20000;
#! true
CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER := 20000;;

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
