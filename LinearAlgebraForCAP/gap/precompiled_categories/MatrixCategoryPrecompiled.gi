# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_MatrixCategoryPrecompiled", function ( cat )
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( b_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + UnderlyingMatrix( b_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, -1 * UnderlyingMatrix( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAssociatorLeftToRight( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_4_1;
    morphism_attr_4_1 := HomalgIdentityMatrix( Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_4_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_4_1 ) ), UnderlyingMatrix, morphism_attr_4_1 );
end
########
        
    , 302 );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( s_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddAssociatorRightToLeft( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_4_1;
    morphism_attr_4_1 := HomalgIdentityMatrix( Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_4_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_4_1 ) ), UnderlyingMatrix, morphism_attr_4_1 );
end
########
        
    , 302 );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( s_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddAstrictionToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_2_1 ) ), deduped_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 704 );
    
    ##
    AddAstrictionToCoimageWithGivenCoimage( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_2_1 ) ), deduped_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 705 );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Dimension( arg3_1 );
    deduped_5_1 := Dimension( arg2_1 );
    deduped_4_1 := deduped_5_1 * deduped_6_1;
    hoisted_3_1 := deduped_6_1;
    hoisted_2_1 := deduped_5_1;
    hoisted_1_1 := HomalgIdentityMatrix( deduped_4_1, UnderlyingRing( cat_1 ) );
    return List( [ 1 .. deduped_4_1 ], function ( logic_new_func_x_2 )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( CertainRows( hoisted_1_1, [ logic_new_func_x_2 ] ), hoisted_2_1, hoisted_3_1 ) );
        end );
