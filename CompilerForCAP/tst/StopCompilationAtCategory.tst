gap> START_TEST( "StopCompilationAtCategory" );

#
gap> LoadPackage( "FreydCategoriesForCAP", false );
true

#
gap> QQ := HomalgFieldOfRationals( );;
gap> vec := CategoryOfRows( QQ : no_precompiled_code );;

#
gap> func := cat -> ZeroObjectFunctorial( cat );;

#
gap> StopCompilationAtCategory( vec );

#
gap> Display( CapJitCompiledFunction( func, vec ) );
function ( cat_1 )
    return ZeroObjectFunctorial( cat_1 );
end

#
gap> ContinueCompilationAtCategory( vec );

#
gap> Display( CapJitCompiledFunction( func, vec ) );
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, 
       RankOfObject, 0 );
    morphism_attr_1_1 := HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, 
       deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end

#
gap> vec := CategoryOfRows( QQ : no_precompiled_code );;

#
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( vec );

#
gap> Display( CapJitCompiledFunction( func, vec ) );
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ZeroObject( cat_1 );
    return ZeroMorphism( cat_1, deduped_1_1, deduped_1_1 );
end

#
gap> ContinueCompilationAtPrimitivelyInstalledOperationsOfCategory( vec );

#
gap> Display( CapJitCompiledFunction( func, vec ) );
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, 
       RankOfObject, 0 );
    morphism_attr_1_1 := HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, 
       deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end

#
gap> STOP_TEST( "StopCompilationAtCategory" );
