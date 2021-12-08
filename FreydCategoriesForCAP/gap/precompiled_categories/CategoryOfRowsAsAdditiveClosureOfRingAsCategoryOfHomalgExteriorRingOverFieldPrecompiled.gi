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
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, 1 );
end
########
        
    , 100 : IsPrecompiledFunction := true );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, Sum( Concatenation( ListWithIdenticalEntries( RankOfObject( arg2_1 ), ListWithIdenticalEntries( RankOfObject( arg3_1 ), Length( GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 ) ) ) ) ) ) );
end
########
        
    , 100 : IsPrecompiledFunction := true );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingMatrix( beta_1 );
    deduped_7_1 := ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 );
    deduped_6_1 := UnderlyingMatrix( alpha_1 );
    deduped_5_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := RangeCategoryOfHomomorphismStructure( cat_1 );
    hoisted_2_1 := deduped_7_1;
    hoisted_3_1 := DiagMat( deduped_5_1, List( [ 1 .. NumberColumns( deduped_8_1 ) ], function ( logic_new_func_x_2 )
              return hoisted_2_1;
          end ) );
    hoisted_1_1 := deduped_5_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), deduped_4_1, source_1, range_1, UnderlyingMatrix, CoercedMatrix( deduped_5_1, UnderlyingRing( deduped_4_1 ), CoefficientsWithGivenMonomials( KroneckerMat( TransposedMatrix( deduped_6_1 ), DualKroneckerMat( UnionOfRows( deduped_5_1, NumberColumns( deduped_7_1 ), List( GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 ), function ( generator_2 )
                        return HomalgMatrix( [ generator_2 ], 1, 1, hoisted_1_1 );
                    end ) ), deduped_8_1 ) ), DiagMat( deduped_5_1, List( [ 1 .. NumberRows( deduped_6_1 ) ], function ( logic_new_func_x_2 )
                    return hoisted_3_1;
                end ) ) ) ) );
end
########
        
    , 100 : IsPrecompiledFunction := true );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingMatrix( alpha_1 );
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := RangeCategoryOfHomomorphismStructure( cat_1 );
    hoisted_1_1 := ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 );
    hoisted_2_1 := DiagMat( deduped_4_1, List( [ 1 .. NumberColumns( deduped_5_1 ) ], function ( logic_new_func_x_2 )
              return hoisted_1_1;
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), deduped_3_1, source_1, range_1, UnderlyingMatrix, CoercedMatrix( deduped_4_1, UnderlyingRing( deduped_3_1 ), CoefficientsWithGivenMonomials( ConvertMatrixToRow( deduped_5_1 ), DiagMat( deduped_4_1, List( [ 1 .. NumberRows( deduped_5_1 ) ], function ( logic_new_func_x_2 )
                    return hoisted_2_1;
                end ) ) ) ) );
end
########
        
    , 100 : IsPrecompiledFunction := true );
    
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
    hoisted_4_1 := [ 1 .. deduped_10_1 ];
    hoisted_3_1 := UnderlyingMatrix( arg4_1 );
    hoisted_2_1 := Concatenation( ListWithIdenticalEntries( deduped_9_1, ListWithIdenticalEntries( deduped_10_1, Length( GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( cat_1 ) ) ) ) );
    hoisted_1_1 := deduped_10_1;
    hoisted_5_1 := List( deduped_8_1, function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := hoisted_1_1 * (i_2 - 1);
            return List( hoisted_4_1, function ( logic_new_func_x_3 )
                    local deduped_1_3, deduped_2_3;
                    deduped_2_3 := hoisted_1_2 + logic_new_func_x_3;
                    deduped_1_3 := Sum( hoisted_2_1{[ 1 .. deduped_2_3 - 1 ]} ) + 1;
                    return CertainColumns( hoisted_3_1, [ deduped_1_3 .. deduped_1_3 - 1 + hoisted_2_1[deduped_2_3] ] );
                end );
        end );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, HomalgMatrix( List( deduped_8_1, function ( logic_new_func_x_2 )
                local hoisted_1_2;
                hoisted_1_2 := hoisted_5_1[logic_new_func_x_2];
                return List( hoisted_4_1, function ( logic_new_func_x_3 )
                        return EntriesOfHomalgMatrix( Pullback( hoisted_6_1, hoisted_1_2[logic_new_func_x_3] ) * hoisted_7_1 )[1];
                    end );
            end ), deduped_9_1, deduped_10_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 : IsPrecompiledFunction := true );
    
end );

BindGlobal( "CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfHomalgExteriorRingOverFieldPrecompiled", function ( homalg_ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( homalg_ring )
    local rows;
    rows := CategoryOfRowsAsAdditiveClosureOfRingAsCategory( homalg_ring );
    if IsBoundGlobal( "CATEGORY_OF_ROWS_HACKY_EXTENDER" ) then
        ValueGlobal( "CATEGORY_OF_ROWS_HACKY_EXTENDER" )( rows );
    fi;
    return rows;
end;
        
        
    
    cat := category_constructor( homalg_ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfHomalgExteriorRingOverFieldPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
