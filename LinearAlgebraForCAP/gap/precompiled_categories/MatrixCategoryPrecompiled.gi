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
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + UnderlyingMatrix( b_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, - UnderlyingMatrix( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAssociatorLeftToRight( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_4_1;
    morphism_attr_4_1 := HomalgIdentityMatrix( Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_4_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_4_1 ) ), UnderlyingMatrix, morphism_attr_4_1 );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( s_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddAssociatorRightToLeft( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_4_1;
    morphism_attr_4_1 := HomalgIdentityMatrix( Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_4_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_4_1 ) ), UnderlyingMatrix, morphism_attr_4_1 );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( s_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddAstrictionToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_2_1 ) ), deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddAstrictionToCoimageWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_2_1 ) ), deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 705 : IsPrecompiledDerivation := true );
    
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
            return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( CertainRows( hoisted_1_1, [ logic_new_func_x_2 ] ), hoisted_2_1, hoisted_3_1 ) );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_3_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_3_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := Dimension( s_1 );
    hoisted_4_1 := Dimension( b_1 );
    hoisted_3_1 := Dimension( a_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1;
                end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := Dimension( s_1 );
    hoisted_2_1 := Dimension( a_1 );
    hoisted_1_1 := Dimension( b_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, hoisted_1_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_1_1 ) + 1;
                end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoDualOnMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), Source( alpha_1 ), UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddCoDualOnMorphismsWithGivenCoDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoDualOnObjects( cat,
        
########
function ( cat_1, a_1 )
    return a_1;
end
########
        
    , 100 );
    
    ##
    AddCoDualityTensorProductCompatibilityMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
    deduped_21_1 := UnderlyingRing( cat_1 );
    deduped_20_1 := Dimension( a_1 );
    deduped_19_1 := Dimension( b_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_21_1 );
    deduped_17_1 := HomalgIdentityMatrix( deduped_19_1, deduped_21_1 );
    deduped_16_1 := HomalgIdentityMatrix( 1, deduped_21_1 );
    deduped_15_1 := 1 * deduped_20_1;
    deduped_14_1 := deduped_20_1 * deduped_19_1;
    deduped_13_1 := 1 * deduped_19_1;
    deduped_12_1 := deduped_14_1 * deduped_14_1;
    deduped_11_1 := deduped_20_1 * deduped_13_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_14_1, deduped_21_1 );
    deduped_9_1 := deduped_15_1 * deduped_13_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_9_1, deduped_21_1 );
    deduped_7_1 := deduped_9_1 * deduped_14_1;
    hoisted_6_1 := deduped_9_1;
    hoisted_5_1 := deduped_14_1;
    hoisted_4_1 := deduped_13_1;
    hoisted_3_1 := deduped_20_1;
    hoisted_2_1 := deduped_19_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_10_1 ), KroneckerMat( deduped_16_1, KroneckerMat( deduped_16_1, ConvertMatrixToRow( deduped_17_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                                end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_21_1 ), deduped_17_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_19_1 * 1), deduped_21_1 ), deduped_17_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_16_1, ConvertMatrixToRow( deduped_18_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                                      local deduped_1_2;
                                      deduped_1_2 := (i_2 - 1);
                                      return (REM_INT( deduped_1_2, hoisted_3_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                                  end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_21_1 ), deduped_18_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_20_1 * 1), deduped_21_1 ), deduped_18_1 )), HomalgIdentityMatrix( deduped_13_1, deduped_21_1 ) ), deduped_17_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_21_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                          end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_21_1 ) ), deduped_17_1 ) ) * (KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                        end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_21_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                        end ) ), deduped_12_1 ), deduped_12_1, deduped_12_1, deduped_21_1 ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_10_1 ), deduped_8_1 )) * KroneckerMat( deduped_18_1, deduped_17_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 16378 : IsPrecompiledDerivation := true );
    
    ##
    AddCoDualityTensorProductCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
    deduped_21_1 := UnderlyingRing( cat_1 );
    deduped_20_1 := Dimension( a_1 );
    deduped_19_1 := Dimension( b_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_21_1 );
    deduped_17_1 := HomalgIdentityMatrix( deduped_19_1, deduped_21_1 );
    deduped_16_1 := HomalgIdentityMatrix( 1, deduped_21_1 );
    deduped_15_1 := 1 * deduped_20_1;
    deduped_14_1 := deduped_20_1 * deduped_19_1;
    deduped_13_1 := 1 * deduped_19_1;
    deduped_12_1 := deduped_14_1 * deduped_14_1;
    deduped_11_1 := deduped_20_1 * deduped_13_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_14_1, deduped_21_1 );
    deduped_9_1 := deduped_15_1 * deduped_13_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_9_1, deduped_21_1 );
    deduped_7_1 := deduped_9_1 * deduped_14_1;
    hoisted_6_1 := deduped_9_1;
    hoisted_5_1 := deduped_14_1;
    hoisted_4_1 := deduped_13_1;
    hoisted_3_1 := deduped_20_1;
    hoisted_2_1 := deduped_19_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_10_1 ), KroneckerMat( deduped_16_1, KroneckerMat( deduped_16_1, ConvertMatrixToRow( deduped_17_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                                end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_21_1 ), deduped_17_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_19_1 * 1), deduped_21_1 ), deduped_17_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_16_1, ConvertMatrixToRow( deduped_18_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                                      local deduped_1_2;
                                      deduped_1_2 := (i_2 - 1);
                                      return (REM_INT( deduped_1_2, hoisted_3_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                                  end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_21_1 ), deduped_18_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_20_1 * 1), deduped_21_1 ), deduped_18_1 )), HomalgIdentityMatrix( deduped_13_1, deduped_21_1 ) ), deduped_17_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_21_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                          end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_21_1 ) ), deduped_17_1 ) ) * (KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                        end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_21_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                        end ) ), deduped_12_1 ), deduped_12_1, deduped_12_1, deduped_21_1 ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_10_1 ), deduped_8_1 )) * KroneckerMat( deduped_18_1, deduped_17_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 15877 : IsPrecompiledDerivation := true );
    
    ##
    AddCoLambdaElimination( cat,
        
########
function ( cat_1, a_1, b_1, alpha_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := deduped_7_1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_8_1 );
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_8_1 ), ConvertMatrixToRow( deduped_4_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_6_1 * deduped_7_1), deduped_8_1 ), deduped_4_1 ) * KroneckerMat( UnderlyingMatrix( alpha_1 ), deduped_4_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), b_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3416 : IsPrecompiledDerivation := true );
    
    ##
    AddCoLambdaIntroduction( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := HomalgIdentityMatrix( 1, deduped_8_1 );
    deduped_6_1 := Dimension( Range( alpha_1 ) );
    deduped_5_1 := deduped_6_1 * deduped_6_1;
    deduped_4_1 := 1 * deduped_6_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_6_1, deduped_8_1 );
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_3_1 ), UnderlyingMatrix( alpha_1 ) ) * (KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_8_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_7_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5327 : IsPrecompiledDerivation := true );
    
    ##
    AddCoRankMorphism( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := HomalgIdentityMatrix( 1, deduped_8_1 );
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := 1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    hoisted_2_1 := deduped_7_1;
    morphism_attr_1_1 := ConvertMatrixToRow( deduped_3_1 ) * (KroneckerMat( TransposedMatrix( deduped_3_1 ), deduped_3_1 ) * (KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_8_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_6_1 )));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 6232 : IsPrecompiledDerivation := true );
    
    ##
    AddCoTraceMap( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := HomalgIdentityMatrix( 1, deduped_8_1 );
    deduped_6_1 := Dimension( Range( alpha_1 ) );
    deduped_5_1 := deduped_6_1 * deduped_6_1;
    deduped_4_1 := 1 * deduped_6_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_6_1, deduped_8_1 );
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := ConvertMatrixToRow( HomalgIdentityMatrix( Dimension( Source( alpha_1 ) ), deduped_8_1 ) ) * (KroneckerMat( TransposedMatrix( deduped_3_1 ), UnderlyingMatrix( alpha_1 ) ) * (KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_8_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_7_1 )));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 6131 : IsPrecompiledDerivation := true );
    
    ##
    AddCoastrictionToImage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := RightDivide( deduped_2_1, SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddCoastrictionToImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := RightDivide( deduped_2_1, SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 705 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedCoevaluationForCoDual( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToColumn( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedCoevaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoclosedCoevaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := Dimension( b_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_9_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_10_1 );
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    morphism_attr_1_1 := KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_10_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_10_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_7_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2912 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedCoevaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := Dimension( b_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_9_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_10_1 );
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    morphism_attr_1_1 := KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_10_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_10_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_7_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2509 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedEvaluationForCoDual( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToRow( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedEvaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoclosedEvaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := deduped_7_1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_8_1 );
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_8_1 ), ConvertMatrixToRow( deduped_4_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_6_1 * deduped_7_1), deduped_8_1 ), deduped_4_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2711 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedEvaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := deduped_7_1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_8_1 );
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_8_1 ), ConvertMatrixToRow( deduped_4_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_6_1 * deduped_7_1), deduped_8_1 ), deduped_4_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2308 : IsPrecompiledDerivation := true );
    
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
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToRow( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) ) );
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
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_10_1 ), deduped_5_1 ) * KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                  end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_10_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2912 : IsPrecompiledDerivation := true );
    
    ##
    AddCoevaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
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
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_10_1 ), deduped_5_1 ) * KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                  end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_10_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2509 : IsPrecompiledDerivation := true );
    
    ##
    AddCoimageObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Dimension( Source( arg2_1 ) ) - RowRankOfMatrix( SyzygiesOfRows( UnderlyingMatrix( arg2_1 ) ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddCoimageProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 602 : IsPrecompiledDerivation := true );
    
    ##
    AddCoimageProjectionWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 603 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelColift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( tau_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( tau_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( tau_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( tau_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Dimension( Range( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( mu_1 ) * SyzygiesOfColumns( UnderlyingMatrix( alphap_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 606 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelObjectFunctorialWithGivenCokernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( mu_1 ) * SyzygiesOfColumns( UnderlyingMatrix( alphap_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 405 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( epsilon_1 ), Range( tau_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( epsilon_1 ), UnderlyingMatrix( tau_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, Dimension );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, S_1[i_1], Range( alpha_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), S_1[i_1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddCoproduct( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Sum( List( arg2_1, Dimension ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddCoproductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := List( objectsp_1, Dimension );
    hoisted_5_1 := Length( objectsp_1 );
    hoisted_4_1 := deduped_7_1;
    hoisted_3_1 := deduped_6_1;
    hoisted_2_1 := List( L_1, UnderlyingMatrix );
    morphism_attr_1_1 := UnionOfRows( deduped_7_1, Sum( deduped_6_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
              return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2118 : IsPrecompiledDerivation := true );
    
    ##
    AddCoproductFunctorialWithGivenCoproducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := Length( objectsp_1 );
    hoisted_4_1 := deduped_6_1;
    hoisted_3_1 := List( objectsp_1, Dimension );
    hoisted_2_1 := List( L_1, UnderlyingMatrix );
    morphism_attr_1_1 := UnionOfRows( deduped_6_1, Dimension( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
              return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Pp_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1713 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectProduct( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Sum( List( arg2_1, Dimension ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectProductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := List( objects_1, Dimension );
    hoisted_5_1 := List( L_1, UnderlyingMatrix );
    hoisted_4_1 := Length( objects_1 );
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := UnionOfColumns( deduped_7_1, Sum( deduped_6_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2118 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectProductFunctorialWithGivenDirectProducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := List( L_1, UnderlyingMatrix );
    hoisted_4_1 := Length( objects_1 );
    hoisted_3_1 := deduped_6_1;
    hoisted_2_1 := List( objects_1, Dimension );
    morphism_attr_1_1 := UnionOfColumns( deduped_6_1, Dimension( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1713 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Sum( List( arg2_1, Dimension ) ) );
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
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( D_1, UnderlyingMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1104 : IsPrecompiledDerivation := true );
    
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
    hoisted_5_1 := List( D_1, UnderlyingMatrix );
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
        end );
    morphism_attr_1_1 := UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1104 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectSumFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := DiagMat( UnderlyingRing( cat_1 ), List( L_1, UnderlyingMatrix ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, Pp_1, UnderlyingMatrix, DiagMat( UnderlyingRing( cat_1 ), List( L_1, UnderlyingMatrix ) ) );
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
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( D_1, UnderlyingMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := SyzygiesOfColumns( UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2610 : IsPrecompiledDerivation := true );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 1 );
end
########
        
    , 100 );
    
    ##
    AddDualOnMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), Source( alpha_1 ), UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddDualOnMorphismsWithGivenDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddEvaluationForDual( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToColumn( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) ) );
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
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    deduped_4_1 := deduped_7_1 * deduped_6_1;
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_4_1, deduped_8_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_8_1 ), deduped_5_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), ConvertMatrixToColumn( deduped_5_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2711 : IsPrecompiledDerivation := true );
    
    ##
    AddEvaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    deduped_4_1 := deduped_7_1 * deduped_6_1;
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_4_1, deduped_8_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_8_1 ), deduped_5_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), ConvertMatrixToColumn( deduped_5_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2308 : IsPrecompiledDerivation := true );
    
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
    hoisted_4_1 := List( arg2_1, UnderlyingMatrix );
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    hoisted_1_1 := deduped_7_1;
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_1_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( hoisted_1_1{[ (logic_new_func_x_2 + 1) .. hoisted_3_1 ]} ), deduped_1_2, hoisted_2_1 ) ) * hoisted_4_1[logic_new_func_x_2];
        end );
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, deduped_6_1 - RowRankOfMatrix( (UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} )) ) );
end
########
        
    , 2611 : IsPrecompiledDerivation := true );
    
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
    hoisted_5_1 := List( D_1, UnderlyingMatrix );
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
        end );
    morphism_attr_1_1 := SyzygiesOfRows( UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2610 : IsPrecompiledDerivation := true );
    
    ##
    AddFiberProductFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1;
    deduped_20_1 := Length( morphismsp_1 );
    deduped_19_1 := Length( morphisms_1 );
    deduped_18_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_16_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_15_1 := Sum( deduped_17_1 );
    deduped_14_1 := Sum( deduped_16_1 );
    hoisted_10_1 := List( morphismsp_1, UnderlyingMatrix );
    hoisted_9_1 := deduped_20_1;
    hoisted_8_1 := deduped_17_1;
    hoisted_3_1 := deduped_18_1;
    deduped_13_1 := List( [ 1 .. deduped_20_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_8_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_8_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_8_1{[ (logic_new_func_x_2 + 1) .. hoisted_9_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_10_1[logic_new_func_x_2];
        end );
    hoisted_5_1 := List( morphisms_1, UnderlyingMatrix );
    hoisted_4_1 := deduped_19_1;
    hoisted_2_1 := deduped_16_1;
    deduped_12_1 := List( [ 1 .. deduped_19_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
        end );
    deduped_11_1 := UnionOfColumns( deduped_18_1, deduped_14_1, deduped_12_1{[ 1 .. deduped_19_1 - 1 ]} ) - UnionOfColumns( deduped_18_1, deduped_14_1, deduped_12_1{[ 2 .. deduped_19_1 ]} );
    hoisted_7_1 := List( L_1, UnderlyingMatrix );
    hoisted_6_1 := SyzygiesOfRows( deduped_11_1 );
    morphism_attr_1_1 := RightDivide( UnionOfColumns( deduped_18_1, deduped_14_1 - RowRankOfMatrix( deduped_11_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return CertainColumns( hoisted_6_1, [ deduped_1_2 .. (deduped_1_2 - 1 + hoisted_2_1[logic_new_func_x_2]) ] ) * hoisted_7_1[logic_new_func_x_2];
            end ) ), SyzygiesOfRows( UnionOfColumns( deduped_18_1, deduped_15_1, deduped_13_1{[ 1 .. deduped_20_1 - 1 ]} ) - UnionOfColumns( deduped_18_1, deduped_15_1, deduped_13_1{[ 2 .. deduped_20_1 ]} ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 13762 : IsPrecompiledDerivation := true );
    
    ##
    AddFiberProductFunctorialWithGivenFiberProducts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
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
    hoisted_10_1 := List( morphismsp_1, UnderlyingMatrix );
    hoisted_9_1 := deduped_19_1;
    hoisted_8_1 := deduped_16_1;
    hoisted_3_1 := deduped_17_1;
    deduped_12_1 := List( [ 1 .. deduped_19_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_8_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_8_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_8_1{[ (logic_new_func_x_2 + 1) .. hoisted_9_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_10_1[logic_new_func_x_2];
        end );
    hoisted_5_1 := List( morphisms_1, UnderlyingMatrix );
    hoisted_4_1 := deduped_18_1;
    hoisted_2_1 := deduped_15_1;
    deduped_11_1 := List( [ 1 .. deduped_18_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
        end );
    hoisted_7_1 := List( L_1, UnderlyingMatrix );
    hoisted_6_1 := SyzygiesOfRows( UnionOfColumns( deduped_17_1, deduped_13_1, deduped_11_1{[ 1 .. deduped_18_1 - 1 ]} ) - UnionOfColumns( deduped_17_1, deduped_13_1, deduped_11_1{[ 2 .. deduped_18_1 ]} ) );
    morphism_attr_1_1 := RightDivide( UnionOfColumns( deduped_17_1, Dimension( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return CertainColumns( hoisted_6_1, [ deduped_1_2 .. (deduped_1_2 - 1 + hoisted_2_1[logic_new_func_x_2]) ] ) * hoisted_7_1[logic_new_func_x_2];
            end ) ), SyzygiesOfRows( UnionOfColumns( deduped_17_1, deduped_14_1, deduped_12_1{[ 1 .. deduped_19_1 - 1 ]} ) - UnionOfColumns( deduped_17_1, deduped_14_1, deduped_12_1{[ 2 .. deduped_19_1 ]} ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 8539 : IsPrecompiledDerivation := true );
    
    ##
    AddHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( deduped_1_1 ) - RowRankOfMatrix( SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( beta_1 ) ) * deduped_1_1 ) ) );
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddHomologyObjectFunctorialWithGivenHomologyObjects( cat,
        
########
function ( cat_1, H_1_1, L_1, H_2_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := SyzygiesOfColumns( UnderlyingMatrix( L_1[4] ) );
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( L_1[1] ) );
    morphism_attr_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( L_1[2] ) ) * deduped_2_1 ) ) * LeftDivide( deduped_2_1, (UnderlyingMatrix( L_1[3] ) * deduped_3_1) ), SyzygiesOfRows( SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( L_1[5] ) ) * deduped_3_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 4218 : IsPrecompiledDerivation := true );
    
    ##
    AddHomomorphismStructureOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, UnderlyingMatrix, KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Dimension( arg2_1 ) * Dimension( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddImageEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 602 : IsPrecompiledDerivation := true );
    
    ##
    AddImageEmbeddingWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 603 : IsPrecompiledDerivation := true );
    
    ##
    AddImageObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Dimension( Range( arg2_1 ) ) - RowRankOfMatrix( SyzygiesOfColumns( UnderlyingMatrix( arg2_1 ) ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddInitialObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddInitialObjectFunctorial( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddInitialObjectFunctorialWithGivenInitialObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( Pp_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := List( objects_1, Dimension );
    deduped_2_1 := deduped_3_1[k_1];
    morphism_attr_1_1 := UnionOfColumns( HomalgZeroMatrix( deduped_2_1, Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_4_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), HomalgZeroMatrix( deduped_2_1, Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_4_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := List( objects_1, Dimension );
    deduped_2_1 := deduped_3_1[k_1];
    morphism_attr_1_1 := UnionOfColumns( HomalgZeroMatrix( deduped_2_1, Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_4_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), HomalgZeroMatrix( deduped_2_1, Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_4_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := List( objects_1, Dimension );
    deduped_2_1 := deduped_3_1[k_1];
    morphism_attr_1_1 := UnionOfColumns( HomalgZeroMatrix( deduped_2_1, Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_4_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), HomalgZeroMatrix( deduped_2_1, Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_4_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( objects_1, Dimension );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], P_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} ) + 1;
    hoisted_4_1 := deduped_11_1;
    hoisted_3_1 := deduped_10_1;
    hoisted_2_1 := deduped_9_1;
    hoisted_1_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return hoisted_1_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), hoisted_3_1 ) );
        end );
    deduped_5_1 := CertainRows( SyzygiesOfColumns( UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} ) ), [ deduped_7_1 .. deduped_7_1 - 1 + deduped_9_1[k_1] ] );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[k_1] ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( deduped_5_1 ) ), UnderlyingMatrix, deduped_5_1 );
end
########
        
    , 2711 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} ) + 1;
    hoisted_4_1 := deduped_11_1;
    hoisted_3_1 := deduped_10_1;
    hoisted_2_1 := deduped_9_1;
    hoisted_1_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return hoisted_1_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), hoisted_3_1 ) );
        end );
    deduped_5_1 := CertainRows( SyzygiesOfColumns( UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} ) ), [ deduped_7_1 .. deduped_7_1 - 1 + deduped_9_1[k_1] ] );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[k_1] ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( deduped_5_1 ) ), UnderlyingMatrix, deduped_5_1 );
end
########
        
    , 2712 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectiveColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( beta_1 ) ), UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1911 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomOnMorphismsWithGivenInternalCoHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( beta_1 ) ), UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1306 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphism( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1;
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_25_1 := List( list_1, Dimension );
    deduped_24_1 := deduped_25_1[1];
    deduped_23_1 := deduped_25_1[3];
    deduped_22_1 := deduped_25_1[2];
    deduped_21_1 := deduped_25_1[4];
    deduped_20_1 := HomalgIdentityMatrix( deduped_23_1, deduped_26_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_21_1, deduped_26_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_24_1, deduped_26_1 );
    deduped_17_1 := deduped_24_1 * deduped_23_1;
    deduped_16_1 := deduped_23_1 * deduped_21_1;
    deduped_15_1 := deduped_22_1 * deduped_21_1;
    deduped_14_1 := deduped_16_1 * deduped_16_1;
    deduped_13_1 := deduped_23_1 * deduped_15_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_16_1, deduped_26_1 );
    deduped_11_1 := deduped_17_1 * deduped_15_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_11_1, deduped_26_1 );
    deduped_9_1 := deduped_11_1 * deduped_16_1;
    hoisted_8_1 := deduped_11_1;
    hoisted_7_1 := deduped_16_1;
    hoisted_6_1 := deduped_15_1;
    hoisted_5_1 := deduped_24_1;
    hoisted_4_1 := deduped_23_1;
    hoisted_3_1 := deduped_22_1;
    hoisted_2_1 := deduped_21_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_12_1 ), KroneckerMat( deduped_18_1, KroneckerMat( HomalgIdentityMatrix( deduped_22_1, deduped_26_1 ), ConvertMatrixToRow( deduped_19_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                              end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_26_1 ), deduped_19_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_21_1 * deduped_22_1), deduped_26_1 ), deduped_19_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_18_1, ConvertMatrixToRow( deduped_20_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                                end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_26_1 ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_23_1 * deduped_24_1), deduped_26_1 ), deduped_20_1 )), HomalgIdentityMatrix( deduped_15_1, deduped_26_1 ) ), deduped_19_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_26_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                        end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_26_1 ) ), deduped_19_1 ) ) * (KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_8_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                      end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_26_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_7_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                      end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_26_1 ), deduped_10_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_12_1 ), deduped_10_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 14665 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphismInverse( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    deduped_26_1 := List( list_1, Dimension );
    deduped_25_1 := deduped_26_1[2];
    deduped_24_1 := deduped_26_1[1];
    deduped_23_1 := deduped_26_1[4];
    deduped_22_1 := deduped_26_1[3];
    deduped_21_1 := HomalgIdentityMatrix( deduped_22_1, deduped_27_1 );
    deduped_20_1 := HomalgIdentityMatrix( deduped_23_1, deduped_27_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_24_1, deduped_27_1 );
    deduped_18_1 := deduped_25_1 * deduped_23_1;
    deduped_17_1 := deduped_24_1 * deduped_22_1;
    deduped_16_1 := deduped_22_1 * deduped_23_1;
    deduped_15_1 := deduped_22_1 * deduped_18_1;
    deduped_14_1 := deduped_16_1 * deduped_16_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_16_1, deduped_27_1 );
    deduped_12_1 := deduped_17_1 * deduped_18_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_12_1, deduped_27_1 );
    deduped_10_1 := deduped_12_1 * deduped_16_1;
    hoisted_3_1 := deduped_12_1;
    hoisted_2_1 := deduped_16_1;
    deduped_9_1 := KroneckerMat( deduped_13_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_27_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_27_1 ), deduped_11_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_13_1 ), deduped_11_1 );
    hoisted_8_1 := deduped_18_1;
    hoisted_7_1 := deduped_24_1;
    hoisted_6_1 := deduped_22_1;
    hoisted_5_1 := deduped_25_1;
    hoisted_4_1 := deduped_23_1;
    morphism_attr_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( deduped_9_1 ), deduped_27_1 ), KroneckerMat( TransposedMatrix( deduped_13_1 ), KroneckerMat( deduped_19_1, KroneckerMat( HomalgIdentityMatrix( deduped_25_1, deduped_27_1 ), ConvertMatrixToRow( deduped_20_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                                end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_27_1 ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_23_1 * deduped_25_1), deduped_27_1 ), deduped_20_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_19_1, ConvertMatrixToRow( deduped_21_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                      local deduped_1_2;
                                      deduped_1_2 := (i_2 - 1);
                                      return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_7_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                                  end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_27_1 ), deduped_21_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_22_1 * deduped_24_1), deduped_27_1 ), deduped_21_1 )), HomalgIdentityMatrix( deduped_18_1, deduped_27_1 ) ), deduped_20_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_27_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_8_1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, hoisted_8_1 ) + 1);
                          end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_27_1 ) ), deduped_20_1 ) ) * deduped_9_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 14868 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    deduped_26_1 := List( list_1, Dimension );
    deduped_25_1 := deduped_26_1[2];
    deduped_24_1 := deduped_26_1[1];
    deduped_23_1 := deduped_26_1[4];
    deduped_22_1 := deduped_26_1[3];
    deduped_21_1 := HomalgIdentityMatrix( deduped_22_1, deduped_27_1 );
    deduped_20_1 := HomalgIdentityMatrix( deduped_23_1, deduped_27_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_24_1, deduped_27_1 );
    deduped_18_1 := deduped_25_1 * deduped_23_1;
    deduped_17_1 := deduped_24_1 * deduped_22_1;
    deduped_16_1 := deduped_22_1 * deduped_23_1;
    deduped_15_1 := deduped_22_1 * deduped_18_1;
    deduped_14_1 := deduped_16_1 * deduped_16_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_16_1, deduped_27_1 );
    deduped_12_1 := deduped_17_1 * deduped_18_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_12_1, deduped_27_1 );
    deduped_10_1 := deduped_12_1 * deduped_16_1;
    hoisted_3_1 := deduped_12_1;
    hoisted_2_1 := deduped_16_1;
    deduped_9_1 := KroneckerMat( deduped_13_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_27_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_27_1 ), deduped_11_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_13_1 ), deduped_11_1 );
    hoisted_8_1 := deduped_18_1;
    hoisted_7_1 := deduped_24_1;
    hoisted_6_1 := deduped_22_1;
    hoisted_5_1 := deduped_25_1;
    hoisted_4_1 := deduped_23_1;
    morphism_attr_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( deduped_9_1 ), deduped_27_1 ), KroneckerMat( TransposedMatrix( deduped_13_1 ), KroneckerMat( deduped_19_1, KroneckerMat( HomalgIdentityMatrix( deduped_25_1, deduped_27_1 ), ConvertMatrixToRow( deduped_20_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                                end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_27_1 ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_23_1 * deduped_25_1), deduped_27_1 ), deduped_20_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_19_1, ConvertMatrixToRow( deduped_21_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                      local deduped_1_2;
                                      deduped_1_2 := (i_2 - 1);
                                      return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_7_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                                  end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_27_1 ), deduped_21_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_22_1 * deduped_24_1), deduped_27_1 ), deduped_21_1 )), HomalgIdentityMatrix( deduped_18_1, deduped_27_1 ) ), deduped_20_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_27_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_8_1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, hoisted_8_1 ) + 1);
                          end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_27_1 ) ), deduped_20_1 ) ) * deduped_9_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 13661 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1;
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_25_1 := List( list_1, Dimension );
    deduped_24_1 := deduped_25_1[1];
    deduped_23_1 := deduped_25_1[3];
    deduped_22_1 := deduped_25_1[2];
    deduped_21_1 := deduped_25_1[4];
    deduped_20_1 := HomalgIdentityMatrix( deduped_23_1, deduped_26_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_21_1, deduped_26_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_24_1, deduped_26_1 );
    deduped_17_1 := deduped_24_1 * deduped_23_1;
    deduped_16_1 := deduped_23_1 * deduped_21_1;
    deduped_15_1 := deduped_22_1 * deduped_21_1;
    deduped_14_1 := deduped_16_1 * deduped_16_1;
    deduped_13_1 := deduped_23_1 * deduped_15_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_16_1, deduped_26_1 );
    deduped_11_1 := deduped_17_1 * deduped_15_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_11_1, deduped_26_1 );
    deduped_9_1 := deduped_11_1 * deduped_16_1;
    hoisted_8_1 := deduped_11_1;
    hoisted_7_1 := deduped_16_1;
    hoisted_6_1 := deduped_15_1;
    hoisted_5_1 := deduped_24_1;
    hoisted_4_1 := deduped_23_1;
    hoisted_3_1 := deduped_22_1;
    hoisted_2_1 := deduped_21_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_12_1 ), KroneckerMat( deduped_18_1, KroneckerMat( HomalgIdentityMatrix( deduped_22_1, deduped_26_1 ), ConvertMatrixToRow( deduped_19_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                              end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_26_1 ), deduped_19_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_21_1 * deduped_22_1), deduped_26_1 ), deduped_19_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_18_1, ConvertMatrixToRow( deduped_20_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                                end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_26_1 ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_23_1 * deduped_24_1), deduped_26_1 ), deduped_20_1 )), HomalgIdentityMatrix( deduped_15_1, deduped_26_1 ) ), deduped_19_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_26_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                        end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_26_1 ) ), deduped_19_1 ) ) * (KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_8_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                      end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_26_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_7_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                      end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_26_1 ), deduped_10_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_12_1 ), deduped_10_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 13458 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomToTensorProductAdjunctionMap( cat,
        
########
function ( cat_1, a_1, b_1, f_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := deduped_7_1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_8_1 );
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_8_1 ), ConvertMatrixToRow( deduped_4_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_6_1 * deduped_7_1), deduped_8_1 ), deduped_4_1 ) * KroneckerMat( UnderlyingMatrix( f_1 ), deduped_4_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3213 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1911 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomOnMorphismsWithGivenInternalHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1306 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomToTensorProductAdjunctionMap( cat,
        
########
function ( cat_1, b_1, c_1, g_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( b_1 );
    deduped_6_1 := Dimension( c_1 );
    deduped_5_1 := deduped_7_1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( UnderlyingMatrix( g_1 ), deduped_4_1 ) * (KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), ConvertMatrixToColumn( deduped_4_1 ) ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3213 : IsPrecompiledDerivation := true );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, UnderlyingMatrix, ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( UnderlyingMatrix( arg4_1 ), Dimension( arg2_1 ), Dimension( arg3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := Range( alpha_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_1_1, Source( alpha_1 ), UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddInverseMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := SyzygiesOfColumns( deduped_3_1 );
    morphism_attr_1_1 := RightDivide( HomalgIdentityMatrix( Dimension( Range( alpha_1 ) ) - RowRankOfMatrix( deduped_2_1 ), UnderlyingRing( cat_1 ) ), RightDivide( LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_3_1 ) ), deduped_3_1 ), SyzygiesOfRows( deduped_2_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2214 : IsPrecompiledDerivation := true );
    
    ##
    AddIsAutomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) );
    deduped_2_1 := Dimension( Range( arg2_1 ) );
    deduped_1_1 := Dimension( Source( arg2_1 ) );
    return deduped_1_1 = deduped_2_1 and (deduped_1_1 - deduped_3_1 = 0 and deduped_2_1 - deduped_3_1 = 0);
end
########
        
    , 505 : IsPrecompiledDerivation := true );
    
    ##
    AddIsBijectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return true and true;
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsCodominating( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
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
        
    , 101 : IsPrecompiledDerivation := true );
    
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
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEndomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( Source( arg2_1 ) ) = Dimension( Range( arg2_1 ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( Range( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = 0;
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualAsFactorobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( arg3_1 );
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return IsZero( DecideZeroColumns( deduped_1_1, deduped_2_1 ) ) and IsZero( DecideZeroColumns( deduped_2_1, deduped_1_1 ) );
end
########
        
    , 205 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualAsSubobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( arg3_1 );
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return IsZero( DecideZeroRows( deduped_1_1, deduped_2_1 ) ) and IsZero( DecideZeroRows( deduped_2_1, deduped_1_1 ) );
end
########
        
    , 205 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphismsOnMor( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    if Dimension( Source( arg2_1 ) ) = Dimension( Source( arg3_1 ) ) and Dimension( Range( arg2_1 ) ) = Dimension( Range( arg3_1 ) ) then
        return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
    else
        return false;
    fi;
    return;
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return Dimension( arg2_1 ) = Dimension( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsEqualToIdentityMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := Dimension( Source( arg2_1 ) );
    if true and Dimension( Range( arg2_1 ) ) = deduped_1_1 then
        return UnderlyingMatrix( arg2_1 ) = HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) );
    else
        return false;
    fi;
    return;
end
########
        
    , 402 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualToZeroMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return UnderlyingMatrix( arg2_1 ) = HomalgZeroMatrix( Dimension( Source( arg2_1 ) ), Dimension( Range( arg2_1 ) ), UnderlyingRing( cat_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsIdempotent( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return deduped_1_1 * deduped_1_1 = deduped_1_1;
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
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
    deduped_1_1 := RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) );
    return Dimension( Source( arg2_1 ) ) - deduped_1_1 = 0 and Dimension( Range( arg2_1 ) ) - deduped_1_1 = 0;
end
########
        
    , 403 : IsPrecompiledDerivation := true );
    
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
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( Source( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = 0;
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsOne( cat,
        
########
function ( cat_1, arg2_1 )
    return HomalgIdentityMatrix( Dimension( Source( arg2_1 ) ), UnderlyingRing( cat_1 ) ) = UnderlyingMatrix( arg2_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
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
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsSplitMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroColumns( HomalgIdentityMatrix( Dimension( Source( arg2_1 ) ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsTerminal( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    if NumberRows( deduped_1_1 ) <> Dimension( Source( arg2_1 ) ) then
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
    if Dimension( arg2_1 ) < 0 then
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
    AddIsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromCoimageToCokernelOfKernel( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( Source( alpha_1 ) ) - RowRankOfMatrix( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromCokernelOfDiagonalDifferenceToPushout( cat,
        
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
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( D_1, UnderlyingMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := HomalgIdentityMatrix( deduped_7_1 - RowRankOfMatrix( (UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} )) ), deduped_9_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1305 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromCokernelOfKernelToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( Source( alpha_1 ) ) - RowRankOfMatrix( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromCoproductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, Dimension ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromDirectProductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, Dimension ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromDirectSumToCoproduct( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, Dimension ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromDirectSumToDirectProduct( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, Dimension ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromFiberProductToKernelOfDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( D_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := List( D_1, UnderlyingMatrix );
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
        end );
    morphism_attr_1_1 := HomalgIdentityMatrix( deduped_7_1 - RowRankOfMatrix( (UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} )) ), deduped_9_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1305 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberColumns( deduped_2_1 ) - RowRankOfMatrix( SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( beta_1 ) ) * deduped_2_1 ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 703 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromImageObjectToKernelOfCokernel( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( Range( alpha_1 ) ) - RowRankOfMatrix( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInitialObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToObject( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := 1 * 1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := deduped_6_1 * 1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_7_1 );
    deduped_3_1 := HomalgIdentityMatrix( 1, deduped_7_1 );
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_3_1 ), deduped_4_1 ) * (KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_7_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * 1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_7_1 ), deduped_4_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_4_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5227 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom( cat,
        
########
function ( cat_1, a_1, s_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := 1 * 1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := deduped_6_1 * 1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_7_1 );
    deduped_3_1 := HomalgIdentityMatrix( 1, deduped_7_1 );
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_3_1 ), deduped_4_1 ) * (KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_7_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * 1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_7_1 ), deduped_4_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_4_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5226 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomIntoTensorUnitToDualObject( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToObject( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := Dimension( a_1 );
    deduped_4_1 := HomalgIdentityMatrix( 1, deduped_6_1 );
    deduped_3_1 := 1 * deduped_5_1;
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_3_1, deduped_6_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, deduped_6_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), ConvertMatrixToColumn( deduped_4_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3015 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToObjectWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, s_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := Dimension( a_1 );
    deduped_4_1 := HomalgIdentityMatrix( 1, deduped_6_1 );
    deduped_3_1 := 1 * deduped_5_1;
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_3_1, deduped_6_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, deduped_6_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), ConvertMatrixToColumn( deduped_4_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3014 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToTensorProductWithDualObject( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromItsConstructionAsAnImageObjectToHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_1_1 := HomalgIdentityMatrix( NumberColumns( deduped_2_1 ) - RowRankOfMatrix( SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( beta_1 ) ) * deduped_2_1 ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 703 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromKernelOfCokernelToImageObject( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( Range( alpha_1 ) ) - RowRankOfMatrix( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromKernelOfDiagonalDifferenceToFiberProduct( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( D_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_5_1 := List( D_1, UnderlyingMatrix );
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
        end );
    morphism_attr_1_1 := HomalgIdentityMatrix( deduped_7_1 - RowRankOfMatrix( (UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} )) ), deduped_9_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1305 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromObjectToInternalCoHom( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := Dimension( a_1 );
    deduped_4_1 := deduped_5_1 * 1;
    deduped_3_1 := HomalgIdentityMatrix( 1, deduped_6_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), ConvertMatrixToRow( deduped_3_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                    end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_6_1 ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( (1 * deduped_5_1), deduped_6_1 ), deduped_3_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), a_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3015 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom( cat,
        
########
function ( cat_1, a_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := Dimension( a_1 );
    deduped_4_1 := deduped_5_1 * 1;
    deduped_3_1 := HomalgIdentityMatrix( 1, deduped_6_1 );
    hoisted_2_1 := deduped_5_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), ConvertMatrixToRow( deduped_3_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                    end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_6_1 ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( (1 * deduped_5_1), deduped_6_1 ), deduped_3_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), r_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3014 : IsPrecompiledDerivation := true );
    
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
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * 1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_7_1 ), deduped_4_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_7_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), deduped_4_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5227 : IsPrecompiledDerivation := true );
    
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
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * 1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_7_1 ), deduped_4_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_2_1 ) * 1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_7_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), deduped_4_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5226 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromPushoutToCokernelOfDiagonalDifference( cat,
        
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
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( D_1, UnderlyingMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := HomalgIdentityMatrix( deduped_7_1 - RowRankOfMatrix( (UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} )) ), deduped_9_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1305 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromTensorProductWithDualObjectToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromTerminalObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromZeroObjectToInitialObject( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromZeroObjectToTerminalObject( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddKernelEmbeddingWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelLift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := RightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( tau_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := RightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( tau_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Dimension( Source( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddKernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := RightDivide( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) * UnderlyingMatrix( mu_1 ), SyzygiesOfRows( UnderlyingMatrix( alphap_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 606 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelObjectFunctorialWithGivenKernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := RightDivide( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) * UnderlyingMatrix( mu_1 ), SyzygiesOfRows( UnderlyingMatrix( alphap_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 405 : IsPrecompiledDerivation := true );
    
    ##
    AddLambdaElimination( cat,
        
########
function ( cat_1, a_1, b_1, alpha_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := deduped_7_1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := KroneckerMat( UnderlyingMatrix( alpha_1 ), deduped_4_1 ) * (KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), ConvertMatrixToColumn( deduped_4_1 ) ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 3416 : IsPrecompiledDerivation := true );
    
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
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_8_1 ), deduped_7_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5327 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftDistributivityExpanding( cat,
        
########
function ( cat_1, a_1, L_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := Length( L_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := List( L_1, Dimension );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_7_1 );
    hoisted_4_1 := deduped_8_1;
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := UnionOfColumns( deduped_7_1, deduped_9_1 * Sum( deduped_6_1 ), List( [ 1 .. deduped_8_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return KroneckerMat( hoisted_5_1, UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ logic_new_func_x_2 + 1 .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_6_1 );
    hoisted_4_1 := deduped_7_1;
    hoisted_3_1 := deduped_6_1;
    hoisted_2_1 := List( L_1, Dimension );
    morphism_attr_1_1 := UnionOfColumns( deduped_6_1, Dimension( s_1 ), List( [ 1 .. deduped_7_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return KroneckerMat( hoisted_5_1, UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ logic_new_func_x_2 + 1 .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftDistributivityFactoring( cat,
        
########
function ( cat_1, a_1, L_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := Length( L_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := List( L_1, Dimension );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_7_1 );
    hoisted_4_1 := deduped_8_1;
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := UnionOfRows( deduped_7_1, deduped_9_1 * Sum( deduped_6_1 ), List( [ 1 .. deduped_8_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return KroneckerMat( hoisted_5_1, UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ logic_new_func_x_2 + 1 .. hoisted_4_1 ]} ), hoisted_3_1 ) ) );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_6_1 );
    hoisted_4_1 := deduped_7_1;
    hoisted_3_1 := deduped_6_1;
    hoisted_2_1 := List( L_1, Dimension );
    morphism_attr_1_1 := UnionOfRows( deduped_6_1, Dimension( r_1 ), List( [ 1 .. deduped_7_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return KroneckerMat( hoisted_5_1, UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ logic_new_func_x_2 + 1 .. hoisted_4_1 ]} ), hoisted_3_1 ) ) );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), r_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitor( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( tau_1 ), Source( iota_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( iota_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
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
        
    , 2206 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPostCoComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := Dimension( c_1 );
    deduped_15_1 := Dimension( a_1 );
    deduped_14_1 := Dimension( b_1 );
    deduped_13_1 := deduped_16_1 * deduped_16_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_14_1, deduped_17_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_16_1, deduped_17_1 );
    deduped_10_1 := deduped_14_1 * deduped_16_1;
    deduped_9_1 := deduped_15_1 * deduped_14_1;
    deduped_8_1 := deduped_9_1 * deduped_10_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_8_1, deduped_17_1 );
    deduped_6_1 := deduped_8_1 * deduped_16_1;
    hoisted_5_1 := deduped_8_1;
    hoisted_4_1 := deduped_16_1;
    hoisted_3_1 := deduped_15_1;
    hoisted_2_1 := deduped_14_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_11_1 ), KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_17_1 ), ConvertMatrixToRow( deduped_12_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                          end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_17_1 ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_14_1 * deduped_15_1), deduped_17_1 ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_9_1, deduped_17_1 ), (KroneckerMat( deduped_12_1, ConvertMatrixToRow( deduped_11_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                            end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_17_1 ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_16_1 * deduped_14_1), deduped_17_1 ), deduped_11_1 )) ) ) * (KroneckerMat( deduped_11_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_17_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_17_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_11_1 ), deduped_7_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 12660 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPostCoComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := Dimension( c_1 );
    deduped_15_1 := Dimension( a_1 );
    deduped_14_1 := Dimension( b_1 );
    deduped_13_1 := deduped_16_1 * deduped_16_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_14_1, deduped_17_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_16_1, deduped_17_1 );
    deduped_10_1 := deduped_14_1 * deduped_16_1;
    deduped_9_1 := deduped_15_1 * deduped_14_1;
    deduped_8_1 := deduped_9_1 * deduped_10_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_8_1, deduped_17_1 );
    deduped_6_1 := deduped_8_1 * deduped_16_1;
    hoisted_5_1 := deduped_8_1;
    hoisted_4_1 := deduped_16_1;
    hoisted_3_1 := deduped_15_1;
    hoisted_2_1 := deduped_14_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_11_1 ), KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_17_1 ), ConvertMatrixToRow( deduped_12_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                          end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_17_1 ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_14_1 * deduped_15_1), deduped_17_1 ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_9_1, deduped_17_1 ), (KroneckerMat( deduped_12_1, ConvertMatrixToRow( deduped_11_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                            end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_17_1 ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_16_1 * deduped_14_1), deduped_17_1 ), deduped_11_1 )) ) ) * (KroneckerMat( deduped_11_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_17_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_17_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_11_1 ), deduped_7_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 11653 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPostComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := Dimension( c_1 );
    deduped_16_1 := Dimension( b_1 );
    deduped_15_1 := Dimension( a_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_16_1, deduped_18_1 );
    deduped_13_1 := deduped_15_1 * deduped_15_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_15_1, deduped_18_1 );
    deduped_11_1 := deduped_15_1 * deduped_16_1;
    deduped_10_1 := deduped_16_1 * deduped_17_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_10_1, deduped_18_1 );
    deduped_8_1 := deduped_10_1 * deduped_11_1;
    deduped_7_1 := deduped_15_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_18_1 );
    hoisted_5_1 := deduped_17_1;
    hoisted_4_1 := deduped_16_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := deduped_15_1;
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_12_1 ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_18_1 ), deduped_6_1 ) * KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_18_1 ) ) * KroneckerMat( TransposedMatrix( deduped_12_1 ), (KroneckerMat( deduped_9_1, KroneckerMat( HomalgIdentityMatrix( deduped_11_1, deduped_18_1 ), deduped_12_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                            end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_18_1 ), deduped_12_1 ) * KroneckerMat( deduped_14_1, ConvertMatrixToColumn( deduped_12_1 ) ) ) * (KroneckerMat( deduped_9_1, deduped_14_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                          end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_18_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_18_1 ), ConvertMatrixToColumn( deduped_14_1 ) ))) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 12660 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPostComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := Dimension( c_1 );
    deduped_16_1 := Dimension( b_1 );
    deduped_15_1 := Dimension( a_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_16_1, deduped_18_1 );
    deduped_13_1 := deduped_15_1 * deduped_15_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_15_1, deduped_18_1 );
    deduped_11_1 := deduped_15_1 * deduped_16_1;
    deduped_10_1 := deduped_16_1 * deduped_17_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_10_1, deduped_18_1 );
    deduped_8_1 := deduped_10_1 * deduped_11_1;
    deduped_7_1 := deduped_15_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_18_1 );
    hoisted_5_1 := deduped_17_1;
    hoisted_4_1 := deduped_16_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := deduped_15_1;
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_12_1 ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_18_1 ), deduped_6_1 ) * KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_18_1 ) ) * KroneckerMat( TransposedMatrix( deduped_12_1 ), (KroneckerMat( deduped_9_1, KroneckerMat( HomalgIdentityMatrix( deduped_11_1, deduped_18_1 ), deduped_12_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                            end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_18_1 ), deduped_12_1 ) * KroneckerMat( deduped_14_1, ConvertMatrixToColumn( deduped_12_1 ) ) ) * (KroneckerMat( deduped_9_1, deduped_14_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                          end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_18_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_18_1 ), ConvertMatrixToColumn( deduped_14_1 ) ))) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 11653 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreCoComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1;
    deduped_20_1 := UnderlyingRing( cat_1 );
    deduped_19_1 := Dimension( c_1 );
    deduped_18_1 := Dimension( a_1 );
    deduped_17_1 := Dimension( b_1 );
    deduped_16_1 := deduped_19_1 * deduped_19_1;
    deduped_15_1 := HomalgIdentityMatrix( deduped_17_1, deduped_20_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_19_1, deduped_20_1 );
    deduped_13_1 := deduped_17_1 * deduped_19_1;
    deduped_12_1 := deduped_18_1 * deduped_17_1;
    deduped_11_1 := deduped_19_1 * deduped_12_1;
    deduped_10_1 := deduped_12_1 * deduped_17_1;
    deduped_9_1 := deduped_13_1 * deduped_12_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_9_1, deduped_20_1 );
    deduped_7_1 := deduped_9_1 * deduped_19_1;
    hoisted_6_1 := deduped_9_1;
    hoisted_5_1 := deduped_19_1;
    hoisted_4_1 := deduped_12_1;
    hoisted_3_1 := deduped_18_1;
    hoisted_2_1 := deduped_17_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_14_1 ), KroneckerMat( HomalgIdentityMatrix( deduped_18_1, deduped_20_1 ), ConvertMatrixToRow( deduped_15_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                              end ) ), deduped_12_1 ), deduped_12_1, deduped_12_1, deduped_20_1 ), deduped_15_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_17_1 * deduped_18_1), deduped_20_1 ), deduped_15_1 ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_20_1 ) * KroneckerMat( (KroneckerMat( deduped_15_1, ConvertMatrixToRow( deduped_14_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                              end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_20_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_19_1 * deduped_17_1), deduped_20_1 ), deduped_14_1 )), HomalgIdentityMatrix( deduped_12_1, deduped_20_1 ) ) * KroneckerMat( HomalgIdentityMatrix( deduped_13_1, deduped_20_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_20_1 ) ) ) * (KroneckerMat( deduped_14_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                      end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_20_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                      end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_20_1 ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_14_1 ), deduped_8_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 13463 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreCoComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1;
    deduped_20_1 := UnderlyingRing( cat_1 );
    deduped_19_1 := Dimension( c_1 );
    deduped_18_1 := Dimension( a_1 );
    deduped_17_1 := Dimension( b_1 );
    deduped_16_1 := deduped_19_1 * deduped_19_1;
    deduped_15_1 := HomalgIdentityMatrix( deduped_17_1, deduped_20_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_19_1, deduped_20_1 );
    deduped_13_1 := deduped_17_1 * deduped_19_1;
    deduped_12_1 := deduped_18_1 * deduped_17_1;
    deduped_11_1 := deduped_19_1 * deduped_12_1;
    deduped_10_1 := deduped_12_1 * deduped_17_1;
    deduped_9_1 := deduped_13_1 * deduped_12_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_9_1, deduped_20_1 );
    deduped_7_1 := deduped_9_1 * deduped_19_1;
    hoisted_6_1 := deduped_9_1;
    hoisted_5_1 := deduped_19_1;
    hoisted_4_1 := deduped_12_1;
    hoisted_3_1 := deduped_18_1;
    hoisted_2_1 := deduped_17_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_14_1 ), KroneckerMat( HomalgIdentityMatrix( deduped_18_1, deduped_20_1 ), ConvertMatrixToRow( deduped_15_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                              end ) ), deduped_12_1 ), deduped_12_1, deduped_12_1, deduped_20_1 ), deduped_15_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_17_1 * deduped_18_1), deduped_20_1 ), deduped_15_1 ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_20_1 ) * KroneckerMat( (KroneckerMat( deduped_15_1, ConvertMatrixToRow( deduped_14_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                              end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_20_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_19_1 * deduped_17_1), deduped_20_1 ), deduped_14_1 )), HomalgIdentityMatrix( deduped_12_1, deduped_20_1 ) ) * KroneckerMat( HomalgIdentityMatrix( deduped_13_1, deduped_20_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_20_1 ) ) ) * (KroneckerMat( deduped_14_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                      end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_20_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                      end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_20_1 ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_14_1 ), deduped_8_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 12456 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1;
    deduped_22_1 := UnderlyingRing( cat_1 );
    deduped_21_1 := Dimension( c_1 );
    deduped_20_1 := Dimension( b_1 );
    deduped_19_1 := Dimension( a_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_22_1 );
    deduped_17_1 := deduped_19_1 * deduped_19_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_19_1, deduped_22_1 );
    deduped_15_1 := deduped_20_1 * deduped_21_1;
    deduped_14_1 := deduped_19_1 * deduped_20_1;
    deduped_13_1 := deduped_20_1 * deduped_15_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_15_1, deduped_22_1 );
    deduped_11_1 := deduped_15_1 * deduped_19_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_14_1, deduped_22_1 );
    deduped_9_1 := deduped_14_1 * deduped_15_1;
    deduped_8_1 := deduped_19_1 * deduped_9_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_22_1 );
    hoisted_6_1 := deduped_21_1;
    hoisted_5_1 := deduped_20_1;
    hoisted_4_1 := deduped_15_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_19_1;
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_16_1 ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_22_1 ), deduped_7_1 ) * KroneckerMat( deduped_16_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_22_1 ) ) * KroneckerMat( TransposedMatrix( deduped_16_1 ), (KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                          end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_22_1 ) ) * KroneckerMat( (KroneckerMat( deduped_10_1, deduped_16_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                                end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_22_1 ), deduped_16_1 ) * KroneckerMat( deduped_18_1, ConvertMatrixToColumn( deduped_16_1 ) )), deduped_12_1 ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_22_1 ) * (KroneckerMat( deduped_12_1, deduped_18_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                          end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_22_1 ), deduped_18_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_21_1, deduped_22_1 ), ConvertMatrixToColumn( deduped_18_1 ) ))) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 13463 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1;
    deduped_22_1 := UnderlyingRing( cat_1 );
    deduped_21_1 := Dimension( c_1 );
    deduped_20_1 := Dimension( b_1 );
    deduped_19_1 := Dimension( a_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_22_1 );
    deduped_17_1 := deduped_19_1 * deduped_19_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_19_1, deduped_22_1 );
    deduped_15_1 := deduped_20_1 * deduped_21_1;
    deduped_14_1 := deduped_19_1 * deduped_20_1;
    deduped_13_1 := deduped_20_1 * deduped_15_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_15_1, deduped_22_1 );
    deduped_11_1 := deduped_15_1 * deduped_19_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_14_1, deduped_22_1 );
    deduped_9_1 := deduped_14_1 * deduped_15_1;
    deduped_8_1 := deduped_19_1 * deduped_9_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_22_1 );
    hoisted_6_1 := deduped_21_1;
    hoisted_5_1 := deduped_20_1;
    hoisted_4_1 := deduped_15_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_19_1;
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_16_1 ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_22_1 ), deduped_7_1 ) * KroneckerMat( deduped_16_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_22_1 ) ) * KroneckerMat( TransposedMatrix( deduped_16_1 ), (KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                          end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_22_1 ) ) * KroneckerMat( (KroneckerMat( deduped_10_1, deduped_16_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                                end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_22_1 ), deduped_16_1 ) * KroneckerMat( deduped_18_1, ConvertMatrixToColumn( deduped_16_1 ) )), deduped_12_1 ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                      end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_22_1 ) * (KroneckerMat( deduped_12_1, deduped_18_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                          end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_22_1 ), deduped_18_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_21_1, deduped_22_1 ), ConvertMatrixToColumn( deduped_18_1 ) ))) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 12456 : IsPrecompiledDerivation := true );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1, I_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismBetweenDirectSums( cat,
        
########
function ( cat_1, source_diagram_1, mat_1, range_diagram_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    hoisted_2_1 := deduped_3_1;
    morphism_attr_1_1 := UnionOfRows( deduped_3_1, Sum( List( range_diagram_1, Dimension ) ), ListN( source_diagram_1, mat_1, function ( logic_new_func_x_2, logic_new_func_y_2 )
              return UnionOfColumns( hoisted_2_1, Dimension( logic_new_func_x_2 ), List( logic_new_func_y_2, UnderlyingMatrix ) );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 402 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismBetweenDirectSumsWithGivenDirectSums( cat,
        
########
function ( cat_1, S_1, source_diagram_1, mat_1, range_diagram_1, T_1 )
    local hoisted_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    hoisted_1_1 := deduped_2_1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, S_1, T_1, UnderlyingMatrix, UnionOfRows( deduped_2_1, Dimension( T_1 ), ListN( source_diagram_1, mat_1, function ( logic_new_func_x_2, logic_new_func_y_2 )
                return UnionOfColumns( hoisted_1_1, Dimension( logic_new_func_x_2 ), List( logic_new_func_y_2, UnderlyingMatrix ) );
            end ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg4_1, UnderlyingMatrix, arg3_1 );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, RightDivide( deduped_1_1, deduped_1_1 ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingRing( cat_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, a_1, UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( s_1 ), deduped_1_1 ), HomalgIdentityMatrix( Dimension( a_1 ), deduped_1_1 ) ) );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromCoBidual( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromCoBidualWithGivenCoBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    morphism_attr_1_1 := RightDivide( LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_2_1 ) ), deduped_2_1 ), SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2011 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromFiberProductToSink( cat,
        
########
function ( cat_1, morphisms_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} ) + 1;
    hoisted_4_1 := deduped_12_1;
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_10_1;
    hoisted_1_1 := deduped_9_1;
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_1_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( hoisted_1_1{[ (logic_new_func_x_2 + 1) .. hoisted_3_1 ]} ), deduped_1_2, hoisted_2_1 ) ) * hoisted_4_1[logic_new_func_x_2];
        end );
    deduped_5_1 := CertainColumns( SyzygiesOfRows( (UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} )) ), [ deduped_7_1 .. (deduped_7_1 - 1 + deduped_9_1[1]) ] ) * deduped_12_1[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( deduped_5_1 ) ), Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ), UnderlyingMatrix, deduped_5_1 );
