#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "LinearAlgebraForCAP", false );
#! true

Q := HomalgFieldOfRationals( );;
vec := MATRIX_CATEGORY( Q : no_precompiled_code );;

func := cat -> ZeroObjectFunctorial( cat );;

StopCompilationAtCategory( vec );

Display( CapJitCompiledFunction( func, vec ) );
#! function ( cat_1 )
#!     return ZeroObjectFunctorial( cat_1 );
#! end

ContinueCompilationAtCategory( vec );

Display( CapJitCompiledFunction( func, vec ) );
#! function ( cat_1 )
#!     local morphism_attr_1_1, deduped_2_1;
#!     deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
#!            ), cat_1, Dimension, 0 );
#!     morphism_attr_1_1 
#!      := HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) );
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes
#!         ( rec(
#!            ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, 
#!        morphism_attr_1_1 );
#! end

vec := MATRIX_CATEGORY( Q : no_precompiled_code );;

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( vec );

Display( CapJitCompiledFunction( func, vec ) );
#! WARNING: Could not find declaration of ZeroObject (current input: \
#! [ <Category "IsMatrixCategory"> ])
#! WARNING: Could not find declaration of ZeroObject (current input: \
#! [ <Category "IsMatrixCategory"> ])
#! WARNING: Could not find declaration of ZeroObject (current input: \
#! [ <Category "IsMatrixCategory"> ])
#! function ( cat_1 )
#!     local deduped_1_1;
#!     deduped_1_1 := ZeroObject( cat_1 );
#!     return ZeroMorphism( cat_1, deduped_1_1, deduped_1_1 );
#! end

ContinueCompilationAtPrimitivelyInstalledOperationsOfCategory( vec );

Display( CapJitCompiledFunction( func, vec ) );
#! function ( cat_1 )
#!     local morphism_attr_1_1, deduped_2_1;
#!     deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
#!            ), cat_1, Dimension, 0 );
#!     morphism_attr_1_1 
#!      := HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) );
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes
#!         ( rec(
#!            ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, 
#!        morphism_attr_1_1 );
#! end

#! @EndExample
