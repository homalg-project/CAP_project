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
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, -1 * UnderlyingMatrix( a_1 ) );
end
########
        
    );
    
    ##
    AddAssociatorLeftToRight( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( s_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddAssociatorRightToLeft( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( s_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddAstrictionToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( cap_jit_deduplicated_expression_1_1 ) ), cap_jit_deduplicated_expression_1_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddAstrictionToCoimageWithGivenCoimage( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( cap_jit_deduplicated_expression_1_1 ) ), cap_jit_deduplicated_expression_1_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_2_1 := Dimension( arg2_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( arg3_1 );
    cap_jit_deduplicated_expression_1_1 := cap_jit_deduplicated_expression_2_1 * cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, UnderlyingRing( cat_1 ) );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_2_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_3_1;
    return List( [ 1 .. cap_jit_deduplicated_expression_1_1 ], function ( logic_new_func_x_2 )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( CertainRows( cap_jit_hoisted_expression_1_1, [ logic_new_func_x_2 ] ), cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1 ) );
        end );
end
########
        
    );
    
    ##
    AddBraiding( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_2_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_1_1 := cap_jit_deduplicated_expression_3_1 * cap_jit_deduplicated_expression_2_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_2_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_morphism_attribute_1_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_1_1 ], function ( i_2 )
                  local cap_jit_deduplicated_expression_1_2;
                  cap_jit_deduplicated_expression_1_2 := i_2 - 1;
                  return REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_2_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1;
              end ) ), cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddBraidingInverse( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_2_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_1_1 := cap_jit_deduplicated_expression_2_1 * cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_2_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_morphism_attribute_1_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_1_1 ], function ( i_2 )
                  local cap_jit_deduplicated_expression_1_2;
                  cap_jit_deduplicated_expression_1_2 := i_2 - 1;
                  return REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_2_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1;
              end ) ), cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Dimension( s_1 );
    cap_jit_hoisted_expression_1_1 := Dimension( a_1 );
    cap_jit_hoisted_expression_2_1 := Dimension( b_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_1_1 ], function ( i_2 )
                    local cap_jit_deduplicated_expression_1_2;
                    cap_jit_deduplicated_expression_1_2 := i_2 - 1;
                    return REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_2_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1;
                end ) ), cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Dimension( s_1 );
    cap_jit_hoisted_expression_1_1 := Dimension( b_1 );
    cap_jit_hoisted_expression_2_1 := Dimension( a_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_1_1 ], function ( i_2 )
                    local cap_jit_deduplicated_expression_1_2;
                    cap_jit_deduplicated_expression_1_2 := i_2 - 1;
                    return REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_2_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1;
                end ) ), cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddCoastrictionToImage( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := RightDivide( cap_jit_deduplicated_expression_1_1, SyzygiesOfRows( SyzygiesOfColumns( cap_jit_deduplicated_expression_1_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCoastrictionToImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := RightDivide( cap_jit_deduplicated_expression_1_1, SyzygiesOfRows( SyzygiesOfColumns( cap_jit_deduplicated_expression_1_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return EntriesOfHomalgMatrix( UnderlyingMatrix( arg2_1 ) );
end
########
        
    );
    
    ##
    AddCoevaluationForDual( cat,
        
########
function ( cat_1, a_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_morphism_attribute_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    cap_jit_deduplicated_expression_2_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_3_1 := UnderlyingRing( cat_1 );
    if cap_jit_deduplicated_expression_2_1 = 0 then
        cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_2_1 * cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1 );
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, cap_jit_deduplicated_expression_1_1, ObjectifyObjectForCAPWithAttributes( rec(
                 ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
    else
        cap_jit_morphism_attribute_2_1 := ConvertMatrixToRow( HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1 ) );
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, cap_jit_deduplicated_expression_1_1, ObjectifyObjectForCAPWithAttributes( rec(
                 ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_2_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_2_1 );
    fi;
    return;
end
########
        
    );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    if cap_jit_deduplicated_expression_1_1 = 0 then
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( s_1 ), Dimension( r_1 ), cap_jit_deduplicated_expression_2_1 ) );
    else
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ) ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddCoevaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_5_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_7_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_6_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_3_1 := cap_jit_deduplicated_expression_5_1 * cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_4_1 := cap_jit_deduplicated_expression_5_1 * cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                  if (cap_jit_deduplicated_expression_5_1 = 0) then
                      return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 );
                  else
                      return ConvertMatrixToRow( cap_jit_deduplicated_expression_1_1 );
                  fi;
                  return;
              end(  ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( cap_jit_deduplicated_expression_1_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_4_1 ], function ( i_2 )
                      local cap_jit_deduplicated_expression_1_2;
                      cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                      return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                  end ) ), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_7_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCoevaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_5_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_7_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_6_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_3_1 := cap_jit_deduplicated_expression_5_1 * cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_4_1 := cap_jit_deduplicated_expression_5_1 * cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                  if (cap_jit_deduplicated_expression_5_1 = 0) then
                      return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 );
                  else
                      return ConvertMatrixToRow( cap_jit_deduplicated_expression_1_1 );
                  fi;
                  return;
              end(  ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( cap_jit_deduplicated_expression_1_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_4_1 ], function ( i_2 )
                      local cap_jit_deduplicated_expression_1_2;
                      cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                      return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                  end ) ), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_7_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCoimage( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfRows( UnderlyingMatrix( arg2_1 ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ) );
end
########
        
    );
    
    ##
    AddCoimageProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCoimageProjectionWithGivenCoimage( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCokernelColift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( tau_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( tau_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( tau_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( tau_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ) );
end
########
        
    );
    
    ##
    AddCokernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( mu_1 ) * SyzygiesOfColumns( UnderlyingMatrix( alphap_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCokernelObjectFunctorialWithGivenCokernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( mu_1 ) * SyzygiesOfColumns( UnderlyingMatrix( alphap_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( epsilon_1 ), Range( tau_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( epsilon_1 ), UnderlyingMatrix( tau_1 ) ) );
end
########
        
    );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_2_1 := List( S_1, Dimension );
    cap_jit_deduplicated_expression_1_1 := Sum( cap_jit_deduplicated_expression_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1[i_1], Range( alpha_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( alpha_1 ), [ cap_jit_deduplicated_expression_1_1 .. cap_jit_deduplicated_expression_1_1 - 1 + cap_jit_deduplicated_expression_2_1[i_1] ] ) );
end
########
        
    );
    
    ##
    AddComponentOfMorphismIntoDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_2_1 := List( S_1, Dimension );
    cap_jit_deduplicated_expression_1_1 := Sum( cap_jit_deduplicated_expression_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), S_1[i_1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( alpha_1 ), [ cap_jit_deduplicated_expression_1_1 .. cap_jit_deduplicated_expression_1_1 - 1 + cap_jit_deduplicated_expression_2_1[i_1] ] ) );
end
########
        
    );
    
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
        
    );
    
    ##
    AddCoproductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( objectsp_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( cap_jit_deduplicated_expression_1_1, Sum( List( objectsp_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( objectsp_1[logic_new_func_x_2] );
              return UnderlyingMatrix( L_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( objectsp_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( objectsp_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddCoproductFunctorialWithGivenCoproducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( objectsp_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( cap_jit_deduplicated_expression_1_1, Dimension( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( objectsp_1[logic_new_func_x_2] );
              return UnderlyingMatrix( L_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( objectsp_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( objectsp_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Pp_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
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
        
    );
    
    ##
    AddDirectProductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( objects_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( cap_jit_deduplicated_expression_1_1, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( objects_1[logic_new_func_x_2] );
              return UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( Sum( objects_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) ) * UnderlyingMatrix( L_1[logic_new_func_x_2] );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddDirectProductFunctorialWithGivenDirectProducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( objects_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( cap_jit_deduplicated_expression_1_1, Dimension( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( objects_1[logic_new_func_x_2] );
              return UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( Sum( objects_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) ) * UnderlyingMatrix( L_1[logic_new_func_x_2] );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
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
        
    );
    
    ##
    AddDirectSumCodiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( D_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := List( D_1, Range );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( D_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddDirectSumDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( D_1 );
    cap_jit_hoisted_expression_1_1 := List( D_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( D_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddDirectSumFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := DiagMat( UnderlyingRing( cat_1 ), List( L_1, function ( mor_2 )
              return UnderlyingMatrix( mor_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
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
        
    );
    
    ##
    AddDirectSumProjectionInPushout( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( D_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := List( D_1, Range );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( D_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    cap_jit_morphism_attribute_1_1 := SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
end
########
        
    );
    
    ##
    AddDualOnMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Source( alpha_1 ), UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddDualOnMorphismsWithGivenDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddDualOnObjects( cat,
        
########
function ( cat_1, a_1 )
    return a_1;
end
########
        
    );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddEvaluationForDual( cat,
        
########
function ( cat_1, a_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_morphism_attribute_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    cap_jit_deduplicated_expression_2_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_3_1 := UnderlyingRing( cat_1 );
    if cap_jit_deduplicated_expression_2_1 = 0 then
        cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( cap_jit_deduplicated_expression_2_1 * cap_jit_deduplicated_expression_2_1, 1, cap_jit_deduplicated_expression_3_1 );
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                 ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
    else
        cap_jit_morphism_attribute_2_1 := ConvertMatrixToColumn( HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1 ) );
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                 ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_2_1 ) ), cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_2_1 );
    fi;
    return;
end
########
        
    );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    if cap_jit_deduplicated_expression_1_1 = 0 then
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( s_1 ), Dimension( r_1 ), cap_jit_deduplicated_expression_2_1 ) );
    else
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
               ), cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ) ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddEvaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_4_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_2_1 := cap_jit_deduplicated_expression_4_1 * cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_2_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_2_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_2_1 ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_5_1 ), function (  )
                if (cap_jit_deduplicated_expression_4_1 = 0) then
                    return HomalgZeroMatrix( (cap_jit_deduplicated_expression_4_1 * cap_jit_deduplicated_expression_4_1), 1, cap_jit_deduplicated_expression_5_1 );
                else
                    return ConvertMatrixToColumn( cap_jit_deduplicated_expression_1_1 );
                fi;
                return;
            end(  ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddEvaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_4_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_2_1 := cap_jit_deduplicated_expression_4_1 * cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_2_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_2_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_2_1 ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_5_1 ), function (  )
                if (cap_jit_deduplicated_expression_4_1 = 0) then
                    return HomalgZeroMatrix( (cap_jit_deduplicated_expression_4_1 * cap_jit_deduplicated_expression_4_1), 1, cap_jit_deduplicated_expression_5_1 );
                else
                    return ConvertMatrixToColumn( cap_jit_deduplicated_expression_1_1 );
                fi;
                return;
            end(  ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddFiberProduct( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( arg2_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( arg2_1 );
    cap_jit_hoisted_expression_1_1 := List( arg2_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( arg2_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} ) ) ) );
end
########
        
    );
    
    ##
    AddFiberProductEmbeddingInDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( D_1 );
    cap_jit_hoisted_expression_1_1 := List( D_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( D_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    cap_jit_morphism_attribute_1_1 := SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddFiberProductFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_hoisted_expression_8_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1;
    cap_jit_deduplicated_expression_6_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_8_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_9_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := List( morphisms_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_8_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_2_1 := List( [ 1 .. cap_jit_deduplicated_expression_9_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_4_1 := Sum( cap_jit_deduplicated_expression_6_1 );
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1{[ 1 .. cap_jit_deduplicated_expression_9_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1{[ 2 .. cap_jit_deduplicated_expression_9_1 ]} ) );
    cap_jit_deduplicated_expression_10_1 := Length( morphismsp_1 );
    cap_jit_deduplicated_expression_7_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_hoisted_expression_6_1 := List( morphismsp_1, Source );
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_hoisted_expression_8_1 := cap_jit_deduplicated_expression_10_1;
    cap_jit_deduplicated_expression_3_1 := List( [ 1 .. cap_jit_deduplicated_expression_10_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_7_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_6_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_6_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_8_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_5_1 := Sum( cap_jit_deduplicated_expression_7_1 );
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_morphism_attribute_1_1 := RightDivide( UnionOfColumns( cap_jit_deduplicated_expression_8_1, NumberRows( cap_jit_deduplicated_expression_1_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local cap_jit_deduplicated_expression_1_2;
                cap_jit_deduplicated_expression_1_2 := Sum( cap_jit_hoisted_expression_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return CertainColumns( cap_jit_hoisted_expression_5_1, [ cap_jit_deduplicated_expression_1_2 .. (cap_jit_deduplicated_expression_1_2 - 1 + cap_jit_hoisted_expression_2_1[logic_new_func_x_2]) ] ) * UnderlyingMatrix( L_1[logic_new_func_x_2] );
            end ) ), SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1{[ 1 .. cap_jit_deduplicated_expression_10_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1{[ 2 .. cap_jit_deduplicated_expression_10_1 ]} ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddFiberProductFunctorialWithGivenFiberProducts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_hoisted_expression_8_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_5_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_7_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_8_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := List( morphisms_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_8_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_8_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_6_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_9_1 := Length( morphismsp_1 );
    cap_jit_hoisted_expression_6_1 := List( morphismsp_1, Source );
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_8_1 := cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_2_1 := List( [ 1 .. cap_jit_deduplicated_expression_9_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_7_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_6_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_6_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_8_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_4_1 := Sum( cap_jit_deduplicated_expression_6_1 );
    cap_jit_hoisted_expression_5_1 := SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_8_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_8_1 ]} ) );
    cap_jit_morphism_attribute_1_1 := RightDivide( UnionOfColumns( cap_jit_deduplicated_expression_7_1, Dimension( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local cap_jit_deduplicated_expression_1_2;
                cap_jit_deduplicated_expression_1_2 := Sum( cap_jit_hoisted_expression_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return CertainColumns( cap_jit_hoisted_expression_5_1, [ cap_jit_deduplicated_expression_1_2 .. (cap_jit_deduplicated_expression_1_2 - 1 + cap_jit_hoisted_expression_2_1[logic_new_func_x_2]) ] ) * UnderlyingMatrix( L_1[logic_new_func_x_2] );
            end ) ), SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1{[ 1 .. cap_jit_deduplicated_expression_9_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1{[ 2 .. cap_jit_deduplicated_expression_9_1 ]} ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( beta_1 ) ) * SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ) );
end
########
        
    );
    
    ##
    AddHomologyObjectFunctorialWithGivenHomologyObjects( cat,
        
########
function ( cat_1, H_1_1, L_1, H_2_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1;
    cap_jit_deduplicated_expression_4_1 := SyzygiesOfColumns( UnderlyingMatrix( L_1[4] ) );
    cap_jit_deduplicated_expression_2_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( L_1[5] ) ) * cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( NumberRows( cap_jit_deduplicated_expression_2_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_2_1 ), UnderlyingRing( cat_1 ) );
    cap_jit_deduplicated_expression_3_1 := SyzygiesOfColumns( UnderlyingMatrix( L_1[1] ) );
    cap_jit_morphism_attribute_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( L_1[2] ) ) * cap_jit_deduplicated_expression_3_1 ) ) * LeftDivide( cap_jit_deduplicated_expression_3_1, (UnderlyingMatrix( L_1[3] ) * cap_jit_deduplicated_expression_4_1) ), SyzygiesOfRows( cap_jit_deduplicated_expression_2_1 ) ) * RightDivide( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, source_1, range_1, UnderlyingMatrix, KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( arg2_1 ) * Dimension( arg3_1 ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddImageEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddImageEmbeddingWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddImageObject( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfColumns( UnderlyingMatrix( arg2_1 ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ) );
end
########
        
    );
    
    ##
    AddInitialObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
end
########
        
    );
    
    ##
    AddInitialObjectFunctorial( cat,
        
########
function ( cat_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInitialObjectFunctorialWithGivenInitialObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( Pp_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_1_1 := Dimension( cap_jit_deduplicated_expression_3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_2_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_3_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_1_1 := Dimension( cap_jit_deduplicated_expression_3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_2_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_3_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_1_1 := Dimension( cap_jit_deduplicated_expression_3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_2_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_3_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_1_1 := Dimension( cap_jit_deduplicated_expression_3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_3_1, P_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), cap_jit_deduplicated_expression_2_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), cap_jit_deduplicated_expression_2_1 ) ) );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_4_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := List( morphisms_1, Range );
    cap_jit_deduplicated_expression_6_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_7_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_7_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_4_1{[ 1 .. k_1 - 1 ]} ) + 1;
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_morphism_attribute_1_1 := CertainRows( SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_7_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_7_1 ]} ) ), [ cap_jit_deduplicated_expression_2_1 .. cap_jit_deduplicated_expression_2_1 - 1 + cap_jit_deduplicated_expression_4_1[k_1] ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_5_1[k_1], ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_4_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := List( morphisms_1, Range );
    cap_jit_deduplicated_expression_6_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_7_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_7_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_4_1{[ 1 .. k_1 - 1 ]} ) + 1;
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_morphism_attribute_1_1 := CertainRows( SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_7_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_7_1 ]} ) ), [ cap_jit_deduplicated_expression_2_1 .. cap_jit_deduplicated_expression_2_1 - 1 + cap_jit_deduplicated_expression_4_1[k_1] ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_5_1[k_1], ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInjectiveColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddInternalHomOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInternalHomOnMorphismsWithGivenInternalHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInternalHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
end
########
        
    );
    
    ##
    AddInternalHomToTensorProductAdjunctionMap( cat,
        
########
function ( cat_1, b_1, c_1, g_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_4_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( c_1 );
    cap_jit_deduplicated_expression_2_1 := cap_jit_deduplicated_expression_4_1 * cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( UnderlyingMatrix( g_1 ), cap_jit_deduplicated_expression_1_1 ) * (KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_2_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_2_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_2_1 ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_5_1 ), function (  )
                  if (cap_jit_deduplicated_expression_4_1 = 0) then
                      return HomalgZeroMatrix( (cap_jit_deduplicated_expression_4_1 * cap_jit_deduplicated_expression_4_1), 1, cap_jit_deduplicated_expression_5_1 );
                  else
                      return ConvertMatrixToColumn( cap_jit_deduplicated_expression_1_1 );
                  fi;
                  return;
              end(  ) ));
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( UnderlyingMatrix( arg4_1 ), Dimension( arg2_1 ), Dimension( arg3_1 ) ) );
end
########
        
    );
    
    ##
    AddInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Range( alpha_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, Source( alpha_1 ), UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddInverseMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_2_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_deduplicated_expression_1_1 := RightDivide( LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( cap_jit_deduplicated_expression_2_1 ) ), cap_jit_deduplicated_expression_2_1 ), SyzygiesOfRows( SyzygiesOfColumns( cap_jit_deduplicated_expression_2_1 ) ) );
    cap_jit_morphism_attribute_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) ), cap_jit_deduplicated_expression_1_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsAutomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Dimension( Source( arg2_1 ) );
    cap_jit_deduplicated_expression_2_1 := Dimension( Range( arg2_1 ) );
    return cap_jit_deduplicated_expression_1_1 = cap_jit_deduplicated_expression_2_1 and (cap_jit_deduplicated_expression_2_1 = cap_jit_deduplicated_expression_1_1 and ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = cap_jit_deduplicated_expression_2_1);
end
########
        
    );
    
    ##
    AddIsCodominating( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( SyzygiesOfRows( UnderlyingMatrix( arg3_1 ) ) * UnderlyingMatrix( arg2_1 ) );
end
########
        
    );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddIsColiftableAlongEpimorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
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
    AddIsDominating( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( UnderlyingMatrix( arg2_1 ) * SyzygiesOfColumns( UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    );
    
    ##
    AddIsEndomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( Source( arg2_1 ) ) = Dimension( Range( arg2_1 ) );
end
########
        
    );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = Dimension( Range( arg2_1 ) );
end
########
        
    );
    
    ##
    AddIsEqualAsFactorobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( arg3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingMatrix( arg2_1 );
    return IsZero( SyzygiesOfRows( cap_jit_deduplicated_expression_1_1 ) * cap_jit_deduplicated_expression_2_1 ) and IsZero( SyzygiesOfRows( cap_jit_deduplicated_expression_2_1 ) * cap_jit_deduplicated_expression_1_1 );
end
########
        
    );
    
    ##
    AddIsEqualAsSubobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( arg2_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingMatrix( arg3_1 );
    return IsZero( cap_jit_deduplicated_expression_1_1 * SyzygiesOfColumns( cap_jit_deduplicated_expression_2_1 ) ) and IsZero( cap_jit_deduplicated_expression_2_1 * SyzygiesOfColumns( cap_jit_deduplicated_expression_1_1 ) );
end
########
        
    );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
end
########
        
    );
    
    ##
    AddIsEqualForMorphismsOnMor( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Dimension( Source( arg2_1 ) ) = Dimension( Source( arg3_1 ) );
    cap_jit_deduplicated_expression_2_1 := Dimension( Range( arg2_1 ) ) = Dimension( Range( arg3_1 ) );
    if cap_jit_deduplicated_expression_1_1 = fail or cap_jit_deduplicated_expression_2_1 = fail then
        return fail;
    elif cap_jit_deduplicated_expression_1_1 = false or cap_jit_deduplicated_expression_2_1 = false then
        return false;
    else
        return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return Dimension( arg2_1 ) = Dimension( arg3_1 );
end
########
        
    );
    
    ##
    AddIsIdempotent( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( arg2_1 );
    return cap_jit_deduplicated_expression_1_1 * cap_jit_deduplicated_expression_1_1 = cap_jit_deduplicated_expression_1_1;
end
########
        
    );
    
    ##
    AddIsIdenticalToIdentityMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := Dimension( Source( arg2_1 ) );
    cap_jit_deduplicated_expression_1_1 := cap_jit_deduplicated_expression_3_1 = cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_2_1 := Dimension( Range( arg2_1 ) ) = cap_jit_deduplicated_expression_3_1;
    if cap_jit_deduplicated_expression_1_1 = fail or cap_jit_deduplicated_expression_2_1 = fail then
        return fail;
    elif cap_jit_deduplicated_expression_1_1 = false or cap_jit_deduplicated_expression_2_1 = false then
        return false;
    else
        return UnderlyingMatrix( arg2_1 ) = HomalgIdentityMatrix( cap_jit_deduplicated_expression_3_1, UnderlyingRing( cat_1 ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsIdenticalToZeroMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1;
    cap_jit_deduplicated_expression_3_1 := Dimension( Source( arg2_1 ) );
    cap_jit_deduplicated_expression_1_1 := cap_jit_deduplicated_expression_3_1 = cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_4_1 := Dimension( Range( arg2_1 ) );
    cap_jit_deduplicated_expression_2_1 := cap_jit_deduplicated_expression_4_1 = cap_jit_deduplicated_expression_4_1;
    if cap_jit_deduplicated_expression_1_1 = fail or cap_jit_deduplicated_expression_2_1 = fail then
        return fail;
    elif cap_jit_deduplicated_expression_1_1 = false or cap_jit_deduplicated_expression_2_1 = false then
        return false;
    else
        return UnderlyingMatrix( arg2_1 ) = HomalgZeroMatrix( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, UnderlyingRing( cat_1 ) );
    fi;
    return;
end
########
        
    );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    );
    
    ##
    AddIsInjective( cat,
        
########
function ( cat_1, arg2_1 )
    return true;
end
########
        
    );
    
    ##
    AddIsIsomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Dimension( Range( arg2_1 ) );
    return cap_jit_deduplicated_expression_1_1 = Dimension( Source( arg2_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = cap_jit_deduplicated_expression_1_1;
end
########
        
    );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    );
    
    ##
    AddIsLiftableAlongMonomorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = Dimension( Source( arg2_1 ) );
end
########
        
    );
    
    ##
    AddIsOne( cat,
        
########
function ( cat_1, arg2_1 )
    return HomalgIdentityMatrix( Dimension( Source( arg2_1 ) ), UnderlyingRing( cat_1 ) ) = UnderlyingMatrix( arg2_1 );
end
########
        
    );
    
    ##
    AddIsProjective( cat,
        
########
function ( cat_1, arg2_1 )
    return true;
end
########
        
    );
    
    ##
    AddIsSplitEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroRows( HomalgIdentityMatrix( Dimension( Range( arg2_1 ) ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddIsSplitMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroColumns( HomalgIdentityMatrix( Dimension( Source( arg2_1 ) ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddIsTerminal( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( arg2_1 );
    if not true then
        return false;
    elif NumberRows( cap_jit_deduplicated_expression_1_1 ) <> Dimension( Source( arg2_1 ) ) then
        return false;
    elif NumberColumns( cap_jit_deduplicated_expression_1_1 ) <> Dimension( Range( arg2_1 ) ) then
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
    elif Dimension( arg2_1 ) < 0 then
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
    return Dimension( arg2_1 ) = 0;
end
########
        
    );
    
    ##
    AddIsomorphismFromCoimageToCokernelOfKernel( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromCokernelOfDiagonalDifferenceToPushout( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_4_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_6_1 := Length( D_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_2_1 := List( D_1, Range );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_2_1 := List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( D_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_1_1 := UnionOfRows( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_2_1{[ 1 .. cap_jit_deduplicated_expression_6_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_2_1{[ 2 .. cap_jit_deduplicated_expression_6_1 ]} );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_5_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromCokernelOfKernelToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromCoproductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromDirectProductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromDirectSumToCoproduct( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromDirectSumToDirectProduct( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromDualToInternalHom( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddIsomorphismFromFiberProductToKernelOfDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_4_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_6_1 := Length( D_1 );
    cap_jit_hoisted_expression_1_1 := List( D_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_2_1 := List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( D_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_1_1 := UnionOfColumns( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_2_1{[ 1 .. cap_jit_deduplicated_expression_6_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_2_1{[ 2 .. cap_jit_deduplicated_expression_6_1 ]} );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberRows( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_5_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( beta_1 ) ) * SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberRows( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromImageObjectToKernelOfCokernel( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberRows( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromInitialObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromInternalHomToDual( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddIsomorphismFromInternalHomToObject( cat,
        
########
function ( cat_1, a_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1;
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( 1, cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_2_1 := 1 * cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_2_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * 1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_2_1 ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1 ), function (  )
                if (1 = 0) then
                    return HomalgZeroMatrix( (1 * 1), 1, cap_jit_deduplicated_expression_4_1 );
                else
                    return ConvertMatrixToColumn( cap_jit_deduplicated_expression_1_1 );
                fi;
                return;
            end(  ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromInternalHomToObjectWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, s_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1;
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( 1, cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_2_1 := 1 * cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_2_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * 1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_2_1 ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1 ), function (  )
                if (1 = 0) then
                    return HomalgZeroMatrix( (1 * 1), 1, cap_jit_deduplicated_expression_4_1 );
                else
                    return ConvertMatrixToColumn( cap_jit_deduplicated_expression_1_1 );
                fi;
                return;
            end(  ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromInternalHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromItsConstructionAsAnImageObjectToHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_2_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( beta_1 ) ) * SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( NumberRows( cap_jit_deduplicated_expression_2_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_2_1 ), UnderlyingRing( cat_1 ) );
    cap_jit_morphism_attribute_1_1 := RightDivide( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromKernelOfCokernelToImageObject( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberRows( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromKernelOfDiagonalDifferenceToFiberProduct( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_4_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_6_1 := Length( D_1 );
    cap_jit_hoisted_expression_1_1 := List( D_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_2_1 := List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( D_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_1_1 := UnionOfColumns( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_2_1{[ 1 .. cap_jit_deduplicated_expression_6_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_2_1{[ 2 .. cap_jit_deduplicated_expression_6_1 ]} );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberRows( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_5_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromObjectToInternalHom( cat,
        
########
function ( cat_1, a_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( 1, cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_4_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_3_1 := 1 * cap_jit_deduplicated_expression_4_1;
    cap_jit_deduplicated_expression_6_1 := 1 * 1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if (1 = 0) then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_5_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_1_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, 1 ) * 1 + QUO_INT( cap_jit_deduplicated_expression_1_2, 1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_6_1 ), cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( cap_jit_deduplicated_expression_1_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * 1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_5_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromObjectToInternalHomWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, r_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( 1, cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_4_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_3_1 := 1 * cap_jit_deduplicated_expression_4_1;
    cap_jit_deduplicated_expression_6_1 := 1 * 1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if (1 = 0) then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_5_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_1_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, 1 ) * 1 + QUO_INT( cap_jit_deduplicated_expression_1_2, 1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_6_1 ), cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( cap_jit_deduplicated_expression_1_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * 1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_5_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromPushoutToCokernelOfDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_4_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_6_1 := Length( D_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_2_1 := List( D_1, Range );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_2_1 := List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( D_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_1_1 := UnionOfRows( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_2_1{[ 1 .. cap_jit_deduplicated_expression_6_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_2_1{[ 2 .. cap_jit_deduplicated_expression_6_1 ]} );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_5_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromTensorProductToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromTerminalObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromZeroObjectToInitialObject( cat,
        
########
function ( cat_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddIsomorphismFromZeroObjectToTerminalObject( cat,
        
########
function ( cat_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddKernelEmbeddingWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddKernelLift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := RightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := RightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ) );
end
########
        
    );
    
    ##
    AddKernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := RightDivide( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) * UnderlyingMatrix( mu_1 ), SyzygiesOfRows( UnderlyingMatrix( alphap_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddKernelObjectFunctorialWithGivenKernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := RightDivide( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) * UnderlyingMatrix( mu_1 ), SyzygiesOfRows( UnderlyingMatrix( alphap_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddLambdaElimination( cat,
        
########
function ( cat_1, a_1, b_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_4_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_2_1 := cap_jit_deduplicated_expression_4_1 * cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( UnderlyingMatrix( alpha_1 ), cap_jit_deduplicated_expression_1_1 ) * (KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_2_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_2_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_2_1 ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_5_1 ), function (  )
                  if (cap_jit_deduplicated_expression_4_1 = 0) then
                      return HomalgZeroMatrix( (cap_jit_deduplicated_expression_4_1 * cap_jit_deduplicated_expression_4_1), 1, cap_jit_deduplicated_expression_5_1 );
                  else
                      return ConvertMatrixToColumn( cap_jit_deduplicated_expression_1_1 );
                  fi;
                  return;
              end(  ) ));
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddLambdaIntroduction( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_4_1 := Dimension( Source( alpha_1 ) );
    cap_jit_deduplicated_expression_6_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_6_1 );
    cap_jit_deduplicated_expression_2_1 := cap_jit_deduplicated_expression_4_1 * cap_jit_deduplicated_expression_4_1;
    cap_jit_deduplicated_expression_3_1 := cap_jit_deduplicated_expression_4_1 * 1;
    cap_jit_deduplicated_expression_5_1 := HomalgIdentityMatrix( 1, cap_jit_deduplicated_expression_6_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if (cap_jit_deduplicated_expression_4_1 = 0) then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_6_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_1_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_2_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_2_1 ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_6_1 ), cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( cap_jit_deduplicated_expression_1_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, 1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, 1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_6_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddLeftDistributivityExpanding( cat,
        
########
function ( cat_1, a_1, L_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Dimension( a_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( L_1 );
    cap_jit_hoisted_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 * Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( cap_jit_hoisted_expression_3_1, UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddLeftDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( L_1 );
    cap_jit_hoisted_expression_3_1 := HomalgIdentityMatrix( Dimension( a_1 ), cap_jit_deduplicated_expression_1_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( cap_jit_deduplicated_expression_1_1, Dimension( s_1 ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( cap_jit_hoisted_expression_3_1, UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddLeftDistributivityFactoring( cat,
        
########
function ( cat_1, a_1, L_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Dimension( a_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( L_1 );
    cap_jit_hoisted_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 * Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( cap_jit_hoisted_expression_3_1, UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ) ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddLeftDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( L_1 );
    cap_jit_hoisted_expression_3_1 := HomalgIdentityMatrix( Dimension( a_1 ), cap_jit_deduplicated_expression_1_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( cap_jit_deduplicated_expression_1_1, Dimension( r_1 ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( cap_jit_hoisted_expression_3_1, UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ) ) );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), r_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddLeftUnitor( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddLeftUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), Source( iota_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( iota_1 ) ) );
end
########
        
    );
    
    ##
    AddMereExistenceOfSolutionOfLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_1_1 := [ 1 .. Length( arg2_1 ) ];
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_3_1 := arg2_1[1];
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := arg3_1[1];
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_2_1;
    return IsZero( DecideZeroRows( UnionOfColumns( cap_jit_deduplicated_expression_2_1, 1, List( cap_jit_deduplicated_expression_1_1, function ( logic_new_func_x_2 )
                  return ConvertMatrixToRow( UnderlyingMatrix( arg4_1[logic_new_func_x_2] ) );
              end ) ), UnionOfRows( cap_jit_deduplicated_expression_2_1, Sum( List( cap_jit_deduplicated_expression_1_1, function ( logic_new_func_x_2 )
                    return Dimension( Source( arg2_1[logic_new_func_x_2][1] ) ) * Dimension( Range( arg3_1[logic_new_func_x_2][1] ) );
                end ) ), List( [ 1 .. Length( cap_jit_deduplicated_expression_3_1 ) ], function ( logic_new_func_x_2 )
                  return UnionOfColumns( cap_jit_hoisted_expression_4_1, Dimension( Range( cap_jit_hoisted_expression_1_1[logic_new_func_x_2] ) ) * Dimension( Source( cap_jit_hoisted_expression_2_1[logic_new_func_x_2] ) ), List( cap_jit_hoisted_expression_3_1, function ( logic_new_func_x_3 )
                            return KroneckerMat( TransposedMatrix( UnderlyingMatrix( arg2_1[logic_new_func_x_3][logic_new_func_x_2] ) ), UnderlyingMatrix( arg3_1[logic_new_func_x_3][logic_new_func_x_2] ) );
                        end ) );
              end ) ) ) );
end
########
        
    );
    
    ##
    AddMonoidalPostComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_11_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_12_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_13_1 := Dimension( c_1 );
    cap_jit_deduplicated_expression_14_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_8_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_13_1;
    cap_jit_deduplicated_expression_9_1 := cap_jit_deduplicated_expression_11_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_deduplicated_expression_6_1 := cap_jit_deduplicated_expression_8_1 * cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_14_1 );
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_11_1 * cap_jit_deduplicated_expression_11_1;
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_14_1 );
    cap_jit_deduplicated_expression_3_1 := cap_jit_deduplicated_expression_11_1 * cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_4_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_14_1 );
    cap_jit_deduplicated_expression_5_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_14_1 );
    cap_jit_deduplicated_expression_7_1 := cap_jit_deduplicated_expression_11_1 = 0;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_11_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_13_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if cap_jit_deduplicated_expression_7_1 then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_14_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_4_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_10_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_10_1 ), cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( cap_jit_deduplicated_expression_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_14_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_4_1 ), (KroneckerMat( cap_jit_deduplicated_expression_2_1, KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_9_1 ], function ( i_2 )
                                local cap_jit_deduplicated_expression_1_2;
                                cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                            end ) ), cap_jit_deduplicated_expression_9_1 ), cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_4_1 ) * KroneckerMat( cap_jit_deduplicated_expression_5_1, function (  )
                        if cap_jit_deduplicated_expression_7_1 then
                            return HomalgZeroMatrix( cap_jit_deduplicated_expression_10_1, 1, cap_jit_deduplicated_expression_14_1 );
                        else
                            return ConvertMatrixToColumn( cap_jit_deduplicated_expression_4_1 );
                        fi;
                        return;
                    end(  ) ) ) * (KroneckerMat( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_8_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_4_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_4_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_8_1 ), cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1 ), function (  )
                      if (cap_jit_deduplicated_expression_12_1 = 0) then
                          return HomalgZeroMatrix( (cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_12_1), 1, cap_jit_deduplicated_expression_14_1 );
                      else
                          return ConvertMatrixToColumn( cap_jit_deduplicated_expression_5_1 );
                      fi;
                      return;
                  end(  ) ))) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMonoidalPostComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_11_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_12_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_13_1 := Dimension( c_1 );
    cap_jit_deduplicated_expression_14_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_8_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_13_1;
    cap_jit_deduplicated_expression_9_1 := cap_jit_deduplicated_expression_11_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_deduplicated_expression_6_1 := cap_jit_deduplicated_expression_8_1 * cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_14_1 );
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_11_1 * cap_jit_deduplicated_expression_11_1;
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_14_1 );
    cap_jit_deduplicated_expression_3_1 := cap_jit_deduplicated_expression_11_1 * cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_4_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_14_1 );
    cap_jit_deduplicated_expression_5_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_14_1 );
    cap_jit_deduplicated_expression_7_1 := cap_jit_deduplicated_expression_11_1 = 0;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_11_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_13_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if cap_jit_deduplicated_expression_7_1 then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_14_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_4_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_10_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_10_1 ), cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( cap_jit_deduplicated_expression_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_14_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_4_1 ), (KroneckerMat( cap_jit_deduplicated_expression_2_1, KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_9_1 ], function ( i_2 )
                                local cap_jit_deduplicated_expression_1_2;
                                cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                            end ) ), cap_jit_deduplicated_expression_9_1 ), cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_4_1 ) * KroneckerMat( cap_jit_deduplicated_expression_5_1, function (  )
                        if cap_jit_deduplicated_expression_7_1 then
                            return HomalgZeroMatrix( cap_jit_deduplicated_expression_10_1, 1, cap_jit_deduplicated_expression_14_1 );
                        else
                            return ConvertMatrixToColumn( cap_jit_deduplicated_expression_4_1 );
                        fi;
                        return;
                    end(  ) ) ) * (KroneckerMat( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_8_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_4_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_4_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_8_1 ), cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1 ), function (  )
                      if (cap_jit_deduplicated_expression_12_1 = 0) then
                          return HomalgZeroMatrix( (cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_12_1), 1, cap_jit_deduplicated_expression_14_1 );
                      else
                          return ConvertMatrixToColumn( cap_jit_deduplicated_expression_5_1 );
                      fi;
                      return;
                  end(  ) ))) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMonoidalPreComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_14_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_15_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_11_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_15_1;
    cap_jit_deduplicated_expression_16_1 := Dimension( c_1 );
    cap_jit_deduplicated_expression_12_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_16_1;
    cap_jit_deduplicated_expression_17_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_7_1 := cap_jit_deduplicated_expression_11_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_14_1 = 0;
    cap_jit_deduplicated_expression_13_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_4_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_5_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_6_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_8_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_9_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_14_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_15_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_16_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if cap_jit_deduplicated_expression_10_1 then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_17_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_5_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_13_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_13_1 ), cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_17_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( cap_jit_deduplicated_expression_5_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_4_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_17_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_5_1 ), (KroneckerMat( cap_jit_deduplicated_expression_2_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_8_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_8_1 ), cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_17_1 ) ) * KroneckerMat( (KroneckerMat( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_11_1 ], function ( i_2 )
                                    local cap_jit_deduplicated_expression_1_2;
                                    cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                    return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_4_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_4_1 ) + 1);
                                end ) ), cap_jit_deduplicated_expression_11_1 ), cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_17_1 ), cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( cap_jit_deduplicated_expression_6_1, function (  )
                            if cap_jit_deduplicated_expression_10_1 then
                                return HomalgZeroMatrix( cap_jit_deduplicated_expression_13_1, 1, cap_jit_deduplicated_expression_17_1 );
                            else
                                return ConvertMatrixToColumn( cap_jit_deduplicated_expression_5_1 );
                            fi;
                            return;
                        end(  ) )), cap_jit_deduplicated_expression_3_1 ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_9_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_9_1 ), cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_17_1 ) * (KroneckerMat( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_12_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_12_1 ), cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_17_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1 ), function (  )
                      if (cap_jit_deduplicated_expression_15_1 = 0) then
                          return HomalgZeroMatrix( (cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_15_1), 1, cap_jit_deduplicated_expression_17_1 );
                      else
                          return ConvertMatrixToColumn( cap_jit_deduplicated_expression_6_1 );
                      fi;
                      return;
                  end(  ) ))) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMonoidalPreComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_14_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_15_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_11_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_15_1;
    cap_jit_deduplicated_expression_16_1 := Dimension( c_1 );
    cap_jit_deduplicated_expression_12_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_16_1;
    cap_jit_deduplicated_expression_17_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_7_1 := cap_jit_deduplicated_expression_11_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_14_1 = 0;
    cap_jit_deduplicated_expression_13_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_4_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_5_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_6_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_17_1 );
    cap_jit_deduplicated_expression_8_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_9_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_14_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_15_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_16_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if cap_jit_deduplicated_expression_10_1 then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_17_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_5_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_13_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_13_1 ), cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_17_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( cap_jit_deduplicated_expression_5_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_4_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_17_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_5_1 ), (KroneckerMat( cap_jit_deduplicated_expression_2_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_8_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_8_1 ), cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_17_1 ) ) * KroneckerMat( (KroneckerMat( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_11_1 ], function ( i_2 )
                                    local cap_jit_deduplicated_expression_1_2;
                                    cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                    return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_4_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_4_1 ) + 1);
                                end ) ), cap_jit_deduplicated_expression_11_1 ), cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_17_1 ), cap_jit_deduplicated_expression_5_1 ) * KroneckerMat( cap_jit_deduplicated_expression_6_1, function (  )
                            if cap_jit_deduplicated_expression_10_1 then
                                return HomalgZeroMatrix( cap_jit_deduplicated_expression_13_1, 1, cap_jit_deduplicated_expression_17_1 );
                            else
                                return ConvertMatrixToColumn( cap_jit_deduplicated_expression_5_1 );
                            fi;
                            return;
                        end(  ) )), cap_jit_deduplicated_expression_3_1 ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_9_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_9_1 ), cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_17_1 ) * (KroneckerMat( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_12_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_12_1 ), cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_17_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1 ), function (  )
                      if (cap_jit_deduplicated_expression_15_1 = 0) then
                          return HomalgZeroMatrix( (cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_15_1), 1, cap_jit_deduplicated_expression_17_1 );
                      else
                          return ConvertMatrixToColumn( cap_jit_deduplicated_expression_6_1 );
                      fi;
                      return;
                  end(  ) ))) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1, I_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddMorphismBetweenDirectSums( cat,
        
########
function ( cat_1, source_diagram_1, mat_1, range_diagram_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_morphism_attribute_1_1 := UnionOfRows( cap_jit_deduplicated_expression_1_1, Sum( List( range_diagram_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ), ListN( source_diagram_1, List( mat_1, function ( row_2 )
                return List( row_2, UnderlyingMatrix );
            end ), function ( source_2, row_2 )
              return UnionOfColumns( cap_jit_hoisted_expression_1_1, Dimension( source_2 ), row_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismBetweenDirectSumsWithGivenDirectSums( cat,
        
########
function ( cat_1, S_1, source_diagram_1, mat_1, range_diagram_1, T_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1, T_1, UnderlyingMatrix, UnionOfRows( cap_jit_deduplicated_expression_1_1, Dimension( T_1 ), ListN( source_diagram_1, List( mat_1, function ( row_2 )
                  return List( row_2, UnderlyingMatrix );
              end ), function ( source_2, row_2 )
                return UnionOfColumns( cap_jit_hoisted_expression_1_1, Dimension( source_2 ), row_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg4_1, UnderlyingMatrix, arg3_1 );
end
########
        
    );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return UnderlyingMatrix( arg2_1 );
end
########
        
    );
    
    ##
    AddMorphismFromBidual( cat,
        
########
function ( cat_1, a_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, RightDivide( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1 ) );
end
########
        
    );
    
    ##
    AddMorphismFromBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, a_1, UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( s_1 ), cap_jit_deduplicated_expression_1_1 ), HomalgIdentityMatrix( Dimension( a_1 ), cap_jit_deduplicated_expression_1_1 ) ) );
end
########
        
    );
    
    ##
    AddMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := RightDivide( LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( cap_jit_deduplicated_expression_1_1 ) ), cap_jit_deduplicated_expression_1_1 ), SyzygiesOfRows( SyzygiesOfColumns( cap_jit_deduplicated_expression_1_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromFiberProductToSink( cat,
        
########
function ( cat_1, morphisms_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_4_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_6_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := List( morphisms_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_4_1{[ 1 .. 1 - 1 ]} ) + 1;
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_7_1 := morphisms_1[1];
    cap_jit_morphism_attribute_1_1 := CertainColumns( SyzygiesOfRows( (UnionOfColumns( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_6_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_6_1 ]} )) ), [ cap_jit_deduplicated_expression_2_1 .. (cap_jit_deduplicated_expression_2_1 - 1 + cap_jit_deduplicated_expression_4_1[1]) ] ) * UnderlyingMatrix( cap_jit_deduplicated_expression_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( cap_jit_deduplicated_expression_7_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromFiberProductToSinkWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_4_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_6_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := List( morphisms_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_4_1{[ 1 .. 1 - 1 ]} ) + 1;
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_7_1 := morphisms_1[1];
    cap_jit_morphism_attribute_1_1 := CertainColumns( SyzygiesOfRows( (UnionOfColumns( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_6_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_6_1 ]} )) ), [ cap_jit_deduplicated_expression_2_1 .. (cap_jit_deduplicated_expression_2_1 - 1 + cap_jit_deduplicated_expression_4_1[1]) ] ) * UnderlyingMatrix( cap_jit_deduplicated_expression_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( cap_jit_deduplicated_expression_7_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromInternalHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromInternalHomToTensorProductWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromKernelObjectToSink( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Range( alpha_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( NumberRows( cap_jit_deduplicated_expression_2_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_2_1 ), Dimension( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromKernelObjectToSinkWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Range( alpha_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( NumberRows( cap_jit_deduplicated_expression_2_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_2_1 ), Dimension( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromSourceToCokernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Source( alpha_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( Dimension( cap_jit_deduplicated_expression_1_1 ), NumberColumns( cap_jit_deduplicated_expression_2_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromSourceToCokernelObjectWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Source( alpha_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( Dimension( cap_jit_deduplicated_expression_1_1 ), NumberColumns( cap_jit_deduplicated_expression_2_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_2_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromSourceToPushout( cat,
        
########
function ( cat_1, morphisms_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_4_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_6_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_2_1 := List( morphisms_1, Range );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_4_1{[ 1 .. 1 - 1 ]} ) + 1;
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_7_1 := morphisms_1[1];
    cap_jit_morphism_attribute_1_1 := UnderlyingMatrix( cap_jit_deduplicated_expression_7_1 ) * CertainRows( SyzygiesOfColumns( (UnionOfRows( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_6_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_6_1 ]} )) ), [ cap_jit_deduplicated_expression_2_1 .. (cap_jit_deduplicated_expression_2_1 - 1 + cap_jit_deduplicated_expression_4_1[1]) ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( cap_jit_deduplicated_expression_7_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromSourceToPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_4_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_6_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_2_1 := List( morphisms_1, Range );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_4_1{[ 1 .. 1 - 1 ]} ) + 1;
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_7_1 := morphisms_1[1];
    cap_jit_morphism_attribute_1_1 := UnderlyingMatrix( cap_jit_deduplicated_expression_7_1 ) * CertainRows( SyzygiesOfColumns( (UnionOfRows( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_6_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_6_1 ]} )) ), [ cap_jit_deduplicated_expression_2_1 .. (cap_jit_deduplicated_expression_2_1 - 1 + cap_jit_deduplicated_expression_4_1[1]) ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( cap_jit_deduplicated_expression_7_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromTensorProductToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismFromTensorProductToInternalHomWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddMorphismToBidual( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddMorphismToBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, r_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
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
           ), cat_1, Dimension, arg2_1 );
end
########
        
    );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 );
end
########
        
    );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_1_1 := Dimension( cap_jit_deduplicated_expression_3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), cap_jit_deduplicated_expression_3_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_1_1 := Dimension( cap_jit_deduplicated_expression_3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), cap_jit_deduplicated_expression_3_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_1_1 := Dimension( cap_jit_deduplicated_expression_3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), cap_jit_deduplicated_expression_3_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_1_1 := Dimension( cap_jit_deduplicated_expression_3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingRing( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, cap_jit_deduplicated_expression_3_1, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1 ) ) );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_4_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := List( morphisms_1, Source );
    cap_jit_deduplicated_expression_6_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_7_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_7_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_4_1{[ 1 .. k_1 - 1 ]} ) + 1;
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_morphism_attribute_1_1 := CertainColumns( SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_7_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_7_1 ]} ) ), [ cap_jit_deduplicated_expression_2_1 .. cap_jit_deduplicated_expression_2_1 - 1 + cap_jit_deduplicated_expression_4_1[k_1] ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), cap_jit_deduplicated_expression_5_1[k_1], UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfFiberProductWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_4_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := List( morphisms_1, Source );
    cap_jit_deduplicated_expression_6_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_7_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_7_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_4_1{[ 1 .. k_1 - 1 ]} ) + 1;
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_4_1 );
    cap_jit_morphism_attribute_1_1 := CertainColumns( SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_7_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_7_1 ]} ) ), [ cap_jit_deduplicated_expression_2_1 .. cap_jit_deduplicated_expression_2_1 - 1 + cap_jit_deduplicated_expression_4_1[k_1] ] );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), cap_jit_deduplicated_expression_5_1[k_1], UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddProjectiveLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddPushout( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( arg2_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( arg2_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := List( arg2_1, Range );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( arg2_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} ) ) ) );
end
########
        
    );
    
    ##
    AddPushoutFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_hoisted_expression_8_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1;
    cap_jit_deduplicated_expression_10_1 := Length( morphismsp_1 );
    cap_jit_deduplicated_expression_7_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_8_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_8_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_hoisted_expression_6_1 := List( morphismsp_1, Range );
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_10_1;
    cap_jit_deduplicated_expression_2_1 := List( [ 1 .. cap_jit_deduplicated_expression_10_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_5_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_6_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_6_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_7_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := Sum( cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1{[ 1 .. cap_jit_deduplicated_expression_10_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1{[ 2 .. cap_jit_deduplicated_expression_10_1 ]} ) );
    cap_jit_deduplicated_expression_6_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_9_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_2_1 := List( morphisms_1, Range );
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_3_1 := List( [ 1 .. cap_jit_deduplicated_expression_9_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := Sum( cap_jit_deduplicated_expression_6_1 );
    cap_jit_hoisted_expression_8_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1{[ 1 .. cap_jit_deduplicated_expression_9_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_3_1{[ 2 .. cap_jit_deduplicated_expression_9_1 ]} ) ), UnionOfRows( cap_jit_deduplicated_expression_8_1, NumberColumns( cap_jit_deduplicated_expression_1_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local cap_jit_deduplicated_expression_1_2;
                cap_jit_deduplicated_expression_1_2 := Sum( cap_jit_hoisted_expression_5_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return UnderlyingMatrix( L_1[logic_new_func_x_2] ) * CertainRows( cap_jit_hoisted_expression_8_1, [ cap_jit_deduplicated_expression_1_2 .. (cap_jit_deduplicated_expression_1_2 - 1 + cap_jit_hoisted_expression_5_1[logic_new_func_x_2]) ] );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddPushoutFunctorialWithGivenPushouts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_hoisted_expression_8_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_6_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_7_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_9_1 := Length( morphismsp_1 );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_7_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_6_1 := List( morphismsp_1, Range );
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_9_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_5_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_6_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_6_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_7_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_5_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_8_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_2_1 := List( morphisms_1, Range );
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_8_1;
    cap_jit_deduplicated_expression_2_1 := List( [ 1 .. cap_jit_deduplicated_expression_8_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_3_1 := Sum( cap_jit_deduplicated_expression_6_1 );
    cap_jit_deduplicated_expression_4_1 := Sum( cap_jit_deduplicated_expression_5_1 );
    cap_jit_hoisted_expression_8_1 := SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_9_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_9_1 ]} ) );
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1{[ 1 .. cap_jit_deduplicated_expression_8_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1{[ 2 .. cap_jit_deduplicated_expression_8_1 ]} ) ), UnionOfRows( cap_jit_deduplicated_expression_7_1, Dimension( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local cap_jit_deduplicated_expression_1_2;
                cap_jit_deduplicated_expression_1_2 := Sum( cap_jit_hoisted_expression_5_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return UnderlyingMatrix( L_1[logic_new_func_x_2] ) * CertainRows( cap_jit_hoisted_expression_8_1, [ cap_jit_deduplicated_expression_1_2 .. (cap_jit_deduplicated_expression_1_2 - 1 + cap_jit_hoisted_expression_5_1[logic_new_func_x_2]) ] );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Pp_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddRankMorphism( cat,
        
########
function ( cat_1, a_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_6_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_7_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( 1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_3_1 := cap_jit_deduplicated_expression_6_1 = 0;
    cap_jit_deduplicated_expression_4_1 := cap_jit_deduplicated_expression_6_1 * cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_5_1 := cap_jit_deduplicated_expression_6_1 * 1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                      if cap_jit_deduplicated_expression_3_1 then
                          return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_7_1 );
                      else
                          return ConvertMatrixToRow( cap_jit_deduplicated_expression_1_1 );
                      fi;
                      return;
                  end(  ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_4_1 ], function ( i_2 )
                            local cap_jit_deduplicated_expression_1_2;
                            cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                            return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                        end ) ), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_7_1 ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( cap_jit_deduplicated_expression_1_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, 1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, 1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_7_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_1_1 ) * function (  )
              if cap_jit_deduplicated_expression_3_1 then
                  return HomalgZeroMatrix( cap_jit_deduplicated_expression_4_1, 1, cap_jit_deduplicated_expression_7_1 );
              else
                  return ConvertMatrixToColumn( cap_jit_deduplicated_expression_1_1 );
              fi;
              return;
          end(  );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddRightDistributivityExpanding( cat,
        
########
function ( cat_1, L_1, a_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Dimension( a_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( L_1 );
    cap_jit_hoisted_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( cap_jit_deduplicated_expression_1_1, Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ) * cap_jit_deduplicated_expression_2_1, List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) ), cap_jit_hoisted_expression_3_1 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddRightDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( L_1 );
    cap_jit_hoisted_expression_3_1 := HomalgIdentityMatrix( Dimension( a_1 ), cap_jit_deduplicated_expression_1_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( cap_jit_deduplicated_expression_1_1, Dimension( s_1 ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) ), cap_jit_hoisted_expression_3_1 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddRightDistributivityFactoring( cat,
        
########
function ( cat_1, L_1, a_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Dimension( a_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( L_1 );
    cap_jit_hoisted_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( cap_jit_deduplicated_expression_1_1, Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ) * cap_jit_deduplicated_expression_2_1, List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ) ), cap_jit_hoisted_expression_3_1 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddRightDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_1_1;
    cap_jit_hoisted_expression_2_1 := Length( L_1 );
    cap_jit_hoisted_expression_3_1 := HomalgIdentityMatrix( Dimension( a_1 ), cap_jit_deduplicated_expression_1_1 );
    cap_jit_morphism_attribute_1_1 := UnionOfRows( cap_jit_deduplicated_expression_1_1, Dimension( r_1 ), List( [ 1 .. Size( L_1 ) ], function ( logic_new_func_x_2 )
              local cap_jit_deduplicated_expression_1_2;
              cap_jit_deduplicated_expression_1_2 := Dimension( L_1[logic_new_func_x_2] );
              return KroneckerMat( UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. cap_jit_hoisted_expression_2_1 ]}, function ( c_3 )
                            return Dimension( c_3 );
                        end ), cap_jit_hoisted_expression_1_1 ) ), cap_jit_hoisted_expression_3_1 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), r_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddRightUnitor( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddRightUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddSolveLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1;
    cap_jit_deduplicated_expression_4_1 := arg2_1[1];
    cap_jit_deduplicated_expression_1_1 := [ 1 .. Length( cap_jit_deduplicated_expression_4_1 ) ];
    cap_jit_deduplicated_expression_2_1 := [ 1 .. Length( arg2_1 ) ];
    cap_jit_deduplicated_expression_3_1 := UnderlyingRing( cat_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_2_1 := arg3_1[1];
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_2_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_5_1 := List( cap_jit_deduplicated_expression_1_1, function ( logic_new_func_x_2 )
            return Dimension( Range( cap_jit_hoisted_expression_1_1[logic_new_func_x_2] ) ) * Dimension( Source( cap_jit_hoisted_expression_2_1[logic_new_func_x_2] ) );
        end );
    cap_jit_hoisted_expression_6_1 := RightDivide( UnionOfColumns( cap_jit_deduplicated_expression_3_1, 1, List( cap_jit_deduplicated_expression_2_1, function ( logic_new_func_x_2 )
                return ConvertMatrixToRow( UnderlyingMatrix( arg4_1[logic_new_func_x_2] ) );
            end ) ), UnionOfRows( cap_jit_deduplicated_expression_3_1, Sum( List( cap_jit_deduplicated_expression_2_1, function ( logic_new_func_x_2 )
                  return Dimension( Source( arg2_1[logic_new_func_x_2][1] ) ) * Dimension( Range( arg3_1[logic_new_func_x_2][1] ) );
              end ) ), List( cap_jit_deduplicated_expression_1_1, function ( logic_new_func_x_2 )
                return UnionOfColumns( cap_jit_hoisted_expression_4_1, Dimension( Range( cap_jit_hoisted_expression_1_1[logic_new_func_x_2] ) ) * Dimension( Source( cap_jit_hoisted_expression_2_1[logic_new_func_x_2] ) ), List( cap_jit_hoisted_expression_3_1, function ( logic_new_func_x_3 )
                          return KroneckerMat( TransposedMatrix( UnderlyingMatrix( arg2_1[logic_new_func_x_3][logic_new_func_x_2] ) ), UnderlyingMatrix( arg3_1[logic_new_func_x_3][logic_new_func_x_2] ) );
                      end ) );
            end ) ) );
    return List( cap_jit_deduplicated_expression_1_1, function ( j_2 )
            local cap_jit_deduplicated_expression_1_2, cap_jit_deduplicated_expression_2_2, cap_jit_deduplicated_expression_3_2;
            cap_jit_deduplicated_expression_1_2 := Sum( cap_jit_hoisted_expression_5_1{[ 1 .. j_2 - 1 ]} ) + 1;
            cap_jit_deduplicated_expression_2_2 := Range( cap_jit_hoisted_expression_1_1[j_2] );
            cap_jit_deduplicated_expression_3_2 := Source( cap_jit_hoisted_expression_2_1[j_2] );
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, cap_jit_deduplicated_expression_2_2, cap_jit_deduplicated_expression_3_2, UnderlyingMatrix, ConvertRowToMatrix( CertainColumns( cap_jit_hoisted_expression_6_1, [ cap_jit_deduplicated_expression_1_2 .. cap_jit_deduplicated_expression_1_2 - 1 + cap_jit_hoisted_expression_5_1[j_2] ] ), Dimension( cap_jit_deduplicated_expression_2_2 ), Dimension( cap_jit_deduplicated_expression_3_2 ) ) );
        end );
end
########
        
    );
    
    ##
    AddSomeInjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return arg2_1;
end
########
        
    );
    
    ##
    AddSomeProjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return arg2_1;
end
########
        
    );
    
    ##
    AddSomeReductionBySplitEpiSummand( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( 0, NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    cap_jit_morphism_attribute_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) ), cap_jit_deduplicated_expression_1_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddSubtractionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( b_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + -1 * UnderlyingMatrix( b_1 ) );
end
########
        
    );
    
    ##
    AddTensorProductDualityCompatibilityMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_19_1, cap_jit_deduplicated_expression_20_1, cap_jit_deduplicated_expression_21_1;
    cap_jit_deduplicated_expression_20_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    cap_jit_deduplicated_expression_19_1 := [ a_1, cap_jit_deduplicated_expression_20_1, b_1, cap_jit_deduplicated_expression_20_1 ];
    cap_jit_deduplicated_expression_15_1 := Dimension( cap_jit_deduplicated_expression_19_1[1] );
    cap_jit_deduplicated_expression_17_1 := Dimension( cap_jit_deduplicated_expression_19_1[2] );
    cap_jit_deduplicated_expression_13_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_16_1 := Dimension( cap_jit_deduplicated_expression_19_1[3] );
    cap_jit_deduplicated_expression_18_1 := Dimension( cap_jit_deduplicated_expression_19_1[4] );
    cap_jit_deduplicated_expression_14_1 := cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_18_1;
    cap_jit_deduplicated_expression_21_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_9_1 := cap_jit_deduplicated_expression_13_1 * cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_12_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_16_1;
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_deduplicated_expression_11_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_15_1;
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_4_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_5_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_6_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_7_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_8_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_9_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_15_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_14_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_17_1;
    cap_jit_hoisted_expression_6_1 := cap_jit_deduplicated_expression_18_1;
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_16_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( HomalgIdentityMatrix( Dimension( a_1 ), cap_jit_deduplicated_expression_21_1 ), HomalgIdentityMatrix( Dimension( b_1 ), cap_jit_deduplicated_expression_21_1 ) ) * (KroneckerMat( function (  )
                      if (cap_jit_deduplicated_expression_12_1 = 0) then
                          return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_21_1 );
                      else
                          return ConvertMatrixToRow( cap_jit_deduplicated_expression_2_1 );
                      fi;
                      return;
                  end(  ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_10_1 ], function ( i_2 )
                            local cap_jit_deduplicated_expression_1_2;
                            cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                            return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                        end ) ), cap_jit_deduplicated_expression_10_1 ), cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_21_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( cap_jit_deduplicated_expression_2_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_21_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_2_1 ), (KroneckerMat( KroneckerMat( cap_jit_deduplicated_expression_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_11_1 ], function ( i_2 )
                                local cap_jit_deduplicated_expression_1_2;
                                cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                            end ) ), cap_jit_deduplicated_expression_11_1 ), cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_21_1 ) ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_13_1 ], function ( i_2 )
                                      local cap_jit_deduplicated_expression_1_2;
                                      cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                      return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) + 1);
                                  end ) ), cap_jit_deduplicated_expression_13_1 ), cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_21_1 ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( cap_jit_deduplicated_expression_8_1, function (  )
                              if (cap_jit_deduplicated_expression_15_1 = 0) then
                                  return HomalgZeroMatrix( (cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_15_1), 1, cap_jit_deduplicated_expression_21_1 );
                              else
                                  return ConvertMatrixToColumn( cap_jit_deduplicated_expression_7_1 );
                              fi;
                              return;
                          end(  ) )), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( cap_jit_deduplicated_expression_8_1, (KroneckerMat( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_14_1 ], function ( i_2 )
                                  local cap_jit_deduplicated_expression_1_2;
                                  cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                  return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) * cap_jit_hoisted_expression_7_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) + 1);
                              end ) ), cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_21_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_21_1 ), function (  )
                          if (cap_jit_deduplicated_expression_16_1 = 0) then
                              return HomalgZeroMatrix( (cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_16_1), 1, cap_jit_deduplicated_expression_21_1 );
                          else
                              return ConvertMatrixToColumn( cap_jit_deduplicated_expression_6_1 );
                          fi;
                          return;
                      end(  ) )) )) ));
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddTensorProductDualityCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_19_1, cap_jit_deduplicated_expression_20_1, cap_jit_deduplicated_expression_21_1;
    cap_jit_deduplicated_expression_20_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    cap_jit_deduplicated_expression_19_1 := [ a_1, cap_jit_deduplicated_expression_20_1, b_1, cap_jit_deduplicated_expression_20_1 ];
    cap_jit_deduplicated_expression_15_1 := Dimension( cap_jit_deduplicated_expression_19_1[1] );
    cap_jit_deduplicated_expression_17_1 := Dimension( cap_jit_deduplicated_expression_19_1[2] );
    cap_jit_deduplicated_expression_13_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_16_1 := Dimension( cap_jit_deduplicated_expression_19_1[3] );
    cap_jit_deduplicated_expression_18_1 := Dimension( cap_jit_deduplicated_expression_19_1[4] );
    cap_jit_deduplicated_expression_14_1 := cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_18_1;
    cap_jit_deduplicated_expression_21_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_9_1 := cap_jit_deduplicated_expression_13_1 * cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_12_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_16_1;
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_deduplicated_expression_11_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_15_1;
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_4_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_5_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_6_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_7_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_deduplicated_expression_8_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_21_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_9_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_15_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_14_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_17_1;
    cap_jit_hoisted_expression_6_1 := cap_jit_deduplicated_expression_18_1;
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_16_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( HomalgIdentityMatrix( Dimension( a_1 ), cap_jit_deduplicated_expression_21_1 ), HomalgIdentityMatrix( Dimension( b_1 ), cap_jit_deduplicated_expression_21_1 ) ) * (KroneckerMat( function (  )
                      if (cap_jit_deduplicated_expression_12_1 = 0) then
                          return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_21_1 );
                      else
                          return ConvertMatrixToRow( cap_jit_deduplicated_expression_2_1 );
                      fi;
                      return;
                  end(  ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_10_1 ], function ( i_2 )
                            local cap_jit_deduplicated_expression_1_2;
                            cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                            return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                        end ) ), cap_jit_deduplicated_expression_10_1 ), cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_21_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( cap_jit_deduplicated_expression_2_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_21_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_2_1 ), (KroneckerMat( KroneckerMat( cap_jit_deduplicated_expression_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_11_1 ], function ( i_2 )
                                local cap_jit_deduplicated_expression_1_2;
                                cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                            end ) ), cap_jit_deduplicated_expression_11_1 ), cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_21_1 ) ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_13_1 ], function ( i_2 )
                                      local cap_jit_deduplicated_expression_1_2;
                                      cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                      return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) + 1);
                                  end ) ), cap_jit_deduplicated_expression_13_1 ), cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_21_1 ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( cap_jit_deduplicated_expression_8_1, function (  )
                              if (cap_jit_deduplicated_expression_15_1 = 0) then
                                  return HomalgZeroMatrix( (cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_15_1), 1, cap_jit_deduplicated_expression_21_1 );
                              else
                                  return ConvertMatrixToColumn( cap_jit_deduplicated_expression_7_1 );
                              fi;
                              return;
                          end(  ) )), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( cap_jit_deduplicated_expression_8_1, (KroneckerMat( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_14_1 ], function ( i_2 )
                                  local cap_jit_deduplicated_expression_1_2;
                                  cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                  return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) * cap_jit_hoisted_expression_7_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) + 1);
                              end ) ), cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_21_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_21_1 ), function (  )
                          if (cap_jit_deduplicated_expression_16_1 = 0) then
                              return HomalgZeroMatrix( (cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_16_1), 1, cap_jit_deduplicated_expression_21_1 );
                          else
                              return ConvertMatrixToColumn( cap_jit_deduplicated_expression_6_1 );
                          fi;
                          return;
                      end(  ) )) )) ));
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphism( cat,
        
########
function ( cat_1, list_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_19_1;
    cap_jit_deduplicated_expression_15_1 := Dimension( list_1[1] );
    cap_jit_deduplicated_expression_17_1 := Dimension( list_1[2] );
    cap_jit_deduplicated_expression_13_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_16_1 := Dimension( list_1[3] );
    cap_jit_deduplicated_expression_18_1 := Dimension( list_1[4] );
    cap_jit_deduplicated_expression_14_1 := cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_18_1;
    cap_jit_deduplicated_expression_19_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_9_1 := cap_jit_deduplicated_expression_13_1 * cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_12_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_16_1;
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_deduplicated_expression_11_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_15_1;
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_4_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_5_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_6_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_7_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_8_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_9_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_15_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_14_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_17_1;
    cap_jit_hoisted_expression_6_1 := cap_jit_deduplicated_expression_18_1;
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_16_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if (cap_jit_deduplicated_expression_12_1 = 0) then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_19_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_2_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_10_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_10_1 ), cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_19_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( cap_jit_deduplicated_expression_2_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_19_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_2_1 ), (KroneckerMat( KroneckerMat( cap_jit_deduplicated_expression_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_11_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_11_1 ), cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_19_1 ) ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_13_1 ], function ( i_2 )
                                    local cap_jit_deduplicated_expression_1_2;
                                    cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                    return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) + 1);
                                end ) ), cap_jit_deduplicated_expression_13_1 ), cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_19_1 ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( cap_jit_deduplicated_expression_8_1, function (  )
                            if (cap_jit_deduplicated_expression_15_1 = 0) then
                                return HomalgZeroMatrix( (cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_15_1), 1, cap_jit_deduplicated_expression_19_1 );
                            else
                                return ConvertMatrixToColumn( cap_jit_deduplicated_expression_7_1 );
                            fi;
                            return;
                        end(  ) )), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( cap_jit_deduplicated_expression_8_1, (KroneckerMat( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_14_1 ], function ( i_2 )
                                local cap_jit_deduplicated_expression_1_2;
                                cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) * cap_jit_hoisted_expression_7_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) + 1);
                            end ) ), cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_19_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_19_1 ), function (  )
                        if (cap_jit_deduplicated_expression_16_1 = 0) then
                            return HomalgZeroMatrix( (cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_16_1), 1, cap_jit_deduplicated_expression_19_1 );
                        else
                            return ConvertMatrixToColumn( cap_jit_deduplicated_expression_6_1 );
                        fi;
                        return;
                    end(  ) )) )) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverse( cat,
        
########
function ( cat_1, list_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_19_1, cap_jit_deduplicated_expression_20_1;
    cap_jit_deduplicated_expression_16_1 := Dimension( list_1[1] );
    cap_jit_deduplicated_expression_18_1 := Dimension( list_1[2] );
    cap_jit_deduplicated_expression_14_1 := cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_18_1;
    cap_jit_deduplicated_expression_17_1 := Dimension( list_1[3] );
    cap_jit_deduplicated_expression_19_1 := Dimension( list_1[4] );
    cap_jit_deduplicated_expression_15_1 := cap_jit_deduplicated_expression_17_1 * cap_jit_deduplicated_expression_19_1;
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_15_1;
    cap_jit_deduplicated_expression_13_1 := cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_11_1 := cap_jit_deduplicated_expression_13_1 * cap_jit_deduplicated_expression_13_1;
    cap_jit_deduplicated_expression_12_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_16_1;
    cap_jit_deduplicated_expression_20_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_4_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_5_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_6_1 := cap_jit_deduplicated_expression_13_1 * cap_jit_deduplicated_expression_10_1;
    cap_jit_deduplicated_expression_7_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_8_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_9_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_13_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_10_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_16_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_15_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_18_1;
    cap_jit_hoisted_expression_6_1 := cap_jit_deduplicated_expression_19_1;
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_1_1 := KroneckerMat( function (  )
                    if (cap_jit_deduplicated_expression_13_1 = 0) then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_20_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_3_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_11_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_11_1 ), cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_20_1 ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( cap_jit_deduplicated_expression_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_6_1 ), cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_20_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_3_1 ), (KroneckerMat( KroneckerMat( cap_jit_deduplicated_expression_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_12_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_12_1 ), cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_20_1 ) ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_8_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_14_1 ], function ( i_2 )
                                    local cap_jit_deduplicated_expression_1_2;
                                    cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                    return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) + 1);
                                end ) ), cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_20_1 ), cap_jit_deduplicated_expression_8_1 ) * KroneckerMat( cap_jit_deduplicated_expression_9_1, function (  )
                            if (cap_jit_deduplicated_expression_16_1 = 0) then
                                return HomalgZeroMatrix( (cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_16_1), 1, cap_jit_deduplicated_expression_20_1 );
                            else
                                return ConvertMatrixToColumn( cap_jit_deduplicated_expression_8_1 );
                            fi;
                            return;
                        end(  ) )), cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( cap_jit_deduplicated_expression_9_1, (KroneckerMat( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_15_1 ], function ( i_2 )
                                local cap_jit_deduplicated_expression_1_2;
                                cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) * cap_jit_hoisted_expression_7_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) + 1);
                            end ) ), cap_jit_deduplicated_expression_15_1 ), cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_20_1 ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_19_1, cap_jit_deduplicated_expression_20_1 ), function (  )
                        if (cap_jit_deduplicated_expression_17_1 = 0) then
                            return HomalgZeroMatrix( (cap_jit_deduplicated_expression_17_1 * cap_jit_deduplicated_expression_17_1), 1, cap_jit_deduplicated_expression_20_1 );
                        else
                            return ConvertMatrixToColumn( cap_jit_deduplicated_expression_7_1 );
                        fi;
                        return;
                    end(  ) )) )) );
    cap_jit_morphism_attribute_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_20_1 ), cap_jit_deduplicated_expression_1_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_19_1, cap_jit_deduplicated_expression_20_1;
    cap_jit_deduplicated_expression_16_1 := Dimension( list_1[1] );
    cap_jit_deduplicated_expression_18_1 := Dimension( list_1[2] );
    cap_jit_deduplicated_expression_14_1 := cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_18_1;
    cap_jit_deduplicated_expression_17_1 := Dimension( list_1[3] );
    cap_jit_deduplicated_expression_19_1 := Dimension( list_1[4] );
    cap_jit_deduplicated_expression_15_1 := cap_jit_deduplicated_expression_17_1 * cap_jit_deduplicated_expression_19_1;
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_15_1;
    cap_jit_deduplicated_expression_13_1 := cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_11_1 := cap_jit_deduplicated_expression_13_1 * cap_jit_deduplicated_expression_13_1;
    cap_jit_deduplicated_expression_12_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_16_1;
    cap_jit_deduplicated_expression_20_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_4_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_5_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_6_1 := cap_jit_deduplicated_expression_13_1 * cap_jit_deduplicated_expression_10_1;
    cap_jit_deduplicated_expression_7_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_8_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_deduplicated_expression_9_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_20_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_13_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_10_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_16_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_15_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_18_1;
    cap_jit_hoisted_expression_6_1 := cap_jit_deduplicated_expression_19_1;
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_1_1 := KroneckerMat( function (  )
                    if (cap_jit_deduplicated_expression_13_1 = 0) then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_20_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_3_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_11_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_11_1 ), cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_20_1 ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( cap_jit_deduplicated_expression_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_6_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_6_1 ), cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_20_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_3_1 ), (KroneckerMat( KroneckerMat( cap_jit_deduplicated_expression_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_12_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_12_1 ), cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_20_1 ) ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_8_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_14_1 ], function ( i_2 )
                                    local cap_jit_deduplicated_expression_1_2;
                                    cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                    return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) + 1);
                                end ) ), cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_20_1 ), cap_jit_deduplicated_expression_8_1 ) * KroneckerMat( cap_jit_deduplicated_expression_9_1, function (  )
                            if (cap_jit_deduplicated_expression_16_1 = 0) then
                                return HomalgZeroMatrix( (cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_16_1), 1, cap_jit_deduplicated_expression_20_1 );
                            else
                                return ConvertMatrixToColumn( cap_jit_deduplicated_expression_8_1 );
                            fi;
                            return;
                        end(  ) )), cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( cap_jit_deduplicated_expression_9_1, (KroneckerMat( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_15_1 ], function ( i_2 )
                                local cap_jit_deduplicated_expression_1_2;
                                cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) * cap_jit_hoisted_expression_7_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) + 1);
                            end ) ), cap_jit_deduplicated_expression_15_1 ), cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_20_1 ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_19_1, cap_jit_deduplicated_expression_20_1 ), function (  )
                        if (cap_jit_deduplicated_expression_17_1 = 0) then
                            return HomalgZeroMatrix( (cap_jit_deduplicated_expression_17_1 * cap_jit_deduplicated_expression_17_1), 1, cap_jit_deduplicated_expression_20_1 );
                        else
                            return ConvertMatrixToColumn( cap_jit_deduplicated_expression_7_1 );
                        fi;
                        return;
                    end(  ) )) )) );
    cap_jit_morphism_attribute_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( cap_jit_deduplicated_expression_1_1 ), cap_jit_deduplicated_expression_20_1 ), cap_jit_deduplicated_expression_1_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1, cap_jit_deduplicated_expression_8_1, cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_19_1;
    cap_jit_deduplicated_expression_15_1 := Dimension( list_1[1] );
    cap_jit_deduplicated_expression_17_1 := Dimension( list_1[2] );
    cap_jit_deduplicated_expression_13_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_17_1;
    cap_jit_deduplicated_expression_16_1 := Dimension( list_1[3] );
    cap_jit_deduplicated_expression_18_1 := Dimension( list_1[4] );
    cap_jit_deduplicated_expression_14_1 := cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_18_1;
    cap_jit_deduplicated_expression_19_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_9_1 := cap_jit_deduplicated_expression_13_1 * cap_jit_deduplicated_expression_14_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_9_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_12_1 := cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_16_1;
    cap_jit_deduplicated_expression_10_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_12_1;
    cap_jit_deduplicated_expression_11_1 := cap_jit_deduplicated_expression_14_1 * cap_jit_deduplicated_expression_15_1;
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_12_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_3_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_4_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_5_1 := cap_jit_deduplicated_expression_12_1 * cap_jit_deduplicated_expression_9_1;
    cap_jit_deduplicated_expression_6_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_16_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_7_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_15_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_deduplicated_expression_8_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_17_1, cap_jit_deduplicated_expression_19_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_12_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_9_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_15_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_14_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_17_1;
    cap_jit_hoisted_expression_6_1 := cap_jit_deduplicated_expression_18_1;
    cap_jit_hoisted_expression_7_1 := cap_jit_deduplicated_expression_16_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if (cap_jit_deduplicated_expression_12_1 = 0) then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_19_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_2_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_10_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_10_1 ), cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_10_1, cap_jit_deduplicated_expression_19_1 ), cap_jit_deduplicated_expression_1_1 ) * KroneckerMat( cap_jit_deduplicated_expression_2_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_5_1 ), cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_19_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_2_1 ), (KroneckerMat( KroneckerMat( cap_jit_deduplicated_expression_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_11_1 ], function ( i_2 )
                              local cap_jit_deduplicated_expression_1_2;
                              cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                              return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) * cap_jit_hoisted_expression_4_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) + 1);
                          end ) ), cap_jit_deduplicated_expression_11_1 ), cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_11_1, cap_jit_deduplicated_expression_19_1 ) ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_13_1 ], function ( i_2 )
                                    local cap_jit_deduplicated_expression_1_2;
                                    cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                    return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) * cap_jit_hoisted_expression_3_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_5_1 ) + 1);
                                end ) ), cap_jit_deduplicated_expression_13_1 ), cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_13_1, cap_jit_deduplicated_expression_19_1 ), cap_jit_deduplicated_expression_7_1 ) * KroneckerMat( cap_jit_deduplicated_expression_8_1, function (  )
                            if (cap_jit_deduplicated_expression_15_1 = 0) then
                                return HomalgZeroMatrix( (cap_jit_deduplicated_expression_15_1 * cap_jit_deduplicated_expression_15_1), 1, cap_jit_deduplicated_expression_19_1 );
                            else
                                return ConvertMatrixToColumn( cap_jit_deduplicated_expression_7_1 );
                            fi;
                            return;
                        end(  ) )), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( cap_jit_deduplicated_expression_8_1, (KroneckerMat( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_14_1 ], function ( i_2 )
                                local cap_jit_deduplicated_expression_1_2;
                                cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                                return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) * cap_jit_hoisted_expression_7_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_6_1 ) + 1);
                            end ) ), cap_jit_deduplicated_expression_14_1 ), cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_14_1, cap_jit_deduplicated_expression_19_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgIdentityMatrix( cap_jit_deduplicated_expression_18_1, cap_jit_deduplicated_expression_19_1 ), function (  )
                        if (cap_jit_deduplicated_expression_16_1 = 0) then
                            return HomalgZeroMatrix( (cap_jit_deduplicated_expression_16_1 * cap_jit_deduplicated_expression_16_1), 1, cap_jit_deduplicated_expression_19_1 );
                        else
                            return ConvertMatrixToColumn( cap_jit_deduplicated_expression_6_1 );
                        fi;
                        return;
                    end(  ) )) )) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddTensorProductOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, KroneckerMat( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( arg2_1 ) * Dimension( arg3_1 ) );