end
########
        
    , 2812 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromFiberProductToSinkWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} ) + 1;
    hoisted_4_1 := deduped_12_1;
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_10_1;
    hoisted_1_1 := deduped_9_1;
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_1_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( hoisted_1_1{[ (logic_new_func_x_2 + 1) .. hoisted_3_1 ]} ), deduped_1_2, hoisted_2_1 ) ) * hoisted_4_1[logic_new_func_x_2];
        end );
    deduped_5_1 := CertainColumns( SyzygiesOfRows( (UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} )) ), [ deduped_7_1 .. (deduped_7_1 - 1 + deduped_9_1[1]) ] ) * deduped_12_1[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( deduped_5_1 ) ), Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ), UnderlyingMatrix, deduped_5_1 );
end
########
        
    , 2813 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromInternalCoHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromInternalCoHomToTensorProductWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromInternalHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromInternalHomToTensorProductWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromKernelObjectToSink( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := Range( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( Source( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), Dimension( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromKernelObjectToSinkWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := Range( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( Source( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), Dimension( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromSourceToCokernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := Source( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( deduped_2_1 ), Dimension( Range( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromSourceToCokernelObjectWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := Source( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( deduped_2_1 ), Dimension( Range( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromSourceToPushout( cat,
        
########
function ( cat_1, morphisms_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} ) + 1;
    hoisted_4_1 := deduped_12_1;
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_9_1;
    hoisted_1_1 := deduped_10_1;
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return hoisted_1_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), hoisted_3_1 ) );
        end );
    deduped_5_1 := deduped_10_1[1] * CertainRows( SyzygiesOfColumns( (UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) - UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} )) ), [ deduped_7_1 .. (deduped_7_1 - 1 + deduped_9_1[1]) ] );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( deduped_5_1 ) ), UnderlyingMatrix, deduped_5_1 );
end
########
        
    , 2812 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromSourceToPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} ) + 1;
    hoisted_4_1 := deduped_12_1;
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_9_1;
    hoisted_1_1 := deduped_10_1;
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return hoisted_1_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), hoisted_3_1 ) );
        end );
    deduped_5_1 := deduped_10_1[1] * CertainRows( SyzygiesOfColumns( (UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) - UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} )) ), [ deduped_7_1 .. (deduped_7_1 - 1 + deduped_9_1[1]) ] );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( deduped_5_1 ) ), UnderlyingMatrix, deduped_5_1 );
