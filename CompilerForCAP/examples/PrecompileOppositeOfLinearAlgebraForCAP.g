#! @Chapter Examples and tests

#! @Section Tests

LoadPackage( "LinearAlgebraForCAP" );

#! @Example

QQ := HomalgFieldOfRationals( );;

# be careful not to use `MatrixCategory` because attributes are not supported
category_constructor := function( field )
  return Opposite( MATRIX_CATEGORY( field : FinalizeCategory := true ) ); end;;

vec := MATRIX_CATEGORY( QQ : no_precompiled_code := true );;

given_arguments := [ QQ ];;
compiled_category_name := "OppositeOfMatrixCategoryPrecompiled";;
package_name := "LinearAlgebraForCAP";;
operations := Intersection(
    ListPrimitivelyInstalledOperationsOfCategory( vec ),
    CAP_JIT_INTERNAL_SAFE_OPERATIONS
);;
# The output for Lift/ColiftOrFail differs between GAP 4.11 and GAP 4.12, see
# https://github.com/gap-system/gap/issues/4523
operations := Difference( operations, [ "LiftOrFail", "ColiftOrFail" ] );;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := operations
);;

ReadPackage(
    "LinearAlgebraForCAP",
    "gap/precompiled_categories/OppositeOfMatrixCategoryPrecompiled.gi"
);;
OppositeOfMatrixCategoryPrecompiled( QQ );
#! Opposite of Category of matrices over Q

#! @EndExample
