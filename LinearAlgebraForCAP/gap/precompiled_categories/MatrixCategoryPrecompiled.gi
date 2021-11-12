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
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
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
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
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
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( cap_jit_deduplicated_expression_1_1 ) ), cap_jit_deduplicated_expression_1_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    , 704 );
    
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
        
    , 705 );
    
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
        
    , 100 );
    
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
        
    , 201 );
    
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
        
    , 202 );
    
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
        
    , 101 );
    
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
        
    , 100 );
    
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
        
    , 704 );
    
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
        
    , 401 );
    
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
        
    , 100 );
    
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
        
    , 2811 );
    
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
        
    , 2408 );
    
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
        
    , 302 );
    
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
        
    , 602 );
    
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
        
    , 603 );
    
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
        
    , 202 );
    
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
        
    , 203 );
    
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
        
    , 100 );
    
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
        
    , 606 );
    
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
        
    , 405 );
    
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
        
    , 100 );
    
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
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_2_1 := List( S_1, Dimension );
    cap_jit_deduplicated_expression_1_1 := Sum( cap_jit_deduplicated_expression_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1[i_1], Range( alpha_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( alpha_1 ), [ cap_jit_deduplicated_expression_1_1 .. cap_jit_deduplicated_expression_1_1 - 1 + cap_jit_deduplicated_expression_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
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
        
    , 2118 );
    
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
        
    , 2118 );
    
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
        
    , 1706 );
    
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
        
    , 1706 );
    
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
        
    , 401 );
    
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
        
    , 100 );
    
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
        
    , 2610 );
    
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
        
    , 2207 );
    
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
        
    , 3815 );
    
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
        
    , 3814 );
    
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
        
    , 19782 );
    
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
        
    , 12151 );
    
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
        
    , 704 );
    
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
        
    , 3815 );
    
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
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    , 602 );
    
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
        
    , 603 );
    
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
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
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
        
    , 503 );
    
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
        
    , 504 );
    
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
        
    , 201 );
    
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
        
    , 100 );
    
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
        
    , 3915 );
    
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
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    , 1810 );
    
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
        
    , 3112 );
    
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
        
    , 100 );
    
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
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Range( alpha_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, Source( alpha_1 ), UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 202 );
    
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
        
    , 2214 );
    
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
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( arg3_1 );
    cap_jit_deduplicated_expression_2_1 := UnderlyingMatrix( arg2_1 );
    return IsZero( SyzygiesOfRows( cap_jit_deduplicated_expression_1_1 ) * cap_jit_deduplicated_expression_2_1 ) and IsZero( SyzygiesOfRows( cap_jit_deduplicated_expression_2_1 ) * cap_jit_deduplicated_expression_1_1 );
end
########
        
    , 603 );
    
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
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( arg2_1 );
    return cap_jit_deduplicated_expression_1_1 * cap_jit_deduplicated_expression_1_1 = cap_jit_deduplicated_expression_1_1;
end
########
        
    , 201 );
    
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
        
    , 403 );
    
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
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Dimension( Range( arg2_1 ) );
    return cap_jit_deduplicated_expression_1_1 = Dimension( Source( arg2_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = cap_jit_deduplicated_expression_1_1;
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
        
    , 100 );
    
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
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    , 301 );
    
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
        
    , 1907 );
    
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
        
    , 301 );
    
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
        
    , 201 );
    
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
        
    , 201 );
    
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
        
    , 201 );
    
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
        
    , 1907 );
    
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
        
    , 703 );
    
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
        
    , 301 );
    
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
        
    , 2914 );
    
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
        
    , 2913 );
    
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
        
    , 301 );
    
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
        
    , 906 );
    
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
        
    , 301 );
    
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
        
    , 1907 );
    
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
        
    , 5025 );
    
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
        
    , 5024 );
    
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
        
    , 1907 );
    
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
        
    , 301 );
    
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
        
    , 201 );
    
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
        
    , 201 );
    
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
        
    , 201 );
    
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
        
    , 100 );
    
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
        
    , 101 );
    
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
        
    , 202 );
    
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
        
    , 203 );
    
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
        
    , 100 );
    
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
        
    , 606 );
    
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
        
    , 405 );
    
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
        
    , 3315 );
    
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
        
    , 5125 );
    
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
        
    , 1707 );
    
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
        
    , 1506 );
    
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
        
    , 1707 );
    
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
        
    , 201 );
    
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
        
    , 12155 );
    
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
        
    , 11148 );
    
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
        
    , 12958 );
    
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
        
    , 301 );
    
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
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, RightDivide( cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1 ) );
end
########
        
    , 504 );
    
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
        
    , 303 );
    
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
        
    , 2011 );
    
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
        
    , 4016 );
    
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
        
    , 4017 );
    
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
        
    , 805 );
    
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
        
    , 302 );
    
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
        
    , 201 );
    
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
        
    , 202 );
    
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
        
    , 201 );
    
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
        
    , 202 );
    
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
        
    , 4016 );
    
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
        
    , 4017 );
    
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
        
    , 805 );
    
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
        
    , 503 );
    
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
        
    , 504 );
    
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
        
    , 201 );
    
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
        
    , 100 );
    
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
        
    , 3915 );
    
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
        
    , 3815 );
    
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
        
    , 19782 );
    
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
        
    , 12151 );
    
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
        
    , 5929 );
    
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
        
    , 1707 );
    
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
        
    , 1506 );
    
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
        
    , 1707 );
    
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
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( alpha_1 );
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( 0, NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    , 100 );
    
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
        
    , 100 );
    
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
        
    , 15766 );
    
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
        
    , 15265 );
    
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
        
    , 14160 );
    
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
        
    , 14363 );
    
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
        
    , 13156 );
    
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
        
    , 12953 );
    
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
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
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
        
    , 5828 );
    
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
        
    , 503 );
    
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
        
    , 504 );
    
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
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := tau_1[2];
    cap_jit_morphism_attribute_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Source( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    , 704 );
    
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
        
    , 705 );
    
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
        
    , 4117 );
    
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
        
    , 4118 );
    
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
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := tau_1[1];
    cap_jit_morphism_attribute_1_1 := LeftDivide( UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ), SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( cap_jit_deduplicated_expression_1_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
end
########
        
    , 704 );
    
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
        
    , 705 );
    
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
        
    , 503 );
    
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
        
    , 504 );
    
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
        
    , 4117 );
    
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
        
    , 4118 );
    
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
    local cap_jit_morphism_attribute_1_1;
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
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
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    cap_jit_morphism_attribute_1_1 := HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, cap_jit_morphism_attribute_1_1 );
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