end
########
        
    , 100 );
    
    ##
    AddBraiding( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := Dimension( a_1 );
    deduped_7_1 := Dimension( b_1 );
    deduped_6_1 := deduped_8_1 * deduped_7_1;
    hoisted_5_1 := deduped_8_1;
    hoisted_4_1 := deduped_7_1;
    morphism_attr_3_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1;
              end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 201 );
    
    ##
    AddBraidingInverse( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := Dimension( b_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := deduped_7_1 * deduped_8_1;
    hoisted_5_1 := deduped_8_1;
    hoisted_4_1 := deduped_7_1;
    morphism_attr_3_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1;
              end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 202 );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := Dimension( s_1 );
    hoisted_4_1 := Dimension( b_1 );
    hoisted_3_1 := Dimension( a_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1;
                end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := Dimension( s_1 );
    hoisted_4_1 := Dimension( a_1 );
    hoisted_3_1 := Dimension( b_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1;
                end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoastrictionToImage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := RightDivide( deduped_2_1, SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 704 );
    
    ##
    AddCoastrictionToImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := RightDivide( deduped_2_1, SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 705 );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return EntriesOfHomalgMatrix( UnderlyingMatrix( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCoevaluationForDual( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, morphism_attr_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := Dimension( a_1 );
    deduped_3_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    if deduped_4_1 = 0 then
        morphism_attr_1_1 := HomalgZeroMatrix( 1, deduped_4_1 * deduped_4_1, deduped_5_1 );
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, deduped_3_1, ObjectifyObjectForCAPWithAttributes( rec(
                 ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
    else
        morphism_attr_2_1 := ConvertMatrixToRow( HomalgIdentityMatrix( deduped_4_1, deduped_5_1 ) );
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, deduped_3_1, ObjectifyObjectForCAPWithAttributes( rec(
                 ), cat_1, Dimension, NrColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
    fi;
    return;
end
########
        
    , 401 );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := Dimension( a_1 );
    if deduped_1_1 = 0 then
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( s_1 ), Dimension( r_1 ), deduped_2_1 ) );
    else
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) ) );
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddCoevaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := Dimension( b_1 );
    deduped_7_1 := deduped_8_1 * deduped_9_1;
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_10_1 );
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                  if (deduped_8_1 = 0) then
                      return HomalgZeroMatrix( 1, deduped_6_1, deduped_10_1 );
                  else
                      return ConvertMatrixToRow( deduped_4_1 );
                  fi;
                  return;
              end(  ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_10_1 ), deduped_5_1 ) * KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                  end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_10_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2811 );
    
    ##
    AddCoevaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := Dimension( a_1 );
    deduped_10_1 := Dimension( b_1 );
    deduped_9_1 := deduped_10_1 * deduped_11_1;
    deduped_8_1 := deduped_10_1 * deduped_10_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_11_1, deduped_12_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_10_1, deduped_12_1 );
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    morphism_attr_3_1 := KroneckerMat( function (  )
                  if (deduped_10_1 = 0) then
                      return HomalgZeroMatrix( 1, deduped_8_1, deduped_12_1 );
                  else
                      return ConvertMatrixToRow( deduped_6_1 );
                  fi;
                  return;
              end(  ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_12_1 ), deduped_7_1 ) * KroneckerMat( deduped_6_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                  end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_12_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 2408 );
    
    ##
    AddCoimage( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfRows( UnderlyingMatrix( arg2_1 ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_1_1 ) - RowRankOfMatrix( deduped_1_1 ) );
end
########
        
    , 302 );
    
    ##
    AddCoimageProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 602 );
    
    ##
    AddCoimageProjectionWithGivenCoimage( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 603 );
    
    ##
    AddCokernelColift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( tau_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Range( tau_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 202 );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( tau_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Range( tau_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 203 );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_1_1 ) - RowRankOfMatrix( deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( mu_1 ) * SyzygiesOfColumns( UnderlyingMatrix( alphap_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 606 );
    
    ##
    AddCokernelObjectFunctorialWithGivenCokernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( mu_1 ) * SyzygiesOfColumns( UnderlyingMatrix( alphap_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 405 );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 101 );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( epsilon_1 ), Range( tau_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( epsilon_1 ), UnderlyingMatrix( tau_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, Dimension );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1[i_1], Range( alpha_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismIntoDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, Dimension );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), S_1[i_1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddCoproduct( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( arg2_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
end
########
        
    , 202 );
    
    ##
    AddCoproductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    hoisted_3_1 := Length( objectsp_1 );
    hoisted_2_1 := deduped_4_1;
    morphism_attr_1_1 := UnionOfRows( deduped_4_1, Sum( List( objectsp_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( objectsp_1[logic_new_func_x_2] );
              return UnderlyingMatrix( L_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( objectsp_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( deduped_1_2, Sum( objectsp_1{[ (logic_new_func_x_2 + 1) .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2118 );
    
    ##
    AddCoproductFunctorialWithGivenCoproducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    hoisted_3_1 := Length( objectsp_1 );
    hoisted_2_1 := deduped_4_1;
    morphism_attr_1_1 := UnionOfRows( deduped_4_1, Dimension( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( objectsp_1[logic_new_func_x_2] );
              return UnderlyingMatrix( L_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( objectsp_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( deduped_1_2, Sum( objectsp_1{[ (logic_new_func_x_2 + 1) .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Pp_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1713 );
    
    ##
    AddDirectProduct( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( arg2_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
end
########
        
    , 202 );
    
    ##
    AddDirectProductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    hoisted_3_1 := Length( objects_1 );
    hoisted_2_1 := deduped_4_1;
    morphism_attr_1_1 := UnionOfColumns( deduped_4_1, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( objects_1[logic_new_func_x_2] );
              return UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( objects_1{[ (logic_new_func_x_2 + 1) .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ) ) * UnderlyingMatrix( L_1[logic_new_func_x_2] );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2118 );
    
    ##
    AddDirectProductFunctorialWithGivenDirectProducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    hoisted_3_1 := Length( objects_1 );
    hoisted_2_1 := deduped_4_1;
    morphism_attr_1_1 := UnionOfColumns( deduped_4_1, Dimension( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( objects_1[logic_new_func_x_2] );
              return UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( objects_1{[ (logic_new_func_x_2 + 1) .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ) ) * UnderlyingMatrix( L_1[logic_new_func_x_2] );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1713 );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( arg2_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSumCodiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( D_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := deduped_10_1;
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := List( D_1, Range );
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( D_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) + -1 * UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1706 );
    
    ##
    AddDirectSumDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( D_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := deduped_10_1;
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( D_1, Source );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( D_1[logic_new_func_x_2] );
        end );
    morphism_attr_1_1 := UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1706 );
    
    ##
    AddDirectSumFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := DiagMat( UnderlyingRing( cat_1 ), List( L_1, function ( mor_2 )
              return UnderlyingMatrix( mor_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, DiagMat( UnderlyingRing( cat_1 ), List( L_1, function ( mor_2 )
                return UnderlyingMatrix( mor_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSumProjectionInPushout( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( D_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := deduped_10_1;
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := List( D_1, Range );
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( D_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := SyzygiesOfColumns( UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) + -1 * UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3814 );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
end
########
        
    , 100 );
    
    ##
    AddDualOnMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Source( alpha_1 ), UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 301 );
    
    ##
    AddDualOnMorphismsWithGivenDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddDualOnObjects( cat,
        
########
function ( cat_1, a_1 )
    return a_1;
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddEvaluationForDual( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, morphism_attr_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := Dimension( a_1 );
    deduped_3_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    if deduped_4_1 = 0 then
        morphism_attr_1_1 := HomalgZeroMatrix( deduped_4_1 * deduped_4_1, 1, deduped_5_1 );
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                 ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), deduped_3_1, UnderlyingMatrix, morphism_attr_1_1 );
    else
        morphism_attr_2_1 := ConvertMatrixToColumn( HomalgIdentityMatrix( deduped_4_1, deduped_5_1 ) );
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                 ), cat_1, Dimension, NrRows( morphism_attr_2_1 ) ), deduped_3_1, UnderlyingMatrix, morphism_attr_2_1 );
    fi;
    return;
end
########
        
    , 401 );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := Dimension( a_1 );
    if deduped_1_1 = 0 then
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( s_1 ), Dimension( r_1 ), deduped_2_1 ) );
    else
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) ) );
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddEvaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := deduped_7_1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), function (  )
                if (deduped_7_1 = 0) then
                    return HomalgZeroMatrix( (deduped_7_1 * deduped_7_1), 1, deduped_8_1 );
                else
                    return ConvertMatrixToColumn( deduped_4_1 );
                fi;
                return;
            end(  ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2610 );
    
    ##
    AddEvaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := Dimension( b_1 );
    deduped_7_1 := deduped_9_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    hoisted_5_1 := deduped_9_1;
    hoisted_4_1 := deduped_8_1;
    morphism_attr_3_1 := KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_10_1 ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_10_1 ), deduped_6_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_10_1 ), function (  )
                if (deduped_9_1 = 0) then
                    return HomalgZeroMatrix( (deduped_9_1 * deduped_9_1), 1, deduped_10_1 );
                else
                    return ConvertMatrixToColumn( deduped_6_1 );
                fi;
                return;
            end(  ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 2207 );
    
    ##
    AddFiberProduct( cat,
        
########
function ( cat_1, arg2_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( arg2_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( arg2_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := deduped_7_1;
    hoisted_1_1 := List( arg2_1, Source );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_1_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_3_1 ) ) * UnderlyingMatrix( arg2_1[logic_new_func_x_2] );
        end );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( SyzygiesOfRows( UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} ) ) ) );
end
########
        
    , 3815 );
    
    ##
    AddFiberProductEmbeddingInDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( D_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := deduped_10_1;
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( D_1, Source );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( D_1[logic_new_func_x_2] );
        end );
    morphism_attr_1_1 := SyzygiesOfRows( UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3814 );
    
    ##
    AddFiberProductFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
    deduped_19_1 := Length( morphismsp_1 );
    deduped_18_1 := Length( morphisms_1 );
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_15_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_14_1 := Sum( deduped_16_1 );
    deduped_13_1 := Sum( deduped_15_1 );
    hoisted_9_1 := deduped_19_1;
    hoisted_8_1 := deduped_16_1;
    hoisted_7_1 := List( morphismsp_1, Source );
    hoisted_4_1 := deduped_17_1;
    deduped_12_1 := List( [ 1 .. deduped_19_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_8_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_7_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_7_1{[ (logic_new_func_x_2 + 1) .. hoisted_9_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] );
        end );
    hoisted_5_1 := deduped_18_1;
    hoisted_3_1 := deduped_15_1;
    hoisted_2_1 := List( morphisms_1, Source );
    deduped_11_1 := List( [ 1 .. deduped_18_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    deduped_10_1 := SyzygiesOfRows( UnionOfColumns( deduped_17_1, deduped_13_1, deduped_11_1{[ 1 .. deduped_18_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_17_1, deduped_13_1, deduped_11_1{[ 2 .. deduped_18_1 ]} ) );
    hoisted_6_1 := deduped_10_1;
    morphism_attr_1_1 := RightDivide( UnionOfColumns( deduped_17_1, NumberRows( deduped_10_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( hoisted_3_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return CertainColumns( hoisted_6_1, [ deduped_1_2 .. (deduped_1_2 - 1 + hoisted_3_1[logic_new_func_x_2]) ] ) * UnderlyingMatrix( L_1[logic_new_func_x_2] );
            end ) ), SyzygiesOfRows( UnionOfColumns( deduped_17_1, deduped_14_1, deduped_12_1{[ 1 .. deduped_19_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_17_1, deduped_14_1, deduped_12_1{[ 2 .. deduped_19_1 ]} ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 19782 );
    
    ##
    AddFiberProductFunctorialWithGivenFiberProducts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := Length( morphismsp_1 );
    deduped_17_1 := Length( morphisms_1 );
    deduped_16_1 := UnderlyingRing( cat_1 );
    deduped_15_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_14_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_13_1 := Sum( deduped_15_1 );
    deduped_12_1 := Sum( deduped_14_1 );
    hoisted_9_1 := deduped_18_1;
    hoisted_8_1 := deduped_15_1;
    hoisted_7_1 := List( morphismsp_1, Source );
    hoisted_4_1 := deduped_16_1;
    deduped_11_1 := List( [ 1 .. deduped_18_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_8_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_7_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_7_1{[ (logic_new_func_x_2 + 1) .. hoisted_9_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] );
        end );
    hoisted_5_1 := deduped_17_1;
    hoisted_3_1 := deduped_14_1;
    hoisted_2_1 := List( morphisms_1, Source );
    deduped_10_1 := List( [ 1 .. deduped_17_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    hoisted_6_1 := SyzygiesOfRows( UnionOfColumns( deduped_16_1, deduped_12_1, deduped_10_1{[ 1 .. deduped_17_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_16_1, deduped_12_1, deduped_10_1{[ 2 .. deduped_17_1 ]} ) );
    morphism_attr_1_1 := RightDivide( UnionOfColumns( deduped_16_1, Dimension( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( hoisted_3_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return CertainColumns( hoisted_6_1, [ deduped_1_2 .. (deduped_1_2 - 1 + hoisted_3_1[logic_new_func_x_2]) ] ) * UnderlyingMatrix( L_1[logic_new_func_x_2] );
            end ) ), SyzygiesOfRows( UnionOfColumns( deduped_16_1, deduped_13_1, deduped_11_1{[ 1 .. deduped_18_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_16_1, deduped_13_1, deduped_11_1{[ 2 .. deduped_18_1 ]} ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 12151 );
    
    ##
    AddHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( beta_1 ) ) * SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_1_1 ) - RowRankOfMatrix( deduped_1_1 ) );
end
########
        
    , 704 );
    
    ##
    AddHomologyObjectFunctorialWithGivenHomologyObjects( cat,
        
########
function ( cat_1, H_1_1, L_1, H_2_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := SyzygiesOfColumns( UnderlyingMatrix( L_1[4] ) );
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( L_1[1] ) );
    deduped_3_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( L_1[5] ) ) * deduped_5_1 );
    deduped_2_1 := HomalgIdentityMatrix( NumberRows( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ), UnderlyingRing( cat_1 ) );
    morphism_attr_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( L_1[2] ) ) * deduped_4_1 ) ) * LeftDivide( deduped_4_1, (UnderlyingMatrix( L_1[3] ) * deduped_5_1) ), SyzygiesOfRows( deduped_3_1 ) ) * RightDivide( deduped_2_1, deduped_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3815 );
    
    ##
    AddHomomorphismStructureOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, source_1, range_1, UnderlyingMatrix, KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( arg2_1 ) * Dimension( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddImageEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 602 );
    
    ##
    AddImageEmbeddingWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 603 );
    
    ##
    AddImageObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfColumns( UnderlyingMatrix( arg2_1 ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_1_1 ) - RowRankOfMatrix( deduped_1_1 ) );
end
########
        
    , 302 );
    
    ##
    AddInitialObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
end
########
        
    , 202 );
    
    ##
    AddInitialObjectFunctorial( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 303 );
    
    ##
    AddInitialObjectFunctorialWithGivenInitialObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( Pp_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 );
    
    ##
    AddInjectionOfCofactorOfCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := objects_1[k_1];
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := Dimension( deduped_4_1 );
    morphism_attr_1_1 := UnionOfColumns( HomalgZeroMatrix( deduped_2_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( deduped_2_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 503 );
    
    ##
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := objects_1[k_1];
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := Dimension( deduped_4_1 );
    morphism_attr_1_1 := UnionOfColumns( HomalgZeroMatrix( deduped_2_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( deduped_2_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 504 );
    
    ##
    AddInjectionOfCofactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := objects_1[k_1];
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := Dimension( deduped_4_1 );
    morphism_attr_1_1 := UnionOfColumns( HomalgZeroMatrix( deduped_2_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( deduped_2_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := objects_1[k_1];
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := Dimension( deduped_3_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_3_1, P_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_1_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), deduped_2_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ), HomalgZeroMatrix( deduped_1_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, Range );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} ) + 1;
    hoisted_5_1 := deduped_12_1;
    hoisted_4_1 := deduped_11_1;
    hoisted_3_1 := deduped_10_1;
    hoisted_2_1 := deduped_9_1;
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := CertainRows( SyzygiesOfColumns( UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) + -1 * UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} ) ), [ deduped_7_1 .. deduped_7_1 - 1 + deduped_9_1[k_1] ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_10_1[k_1], ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3915 );
    
    ##
    AddInjectionOfCofactorOfPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, Range );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} ) + 1;
    hoisted_5_1 := deduped_12_1;
    hoisted_4_1 := deduped_11_1;
    hoisted_3_1 := deduped_10_1;
    hoisted_2_1 := deduped_9_1;
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := CertainRows( SyzygiesOfColumns( UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) + -1 * UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} ) ), [ deduped_7_1 .. deduped_7_1 - 1 + deduped_9_1[k_1] ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_10_1[k_1], ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3916 );
    
    ##
    AddInjectiveColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddInternalHomOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1810 );
    
    ##
    AddInternalHomOnMorphismsWithGivenInternalHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    local morphism_attr_3_1;
    morphism_attr_3_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 1205 );
    
    ##
    AddInternalHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
end
########
        
    , 302 );
    
    ##
    AddInternalHomToTensorProductAdjunctionMap( cat,
        
########
function ( cat_1, b_1, c_1, g_1 )
    local morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( b_1 );
    deduped_8_1 := Dimension( c_1 );
    deduped_7_1 := deduped_9_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    hoisted_5_1 := deduped_9_1;
    hoisted_4_1 := deduped_8_1;
    morphism_attr_3_1 := KroneckerMat( UnderlyingMatrix( g_1 ), deduped_6_1 ) * (KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_10_1 ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_10_1 ), deduped_6_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_10_1 ), function (  )
                  if (deduped_9_1 = 0) then
                      return HomalgZeroMatrix( (deduped_9_1 * deduped_9_1), 1, deduped_10_1 );
                  else
                      return ConvertMatrixToColumn( deduped_6_1 );
                  fi;
                  return;
              end(  ) ));
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 3112 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 101 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( UnderlyingMatrix( arg4_1 ), Dimension( arg2_1 ), Dimension( arg3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := Range( alpha_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, Source( alpha_1 ), UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 202 );
    
    ##
    AddInverseMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := RightDivide( LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_3_1 ) ), deduped_3_1 ), SyzygiesOfRows( SyzygiesOfColumns( deduped_3_1 ) ) );
    morphism_attr_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( deduped_2_1 ), UnderlyingRing( cat_1 ) ), deduped_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2214 );
    
    ##
    AddIsAutomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Dimension( Range( arg2_1 ) );
    deduped_1_1 := Dimension( Source( arg2_1 ) );
    return deduped_1_1 = deduped_2_1 and (deduped_2_1 = deduped_1_1 and ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = deduped_2_1);
end
########
        
    , 202 );
    
    ##
    AddIsCodominating( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( SyzygiesOfRows( UnderlyingMatrix( arg3_1 ) ) * UnderlyingMatrix( arg2_1 ) );
end
########
        
    , 301 );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsColiftableAlongEpimorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsDominating( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( UnderlyingMatrix( arg2_1 ) * SyzygiesOfColumns( UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    , 301 );
    
    ##
    AddIsEndomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( Source( arg2_1 ) ) = Dimension( Range( arg2_1 ) );
end
########
        
    , 101 );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = Dimension( Range( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualAsFactorobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( arg2_1 );
    deduped_1_1 := UnderlyingMatrix( arg3_1 );
    return IsZero( SyzygiesOfRows( deduped_1_1 ) * deduped_2_1 ) and IsZero( SyzygiesOfRows( deduped_2_1 ) * deduped_1_1 );
end
########
        
    , 603 );
    
    ##
    AddIsEqualAsSubobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( arg3_1 );
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return IsZero( deduped_1_1 * SyzygiesOfColumns( deduped_2_1 ) ) and IsZero( deduped_2_1 * SyzygiesOfColumns( deduped_1_1 ) );
end
########
        
    , 603 );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
end
########
        
    , 101 );
    
    ##
    AddIsEqualForMorphismsOnMor( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_3_1, deduped_4_1;
    deduped_4_1 := Dimension( Range( arg2_1 ) ) = Dimension( Range( arg3_1 ) );
    deduped_3_1 := Dimension( Source( arg2_1 ) ) = Dimension( Source( arg3_1 ) );
    if deduped_3_1 = fail or deduped_4_1 = fail then
        return fail;
    elif deduped_3_1 = false or deduped_4_1 = false then
        return false;
    else
        return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
    fi;
    return;
end
########
        
    , 302 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return Dimension( arg2_1 ) = Dimension( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsIdempotent( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return deduped_1_1 * deduped_1_1 = deduped_1_1;
end
########
        
    , 201 );
    
    ##
    AddIsIdenticalToIdentityMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Dimension( Source( arg2_1 ) );
    deduped_2_1 := Dimension( Range( arg2_1 ) ) = deduped_3_1;
    deduped_1_1 := deduped_3_1 = deduped_3_1;
    if deduped_1_1 = fail or deduped_2_1 = fail then
        return fail;
    elif deduped_1_1 = false or deduped_2_1 = false then
        return false;
    else
        return UnderlyingMatrix( arg2_1 ) = HomalgIdentityMatrix( deduped_3_1, UnderlyingRing( cat_1 ) );
    fi;
    return;
end
########
        
    , 403 );
    
    ##
    AddIsIdenticalToZeroMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Dimension( Range( arg2_1 ) );
    deduped_3_1 := Dimension( Source( arg2_1 ) );
    deduped_2_1 := deduped_4_1 = deduped_4_1;
    deduped_1_1 := deduped_3_1 = deduped_3_1;
    if deduped_1_1 = fail or deduped_2_1 = fail then
        return fail;
    elif deduped_1_1 = false or deduped_2_1 = false then
        return false;
    else
        return UnderlyingMatrix( arg2_1 ) = HomalgZeroMatrix( deduped_3_1, deduped_4_1, UnderlyingRing( cat_1 ) );
    fi;
    return;
end
########
        
    , 403 );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    , 101 );
    
    ##
    AddIsInjective( cat,
        
########
function ( cat_1, arg2_1 )
    return true;
end
########
        
    , 100 );
    
    ##
    AddIsIsomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := Dimension( Range( arg2_1 ) );
    return deduped_1_1 = Dimension( Source( arg2_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = deduped_1_1;
end
########
        
    , 100 );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsLiftableAlongMonomorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = Dimension( Source( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsOne( cat,
        
########
function ( cat_1, arg2_1 )
    return HomalgIdentityMatrix( Dimension( Source( arg2_1 ) ), UnderlyingRing( cat_1 ) ) = UnderlyingMatrix( arg2_1 );
end
########
        
    , 201 );
    
    ##
    AddIsProjective( cat,
        
########
function ( cat_1, arg2_1 )
    return true;
end
########
        
    , 100 );
    
    ##
    AddIsSplitEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroRows( HomalgIdentityMatrix( Dimension( Range( arg2_1 ) ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 201 );
    
    ##
    AddIsSplitMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroColumns( HomalgIdentityMatrix( Dimension( Source( arg2_1 ) ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 201 );
    
    ##
    AddIsTerminal( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    , 101 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    if not IS_IDENTICAL_OBJ( cat_1, cat_1 ) then
        return false;
    elif NumberRows( deduped_1_1 ) <> Dimension( Source( arg2_1 ) ) then
        return false;
    elif NumberColumns( deduped_1_1 ) <> Dimension( Range( arg2_1 ) ) then
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
    if not IS_IDENTICAL_OBJ( cat_1, cat_1 ) then
        return false;
    elif Dimension( arg2_1 ) < 0 then
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
    return Dimension( arg2_1 ) = 0;
end
########
        
    , 100 );
    
    ##
    AddIsomorphismFromCoimageToCokernelOfKernel( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberColumns( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 );
    
    ##
    AddIsomorphismFromCokernelOfDiagonalDifferenceToPushout( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( D_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := List( D_1, Range );
    hoisted_2_1 := deduped_9_1;
    deduped_7_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( D_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    deduped_6_1 := UnionOfRows( deduped_10_1, deduped_8_1, deduped_7_1{[ 1 .. deduped_11_1 - 1 ]} ) + -1 * UnionOfRows( deduped_10_1, deduped_8_1, deduped_7_1{[ 2 .. deduped_11_1 ]} );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberColumns( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ), deduped_10_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1907 );
    
    ##
    AddIsomorphismFromCokernelOfKernelToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberColumns( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 );
    
    ##
    AddIsomorphismFromCoproductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddIsomorphismFromDirectProductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddIsomorphismFromDirectSumToCoproduct( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddIsomorphismFromDirectSumToDirectProduct( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddIsomorphismFromDualToInternalHom( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 );
    
    ##
    AddIsomorphismFromFiberProductToKernelOfDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( D_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := List( D_1, Source );
    deduped_7_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( D_1[logic_new_func_x_2] );
        end );
    deduped_6_1 := UnionOfColumns( deduped_10_1, deduped_8_1, deduped_7_1{[ 1 .. deduped_11_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_10_1, deduped_8_1, deduped_7_1{[ 2 .. deduped_11_1 ]} );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberRows( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ), deduped_10_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1907 );
    
    ##
    AddIsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( beta_1 ) ) * SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 703 );
    
    ##
    AddIsomorphismFromImageObjectToKernelOfCokernel( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 );
    
    ##
    AddIsomorphismFromInitialObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddIsomorphismFromInternalHomToDual( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 );
    
    ##
    AddIsomorphismFromInternalHomToObject( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := Dimension( a_1 );
    deduped_4_1 := 1 * deduped_5_1;
    deduped_3_1 := HomalgIdentityMatrix( 1, deduped_6_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), deduped_3_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_6_1 ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), function (  )
                if (1 = 0) then
                    return HomalgZeroMatrix( (1 * 1), 1, deduped_6_1 );
                else
                    return ConvertMatrixToColumn( deduped_3_1 );
                fi;
                return;
            end(  ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2914 );
    
    ##
    AddIsomorphismFromInternalHomToObjectWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, s_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := Dimension( a_1 );
    deduped_4_1 := 1 * deduped_5_1;
    deduped_3_1 := HomalgIdentityMatrix( 1, deduped_6_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), deduped_3_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_6_1 ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), function (  )
                if (1 = 0) then
                    return HomalgZeroMatrix( (1 * 1), 1, deduped_6_1 );
                else
                    return ConvertMatrixToColumn( deduped_3_1 );
                fi;
                return;
            end(  ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2913 );
    
    ##
    AddIsomorphismFromInternalHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_3_1;
    morphism_attr_3_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 301 );
    
    ##
    AddIsomorphismFromItsConstructionAsAnImageObjectToHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( beta_1 ) ) * SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    deduped_2_1 := HomalgIdentityMatrix( NumberRows( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ), UnderlyingRing( cat_1 ) );
    morphism_attr_1_1 := RightDivide( deduped_2_1, deduped_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 906 );
    
    ##
    AddIsomorphismFromKernelOfCokernelToImageObject( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 );
    
    ##
    AddIsomorphismFromKernelOfDiagonalDifferenceToFiberProduct( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( D_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := List( D_1, Source );
    deduped_7_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( D_1[logic_new_func_x_2] );
        end );
    deduped_6_1 := UnionOfColumns( deduped_10_1, deduped_8_1, deduped_7_1{[ 1 .. deduped_11_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_10_1, deduped_8_1, deduped_7_1{[ 2 .. deduped_11_1 ]} );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberRows( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ), deduped_10_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1907 );
    
    ##
    AddIsomorphismFromObjectToInternalHom( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := 1 * 1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := 1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_7_1 );
    deduped_3_1 := HomalgIdentityMatrix( 1, deduped_7_1 );
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                    if (1 = 0) then
                        return HomalgZeroMatrix( 1, deduped_8_1, deduped_7_1 );
                    else
                        return ConvertMatrixToRow( deduped_3_1 );
                    fi;
                    return;
                end(  ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * 1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_7_1 ), deduped_4_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_7_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), deduped_4_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5025 );
    
    ##
    AddIsomorphismFromObjectToInternalHomWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := 1 * 1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := 1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_7_1 );
    deduped_3_1 := HomalgIdentityMatrix( 1, deduped_7_1 );
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                    if (1 = 0) then
                        return HomalgZeroMatrix( 1, deduped_8_1, deduped_7_1 );
                    else
                        return ConvertMatrixToRow( deduped_3_1 );
                    fi;
                    return;
                end(  ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * 1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_7_1 ), deduped_4_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_7_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), deduped_4_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5024 );
    
    ##
    AddIsomorphismFromPushoutToCokernelOfDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( D_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := List( D_1, Range );
    hoisted_2_1 := deduped_9_1;
    deduped_7_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( D_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    deduped_6_1 := UnionOfRows( deduped_10_1, deduped_8_1, deduped_7_1{[ 1 .. deduped_11_1 - 1 ]} ) + -1 * UnionOfRows( deduped_10_1, deduped_8_1, deduped_7_1{[ 2 .. deduped_11_1 ]} );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberColumns( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ), deduped_10_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1907 );
    
    ##
    AddIsomorphismFromTensorProductToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_3_1;
    morphism_attr_3_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 301 );
    
    ##
    AddIsomorphismFromTerminalObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddIsomorphismFromZeroObjectToInitialObject( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddIsomorphismFromZeroObjectToTerminalObject( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddKernelEmbeddingWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 101 );
    
    ##
    AddKernelLift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := RightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 202 );
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := RightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 203 );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_1_1 ) - RowRankOfMatrix( deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddKernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := RightDivide( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) * UnderlyingMatrix( mu_1 ), SyzygiesOfRows( UnderlyingMatrix( alphap_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 606 );
    
    ##
    AddKernelObjectFunctorialWithGivenKernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := RightDivide( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) * UnderlyingMatrix( mu_1 ), SyzygiesOfRows( UnderlyingMatrix( alphap_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 405 );
    
    ##
    AddLambdaElimination( cat,
        
########
function ( cat_1, a_1, b_1, alpha_1 )
    local morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := Dimension( b_1 );
    deduped_7_1 := deduped_9_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    hoisted_5_1 := deduped_9_1;
    hoisted_4_1 := deduped_8_1;
    morphism_attr_3_1 := KroneckerMat( UnderlyingMatrix( alpha_1 ), deduped_6_1 ) * (KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_10_1 ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_10_1 ), deduped_6_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_10_1 ), function (  )
                  if (deduped_9_1 = 0) then
                      return HomalgZeroMatrix( (deduped_9_1 * deduped_9_1), 1, deduped_10_1 );
                  else
                      return ConvertMatrixToColumn( deduped_6_1 );
                  fi;
                  return;
              end(  ) ));
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 3315 );
    
    ##
    AddLambdaIntroduction( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := HomalgIdentityMatrix( 1, deduped_8_1 );
    deduped_6_1 := Dimension( Source( alpha_1 ) );
    deduped_5_1 := deduped_6_1 * 1;
    deduped_4_1 := deduped_6_1 * deduped_6_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_6_1, deduped_8_1 );
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                    if (deduped_6_1 = 0) then
                        return HomalgZeroMatrix( 1, deduped_4_1, deduped_8_1 );
                    else
                        return ConvertMatrixToRow( deduped_3_1 );
                    fi;
                    return;
                end(  ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_8_1 ), deduped_7_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5125 );
    
    ##
    AddLeftDistributivityExpanding( cat,
        
########
function ( cat_1, a_1, L_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_5_1 );
    hoisted_3_1 := Length( L_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := UnionOfColumns( deduped_5_1, deduped_6_1 * Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( hoisted_4_1, UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ) ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1707 );
    
    ##
    AddLeftDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_5_1 );
    hoisted_3_1 := Length( L_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := UnionOfColumns( deduped_5_1, Dimension( s_1 ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( hoisted_4_1, UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ) ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1506 );
    
    ##
    AddLeftDistributivityFactoring( cat,
        
########
function ( cat_1, a_1, L_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_5_1 );
    hoisted_3_1 := Length( L_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := UnionOfRows( deduped_5_1, deduped_6_1 * Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( hoisted_4_1, UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( deduped_1_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ) ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1707 );
    
    ##
    AddLeftDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_5_1 );
    hoisted_3_1 := Length( L_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := UnionOfRows( deduped_5_1, Dimension( r_1 ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( hoisted_4_1, UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( deduped_1_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ) ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), r_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1506 );
    
    ##
    AddLeftUnitor( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 );
    
    ##
    AddLeftUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), Source( iota_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( iota_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddMereExistenceOfSolutionOfLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := arg2_1[1];
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := [ 1 .. Length( arg2_1 ) ];
    hoisted_4_1 := deduped_6_1;
    hoisted_3_1 := deduped_5_1;
    hoisted_2_1 := arg3_1[1];
    hoisted_1_1 := deduped_7_1;
    return IsZero( DecideZeroRows( UnionOfColumns( deduped_6_1, 1, List( deduped_5_1, function ( logic_new_func_x_2 )
                  return ConvertMatrixToRow( UnderlyingMatrix( arg4_1[logic_new_func_x_2] ) );
              end ) ), UnionOfRows( deduped_6_1, Sum( List( deduped_5_1, function ( logic_new_func_x_2 )
                    return Dimension( Source( arg2_1[logic_new_func_x_2][1] ) ) * Dimension( Range( arg3_1[logic_new_func_x_2][1] ) );
                end ) ), List( [ 1 .. Length( deduped_7_1 ) ], function ( logic_new_func_x_2 )
                  return UnionOfColumns( hoisted_4_1, Dimension( Range( hoisted_1_1[logic_new_func_x_2] ) ) * Dimension( Source( hoisted_2_1[logic_new_func_x_2] ) ), List( hoisted_3_1, function ( logic_new_func_x_3 )
                            return KroneckerMat( TransposedMatrix( UnderlyingMatrix( arg2_1[logic_new_func_x_3][logic_new_func_x_2] ) ), UnderlyingMatrix( arg3_1[logic_new_func_x_3][logic_new_func_x_2] ) );
                        end ) );
              end ) ) ) );
end
########
        
    , 201 );
    
    ##
    AddMonoidalPostComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
    deduped_19_1 := UnderlyingRing( cat_1 );
    deduped_18_1 := Dimension( c_1 );
    deduped_17_1 := Dimension( b_1 );
    deduped_16_1 := Dimension( a_1 );
    deduped_15_1 := deduped_16_1 * deduped_16_1;
    deduped_14_1 := deduped_16_1 * deduped_17_1;
    deduped_13_1 := deduped_17_1 * deduped_18_1;
    deduped_12_1 := deduped_16_1 = 0;
    deduped_11_1 := deduped_13_1 * deduped_14_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_17_1, deduped_19_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_16_1, deduped_19_1 );
    deduped_8_1 := deduped_16_1 * deduped_11_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_13_1, deduped_19_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_11_1, deduped_19_1 );
    hoisted_5_1 := deduped_18_1;
    hoisted_4_1 := deduped_17_1;
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_16_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                    if deduped_12_1 then
                        return HomalgZeroMatrix( 1, deduped_15_1, deduped_19_1 );
                    else
                        return ConvertMatrixToRow( deduped_9_1 );
                    fi;
                    return;
                end(  ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_19_1 ), deduped_6_1 ) * KroneckerMat( deduped_9_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_19_1 ) ) * KroneckerMat( TransposedMatrix( deduped_9_1 ), (KroneckerMat( deduped_7_1, KroneckerMat( HomalgIdentityMatrix( deduped_14_1, deduped_19_1 ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                            end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_19_1 ), deduped_9_1 ) * KroneckerMat( deduped_10_1, function (  )
                        if deduped_12_1 then
                            return HomalgZeroMatrix( deduped_15_1, 1, deduped_19_1 );
                        else
                            return ConvertMatrixToColumn( deduped_9_1 );
                        fi;
                        return;
                    end(  ) ) ) * (KroneckerMat( deduped_7_1, deduped_10_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                          end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_19_1 ), deduped_10_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_18_1, deduped_19_1 ), function (  )
                      if (deduped_17_1 = 0) then
                          return HomalgZeroMatrix( (deduped_17_1 * deduped_17_1), 1, deduped_19_1 );
                      else
                          return ConvertMatrixToColumn( deduped_10_1 );
                      fi;
                      return;
                  end(  ) ))) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 12155 );
    
    ##
    AddMonoidalPostComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
    deduped_19_1 := UnderlyingRing( cat_1 );
    deduped_18_1 := Dimension( c_1 );
    deduped_17_1 := Dimension( b_1 );
    deduped_16_1 := Dimension( a_1 );
    deduped_15_1 := deduped_16_1 * deduped_16_1;
    deduped_14_1 := deduped_16_1 * deduped_17_1;
    deduped_13_1 := deduped_17_1 * deduped_18_1;
    deduped_12_1 := deduped_16_1 = 0;
    deduped_11_1 := deduped_13_1 * deduped_14_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_17_1, deduped_19_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_16_1, deduped_19_1 );
    deduped_8_1 := deduped_16_1 * deduped_11_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_13_1, deduped_19_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_11_1, deduped_19_1 );
    hoisted_5_1 := deduped_18_1;
    hoisted_4_1 := deduped_17_1;
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_16_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                    if deduped_12_1 then
                        return HomalgZeroMatrix( 1, deduped_15_1, deduped_19_1 );
                    else
                        return ConvertMatrixToRow( deduped_9_1 );
                    fi;
                    return;
                end(  ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_19_1 ), deduped_6_1 ) * KroneckerMat( deduped_9_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_19_1 ) ) * KroneckerMat( TransposedMatrix( deduped_9_1 ), (KroneckerMat( deduped_7_1, KroneckerMat( HomalgIdentityMatrix( deduped_14_1, deduped_19_1 ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                            end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_19_1 ), deduped_9_1 ) * KroneckerMat( deduped_10_1, function (  )
                        if deduped_12_1 then
                            return HomalgZeroMatrix( deduped_15_1, 1, deduped_19_1 );
                        else
                            return ConvertMatrixToColumn( deduped_9_1 );
                        fi;
                        return;
                    end(  ) ) ) * (KroneckerMat( deduped_7_1, deduped_10_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                          end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_19_1 ), deduped_10_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_18_1, deduped_19_1 ), function (  )
                      if (deduped_17_1 = 0) then
                          return HomalgZeroMatrix( (deduped_17_1 * deduped_17_1), 1, deduped_19_1 );
                      else
                          return ConvertMatrixToColumn( deduped_10_1 );
                      fi;
                      return;
                  end(  ) ))) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 11148 );
    
    ##
    AddMonoidalPreComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1;
    deduped_23_1 := UnderlyingRing( cat_1 );
    deduped_22_1 := Dimension( c_1 );
    deduped_21_1 := Dimension( b_1 );
    deduped_20_1 := Dimension( a_1 );
    deduped_19_1 := deduped_20_1 * deduped_20_1;
    deduped_18_1 := deduped_21_1 * deduped_22_1;
    deduped_17_1 := deduped_20_1 * deduped_21_1;
    deduped_16_1 := deduped_20_1 = 0;
    deduped_15_1 := deduped_21_1 * deduped_18_1;
    deduped_14_1 := deduped_18_1 * deduped_20_1;
    deduped_13_1 := deduped_17_1 * deduped_18_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_21_1, deduped_23_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_20_1, deduped_23_1 );
    deduped_10_1 := deduped_20_1 * deduped_13_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_18_1, deduped_23_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_17_1, deduped_23_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_13_1, deduped_23_1 );
    hoisted_6_1 := deduped_22_1;
    hoisted_5_1 := deduped_21_1;
    hoisted_4_1 := deduped_18_1;
    hoisted_3_1 := deduped_13_1;
    hoisted_2_1 := deduped_20_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                    if deduped_16_1 then
                        return HomalgZeroMatrix( 1, deduped_19_1, deduped_23_1 );
                    else
                        return ConvertMatrixToRow( deduped_11_1 );
                    fi;
                    return;
                end(  ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_23_1 ), deduped_7_1 ) * KroneckerMat( deduped_11_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_23_1 ) ) * KroneckerMat( TransposedMatrix( deduped_11_1 ), (KroneckerMat( deduped_8_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                          end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_23_1 ) ) * KroneckerMat( (KroneckerMat( deduped_8_1, deduped_11_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                                end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_23_1 ), deduped_11_1 ) * KroneckerMat( deduped_12_1, function (  )
                            if deduped_16_1 then
                                return HomalgZeroMatrix( deduped_19_1, 1, deduped_23_1 );
                            else
                                return ConvertMatrixToColumn( deduped_11_1 );
                            fi;
                            return;
                        end(  ) )), deduped_9_1 ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_23_1 ) * (KroneckerMat( deduped_9_1, deduped_12_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                          end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_23_1 ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_22_1, deduped_23_1 ), function (  )
                      if (deduped_21_1 = 0) then
                          return HomalgZeroMatrix( (deduped_21_1 * deduped_21_1), 1, deduped_23_1 );
                      else
                          return ConvertMatrixToColumn( deduped_12_1 );
                      fi;
                      return;
                  end(  ) ))) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 12958 );
    
    ##
    AddMonoidalPreComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1;
    deduped_23_1 := UnderlyingRing( cat_1 );
    deduped_22_1 := Dimension( c_1 );
    deduped_21_1 := Dimension( b_1 );
    deduped_20_1 := Dimension( a_1 );
    deduped_19_1 := deduped_20_1 * deduped_20_1;
    deduped_18_1 := deduped_21_1 * deduped_22_1;
    deduped_17_1 := deduped_20_1 * deduped_21_1;
    deduped_16_1 := deduped_20_1 = 0;
    deduped_15_1 := deduped_21_1 * deduped_18_1;
    deduped_14_1 := deduped_18_1 * deduped_20_1;
    deduped_13_1 := deduped_17_1 * deduped_18_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_21_1, deduped_23_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_20_1, deduped_23_1 );
    deduped_10_1 := deduped_20_1 * deduped_13_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_18_1, deduped_23_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_17_1, deduped_23_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_13_1, deduped_23_1 );
    hoisted_6_1 := deduped_22_1;
    hoisted_5_1 := deduped_21_1;
    hoisted_4_1 := deduped_18_1;
    hoisted_3_1 := deduped_13_1;
    hoisted_2_1 := deduped_20_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                    if deduped_16_1 then
                        return HomalgZeroMatrix( 1, deduped_19_1, deduped_23_1 );
                    else
                        return ConvertMatrixToRow( deduped_11_1 );
                    fi;
                    return;
                end(  ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_23_1 ), deduped_7_1 ) * KroneckerMat( deduped_11_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_23_1 ) ) * KroneckerMat( TransposedMatrix( deduped_11_1 ), (KroneckerMat( deduped_8_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                          end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_23_1 ) ) * KroneckerMat( (KroneckerMat( deduped_8_1, deduped_11_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                                end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_23_1 ), deduped_11_1 ) * KroneckerMat( deduped_12_1, function (  )
                            if deduped_16_1 then
                                return HomalgZeroMatrix( deduped_19_1, 1, deduped_23_1 );
                            else
                                return ConvertMatrixToColumn( deduped_11_1 );
                            fi;
                            return;
                        end(  ) )), deduped_9_1 ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_23_1 ) * (KroneckerMat( deduped_9_1, deduped_12_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                          end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_23_1 ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_22_1, deduped_23_1 ), function (  )
                      if (deduped_21_1 = 0) then
                          return HomalgZeroMatrix( (deduped_21_1 * deduped_21_1), 1, deduped_23_1 );
                      else
                          return ConvertMatrixToColumn( deduped_12_1 );
                      fi;
                      return;
                  end(  ) ))) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 11951 );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1, I_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddMorphismBetweenDirectSums( cat,
        
########
function ( cat_1, source_diagram_1, mat_1, range_diagram_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    hoisted_2_1 := deduped_3_1;
    morphism_attr_1_1 := UnionOfRows( deduped_3_1, Sum( List( range_diagram_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), ListN( source_diagram_1, List( mat_1, function ( row_2 )
                return List( row_2, UnderlyingMatrix );
            end ), function ( source_2, row_2 )
              return UnionOfColumns( hoisted_2_1, Dimension( source_2 ), row_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 );
    
    ##
    AddMorphismBetweenDirectSumsWithGivenDirectSums( cat,
        
########
function ( cat_1, S_1, source_diagram_1, mat_1, range_diagram_1, T_1 )
    local hoisted_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    hoisted_1_1 := deduped_2_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1, T_1, UnderlyingMatrix, UnionOfRows( deduped_2_1, Dimension( T_1 ), ListN( source_diagram_1, List( mat_1, function ( row_2 )
                  return List( row_2, UnderlyingMatrix );
              end ), function ( source_2, row_2 )
                return UnionOfColumns( hoisted_1_1, Dimension( source_2 ), row_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg4_1, UnderlyingMatrix, arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return UnderlyingMatrix( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismFromBidual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, RightDivide( deduped_1_1, deduped_1_1 ) );
end
########
        
    , 504 );
    
    ##
    AddMorphismFromBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingRing( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, a_1, UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( s_1 ), deduped_1_1 ), HomalgIdentityMatrix( Dimension( a_1 ), deduped_1_1 ) ) );
end
########
        
    , 303 );
    
    ##
    AddMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := RightDivide( LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_2_1 ) ), deduped_2_1 ), SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2011 );
    
    ##
    AddMorphismFromFiberProductToSink( cat,
        
########
function ( cat_1, morphisms_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := morphisms_1[1];
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} ) + 1;
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := List( morphisms_1, Source );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    morphism_attr_1_1 := CertainColumns( SyzygiesOfRows( (UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} )) ), [ deduped_7_1 .. (deduped_7_1 - 1 + deduped_9_1[1]) ] ) * UnderlyingMatrix( deduped_12_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Range( deduped_12_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 4016 );
    
    ##
    AddMorphismFromFiberProductToSinkWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := morphisms_1[1];
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} ) + 1;
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := List( morphisms_1, Source );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    morphism_attr_1_1 := CertainColumns( SyzygiesOfRows( (UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} )) ), [ deduped_7_1 .. (deduped_7_1 - 1 + deduped_9_1[1]) ] ) * UnderlyingMatrix( deduped_12_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Range( deduped_12_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 4017 );
    
    ##
    AddMorphismFromInternalHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 805 );
    
    ##
    AddMorphismFromInternalHomToTensorProductWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_3_1;
    morphism_attr_3_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 302 );
    
    ##
    AddMorphismFromKernelObjectToSink( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := Range( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( NumberRows( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ), Dimension( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddMorphismFromKernelObjectToSinkWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := Range( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( NumberRows( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ), Dimension( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 202 );
    
    ##
    AddMorphismFromSourceToCokernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := Source( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( deduped_2_1 ), NumberColumns( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddMorphismFromSourceToCokernelObjectWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := Source( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( deduped_2_1 ), NumberColumns( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 202 );
    
    ##
    AddMorphismFromSourceToPushout( cat,
        
########
function ( cat_1, morphisms_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := morphisms_1[1];
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} ) + 1;
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := List( morphisms_1, Range );
    hoisted_2_1 := deduped_9_1;
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := UnderlyingMatrix( deduped_12_1 ) * CertainRows( SyzygiesOfColumns( (UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) + -1 * UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} )) ), [ deduped_7_1 .. (deduped_7_1 - 1 + deduped_9_1[1]) ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_12_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 4016 );
    
    ##
    AddMorphismFromSourceToPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := morphisms_1[1];
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} ) + 1;
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := List( morphisms_1, Range );
    hoisted_2_1 := deduped_9_1;
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := UnderlyingMatrix( deduped_12_1 ) * CertainRows( SyzygiesOfColumns( (UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) + -1 * UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} )) ), [ deduped_7_1 .. (deduped_7_1 - 1 + deduped_9_1[1]) ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_12_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 4017 );
    
    ##
    AddMorphismFromTensorProductToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 805 );
    
    ##
    AddMorphismFromTensorProductToInternalHomWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_3_1;
    morphism_attr_3_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 302 );
    
    ##
    AddMorphismToBidual( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 );
    
    ##
    AddMorphismToBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, r_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
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
           ), cat_1, Dimension, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    , 101 );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := objects_1[k_1];
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := Dimension( deduped_4_1 );
    morphism_attr_1_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_2_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_2_1, deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), deduped_4_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 503 );
    
    ##
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := objects_1[k_1];
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := Dimension( deduped_4_1 );
    morphism_attr_1_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_2_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_2_1, deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), deduped_4_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 504 );
    
    ##
    AddProjectionInFactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := objects_1[k_1];
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := Dimension( deduped_4_1 );
    morphism_attr_1_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_2_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_2_1, deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), deduped_4_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := objects_1[k_1];
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := Dimension( deduped_3_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, deduped_3_1, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), deduped_1_1, deduped_2_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), deduped_1_1, deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, Source );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} ) + 1;
    hoisted_5_1 := deduped_12_1;
    hoisted_4_1 := deduped_11_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_10_1;
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    morphism_attr_1_1 := CertainColumns( SyzygiesOfRows( UnionOfColumns( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} ) ), [ deduped_7_1 .. deduped_7_1 - 1 + deduped_9_1[k_1] ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), deduped_10_1[k_1], UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3915 );
    
    ##
    AddProjectionInFactorOfFiberProductWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, Source );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} ) + 1;
    hoisted_5_1 := deduped_12_1;
    hoisted_4_1 := deduped_11_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_10_1;
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    morphism_attr_1_1 := CertainColumns( SyzygiesOfRows( UnionOfColumns( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} ) ), [ deduped_7_1 .. deduped_7_1 - 1 + deduped_9_1[k_1] ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), deduped_10_1[k_1], UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3916 );
    
    ##
    AddProjectiveLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddPushout( cat,
        
########
function ( cat_1, arg2_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( arg2_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( arg2_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( arg2_1, Range );
    hoisted_1_1 := deduped_7_1;
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( arg2_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_3_1 ) );
        end );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( SyzygiesOfColumns( UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) + -1 * UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} ) ) ) );
