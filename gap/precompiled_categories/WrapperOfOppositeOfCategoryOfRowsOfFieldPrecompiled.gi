# SPDX-License-Identifier: GPL-2.0-or-later
# WrapperCategories: Construct an equivalent wrapper category out of a CAP category
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
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1;
    cap_jit_hoisted_expression_1_1 := HomalgIdentityMatrix( RankOfObject( arg3_1 ) * RankOfObject( arg2_1 ), UnderlyingRing( cat_1 ) );
    cap_jit_hoisted_expression_2_1 := RankOfObject( arg3_1 );
    cap_jit_hoisted_expression_3_1 := RankOfObject( arg2_1 );
    return List( [ 1 .. RankOfObject( arg3_1 ) * RankOfObject( arg2_1 ) ], function ( logic_new_func_x_2 )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( CertainRows( cap_jit_hoisted_expression_1_1, [ logic_new_func_x_2 ] ), cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1 ) );
        end );
end
########
        
    );
    
    ##
    AddBiasedWeakFiberProduct( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberColumns( ReducedSyzygiesOfColumns( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) ) );
end
########
        
    );
    
    ##
    AddBiasedWeakPushout( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberRows( ReducedSyzygiesOfRows( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) ) );
end
########
        
    );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ID_FUNC( EntriesOfHomalgMatrix( UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberRows( UnderlyingMatrix( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), P_1, UnderlyingMatrix, SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
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
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return ID_FUNC( ObjectifyObjectForCAPWithAttributes( rec(
             ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, 1 ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_morphism_attribute_2_1, cap_jit_morphism_attribute_3_1, cap_jit_morphism_attribute_4_1, cap_jit_morphism_attribute_5_1, cap_jit_morphism_attribute_6_1, cap_jit_morphism_attribute_7_1, cap_jit_morphism_attribute_8_1, cap_jit_morphism_attribute_9_1, cap_jit_morphism_attribute_10_1;
    cap_jit_morphism_attribute_1_1 := UnderlyingMatrix( beta_1 );
    cap_jit_morphism_attribute_10_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_2_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_3_1 := UnderlyingMatrix( beta_1 );
    cap_jit_morphism_attribute_4_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_5_1 := UnderlyingMatrix( beta_1 );
    cap_jit_morphism_attribute_6_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_7_1 := UnderlyingMatrix( beta_1 );
    cap_jit_morphism_attribute_8_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_9_1 := UnderlyingMatrix( beta_1 );
    return ID_FUNC( HomomorphismStructureOnMorphismsWithGivenObjects( [ RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_2_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_2_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_2_1 ), range_1 ][1], [ RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_3_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_3_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_4_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_4_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_4_1 ), range_1 ][2], [ RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_5_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_5_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_5_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_6_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_6_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_6_1 ), range_1 ][3], [ RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_7_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_7_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_7_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_8_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_8_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_8_1 ), range_1 ][4], [ RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_9_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_9_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_9_1 ), ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_10_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_10_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_10_1 ), range_1 ][5] ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ID_FUNC( ObjectifyObjectForCAPWithAttributes( rec(
             ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg3_1 ) * RankOfObject( arg2_1 ) ) );
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
    AddInjectionOfBiasedWeakPushoutWithGivenBiasedWeakPushout( cat,
        
########
function ( cat_1, a_1, b_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( a_1 ), P_1, UnderlyingMatrix, ReducedSyzygiesOfRows( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) ) );
end
########
        
    );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
    return ID_FUNC( ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 ) );
end
########
        
    );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, UnderlyingMatrix( InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( [ RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg2_1 ) ), arg4_1 ][1], [ RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg2_1 ) ), arg4_1 ][2], [ RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg2_1 ) ), arg4_1 ][3], [ RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg2_1 ) ), arg4_1 ][4] ) ) );
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
    if not true then
        return false;
    elif NumberRows( UnderlyingMatrix( arg2_1 ) ) <> NumberRows( UnderlyingMatrix( arg2_1 ) ) then
        return false;
    elif NumberColumns( UnderlyingMatrix( arg2_1 ) ) <> NumberColumns( UnderlyingMatrix( arg2_1 ) ) then
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
    AddKernelEmbeddingWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Source( alpha_1 ), UnderlyingMatrix, SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberColumns( UnderlyingMatrix( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) );
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
           ), cat_1, arg2_1, arg4_1, UnderlyingMatrix, UnderlyingMatrix( Opposite( arg3_1 ) ) );
end
########
        
    );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), UnderlyingCategory( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), UnderlyingCategory( cat_1 ), Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( Source( arg2_1 ) ) ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), UnderlyingCategory( cat_1 ), Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( Range( arg2_1 ) ) ) ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), RangeCategoryOfHomomorphismStructure( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
               ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 ) );
end
########
        
    );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, r_1 * UnderlyingMatrix( a_1 ) );
end
########
        
    );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, RankOfObject( Opposite( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), UnderlyingCategory( cat_1 ), Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg2_1 ) ) );
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
    AddProjectionOfBiasedWeakFiberProductWithGivenBiasedWeakFiberProduct( cat,
        
########
function ( cat_1, a_1, b_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Source( a_1 ), UnderlyingMatrix, ReducedSyzygiesOfColumns( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) ) );
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
    AddWeakCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberRows( ReducedSyzygiesOfRows( UnderlyingMatrix( arg2_1 ) ) ) );
end
########
        
    );
    
    ##
    AddWeakCokernelProjectionWithGivenWeakCokernelObject( cat,
        
########
function ( cat_1, alpha_1, K_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), K_1, UnderlyingMatrix, ReducedSyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddWeakKernelEmbeddingWithGivenWeakKernelObject( cat,
        
########
function ( cat_1, alpha_1, K_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, K_1, Source( alpha_1 ), UnderlyingMatrix, ReducedSyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddWeakKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, RankOfObject, NumberColumns( ReducedSyzygiesOfColumns( UnderlyingMatrix( arg2_1 ) ) ) );
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
    wrapper := WrapperCategory( op : name := "Columns( Q )",
        primitive_operations := true,
        wrap_range_of_hom_structure := false,
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum );
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
    
    if ValueOption( "FinalizeCategory" ) = false then
        
        return cat;
        
    fi;
    
    Finalize( cat );
    
    return cat;
    
end );