end
########
        
    , 2813 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromTensorProductToInternalCoHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromTensorProductToInternalCoHomWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromTensorProductToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromTensorProductToInternalHomWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( a_1 ) * Dimension( b_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismToBidual( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismToBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, r_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismToCoBidual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, RightDivide( deduped_1_1, deduped_1_1 ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismToCoBidualWithGivenCoBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, r_1, UnderlyingMatrix, RightDivide( deduped_1_1, deduped_1_1 ) );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, r_1 * UnderlyingMatrix( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, arg2_1 );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddPostComposeList( cat,
        
########
function ( cat_1, list_of_morphisms_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := Iterated( List( list_of_morphisms_1, UnderlyingMatrix ), function ( beta_2, alpha_2 )
            return alpha_2 * beta_2;
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    , 100 );
    
    ##
    AddPreComposeList( cat,
        
########
function ( cat_1, list_of_morphisms_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := Iterated( List( list_of_morphisms_1, UnderlyingMatrix ), function ( alpha_2, beta_2 )
            return alpha_2 * beta_2;
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := List( objects_1, Dimension );
    deduped_2_1 := deduped_3_1[k_1];
    morphism_attr_1_1 := UnionOfRows( HomalgZeroMatrix( Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1, deduped_4_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), HomalgZeroMatrix( Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1, deduped_4_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), objects_1[k_1], UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := List( objects_1, Dimension );
    deduped_2_1 := deduped_3_1[k_1];
    morphism_attr_1_1 := UnionOfRows( HomalgZeroMatrix( Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1, deduped_4_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), HomalgZeroMatrix( Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1, deduped_4_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), objects_1[k_1], UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := List( objects_1, Dimension );
    deduped_2_1 := deduped_3_1[k_1];
    morphism_attr_1_1 := UnionOfRows( HomalgZeroMatrix( Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1, deduped_4_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), HomalgZeroMatrix( Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1, deduped_4_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), objects_1[k_1], UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( objects_1, Dimension );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, objects_1[k_1], UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} ) + 1;
    hoisted_4_1 := List( morphisms_1, UnderlyingMatrix );
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_10_1;
    hoisted_1_1 := deduped_9_1;
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_1_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( hoisted_1_1{[ (logic_new_func_x_2 + 1) .. hoisted_3_1 ]} ), deduped_1_2, hoisted_2_1 ) ) * hoisted_4_1[logic_new_func_x_2];
        end );
    deduped_5_1 := CertainColumns( SyzygiesOfRows( UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} ) ), [ deduped_7_1 .. deduped_7_1 - 1 + deduped_9_1[k_1] ] );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( deduped_5_1 ) ), Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[k_1] ) ), UnderlyingMatrix, deduped_5_1 );
