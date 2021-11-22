# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_WrapperOfOppositeOfCategoryOfRowsOfFieldPrecompiled", function ( cat )
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + UnderlyingMatrix( b_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, - UnderlyingMatrix( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_5_1 := RankOfObject( arg3_1 );
    deduped_6_1 := RankOfObject( arg2_1 );
    deduped_4_1 := deduped_5_1 * deduped_6_1;
    hoisted_1_1 := HomalgIdentityMatrix( deduped_4_1, UnderlyingRing( cat_1 ) );
    hoisted_2_1 := deduped_5_1;
    hoisted_3_1 := deduped_6_1;
    return List( [ 1 .. deduped_4_1 ], function ( logic_new_func_x_2 )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( CertainRows( hoisted_1_1, [ logic_new_func_x_2 ] ), hoisted_2_1, hoisted_3_1 ) );
        end );
end
########
        
    , 100 );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ID_FUNC( EntriesOfHomalgMatrix( UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberRows( deduped_1_1 ) - RowRankOfMatrix( deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, function ( logic_new_func_x_2 )
            return RankOfObject( logic_new_func_x_2 );
        end );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1[i_1], Range( alpha_1 ), UnderlyingMatrix, CertainColumns( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismIntoDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, function ( logic_new_func_x_2 )
            return RankOfObject( logic_new_func_x_2 );
        end );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), S_1[i_1], UnderlyingMatrix, CertainRows( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
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
        
    , 100 );
    
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
        
    , 100 );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return ID_FUNC( ObjectifyObjectForCAPWithAttributes( rec(
             ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, 1 ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    local morphism_attr_1_1, morphism_attr_2_1, morphism_attr_3_1, morphism_attr_4_1, morphism_attr_5_1, morphism_attr_6_1, morphism_attr_7_1, morphism_attr_8_1, morphism_attr_9_1, morphism_attr_10_1, deduped_11_1, deduped_12_1, deduped_13_1;
    deduped_11_1 := RangeCategoryOfHomomorphismStructure( cat_1 );
    deduped_12_1 := UnderlyingMatrix( beta_1 );
    deduped_13_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := deduped_12_1;
    morphism_attr_10_1 := deduped_13_1;
    morphism_attr_2_1 := deduped_13_1;
    morphism_attr_3_1 := deduped_12_1;
    morphism_attr_4_1 := deduped_13_1;
    morphism_attr_5_1 := deduped_12_1;
    morphism_attr_6_1 := deduped_13_1;
    morphism_attr_7_1 := deduped_12_1;
    morphism_attr_8_1 := deduped_13_1;
    morphism_attr_9_1 := deduped_12_1;
    return ID_FUNC( HomomorphismStructureOnMorphismsWithGivenObjects( [ deduped_11_1, source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_2_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 ), range_1 ][1], [ deduped_11_1, source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_4_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_4_1 ) ), UnderlyingMatrix, morphism_attr_4_1 ), range_1 ][2], [ deduped_11_1, source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_5_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_5_1 ) ), UnderlyingMatrix, morphism_attr_5_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_6_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_6_1 ) ), UnderlyingMatrix, morphism_attr_6_1 ), range_1 ][3], [ deduped_11_1, source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_7_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_7_1 ) ), UnderlyingMatrix, morphism_attr_7_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_8_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 ), range_1 ][4], [ deduped_11_1, source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_9_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_9_1 ) ), UnderlyingMatrix, morphism_attr_9_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), deduped_11_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrRows( morphism_attr_10_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), deduped_11_1, RankOfObject, NrColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 ), range_1 ][5] ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ID_FUNC( ObjectifyObjectForCAPWithAttributes( rec(
             ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg3_1 ) * RankOfObject( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfBiasedWeakPushout( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( a_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := RangeCategoryOfHomomorphismStructure( cat_1 );
    morphism_attr_1_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
    return ID_FUNC( ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_2_1, ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_2_1, RankOfObject, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_2_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := RangeCategoryOfHomomorphismStructure( cat_1 );
    deduped_1_1 := [ deduped_2_1, ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_2_1, RankOfObject, RankOfObject( arg3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_2_1, RankOfObject, RankOfObject( arg2_1 ) ), arg4_1 ];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, UnderlyingMatrix( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( deduped_1_1[1], deduped_1_1[2], deduped_1_1[3], deduped_1_1[4] ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return RankOfObject( arg2_1 ) = RankOfObject( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( arg2_1 );
    deduped_1_1 := NumberRows( deduped_3_1 );
    deduped_2_1 := NumberColumns( deduped_3_1 );
    if not true then
        return false;
    elif deduped_1_1 <> deduped_1_1 then
        return false;
    elif deduped_2_1 <> deduped_2_1 then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    , 100 );
    
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
        
    , 100 );
    
    ##
    AddIsZeroForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( UnderlyingMatrix( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return RankOfObject( arg2_1 ) = 0;
end
########
        
    , 100 );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberColumns( deduped_1_1 ) - RowRankOfMatrix( deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg4_1, UnderlyingMatrix, UnderlyingMatrix( Opposite( arg3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_2_1 := UnderlyingCategory( cat_1 );
    deduped_3_1 := RangeCategoryOfHomomorphismStructure( cat_1 );
    morphism_attr_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), deduped_2_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), deduped_2_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_3_1, RankOfObject, RankOfObject( Source( arg2_1 ) ) ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), deduped_2_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_3_1, RankOfObject, RankOfObject( Range( arg2_1 ) ) ) ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_3_1, ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_3_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_3_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, r_1 * UnderlyingMatrix( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, RankOfObject( Opposite( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), UnderlyingCategory( cat_1 ), Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( beta_1 ) * UnderlyingMatrix( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionOfBiasedWeakFiberProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), Source( a_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[1];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[2];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[5];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[4];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[3];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), Source( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( mor_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), Source( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
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
        
    , 100 );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( T_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
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
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( 0, RankOfObject( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddWeakCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddWeakKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, RankOfObject, NrColumns( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( b_1 ), RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, 0 );
end
########
        
    , 100 );
    
end );

BindGlobal( "WrapperOfOppositeOfCategoryOfRowsOfFieldPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( field )
    local matrix_category, op, object_constructor, object_datum, morphism_constructor, morphism_datum, wrapper;
    matrix_category := CategoryOfRows( field : FinalizeCategory := true );
    op := Opposite( matrix_category : FinalizeCategory := true,
        only_primitive_operations := true );
    object_constructor := function ( cat, underlying_object )
          return ObjectifyObjectForCAPWithAttributes( rec(
                 ), cat, RankOfObject, RankOfObject( Opposite( underlying_object ) ) );
      end;
    object_datum := function ( cat, obj )
          local op, matrix_category;
          op := UnderlyingCategory( cat );
          matrix_category := Opposite( op );
          return ObjectConstructor( op, CategoryOfRowsObject( matrix_category, RankOfObject( obj ) ) );
      end;
    morphism_constructor := function ( cat, source, underlying_morphism, range )
          return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                 ), cat, source, range, UnderlyingMatrix, UnderlyingMatrix( Opposite( underlying_morphism ) ) );
      end;
    morphism_datum := function ( cat, mor )
          local op, matrix_category, matrix_morphism;
          op := UnderlyingCategory( cat );
          matrix_category := Opposite( op );
          matrix_morphism := CategoryOfRowsMorphism( matrix_category, CategoryOfRowsObject( matrix_category, RankOfObject( Range( mor ) ) ), UnderlyingMatrix( mor ), CategoryOfRowsObject( matrix_category, RankOfObject( Source( mor ) ) ) );
          return MorphismConstructor( op, ObjectConstructor( op, Range( matrix_morphism ) ), matrix_morphism, ObjectConstructor( op, Source( matrix_morphism ) ) );
      end;
    wrapper := WrapperCategory( op, rec(
          name := "Columns( Q )",
          object_constructor := object_constructor,
          object_datum := object_datum,
          morphism_constructor := morphism_constructor,
          morphism_datum := morphism_datum,
          only_primitive_operations := true ) );
    SetUnderlyingRing( wrapper, field );
    Add( wrapper!.compiler_hints.category_attribute_names, "UnderlyingRing" );
    wrapper!.compiler_hints.source_and_range_attributes_from_morphism_attribute := rec(
        object_attribute_name := "RankOfObject",
        morphism_attribute_name := "UnderlyingMatrix",
        source_attribute_getter_name := "NrColumns",
        range_attribute_getter_name := "NrRows" );
    return wrapper;
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_WrapperOfOppositeOfCategoryOfRowsOfFieldPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