end
########
        
    , 3815 );
    
    ##
    AddPushoutFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
    deduped_19_1 := Length( morphismsp_1 );
    deduped_18_1 := Length( morphisms_1 );
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_15_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_14_1 := Sum( deduped_15_1 );
    deduped_13_1 := Sum( deduped_16_1 );
    hoisted_5_1 := deduped_18_1;
    hoisted_4_1 := deduped_17_1;
    hoisted_3_1 := List( morphisms_1, Range );
    hoisted_2_1 := deduped_15_1;
    deduped_12_1 := List( [ 1 .. deduped_18_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    hoisted_8_1 := deduped_19_1;
    hoisted_7_1 := List( morphismsp_1, Range );
    hoisted_6_1 := deduped_16_1;
    deduped_11_1 := List( [ 1 .. deduped_19_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_6_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_7_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_7_1{[ (logic_new_func_x_2 + 1) .. hoisted_8_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    deduped_10_1 := SyzygiesOfColumns( UnionOfRows( deduped_17_1, deduped_13_1, deduped_11_1{[ 1 .. deduped_19_1 - 1 ]} ) + -1 * UnionOfRows( deduped_17_1, deduped_13_1, deduped_11_1{[ 2 .. deduped_19_1 ]} ) );
    hoisted_9_1 := deduped_10_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_17_1, deduped_14_1, deduped_12_1{[ 1 .. deduped_18_1 - 1 ]} ) + -1 * UnionOfRows( deduped_17_1, deduped_14_1, deduped_12_1{[ 2 .. deduped_18_1 ]} ) ), UnionOfRows( deduped_17_1, NumberColumns( deduped_10_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( hoisted_6_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return UnderlyingMatrix( L_1[logic_new_func_x_2] ) * CertainRows( hoisted_9_1, [ deduped_1_2 .. (deduped_1_2 - 1 + hoisted_6_1[logic_new_func_x_2]) ] );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 19782 );
    
    ##
    AddPushoutFunctorialWithGivenPushouts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := Length( morphismsp_1 );
    deduped_17_1 := Length( morphisms_1 );
    deduped_16_1 := UnderlyingRing( cat_1 );
    deduped_15_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_14_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_13_1 := Sum( deduped_14_1 );
    deduped_12_1 := Sum( deduped_15_1 );
    hoisted_5_1 := deduped_17_1;
    hoisted_4_1 := deduped_16_1;
    hoisted_3_1 := List( morphisms_1, Range );
    hoisted_2_1 := deduped_14_1;
    deduped_11_1 := List( [ 1 .. deduped_17_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    hoisted_8_1 := deduped_18_1;
    hoisted_7_1 := List( morphismsp_1, Range );
    hoisted_6_1 := deduped_15_1;
    deduped_10_1 := List( [ 1 .. deduped_18_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_6_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_7_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_7_1{[ (logic_new_func_x_2 + 1) .. hoisted_8_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    hoisted_9_1 := SyzygiesOfColumns( UnionOfRows( deduped_16_1, deduped_12_1, deduped_10_1{[ 1 .. deduped_18_1 - 1 ]} ) + -1 * UnionOfRows( deduped_16_1, deduped_12_1, deduped_10_1{[ 2 .. deduped_18_1 ]} ) );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_16_1, deduped_13_1, deduped_11_1{[ 1 .. deduped_17_1 - 1 ]} ) + -1 * UnionOfRows( deduped_16_1, deduped_13_1, deduped_11_1{[ 2 .. deduped_17_1 ]} ) ), UnionOfRows( deduped_16_1, Dimension( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( hoisted_6_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return UnderlyingMatrix( L_1[logic_new_func_x_2] ) * CertainRows( hoisted_9_1, [ deduped_1_2 .. (deduped_1_2 - 1 + hoisted_6_1[logic_new_func_x_2]) ] );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Pp_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 12151 );
    
    ##
    AddRankMorphism( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := Dimension( a_1 );
    deduped_7_1 := deduped_8_1 * 1;
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_8_1 = 0;
    deduped_4_1 := HomalgIdentityMatrix( 1, deduped_9_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    hoisted_2_1 := deduped_8_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                      if deduped_5_1 then
                          return HomalgZeroMatrix( 1, deduped_6_1, deduped_9_1 );
                      else
                          return ConvertMatrixToRow( deduped_3_1 );
                      fi;
                      return;
                  end(  ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_9_1 ), deduped_4_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_9_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), deduped_3_1 ) * function (  )
              if deduped_5_1 then
                  return HomalgZeroMatrix( deduped_6_1, 1, deduped_9_1 );
              else
                  return ConvertMatrixToColumn( deduped_3_1 );
              fi;
              return;
          end(  );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5929 );
    
    ##
    AddRightDistributivityExpanding( cat,
        
########
function ( cat_1, L_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_5_1 );
    hoisted_3_1 := Length( L_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := UnionOfColumns( deduped_5_1, Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ) * deduped_6_1, List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ) ), hoisted_4_1 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1707 );
    
    ##
    AddRightDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_5_1 );
    hoisted_3_1 := Length( L_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := UnionOfColumns( deduped_5_1, Dimension( s_1 ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), deduped_1_2, hoisted_2_1 ) ), hoisted_4_1 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1506 );
    
    ##
    AddRightDistributivityFactoring( cat,
        
########
function ( cat_1, L_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_5_1 );
    hoisted_3_1 := Length( L_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := UnionOfRows( deduped_5_1, Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ) * deduped_6_1, List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( deduped_1_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ) ), hoisted_4_1 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1707 );
    
    ##
    AddRightDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_5_1 );
    hoisted_3_1 := Length( L_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := UnionOfRows( deduped_5_1, Dimension( r_1 ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( deduped_1_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. hoisted_3_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), hoisted_2_1 ) ), hoisted_4_1 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), r_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1506 );
    
    ##
    AddRightUnitor( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 );
    
    ##
    AddRightUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddSolveLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := arg2_1[1];
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_7_1 := [ 1 .. Length( deduped_10_1 ) ];
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := arg3_1[1];
    hoisted_1_1 := deduped_10_1;
    hoisted_6_1 := RightDivide( UnionOfColumns( deduped_9_1, 1, List( deduped_8_1, function ( logic_new_func_x_2 )
                return ConvertMatrixToRow( UnderlyingMatrix( arg4_1[logic_new_func_x_2] ) );
            end ) ), UnionOfRows( deduped_9_1, Sum( List( deduped_8_1, function ( logic_new_func_x_2 )
                  return Dimension( Source( arg2_1[logic_new_func_x_2][1] ) ) * Dimension( Range( arg3_1[logic_new_func_x_2][1] ) );
              end ) ), List( deduped_7_1, function ( logic_new_func_x_2 )
                return UnionOfColumns( hoisted_4_1, Dimension( Range( hoisted_1_1[logic_new_func_x_2] ) ) * Dimension( Source( hoisted_2_1[logic_new_func_x_2] ) ), List( hoisted_3_1, function ( logic_new_func_x_3 )
                          return KroneckerMat( TransposedMatrix( UnderlyingMatrix( arg2_1[logic_new_func_x_3][logic_new_func_x_2] ) ), UnderlyingMatrix( arg3_1[logic_new_func_x_3][logic_new_func_x_2] ) );
                      end ) );
            end ) ) );
    hoisted_5_1 := List( deduped_7_1, function ( logic_new_func_x_2 )
            return Dimension( Range( hoisted_1_1[logic_new_func_x_2] ) ) * Dimension( Source( hoisted_2_1[logic_new_func_x_2] ) );
        end );
    return List( deduped_7_1, function ( j_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2;
            deduped_3_2 := Source( hoisted_2_1[j_2] );
            deduped_2_2 := Range( hoisted_1_1[j_2] );
            deduped_1_2 := Sum( hoisted_5_1{[ 1 .. j_2 - 1 ]} ) + 1;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_2_2, deduped_3_2, UnderlyingMatrix, ConvertRowToMatrix( CertainColumns( hoisted_6_1, [ deduped_1_2 .. deduped_1_2 - 1 + hoisted_5_1[j_2] ] ), Dimension( deduped_2_2 ), Dimension( deduped_3_2 ) ) );
        end );
end
########
        
    , 401 );
    
    ##
    AddSomeInjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return arg2_1;
end
########
        
    , 100 );
    
    ##
    AddSomeProjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return arg2_1;
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( 0, NumberColumns( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( deduped_2_1 ), UnderlyingRing( cat_1 ) ), deduped_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSubtractionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( b_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + -1 * UnderlyingMatrix( b_1 ) );
end
########
        
    , 201 );
    
    ##
    AddTensorProductDualityCompatibilityMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1;
    deduped_29_1 := UnderlyingRing( cat_1 );
    deduped_28_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    deduped_27_1 := [ a_1, deduped_28_1, b_1, deduped_28_1 ];
    deduped_26_1 := Dimension( deduped_27_1[4] );
    deduped_25_1 := Dimension( deduped_27_1[2] );
    deduped_24_1 := Dimension( deduped_27_1[3] );
    deduped_23_1 := Dimension( deduped_27_1[1] );
    deduped_22_1 := deduped_24_1 * deduped_26_1;
    deduped_21_1 := deduped_23_1 * deduped_25_1;
    deduped_20_1 := deduped_23_1 * deduped_24_1;
    deduped_19_1 := deduped_22_1 * deduped_23_1;
    deduped_18_1 := deduped_20_1 * deduped_20_1;
    deduped_17_1 := deduped_21_1 * deduped_22_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_25_1, deduped_29_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_23_1, deduped_29_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_24_1, deduped_29_1 );
    deduped_13_1 := deduped_20_1 * deduped_17_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_22_1, deduped_29_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_21_1, deduped_29_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_20_1, deduped_29_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_17_1, deduped_29_1 );
    hoisted_8_1 := deduped_24_1;
    hoisted_7_1 := deduped_26_1;
    hoisted_6_1 := deduped_25_1;
    hoisted_5_1 := deduped_22_1;
    hoisted_4_1 := deduped_23_1;
    hoisted_3_1 := deduped_17_1;
    hoisted_2_1 := deduped_20_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( Dimension( a_1 ), deduped_29_1 ), HomalgIdentityMatrix( Dimension( b_1 ), deduped_29_1 ) ) * (KroneckerMat( function (  )
                      if (deduped_20_1 = 0) then
                          return HomalgZeroMatrix( 1, deduped_18_1, deduped_29_1 );
                      else
                          return ConvertMatrixToRow( deduped_10_1 );
                      fi;
                      return;
                  end(  ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_29_1 ), deduped_9_1 ) * KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                      end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_29_1 ) ) * KroneckerMat( TransposedMatrix( deduped_10_1 ), (KroneckerMat( KroneckerMat( deduped_11_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                            end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_29_1 ) ), deduped_14_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_11_1, deduped_15_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_21_1 ], function ( i_2 )
                                      local deduped_1_2;
                                      deduped_1_2 := (i_2 - 1);
                                      return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                                  end ) ), deduped_21_1 ), deduped_21_1, deduped_21_1, deduped_29_1 ), deduped_15_1 ) * KroneckerMat( deduped_16_1, function (  )
                              if (deduped_23_1 = 0) then
                                  return HomalgZeroMatrix( (deduped_23_1 * deduped_23_1), 1, deduped_29_1 );
                              else
                                  return ConvertMatrixToColumn( deduped_15_1 );
                              fi;
                              return;
                          end(  ) )), deduped_12_1 ), deduped_14_1 ) * KroneckerMat( deduped_16_1, (KroneckerMat( deduped_12_1, deduped_14_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_22_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_8_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                              end ) ), deduped_22_1 ), deduped_22_1, deduped_22_1, deduped_29_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_29_1 ), function (  )
                          if (deduped_24_1 = 0) then
                              return HomalgZeroMatrix( (deduped_24_1 * deduped_24_1), 1, deduped_29_1 );
                          else
                              return ConvertMatrixToColumn( deduped_14_1 );
                          fi;
                          return;
                      end(  ) )) )) ));
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 15766 );
    
    ##
    AddTensorProductDualityCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1, deduped_30_1, deduped_31_1;
    deduped_31_1 := UnderlyingRing( cat_1 );
    deduped_30_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    deduped_29_1 := [ a_1, deduped_30_1, b_1, deduped_30_1 ];
    deduped_28_1 := Dimension( deduped_29_1[4] );
    deduped_27_1 := Dimension( deduped_29_1[2] );
    deduped_26_1 := Dimension( deduped_29_1[1] );
    deduped_25_1 := Dimension( deduped_29_1[3] );
    deduped_24_1 := deduped_25_1 * deduped_28_1;
    deduped_23_1 := deduped_26_1 * deduped_27_1;
    deduped_22_1 := deduped_26_1 * deduped_25_1;
    deduped_21_1 := deduped_24_1 * deduped_26_1;
    deduped_20_1 := deduped_22_1 * deduped_22_1;
    deduped_19_1 := deduped_23_1 * deduped_24_1;
    deduped_18_1 := HomalgIdentityMatrix( deduped_27_1, deduped_31_1 );
    deduped_17_1 := HomalgIdentityMatrix( deduped_26_1, deduped_31_1 );
    deduped_16_1 := HomalgIdentityMatrix( deduped_25_1, deduped_31_1 );
    deduped_15_1 := deduped_22_1 * deduped_19_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_24_1, deduped_31_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_23_1, deduped_31_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_22_1, deduped_31_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_19_1, deduped_31_1 );
    hoisted_10_1 := deduped_25_1;
    hoisted_9_1 := deduped_28_1;
    hoisted_8_1 := deduped_27_1;
    hoisted_7_1 := deduped_24_1;
    hoisted_6_1 := deduped_26_1;
    hoisted_5_1 := deduped_19_1;
    hoisted_4_1 := deduped_22_1;
    morphism_attr_3_1 := KroneckerMat( HomalgIdentityMatrix( Dimension( a_1 ), deduped_31_1 ), HomalgIdentityMatrix( Dimension( b_1 ), deduped_31_1 ) ) * (KroneckerMat( function (  )
                      if (deduped_22_1 = 0) then
                          return HomalgZeroMatrix( 1, deduped_20_1, deduped_31_1 );
                      else
                          return ConvertMatrixToRow( deduped_12_1 );
                      fi;
                      return;
                  end(  ), deduped_11_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_20_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                        end ) ), deduped_20_1 ), deduped_20_1, deduped_20_1, deduped_31_1 ), deduped_11_1 ) * KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                      end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_31_1 ) ) * KroneckerMat( TransposedMatrix( deduped_12_1 ), (KroneckerMat( KroneckerMat( deduped_13_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_21_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_7_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                            end ) ), deduped_21_1 ), deduped_21_1, deduped_21_1, deduped_31_1 ) ), deduped_16_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_13_1, deduped_17_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_23_1 ], function ( i_2 )
                                      local deduped_1_2;
                                      deduped_1_2 := (i_2 - 1);
                                      return (REM_INT( deduped_1_2, hoisted_8_1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, hoisted_8_1 ) + 1);
                                  end ) ), deduped_23_1 ), deduped_23_1, deduped_23_1, deduped_31_1 ), deduped_17_1 ) * KroneckerMat( deduped_18_1, function (  )
                              if (deduped_26_1 = 0) then
                                  return HomalgZeroMatrix( (deduped_26_1 * deduped_26_1), 1, deduped_31_1 );
                              else
                                  return ConvertMatrixToColumn( deduped_17_1 );
                              fi;
                              return;
                          end(  ) )), deduped_14_1 ), deduped_16_1 ) * KroneckerMat( deduped_18_1, (KroneckerMat( deduped_14_1, deduped_16_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_24_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_9_1 ) * hoisted_10_1 + QUO_INT( deduped_1_2, hoisted_9_1 ) + 1);
                              end ) ), deduped_24_1 ), deduped_24_1, deduped_24_1, deduped_31_1 ), deduped_16_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_28_1, deduped_31_1 ), function (  )
                          if (deduped_25_1 = 0) then
                              return HomalgZeroMatrix( (deduped_25_1 * deduped_25_1), 1, deduped_31_1 );
                          else
                              return ConvertMatrixToColumn( deduped_16_1 );
                          fi;
                          return;
                      end(  ) )) )) ));
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 15265 );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphism( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    deduped_26_1 := Dimension( list_1[4] );
    deduped_25_1 := Dimension( list_1[2] );
    deduped_24_1 := Dimension( list_1[3] );
    deduped_23_1 := Dimension( list_1[1] );
    deduped_22_1 := deduped_24_1 * deduped_26_1;
    deduped_21_1 := deduped_23_1 * deduped_25_1;
    deduped_20_1 := deduped_23_1 * deduped_24_1;
    deduped_19_1 := deduped_22_1 * deduped_23_1;
    deduped_18_1 := deduped_20_1 * deduped_20_1;
    deduped_17_1 := deduped_21_1 * deduped_22_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_25_1, deduped_27_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_23_1, deduped_27_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_24_1, deduped_27_1 );
    deduped_13_1 := deduped_20_1 * deduped_17_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_22_1, deduped_27_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_21_1, deduped_27_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_20_1, deduped_27_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_17_1, deduped_27_1 );
    hoisted_8_1 := deduped_24_1;
    hoisted_7_1 := deduped_26_1;
    hoisted_6_1 := deduped_25_1;
    hoisted_5_1 := deduped_22_1;
    hoisted_4_1 := deduped_23_1;
    hoisted_3_1 := deduped_17_1;
    hoisted_2_1 := deduped_20_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                    if (deduped_20_1 = 0) then
                        return HomalgZeroMatrix( 1, deduped_18_1, deduped_27_1 );
                    else
                        return ConvertMatrixToRow( deduped_10_1 );
                    fi;
                    return;
                end(  ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_27_1 ), deduped_9_1 ) * KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_27_1 ) ) * KroneckerMat( TransposedMatrix( deduped_10_1 ), (KroneckerMat( KroneckerMat( deduped_11_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                          end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_27_1 ) ), deduped_14_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_11_1, deduped_15_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_21_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                                end ) ), deduped_21_1 ), deduped_21_1, deduped_21_1, deduped_27_1 ), deduped_15_1 ) * KroneckerMat( deduped_16_1, function (  )
                            if (deduped_23_1 = 0) then
                                return HomalgZeroMatrix( (deduped_23_1 * deduped_23_1), 1, deduped_27_1 );
                            else
                                return ConvertMatrixToColumn( deduped_15_1 );
                            fi;
                            return;
                        end(  ) )), deduped_12_1 ), deduped_14_1 ) * KroneckerMat( deduped_16_1, (KroneckerMat( deduped_12_1, deduped_14_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_22_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_8_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                            end ) ), deduped_22_1 ), deduped_22_1, deduped_22_1, deduped_27_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_27_1 ), function (  )
                        if (deduped_24_1 = 0) then
                            return HomalgZeroMatrix( (deduped_24_1 * deduped_24_1), 1, deduped_27_1 );
                        else
                            return ConvertMatrixToColumn( deduped_14_1 );
                        fi;
                        return;
                    end(  ) )) )) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 14160 );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverse( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := Dimension( list_1[4] );
    deduped_26_1 := Dimension( list_1[2] );
    deduped_25_1 := Dimension( list_1[3] );
    deduped_24_1 := Dimension( list_1[1] );
    deduped_23_1 := deduped_25_1 * deduped_27_1;
    deduped_22_1 := deduped_24_1 * deduped_26_1;
    deduped_21_1 := deduped_24_1 * deduped_25_1;
    deduped_20_1 := deduped_23_1 * deduped_24_1;
    deduped_19_1 := deduped_21_1 * deduped_21_1;
    deduped_18_1 := deduped_22_1 * deduped_23_1;
    deduped_17_1 := HomalgIdentityMatrix( deduped_26_1, deduped_28_1 );
    deduped_16_1 := HomalgIdentityMatrix( deduped_24_1, deduped_28_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_25_1, deduped_28_1 );
    deduped_14_1 := deduped_21_1 * deduped_18_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_23_1, deduped_28_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_22_1, deduped_28_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_21_1, deduped_28_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_18_1, deduped_28_1 );
    hoisted_8_1 := deduped_25_1;
    hoisted_7_1 := deduped_27_1;
    hoisted_6_1 := deduped_26_1;
    hoisted_5_1 := deduped_23_1;
    hoisted_4_1 := deduped_24_1;
    hoisted_3_1 := deduped_18_1;
    hoisted_2_1 := deduped_21_1;
    deduped_9_1 := KroneckerMat( function (  )
                    if (deduped_21_1 = 0) then
                        return HomalgZeroMatrix( 1, deduped_19_1, deduped_28_1 );
                    else
                        return ConvertMatrixToRow( deduped_11_1 );
                    fi;
                    return;
                end(  ), deduped_10_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_28_1 ), deduped_10_1 ) * KroneckerMat( deduped_11_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_28_1 ) ) * KroneckerMat( TransposedMatrix( deduped_11_1 ), (KroneckerMat( KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_20_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                          end ) ), deduped_20_1 ), deduped_20_1, deduped_20_1, deduped_28_1 ) ), deduped_15_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_12_1, deduped_16_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_22_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                                end ) ), deduped_22_1 ), deduped_22_1, deduped_22_1, deduped_28_1 ), deduped_16_1 ) * KroneckerMat( deduped_17_1, function (  )
                            if (deduped_24_1 = 0) then
                                return HomalgZeroMatrix( (deduped_24_1 * deduped_24_1), 1, deduped_28_1 );
                            else
                                return ConvertMatrixToColumn( deduped_16_1 );
                            fi;
                            return;
                        end(  ) )), deduped_13_1 ), deduped_15_1 ) * KroneckerMat( deduped_17_1, (KroneckerMat( deduped_13_1, deduped_15_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_23_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_8_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                            end ) ), deduped_23_1 ), deduped_23_1, deduped_23_1, deduped_28_1 ), deduped_15_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_27_1, deduped_28_1 ), function (  )
                        if (deduped_25_1 = 0) then
                            return HomalgZeroMatrix( (deduped_25_1 * deduped_25_1), 1, deduped_28_1 );
                        else
                            return ConvertMatrixToColumn( deduped_15_1 );
                        fi;
                        return;
                    end(  ) )) )) );
    morphism_attr_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( deduped_9_1 ), deduped_28_1 ), deduped_9_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 14363 );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := Dimension( list_1[4] );
    deduped_26_1 := Dimension( list_1[2] );
    deduped_25_1 := Dimension( list_1[3] );
    deduped_24_1 := Dimension( list_1[1] );
    deduped_23_1 := deduped_25_1 * deduped_27_1;
    deduped_22_1 := deduped_24_1 * deduped_26_1;
    deduped_21_1 := deduped_24_1 * deduped_25_1;
    deduped_20_1 := deduped_23_1 * deduped_24_1;
    deduped_19_1 := deduped_21_1 * deduped_21_1;
    deduped_18_1 := deduped_22_1 * deduped_23_1;
    deduped_17_1 := HomalgIdentityMatrix( deduped_26_1, deduped_28_1 );
    deduped_16_1 := HomalgIdentityMatrix( deduped_24_1, deduped_28_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_25_1, deduped_28_1 );
    deduped_14_1 := deduped_21_1 * deduped_18_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_23_1, deduped_28_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_22_1, deduped_28_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_21_1, deduped_28_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_18_1, deduped_28_1 );
    hoisted_8_1 := deduped_25_1;
    hoisted_7_1 := deduped_27_1;
    hoisted_6_1 := deduped_26_1;
    hoisted_5_1 := deduped_23_1;
    hoisted_4_1 := deduped_24_1;
    hoisted_3_1 := deduped_18_1;
    hoisted_2_1 := deduped_21_1;
    deduped_9_1 := KroneckerMat( function (  )
                    if (deduped_21_1 = 0) then
                        return HomalgZeroMatrix( 1, deduped_19_1, deduped_28_1 );
                    else
                        return ConvertMatrixToRow( deduped_11_1 );
                    fi;
                    return;
                end(  ), deduped_10_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_28_1 ), deduped_10_1 ) * KroneckerMat( deduped_11_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_28_1 ) ) * KroneckerMat( TransposedMatrix( deduped_11_1 ), (KroneckerMat( KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_20_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                          end ) ), deduped_20_1 ), deduped_20_1, deduped_20_1, deduped_28_1 ) ), deduped_15_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_12_1, deduped_16_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_22_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                                end ) ), deduped_22_1 ), deduped_22_1, deduped_22_1, deduped_28_1 ), deduped_16_1 ) * KroneckerMat( deduped_17_1, function (  )
                            if (deduped_24_1 = 0) then
                                return HomalgZeroMatrix( (deduped_24_1 * deduped_24_1), 1, deduped_28_1 );
                            else
                                return ConvertMatrixToColumn( deduped_16_1 );
                            fi;
                            return;
                        end(  ) )), deduped_13_1 ), deduped_15_1 ) * KroneckerMat( deduped_17_1, (KroneckerMat( deduped_13_1, deduped_15_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_23_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_8_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                            end ) ), deduped_23_1 ), deduped_23_1, deduped_23_1, deduped_28_1 ), deduped_15_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_27_1, deduped_28_1 ), function (  )
                        if (deduped_25_1 = 0) then
                            return HomalgZeroMatrix( (deduped_25_1 * deduped_25_1), 1, deduped_28_1 );
                        else
                            return ConvertMatrixToColumn( deduped_15_1 );
                        fi;
                        return;
                    end(  ) )) )) );
    morphism_attr_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( deduped_9_1 ), deduped_28_1 ), deduped_9_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 13156 );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    deduped_26_1 := Dimension( list_1[4] );
    deduped_25_1 := Dimension( list_1[2] );
    deduped_24_1 := Dimension( list_1[3] );
    deduped_23_1 := Dimension( list_1[1] );
    deduped_22_1 := deduped_24_1 * deduped_26_1;
    deduped_21_1 := deduped_23_1 * deduped_25_1;
    deduped_20_1 := deduped_23_1 * deduped_24_1;
    deduped_19_1 := deduped_22_1 * deduped_23_1;
    deduped_18_1 := deduped_20_1 * deduped_20_1;
    deduped_17_1 := deduped_21_1 * deduped_22_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_25_1, deduped_27_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_23_1, deduped_27_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_24_1, deduped_27_1 );
    deduped_13_1 := deduped_20_1 * deduped_17_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_22_1, deduped_27_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_21_1, deduped_27_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_20_1, deduped_27_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_17_1, deduped_27_1 );
    hoisted_8_1 := deduped_24_1;
    hoisted_7_1 := deduped_26_1;
    hoisted_6_1 := deduped_25_1;
    hoisted_5_1 := deduped_22_1;
    hoisted_4_1 := deduped_23_1;
    hoisted_3_1 := deduped_17_1;
    hoisted_2_1 := deduped_20_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                    if (deduped_20_1 = 0) then
                        return HomalgZeroMatrix( 1, deduped_18_1, deduped_27_1 );
                    else
                        return ConvertMatrixToRow( deduped_10_1 );
                    fi;
                    return;
                end(  ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_27_1 ), deduped_9_1 ) * KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_27_1 ) ) * KroneckerMat( TransposedMatrix( deduped_10_1 ), (KroneckerMat( KroneckerMat( deduped_11_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                          end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_27_1 ) ), deduped_14_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_11_1, deduped_15_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_21_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                                end ) ), deduped_21_1 ), deduped_21_1, deduped_21_1, deduped_27_1 ), deduped_15_1 ) * KroneckerMat( deduped_16_1, function (  )
                            if (deduped_23_1 = 0) then
                                return HomalgZeroMatrix( (deduped_23_1 * deduped_23_1), 1, deduped_27_1 );
                            else
                                return ConvertMatrixToColumn( deduped_15_1 );
                            fi;
                            return;
                        end(  ) )), deduped_12_1 ), deduped_14_1 ) * KroneckerMat( deduped_16_1, (KroneckerMat( deduped_12_1, deduped_14_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_22_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_8_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                            end ) ), deduped_22_1 ), deduped_22_1, deduped_22_1, deduped_27_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_27_1 ), function (  )
                        if (deduped_24_1 = 0) then
                            return HomalgZeroMatrix( (deduped_24_1 * deduped_24_1), 1, deduped_27_1 );
                        else
                            return ConvertMatrixToColumn( deduped_14_1 );
                        fi;
                        return;
                    end(  ) )) )) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 12953 );
    
    ##
    AddTensorProductOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, KroneckerMat( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( arg2_1 ) * Dimension( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductToInternalHomAdjunctionMap( cat,
        
########
function ( cat_1, a_1, b_1, f_1 )
    local morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := Dimension( a_1 );
    deduped_10_1 := Dimension( b_1 );
    deduped_9_1 := deduped_10_1 * deduped_11_1;
    deduped_8_1 := deduped_10_1 * deduped_10_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_11_1, deduped_12_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_10_1, deduped_12_1 );
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    morphism_attr_3_1 := KroneckerMat( function (  )
                    if (deduped_10_1 = 0) then
                        return HomalgZeroMatrix( 1, deduped_8_1, deduped_12_1 );
                    else
                        return ConvertMatrixToRow( deduped_6_1 );
                    fi;
                    return;
                end(  ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_12_1 ), deduped_7_1 ) * KroneckerMat( deduped_6_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_12_1 ) ) * KroneckerMat( TransposedMatrix( deduped_6_1 ), UnderlyingMatrix( f_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 4822 );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
end
########
        
    , 100 );
    
    ##
    AddTerminalObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
end
########
        
    , 202 );
    
    ##
    AddTerminalObjectFunctorial( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 303 );
    
    ##
    AddTerminalObjectFunctorialWithGivenTerminalObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( Pp_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 );
    
    ##
    AddTraceMap( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := HomalgIdentityMatrix( 1, deduped_9_1 );
    deduped_7_1 := Dimension( Source( alpha_1 ) );
    deduped_6_1 := deduped_7_1 * 1;
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := deduped_7_1 = 0;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_9_1 );
    hoisted_2_1 := deduped_7_1;
    morphism_attr_1_1 := KroneckerMat( function (  )
                      if deduped_4_1 then
                          return HomalgZeroMatrix( 1, deduped_5_1, deduped_9_1 );
                      else
                          return ConvertMatrixToRow( deduped_3_1 );
                      fi;
                      return;
                  end(  ), deduped_8_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_9_1 ), deduped_8_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_9_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), UnderlyingMatrix( alpha_1 ) ) * function (  )
              if deduped_4_1 then
                  return HomalgZeroMatrix( deduped_5_1, 1, deduped_9_1 );
              else
                  return ConvertMatrixToColumn( deduped_3_1 );
              fi;
              return;
          end(  );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5828 );
    
    ##
    AddUniversalMorphismFromCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 503 );
    
    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 504 );
    
    ##
    AddUniversalMorphismFromDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromImage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := tau_1[2];
    morphism_attr_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Source( deduped_2_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 704 );
    
    ##
    AddUniversalMorphismFromImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, tau_1, I_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := tau_1[2];
    morphism_attr_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), Source( deduped_2_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 705 );
    
    ##
    AddUniversalMorphismFromInitialObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 303 );
    
    ##
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddUniversalMorphismFromPushout( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := deduped_10_1;
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := List( morphisms_1, Range );
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) + -1 * UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) ), UnionOfRows( deduped_9_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 4117 );
    
    ##
    AddUniversalMorphismFromPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := deduped_10_1;
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := List( morphisms_1, Range );
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) + -1 * UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) ), UnionOfRows( deduped_9_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 4118 );
    
    ##
    AddUniversalMorphismFromZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoCoimage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := tau_1[1];
    morphism_attr_1_1 := LeftDivide( UnderlyingMatrix( deduped_2_1 ), SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_2_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 704 );
    
    ##
    AddUniversalMorphismIntoCoimageWithGivenCoimage( cat,
        
########
function ( cat_1, alpha_1, tau_1, C_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := tau_1[1];
    morphism_attr_1_1 := LeftDivide( UnderlyingMatrix( deduped_2_1 ), SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_2_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 705 );
    
    ##
    AddUniversalMorphismIntoDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 503 );
    
    ##
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 504 );
    
    ##
    AddUniversalMorphismIntoDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := deduped_10_1;
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( morphisms_1, Source );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    morphism_attr_1_1 := RightDivide( UnionOfColumns( deduped_9_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ), SyzygiesOfRows( UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 4117 );
    
    ##
    AddUniversalMorphismIntoFiberProductWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := deduped_10_1;
    hoisted_4_1 := deduped_9_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( morphisms_1, Source );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_4_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    morphism_attr_1_1 := RightDivide( UnionOfColumns( deduped_9_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ), SyzygiesOfRows( UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) + -1 * UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 4118 );
    
    ##
    AddUniversalMorphismIntoTerminalObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 303 );
    
    ##
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), Dimension( P_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
    ##
    AddUniversalMorphismIntoZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalPropertyOfDual( cat,
        
########
function ( cat_1, t_1, a_1, alpha_1 )
    local morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := Dimension( t_1 );
    deduped_10_1 := Dimension( a_1 );
    deduped_9_1 := deduped_10_1 * deduped_11_1;
    deduped_8_1 := deduped_10_1 * deduped_10_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_11_1, deduped_12_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_10_1, deduped_12_1 );
    hoisted_5_1 := deduped_11_1;
    hoisted_4_1 := deduped_10_1;
    morphism_attr_3_1 := KroneckerMat( function (  )
                    if (deduped_10_1 = 0) then
                        return HomalgZeroMatrix( 1, deduped_8_1, deduped_12_1 );
                    else
                        return ConvertMatrixToRow( deduped_6_1 );
                    fi;
                    return;
                end(  ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_12_1 ), deduped_7_1 ) * KroneckerMat( deduped_6_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_12_1 ) ) * KroneckerMat( TransposedMatrix( deduped_6_1 ), UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( morphism_attr_3_1 ) ), a_1, UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 5124 );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( a_1 ), Dimension( b_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
end
########
        
    , 100 );
    
    ##
    AddZeroObjectFunctorial( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 );
    
    ##
    AddZeroObjectFunctorialWithGivenZeroObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 );
    
end );

BindGlobal( "MatrixCategoryPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( field )
    return MATRIX_CATEGORY( field );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_MatrixCategoryPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