end
########
        
    , 2711 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfFiberProductWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} ) + 1;
    hoisted_4_1 := List( morphisms_1, UnderlyingMatrix );
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_10_1;
    hoisted_1_1 := deduped_9_1;
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_1_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_1_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_2_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_2_1 ), HomalgZeroMatrix( Sum( hoisted_1_1{[ (logic_new_func_x_2 + 1) .. hoisted_3_1 ]} ), deduped_1_2, hoisted_2_1 ) ) * hoisted_4_1[logic_new_func_x_2];
        end );
    deduped_5_1 := CertainColumns( SyzygiesOfRows( UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} ) ), [ deduped_7_1 .. deduped_7_1 - 1 + deduped_9_1[k_1] ] );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( deduped_5_1 ) ), Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[k_1] ) ), UnderlyingMatrix, deduped_5_1 );
end
########
        
    , 2712 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectiveLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
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
    hoisted_2_1 := deduped_7_1;
    hoisted_1_1 := List( arg2_1, UnderlyingMatrix );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return hoisted_1_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), hoisted_3_1 ) );
        end );
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, deduped_6_1 - RowRankOfMatrix( (UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} )) ) );
end
########
        
    , 2611 : IsPrecompiledDerivation := true );
    
    ##
    AddPushoutFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1;
    deduped_20_1 := Length( morphisms_1 );
    deduped_19_1 := Length( morphismsp_1 );
    deduped_18_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_16_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_15_1 := Sum( deduped_17_1 );
    deduped_14_1 := Sum( deduped_16_1 );
    hoisted_5_1 := deduped_20_1;
    hoisted_4_1 := deduped_18_1;
    hoisted_3_1 := deduped_17_1;
    hoisted_2_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_13_1 := List( [ 1 .. deduped_20_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
        end );
    hoisted_8_1 := deduped_19_1;
    hoisted_7_1 := deduped_16_1;
    hoisted_6_1 := List( morphismsp_1, UnderlyingMatrix );
    deduped_12_1 := List( [ 1 .. deduped_19_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_7_1[logic_new_func_x_2];
            return hoisted_6_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_7_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_7_1{[ (logic_new_func_x_2 + 1) .. hoisted_8_1 ]} ), hoisted_4_1 ) );
        end );
    deduped_11_1 := UnionOfRows( deduped_18_1, deduped_14_1, deduped_12_1{[ 1 .. deduped_19_1 - 1 ]} ) - UnionOfRows( deduped_18_1, deduped_14_1, deduped_12_1{[ 2 .. deduped_19_1 ]} );
    hoisted_10_1 := SyzygiesOfColumns( deduped_11_1 );
    hoisted_9_1 := List( L_1, UnderlyingMatrix );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_18_1, deduped_15_1, deduped_13_1{[ 1 .. deduped_20_1 - 1 ]} ) - UnionOfRows( deduped_18_1, deduped_15_1, deduped_13_1{[ 2 .. deduped_20_1 ]} ) ), UnionOfRows( deduped_18_1, deduped_14_1 - RowRankOfMatrix( deduped_11_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( hoisted_7_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return hoisted_9_1[logic_new_func_x_2] * CertainRows( hoisted_10_1, [ deduped_1_2 .. (deduped_1_2 - 1 + hoisted_7_1[logic_new_func_x_2]) ] );
            end ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 13762 : IsPrecompiledDerivation := true );
    
    ##
    AddPushoutFunctorialWithGivenPushouts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
    deduped_19_1 := Length( morphisms_1 );
    deduped_18_1 := Length( morphismsp_1 );
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_15_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return Dimension( Range( logic_new_func_x_2 ) );
        end );
    deduped_14_1 := Sum( deduped_16_1 );
    deduped_13_1 := Sum( deduped_15_1 );
    hoisted_5_1 := deduped_19_1;
    hoisted_4_1 := deduped_17_1;
    hoisted_3_1 := deduped_16_1;
    hoisted_2_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_12_1 := List( [ 1 .. deduped_19_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
        end );
    hoisted_9_1 := deduped_18_1;
    hoisted_8_1 := deduped_15_1;
    hoisted_7_1 := List( morphismsp_1, UnderlyingMatrix );
    deduped_11_1 := List( [ 1 .. deduped_18_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_8_1[logic_new_func_x_2];
            return hoisted_7_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_8_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_8_1{[ (logic_new_func_x_2 + 1) .. hoisted_9_1 ]} ), hoisted_4_1 ) );
        end );
    hoisted_10_1 := SyzygiesOfColumns( UnionOfRows( deduped_17_1, deduped_13_1, deduped_11_1{[ 1 .. deduped_18_1 - 1 ]} ) - UnionOfRows( deduped_17_1, deduped_13_1, deduped_11_1{[ 2 .. deduped_18_1 ]} ) );
    hoisted_6_1 := List( L_1, UnderlyingMatrix );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_17_1, deduped_14_1, deduped_12_1{[ 1 .. deduped_19_1 - 1 ]} ) - UnionOfRows( deduped_17_1, deduped_14_1, deduped_12_1{[ 2 .. deduped_19_1 ]} ) ), UnionOfRows( deduped_17_1, Dimension( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( hoisted_8_1{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
                return hoisted_6_1[logic_new_func_x_2] * CertainRows( hoisted_10_1, [ deduped_1_2 .. (deduped_1_2 - 1 + hoisted_8_1[logic_new_func_x_2]) ] );
            end ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Pp_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 8539 : IsPrecompiledDerivation := true );
    
    ##
    AddRandomMorphismByInteger( cat,
        
########
function ( cat_1, n_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := Random( [ 0 .. n_1 ] );
    hoisted_2_1 := RandomMatrix( deduped_3_1, deduped_3_1, UnderlyingRing( cat_1 ) );
    morphism_attr_1_1 := Sum( [ 1 ], function ( c_2 )
            return c_2 * hoisted_2_1;
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddRandomMorphismWithFixedRangeByInteger( cat,
        
########
function ( cat_1, B_1, n_1 )
    local morphism_attr_1_1, hoisted_2_1;
    hoisted_2_1 := RandomMatrix( Random( [ 0 .. n_1 ] ), Dimension( B_1 ), UnderlyingRing( cat_1 ) );
    morphism_attr_1_1 := Sum( [ 1 ], function ( c_2 )
            return c_2 * hoisted_2_1;
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), B_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddRandomMorphismWithFixedSourceAndRangeByInteger( cat,
        
########
function ( cat_1, A_1, B_1, n_1 )
    local hoisted_1_1;
    hoisted_1_1 := RandomMatrix( Dimension( A_1 ), Dimension( B_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, B_1, UnderlyingMatrix, Sum( [ 1 ], function ( c_2 )
              return c_2 * hoisted_1_1;
          end ) );
end
########
        
    , 100 );
    
    ##
    AddRandomMorphismWithFixedSourceByInteger( cat,
        
########
function ( cat_1, A_1, n_1 )
    local morphism_attr_1_1, hoisted_2_1;
    hoisted_2_1 := RandomMatrix( Dimension( A_1 ), Random( [ 0 .. n_1 ] ), UnderlyingRing( cat_1 ) );
    morphism_attr_1_1 := Sum( [ 1 ], function ( c_2 )
            return c_2 * hoisted_2_1;
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddRandomObjectByInteger( cat,
        
########
function ( cat_1, n_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Random( [ 0 .. n_1 ] ) );
end
########
        
    , 100 );
    
    ##
    AddRankMorphism( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := deduped_7_1 * 1;
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := HomalgIdentityMatrix( 1, deduped_8_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    hoisted_2_1 := deduped_7_1;
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ), deduped_4_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_8_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), deduped_3_1 ) * ConvertMatrixToColumn( deduped_3_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 6232 : IsPrecompiledDerivation := true );
    
    ##
    AddRightDistributivityExpanding( cat,
        
########
function ( cat_1, L_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := Length( L_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := List( L_1, Dimension );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_7_1 );
    hoisted_4_1 := deduped_8_1;
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := UnionOfColumns( deduped_7_1, Sum( deduped_6_1 ) * deduped_9_1, List( [ 1 .. deduped_8_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return KroneckerMat( UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ logic_new_func_x_2 + 1 .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ), hoisted_5_1 );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    AddRightDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_6_1 );
    hoisted_4_1 := deduped_7_1;
    hoisted_3_1 := deduped_6_1;
    hoisted_2_1 := List( L_1, Dimension );
    morphism_attr_1_1 := UnionOfColumns( deduped_6_1, Dimension( s_1 ), List( [ 1 .. deduped_7_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return KroneckerMat( UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ logic_new_func_x_2 + 1 .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ), hoisted_5_1 );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    AddRightDistributivityFactoring( cat,
        
########
function ( cat_1, L_1, a_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := Length( L_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := List( L_1, Dimension );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_7_1 );
    hoisted_4_1 := deduped_8_1;
    hoisted_3_1 := deduped_7_1;
    hoisted_2_1 := deduped_6_1;
    morphism_attr_1_1 := UnionOfRows( deduped_7_1, Sum( deduped_6_1 ) * deduped_9_1, List( [ 1 .. deduped_8_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return KroneckerMat( UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ logic_new_func_x_2 + 1 .. hoisted_4_1 ]} ), hoisted_3_1 ) ), hoisted_5_1 );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    AddRightDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_6_1 );
    hoisted_4_1 := deduped_7_1;
    hoisted_3_1 := deduped_6_1;
    hoisted_2_1 := List( L_1, Dimension );
    morphism_attr_1_1 := UnionOfRows( deduped_6_1, Dimension( r_1 ), List( [ 1 .. deduped_7_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2;
              deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
              return KroneckerMat( UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ 1 .. logic_new_func_x_2 - 1 ]} ), hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_2_1{[ logic_new_func_x_2 + 1 .. hoisted_4_1 ]} ), hoisted_3_1 ) ), hoisted_5_1 );
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), r_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitor( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddSimplifyRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[3];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[4];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[5];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[2];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Source( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Source( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSolveLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := arg2_1[1];
    deduped_8_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_7_1 := [ 1 .. Length( deduped_9_1 ) ];
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := arg3_1[1];
    hoisted_1_1 := deduped_9_1;
    hoisted_6_1 := RightDivide( UnionOfColumns( deduped_10_1, 1, List( deduped_8_1, function ( logic_new_func_x_2 )
                return ConvertMatrixToRow( UnderlyingMatrix( arg4_1[logic_new_func_x_2] ) );
            end ) ), UnionOfRows( deduped_10_1, Sum( List( deduped_8_1, function ( logic_new_func_x_2 )
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
            return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_2, deduped_3_2, UnderlyingMatrix, ConvertRowToMatrix( CertainColumns( hoisted_6_1, [ deduped_1_2 .. deduped_1_2 - 1 + hoisted_5_1[j_2] ] ), Dimension( deduped_2_2 ), Dimension( deduped_3_2 ) ) );
        end );
end
########
        
    , 2806 : IsPrecompiledDerivation := true );
    
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
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( 0, Dimension( Range( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSubtractionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) - UnderlyingMatrix( b_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductDualityCompatibilityMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1;
    deduped_23_1 := UnderlyingRing( cat_1 );
    deduped_22_1 := Dimension( b_1 );
    deduped_21_1 := Dimension( a_1 );
    deduped_20_1 := HomalgIdentityMatrix( 1, deduped_23_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_22_1, deduped_23_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_21_1, deduped_23_1 );
    deduped_17_1 := deduped_22_1 * 1;
    deduped_16_1 := deduped_21_1 * 1;
    deduped_15_1 := deduped_21_1 * deduped_22_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_17_1, deduped_23_1 );
    deduped_13_1 := deduped_17_1 * deduped_21_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_16_1, deduped_23_1 );
    deduped_11_1 := deduped_15_1 * deduped_15_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_15_1, deduped_23_1 );
    deduped_9_1 := deduped_16_1 * deduped_17_1;
    deduped_8_1 := deduped_15_1 * deduped_9_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_23_1 );
    hoisted_6_1 := deduped_22_1;
    hoisted_5_1 := deduped_17_1;
    hoisted_4_1 := deduped_21_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_15_1;
    morphism_attr_1_1 := KroneckerMat( deduped_18_1, deduped_19_1 ) * (KroneckerMat( ConvertMatrixToRow( deduped_10_1 ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_23_1 ), deduped_7_1 ) * KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_23_1 ) ) * KroneckerMat( TransposedMatrix( deduped_10_1 ), (KroneckerMat( KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                            end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_23_1 ) ), deduped_19_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_12_1, deduped_18_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                                      local deduped_1_2;
                                      deduped_1_2 := (i_2 - 1);
                                      return (REM_INT( deduped_1_2, 1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                                  end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_23_1 ), deduped_18_1 ) * KroneckerMat( deduped_20_1, ConvertMatrixToColumn( deduped_18_1 ) )), deduped_14_1 ), deduped_19_1 ) * KroneckerMat( deduped_20_1, (KroneckerMat( deduped_14_1, deduped_19_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, 1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                              end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_23_1 ), deduped_19_1 ) * KroneckerMat( deduped_20_1, ConvertMatrixToColumn( deduped_19_1 ) )) )) ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 16378 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductDualityCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1;
    deduped_23_1 := UnderlyingRing( cat_1 );
    deduped_22_1 := Dimension( b_1 );
    deduped_21_1 := Dimension( a_1 );
    deduped_20_1 := HomalgIdentityMatrix( 1, deduped_23_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_22_1, deduped_23_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_21_1, deduped_23_1 );
    deduped_17_1 := deduped_22_1 * 1;
    deduped_16_1 := deduped_21_1 * 1;
    deduped_15_1 := deduped_21_1 * deduped_22_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_17_1, deduped_23_1 );
    deduped_13_1 := deduped_17_1 * deduped_21_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_16_1, deduped_23_1 );
    deduped_11_1 := deduped_15_1 * deduped_15_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_15_1, deduped_23_1 );
    deduped_9_1 := deduped_16_1 * deduped_17_1;
    deduped_8_1 := deduped_15_1 * deduped_9_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_23_1 );
    hoisted_6_1 := deduped_22_1;
    hoisted_5_1 := deduped_17_1;
    hoisted_4_1 := deduped_21_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_15_1;
    morphism_attr_1_1 := KroneckerMat( deduped_18_1, deduped_19_1 ) * (KroneckerMat( ConvertMatrixToRow( deduped_10_1 ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_23_1 ), deduped_7_1 ) * KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                      end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_23_1 ) ) * KroneckerMat( TransposedMatrix( deduped_10_1 ), (KroneckerMat( KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                            end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_23_1 ) ), deduped_19_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_12_1, deduped_18_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                                      local deduped_1_2;
                                      deduped_1_2 := (i_2 - 1);
                                      return (REM_INT( deduped_1_2, 1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                                  end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_23_1 ), deduped_18_1 ) * KroneckerMat( deduped_20_1, ConvertMatrixToColumn( deduped_18_1 ) )), deduped_14_1 ), deduped_19_1 ) * KroneckerMat( deduped_20_1, (KroneckerMat( deduped_14_1, deduped_19_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, 1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                              end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_23_1 ), deduped_19_1 ) * KroneckerMat( deduped_20_1, ConvertMatrixToColumn( deduped_19_1 ) )) )) ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 15877 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphism( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := List( list_1, Dimension );
    deduped_26_1 := deduped_27_1[4];
    deduped_25_1 := deduped_27_1[2];
    deduped_24_1 := deduped_27_1[3];
    deduped_23_1 := deduped_27_1[1];
    deduped_22_1 := HomalgIdentityMatrix( deduped_25_1, deduped_28_1 );
    deduped_21_1 := HomalgIdentityMatrix( deduped_23_1, deduped_28_1 );
    deduped_20_1 := HomalgIdentityMatrix( deduped_24_1, deduped_28_1 );
    deduped_19_1 := deduped_24_1 * deduped_26_1;
    deduped_18_1 := deduped_23_1 * deduped_25_1;
    deduped_17_1 := deduped_23_1 * deduped_24_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_19_1, deduped_28_1 );
    deduped_15_1 := deduped_19_1 * deduped_23_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_18_1, deduped_28_1 );
    deduped_13_1 := deduped_17_1 * deduped_17_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_17_1, deduped_28_1 );
    deduped_11_1 := deduped_18_1 * deduped_19_1;
    deduped_10_1 := deduped_17_1 * deduped_11_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_11_1, deduped_28_1 );
    hoisted_8_1 := deduped_24_1;
    hoisted_7_1 := deduped_26_1;
    hoisted_6_1 := deduped_25_1;
    hoisted_5_1 := deduped_19_1;
    hoisted_4_1 := deduped_23_1;
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_17_1;
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_12_1 ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_28_1 ), deduped_9_1 ) * KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_28_1 ) ) * KroneckerMat( TransposedMatrix( deduped_12_1 ), (KroneckerMat( KroneckerMat( deduped_14_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                          end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_28_1 ) ), deduped_20_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_14_1, deduped_21_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                                end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_28_1 ), deduped_21_1 ) * KroneckerMat( deduped_22_1, ConvertMatrixToColumn( deduped_21_1 ) )), deduped_16_1 ), deduped_20_1 ) * KroneckerMat( deduped_22_1, (KroneckerMat( deduped_16_1, deduped_20_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_8_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                            end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_28_1 ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_28_1 ), ConvertMatrixToColumn( deduped_20_1 ) )) )) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 14665 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverse( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1;
    deduped_29_1 := UnderlyingRing( cat_1 );
    deduped_28_1 := List( list_1, Dimension );
    deduped_27_1 := deduped_28_1[2];
    deduped_26_1 := deduped_28_1[4];
    deduped_25_1 := deduped_28_1[3];
    deduped_24_1 := deduped_28_1[1];
    deduped_23_1 := HomalgIdentityMatrix( deduped_27_1, deduped_29_1 );
    deduped_22_1 := HomalgIdentityMatrix( deduped_24_1, deduped_29_1 );
    deduped_21_1 := HomalgIdentityMatrix( deduped_25_1, deduped_29_1 );
    deduped_20_1 := deduped_24_1 * deduped_27_1;
    deduped_19_1 := deduped_24_1 * deduped_25_1;
    deduped_18_1 := deduped_25_1 * deduped_26_1;
    deduped_17_1 := deduped_19_1 * deduped_19_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_18_1, deduped_29_1 );
    deduped_15_1 := deduped_18_1 * deduped_24_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_20_1, deduped_29_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_19_1, deduped_29_1 );
    deduped_12_1 := deduped_20_1 * deduped_18_1;
    deduped_11_1 := deduped_19_1 * deduped_12_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_12_1, deduped_29_1 );
    hoisted_6_1 := deduped_25_1;
    hoisted_5_1 := deduped_26_1;
    hoisted_4_1 := deduped_27_1;
    hoisted_3_1 := deduped_18_1;
    hoisted_2_1 := deduped_24_1;
    deduped_9_1 := KroneckerMat( TransposedMatrix( deduped_13_1 ), KroneckerMat( KroneckerMat( deduped_14_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_29_1 ) ), deduped_21_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_14_1, deduped_22_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_20_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                              end ) ), deduped_20_1 ), deduped_20_1, deduped_20_1, deduped_29_1 ), deduped_22_1 ) * KroneckerMat( deduped_23_1, ConvertMatrixToColumn( deduped_22_1 ) )), deduped_16_1 ), deduped_21_1 ) * KroneckerMat( deduped_23_1, (KroneckerMat( deduped_16_1, deduped_21_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                          end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_29_1 ), deduped_21_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_29_1 ), ConvertMatrixToColumn( deduped_21_1 ) )) ) );
    hoisted_8_1 := deduped_12_1;
    hoisted_7_1 := deduped_19_1;
    morphism_attr_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( deduped_9_1 ), deduped_29_1 ), KroneckerMat( ConvertMatrixToRow( deduped_13_1 ), deduped_10_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_7_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                        end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_29_1 ), deduped_10_1 ) * KroneckerMat( deduped_13_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_8_1 ) * hoisted_7_1 + QUO_INT( deduped_1_2, hoisted_8_1 ) + 1);
                      end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_29_1 ) ) * deduped_9_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 14868 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1;
    deduped_29_1 := UnderlyingRing( cat_1 );
    deduped_28_1 := List( list_1, Dimension );
    deduped_27_1 := deduped_28_1[2];
    deduped_26_1 := deduped_28_1[4];
    deduped_25_1 := deduped_28_1[3];
    deduped_24_1 := deduped_28_1[1];
    deduped_23_1 := HomalgIdentityMatrix( deduped_27_1, deduped_29_1 );
    deduped_22_1 := HomalgIdentityMatrix( deduped_24_1, deduped_29_1 );
    deduped_21_1 := HomalgIdentityMatrix( deduped_25_1, deduped_29_1 );
    deduped_20_1 := deduped_24_1 * deduped_27_1;
    deduped_19_1 := deduped_24_1 * deduped_25_1;
    deduped_18_1 := deduped_25_1 * deduped_26_1;
    deduped_17_1 := deduped_19_1 * deduped_19_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_18_1, deduped_29_1 );
    deduped_15_1 := deduped_18_1 * deduped_24_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_20_1, deduped_29_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_19_1, deduped_29_1 );
    deduped_12_1 := deduped_20_1 * deduped_18_1;
    deduped_11_1 := deduped_19_1 * deduped_12_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_12_1, deduped_29_1 );
    hoisted_6_1 := deduped_25_1;
    hoisted_5_1 := deduped_26_1;
    hoisted_4_1 := deduped_27_1;
    hoisted_3_1 := deduped_18_1;
    hoisted_2_1 := deduped_24_1;
    deduped_9_1 := KroneckerMat( TransposedMatrix( deduped_13_1 ), KroneckerMat( KroneckerMat( deduped_14_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_29_1 ) ), deduped_21_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_14_1, deduped_22_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_20_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                              end ) ), deduped_20_1 ), deduped_20_1, deduped_20_1, deduped_29_1 ), deduped_22_1 ) * KroneckerMat( deduped_23_1, ConvertMatrixToColumn( deduped_22_1 ) )), deduped_16_1 ), deduped_21_1 ) * KroneckerMat( deduped_23_1, (KroneckerMat( deduped_16_1, deduped_21_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_5_1 ) * hoisted_6_1 + QUO_INT( deduped_1_2, hoisted_5_1 ) + 1);
                          end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_29_1 ), deduped_21_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_29_1 ), ConvertMatrixToColumn( deduped_21_1 ) )) ) );
    hoisted_8_1 := deduped_12_1;
    hoisted_7_1 := deduped_19_1;
    morphism_attr_1_1 := RightDivide( HomalgIdentityMatrix( NumberColumns( deduped_9_1 ), deduped_29_1 ), KroneckerMat( ConvertMatrixToRow( deduped_13_1 ), deduped_10_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_7_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                        end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_29_1 ), deduped_10_1 ) * KroneckerMat( deduped_13_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_8_1 ) * hoisted_7_1 + QUO_INT( deduped_1_2, hoisted_8_1 ) + 1);
                      end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_29_1 ) ) * deduped_9_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 13661 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := List( list_1, Dimension );
    deduped_26_1 := deduped_27_1[4];
    deduped_25_1 := deduped_27_1[2];
    deduped_24_1 := deduped_27_1[3];
    deduped_23_1 := deduped_27_1[1];
    deduped_22_1 := HomalgIdentityMatrix( deduped_25_1, deduped_28_1 );
    deduped_21_1 := HomalgIdentityMatrix( deduped_23_1, deduped_28_1 );
    deduped_20_1 := HomalgIdentityMatrix( deduped_24_1, deduped_28_1 );
    deduped_19_1 := deduped_24_1 * deduped_26_1;
    deduped_18_1 := deduped_23_1 * deduped_25_1;
    deduped_17_1 := deduped_23_1 * deduped_24_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_19_1, deduped_28_1 );
    deduped_15_1 := deduped_19_1 * deduped_23_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_18_1, deduped_28_1 );
    deduped_13_1 := deduped_17_1 * deduped_17_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_17_1, deduped_28_1 );
    deduped_11_1 := deduped_18_1 * deduped_19_1;
    deduped_10_1 := deduped_17_1 * deduped_11_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_11_1, deduped_28_1 );
    hoisted_8_1 := deduped_24_1;
    hoisted_7_1 := deduped_26_1;
    hoisted_6_1 := deduped_25_1;
    hoisted_5_1 := deduped_19_1;
    hoisted_4_1 := deduped_23_1;
    hoisted_3_1 := deduped_11_1;
    hoisted_2_1 := deduped_17_1;
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_12_1 ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_28_1 ), deduped_9_1 ) * KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_28_1 ) ) * KroneckerMat( TransposedMatrix( deduped_12_1 ), (KroneckerMat( KroneckerMat( deduped_14_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, hoisted_4_1 ) * hoisted_5_1 + QUO_INT( deduped_1_2, hoisted_4_1 ) + 1);
                          end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_28_1 ) ), deduped_20_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_14_1, deduped_21_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                                    local deduped_1_2;
                                    deduped_1_2 := (i_2 - 1);
                                    return (REM_INT( deduped_1_2, hoisted_6_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, hoisted_6_1 ) + 1);
                                end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_28_1 ), deduped_21_1 ) * KroneckerMat( deduped_22_1, ConvertMatrixToColumn( deduped_21_1 ) )), deduped_16_1 ), deduped_20_1 ) * KroneckerMat( deduped_22_1, (KroneckerMat( deduped_16_1, deduped_20_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_7_1 ) * hoisted_8_1 + QUO_INT( deduped_1_2, hoisted_7_1 ) + 1);
                            end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_28_1 ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_28_1 ), ConvertMatrixToColumn( deduped_20_1 ) )) )) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 13458 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, KroneckerMat( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, Dimension( arg2_1 ) * Dimension( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductToInternalCoHomAdjunctionMap( cat,
        
########
function ( cat_1, c_1, b_1, g_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( c_1 );
    deduped_8_1 := Dimension( b_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_9_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_10_1 );
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_4_1 ), UnderlyingMatrix( g_1 ) ) * (KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_10_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_10_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_7_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5024 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductToInternalHomAdjunctionMap( cat,
        
########
function ( cat_1, a_1, b_1, f_1 )
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
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_10_1 ), deduped_5_1 ) * KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_10_1 ) ) * KroneckerMat( TransposedMatrix( deduped_4_1 ), UnderlyingMatrix( f_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5024 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 1 );
end
########
        
    , 100 );
    
    ##
    AddTerminalObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddTerminalObjectFunctorial( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddTerminalObjectFunctorialWithGivenTerminalObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( Pp_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddTraceMap( cat,
        
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
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                        end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_8_1 ), deduped_7_1 ) * KroneckerMat( deduped_3_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, 1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_8_1 ) ) * KroneckerMat( TransposedMatrix( deduped_3_1 ), UnderlyingMatrix( alpha_1 ) ) * ConvertMatrixToColumn( deduped_3_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 6131 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromImage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := CAP_JIT_INCOMPLETE_LOGIC( tau_1[2] );
    deduped_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingMatrix( deduped_2_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( deduped_1_1 ) ), Source( deduped_2_1 ), UnderlyingMatrix, deduped_1_1 );
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, tau_1, I_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := CAP_JIT_INCOMPLETE_LOGIC( tau_1[2] );
    deduped_1_1 := RightDivide( SyzygiesOfRows( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ) ), UnderlyingMatrix( deduped_2_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( deduped_1_1 ) ), Source( deduped_2_1 ), UnderlyingMatrix, deduped_1_1 );