end
########
        
    );
    
    ##
    AddTensorProductToInternalHomAdjunctionMap( cat,
        
########
function ( cat_1, a_1, b_1, f_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_5_1 := Dimension( b_1 );
    cap_jit_deduplicated_expression_7_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_6_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_3_1 := cap_jit_deduplicated_expression_5_1 * cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_4_1 := cap_jit_deduplicated_expression_5_1 * cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if (cap_jit_deduplicated_expression_5_1 = 0) then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_1_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( cap_jit_deduplicated_expression_1_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_4_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_7_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix( f_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
end
########
        
    );
    
    ##
    AddTerminalObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
end
########
        
    );
    
    ##
    AddTerminalObjectFunctorial( cat,
        
########
function ( cat_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddTerminalObjectFunctorialWithGivenTerminalObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( Pp_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddTraceMap( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_5_1 := Dimension( Source( alpha_1 ) );
    cap_jit_deduplicated_expression_7_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_2_1 := cap_jit_deduplicated_expression_5_1 = 0;
    cap_jit_deduplicated_expression_3_1 := cap_jit_deduplicated_expression_5_1 * cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_4_1 := cap_jit_deduplicated_expression_5_1 * 1;
    cap_jit_deduplicated_expression_6_1 := HomalgIdentityMatrix( 1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                      if cap_jit_deduplicated_expression_2_1 then
                          return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 );
                      else
                          return ConvertMatrixToRow( cap_jit_deduplicated_expression_1_1 );
                      fi;
                      return;
                  end(  ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                            local cap_jit_deduplicated_expression_1_2;
                            cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                            return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                        end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 ), cap_jit_deduplicated_expression_6_1 ) * KroneckerMat( cap_jit_deduplicated_expression_1_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_4_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, 1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, 1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_7_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix( alpha_1 ) ) * function (  )
              if cap_jit_deduplicated_expression_2_1 then
                  return HomalgZeroMatrix( cap_jit_deduplicated_expression_3_1, 1, cap_jit_deduplicated_expression_7_1 );
              else
                  return ConvertMatrixToColumn( cap_jit_deduplicated_expression_1_1 );
              fi;
              return;
          end(  );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), T_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), T_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), T_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
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
        
    );
    
    ##
    AddUniversalMorphismFromImage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := tau_1[2];
    cap_jit_morphism_attribute_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Source( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, tau_1, I_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := tau_1[2];
    cap_jit_morphism_attribute_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Source( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromInitialObject( cat,
        
########
function ( cat_1, T_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), T_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromPushout( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := List( morphisms_1, Range );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} ) ), UnionOfRows( cap_jit_deduplicated_expression_4_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), T_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_2_1 := List( morphisms_1, Range );
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_1_1[logic_new_func_x_2];
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_1_2, Sum( cap_jit_hoisted_expression_2_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_hoisted_expression_3_1 ) );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfRows( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} ) ), UnionOfRows( cap_jit_deduplicated_expression_4_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), T_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), T_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoCoimage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := tau_1[1];
    cap_jit_morphism_attribute_1_1 := LeftDivide( UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ), SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( cap_jit_deduplicated_expression_1_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoCoimageWithGivenCoimage( cat,
        
########
function ( cat_1, alpha_1, tau_1, C_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := tau_1[1];
    cap_jit_morphism_attribute_1_1 := LeftDivide( UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ), SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( cap_jit_deduplicated_expression_1_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
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
        
    );
    
    ##
    AddUniversalMorphismIntoFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := List( morphisms_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    cap_jit_morphism_attribute_1_1 := RightDivide( UnionOfColumns( cap_jit_deduplicated_expression_4_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ), SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoFiberProductWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_3_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    cap_jit_deduplicated_expression_4_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_5_1 := Length( morphisms_1 );
    cap_jit_hoisted_expression_1_1 := List( morphisms_1, Source );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_1_1 := List( [ 1 .. cap_jit_deduplicated_expression_5_1 ], function ( logic_new_func_x_2 )
            local cap_jit_deduplicated_expression_1_2;
            cap_jit_deduplicated_expression_1_2 := cap_jit_hoisted_expression_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_hoisted_expression_1_1{[ (logic_new_func_x_2 + 1) .. cap_jit_hoisted_expression_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_3_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    cap_jit_deduplicated_expression_2_1 := Sum( cap_jit_deduplicated_expression_3_1 );
    cap_jit_morphism_attribute_1_1 := RightDivide( UnionOfColumns( cap_jit_deduplicated_expression_4_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ), SyzygiesOfRows( UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 1 .. cap_jit_deduplicated_expression_5_1 - 1 ]} ) + -1 * UnionOfColumns( cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1{[ 2 .. cap_jit_deduplicated_expression_5_1 ]} ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoTerminalObject( cat,
        
########
function ( cat_1, T_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), Dimension( P_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddUniversalPropertyOfDual( cat,
        
########
function ( cat_1, t_1, a_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1;
    cap_jit_deduplicated_expression_5_1 := Dimension( a_1 );
    cap_jit_deduplicated_expression_7_1 := UnderlyingRing( cat_1 );
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_6_1 := Dimension( t_1 );
    cap_jit_deduplicated_expression_2_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_6_1, cap_jit_deduplicated_expression_7_1 );
    cap_jit_deduplicated_expression_3_1 := cap_jit_deduplicated_expression_5_1 * cap_jit_deduplicated_expression_5_1;
    cap_jit_deduplicated_expression_4_1 := cap_jit_deduplicated_expression_5_1 * cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_1_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( function (  )
                    if (cap_jit_deduplicated_expression_5_1 = 0) then
                        return HomalgZeroMatrix( 1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 );
                    else
                        return ConvertMatrixToRow( cap_jit_deduplicated_expression_1_1 );
                    fi;
                    return;
                end(  ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_3_1 ], function ( i_2 )
                          local cap_jit_deduplicated_expression_1_2;
                          cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                          return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_1_1 ) + 1);
                      end ) ), cap_jit_deduplicated_expression_3_1 ), cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_7_1 ), cap_jit_deduplicated_expression_2_1 ) * KroneckerMat( cap_jit_deduplicated_expression_1_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. cap_jit_deduplicated_expression_4_1 ], function ( i_2 )
                        local cap_jit_deduplicated_expression_1_2;
                        cap_jit_deduplicated_expression_1_2 := (i_2 - 1);
                        return (REM_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) * cap_jit_hoisted_expression_1_1 + QUO_INT( cap_jit_deduplicated_expression_1_2, cap_jit_hoisted_expression_2_1 ) + 1);
                    end ) ), cap_jit_deduplicated_expression_4_1 ), cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_7_1 ) ) * KroneckerMat( TransposedMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), a_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( a_1 ), Dimension( b_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
end
########
        
    );
    
    ##
    AddZeroObjectFunctorial( cat,
        
########
function ( cat_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    );
    
    ##
    AddZeroObjectFunctorialWithGivenZeroObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
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
