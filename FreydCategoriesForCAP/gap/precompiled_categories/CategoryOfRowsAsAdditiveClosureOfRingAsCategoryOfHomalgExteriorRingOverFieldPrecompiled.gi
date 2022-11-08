# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfHomalgExteriorRingOverFieldPrecompiled", function ( cat )
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, 1 );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, Sum( ListWithIdenticalEntries( RankOfObject( arg2_1 ) * RankOfObject( arg3_1 ), Length( GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    local hoisted_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingMatrix( beta_1 );
    deduped_5_1 := ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 );
    deduped_4_1 := UnderlyingMatrix( alpha_1 );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := RangeCategoryOfHomomorphismStructure( cat_1 );
    hoisted_1_1 := deduped_3_1;
    return CreateCapCategoryMorphismWithAttributes( deduped_2_1, source_1, range_1, UnderlyingMatrix, CoercedMatrix( deduped_3_1, UnderlyingRing( deduped_2_1 ), CoefficientsWithGivenMonomials( KroneckerMat( TransposedMatrix( deduped_4_1 ), DualKroneckerMat( UnionOfRows( deduped_3_1, NumberColumns( deduped_5_1 ), List( GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 ), function ( generator_2 )
                        return COMPILATION_HELPER_HomalgMatrixFromRingElement( generator_2, hoisted_1_1 );
                    end ) ), deduped_6_1 ) ), DiagMat( deduped_3_1, ListWithIdenticalEntries( NumberRows( deduped_4_1 ), DiagMat( deduped_3_1, ListWithIdenticalEntries( NumberColumns( deduped_6_1 ), deduped_5_1 ) ) ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := RangeCategoryOfHomomorphismStructure( cat_1 );
    return CreateCapCategoryMorphismWithAttributes( deduped_1_1, source_1, range_1, UnderlyingMatrix, CoercedMatrix( deduped_2_1, UnderlyingRing( deduped_1_1 ), CoefficientsWithGivenMonomials( ConvertMatrixToRow( deduped_3_1 ), DiagMat( deduped_2_1, ListWithIdenticalEntries( NumberRows( deduped_3_1 ), DiagMat( deduped_2_1, ListWithIdenticalEntries( NumberColumns( deduped_3_1 ), ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 ) ) ) ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := RankOfObject( arg3_1 );
    deduped_9_1 := RankOfObject( arg2_1 );
    deduped_8_1 := [ 1 .. deduped_9_1 ];
    hoisted_7_1 := ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 );
    hoisted_6_1 := RingInclusionForHomomorphismStructure( cat_1 );
    hoisted_5_1 := UnderlyingMatrix( arg4_1 );
    hoisted_4_1 := Length( GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 ) );
    hoisted_3_1 := [ 1 .. deduped_10_1 ];
    hoisted_2_1 := deduped_10_1;
    hoisted_1_1 := deduped_8_1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg3_1, UnderlyingMatrix, HomalgMatrixListList( List( deduped_8_1, function ( logic_new_func_x_2 )
                local hoisted_1_2;
                hoisted_1_2 := hoisted_2_1 * (CAP_JIT_INCOMPLETE_LOGIC( hoisted_1_1[logic_new_func_x_2] ) - 1);
                return List( hoisted_3_1, function ( logic_new_func_x_3 )
                        local deduped_1_3;
                        deduped_1_3 := Sum( ListWithIdenticalEntries( hoisted_1_2 + CAP_JIT_INCOMPLETE_LOGIC( hoisted_3_1[logic_new_func_x_3] ) - 1, hoisted_4_1 ) ) + 1;
                        return EntriesOfHomalgMatrix( Pullback( hoisted_6_1, CertainColumns( hoisted_5_1, [ deduped_1_3 .. (deduped_1_3 - 1 + hoisted_4_1) ] ) ) * hoisted_7_1 )[1];
                    end );
            end ), deduped_9_1, deduped_10_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfHomalgExteriorRingOverFieldPrecompiled", function ( homalg_ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( homalg_ring )
    return CategoryOfRowsAsAdditiveClosureOfRingAsCategory( homalg_ring );
end;
        
        
    
    cat := category_constructor( homalg_ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfHomalgExteriorRingOverFieldPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