end
########
        
    , 705 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromInitialObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
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
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) ), UnionOfRows( deduped_9_1, Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2913 : IsPrecompiledDerivation := true );
    
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
    hoisted_3_1 := deduped_8_1;
    hoisted_2_1 := List( morphisms_1, UnderlyingMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_3_1[logic_new_func_x_2];
            return hoisted_2_1[logic_new_func_x_2] * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), hoisted_4_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_4_1 ), HomalgZeroMatrix( deduped_1_2, Sum( hoisted_3_1{[ (logic_new_func_x_2 + 1) .. hoisted_5_1 ]} ), hoisted_4_1 ) );
        end );
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) ), UnionOfRows( deduped_9_1, Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2914 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoCoimage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := CAP_JIT_INCOMPLETE_LOGIC( tau_1[1] );
    deduped_1_1 := LeftDivide( UnderlyingMatrix( deduped_2_1 ), SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( deduped_2_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( deduped_1_1 ) ), UnderlyingMatrix, deduped_1_1 );
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoCoimageWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, tau_1, C_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := CAP_JIT_INCOMPLETE_LOGIC( tau_1[1] );
    deduped_1_1 := LeftDivide( UnderlyingMatrix( deduped_2_1 ), SyzygiesOfColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( deduped_2_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( deduped_1_1 ) ), UnderlyingMatrix, deduped_1_1 );
end
########
        
    , 705 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) ) );
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
    hoisted_5_1 := List( morphisms_1, UnderlyingMatrix );
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
        end );
    morphism_attr_1_1 := RightDivide( UnionOfColumns( deduped_9_1, Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) ), SyzygiesOfRows( UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2913 : IsPrecompiledDerivation := true );
    
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
    hoisted_5_1 := List( morphisms_1, UnderlyingMatrix );
    hoisted_4_1 := deduped_10_1;
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := hoisted_2_1[logic_new_func_x_2];
            return UnionOfRows( HomalgZeroMatrix( Sum( hoisted_2_1{[ 1 .. (logic_new_func_x_2 - 1) ]} ), deduped_1_2, hoisted_3_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_3_1 ), HomalgZeroMatrix( Sum( hoisted_2_1{[ (logic_new_func_x_2 + 1) .. hoisted_4_1 ]} ), deduped_1_2, hoisted_3_1 ) ) * hoisted_5_1[logic_new_func_x_2];
        end );
    morphism_attr_1_1 := RightDivide( UnionOfColumns( deduped_9_1, Dimension( T_1 ), List( tau_1, UnderlyingMatrix ) ), SyzygiesOfRows( UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 2914 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoTerminalObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), Dimension( P_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalPropertyOfCoDual( cat,
        
########
function ( cat_1, t_1, a_1, alpha_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( t_1 );
    deduped_8_1 := Dimension( a_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_9_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_10_1 );
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( deduped_4_1 ), UnderlyingMatrix( alpha_1 ) ) * (KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_3_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_10_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_10_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_7_1 ));
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5328 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalPropertyOfDual( cat,
        
########
function ( cat_1, t_1, a_1, alpha_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( t_1 );
    deduped_8_1 := Dimension( a_1 );
    deduped_7_1 := deduped_8_1 * deduped_9_1;
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_10_1 );
    hoisted_3_1 := deduped_9_1;
    hoisted_2_1 := deduped_8_1;
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_10_1 ), deduped_5_1 ) * KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, hoisted_3_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_3_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_10_1 ) ) * KroneckerMat( TransposedMatrix( deduped_4_1 ), UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), a_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 5328 : IsPrecompiledDerivation := true );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( a_1 ), Dimension( b_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
end
########
        
    , 100 );
    
    ##
    AddZeroObjectFunctorial( cat,
        
########
function ( cat_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 0 );
    morphism_attr_1_1 := HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddZeroObjectFunctorialWithGivenZeroObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
end );

BindGlobal( "MatrixCategoryPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( field )
    return MatrixCategoryAsCategoryOfRows( field );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_MatrixCategoryPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
