# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryOfColumnsAsOppositeOfCategoryOfRowsOfArbitraryRingPrecompiled", function ( cat )
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + UnderlyingMatrix( b_1 ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, - UnderlyingMatrix( a_1 ) );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, Sum( List( arg2_1, function ( logic_new_func_x_2 )
                return RankOfObject( logic_new_func_x_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, DiagMat( UnderlyingRing( cat_1 ), List( L_1, function ( logic_new_func_x_2 )
                return UnderlyingMatrix( logic_new_func_x_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddInjectionOfBiasedWeakPushout( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( a_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
end
########
        
    );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return RankOfObject( arg2_1 ) = RankOfObject( arg3_1 );
end
########
        
    );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := UnderlyingMatrix( arg2_1 );
    cap_jit_deduplicated_expression_1_1 := NumberRows( cap_jit_deduplicated_expression_3_1 );
    cap_jit_deduplicated_expression_2_1 := NumberColumns( cap_jit_deduplicated_expression_3_1 );
    if not true then
        return false;
    elif cap_jit_deduplicated_expression_1_1 <> cap_jit_deduplicated_expression_1_1 then
        return false;
    elif cap_jit_deduplicated_expression_2_1 <> cap_jit_deduplicated_expression_2_1 then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    if not true then
        return false;
    elif RankOfObject( arg2_1 ) < 0 then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsZeroForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( UnderlyingMatrix( arg2_1 ) );
end
########
        
    );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return RankOfObject( arg2_1 ) = 0;
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg4_1, UnderlyingMatrix, UnderlyingMatrix( arg3_1 ) );
end
########
        
    );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( cat_1 );
    cap_jit_morphism_attribute_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cap_jit_deduplicated_expression_1_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_1_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_1_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, RankOfObject( arg2_1 ) );
end
########
        
    );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), Opposite( cat_1 ), RankOfObject, RankOfObject( arg2_1 ) );
end
########
        
    );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( beta_1 ) * UnderlyingMatrix( alpha_1 ) );
end
########
        
    );
    
    ##
    AddProjectionOfBiasedWeakFiberProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), Source( a_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifyRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifyRange_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifyRange_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifySource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifySourceAndRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[1];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[2];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[5];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[4];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[3];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), Source( mor_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifySource_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSimplifySource_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), Source( mor_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSomeReductionBySplitEpiSummand( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCategoryOfColumnsMorphism( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha_1 )[1], cat_1 );
end
########
        
    );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCategoryOfColumnsMorphism( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha_1 )[2], cat_1 );
end
########
        
    );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCategoryOfColumnsMorphism( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha_1 )[3], cat_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), RankOfObject( T_1 ), List( tau_1, function ( logic_new_func_x_2 )
                return UnderlyingMatrix( logic_new_func_x_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( T_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), RankOfObject( T_1 ), List( tau_1, function ( logic_new_func_x_2 )
                return UnderlyingMatrix( logic_new_func_x_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( 0, RankOfObject( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddWeakCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddWeakKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( b_1 ), RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, 0 );
end
########
        
    );
    
end );

BindGlobal( "CategoryOfColumnsAsOppositeOfCategoryOfRowsOfArbitraryRingPrecompiled", function ( homalg_ring )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( homalg_ring )
    return CategoryOfColumnsAsOppositeOfCategoryOfRows( homalg_ring );
end;
        
        
    
    cat := category_constructor( homalg_ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfColumnsAsOppositeOfCategoryOfRowsOfArbitraryRingPrecompiled( cat );
    
    if ValueOption( "FinalizeCategory" ) = false then
        
        return cat;
        
    fi;
    
    Finalize( cat );
    
    return cat;
    
end );
