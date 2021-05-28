#! @Chapter Examples and tests

#! @Section Examples

LoadPackage( "LinearAlgebraForCAP" );

#! @Example

QQ := HomalgFieldOfRationals( );;

# be careful not to use `MatrixCategory` because attributes are not supported
category_constructor := field -> MATRIX_CATEGORY( field );;
given_arguments := [ QQ ];;
compiled_category_name := "MatrixCategoryPrecompiled";;
package_name := "LinearAlgebraForCAP";;
operations := Intersection(
    ListInstalledOperationsOfCategory( category_constructor( QQ ) ),
    CAP_JIT_INTERNAL_SAFE_OPERATIONS
);;
# exclude some operations which currently do not yield nice results
operations := Filtered( operations,
                        o -> PositionSublist( o, "FiberProduct" ) = fail );;
operations := Filtered( operations,
                        o -> PositionSublist( o, "Pushout" ) = fail );;
operations := Filtered( operations,
                        o -> PositionSublist( o, "Image" ) = fail );;
operations := Filtered( operations,
                        o -> PositionSublist( o, "Coimage" ) = fail );;
operations := Filtered( operations,
                        o -> PositionSublist( o, "DirectProduct" ) = fail );;
operations := Filtered( operations,
                        o -> PositionSublist( o, "Coproduct" ) = fail );;
operations := Filtered( operations,
                        o -> PositionSublist( o, "TerminalObject" ) = fail );;
operations := Filtered( operations,
                        o -> PositionSublist( o, "InitialObject" ) = fail );;
operations := Difference( operations, [ "DirectSumCodiagonalDifference" ] );;
operations := Difference( operations, [ "DirectSumDiagonalDifference" ] );;
operations := Difference( operations, [ "HomologyObject" ] );;
# IsEqualForMorphismsOnMor causes problems in GAP 4.11 (see GAP issue #4449)
operations := Difference( operations, [ "IsEqualForMorphismsOnMor" ] );;
operations := Difference( operations, [ "IsIdenticalToIdentityMorphism" ] );;
operations := Difference( operations, [ "IsIdenticalToZeroMorphism" ] );;
# IsZeroForMorphisms tries to resolve IsZero and IsZero has a new
# installation in GAP 4.12, so this causes slight differences in the output
operations := Difference( operations, [ "IsZeroForMorphisms" ] );;
Add( operations, "DirectSumFunctorialWithGivenDirectSums" );

filepath := "precompiled_categories/MatrixCategoryPrecompiled.gi";;
old_file_content := ReadFileFromPackageForHomalg( package_name, filepath );;

# set CAP_JIT_INTERNAL_FUNCTION_ID and
# CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER
# to known values for a stable output
CAP_JIT_INTERNAL_FUNCTION_ID < 10000;
#! true
CAP_JIT_INTERNAL_FUNCTION_ID := 10000;;

CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER < 10000;
#! true
CAP_JIT_INTERNAL_INLINED_FUNCTION_COUNTER := 10000;;

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

MatrixCategoryPrecompiled( QQ );
#! Category of matrices over Q

#! @EndExample
