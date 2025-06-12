# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_MatrixCategory_precompiled", function ( cat )
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), AsHomalgMatrix( alpha_1 ) + AsHomalgMatrix( beta_1 ), Range( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAdditiveGenerators( cat,
        
########
function ( cat_1 )
    return [ AsCapCategoryObject( cat_1, 1 ) ];
end
########
        
    , 100 );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), - AsHomalgMatrix( alpha_1 ), Range( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAssociatorLeftToRight( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_4_1;
    morphism_attr_4_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * (AsInteger( b_1 ) * AsInteger( c_1 )), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_4_1 ) ), morphism_attr_4_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_4_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.AssociatorLeftToRight :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_4_1, deduped_5_1;
    deduped_5_1 := AsInteger( a_1 ) * (AsInteger( b_1 ) * AsInteger( c_1 ));
    deduped_4_1 := AsCapCategoryObject( cat_1, deduped_5_1 );
    return AsCapCategoryMorphism( cat_1, deduped_4_1, HomalgIdentityMatrix( deduped_5_1, UnderlyingRing( cat_1 ) ), deduped_4_1 );
end
########
        
    ;
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, HomalgIdentityMatrix( AsInteger( s_1 ), UnderlyingRing( cat_1 ) ), s_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddAssociatorRightToLeft( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_4_1;
    morphism_attr_4_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * (AsInteger( b_1 ) * AsInteger( c_1 )), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_4_1 ) ), morphism_attr_4_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_4_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.AssociatorRightToLeft :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_4_1, deduped_5_1;
    deduped_5_1 := AsInteger( a_1 ) * (AsInteger( b_1 ) * AsInteger( c_1 ));
    deduped_4_1 := AsCapCategoryObject( cat_1, deduped_5_1 );
    return AsCapCategoryMorphism( cat_1, deduped_4_1, HomalgIdentityMatrix( deduped_5_1, UnderlyingRing( cat_1 ) ), deduped_4_1 );
end
########
        
    ;
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, HomalgIdentityMatrix( AsInteger( s_1 ), UnderlyingRing( cat_1 ) ), s_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddAstrictionToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    morphism_attr_1_1 := UniqueLeftDivide( BasisOfColumns( deduped_2_1 ), deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Range( alpha_1 ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.AstrictionToCoimage :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, ColumnRankOfMatrix( deduped_1_1 ) ), UniqueLeftDivide( BasisOfColumns( deduped_1_1 ), deduped_1_1 ), Range( alpha_1 ) );
end
########
        
    ;
    
    ##
    AddAstrictionToCoimageWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local deduped_1_1;
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    return AsCapCategoryMorphism( cat_1, C_1, UniqueLeftDivide( BasisOfColumns( deduped_1_1 ), deduped_1_1 ), Range( alpha_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := AsInteger( arg3_1 );
    deduped_5_1 := AsInteger( arg2_1 );
    deduped_4_1 := deduped_5_1 * deduped_6_1;
    hoisted_1_1 := HomalgIdentityMatrix( deduped_4_1, UnderlyingRing( cat_1 ) );
    return List( [ 1 .. deduped_4_1 ], function ( i_2 )
            return AsCapCategoryMorphism( cat_1, arg2_1, ConvertRowToMatrix( CertainRows( hoisted_1_1, [ i_2 ] ), deduped_5_1, deduped_6_1 ), arg3_1 );
        end );
end
########
        
    , 100 );
    
    ##
    AddBasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1, arg5_1 )
    local hoisted_1_1, deduped_2_1, deduped_3_1, hoisted_4_1, hoisted_5_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, hoisted_11_1, deduped_14_1, hoisted_16_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1;
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_25_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_24_1 := CAP_JIT_INCOMPLETE_LOGIC( arg3_1[1] );
    deduped_23_1 := CAP_JIT_INCOMPLETE_LOGIC( arg2_1[1] );
    deduped_22_1 := CAP_JIT_INCOMPLETE_LOGIC( Length( deduped_23_1 ) );
    deduped_21_1 := [ 1 .. deduped_22_1 ];
    hoisted_1_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Target( logic_new_func_x_3 ) );
                end );
        end );
    deduped_20_1 := Sum( List( deduped_25_1, function ( i_2 )
              return CAP_JIT_INCOMPLETE_LOGIC( AsInteger( Source( CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( arg2_1[i_2] )[1] ) ) ) ) * hoisted_1_1[i_2][1];
          end ) );
    hoisted_9_1 := List( arg5_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_8_1 := List( arg4_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_5_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_4_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    deduped_3_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_24_1, function ( logic_new_func_x_2 )
              return AsInteger( Source( logic_new_func_x_2 ) );
          end ) );
    deduped_2_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_23_1, function ( logic_new_func_x_2 )
              return AsInteger( Target( logic_new_func_x_2 ) );
          end ) );
    deduped_19_1 := SyzygiesOfRows( UnionOfRows( deduped_26_1, deduped_20_1, List( deduped_21_1, function ( j_2 )
                  return UnionOfColumns( deduped_26_1, deduped_2_1[j_2] * deduped_3_1[j_2], List( deduped_25_1, function ( i_3 )
                            return KroneckerMat( hoisted_4_1[i_3][j_2], hoisted_5_1[i_3][j_2] );
                        end ) );
              end ) ) - UnionOfRows( deduped_26_1, deduped_20_1, List( deduped_21_1, function ( j_2 )
                  return UnionOfColumns( deduped_26_1, deduped_2_1[j_2] * deduped_3_1[j_2], List( deduped_25_1, function ( i_3 )
                            return KroneckerMat( hoisted_8_1[i_3][j_2], hoisted_9_1[i_3][j_2] );
                        end ) );
              end ) ) );
    deduped_18_1 := NumberRows( deduped_19_1 );
    hoisted_16_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_24_1, Source ) );
    deduped_14_1 := List( deduped_21_1, function ( j_2 )
            return deduped_2_1[j_2] * deduped_3_1[j_2];
        end );
    hoisted_11_1 := HomalgIdentityMatrix( deduped_18_1, deduped_26_1 );
    hoisted_10_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_23_1, Target ) );
    return List( [ 1 .. deduped_18_1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := ConvertRowToMatrix( CertainRows( hoisted_11_1, [ i_2 ] ), 1, deduped_18_1 ) * deduped_19_1;
            return List( deduped_21_1, function ( j_3 )
                    local deduped_1_3;
                    deduped_1_3 := deduped_14_1[j_3];
                    return AsCapCategoryMorphism( cat_1, hoisted_10_1[j_3], ConvertRowToMatrix( hoisted_1_2 * UnionOfRows( deduped_26_1, deduped_1_3, [ HomalgZeroMatrix( Sum( deduped_14_1{[ 1 .. (j_3 - 1) ]} ), deduped_1_3, deduped_26_1 ), HomalgIdentityMatrix( deduped_1_3, deduped_26_1 ), HomalgZeroMatrix( Sum( deduped_14_1{[ (j_3 + 1) .. deduped_22_1 ]} ), deduped_1_3, deduped_26_1 ) ] ), deduped_2_1[j_3], deduped_3_1[j_3] ), hoisted_16_1[j_3] );
                end );
        end );
end
########
        
    , 6118 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.BasisOfSolutionsOfHomogeneousDoubleLinearSystemInLinearCategory :=
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1, arg5_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, hoisted_5_1, hoisted_6_1, hoisted_9_1, hoisted_10_1, hoisted_11_1, hoisted_12_1, deduped_15_1, hoisted_17_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1;
    deduped_25_1 := UnderlyingRing( cat_1 );
    deduped_24_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_23_1 := List( arg2_1, Length )[1];
    deduped_22_1 := [ 1 .. deduped_23_1 ];
    hoisted_2_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Target( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_1_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Source( logic_new_func_x_3 ) );
                end );
        end );
    deduped_21_1 := Sum( List( deduped_24_1, function ( i_2 )
              return hoisted_1_1[i_2][1] * hoisted_2_1[i_2][1];
          end ) );
    hoisted_10_1 := List( arg5_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_9_1 := List( arg4_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_6_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_5_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    deduped_4_1 := List( arg3_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Source( logic_new_func_x_3 ) );
                  end );
          end )[1];
    deduped_3_1 := List( arg2_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Target( logic_new_func_x_3 ) );
                  end );
          end )[1];
    deduped_20_1 := SyzygiesOfRows( UnionOfRows( deduped_25_1, deduped_21_1, List( deduped_22_1, function ( j_2 )
                  return UnionOfColumns( deduped_25_1, deduped_3_1[j_2] * deduped_4_1[j_2], List( deduped_24_1, function ( i_3 )
                            return KroneckerMat( hoisted_5_1[i_3][j_2], hoisted_6_1[i_3][j_2] );
                        end ) );
              end ) ) - UnionOfRows( deduped_25_1, deduped_21_1, List( deduped_22_1, function ( j_2 )
                  return UnionOfColumns( deduped_25_1, deduped_3_1[j_2] * deduped_4_1[j_2], List( deduped_24_1, function ( i_3 )
                            return KroneckerMat( hoisted_9_1[i_3][j_2], hoisted_10_1[i_3][j_2] );
                        end ) );
              end ) ) );
    deduped_19_1 := NumberRows( deduped_20_1 );
    hoisted_17_1 := List( arg3_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, Source );
          end )[1];
    deduped_15_1 := List( deduped_22_1, function ( j_2 )
            return deduped_3_1[j_2] * deduped_4_1[j_2];
        end );
    hoisted_12_1 := HomalgIdentityMatrix( deduped_19_1, deduped_25_1 );
    hoisted_11_1 := List( arg2_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, Target );
          end )[1];
    return List( [ 1 .. deduped_19_1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := ConvertRowToMatrix( CertainRows( hoisted_12_1, [ i_2 ] ), 1, deduped_19_1 ) * deduped_20_1;
            return List( deduped_22_1, function ( j_3 )
                    local deduped_1_3;
                    deduped_1_3 := deduped_15_1[j_3];
                    return AsCapCategoryMorphism( cat_1, hoisted_11_1[j_3], ConvertRowToMatrix( hoisted_1_2 * UnionOfRows( deduped_25_1, deduped_1_3, [ HomalgZeroMatrix( Sum( deduped_15_1{[ 1 .. (j_3 - 1) ]} ), deduped_1_3, deduped_25_1 ), HomalgIdentityMatrix( deduped_1_3, deduped_25_1 ), HomalgZeroMatrix( Sum( deduped_15_1{[ (j_3 + 1) .. deduped_23_1 ]} ), deduped_1_3, deduped_25_1 ) ] ), deduped_3_1[j_3], deduped_4_1[j_3] ), hoisted_17_1[j_3] );
                end );
        end );
end
########
        
    ;
    
    ##
    AddBasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, deduped_2_1, deduped_3_1, hoisted_4_1, hoisted_5_1, hoisted_8_1, hoisted_9_1, deduped_12_1, hoisted_14_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1;
    deduped_23_1 := UnderlyingRing( cat_1 );
    deduped_22_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_21_1 := CAP_JIT_INCOMPLETE_LOGIC( arg3_1[1] );
    deduped_20_1 := CAP_JIT_INCOMPLETE_LOGIC( arg2_1[1] );
    deduped_19_1 := CAP_JIT_INCOMPLETE_LOGIC( Length( deduped_20_1 ) );
    deduped_18_1 := [ 1 .. deduped_19_1 ];
    hoisted_5_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_4_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    deduped_3_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_21_1, function ( logic_new_func_x_2 )
              return AsInteger( Source( logic_new_func_x_2 ) );
          end ) );
    deduped_2_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_20_1, function ( logic_new_func_x_2 )
              return AsInteger( Target( logic_new_func_x_2 ) );
          end ) );
    hoisted_1_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Target( logic_new_func_x_3 ) );
                end );
        end );
    deduped_17_1 := SyzygiesOfRows( UnionOfRows( deduped_23_1, Sum( List( deduped_22_1, function ( i_2 )
                  return CAP_JIT_INCOMPLETE_LOGIC( AsInteger( Source( CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( arg2_1[i_2] )[1] ) ) ) ) * hoisted_1_1[i_2][1];
              end ) ), List( deduped_18_1, function ( j_2 )
                return UnionOfColumns( deduped_23_1, deduped_2_1[j_2] * deduped_3_1[j_2], List( deduped_22_1, function ( i_3 )
                          return KroneckerMat( hoisted_4_1[i_3][j_2], hoisted_5_1[i_3][j_2] );
                      end ) );
            end ) ) );
    deduped_16_1 := NumberRows( deduped_17_1 );
    hoisted_14_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_21_1, Source ) );
    deduped_12_1 := List( deduped_18_1, function ( j_2 )
            return deduped_2_1[j_2] * deduped_3_1[j_2];
        end );
    hoisted_9_1 := HomalgIdentityMatrix( deduped_16_1, deduped_23_1 );
    hoisted_8_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_20_1, Target ) );
    return List( [ 1 .. deduped_16_1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := ConvertRowToMatrix( CertainRows( hoisted_9_1, [ i_2 ] ), 1, deduped_16_1 ) * deduped_17_1;
            return List( deduped_18_1, function ( j_3 )
                    local deduped_1_3;
                    deduped_1_3 := deduped_12_1[j_3];
                    return AsCapCategoryMorphism( cat_1, hoisted_8_1[j_3], ConvertRowToMatrix( hoisted_1_2 * UnionOfRows( deduped_23_1, deduped_1_3, [ HomalgZeroMatrix( Sum( deduped_12_1{[ 1 .. (j_3 - 1) ]} ), deduped_1_3, deduped_23_1 ), HomalgIdentityMatrix( deduped_1_3, deduped_23_1 ), HomalgZeroMatrix( Sum( deduped_12_1{[ (j_3 + 1) .. deduped_19_1 ]} ), deduped_1_3, deduped_23_1 ) ] ), deduped_2_1[j_3], deduped_3_1[j_3] ), hoisted_14_1[j_3] );
                end );
        end );
end
########
        
    , 4211 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.BasisOfSolutionsOfHomogeneousLinearSystemInLinearCategory :=
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, hoisted_5_1, hoisted_6_1, hoisted_9_1, hoisted_10_1, deduped_13_1, hoisted_15_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1;
    deduped_22_1 := UnderlyingRing( cat_1 );
    deduped_21_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_20_1 := List( arg2_1, Length )[1];
    deduped_19_1 := [ 1 .. deduped_20_1 ];
    hoisted_6_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_5_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    deduped_4_1 := List( arg3_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Source( logic_new_func_x_3 ) );
                  end );
          end )[1];
    deduped_3_1 := List( arg2_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Target( logic_new_func_x_3 ) );
                  end );
          end )[1];
    hoisted_2_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Target( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_1_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Source( logic_new_func_x_3 ) );
                end );
        end );
    deduped_18_1 := SyzygiesOfRows( UnionOfRows( deduped_22_1, Sum( List( deduped_21_1, function ( i_2 )
                  return hoisted_1_1[i_2][1] * hoisted_2_1[i_2][1];
              end ) ), List( deduped_19_1, function ( j_2 )
                return UnionOfColumns( deduped_22_1, deduped_3_1[j_2] * deduped_4_1[j_2], List( deduped_21_1, function ( i_3 )
                          return KroneckerMat( hoisted_5_1[i_3][j_2], hoisted_6_1[i_3][j_2] );
                      end ) );
            end ) ) );
    deduped_17_1 := NumberRows( deduped_18_1 );
    hoisted_15_1 := List( arg3_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, Source );
          end )[1];
    deduped_13_1 := List( deduped_19_1, function ( j_2 )
            return deduped_3_1[j_2] * deduped_4_1[j_2];
        end );
    hoisted_10_1 := HomalgIdentityMatrix( deduped_17_1, deduped_22_1 );
    hoisted_9_1 := List( arg2_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, Target );
          end )[1];
    return List( [ 1 .. deduped_17_1 ], function ( i_2 )
            local hoisted_1_2;
            hoisted_1_2 := ConvertRowToMatrix( CertainRows( hoisted_10_1, [ i_2 ] ), 1, deduped_17_1 ) * deduped_18_1;
            return List( deduped_19_1, function ( j_3 )
                    local deduped_1_3;
                    deduped_1_3 := deduped_13_1[j_3];
                    return AsCapCategoryMorphism( cat_1, hoisted_9_1[j_3], ConvertRowToMatrix( hoisted_1_2 * UnionOfRows( deduped_22_1, deduped_1_3, [ HomalgZeroMatrix( Sum( deduped_13_1{[ 1 .. (j_3 - 1) ]} ), deduped_1_3, deduped_22_1 ), HomalgIdentityMatrix( deduped_1_3, deduped_22_1 ), HomalgZeroMatrix( Sum( deduped_13_1{[ (j_3 + 1) .. deduped_20_1 ]} ), deduped_1_3, deduped_22_1 ) ] ), deduped_3_1[j_3], deduped_4_1[j_3] ), hoisted_15_1[j_3] );
                end );
        end );
end
########
        
    ;
    
    ##
    AddBraiding( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_3_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( b_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := deduped_7_1 * deduped_8_1;
    morphism_attr_3_1 := CertainRows( HomalgIdentityMatrix( deduped_6_1, UnderlyingRing( cat_1 ) ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_8_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1;
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_3_1 ) ), morphism_attr_3_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_3_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.Braiding :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( b_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := deduped_7_1 * deduped_8_1;
    deduped_5_1 := AsCapCategoryObject( cat_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, UnderlyingRing( cat_1 ) ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := i_2 - 1;
                return REM_INT( deduped_1_2, deduped_8_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1;
            end ) ), deduped_5_1 );
end
########
        
    ;
    
    ##
    AddBraidingInverse( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_3_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( b_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := deduped_7_1 * deduped_8_1;
    morphism_attr_3_1 := CertainRows( HomalgIdentityMatrix( deduped_6_1, UnderlyingRing( cat_1 ) ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_7_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1;
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_3_1 ) ), morphism_attr_3_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_3_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.BraidingInverse :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( b_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := deduped_7_1 * deduped_8_1;
    deduped_5_1 := AsCapCategoryObject( cat_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, UnderlyingRing( cat_1 ) ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := i_2 - 1;
                return REM_INT( deduped_1_2, deduped_7_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1;
            end ) ), deduped_5_1 );
end
########
        
    ;
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := AsInteger( s_1 );
    hoisted_4_1 := AsInteger( b_1 );
    deduped_3_1 := AsInteger( a_1 );
    return AsCapCategoryMorphism( cat_1, s_1, CertainRows( HomalgIdentityMatrix( deduped_5_1, UnderlyingRing( cat_1 ) ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := i_2 - 1;
                return REM_INT( deduped_1_2, deduped_3_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, deduped_3_1 ) + 1;
            end ) ), r_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := AsInteger( s_1 );
    hoisted_2_1 := AsInteger( a_1 );
    deduped_1_1 := AsInteger( b_1 );
    return AsCapCategoryMorphism( cat_1, s_1, CertainRows( HomalgIdentityMatrix( deduped_3_1, UnderlyingRing( cat_1 ) ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := i_2 - 1;
                return REM_INT( deduped_1_2, deduped_1_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, deduped_1_1 ) + 1;
            end ) ), r_1 );
end
########
        
    , 100 );
    
    ##
    AddClosedMonoidalLeftCoevaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := deduped_8_1 * deduped_10_1;
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_5_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                end ) ), deduped_5_1 ) * KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
              end ) ) );
    return AsCapCategoryMorphism( cat_1, b_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 3212 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ClosedMonoidalLeftCoevaluationMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( b_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := deduped_7_1 * deduped_9_1;
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_4_1 ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                end ) ) ), AsCapCategoryObject( cat_1, deduped_7_1 * (deduped_9_1 * deduped_7_1) ) );
end
########
        
    ;
    
    ##
    AddClosedMonoidalLeftCoevaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( b_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := deduped_7_1 * deduped_9_1;
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_4_1 ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                end ) ) ), r_1 );
end
########
        
    , 2809 : IsPrecompiledDerivation := true );
    
    ##
    AddClosedMonoidalLeftEvaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( b_1 );
    deduped_6_1 := AsInteger( a_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_6_1, deduped_8_1 );
    deduped_4_1 := deduped_6_1 * deduped_7_1;
    morphism_attr_1_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_8_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
              end ) ), deduped_5_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_8_1 ), ConvertMatrixToColumn( deduped_5_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, b_1 );
end
########
        
    , 3011 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ClosedMonoidalLeftEvaluationMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := AsInteger( b_1 );
    deduped_5_1 := AsInteger( a_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_5_1, deduped_7_1 );
    deduped_3_1 := deduped_5_1 * deduped_6_1;
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_3_1 * deduped_5_1 ), KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_7_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_6_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_6_1 ) + 1);
                end ) ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_7_1 ), ConvertMatrixToColumn( deduped_4_1 ) ), b_1 );
end
########
        
    ;
    
    ##
    AddClosedMonoidalLeftEvaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := AsInteger( b_1 );
    deduped_5_1 := AsInteger( a_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_5_1, deduped_7_1 );
    deduped_3_1 := deduped_5_1 * deduped_6_1;
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_7_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_6_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_6_1 ) + 1);
                end ) ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_7_1 ), ConvertMatrixToColumn( deduped_4_1 ) ), b_1 );
end
########
        
    , 2608 : IsPrecompiledDerivation := true );
    
    ##
    AddClosedMonoidalRightCoevaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := AsInteger( b_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := deduped_11_1 * deduped_9_1;
    deduped_7_1 := deduped_9_1 * deduped_11_1;
    deduped_6_1 := deduped_9_1 * deduped_9_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_11_1, deduped_10_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_5_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ), deduped_5_1 ) * KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_10_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                end ) ) ) * KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_8_1, deduped_10_1 ), List( [ 1 .. deduped_8_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
              end ) ) );
    return AsCapCategoryMorphism( cat_1, b_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 5925 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ClosedMonoidalRightCoevaluationMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := deduped_10_1 * deduped_8_1;
    deduped_6_1 := deduped_8_1 * deduped_10_1;
    deduped_5_1 := deduped_8_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_4_1 ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                end ) ) ), AsCapCategoryObject( cat_1, deduped_8_1 * deduped_6_1 ) );
end
########
        
    ;
    
    ##
    AddClosedMonoidalRightCoevaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := deduped_10_1 * deduped_8_1;
    deduped_6_1 := deduped_8_1 * deduped_10_1;
    deduped_5_1 := deduped_8_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_4_1 ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                end ) ) ), r_1 );
end
########
        
    , 5522 : IsPrecompiledDerivation := true );
    
    ##
    AddClosedMonoidalRightEvaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := AsInteger( b_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_8_1, deduped_10_1 );
    deduped_6_1 := deduped_8_1 * deduped_9_1;
    deduped_5_1 := deduped_8_1 * deduped_6_1;
    morphism_attr_1_1 := CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_10_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := (i_2 - 1);
                return (REM_INT( deduped_1_2, deduped_6_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_6_1 ) + 1);
            end ) ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                end ) ), deduped_7_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_9_1, deduped_10_1 ), ConvertMatrixToColumn( deduped_7_1 ) ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, b_1 );
end
########
        
    , 4419 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ClosedMonoidalRightEvaluationMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( b_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_7_1, deduped_9_1 );
    deduped_5_1 := deduped_7_1 * deduped_8_1;
    deduped_4_1 := deduped_7_1 * deduped_5_1;
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_4_1 ), CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_9_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_5_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_5_1 ) + 1);
              end ) ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ), deduped_6_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_9_1 ), ConvertMatrixToColumn( deduped_6_1 ) )), b_1 );
end
########
        
    ;
    
    ##
    AddClosedMonoidalRightEvaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( b_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := AsInteger( s_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_7_1 );
    deduped_4_1 := deduped_8_1 * deduped_9_1;
    return AsCapCategoryMorphism( cat_1, s_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_7_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_4_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_4_1 ) + 1);
              end ) ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_7_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ), deduped_5_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_9_1, deduped_7_1 ), ConvertMatrixToColumn( deduped_5_1 ) )), b_1 );
end
########
        
    , 4016 : IsPrecompiledDerivation := true );
    
    ##
    AddCoDualOnMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCapCategoryMorphism( cat_1, Range( alpha_1 ), TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), Source( alpha_1 ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddCoDualOnMorphismsWithGivenCoDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), r_1 );
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
    local morphism_attr_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_12_1 := AsInteger( b_1 );
    deduped_11_1 := AsInteger( a_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_11_1, deduped_13_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_12_1, deduped_13_1 );
    deduped_8_1 := deduped_11_1 * deduped_12_1;
    deduped_7_1 := deduped_8_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_13_1 );
    deduped_5_1 := CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_13_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1;
          end ) );
    morphism_attr_1_1 := KroneckerMat( deduped_6_1, ConvertMatrixToRow( deduped_9_1 ) * KroneckerMat( KroneckerMat( ConvertMatrixToRow( deduped_10_1 ), deduped_9_1 ), deduped_9_1 ) * KroneckerMat( KroneckerMat( deduped_10_1, CertainRows( deduped_6_1, List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                    end ) ) ), deduped_9_1 ) ) * (KroneckerMat( deduped_6_1, deduped_5_1 ) * KroneckerMat( deduped_5_1, deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_6_1 ), deduped_6_1 ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 17673 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoDualityTensorProductCompatibilityMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_12_1 := AsInteger( b_1 );
    deduped_11_1 := AsInteger( a_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_11_1, deduped_13_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_12_1, deduped_13_1 );
    deduped_8_1 := deduped_11_1 * deduped_12_1;
    deduped_7_1 := deduped_8_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_13_1 );
    deduped_5_1 := AsCapCategoryObject( cat_1, deduped_8_1 );
    deduped_4_1 := CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_13_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1;
          end ) );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, KroneckerMat( deduped_6_1, ConvertMatrixToRow( deduped_9_1 ) * KroneckerMat( KroneckerMat( ConvertMatrixToRow( deduped_10_1 ), deduped_9_1 ), deduped_9_1 ) * KroneckerMat( KroneckerMat( deduped_10_1, CertainRows( deduped_6_1, List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                      end ) ) ), deduped_9_1 ) ) * (KroneckerMat( deduped_6_1, deduped_4_1 ) * KroneckerMat( deduped_4_1, deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_6_1 ), deduped_6_1 )), deduped_5_1 );
end
########
        
    ;
    
    ##
    AddCoDualityTensorProductCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := AsInteger( b_1 );
    deduped_10_1 := AsInteger( a_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_10_1, deduped_12_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_11_1, deduped_12_1 );
    deduped_7_1 := deduped_10_1 * deduped_11_1;
    deduped_6_1 := deduped_7_1 * deduped_7_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_12_1 );
    deduped_4_1 := CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_12_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1;
          end ) );
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( deduped_5_1, ConvertMatrixToRow( deduped_8_1 ) * KroneckerMat( KroneckerMat( ConvertMatrixToRow( deduped_9_1 ), deduped_8_1 ), deduped_8_1 ) * KroneckerMat( KroneckerMat( deduped_9_1, CertainRows( deduped_5_1, List( [ 1 .. deduped_7_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                      end ) ) ), deduped_8_1 ) ) * (KroneckerMat( deduped_5_1, deduped_4_1 ) * KroneckerMat( deduped_4_1, deduped_5_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_5_1 ), deduped_5_1 )), r_1 );
end
########
        
    , 17172 : IsPrecompiledDerivation := true );
    
    ##
    AddCoLambdaElimination( cat,
        
########
function ( cat_1, a_1, b_1, alpha_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := AsInteger( b_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( a_1 );
    deduped_4_1 := deduped_5_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, a_1, KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), ConvertMatrixToRow( deduped_3_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_3_1 ) * KroneckerMat( AsHomalgMatrix( alpha_1 ), deduped_3_1 ), b_1 );
end
########
        
    , 3616 : IsPrecompiledDerivation := true );
    
    ##
    AddCoLambdaIntroduction( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( Range( alpha_1 ) );
    deduped_4_1 := deduped_5_1 * deduped_5_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_5_1, deduped_6_1 );
    morphism_attr_1_1 := KroneckerMat( deduped_3_1, AsHomalgMatrix( alpha_1 ) ) * (CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_5_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_5_1 ) + 1);
              end ) ) * ConvertMatrixToColumn( deduped_3_1 ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, 1 ) );
end
########
        
    , 5625 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoLambdaIntroduction :=
        
########
function ( cat_1, alpha_1 )
    local deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := AsInteger( Range( alpha_1 ) );
    deduped_3_1 := deduped_4_1 * deduped_4_1;
    deduped_2_1 := HomalgIdentityMatrix( deduped_4_1, deduped_5_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, AsInteger( Source( alpha_1 ) ) * deduped_4_1 ), KroneckerMat( deduped_2_1, AsHomalgMatrix( alpha_1 ) ) * (CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_5_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_4_1 ) * deduped_4_1 + QUO_INT( deduped_1_2, deduped_4_1 ) + 1);
                end ) ) * ConvertMatrixToColumn( deduped_2_1 )), AsCapCategoryObject( cat_1, 1 ) );
end
########
        
    ;
    
    ##
    AddCoRankMorphism( cat,
        
########
function ( cat_1, a_1 )
    local deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( a_1 );
    deduped_4_1 := AsCapCategoryObject( cat_1, 1 );
    deduped_3_1 := deduped_5_1 * deduped_5_1;
    deduped_2_1 := HomalgIdentityMatrix( deduped_5_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_4_1, ConvertMatrixToRow( deduped_2_1 ) * (CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_6_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_5_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_5_1 ) + 1);
                end ) ) * ConvertMatrixToColumn( deduped_2_1 )), deduped_4_1 );
end
########
        
    , 6930 : IsPrecompiledDerivation := true );
    
    ##
    AddCoTraceMap( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsCapCategoryObject( cat_1, 1 );
    deduped_4_1 := AsInteger( Range( alpha_1 ) );
    deduped_3_1 := deduped_4_1 * deduped_4_1;
    deduped_2_1 := HomalgIdentityMatrix( deduped_4_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, ConvertMatrixToRow( HomalgIdentityMatrix( AsInteger( Source( alpha_1 ) ), deduped_6_1 ) ) * (KroneckerMat( deduped_2_1, AsHomalgMatrix( alpha_1 ) ) * (CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_6_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_4_1 ) * deduped_4_1 + QUO_INT( deduped_1_2, deduped_4_1 ) + 1);
                  end ) ) * ConvertMatrixToColumn( deduped_2_1 ))), deduped_5_1 );
end
########
        
    , 6829 : IsPrecompiledDerivation := true );
    
    ##
    AddCoastrictionToImage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    morphism_attr_1_1 := UniqueRightDivide( deduped_2_1, BasisOfRows( deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoastrictionToImage :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), UniqueRightDivide( deduped_1_1, BasisOfRows( deduped_1_1 ) ), AsCapCategoryObject( cat_1, RowRankOfMatrix( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddCoastrictionToImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local deduped_1_1;
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), UniqueRightDivide( deduped_1_1, BasisOfRows( deduped_1_1 ) ), I_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedCoevaluationForCoDual( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToColumn( HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, 1 ) );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoclosedCoevaluationForCoDual :=
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := AsInteger( a_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_1_1 * deduped_1_1 ), ConvertMatrixToColumn( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ) ), AsCapCategoryObject( cat_1, 1 ) );
end
########
        
    ;
    
    ##
    AddCoclosedCoevaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, ConvertMatrixToColumn( HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ) ), r_1 );
end
########
        
    , 100 );
    
    ##
    AddCoclosedEvaluationForCoDual( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToRow( HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoclosedEvaluationForCoDual :=
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := AsInteger( a_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 1 ), ConvertMatrixToRow( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ) ), AsCapCategoryObject( cat_1, deduped_1_1 * deduped_1_1 ) );
end
########
        
    ;
    
    ##
    AddCoclosedEvaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, ConvertMatrixToRow( HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ) ), r_1 );
end
########
        
    , 100 );
    
    ##
    AddCoclosedMonoidalLeftCoevaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_10_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    morphism_attr_1_1 := KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                end ) ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_7_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, b_1 );
end
########
        
    , 3212 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoclosedMonoidalLeftCoevaluationMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := AsInteger( b_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_7_1, deduped_9_1 );
    deduped_5_1 := deduped_8_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    deduped_3_1 := deduped_7_1 * deduped_8_1;
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_3_1 * deduped_8_1 ), KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_9_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_6_1 ), b_1 );
end
########
        
    ;
    
    ##
    AddCoclosedMonoidalLeftCoevaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( b_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := deduped_9_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_8_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_6_1 ), b_1 );
end
########
        
    , 2809 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedMonoidalLeftEvaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := AsInteger( b_1 );
    deduped_5_1 := deduped_6_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_7_1 );
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_7_1 ), ConvertMatrixToRow( deduped_4_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_7_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
              end ) ), deduped_4_1 );
    return AsCapCategoryMorphism( cat_1, b_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 3011 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoclosedMonoidalLeftEvaluationMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( b_1 );
    deduped_4_1 := deduped_5_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), ConvertMatrixToRow( deduped_3_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                end ) ), deduped_3_1 ), AsCapCategoryObject( cat_1, deduped_4_1 * deduped_7_1 ) );
end
########
        
    ;
    
    ##
    AddCoclosedMonoidalLeftEvaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( b_1 );
    deduped_4_1 := deduped_5_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), ConvertMatrixToRow( deduped_3_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                end ) ), deduped_3_1 ), r_1 );
end
########
        
    , 2608 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedMonoidalRightCoevaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := AsInteger( b_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_11_1, deduped_10_1 );
    deduped_7_1 := deduped_9_1 * deduped_9_1;
    deduped_6_1 := deduped_11_1 * deduped_9_1;
    deduped_5_1 := deduped_9_1 * deduped_11_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    morphism_attr_1_1 := KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_10_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
              end ) ) ) * (KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_10_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_8_1 ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, b_1 );
end
########
        
    , 5924 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoclosedMonoidalRightCoevaluationMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := AsInteger( b_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_9_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_10_1 );
    deduped_3_1 := deduped_8_1 * deduped_9_1;
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_3_1 * deduped_8_1 ), KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_10_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                end ) ) ) * (KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_10_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_7_1 )), b_1 );
end
########
        
    ;
    
    ##
    AddCoclosedMonoidalRightCoevaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_10_1 * deduped_8_1;
    deduped_4_1 := deduped_8_1 * deduped_10_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_9_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                end ) ) ) * (KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_7_1 )), b_1 );
end
########
        
    , 5521 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedMonoidalRightEvaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( a_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( b_1 );
    deduped_7_1 := deduped_8_1 * deduped_10_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_5_1 := deduped_7_1 * deduped_10_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_9_1 ), ConvertMatrixToRow( deduped_6_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                end ) ), deduped_6_1 ) * CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := (i_2 - 1);
                return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
            end ) );
    return AsCapCategoryMorphism( cat_1, b_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 4420 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoclosedMonoidalRightEvaluationMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( b_1 );
    deduped_6_1 := deduped_7_1 * deduped_9_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_4_1 := deduped_6_1 * deduped_9_1;
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_8_1 ), ConvertMatrixToRow( deduped_5_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ), deduped_5_1 ) * CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_8_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
              end ) ), AsCapCategoryObject( cat_1, deduped_9_1 * deduped_6_1 ) );
end
########
        
    ;
    
    ##
    AddCoclosedMonoidalRightEvaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( b_1 );
    deduped_6_1 := deduped_7_1 * deduped_9_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_4_1 := deduped_6_1 * deduped_9_1;
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_8_1 ), ConvertMatrixToRow( deduped_5_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ), deduped_5_1 ) * CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_8_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
              end ) ), r_1 );
end
########
        
    , 4017 : IsPrecompiledDerivation := true );
    
    ##
    AddCoefficientsOfMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return EntriesOfHomalgMatrix( AsHomalgMatrix( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCoequalizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Length( morphisms_1 );
    deduped_3_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := AsInteger( Y_1 );
    return AsCapCategoryObject( cat_1, deduped_1_1 - RowRankOfMatrix( (UnionOfRows( deduped_2_1, deduped_1_1, deduped_3_1{[ 1 .. deduped_4_1 - 1 ]} ) - UnionOfRows( deduped_2_1, deduped_1_1, deduped_3_1{[ 2 .. deduped_4_1 ]} )) ) );
end
########
        
    , 2824 : IsPrecompiledDerivation := true );
    
    ##
    AddCoequalizerFunctorial( cat,
        
########
function ( cat_1, morphisms_1, mu_1, morphismsp_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := Length( morphismsp_1 );
    deduped_7_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_6_1 := Length( morphisms_1 );
    deduped_5_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsInteger( Range( mu_1 ) );
    deduped_2_1 := AsInteger( Source( mu_1 ) );
    morphism_attr_1_1 := UniqueLeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_4_1, deduped_2_1, deduped_5_1{[ 1 .. deduped_6_1 - 1 ]} ) - UnionOfRows( deduped_4_1, deduped_2_1, deduped_5_1{[ 2 .. deduped_6_1 ]} ) ), AsHomalgMatrix( mu_1 ) * SyzygiesOfColumns( (UnionOfRows( deduped_4_1, deduped_3_1, deduped_7_1{[ 1 .. deduped_8_1 - 1 ]} ) - UnionOfRows( deduped_4_1, deduped_3_1, deduped_7_1{[ 2 .. deduped_8_1 ]} )) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 11500 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoequalizerFunctorial :=
        
########
function ( cat_1, morphisms_1, mu_1, morphismsp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphismsp_1 );
    deduped_8_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_7_1 := Length( morphisms_1 );
    deduped_6_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_5_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := AsInteger( Range( mu_1 ) );
    deduped_3_1 := AsInteger( Source( mu_1 ) );
    deduped_2_1 := UnionOfRows( deduped_5_1, deduped_4_1, deduped_8_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfRows( deduped_5_1, deduped_4_1, deduped_8_1{[ 2 .. deduped_9_1 ]} );
    deduped_1_1 := UnionOfRows( deduped_5_1, deduped_3_1, deduped_6_1{[ 1 .. deduped_7_1 - 1 ]} ) - UnionOfRows( deduped_5_1, deduped_3_1, deduped_6_1{[ 2 .. deduped_7_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_3_1 - RowRankOfMatrix( deduped_1_1 ) ), UniqueLeftDivide( SyzygiesOfColumns( deduped_1_1 ), AsHomalgMatrix( mu_1 ) * SyzygiesOfColumns( deduped_2_1 ) ), AsCapCategoryObject( cat_1, deduped_4_1 - RowRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddCoequalizerFunctorialWithGivenCoequalizers( cat,
        
########
function ( cat_1, P_1, morphisms_1, mu_1, morphismsp_1, Pp_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := Length( morphismsp_1 );
    deduped_7_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_6_1 := Length( morphisms_1 );
    deduped_5_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsInteger( Range( mu_1 ) );
    deduped_2_1 := AsInteger( Source( mu_1 ) );
    morphism_attr_1_1 := UniqueLeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_4_1, deduped_2_1, deduped_5_1{[ 1 .. deduped_6_1 - 1 ]} ) - UnionOfRows( deduped_4_1, deduped_2_1, deduped_5_1{[ 2 .. deduped_6_1 ]} ) ), AsHomalgMatrix( mu_1 ) * SyzygiesOfColumns( (UnionOfRows( deduped_4_1, deduped_3_1, deduped_7_1{[ 1 .. deduped_8_1 - 1 ]} ) - UnionOfRows( deduped_4_1, deduped_3_1, deduped_7_1{[ 2 .. deduped_8_1 ]} )) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 5851 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoequalizerFunctorialWithGivenCoequalizers :=
        
########
function ( cat_1, P_1, morphisms_1, mu_1, morphismsp_1, Pp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphismsp_1 );
    deduped_8_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_7_1 := Length( morphisms_1 );
    deduped_6_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_5_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := AsInteger( Range( mu_1 ) );
    deduped_3_1 := AsInteger( Source( mu_1 ) );
    deduped_2_1 := UnionOfRows( deduped_5_1, deduped_4_1, deduped_8_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfRows( deduped_5_1, deduped_4_1, deduped_8_1{[ 2 .. deduped_9_1 ]} );
    deduped_1_1 := UnionOfRows( deduped_5_1, deduped_3_1, deduped_6_1{[ 1 .. deduped_7_1 - 1 ]} ) - UnionOfRows( deduped_5_1, deduped_3_1, deduped_6_1{[ 2 .. deduped_7_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_3_1 - RowRankOfMatrix( deduped_1_1 ) ), UniqueLeftDivide( SyzygiesOfColumns( deduped_1_1 ), AsHomalgMatrix( mu_1 ) * SyzygiesOfColumns( deduped_2_1 ) ), AsCapCategoryObject( cat_1, deduped_4_1 - RowRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddCoevaluationForDual( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToRow( HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoevaluationForDual :=
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := AsInteger( a_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 1 ), ConvertMatrixToRow( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ) ), AsCapCategoryObject( cat_1, deduped_1_1 * deduped_1_1 ) );
end
########
        
    ;
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, ConvertMatrixToRow( HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ) ), r_1 );
end
########
        
    , 100 );
    
    ##
    AddCoimageObject( cat,
        
########
function ( cat_1, arg2_1 )
    return AsCapCategoryObject( cat_1, ColumnRankOfMatrix( AsHomalgMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoimageObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueLeftDivide( BasisOfColumns( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( mu_1 ) * BasisOfColumns( AsHomalgMatrix( alphap_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 603 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoimageObjectFunctorial :=
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alphap_1 );
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, ColumnRankOfMatrix( deduped_1_1 ) ), UniqueLeftDivide( BasisOfColumns( deduped_1_1 ), AsHomalgMatrix( mu_1 ) * BasisOfColumns( deduped_2_1 ) ), AsCapCategoryObject( cat_1, ColumnRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddCoimageObjectFunctorialWithGivenCoimageObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, mu_1, alphap_1, Cp_1 )
    return AsCapCategoryMorphism( cat_1, C_1, UniqueLeftDivide( BasisOfColumns( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( mu_1 ) * BasisOfColumns( AsHomalgMatrix( alphap_1 ) ) ), Cp_1 );
end
########
        
    , 402 : IsPrecompiledDerivation := true );
    
    ##
    AddCoimageProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := BasisOfColumns( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoimageProjection :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), BasisOfColumns( deduped_1_1 ), AsCapCategoryObject( cat_1, ColumnRankOfMatrix( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddCoimageProjectionWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), BasisOfColumns( AsHomalgMatrix( alpha_1 ) ), C_1 );
end
########
        
    , 100 );
    
    ##
    AddCokernelColift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueLeftDivide( SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( tau_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Range( tau_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CokernelColift :=
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ), UniqueLeftDivide( deduped_1_1, AsHomalgMatrix( tau_1 ) ), Range( tau_1 ) );
end
########
        
    ;
    
    ##
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueLeftDivide( SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( tau_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Range( tau_1 ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CokernelColiftWithGivenCokernelObject :=
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ), UniqueLeftDivide( deduped_1_1, AsHomalgMatrix( tau_1 ) ), Range( tau_1 ) );
end
########
        
    ;
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCapCategoryObject( cat_1, AsInteger( Range( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueLeftDivide( SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( mu_1 ) * SyzygiesOfColumns( AsHomalgMatrix( alphap_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 606 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CokernelObjectFunctorial :=
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( AsHomalgMatrix( alphap_1 ) );
    deduped_1_1 := SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ), UniqueLeftDivide( deduped_1_1, AsHomalgMatrix( mu_1 ) * deduped_2_1 ), AsCapCategoryObject( cat_1, NumberColumns( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddCokernelObjectFunctorialWithGivenCokernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueLeftDivide( SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( mu_1 ) * SyzygiesOfColumns( AsHomalgMatrix( alphap_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 405 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CokernelObjectFunctorialWithGivenCokernelObjects :=
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( AsHomalgMatrix( alphap_1 ) );
    deduped_1_1 := SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ), UniqueLeftDivide( deduped_1_1, AsHomalgMatrix( mu_1 ) * deduped_2_1 ), AsCapCategoryObject( cat_1, NumberColumns( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, Range( alpha_1 ), deduped_1_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, Range( alpha_1 ), deduped_1_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, Range( alpha_1 ), SafeLeftDivide( AsHomalgMatrix( alpha_1 ), AsHomalgMatrix( beta_1 ) ), Range( beta_1 ) );
end
########
        
    , 100 );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    return AsCapCategoryMorphism( cat_1, Range( epsilon_1 ), UniqueLeftDivide( AsHomalgMatrix( epsilon_1 ), AsHomalgMatrix( tau_1 ) ), Range( tau_1 ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismFromCoproduct( cat,
        
########
function ( cat_1, alpha_1, I_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( I_1, AsInteger );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return AsCapCategoryMorphism( cat_1, I_1[i_1], CertainRows( AsHomalgMatrix( alpha_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ), Range( alpha_1 ) );
end
########
        
    , 403 : IsPrecompiledDerivation := true );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, AsInteger );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return AsCapCategoryMorphism( cat_1, S_1[i_1], CertainRows( AsHomalgMatrix( alpha_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ), Range( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismIntoDirectProduct( cat,
        
########
function ( cat_1, alpha_1, P_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( P_1, AsInteger );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), CertainColumns( AsHomalgMatrix( alpha_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ), P_1[i_1] );
end
########
        
    , 402 : IsPrecompiledDerivation := true );
    
    ##
    AddComponentOfMorphismIntoDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, AsInteger );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), CertainColumns( AsHomalgMatrix( alpha_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ), S_1[i_1] );
end
########
        
    , 100 );
    
    ##
    AddCoproduct( cat,
        
########
function ( cat_1, objects_1 )
    return AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddCoproductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := List( objectsp_1, AsInteger );
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_3_1 := Length( objectsp_1 );
    deduped_4_1 := UnionOfRows( deduped_5_1, Sum( deduped_6_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_6_1[i_2];
              return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( L_1[i_2] ) ) ) * UnionOfColumns( deduped_5_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_6_1{[ 1 .. (i_2 - 1) ]} ), deduped_5_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_5_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_6_1{[ (i_2 + 1) .. hoisted_3_1 ]} ), deduped_5_1 ) ] );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 2123 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoproductFunctorial :=
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local hoisted_1_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := List( objectsp_1, AsInteger );
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := Sum( deduped_7_1 );
    hoisted_4_1 := Length( objectsp_1 );
    hoisted_1_1 := List( L_1, AsHomalgMatrix );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) ), UnionOfRows( deduped_6_1, deduped_5_1, List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_7_1[i_2];
                return hoisted_1_1[i_2] * UnionOfColumns( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ (i_2 + 1) .. hoisted_4_1 ]} ), deduped_6_1 ) ] );
            end ) ), AsCapCategoryObject( cat_1, deduped_5_1 ) );
end
########
        
    ;
    
    ##
    AddCoproductFunctorialWithGivenCoproducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local deduped_1_1, hoisted_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_3_1 := Length( objectsp_1 );
    deduped_1_1 := List( objectsp_1, AsInteger );
    deduped_4_1 := UnionOfRows( deduped_5_1, AsInteger( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_1_1[i_2];
              return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( L_1[i_2] ) ) ) * UnionOfColumns( deduped_5_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_1_1{[ 1 .. (i_2 - 1) ]} ), deduped_5_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_5_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_1_1{[ (i_2 + 1) .. hoisted_3_1 ]} ), deduped_5_1 ) ] );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, Pp_1 );
end
########
        
    , 1718 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.CoproductFunctorialWithGivenCoproducts :=
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local hoisted_1_1, deduped_2_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := Length( objectsp_1 );
    deduped_2_1 := List( objectsp_1, AsInteger );
    hoisted_1_1 := List( L_1, AsHomalgMatrix );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) ), UnionOfRows( deduped_5_1, AsInteger( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_2_1[i_2];
                return hoisted_1_1[i_2] * UnionOfColumns( deduped_5_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ 1 .. (i_2 - 1) ]} ), deduped_5_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_5_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ (i_2 + 1) .. hoisted_4_1 ]} ), deduped_5_1 ) ] );
            end ) ), Pp_1 );
end
########
        
    ;
    
    ##
    AddDirectProduct( cat,
        
########
function ( cat_1, objects_1 )
    return AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectProductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := List( objects_1, AsInteger );
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_3_1 := Length( objects_1 );
    deduped_4_1 := UnionOfColumns( deduped_5_1, Sum( deduped_6_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_6_1[i_2];
              return UnionOfRows( deduped_5_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_6_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_5_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_5_1 ), HomalgZeroMatrix( Sum( deduped_6_1{[ (i_2 + 1) .. hoisted_3_1 ]} ), deduped_1_2, deduped_5_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( L_1[i_2] ) ) );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 2118 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.DirectProductFunctorial :=
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := List( objects_1, AsInteger );
    deduped_5_1 := Sum( deduped_6_1 );
    hoisted_4_1 := List( L_1, AsHomalgMatrix );
    hoisted_3_1 := Length( objects_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_5_1 ), UnionOfColumns( deduped_7_1, deduped_5_1, List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_6_1[i_2];
                return UnionOfRows( deduped_7_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_6_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_7_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_7_1 ), HomalgZeroMatrix( Sum( deduped_6_1{[ (i_2 + 1) .. hoisted_3_1 ]} ), deduped_1_2, deduped_7_1 ) ] ) * hoisted_4_1[i_2];
            end ) ), AsCapCategoryObject( cat_1, Sum( List( objectsp_1, AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddDirectProductFunctorialWithGivenDirectProducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local deduped_1_1, hoisted_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_3_1 := Length( objects_1 );
    deduped_1_1 := List( objects_1, AsInteger );
    deduped_4_1 := UnionOfColumns( deduped_5_1, AsInteger( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_1_1[i_2];
              return UnionOfRows( deduped_5_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_1_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_5_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_5_1 ), HomalgZeroMatrix( Sum( deduped_1_1{[ (i_2 + 1) .. hoisted_3_1 ]} ), deduped_1_2, deduped_5_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( L_1[i_2] ) ) );
          end ) );
    return AsCapCategoryMorphism( cat_1, P_1, deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 1713 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.DirectProductFunctorialWithGivenDirectProducts :=
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local deduped_1_1, hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := List( L_1, AsHomalgMatrix );
    hoisted_3_1 := Length( objects_1 );
    deduped_1_1 := List( objects_1, AsInteger );
    return AsCapCategoryMorphism( cat_1, P_1, UnionOfColumns( deduped_5_1, AsInteger( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_1_1[i_2];
                return UnionOfRows( deduped_5_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_1_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_5_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_5_1 ), HomalgZeroMatrix( Sum( deduped_1_1{[ (i_2 + 1) .. hoisted_3_1 ]} ), deduped_1_2, deduped_5_1 ) ] ) * hoisted_4_1[i_2];
            end ) ), AsCapCategoryObject( cat_1, Sum( List( objectsp_1, AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, objects_1 )
    return AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSumFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := DiagMat( UnderlyingRing( cat_1 ), List( L_1, AsHomalgMatrix ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.DirectSumFunctorial :=
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) ), DiagMat( UnderlyingRing( cat_1 ), List( L_1, AsHomalgMatrix ) ), AsCapCategoryObject( cat_1, Sum( List( objectsp_1, AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return AsCapCategoryMorphism( cat_1, P_1, DiagMat( UnderlyingRing( cat_1 ), List( L_1, AsHomalgMatrix ) ), Pp_1 );
end
########
        
    , 100 );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return AsCapCategoryObject( cat_1, 1 );
end
########
        
    , 100 );
    
    ##
    AddDualOnMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCapCategoryMorphism( cat_1, Range( alpha_1 ), TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), Source( alpha_1 ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddDualOnMorphismsWithGivenDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), r_1 );
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
    AddEmbeddingOfEqualizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := SyzygiesOfRows( UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Y_1 );
end
########
        
    , 2818 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.EmbeddingOfEqualizer :=
        
########
function ( cat_1, Y_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( Y_1 );
    deduped_1_1 := UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_2_1 - RowRankOfMatrix( deduped_1_1 ) ), SyzygiesOfRows( deduped_1_1 ), Y_1 );
end
########
        
    ;
    
    ##
    AddEmbeddingOfEqualizerWithGivenEqualizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := SyzygiesOfRows( UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Y_1 );
end
########
        
    , 2819 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.EmbeddingOfEqualizerWithGivenEqualizer :=
        
########
function ( cat_1, Y_1, morphisms_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( Y_1 );
    deduped_1_1 := UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_2_1 - RowRankOfMatrix( deduped_1_1 ) ), SyzygiesOfRows( deduped_1_1 ), Y_1 );
end
########
        
    ;
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return AsCapCategoryMorphism( cat_1, A_1, HomalgIdentityMatrix( AsInteger( A_1 ), UnderlyingRing( cat_1 ) ), A_1 );
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1, P_1 )
    return AsCapCategoryMorphism( cat_1, A_1, HomalgIdentityMatrix( AsInteger( A_1 ), UnderlyingRing( cat_1 ) ), A_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddEqualizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Length( morphisms_1 );
    deduped_3_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := AsInteger( Y_1 );
    return AsCapCategoryObject( cat_1, deduped_1_1 - RowRankOfMatrix( (UnionOfColumns( deduped_2_1, deduped_1_1, deduped_3_1{[ 1 .. deduped_4_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_1_1, deduped_3_1{[ 2 .. deduped_4_1 ]} )) ) );
end
########
        
    , 2819 : IsPrecompiledDerivation := true );
    
    ##
    AddEqualizerFunctorial( cat,
        
########
function ( cat_1, morphisms_1, mu_1, morphismsp_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := Length( morphismsp_1 );
    deduped_7_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_6_1 := Length( morphisms_1 );
    deduped_5_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsInteger( Range( mu_1 ) );
    deduped_2_1 := AsInteger( Source( mu_1 ) );
    morphism_attr_1_1 := UniqueRightDivide( SyzygiesOfRows( (UnionOfColumns( deduped_4_1, deduped_2_1, deduped_5_1{[ 1 .. deduped_6_1 - 1 ]} ) - UnionOfColumns( deduped_4_1, deduped_2_1, deduped_5_1{[ 2 .. deduped_6_1 ]} )) ) * AsHomalgMatrix( mu_1 ), SyzygiesOfRows( UnionOfColumns( deduped_4_1, deduped_3_1, deduped_7_1{[ 1 .. deduped_8_1 - 1 ]} ) - UnionOfColumns( deduped_4_1, deduped_3_1, deduped_7_1{[ 2 .. deduped_8_1 ]} ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 11479 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.EqualizerFunctorial :=
        
########
function ( cat_1, morphisms_1, mu_1, morphismsp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphismsp_1 );
    deduped_8_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_7_1 := Length( morphisms_1 );
    deduped_6_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_5_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := AsInteger( Range( mu_1 ) );
    deduped_3_1 := AsInteger( Source( mu_1 ) );
    deduped_2_1 := UnionOfColumns( deduped_5_1, deduped_4_1, deduped_8_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfColumns( deduped_5_1, deduped_4_1, deduped_8_1{[ 2 .. deduped_9_1 ]} );
    deduped_1_1 := UnionOfColumns( deduped_5_1, deduped_3_1, deduped_6_1{[ 1 .. deduped_7_1 - 1 ]} ) - UnionOfColumns( deduped_5_1, deduped_3_1, deduped_6_1{[ 2 .. deduped_7_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_3_1 - RowRankOfMatrix( deduped_1_1 ) ), UniqueRightDivide( SyzygiesOfRows( deduped_1_1 ) * AsHomalgMatrix( mu_1 ), SyzygiesOfRows( deduped_2_1 ) ), AsCapCategoryObject( cat_1, deduped_4_1 - RowRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddEqualizerFunctorialWithGivenEqualizers( cat,
        
########
function ( cat_1, P_1, morphisms_1, mu_1, morphismsp_1, Pp_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := Length( morphismsp_1 );
    deduped_7_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_6_1 := Length( morphisms_1 );
    deduped_5_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsInteger( Range( mu_1 ) );
    deduped_2_1 := AsInteger( Source( mu_1 ) );
    morphism_attr_1_1 := UniqueRightDivide( SyzygiesOfRows( (UnionOfColumns( deduped_4_1, deduped_2_1, deduped_5_1{[ 1 .. deduped_6_1 - 1 ]} ) - UnionOfColumns( deduped_4_1, deduped_2_1, deduped_5_1{[ 2 .. deduped_6_1 ]} )) ) * AsHomalgMatrix( mu_1 ), SyzygiesOfRows( UnionOfColumns( deduped_4_1, deduped_3_1, deduped_7_1{[ 1 .. deduped_8_1 - 1 ]} ) - UnionOfColumns( deduped_4_1, deduped_3_1, deduped_7_1{[ 2 .. deduped_8_1 ]} ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 5840 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.EqualizerFunctorialWithGivenEqualizers :=
        
########
function ( cat_1, P_1, morphisms_1, mu_1, morphismsp_1, Pp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphismsp_1 );
    deduped_8_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_7_1 := Length( morphisms_1 );
    deduped_6_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_5_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := AsInteger( Range( mu_1 ) );
    deduped_3_1 := AsInteger( Source( mu_1 ) );
    deduped_2_1 := UnionOfColumns( deduped_5_1, deduped_4_1, deduped_8_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfColumns( deduped_5_1, deduped_4_1, deduped_8_1{[ 2 .. deduped_9_1 ]} );
    deduped_1_1 := UnionOfColumns( deduped_5_1, deduped_3_1, deduped_6_1{[ 1 .. deduped_7_1 - 1 ]} ) - UnionOfColumns( deduped_5_1, deduped_3_1, deduped_6_1{[ 2 .. deduped_7_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_3_1 - RowRankOfMatrix( deduped_1_1 ) ), UniqueRightDivide( SyzygiesOfRows( deduped_1_1 ) * AsHomalgMatrix( mu_1 ), SyzygiesOfRows( deduped_2_1 ) ), AsCapCategoryObject( cat_1, deduped_4_1 - RowRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddEvaluationForDual( cat,
        
########
function ( cat_1, a_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToColumn( HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, 1 ) );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.EvaluationForDual :=
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := AsInteger( a_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_1_1 * deduped_1_1 ), ConvertMatrixToColumn( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ) ), AsCapCategoryObject( cat_1, 1 ) );
end
########
        
    ;
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, ConvertMatrixToColumn( HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ) ), r_1 );
end
########
        
    , 100 );
    
    ##
    AddFiberProduct( cat,
        
########
function ( cat_1, morphisms_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := Length( morphisms_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_5_1 := Sum( deduped_6_1 );
    deduped_4_1 := List( [ 1 .. deduped_8_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_6_1[i_2];
            return UnionOfRows( deduped_7_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_6_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_7_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_7_1 ), HomalgZeroMatrix( Sum( deduped_6_1{[ (i_2 + 1) .. deduped_8_1 ]} ), deduped_1_2, deduped_7_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) );
        end );
    return AsCapCategoryObject( cat_1, deduped_5_1 - RowRankOfMatrix( (UnionOfColumns( deduped_7_1, deduped_5_1, deduped_4_1{[ 1 .. deduped_8_1 - 1 ]} ) - UnionOfColumns( deduped_7_1, deduped_5_1, deduped_4_1{[ 2 .. deduped_8_1 ]} )) ) );
end
########
        
    , 4331 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.FiberProduct :=
        
########
function ( cat_1, morphisms_1 )
    local hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphisms_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    hoisted_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return UnionOfRows( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_1_2, deduped_8_1 ) ] ) * hoisted_4_1[i_2];
        end );
    return AsCapCategoryObject( cat_1, deduped_6_1 - RowRankOfMatrix( (UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} )) ) );
end
########
        
    ;
    
    ##
    AddFiberProductFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local hoisted_4_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := Length( morphismsp_1 );
    deduped_16_1 := Length( morphisms_1 );
    deduped_15_1 := UnderlyingRing( cat_1 );
    deduped_14_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_13_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_12_1 := Sum( deduped_14_1 );
    deduped_11_1 := Sum( deduped_13_1 );
    deduped_10_1 := List( [ 1 .. deduped_17_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_14_1[i_2];
            return UnionOfRows( deduped_15_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_14_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_15_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_15_1 ), HomalgZeroMatrix( Sum( deduped_14_1{[ (i_2 + 1) .. deduped_17_1 ]} ), deduped_1_2, deduped_15_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphismsp_1[i_2] ) ) );
        end );
    deduped_9_1 := List( [ 1 .. deduped_16_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_13_1[i_2];
            return UnionOfRows( deduped_15_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_13_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_15_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_15_1 ), HomalgZeroMatrix( Sum( deduped_13_1{[ (i_2 + 1) .. deduped_16_1 ]} ), deduped_1_2, deduped_15_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) );
        end );
    deduped_8_1 := UnionOfColumns( deduped_15_1, deduped_11_1, deduped_9_1{[ 1 .. deduped_16_1 - 1 ]} ) - UnionOfColumns( deduped_15_1, deduped_11_1, deduped_9_1{[ 2 .. deduped_16_1 ]} );
    hoisted_4_1 := SyzygiesOfRows( deduped_8_1 );
    deduped_7_1 := UniqueRightDivide( UnionOfColumns( deduped_15_1, deduped_11_1 - RowRankOfMatrix( deduped_8_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( deduped_13_1{[ 1 .. i_2 - 1 ]} );
                return CertainColumns( hoisted_4_1, [ (deduped_1_2 + 1) .. (deduped_1_2 + deduped_13_1[i_2]) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( L_1[i_2] ) ) );
            end ) ), SyzygiesOfRows( UnionOfColumns( deduped_15_1, deduped_12_1, deduped_10_1{[ 1 .. deduped_17_1 - 1 ]} ) - UnionOfColumns( deduped_15_1, deduped_12_1, deduped_10_1{[ 2 .. deduped_17_1 ]} ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_7_1 ) ), deduped_7_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_7_1 ) ) );
end
########
        
    , 36252 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.FiberProductFunctorial :=
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
    deduped_21_1 := Length( morphismsp_1 );
    deduped_20_1 := Length( morphisms_1 );
    deduped_19_1 := UnderlyingRing( cat_1 );
    deduped_18_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_17_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_16_1 := Sum( deduped_18_1 );
    deduped_15_1 := Sum( deduped_17_1 );
    hoisted_9_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_14_1 := List( [ 1 .. deduped_21_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_18_1[i_2];
            return UnionOfRows( deduped_19_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_18_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_19_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_19_1 ), HomalgZeroMatrix( Sum( deduped_18_1{[ (i_2 + 1) .. deduped_21_1 ]} ), deduped_1_2, deduped_19_1 ) ] ) * hoisted_9_1[i_2];
        end );
    hoisted_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_13_1 := List( [ 1 .. deduped_20_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_17_1[i_2];
            return UnionOfRows( deduped_19_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_17_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_19_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_19_1 ), HomalgZeroMatrix( Sum( deduped_17_1{[ (i_2 + 1) .. deduped_20_1 ]} ), deduped_1_2, deduped_19_1 ) ] ) * hoisted_4_1[i_2];
        end );
    deduped_12_1 := UnionOfColumns( deduped_19_1, deduped_16_1, deduped_14_1{[ 1 .. deduped_21_1 - 1 ]} ) - UnionOfColumns( deduped_19_1, deduped_16_1, deduped_14_1{[ 2 .. deduped_21_1 ]} );
    deduped_11_1 := UnionOfColumns( deduped_19_1, deduped_15_1, deduped_13_1{[ 1 .. deduped_20_1 - 1 ]} ) - UnionOfColumns( deduped_19_1, deduped_15_1, deduped_13_1{[ 2 .. deduped_20_1 ]} );
    deduped_10_1 := deduped_15_1 - RowRankOfMatrix( deduped_11_1 );
    hoisted_6_1 := List( L_1, AsHomalgMatrix );
    hoisted_5_1 := SyzygiesOfRows( deduped_11_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_10_1 ), UniqueRightDivide( UnionOfColumns( deduped_19_1, deduped_10_1, List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := Sum( deduped_17_1{[ 1 .. i_2 - 1 ]} );
                  return CertainColumns( hoisted_5_1, [ (deduped_1_2 + 1) .. (deduped_1_2 + deduped_17_1[i_2]) ] ) * hoisted_6_1[i_2];
              end ) ), SyzygiesOfRows( deduped_12_1 ) ), AsCapCategoryObject( cat_1, deduped_16_1 - RowRankOfMatrix( deduped_12_1 ) ) );
end
########
        
    ;
    
    ##
    AddFiberProductFunctorialWithGivenFiberProducts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local hoisted_4_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1;
    deduped_16_1 := Length( morphisms_1 );
    deduped_15_1 := Length( morphismsp_1 );
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_12_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_11_1 := Sum( deduped_13_1 );
    deduped_10_1 := Sum( deduped_12_1 );
    deduped_9_1 := List( [ 1 .. deduped_16_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_13_1[i_2];
            return UnionOfRows( deduped_14_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_13_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_14_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_14_1 ), HomalgZeroMatrix( Sum( deduped_13_1{[ (i_2 + 1) .. deduped_16_1 ]} ), deduped_1_2, deduped_14_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) );
        end );
    deduped_8_1 := List( [ 1 .. deduped_15_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_12_1[i_2];
            return UnionOfRows( deduped_14_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_12_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_14_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_14_1 ), HomalgZeroMatrix( Sum( deduped_12_1{[ (i_2 + 1) .. deduped_15_1 ]} ), deduped_1_2, deduped_14_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphismsp_1[i_2] ) ) );
        end );
    hoisted_4_1 := SyzygiesOfRows( UnionOfColumns( deduped_14_1, deduped_11_1, deduped_9_1{[ 1 .. deduped_16_1 - 1 ]} ) - UnionOfColumns( deduped_14_1, deduped_11_1, deduped_9_1{[ 2 .. deduped_16_1 ]} ) );
    deduped_7_1 := UniqueRightDivide( UnionOfColumns( deduped_14_1, AsInteger( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( deduped_13_1{[ 1 .. i_2 - 1 ]} );
                return CertainColumns( hoisted_4_1, [ (deduped_1_2 + 1) .. (deduped_1_2 + deduped_13_1[i_2]) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( L_1[i_2] ) ) );
            end ) ), SyzygiesOfRows( UnionOfColumns( deduped_14_1, deduped_10_1, deduped_8_1{[ 1 .. deduped_15_1 - 1 ]} ) - UnionOfColumns( deduped_14_1, deduped_10_1, deduped_8_1{[ 2 .. deduped_15_1 ]} ) ) );
    return AsCapCategoryMorphism( cat_1, P_1, deduped_7_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_7_1 ) ) );
end
########
        
    , 27589 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.FiberProductFunctorialWithGivenFiberProducts :=
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
    deduped_19_1 := Length( morphisms_1 );
    deduped_18_1 := Length( morphismsp_1 );
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_15_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_14_1 := Sum( deduped_16_1 );
    deduped_13_1 := Sum( deduped_15_1 );
    hoisted_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_12_1 := List( [ 1 .. deduped_19_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_16_1[i_2];
            return UnionOfRows( deduped_17_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_16_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_17_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_17_1 ), HomalgZeroMatrix( Sum( deduped_16_1{[ (i_2 + 1) .. deduped_19_1 ]} ), deduped_1_2, deduped_17_1 ) ] ) * hoisted_4_1[i_2];
        end );
    hoisted_9_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_11_1 := List( [ 1 .. deduped_18_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_15_1[i_2];
            return UnionOfRows( deduped_17_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_15_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_17_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_17_1 ), HomalgZeroMatrix( Sum( deduped_15_1{[ (i_2 + 1) .. deduped_18_1 ]} ), deduped_1_2, deduped_17_1 ) ] ) * hoisted_9_1[i_2];
        end );
    deduped_10_1 := UnionOfColumns( deduped_17_1, deduped_13_1, deduped_11_1{[ 1 .. deduped_18_1 - 1 ]} ) - UnionOfColumns( deduped_17_1, deduped_13_1, deduped_11_1{[ 2 .. deduped_18_1 ]} );
    hoisted_6_1 := List( L_1, AsHomalgMatrix );
    hoisted_5_1 := SyzygiesOfRows( UnionOfColumns( deduped_17_1, deduped_14_1, deduped_12_1{[ 1 .. deduped_19_1 - 1 ]} ) - UnionOfColumns( deduped_17_1, deduped_14_1, deduped_12_1{[ 2 .. deduped_19_1 ]} ) );
    return AsCapCategoryMorphism( cat_1, P_1, UniqueRightDivide( UnionOfColumns( deduped_17_1, AsInteger( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := Sum( deduped_16_1{[ 1 .. i_2 - 1 ]} );
                  return CertainColumns( hoisted_5_1, [ (deduped_1_2 + 1) .. (deduped_1_2 + deduped_16_1[i_2]) ] ) * hoisted_6_1[i_2];
              end ) ), SyzygiesOfRows( deduped_10_1 ) ), AsCapCategoryObject( cat_1, deduped_13_1 - RowRankOfMatrix( deduped_10_1 ) ) );
end
########
        
    ;
    
    ##
    AddHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryObject( cat_1, RowRankOfMatrix( SyzygiesOfRows( AsHomalgMatrix( beta_1 ) ) * SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) ) ) );
end
########
        
    , 502 : IsPrecompiledDerivation := true );
    
    ##
    AddHomologyObjectFunctorialWithGivenHomologyObjects( cat,
        
########
function ( cat_1, H_1_1, L_1, H_2_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( AsHomalgMatrix( L_1[4] ) );
    deduped_1_1 := SyzygiesOfColumns( AsHomalgMatrix( L_1[1] ) );
    return AsCapCategoryMorphism( cat_1, H_1_1, UniqueRightDivide( BasisOfRows( SyzygiesOfRows( AsHomalgMatrix( L_1[2] ) ) * deduped_1_1 ) * UniqueLeftDivide( deduped_1_1, (AsHomalgMatrix( L_1[3] ) * deduped_2_1) ), BasisOfRows( SyzygiesOfRows( AsHomalgMatrix( L_1[5] ) ) * deduped_2_1 ) ), H_2_1 );
end
########
        
    , 3212 : IsPrecompiledDerivation := true );
    
    ##
    AddHomomorphismStructureOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( beta_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.HomomorphismStructureOnMorphisms :=
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, AsInteger( Range( alpha_1 ) ) * AsInteger( Source( beta_1 ) ) ), KroneckerMat( TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( beta_1 ) ), AsCapCategoryObject( cat_1, AsInteger( Source( alpha_1 ) ) * AsInteger( Range( beta_1 ) ) ) );
end
########
        
    ;
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return AsCapCategoryMorphism( cat_1, source_1, KroneckerMat( TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( beta_1 ) ), range_1 );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return AsCapCategoryObject( cat_1, AsInteger( arg2_1 ) * AsInteger( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 100 );
    
    ##
    AddImageEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := BasisOfRows( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Range( alpha_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ImageEmbedding :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, RowRankOfMatrix( deduped_1_1 ) ), BasisOfRows( deduped_1_1 ), Range( alpha_1 ) );
end
########
        
    ;
    
    ##
    AddImageEmbeddingWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    return AsCapCategoryMorphism( cat_1, I_1, BasisOfRows( AsHomalgMatrix( alpha_1 ) ), Range( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddImageObject( cat,
        
########
function ( cat_1, arg2_1 )
    return AsCapCategoryObject( cat_1, RowRankOfMatrix( AsHomalgMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddImageObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, nu_1, alphap_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueRightDivide( BasisOfRows( AsHomalgMatrix( alpha_1 ) ) * AsHomalgMatrix( nu_1 ), BasisOfRows( AsHomalgMatrix( alphap_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 602 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ImageObjectFunctorial :=
        
########
function ( cat_1, alpha_1, nu_1, alphap_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alphap_1 );
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, RowRankOfMatrix( deduped_1_1 ) ), UniqueRightDivide( BasisOfRows( deduped_1_1 ) * AsHomalgMatrix( nu_1 ), BasisOfRows( deduped_2_1 ) ), AsCapCategoryObject( cat_1, RowRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddImageObjectFunctorialWithGivenImageObjects( cat,
        
########
function ( cat_1, I_1, alpha_1, nu_1, alphap_1, Ip_1 )
    return AsCapCategoryMorphism( cat_1, I_1, UniqueRightDivide( BasisOfRows( AsHomalgMatrix( alpha_1 ) ) * AsHomalgMatrix( nu_1 ), BasisOfRows( AsHomalgMatrix( alphap_1 ) ) ), Ip_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddInitialObject( cat,
        
########
function ( cat_1 )
    return AsCapCategoryObject( cat_1, 0 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddInitialObjectFunctorial( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := AsCapCategoryObject( cat_1, 0 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddInitialObjectFunctorialWithGivenInitialObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return AsCapCategoryMorphism( cat_1, P_1, HomalgZeroMatrix( AsInteger( P_1 ), AsInteger( Pp_1 ), UnderlyingRing( cat_1 ) ), Pp_1 );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := List( objects_1, AsInteger );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := deduped_4_1[k_1];
    morphism_attr_1_1 := UnionOfColumns( deduped_3_1, deduped_2_1, [ HomalgZeroMatrix( deduped_2_1, Sum( deduped_4_1{[ 1 .. k_1 - 1 ]} ), deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( deduped_2_1, Sum( deduped_4_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_3_1 ) ] );
    return AsCapCategoryMorphism( cat_1, objects_1[k_1], morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InjectionOfCofactorOfCoproduct :=
        
########
function ( cat_1, objects_1, k_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := List( objects_1, AsInteger );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := deduped_3_1[k_1];
    return AsCapCategoryMorphism( cat_1, objects_1[k_1], UnionOfColumns( deduped_2_1, deduped_1_1, [ HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1 ) ] ), AsCapCategoryObject( cat_1, Sum( deduped_3_1 ) ) );
end
########
        
    ;
    
    ##
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := List( objects_1, AsInteger );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := deduped_4_1[k_1];
    morphism_attr_1_1 := UnionOfColumns( deduped_3_1, deduped_2_1, [ HomalgZeroMatrix( deduped_2_1, Sum( deduped_4_1{[ 1 .. k_1 - 1 ]} ), deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( deduped_2_1, Sum( deduped_4_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_3_1 ) ] );
    return AsCapCategoryMorphism( cat_1, objects_1[k_1], morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 505 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InjectionOfCofactorOfCoproductWithGivenCoproduct :=
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := List( objects_1, AsInteger );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := deduped_3_1[k_1];
    return AsCapCategoryMorphism( cat_1, objects_1[k_1], UnionOfColumns( deduped_2_1, deduped_1_1, [ HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1 ) ] ), AsCapCategoryObject( cat_1, Sum( deduped_3_1 ) ) );
end
########
        
    ;
    
    ##
    AddInjectionOfCofactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := List( objects_1, AsInteger );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := deduped_4_1[k_1];
    morphism_attr_1_1 := UnionOfColumns( deduped_3_1, deduped_2_1, [ HomalgZeroMatrix( deduped_2_1, Sum( deduped_4_1{[ 1 .. k_1 - 1 ]} ), deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( deduped_2_1, Sum( deduped_4_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_3_1 ) ] );
    return AsCapCategoryMorphism( cat_1, objects_1[k_1], morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InjectionOfCofactorOfDirectSum :=
        
########
function ( cat_1, objects_1, k_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := List( objects_1, AsInteger );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := deduped_3_1[k_1];
    return AsCapCategoryMorphism( cat_1, objects_1[k_1], UnionOfColumns( deduped_2_1, deduped_1_1, [ HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1 ) ] ), AsCapCategoryObject( cat_1, Sum( deduped_3_1 ) ) );
end
########
        
    ;
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := List( objects_1, AsInteger );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := deduped_3_1[k_1];
    return AsCapCategoryMorphism( cat_1, objects_1[k_1], UnionOfColumns( deduped_2_1, deduped_1_1, [ HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1 ) ] ), P_1 );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    deduped_6_1 := Sum( deduped_8_1{[ 1 .. k_1 - 1 ]} );
    deduped_5_1 := List( [ 1 .. deduped_10_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_8_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) ) * UnionOfColumns( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ 1 .. (i_2 - 1) ]} ), deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ (i_2 + 1) .. deduped_10_1 ]} ), deduped_9_1 ) ] );
        end );
    deduped_4_1 := CertainRows( SyzygiesOfColumns( UnionOfRows( deduped_9_1, deduped_7_1, deduped_5_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_5_1{[ 2 .. deduped_10_1 ]} ) ), [ deduped_6_1 + 1 .. deduped_6_1 + deduped_8_1[k_1] ] );
    return AsCapCategoryMorphism( cat_1, CAP_JIT_INCOMPLETE_LOGIC( Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[k_1] ) ) ), deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 9079 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InjectionOfCofactorOfPushout :=
        
########
function ( cat_1, morphisms_1, k_1 )
    local hoisted_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} );
    hoisted_1_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return hoisted_1_1[i_2] * UnionOfColumns( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_10_1 ) ] );
        end );
    deduped_5_1 := UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} );
    return AsCapCategoryMorphism( cat_1, List( morphisms_1, Range )[k_1], CertainRows( SyzygiesOfColumns( deduped_5_1 ), [ deduped_7_1 + 1 .. deduped_7_1 + deduped_9_1[k_1] ] ), AsCapCategoryObject( cat_1, deduped_8_1 - RowRankOfMatrix( deduped_5_1 ) ) );
end
########
        
    ;
    
    ##
    AddInjectionOfCofactorOfPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    deduped_6_1 := Sum( deduped_8_1{[ 1 .. k_1 - 1 ]} );
    deduped_5_1 := List( [ 1 .. deduped_10_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_8_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) ) * UnionOfColumns( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ 1 .. (i_2 - 1) ]} ), deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ (i_2 + 1) .. deduped_10_1 ]} ), deduped_9_1 ) ] );
        end );
    deduped_4_1 := CertainRows( SyzygiesOfColumns( UnionOfRows( deduped_9_1, deduped_7_1, deduped_5_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_5_1{[ 2 .. deduped_10_1 ]} ) ), [ deduped_6_1 + 1 .. deduped_6_1 + deduped_8_1[k_1] ] );
    return AsCapCategoryMorphism( cat_1, CAP_JIT_INCOMPLETE_LOGIC( Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[k_1] ) ) ), deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 9080 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InjectionOfCofactorOfPushoutWithGivenPushout :=
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local hoisted_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} );
    hoisted_1_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return hoisted_1_1[i_2] * UnionOfColumns( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_10_1 ) ] );
        end );
    deduped_5_1 := UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfRows( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} );
    return AsCapCategoryMorphism( cat_1, List( morphisms_1, Range )[k_1], CertainRows( SyzygiesOfColumns( deduped_5_1 ), [ deduped_7_1 + 1 .. deduped_7_1 + deduped_9_1[k_1] ] ), AsCapCategoryObject( cat_1, deduped_8_1 - RowRankOfMatrix( deduped_5_1 ) ) );
end
########
        
    ;
    
    ##
    AddInjectiveColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, Range( alpha_1 ), SafeLeftDivide( AsHomalgMatrix( alpha_1 ), AsHomalgMatrix( beta_1 ) ), Range( beta_1 ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( AsHomalgMatrix( beta_1 ) ), AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 2211 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalCoHomOnMorphisms :=
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, AsInteger( Source( alpha_1 ) ) * AsInteger( Range( beta_1 ) ) ), KroneckerMat( TransposedMatrix( AsHomalgMatrix( beta_1 ) ), AsHomalgMatrix( alpha_1 ) ), AsCapCategoryObject( cat_1, AsInteger( Range( alpha_1 ) ) * AsInteger( Source( beta_1 ) ) ) );
end
########
        
    ;
    
    ##
    AddInternalCoHomOnMorphismsWithGivenInternalCoHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( TransposedMatrix( AsHomalgMatrix( beta_1 ) ), AsHomalgMatrix( alpha_1 ) ), r_1 );
end
########
        
    , 1606 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    return AsCapCategoryObject( cat_1, AsInteger( a_1 ) * AsInteger( b_1 ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphism( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := List( list_1, AsInteger );
    deduped_26_1 := deduped_27_1[2];
    deduped_25_1 := deduped_27_1[1];
    deduped_24_1 := deduped_27_1[4];
    deduped_23_1 := deduped_27_1[3];
    deduped_22_1 := deduped_25_1 * deduped_23_1;
    deduped_21_1 := HomalgIdentityMatrix( deduped_23_1, deduped_28_1 );
    deduped_20_1 := deduped_26_1 * deduped_24_1;
    deduped_19_1 := HomalgIdentityMatrix( deduped_24_1, deduped_28_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_25_1, deduped_28_1 );
    deduped_17_1 := deduped_23_1 * deduped_24_1;
    deduped_16_1 := deduped_17_1 * deduped_17_1;
    deduped_15_1 := deduped_22_1 * deduped_20_1;
    deduped_14_1 := deduped_23_1 * deduped_20_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_22_1, deduped_28_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_20_1, deduped_28_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_17_1, deduped_28_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_15_1, deduped_28_1 );
    deduped_9_1 := deduped_15_1 * deduped_17_1;
    morphism_attr_1_1 := KroneckerMat( deduped_11_1, KroneckerMat( deduped_18_1, KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_28_1 ), ConvertMatrixToRow( deduped_19_1 ) ) * KroneckerMat( CertainRows( deduped_12_1, List( [ 1 .. deduped_20_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_24_1 ) * deduped_26_1 + QUO_INT( deduped_1_2, deduped_24_1 ) + 1);
                        end ) ), deduped_19_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_18_1, ConvertMatrixToRow( deduped_21_1 ) ) * KroneckerMat( CertainRows( deduped_13_1, List( [ 1 .. deduped_22_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_25_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                          end ) ), deduped_21_1 )), deduped_12_1 ), deduped_19_1 ) * KroneckerMat( KroneckerMat( deduped_13_1, CertainRows( HomalgIdentityMatrix( deduped_14_1, deduped_28_1 ), List( [ 1 .. deduped_14_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                    end ) ) ), deduped_19_1 ) ) * (KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_28_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                  end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_16_1, deduped_28_1 ), List( [ 1 .. deduped_16_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                  end ) ), deduped_10_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_11_1 ), deduped_10_1 ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 15660 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalCoHomTensorProductCompatibilityMorphism :=
        
########
function ( cat_1, list_1 )
    local deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    deduped_26_1 := List( list_1, AsInteger );
    deduped_25_1 := deduped_26_1[4];
    deduped_24_1 := deduped_26_1[3];
    deduped_23_1 := deduped_26_1[2];
    deduped_22_1 := deduped_26_1[1];
    deduped_21_1 := deduped_22_1 * deduped_24_1;
    deduped_20_1 := HomalgIdentityMatrix( deduped_24_1, deduped_27_1 );
    deduped_19_1 := deduped_23_1 * deduped_25_1;
    deduped_18_1 := HomalgIdentityMatrix( deduped_25_1, deduped_27_1 );
    deduped_17_1 := HomalgIdentityMatrix( deduped_22_1, deduped_27_1 );
    deduped_16_1 := deduped_24_1 * deduped_25_1;
    deduped_15_1 := deduped_16_1 * deduped_16_1;
    deduped_14_1 := deduped_21_1 * deduped_19_1;
    deduped_13_1 := deduped_24_1 * deduped_19_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_21_1, deduped_27_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_19_1, deduped_27_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_16_1, deduped_27_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_14_1, deduped_27_1 );
    deduped_8_1 := deduped_14_1 * deduped_16_1;
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_22_1 * deduped_23_1 * deduped_16_1 ), KroneckerMat( deduped_10_1, KroneckerMat( deduped_17_1, KroneckerMat( HomalgIdentityMatrix( deduped_23_1, deduped_27_1 ), ConvertMatrixToRow( deduped_18_1 ) ) * KroneckerMat( CertainRows( deduped_11_1, List( [ 1 .. deduped_19_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_25_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_25_1 ) + 1);
                          end ) ), deduped_18_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_17_1, ConvertMatrixToRow( deduped_20_1 ) ) * KroneckerMat( CertainRows( deduped_12_1, List( [ 1 .. deduped_21_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_24_1 ) * deduped_22_1 + QUO_INT( deduped_1_2, deduped_24_1 ) + 1);
                            end ) ), deduped_20_1 )), deduped_11_1 ), deduped_18_1 ) * KroneckerMat( KroneckerMat( deduped_12_1, CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_27_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_24_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                      end ) ) ), deduped_18_1 ) ) * (KroneckerMat( deduped_10_1, CertainRows( HomalgIdentityMatrix( deduped_8_1, deduped_27_1 ), List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_15_1, deduped_27_1 ), List( [ 1 .. deduped_15_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                    end ) ), deduped_9_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_10_1 ), deduped_9_1 )), AsCapCategoryObject( cat_1, deduped_14_1 ) );
end
########
        
    ;
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphismInverse( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := List( list_1, AsInteger );
    deduped_26_1 := deduped_27_1[4];
    deduped_25_1 := deduped_27_1[2];
    deduped_24_1 := deduped_27_1[3];
    deduped_23_1 := deduped_27_1[1];
    deduped_22_1 := HomalgIdentityMatrix( deduped_24_1, deduped_28_1 );
    deduped_21_1 := HomalgIdentityMatrix( deduped_26_1, deduped_28_1 );
    deduped_20_1 := HomalgIdentityMatrix( deduped_23_1, deduped_28_1 );
    deduped_19_1 := deduped_24_1 * deduped_26_1;
    deduped_18_1 := deduped_25_1 * deduped_26_1;
    deduped_17_1 := deduped_23_1 * deduped_24_1;
    deduped_16_1 := deduped_19_1 * deduped_19_1;
    deduped_15_1 := deduped_24_1 * deduped_18_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_17_1, deduped_28_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_18_1, deduped_28_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_19_1, deduped_28_1 );
    deduped_11_1 := deduped_17_1 * deduped_18_1;
    deduped_10_1 := deduped_11_1 * deduped_19_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_11_1, deduped_28_1 );
    morphism_attr_1_1 := UniqueRightDivide( deduped_9_1, KroneckerMat( deduped_12_1, KroneckerMat( deduped_20_1, KroneckerMat( HomalgIdentityMatrix( deduped_25_1, deduped_28_1 ), ConvertMatrixToRow( deduped_21_1 ) ) * KroneckerMat( CertainRows( deduped_13_1, List( [ 1 .. deduped_18_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_26_1 ) * deduped_25_1 + QUO_INT( deduped_1_2, deduped_26_1 ) + 1);
                          end ) ), deduped_21_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_20_1, ConvertMatrixToRow( deduped_22_1 ) ) * KroneckerMat( CertainRows( deduped_14_1, List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_24_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_24_1 ) + 1);
                            end ) ), deduped_22_1 )), deduped_13_1 ), deduped_21_1 ) * KroneckerMat( KroneckerMat( deduped_14_1, CertainRows( HomalgIdentityMatrix( deduped_15_1, deduped_28_1 ), List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_24_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                      end ) ) ), deduped_21_1 ) ) * (KroneckerMat( deduped_12_1, CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_28_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_16_1, deduped_28_1 ), List( [ 1 .. deduped_16_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                    end ) ), deduped_9_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_12_1 ), deduped_9_1 )) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 15862 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalCoHomTensorProductCompatibilityMorphismInverse :=
        
########
function ( cat_1, list_1 )
    local deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    deduped_26_1 := List( list_1, AsInteger );
    deduped_25_1 := deduped_26_1[4];
    deduped_24_1 := deduped_26_1[2];
    deduped_23_1 := deduped_26_1[3];
    deduped_22_1 := deduped_26_1[1];
    deduped_21_1 := HomalgIdentityMatrix( deduped_23_1, deduped_27_1 );
    deduped_20_1 := HomalgIdentityMatrix( deduped_25_1, deduped_27_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_22_1, deduped_27_1 );
    deduped_18_1 := deduped_23_1 * deduped_25_1;
    deduped_17_1 := deduped_24_1 * deduped_25_1;
    deduped_16_1 := deduped_22_1 * deduped_23_1;
    deduped_15_1 := deduped_18_1 * deduped_18_1;
    deduped_14_1 := deduped_23_1 * deduped_17_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_16_1, deduped_27_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_17_1, deduped_27_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_18_1, deduped_27_1 );
    deduped_10_1 := deduped_16_1 * deduped_17_1;
    deduped_9_1 := deduped_10_1 * deduped_18_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_10_1, deduped_27_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_10_1 ), UniqueRightDivide( deduped_8_1, KroneckerMat( deduped_11_1, KroneckerMat( deduped_19_1, KroneckerMat( HomalgIdentityMatrix( deduped_24_1, deduped_27_1 ), ConvertMatrixToRow( deduped_20_1 ) ) * KroneckerMat( CertainRows( deduped_12_1, List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_25_1 ) * deduped_24_1 + QUO_INT( deduped_1_2, deduped_25_1 ) + 1);
                            end ) ), deduped_20_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_19_1, ConvertMatrixToRow( deduped_21_1 ) ) * KroneckerMat( CertainRows( deduped_13_1, List( [ 1 .. deduped_16_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_22_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                              end ) ), deduped_21_1 )), deduped_12_1 ), deduped_20_1 ) * KroneckerMat( KroneckerMat( deduped_13_1, CertainRows( HomalgIdentityMatrix( deduped_14_1, deduped_27_1 ), List( [ 1 .. deduped_14_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                        end ) ) ), deduped_20_1 ) ) * (KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_27_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                      end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_15_1, deduped_27_1 ), List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                      end ) ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_11_1 ), deduped_8_1 )) ), AsCapCategoryObject( cat_1, deduped_22_1 * deduped_24_1 * deduped_18_1 ) );
end
########
        
    ;
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := List( list_1, AsInteger );
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_25_1 := AsInteger( source_1 );
    deduped_24_1 := deduped_27_1[2];
    deduped_23_1 := deduped_27_1[1];
    deduped_22_1 := deduped_27_1[4];
    deduped_21_1 := deduped_27_1[3];
    deduped_20_1 := HomalgIdentityMatrix( deduped_25_1, deduped_26_1 );
    deduped_19_1 := deduped_23_1 * deduped_21_1;
    deduped_18_1 := HomalgIdentityMatrix( deduped_21_1, deduped_26_1 );
    deduped_17_1 := deduped_24_1 * deduped_22_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_22_1, deduped_26_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_23_1, deduped_26_1 );
    deduped_14_1 := deduped_21_1 * deduped_22_1;
    deduped_13_1 := deduped_14_1 * deduped_14_1;
    deduped_12_1 := deduped_25_1 * deduped_14_1;
    deduped_11_1 := deduped_21_1 * deduped_17_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_19_1, deduped_26_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_17_1, deduped_26_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_14_1, deduped_26_1 );
    return AsCapCategoryMorphism( cat_1, source_1, UniqueRightDivide( deduped_20_1, KroneckerMat( deduped_8_1, KroneckerMat( deduped_15_1, KroneckerMat( HomalgIdentityMatrix( deduped_24_1, deduped_26_1 ), ConvertMatrixToRow( deduped_16_1 ) ) * KroneckerMat( CertainRows( deduped_9_1, List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_22_1 ) * deduped_24_1 + QUO_INT( deduped_1_2, deduped_22_1 ) + 1);
                            end ) ), deduped_16_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_15_1, ConvertMatrixToRow( deduped_18_1 ) ) * KroneckerMat( CertainRows( deduped_10_1, List( [ 1 .. deduped_19_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, deduped_21_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_21_1 ) + 1);
                              end ) ), deduped_18_1 )), deduped_9_1 ), deduped_16_1 ) * KroneckerMat( KroneckerMat( deduped_10_1, CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_26_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_21_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                        end ) ) ), deduped_16_1 ) ) * (KroneckerMat( deduped_8_1, CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_26_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_25_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                      end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_26_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                      end ) ), deduped_20_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_8_1 ), deduped_20_1 )) ), range_1 );
end
########
        
    , 14655 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := AsInteger( range_1 );
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_25_1 := List( list_1, AsInteger );
    deduped_24_1 := HomalgIdentityMatrix( deduped_27_1, deduped_26_1 );
    deduped_23_1 := deduped_25_1[2];
    deduped_22_1 := deduped_25_1[1];
    deduped_21_1 := deduped_25_1[4];
    deduped_20_1 := deduped_25_1[3];
    deduped_19_1 := deduped_22_1 * deduped_20_1;
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_26_1 );
    deduped_17_1 := deduped_23_1 * deduped_21_1;
    deduped_16_1 := HomalgIdentityMatrix( deduped_21_1, deduped_26_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_22_1, deduped_26_1 );
    deduped_14_1 := deduped_20_1 * deduped_21_1;
    deduped_13_1 := deduped_14_1 * deduped_14_1;
    deduped_12_1 := deduped_27_1 * deduped_14_1;
    deduped_11_1 := deduped_20_1 * deduped_17_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_19_1, deduped_26_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_17_1, deduped_26_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_14_1, deduped_26_1 );
    return AsCapCategoryMorphism( cat_1, source_1, KroneckerMat( deduped_8_1, KroneckerMat( deduped_15_1, KroneckerMat( HomalgIdentityMatrix( deduped_23_1, deduped_26_1 ), ConvertMatrixToRow( deduped_16_1 ) ) * KroneckerMat( CertainRows( deduped_9_1, List( [ 1 .. deduped_17_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_21_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_21_1 ) + 1);
                          end ) ), deduped_16_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_15_1, ConvertMatrixToRow( deduped_18_1 ) ) * KroneckerMat( CertainRows( deduped_10_1, List( [ 1 .. deduped_19_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_22_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                            end ) ), deduped_18_1 )), deduped_9_1 ), deduped_16_1 ) * KroneckerMat( KroneckerMat( deduped_10_1, CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_26_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                      end ) ) ), deduped_16_1 ) ) * (KroneckerMat( deduped_8_1, CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_26_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_27_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_26_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_24_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_8_1 ), deduped_24_1 )), range_1 );
end
########
        
    , 14453 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomToTensorProductLeftAdjunctMorphism( cat,
        
########
function ( cat_1, a_1, c_1, f_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( c_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := AsInteger( a_1 );
    deduped_5_1 := deduped_6_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_7_1 );
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_7_1 ), ConvertMatrixToRow( deduped_4_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_7_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                end ) ), deduped_4_1 ) * KroneckerMat( AsHomalgMatrix( f_1 ), deduped_4_1 );
    return AsCapCategoryMorphism( cat_1, a_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 3413 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalCoHomToTensorProductLeftAdjunctMorphism :=
        
########
function ( cat_1, a_1, c_1, f_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := AsInteger( c_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( a_1 );
    deduped_4_1 := deduped_5_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, a_1, KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), ConvertMatrixToRow( deduped_3_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_3_1 ) * KroneckerMat( AsHomalgMatrix( f_1 ), deduped_3_1 ), AsCapCategoryObject( cat_1, AsInteger( Range( f_1 ) ) * deduped_7_1 ) );
end
########
        
    ;
    
    ##
    AddInternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, c_1, f_1, t_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := AsInteger( c_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( a_1 );
    deduped_4_1 := deduped_5_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, a_1, KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_6_1 ), ConvertMatrixToRow( deduped_3_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_3_1 ) * KroneckerMat( AsHomalgMatrix( f_1 ), deduped_3_1 ), t_1 );
end
########
        
    , 3312 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomToTensorProductRightAdjunctMorphism( cat,
        
########
function ( cat_1, a_1, b_1, f_1 )
    local morphism_attr_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := AsInteger( b_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := AsInteger( Range( f_1 ) );
    deduped_7_1 := deduped_9_1 * deduped_11_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_11_1, deduped_10_1 );
    deduped_5_1 := deduped_8_1 * deduped_11_1;
    morphism_attr_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_9_1, deduped_10_1 ), ConvertMatrixToRow( deduped_6_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_10_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                  end ) ), deduped_6_1 ) * KroneckerMat( AsHomalgMatrix( f_1 ), deduped_6_1 ) * CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_10_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := (i_2 - 1);
                return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
            end ) );
    return AsCapCategoryMorphism( cat_1, a_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 3715 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalCoHomToTensorProductRightAdjunctMorphism :=
        
########
function ( cat_1, a_1, b_1, f_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := AsInteger( Range( f_1 ) );
    deduped_6_1 := deduped_8_1 * deduped_10_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_4_1 := deduped_7_1 * deduped_10_1;
    return AsCapCategoryMorphism( cat_1, a_1, KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_9_1 ), ConvertMatrixToRow( deduped_5_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_5_1 ) * KroneckerMat( AsHomalgMatrix( f_1 ), deduped_5_1 ) * CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_9_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
              end ) ), AsCapCategoryObject( cat_1, deduped_10_1 * deduped_7_1 ) );
end
########
        
    ;
    
    ##
    AddInternalCoHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1, f_1, t_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := AsInteger( Range( f_1 ) );
    deduped_6_1 := deduped_8_1 * deduped_10_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_4_1 := deduped_7_1 * deduped_10_1;
    return AsCapCategoryMorphism( cat_1, a_1, KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_9_1 ), ConvertMatrixToRow( deduped_5_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_5_1 ) * KroneckerMat( AsHomalgMatrix( f_1 ), deduped_5_1 ) * CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_9_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
              end ) ), t_1 );
end
########
        
    , 3614 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( beta_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 2211 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalHomOnMorphisms :=
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, AsInteger( Range( alpha_1 ) ) * AsInteger( Source( beta_1 ) ) ), KroneckerMat( TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( beta_1 ) ), AsCapCategoryObject( cat_1, AsInteger( Source( alpha_1 ) ) * AsInteger( Range( beta_1 ) ) ) );
end
########
        
    ;
    
    ##
    AddInternalHomOnMorphismsWithGivenInternalHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( TransposedMatrix( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( beta_1 ) ), r_1 );
end
########
        
    , 1606 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    return AsCapCategoryObject( cat_1, AsInteger( a_1 ) * AsInteger( b_1 ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomToTensorProductLeftAdjunctMorphism( cat,
        
########
function ( cat_1, b_1, c_1, g_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( c_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := AsInteger( b_1 );
    deduped_5_1 := deduped_6_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_7_1 );
    morphism_attr_1_1 := KroneckerMat( AsHomalgMatrix( g_1 ), deduped_4_1 ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_7_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                end ) ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_7_1 ), ConvertMatrixToColumn( deduped_4_1 ) ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, c_1 );
end
########
        
    , 3413 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalHomToTensorProductLeftAdjunctMorphism :=
        
########
function ( cat_1, b_1, c_1, g_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := AsInteger( c_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( b_1 );
    deduped_4_1 := deduped_5_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_5_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, AsInteger( Source( g_1 ) ) * deduped_5_1 ), KroneckerMat( AsHomalgMatrix( g_1 ), deduped_3_1 ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_6_1 ), ConvertMatrixToColumn( deduped_3_1 ) )), c_1 );
end
########
        
    ;
    
    ##
    AddInternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( cat,
        
########
function ( cat_1, b_1, c_1, g_1, s_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := AsInteger( c_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( b_1 );
    deduped_4_1 := deduped_5_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_5_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( AsHomalgMatrix( g_1 ), deduped_3_1 ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_6_1 ), ConvertMatrixToColumn( deduped_3_1 ) )), c_1 );
end
########
        
    , 3312 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomToTensorProductLeftAdjunctionIsomorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1;
    deduped_15_1 := AsInteger( c_1 );
    deduped_14_1 := AsInteger( b_1 );
    deduped_13_1 := AsInteger( a_1 );
    deduped_12_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_14_1, deduped_12_1 );
    deduped_10_1 := deduped_14_1 * deduped_15_1;
    deduped_9_1 := deduped_13_1 * deduped_10_1;
    hoisted_8_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_12_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
              end ) ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_12_1 ), ConvertMatrixToColumn( deduped_11_1 ) );
    hoisted_2_1 := HomalgIdentityMatrix( deduped_9_1, deduped_12_1 );
    morphism_attr_1_1 := UnionOfRows( deduped_12_1, deduped_13_1 * deduped_14_1 * deduped_15_1, List( [ 1 .. deduped_9_1 ], function ( i_2 )
              return ConvertMatrixToRow( KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_2_1, [ i_2 ] ), deduped_13_1, deduped_10_1 ), deduped_11_1 ) * hoisted_8_1 );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 8535 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalHomToTensorProductLeftAdjunctionIsomorphism :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local hoisted_1_1, hoisted_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1;
    deduped_15_1 := UnderlyingRing( cat_1 );
    deduped_14_1 := AsInteger( c_1 );
    deduped_13_1 := AsInteger( b_1 );
    deduped_12_1 := AsInteger( a_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_13_1, deduped_15_1 );
    deduped_10_1 := deduped_13_1 * deduped_14_1;
    deduped_9_1 := deduped_12_1 * deduped_13_1 * deduped_14_1;
    deduped_8_1 := deduped_12_1 * deduped_10_1;
    hoisted_7_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_15_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_13_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
              end ) ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_14_1, deduped_15_1 ), ConvertMatrixToColumn( deduped_11_1 ) );
    hoisted_1_1 := HomalgIdentityMatrix( deduped_8_1, deduped_15_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( ListWithIdenticalEntries( deduped_8_1, AsCapCategoryObject( cat_1, 1 ) ), AsInteger ) ) ), UnionOfRows( deduped_15_1, deduped_9_1, List( [ 1 .. deduped_8_1 ], function ( i_2 )
                return ConvertMatrixToRow( KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_1_1, [ i_2 ] ), deduped_12_1, deduped_10_1 ), deduped_11_1 ) * hoisted_7_1 );
            end ) ), AsCapCategoryObject( cat_1, deduped_9_1 ) );
end
########
        
    ;
    
    ##
    AddInternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1;
    deduped_15_1 := AsInteger( c_1 );
    deduped_14_1 := AsInteger( b_1 );
    deduped_13_1 := AsInteger( a_1 );
    deduped_12_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_14_1, deduped_12_1 );
    deduped_10_1 := deduped_14_1 * deduped_15_1;
    deduped_9_1 := deduped_13_1 * deduped_10_1;
    hoisted_8_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_12_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
              end ) ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_12_1 ), ConvertMatrixToColumn( deduped_11_1 ) );
    hoisted_2_1 := HomalgIdentityMatrix( deduped_9_1, deduped_12_1 );
    morphism_attr_1_1 := UnionOfRows( deduped_12_1, AsInteger( r_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
              return ConvertMatrixToRow( KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_2_1, [ i_2 ] ), deduped_13_1, deduped_10_1 ), deduped_11_1 ) * hoisted_8_1 );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, r_1 );
end
########
        
    , 7932 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local hoisted_1_1, hoisted_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1;
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := AsInteger( c_1 );
    deduped_12_1 := AsInteger( b_1 );
    deduped_11_1 := AsInteger( a_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_12_1, deduped_14_1 );
    deduped_9_1 := deduped_12_1 * deduped_13_1;
    deduped_8_1 := deduped_11_1 * deduped_9_1;
    hoisted_7_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_14_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_13_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_13_1 ) + 1);
              end ) ), deduped_10_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_13_1, deduped_14_1 ), ConvertMatrixToColumn( deduped_10_1 ) );
    hoisted_1_1 := HomalgIdentityMatrix( deduped_8_1, deduped_14_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( ListWithIdenticalEntries( deduped_8_1, AsCapCategoryObject( cat_1, 1 ) ), AsInteger ) ) ), UnionOfRows( deduped_14_1, AsInteger( r_1 ), List( [ 1 .. deduped_8_1 ], function ( i_2 )
                return ConvertMatrixToRow( KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_1_1, [ i_2 ] ), deduped_11_1, deduped_9_1 ), deduped_10_1 ) * hoisted_7_1 );
            end ) ), r_1 );
end
########
        
    ;
    
    ##
    AddInternalHomToTensorProductRightAdjunctMorphism( cat,
        
########
function ( cat_1, a_1, c_1, g_1 )
    local morphism_attr_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := AsInteger( c_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := deduped_9_1 * deduped_11_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    deduped_6_1 := AsInteger( Source( g_1 ) );
    deduped_5_1 := deduped_9_1 * deduped_6_1;
    morphism_attr_1_1 := CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_10_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := (i_2 - 1);
                return (REM_INT( deduped_1_2, deduped_6_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_6_1 ) + 1);
            end ) ) * (KroneckerMat( AsHomalgMatrix( g_1 ), deduped_7_1 ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_8_1, deduped_10_1 ), List( [ 1 .. deduped_8_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                  end ) ), deduped_7_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_11_1, deduped_10_1 ), ConvertMatrixToColumn( deduped_7_1 ) )));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, c_1 );
end
########
        
    , 3714 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalHomToTensorProductRightAdjunctMorphism :=
        
########
function ( cat_1, a_1, c_1, g_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( c_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := deduped_8_1 * deduped_10_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    deduped_5_1 := AsInteger( Source( g_1 ) );
    deduped_4_1 := deduped_8_1 * deduped_5_1;
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_4_1 ), CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_9_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_5_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_5_1 ) + 1);
              end ) ) * (KroneckerMat( AsHomalgMatrix( g_1 ), deduped_6_1 ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_6_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_10_1, deduped_9_1 ), ConvertMatrixToColumn( deduped_6_1 ) ))), c_1 );
end
########
        
    ;
    
    ##
    AddInternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, c_1, g_1, s_1 )
    local deduped_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( c_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := AsInteger( s_1 );
    deduped_5_1 := deduped_8_1 * deduped_9_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_7_1 );
    deduped_1_1 := AsInteger( Source( g_1 ) );
    return AsCapCategoryMorphism( cat_1, s_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_7_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_1_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_1_1 ) + 1);
              end ) ) * (KroneckerMat( AsHomalgMatrix( g_1 ), deduped_4_1 ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_7_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                    end ) ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_9_1, deduped_7_1 ), ConvertMatrixToColumn( deduped_4_1 ) ))), c_1 );
end
########
        
    , 3613 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomToTensorProductRightAdjunctionIsomorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_4_1, hoisted_8_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := AsInteger( c_1 );
    deduped_16_1 := AsInteger( b_1 );
    deduped_15_1 := AsInteger( a_1 );
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_15_1, deduped_14_1 );
    deduped_12_1 := deduped_15_1 * deduped_17_1;
    deduped_11_1 := deduped_15_1 * deduped_16_1;
    deduped_10_1 := deduped_16_1 * deduped_12_1;
    hoisted_9_1 := CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_14_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_16_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1;
          end ) );
    hoisted_8_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_14_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
              end ) ), deduped_13_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_14_1 ), ConvertMatrixToColumn( deduped_13_1 ) );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_10_1, deduped_14_1 );
    morphism_attr_1_1 := UnionOfRows( deduped_14_1, deduped_11_1 * deduped_17_1, List( [ 1 .. deduped_10_1 ], function ( i_2 )
              return ConvertMatrixToRow( hoisted_9_1 * (KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_4_1, [ i_2 ] ), deduped_16_1, deduped_12_1 ), deduped_13_1 ) * hoisted_8_1) );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 9137 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalHomToTensorProductRightAdjunctionIsomorphism :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local hoisted_3_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := AsInteger( c_1 );
    deduped_15_1 := AsInteger( a_1 );
    deduped_14_1 := AsInteger( b_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_15_1, deduped_17_1 );
    deduped_12_1 := deduped_15_1 * deduped_14_1;
    deduped_11_1 := deduped_15_1 * deduped_16_1;
    deduped_10_1 := deduped_12_1 * deduped_16_1;
    deduped_9_1 := deduped_14_1 * deduped_11_1;
    hoisted_8_1 := CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_17_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_14_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1;
          end ) );
    hoisted_7_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_17_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
              end ) ), deduped_13_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_16_1, deduped_17_1 ), ConvertMatrixToColumn( deduped_13_1 ) );
    hoisted_3_1 := HomalgIdentityMatrix( deduped_9_1, deduped_17_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( ListWithIdenticalEntries( deduped_9_1, AsCapCategoryObject( cat_1, 1 ) ), AsInteger ) ) ), UnionOfRows( deduped_17_1, deduped_10_1, List( [ 1 .. deduped_9_1 ], function ( i_2 )
                return ConvertMatrixToRow( hoisted_8_1 * (KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_3_1, [ i_2 ] ), deduped_14_1, deduped_11_1 ), deduped_13_1 ) * hoisted_7_1) );
            end ) ), AsCapCategoryObject( cat_1, deduped_10_1 ) );
end
########
        
    ;
    
    ##
    AddInternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_4_1, hoisted_8_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := AsInteger( c_1 );
    deduped_16_1 := AsInteger( a_1 );
    deduped_15_1 := AsInteger( b_1 );
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := deduped_16_1 * deduped_15_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_16_1, deduped_14_1 );
    deduped_11_1 := deduped_16_1 * deduped_17_1;
    deduped_10_1 := deduped_15_1 * deduped_11_1;
    hoisted_9_1 := CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_14_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_15_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1;
          end ) );
    hoisted_8_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_14_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
              end ) ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_14_1 ), ConvertMatrixToColumn( deduped_12_1 ) );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_10_1, deduped_14_1 );
    morphism_attr_1_1 := UnionOfRows( deduped_14_1, AsInteger( r_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
              return ConvertMatrixToRow( hoisted_9_1 * (KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_4_1, [ i_2 ] ), deduped_15_1, deduped_11_1 ), deduped_12_1 ) * hoisted_8_1) );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, r_1 );
end
########
        
    , 8534 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local hoisted_3_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1;
    deduped_16_1 := UnderlyingRing( cat_1 );
    deduped_15_1 := AsInteger( c_1 );
    deduped_14_1 := AsInteger( a_1 );
    deduped_13_1 := AsInteger( b_1 );
    deduped_12_1 := deduped_14_1 * deduped_13_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_14_1, deduped_16_1 );
    deduped_10_1 := deduped_14_1 * deduped_15_1;
    deduped_9_1 := deduped_13_1 * deduped_10_1;
    hoisted_8_1 := CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_16_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_13_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_13_1 ) + 1;
          end ) );
    hoisted_7_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_16_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
              end ) ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_16_1 ), ConvertMatrixToColumn( deduped_11_1 ) );
    hoisted_3_1 := HomalgIdentityMatrix( deduped_9_1, deduped_16_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( ListWithIdenticalEntries( deduped_9_1, AsCapCategoryObject( cat_1, 1 ) ), AsInteger ) ) ), UnionOfRows( deduped_16_1, AsInteger( r_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                return ConvertMatrixToRow( hoisted_8_1 * (KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_3_1, [ i_2 ] ), deduped_13_1, deduped_10_1 ), deduped_11_1 ) * hoisted_7_1) );
            end ) ), r_1 );
end
########
        
    ;
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ConvertMatrixToRow( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure :=
        
########
function ( cat_1, alpha_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 1 ), ConvertMatrixToRow( AsHomalgMatrix( alpha_1 ) ), AsCapCategoryObject( cat_1, AsInteger( Source( alpha_1 ) ) * AsInteger( Range( alpha_1 ) ) ) );
end
########
        
    ;
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    return AsCapCategoryMorphism( cat_1, source_1, ConvertMatrixToRow( AsHomalgMatrix( alpha_1 ) ), range_1 );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, source_1, range_1, alpha_1 )
    return AsCapCategoryMorphism( cat_1, source_1, ConvertRowToMatrix( AsHomalgMatrix( alpha_1 ), AsInteger( source_1 ), AsInteger( range_1 ) ), range_1 );
end
########
        
    , 100 );
    
    ##
    AddInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := Range( alpha_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, UniqueRightDivide( HomalgIdentityMatrix( AsInteger( deduped_1_1 ), UnderlyingRing( cat_1 ) ), AsHomalgMatrix( alpha_1 ) ), Source( alpha_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddInverseOfMorphismFromCoimageToImage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_3_1 ) );
    morphism_attr_1_1 := UniqueRightDivide( HomalgIdentityMatrix( RowRankOfMatrix( deduped_3_1 ), deduped_4_1 ), UniqueRightDivide( UniqueLeftDivide( BasisOfColumns( deduped_3_1 ), deduped_3_1 ), deduped_2_1 ) * UniqueRightDivide( HomalgIdentityMatrix( NumberRows( deduped_2_1 ), deduped_4_1 ), UniqueRightDivide( BasisOfRows( deduped_3_1 ), deduped_2_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1811 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InverseOfMorphismFromCoimageToImage :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := RowRankOfMatrix( deduped_3_1 );
    deduped_1_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_3_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_2_1 ), UniqueRightDivide( HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), UniqueRightDivide( UniqueLeftDivide( BasisOfColumns( deduped_3_1 ), deduped_3_1 ), deduped_1_1 ) * UniqueRightDivide( HomalgIdentityMatrix( NumberRows( deduped_1_1 ), deduped_4_1 ), UniqueRightDivide( BasisOfRows( deduped_3_1 ), deduped_1_1 ) ) ), AsCapCategoryObject( cat_1, ColumnRankOfMatrix( deduped_3_1 ) ) );
end
########
        
    ;
    
    ##
    AddInverseOfMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, I_1, alpha_1, C_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_3_1 ) );
    morphism_attr_1_1 := UniqueRightDivide( HomalgIdentityMatrix( RowRankOfMatrix( deduped_3_1 ), deduped_4_1 ), UniqueRightDivide( UniqueLeftDivide( BasisOfColumns( deduped_3_1 ), deduped_3_1 ), deduped_2_1 ) * UniqueRightDivide( HomalgIdentityMatrix( NumberRows( deduped_2_1 ), deduped_4_1 ), UniqueRightDivide( BasisOfRows( deduped_3_1 ), deduped_2_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, C_1 );
end
########
        
    , 1610 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.InverseOfMorphismFromCoimageToImageWithGivenObjects :=
        
########
function ( cat_1, I_1, alpha_1, C_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := RowRankOfMatrix( deduped_3_1 );
    deduped_1_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_3_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_2_1 ), UniqueRightDivide( HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), UniqueRightDivide( UniqueLeftDivide( BasisOfColumns( deduped_3_1 ), deduped_3_1 ), deduped_1_1 ) * UniqueRightDivide( HomalgIdentityMatrix( NumberRows( deduped_1_1 ), deduped_4_1 ), UniqueRightDivide( BasisOfRows( deduped_3_1 ), deduped_1_1 ) ) ), C_1 );
end
########
        
    ;
    
    ##
    AddIsAutomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := RowRankOfMatrix( AsHomalgMatrix( arg2_1 ) );
    deduped_2_1 := AsInteger( Range( arg2_1 ) );
    deduped_1_1 := AsInteger( Source( arg2_1 ) );
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
        
    , 3 : IsPrecompiledDerivation := true );
    
    ##
    AddIsCodominating( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( AsHomalgMatrix( arg2_1 ), AsHomalgMatrix( arg3_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( AsHomalgMatrix( arg3_1 ), AsHomalgMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsColiftableAlongEpimorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( AsHomalgMatrix( arg3_1 ), AsHomalgMatrix( arg2_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return AsHomalgMatrix( arg2_1 ) = AsHomalgMatrix( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsDominating( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( AsHomalgMatrix( arg2_1 ), AsHomalgMatrix( arg3_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEndomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return AsInteger( Source( arg2_1 ) ) = AsInteger( Range( arg2_1 ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return AsInteger( Range( arg2_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( arg2_1 ) ) = 0;
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualAsFactorobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( arg3_1 );
    deduped_1_1 := AsHomalgMatrix( arg2_1 );
    return IsZero( DecideZeroColumns( deduped_1_1, deduped_2_1 ) ) and IsZero( DecideZeroColumns( deduped_2_1, deduped_1_1 ) );
end
########
        
    , 205 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualAsSubobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( arg3_1 );
    deduped_1_1 := AsHomalgMatrix( arg2_1 );
    return IsZero( DecideZeroRows( deduped_1_1, deduped_2_1 ) ) and IsZero( DecideZeroRows( deduped_2_1, deduped_1_1 ) );
end
########
        
    , 205 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return AsHomalgMatrix( arg2_1 ) = AsHomalgMatrix( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphismsOnMor( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    if AsInteger( Source( arg2_1 ) ) = AsInteger( Source( arg3_1 ) ) and AsInteger( Range( arg2_1 ) ) = AsInteger( Range( arg3_1 ) ) then
        return AsHomalgMatrix( arg2_1 ) = AsHomalgMatrix( arg3_1 );
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
    return AsInteger( arg2_1 ) = AsInteger( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsEqualToIdentityMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := AsInteger( Source( arg2_1 ) );
    if true and AsInteger( Range( arg2_1 ) ) = deduped_1_1 then
        return AsHomalgMatrix( arg2_1 ) = HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) );
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
    return AsHomalgMatrix( arg2_1 ) = HomalgZeroMatrix( AsInteger( Source( arg2_1 ) ), AsInteger( Range( arg2_1 ) ), UnderlyingRing( cat_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsIdempotent( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := AsHomalgMatrix( arg2_1 );
    return deduped_1_1 * deduped_1_1 = deduped_1_1;
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    return AsInteger( arg2_1 ) = 0;
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
        
    , 1 );
    
    ##
    AddIsIsomorphicForObjects( cat,
        
########
function ( cat_1, object_1_1, object_2_1 )
    return AsInteger( object_1_1 ) = AsInteger( object_2_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsIsomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := RowRankOfMatrix( AsHomalgMatrix( arg2_1 ) );
    return AsInteger( Source( arg2_1 ) ) - deduped_1_1 = 0 and AsInteger( Range( arg2_1 ) ) - deduped_1_1 = 0;
end
########
        
    , 403 : IsPrecompiledDerivation := true );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( AsHomalgMatrix( arg2_1 ), AsHomalgMatrix( arg3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsLiftableAlongMonomorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( AsHomalgMatrix( arg3_1 ), AsHomalgMatrix( arg2_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return AsInteger( Source( arg2_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( arg2_1 ) ) = 0;
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsOne( cat,
        
########
function ( cat_1, arg2_1 )
    return HomalgIdentityMatrix( AsInteger( Source( arg2_1 ) ), UnderlyingRing( cat_1 ) ) = AsHomalgMatrix( arg2_1 );
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
        
    , 1 );
    
    ##
    AddIsSplitEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroRows( HomalgIdentityMatrix( AsInteger( Range( arg2_1 ) ), UnderlyingRing( cat_1 ) ), AsHomalgMatrix( arg2_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsSplitMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroColumns( HomalgIdentityMatrix( AsInteger( Source( arg2_1 ) ), UnderlyingRing( cat_1 ) ), AsHomalgMatrix( arg2_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsTerminal( cat,
        
########
function ( cat_1, arg2_1 )
    return AsInteger( arg2_1 ) = 0;
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    if not IsHomalgMatrix( deduped_1_1 ) then
        return false;
    elif not NumberRows( deduped_1_1 ) = AsInteger( Source( alpha_1 ) ) then
        return false;
    elif not NumberColumns( deduped_1_1 ) = AsInteger( Range( alpha_1 ) ) then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForMorphismsWithGivenSourceAndRange( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := AsInteger( Range( alpha_1 ) );
    deduped_1_1 := AsInteger( Source( alpha_1 ) );
    return CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                  if not IsHomalgMatrix( deduped_3_1 ) then
                      return false;
                  elif not NumberRows( deduped_3_1 ) = deduped_1_1 then
                      return false;
                  elif not NumberColumns( deduped_3_1 ) = deduped_2_1 then
                      return false;
                  else
                      return true;
                  fi;
                  return;
              end )(  ) and deduped_1_1 = AsInteger( source_1 ) and deduped_2_1 = AsInteger( range_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := AsInteger( arg2_1 );
    if not IsInt( deduped_1_1 ) then
        return false;
    elif not deduped_1_1 >= 0 then
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
    return IsZero( AsHomalgMatrix( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return AsInteger( arg2_1 ) = 0;
end
########
        
    , 100 );
    
    ##
    AddIsomorphismFromCoDualObjectToInternalCoHomFromTensorUnit( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromCoequalizerOfCoproductDiagramToPushout( cat,
        
########
function ( cat_1, D_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( D_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( D_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( D_1[i_2] ) ) ) * UnionOfColumns( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_8_1 ) ] );
        end );
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1 - RowRankOfMatrix( (UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} )) ), deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 4337 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromCoequalizerOfCoproductDiagramToPushout :=
        
########
function ( cat_1, D_1 )
    local hoisted_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( D_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( D_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    hoisted_1_1 := List( D_1, AsHomalgMatrix );
    deduped_7_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return hoisted_1_1[i_2] * UnionOfColumns( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_10_1 ) ] );
        end );
    deduped_6_1 := deduped_8_1 - RowRankOfMatrix( (UnionOfRows( deduped_10_1, deduped_8_1, deduped_7_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfRows( deduped_10_1, deduped_8_1, deduped_7_1{[ 2 .. deduped_11_1 ]} )) );
    deduped_5_1 := AsCapCategoryObject( cat_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), deduped_5_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct( cat,
        
########
function ( cat_1, A_1, D_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( D_1 );
    deduped_4_1 := List( D_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( A_1 );
    morphism_attr_1_1 := HomalgIdentityMatrix( deduped_2_1 - RowRankOfMatrix( (UnionOfRows( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} )) ), deduped_3_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1411 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct :=
        
########
function ( cat_1, A_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Length( D_1 );
    deduped_5_1 := List( D_1, AsHomalgMatrix );
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsInteger( A_1 );
    deduped_2_1 := deduped_3_1 - RowRankOfMatrix( (UnionOfRows( deduped_4_1, deduped_3_1, deduped_5_1{[ 1 .. deduped_6_1 - 1 ]} ) - UnionOfRows( deduped_4_1, deduped_3_1, deduped_5_1{[ 2 .. deduped_6_1 ]} )) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromCoimageToCokernelOfKernel( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    morphism_attr_1_1 := UniqueRightDivide( HomalgIdentityMatrix( ColumnRankOfMatrix( deduped_2_1 ), UnderlyingRing( cat_1 ) ), UniqueLeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_2_1 ) ), BasisOfColumns( deduped_2_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromCoimageToCokernelOfKernel :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := ColumnRankOfMatrix( deduped_3_1 );
    deduped_1_1 := SyzygiesOfColumns( SyzygiesOfRows( deduped_3_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_2_1 ), UniqueRightDivide( HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), UniqueLeftDivide( deduped_1_1, BasisOfColumns( deduped_3_1 ) ) ), AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddIsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer( cat,
        
########
function ( cat_1, A_1, D_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( D_1 );
    deduped_4_1 := List( D_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( A_1 );
    morphism_attr_1_1 := HomalgIdentityMatrix( deduped_2_1 - RowRankOfMatrix( (UnionOfRows( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} )) ), deduped_3_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1411 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer :=
        
########
function ( cat_1, A_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Length( D_1 );
    deduped_5_1 := List( D_1, AsHomalgMatrix );
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsInteger( A_1 );
    deduped_2_1 := deduped_3_1 - RowRankOfMatrix( (UnionOfRows( deduped_4_1, deduped_3_1, deduped_5_1{[ 1 .. deduped_6_1 - 1 ]} ) - UnionOfRows( deduped_4_1, deduped_3_1, deduped_5_1{[ 2 .. deduped_6_1 ]} )) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromCokernelOfKernelToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    morphism_attr_1_1 := UniqueLeftDivide( SyzygiesOfColumns( SyzygiesOfRows( deduped_2_1 ) ), BasisOfColumns( deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 603 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromCokernelOfKernelToCoimage :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    deduped_1_1 := SyzygiesOfColumns( SyzygiesOfRows( deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ), UniqueLeftDivide( deduped_1_1, BasisOfColumns( deduped_2_1 ) ), AsCapCategoryObject( cat_1, ColumnRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddIsomorphismFromCoproductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, AsInteger ) ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromCoproductToDirectSum :=
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Sum( List( D_1, AsInteger ) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromDirectProductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, AsInteger ) ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromDirectProductToDirectSum :=
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Sum( List( D_1, AsInteger ) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromDirectSumToCoproduct( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, AsInteger ) ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromDirectSumToCoproduct :=
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Sum( List( D_1, AsInteger ) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromDirectSumToDirectProduct( cat,
        
########
function ( cat_1, D_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Sum( List( D_1, AsInteger ) ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromDirectSumToDirectProduct :=
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Sum( List( D_1, AsInteger ) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromDualObjectToInternalHomIntoTensorUnit( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct( cat,
        
########
function ( cat_1, D_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( D_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( D_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return UnionOfRows( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_1_2, deduped_8_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( D_1[i_2] ) ) );
        end );
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1 - RowRankOfMatrix( (UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} )) ), deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 4330 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct :=
        
########
function ( cat_1, D_1 )
    local hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( D_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( D_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    hoisted_4_1 := List( D_1, AsHomalgMatrix );
    deduped_7_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return UnionOfRows( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_1_2, deduped_10_1 ) ] ) * hoisted_4_1[i_2];
        end );
    deduped_6_1 := deduped_8_1 - RowRankOfMatrix( (UnionOfColumns( deduped_10_1, deduped_8_1, deduped_7_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_7_1{[ 2 .. deduped_11_1 ]} )) );
    deduped_5_1 := AsCapCategoryObject( cat_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), deduped_5_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct( cat,
        
########
function ( cat_1, A_1, D_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( D_1 );
    deduped_4_1 := List( D_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( A_1 );
    morphism_attr_1_1 := HomalgIdentityMatrix( deduped_2_1 - RowRankOfMatrix( (UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} )) ), deduped_3_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1409 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct :=
        
########
function ( cat_1, A_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Length( D_1 );
    deduped_5_1 := List( D_1, AsHomalgMatrix );
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsInteger( A_1 );
    deduped_2_1 := deduped_3_1 - RowRankOfMatrix( (UnionOfColumns( deduped_4_1, deduped_3_1, deduped_5_1{[ 1 .. deduped_6_1 - 1 ]} ) - UnionOfColumns( deduped_4_1, deduped_3_1, deduped_5_1{[ 2 .. deduped_6_1 ]} )) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromFiberProductToEqualizerOfDirectProductDiagram( cat,
        
########
function ( cat_1, D_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( D_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( D_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return UnionOfRows( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_1_2, deduped_8_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( D_1[i_2] ) ) );
        end );
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1 - RowRankOfMatrix( (UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} )) ), deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 4330 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram :=
        
########
function ( cat_1, D_1 )
    local hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( D_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( D_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    hoisted_4_1 := List( D_1, AsHomalgMatrix );
    deduped_7_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return UnionOfRows( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_1_2, deduped_10_1 ) ] ) * hoisted_4_1[i_2];
        end );
    deduped_6_1 := deduped_8_1 - RowRankOfMatrix( (UnionOfColumns( deduped_10_1, deduped_8_1, deduped_7_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_7_1{[ 2 .. deduped_11_1 ]} )) );
    deduped_5_1 := AsCapCategoryObject( cat_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), deduped_5_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( RowRankOfMatrix( SyzygiesOfRows( AsHomalgMatrix( beta_1 ) ) * SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) ) ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 501 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject :=
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := RowRankOfMatrix( SyzygiesOfRows( AsHomalgMatrix( beta_1 ) ) * SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) ) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromImageObjectToKernelOfCokernel( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    morphism_attr_1_1 := UniqueRightDivide( BasisOfRows( deduped_2_1 ), SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 603 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromImageObjectToKernelOfCokernel :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    deduped_1_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, RowRankOfMatrix( deduped_2_1 ) ), UniqueRightDivide( BasisOfRows( deduped_2_1 ), deduped_1_1 ), AsCapCategoryObject( cat_1, NumberRows( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddIsomorphismFromInitialObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := AsCapCategoryObject( cat_1, 0 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomFromTensorUnitToCoDualObject( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToObject( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 5526 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom( cat,
        
########
function ( cat_1, a_1, s_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 5525 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToTensorProductWithCoDualObject( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromInternalCoHomToTensorProductWithCoDualObject :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromInternalHomIntoTensorUnitToDualObject( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToObject( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 3315 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToObjectWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, s_1 )
    return AsCapCategoryMorphism( cat_1, s_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 3314 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToTensorProductWithDualObject( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromInternalHomToTensorProductWithDualObject :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromItsConstructionAsAnImageObjectToHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( RowRankOfMatrix( SyzygiesOfRows( AsHomalgMatrix( beta_1 ) ) * SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) ) ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 501 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject :=
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := RowRankOfMatrix( SyzygiesOfRows( AsHomalgMatrix( beta_1 ) ) * SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) ) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromKernelOfCokernelToImageObject( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_3_1 ) );
    morphism_attr_1_1 := UniqueRightDivide( HomalgIdentityMatrix( NumberRows( deduped_2_1 ), UnderlyingRing( cat_1 ) ), UniqueRightDivide( BasisOfRows( deduped_3_1 ), deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromKernelOfCokernelToImageObject :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_3_1 ) );
    deduped_1_1 := NumberRows( deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_1_1 ), UniqueRightDivide( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ), UniqueRightDivide( BasisOfRows( deduped_3_1 ), deduped_2_1 ) ), AsCapCategoryObject( cat_1, RowRankOfMatrix( deduped_3_1 ) ) );
end
########
        
    ;
    
    ##
    AddIsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer( cat,
        
########
function ( cat_1, A_1, D_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( D_1 );
    deduped_4_1 := List( D_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( A_1 );
    morphism_attr_1_1 := HomalgIdentityMatrix( deduped_2_1 - RowRankOfMatrix( (UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} )) ), deduped_3_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1409 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer :=
        
########
function ( cat_1, A_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Length( D_1 );
    deduped_5_1 := List( D_1, AsHomalgMatrix );
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := AsInteger( A_1 );
    deduped_2_1 := deduped_3_1 - RowRankOfMatrix( (UnionOfColumns( deduped_4_1, deduped_3_1, deduped_5_1{[ 1 .. deduped_6_1 - 1 ]} ) - UnionOfColumns( deduped_4_1, deduped_3_1, deduped_5_1{[ 2 .. deduped_6_1 ]} )) );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromObjectToInternalCoHom( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 3315 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom( cat,
        
########
function ( cat_1, a_1, r_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), r_1 );
end
########
        
    , 3314 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromObjectToInternalHom( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 5526 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromObjectToInternalHomWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, r_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 5525 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromPushoutToCoequalizerOfCoproductDiagram( cat,
        
########
function ( cat_1, D_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( D_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( D_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( D_1[i_2] ) ) ) * UnionOfColumns( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_8_1 ) ] );
        end );
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1 - RowRankOfMatrix( (UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} )) ), deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 4337 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromPushoutToCoequalizerOfCoproductDiagram :=
        
########
function ( cat_1, D_1 )
    local hoisted_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( D_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( D_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    hoisted_1_1 := List( D_1, AsHomalgMatrix );
    deduped_7_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return hoisted_1_1[i_2] * UnionOfColumns( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_10_1 ) ] );
        end );
    deduped_6_1 := deduped_8_1 - RowRankOfMatrix( (UnionOfRows( deduped_10_1, deduped_8_1, deduped_7_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfRows( deduped_10_1, deduped_8_1, deduped_7_1{[ 2 .. deduped_11_1 ]} )) );
    deduped_5_1 := AsCapCategoryObject( cat_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), deduped_5_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromTensorProductWithCoDualObjectToInternalCoHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromTensorProductWithDualObjectToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.IsomorphismFromTensorProductWithDualObjectToInternalHom :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddIsomorphismFromTerminalObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := AsCapCategoryObject( cat_1, 0 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromZeroObjectToInitialObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := AsCapCategoryObject( cat_1, 0 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromZeroObjectToTerminalObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := AsCapCategoryObject( cat_1, 0 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddJointPairwiseDifferencesOfMorphismsFromCoproduct( cat,
        
########
function ( cat_1, A_1, D_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( D_1 );
    deduped_4_1 := List( D_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( A_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, A_1 );
end
########
        
    , 1210 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.JointPairwiseDifferencesOfMorphismsFromCoproduct :=
        
########
function ( cat_1, A_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := List( D_1, AsHomalgMatrix );
    deduped_4_1 := AsInteger( A_1 );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := Length( D_1 );
    deduped_1_1 := [ 1 .. deduped_2_1 - 1 ];
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( D_1, function ( logic_new_func_x_2 )
                    return AsInteger( Source( logic_new_func_x_2 ) );
                end ){deduped_1_1} ) ), UnionOfRows( deduped_3_1, deduped_4_1, deduped_5_1{deduped_1_1} ) - UnionOfRows( deduped_3_1, deduped_4_1, deduped_5_1{[ 2 .. deduped_2_1 ]} ), A_1 );
end
########
        
    ;
    
    ##
    AddJointPairwiseDifferencesOfMorphismsIntoDirectProduct( cat,
        
########
function ( cat_1, A_1, D_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( D_1 );
    deduped_4_1 := List( D_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( A_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, A_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1208 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.JointPairwiseDifferencesOfMorphismsIntoDirectProduct :=
        
########
function ( cat_1, A_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( D_1 );
    deduped_4_1 := List( D_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( A_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := [ 1 .. deduped_5_1 - 1 ];
    return AsCapCategoryMorphism( cat_1, A_1, UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{deduped_1_1} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} ), AsCapCategoryObject( cat_1, Sum( List( D_1, function ( logic_new_func_x_2 )
                    return AsInteger( Range( logic_new_func_x_2 ) );
                end ){deduped_1_1} ) ) );
end
########
        
    ;
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_1_1 ) ), deduped_1_1, Source( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddKernelEmbeddingWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_1_1 ) ), deduped_1_1, Source( alpha_1 ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelLift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueRightDivide( AsHomalgMatrix( tau_1 ), SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) ) );
    return AsCapCategoryMorphism( cat_1, Source( tau_1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.KernelLift :=
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, Source( tau_1 ), UniqueRightDivide( AsHomalgMatrix( tau_1 ), deduped_1_1 ), AsCapCategoryObject( cat_1, NumberRows( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueRightDivide( AsHomalgMatrix( tau_1 ), SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) ) );
    return AsCapCategoryMorphism( cat_1, Source( tau_1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.KernelLiftWithGivenKernelObject :=
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, Source( tau_1 ), UniqueRightDivide( AsHomalgMatrix( tau_1 ), deduped_1_1 ), AsCapCategoryObject( cat_1, NumberRows( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCapCategoryObject( cat_1, AsInteger( Source( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddKernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueRightDivide( SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) ) * AsHomalgMatrix( mu_1 ), SyzygiesOfRows( AsHomalgMatrix( alphap_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 605 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.KernelObjectFunctorial :=
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfRows( AsHomalgMatrix( alphap_1 ) );
    deduped_1_1 := SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_1_1 ) ), UniqueRightDivide( deduped_1_1 * AsHomalgMatrix( mu_1 ), deduped_2_1 ), AsCapCategoryObject( cat_1, NumberRows( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddKernelObjectFunctorialWithGivenKernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UniqueRightDivide( SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) ) * AsHomalgMatrix( mu_1 ), SyzygiesOfRows( AsHomalgMatrix( alphap_1 ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 404 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.KernelObjectFunctorialWithGivenKernelObjects :=
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfRows( AsHomalgMatrix( alphap_1 ) );
    deduped_1_1 := SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_1_1 ) ), UniqueRightDivide( deduped_1_1 * AsHomalgMatrix( mu_1 ), deduped_2_1 ), AsCapCategoryObject( cat_1, NumberRows( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddLambdaElimination( cat,
        
########
function ( cat_1, a_1, b_1, alpha_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := AsInteger( b_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( a_1 );
    deduped_4_1 := deduped_5_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_5_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, a_1, KroneckerMat( AsHomalgMatrix( alpha_1 ), deduped_3_1 ) * (KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_6_1 ), ConvertMatrixToColumn( deduped_3_1 ) )), b_1 );
end
########
        
    , 3616 : IsPrecompiledDerivation := true );
    
    ##
    AddLambdaIntroduction( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( Source( alpha_1 ) );
    deduped_4_1 := deduped_5_1 * deduped_5_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_5_1, deduped_6_1 );
    morphism_attr_1_1 := ConvertMatrixToRow( deduped_3_1 ) * CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_6_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_5_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_5_1 ) + 1);
              end ) ) * KroneckerMat( deduped_3_1, AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 5625 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.LambdaIntroduction :=
        
########
function ( cat_1, alpha_1 )
    local deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := AsInteger( Source( alpha_1 ) );
    deduped_3_1 := deduped_4_1 * deduped_4_1;
    deduped_2_1 := HomalgIdentityMatrix( deduped_4_1, deduped_5_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 1 ), ConvertMatrixToRow( deduped_2_1 ) * CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_5_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_4_1 ) * deduped_4_1 + QUO_INT( deduped_1_2, deduped_4_1 ) + 1);
                end ) ) * KroneckerMat( deduped_2_1, AsHomalgMatrix( alpha_1 ) ), AsCapCategoryObject( cat_1, deduped_4_1 * AsInteger( Range( alpha_1 ) ) ) );
end
########
        
    ;
    
    ##
    AddLeftDistributivityExpanding( cat,
        
########
function ( cat_1, a_1, L_1 )
    local morphism_attr_1_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( L_1 );
    deduped_8_1 := List( L_1, AsInteger );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_6_1 );
    morphism_attr_1_1 := UnionOfColumns( deduped_6_1, deduped_7_1 * Sum( deduped_8_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_8_1[i_2];
              return KroneckerMat( hoisted_5_1, UnionOfRows( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_8_1{[ 1 .. i_2 - 1 ]} ), deduped_1_2, deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( Sum( deduped_8_1{[ i_2 + 1 .. deduped_9_1 ]} ), deduped_1_2, deduped_6_1 ) ] ) );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.LeftDistributivityExpanding :=
        
########
function ( cat_1, a_1, L_1 )
    local hoisted_4_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( L_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( L_1, AsInteger );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := deduped_7_1 * Sum( deduped_8_1 );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_7_1, deduped_9_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_6_1 ), UnionOfColumns( deduped_9_1, deduped_6_1, List( [ 1 .. deduped_10_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_8_1[i_2];
                return KroneckerMat( hoisted_4_1, UnionOfRows( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_8_1{[ 1 .. i_2 - 1 ]} ), deduped_1_2, deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( Sum( deduped_8_1{[ i_2 + 1 .. deduped_10_1 ]} ), deduped_1_2, deduped_9_1 ) ] ) );
            end ) ), AsCapCategoryObject( cat_1, Sum( List( L_1, function ( summand_2 )
                  return deduped_7_1 * AsInteger( summand_2 );
              end ) ) ) );
end
########
        
    ;
    
    ##
    AddLeftDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local morphism_attr_1_1, deduped_2_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( AsInteger( a_1 ), deduped_6_1 );
    deduped_2_1 := List( L_1, AsInteger );
    morphism_attr_1_1 := UnionOfColumns( deduped_6_1, AsInteger( s_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_2_1[i_2];
              return KroneckerMat( hoisted_5_1, UnionOfRows( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. i_2 - 1 ]} ), deduped_1_2, deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ i_2 + 1 .. deduped_7_1 ]} ), deduped_1_2, deduped_6_1 ) ] ) );
          end ) );
    return AsCapCategoryMorphism( cat_1, s_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.LeftDistributivityExpandingWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local deduped_1_1, hoisted_4_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_6_1 );
    deduped_1_1 := List( L_1, AsInteger );
    return AsCapCategoryMorphism( cat_1, s_1, UnionOfColumns( deduped_6_1, AsInteger( s_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_1_1[i_2];
                return KroneckerMat( hoisted_4_1, UnionOfRows( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_1_1{[ 1 .. i_2 - 1 ]} ), deduped_1_2, deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( Sum( deduped_1_1{[ i_2 + 1 .. deduped_7_1 ]} ), deduped_1_2, deduped_6_1 ) ] ) );
            end ) ), AsCapCategoryObject( cat_1, Sum( List( L_1, function ( summand_2 )
                  return deduped_8_1 * AsInteger( summand_2 );
              end ) ) ) );
end
########
        
    ;
    
    ##
    AddLeftDistributivityFactoring( cat,
        
########
function ( cat_1, a_1, L_1 )
    local morphism_attr_1_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( L_1 );
    deduped_8_1 := List( L_1, AsInteger );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_6_1 );
    morphism_attr_1_1 := UnionOfRows( deduped_6_1, deduped_7_1 * Sum( deduped_8_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_8_1[i_2];
              return KroneckerMat( hoisted_5_1, UnionOfColumns( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ 1 .. i_2 - 1 ]} ), deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ i_2 + 1 .. deduped_9_1 ]} ), deduped_6_1 ) ] ) );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.LeftDistributivityFactoring :=
        
########
function ( cat_1, a_1, L_1 )
    local hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( L_1 );
    deduped_9_1 := List( L_1, AsInteger );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := deduped_8_1 * Sum( deduped_9_1 );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_7_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( L_1, function ( summand_2 )
                  return deduped_8_1 * AsInteger( summand_2 );
              end ) ) ), UnionOfRows( deduped_7_1, deduped_6_1, List( [ 1 .. deduped_10_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_9_1[i_2];
                return KroneckerMat( hoisted_5_1, UnionOfColumns( deduped_7_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ 1 .. i_2 - 1 ]} ), deduped_7_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_7_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ i_2 + 1 .. deduped_10_1 ]} ), deduped_7_1 ) ] ) );
            end ) ), AsCapCategoryObject( cat_1, deduped_6_1 ) );
end
########
        
    ;
    
    ##
    AddLeftDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local morphism_attr_1_1, deduped_2_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( AsInteger( a_1 ), deduped_6_1 );
    deduped_2_1 := List( L_1, AsInteger );
    morphism_attr_1_1 := UnionOfRows( deduped_6_1, AsInteger( r_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_2_1[i_2];
              return KroneckerMat( hoisted_5_1, UnionOfColumns( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ 1 .. i_2 - 1 ]} ), deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ i_2 + 1 .. deduped_7_1 ]} ), deduped_6_1 ) ] ) );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, r_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.LeftDistributivityFactoringWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local deduped_2_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_6_1 );
    deduped_2_1 := List( L_1, AsInteger );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( L_1, function ( summand_2 )
                  return deduped_8_1 * AsInteger( summand_2 );
              end ) ) ), UnionOfRows( deduped_6_1, AsInteger( r_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_2_1[i_2];
                return KroneckerMat( hoisted_5_1, UnionOfColumns( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ 1 .. i_2 - 1 ]} ), deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ i_2 + 1 .. deduped_7_1 ]} ), deduped_6_1 ) ] ) );
            end ) ), r_1 );
end
########
        
    ;
    
    ##
    AddLeftUnitor( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), SafeRightDivide( AsHomalgMatrix( alpha_1 ), AsHomalgMatrix( beta_1 ) ), Source( beta_1 ) );
end
########
        
    , 100 );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    return AsCapCategoryMorphism( cat_1, Source( tau_1 ), UniqueRightDivide( AsHomalgMatrix( tau_1 ), AsHomalgMatrix( iota_1 ) ), Source( iota_1 ) );
end
########
        
    , 100 );
    
    ##
    AddLinearCombinationOfMorphisms( cat,
        
########
function ( cat_1, source_1, list_of_ring_elements_1, list_of_morphisms_1, range_1 )
    return AsCapCategoryMorphism( cat_1, source_1, Sum( ListN( list_of_ring_elements_1, list_of_morphisms_1, function ( r_2, alpha_2 )
                return r_2 * AsHomalgMatrix( alpha_2 );
            end ), HomalgZeroMatrix( AsInteger( source_1 ), AsInteger( range_1 ), UnderlyingRing( cat_1 ) ) ), range_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddMereExistenceOfSolutionOfLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_9_1 := CAP_JIT_INCOMPLETE_LOGIC( arg2_1[1] );
    hoisted_6_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_5_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_4_1 := CAP_JIT_INCOMPLETE_LOGIC( List( CAP_JIT_INCOMPLETE_LOGIC( arg3_1[1] ), function ( logic_new_func_x_2 )
              return AsInteger( Source( logic_new_func_x_2 ) );
          end ) );
    hoisted_2_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Range( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_1_1 := List( arg4_1, function ( logic_new_func_x_2 )
            return ConvertMatrixToRow( AsHomalgMatrix( logic_new_func_x_2 ) );
        end );
    return IsZero( DecideZeroRows( UnionOfColumns( deduped_11_1, 1, List( deduped_10_1, function ( i_2 )
                  return hoisted_1_1[i_2];
              end ) ), UnionOfRows( deduped_11_1, Sum( List( deduped_10_1, function ( i_2 )
                    return CAP_JIT_INCOMPLETE_LOGIC( AsInteger( Source( CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( arg2_1[i_2] )[1] ) ) ) ) * hoisted_2_1[i_2][1];
                end ) ), List( [ 1 .. CAP_JIT_INCOMPLETE_LOGIC( Length( deduped_9_1 ) ) ], function ( j_2 )
                  return UnionOfColumns( deduped_11_1, CAP_JIT_INCOMPLETE_LOGIC( AsInteger( Range( CAP_JIT_INCOMPLETE_LOGIC( deduped_9_1[j_2] ) ) ) ) * hoisted_4_1[j_2], List( deduped_10_1, function ( i_3 )
                            return KroneckerMat( hoisted_5_1[i_3][j_2], hoisted_6_1[i_3][j_2] );
                        end ) );
              end ) ) ) );
end
########
        
    , 2306 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MereExistenceOfSolutionOfLinearSystemInAbCategory :=
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := [ 1 .. Length( arg2_1 ) ];
    hoisted_7_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_6_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_5_1 := List( arg3_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Source( logic_new_func_x_3 ) );
                  end );
          end )[1];
    hoisted_4_1 := List( arg2_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Range( logic_new_func_x_3 ) );
                  end );
          end )[1];
    hoisted_3_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Range( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_2_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Source( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_1_1 := List( arg4_1, function ( logic_new_func_x_2 )
            return ConvertMatrixToRow( AsHomalgMatrix( logic_new_func_x_2 ) );
        end );
    return IsZero( DecideZeroRows( UnionOfColumns( deduped_11_1, 1, List( deduped_10_1, function ( i_2 )
                  return hoisted_1_1[i_2];
              end ) ), UnionOfRows( deduped_11_1, Sum( List( deduped_10_1, function ( i_2 )
                    return hoisted_2_1[i_2][1] * hoisted_3_1[i_2][1];
                end ) ), List( [ 1 .. List( arg2_1, Length )[1] ], function ( j_2 )
                  return UnionOfColumns( deduped_11_1, hoisted_4_1[j_2] * hoisted_5_1[j_2], List( deduped_10_1, function ( i_3 )
                            return KroneckerMat( hoisted_6_1[i_3][j_2], hoisted_7_1[i_3][j_2] );
                        end ) );
              end ) ) ) );
end
########
        
    ;
    
    ##
    AddMereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_9_1 := CAP_JIT_INCOMPLETE_LOGIC( arg2_1[1] );
    deduped_8_1 := [ 1 .. CAP_JIT_INCOMPLETE_LOGIC( Length( deduped_9_1 ) ) ];
    hoisted_5_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_4_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_3_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Target( logic_new_func_x_3 ) );
                end );
        end );
    deduped_2_1 := CAP_JIT_INCOMPLETE_LOGIC( List( CAP_JIT_INCOMPLETE_LOGIC( arg3_1[1] ), function ( logic_new_func_x_2 )
              return AsInteger( Source( logic_new_func_x_2 ) );
          end ) );
    deduped_1_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_9_1, function ( logic_new_func_x_2 )
              return AsInteger( Target( logic_new_func_x_2 ) );
          end ) );
    return Sum( List( deduped_8_1, function ( j_2 )
                  return deduped_1_1[j_2] * deduped_2_1[j_2];
              end ) ) - RowRankOfMatrix( UnionOfRows( deduped_11_1, Sum( List( deduped_10_1, function ( i_2 )
                      return CAP_JIT_INCOMPLETE_LOGIC( AsInteger( Source( CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( arg2_1[i_2] )[1] ) ) ) ) * hoisted_3_1[i_2][1];
                  end ) ), List( deduped_8_1, function ( j_2 )
                    return UnionOfColumns( deduped_11_1, deduped_1_1[j_2] * deduped_2_1[j_2], List( deduped_10_1, function ( i_3 )
                              return KroneckerMat( hoisted_4_1[i_3][j_2], hoisted_5_1[i_3][j_2] );
                          end ) );
                end ) ) ) = 0;
end
########
        
    , 2408 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfHomogeneousLinearSystemInAbCategory :=
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_9_1 := [ 1 .. List( arg2_1, Length )[1] ];
    hoisted_6_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_5_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_4_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Target( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_3_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Source( logic_new_func_x_3 ) );
                end );
        end );
    deduped_2_1 := List( arg3_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Source( logic_new_func_x_3 ) );
                  end );
          end )[1];
    deduped_1_1 := List( arg2_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Target( logic_new_func_x_3 ) );
                  end );
          end )[1];
    return Sum( List( deduped_9_1, function ( j_2 )
                  return deduped_1_1[j_2] * deduped_2_1[j_2];
              end ) ) - RowRankOfMatrix( UnionOfRows( deduped_11_1, Sum( List( deduped_10_1, function ( i_2 )
                      return hoisted_3_1[i_2][1] * hoisted_4_1[i_2][1];
                  end ) ), List( deduped_9_1, function ( j_2 )
                    return UnionOfColumns( deduped_11_1, deduped_1_1[j_2] * deduped_2_1[j_2], List( deduped_10_1, function ( i_3 )
                              return KroneckerMat( hoisted_5_1[i_3][j_2], hoisted_6_1[i_3][j_2] );
                          end ) );
                end ) ) ) = 0;
end
########
        
    ;
    
    ##
    AddMereExistenceOfUniqueSolutionOfLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local deduped_1_1, deduped_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_12_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_11_1 := CAP_JIT_INCOMPLETE_LOGIC( arg2_1[1] );
    deduped_10_1 := [ 1 .. CAP_JIT_INCOMPLETE_LOGIC( Length( deduped_11_1 ) ) ];
    hoisted_5_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_4_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_3_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Target( logic_new_func_x_3 ) );
                end );
        end );
    deduped_2_1 := CAP_JIT_INCOMPLETE_LOGIC( List( CAP_JIT_INCOMPLETE_LOGIC( arg3_1[1] ), function ( logic_new_func_x_2 )
              return AsInteger( Source( logic_new_func_x_2 ) );
          end ) );
    deduped_1_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_11_1, function ( logic_new_func_x_2 )
              return AsInteger( Target( logic_new_func_x_2 ) );
          end ) );
    deduped_9_1 := UnionOfRows( deduped_13_1, Sum( List( deduped_12_1, function ( i_2 )
                return CAP_JIT_INCOMPLETE_LOGIC( AsInteger( Source( CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( arg2_1[i_2] )[1] ) ) ) ) * hoisted_3_1[i_2][1];
            end ) ), List( deduped_10_1, function ( j_2 )
              return UnionOfColumns( deduped_13_1, deduped_1_1[j_2] * deduped_2_1[j_2], List( deduped_12_1, function ( i_3 )
                        return KroneckerMat( hoisted_4_1[i_3][j_2], hoisted_5_1[i_3][j_2] );
                    end ) );
          end ) );
    hoisted_8_1 := List( arg4_1, function ( logic_new_func_x_2 )
            return ConvertMatrixToRow( AsHomalgMatrix( logic_new_func_x_2 ) );
        end );
    return Sum( List( deduped_10_1, function ( j_2 )
                    return deduped_1_1[j_2] * deduped_2_1[j_2];
                end ) ) - RowRankOfMatrix( deduped_9_1 ) = 0 and IsZero( DecideZeroRows( UnionOfColumns( deduped_13_1, 1, List( deduped_12_1, function ( i_2 )
                    return hoisted_8_1[i_2];
                end ) ), deduped_9_1 ) );
end
########
        
    , 2507 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MereExistenceOfUniqueSolutionOfLinearSystemInAbCategory :=
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local deduped_1_1, deduped_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_12_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_11_1 := [ 1 .. List( arg2_1, Length )[1] ];
    hoisted_6_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_5_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_4_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Target( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_3_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Source( logic_new_func_x_3 ) );
                end );
        end );
    deduped_2_1 := List( arg3_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Source( logic_new_func_x_3 ) );
                  end );
          end )[1];
    deduped_1_1 := List( arg2_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Target( logic_new_func_x_3 ) );
                  end );
          end )[1];
    deduped_10_1 := UnionOfRows( deduped_13_1, Sum( List( deduped_12_1, function ( i_2 )
                return hoisted_3_1[i_2][1] * hoisted_4_1[i_2][1];
            end ) ), List( deduped_11_1, function ( j_2 )
              return UnionOfColumns( deduped_13_1, deduped_1_1[j_2] * deduped_2_1[j_2], List( deduped_12_1, function ( i_3 )
                        return KroneckerMat( hoisted_5_1[i_3][j_2], hoisted_6_1[i_3][j_2] );
                    end ) );
          end ) );
    hoisted_9_1 := List( arg4_1, function ( logic_new_func_x_2 )
            return ConvertMatrixToRow( AsHomalgMatrix( logic_new_func_x_2 ) );
        end );
    return Sum( List( deduped_11_1, function ( j_2 )
                    return deduped_1_1[j_2] * deduped_2_1[j_2];
                end ) ) - RowRankOfMatrix( deduped_10_1 ) = 0 and IsZero( DecideZeroRows( UnionOfColumns( deduped_13_1, 1, List( deduped_12_1, function ( i_2 )
                    return hoisted_9_1[i_2];
                end ) ), deduped_10_1 ) );
end
########
        
    ;
    
    ##
    AddMonoidalPostCoComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := AsInteger( b_1 );
    deduped_17_1 := AsInteger( a_1 );
    deduped_16_1 := UnderlyingRing( cat_1 );
    deduped_15_1 := AsInteger( c_1 );
    deduped_14_1 := deduped_15_1 * deduped_15_1;
    deduped_13_1 := deduped_18_1 * deduped_15_1;
    deduped_12_1 := deduped_17_1 * deduped_18_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_18_1, deduped_16_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_15_1, deduped_16_1 );
    deduped_9_1 := deduped_12_1 * deduped_13_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_12_1, deduped_16_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_16_1 );
    deduped_6_1 := deduped_9_1 * deduped_15_1;
    morphism_attr_1_1 := KroneckerMat( deduped_10_1, KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_16_1 ), ConvertMatrixToRow( deduped_11_1 ) ) * KroneckerMat( CertainRows( deduped_8_1, List( [ 1 .. deduped_12_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                    end ) ), deduped_11_1 ) * KroneckerMat( deduped_8_1, (KroneckerMat( deduped_11_1, ConvertMatrixToRow( deduped_10_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_16_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                      end ) ), deduped_10_1 )) ) ) * (KroneckerMat( deduped_10_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_16_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                  end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_14_1, deduped_16_1 ), List( [ 1 .. deduped_14_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                  end ) ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_10_1 ), deduped_7_1 ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 13253 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MonoidalPostCoComposeMorphism :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := AsInteger( b_1 );
    deduped_16_1 := UnderlyingRing( cat_1 );
    deduped_15_1 := AsInteger( c_1 );
    deduped_14_1 := AsInteger( a_1 );
    deduped_13_1 := deduped_15_1 * deduped_15_1;
    deduped_12_1 := deduped_17_1 * deduped_15_1;
    deduped_11_1 := deduped_14_1 * deduped_17_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_17_1, deduped_16_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_15_1, deduped_16_1 );
    deduped_8_1 := deduped_11_1 * deduped_12_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_11_1, deduped_16_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_16_1 );
    deduped_5_1 := deduped_8_1 * deduped_15_1;
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_14_1 * deduped_15_1 ), KroneckerMat( deduped_9_1, KroneckerMat( HomalgIdentityMatrix( deduped_14_1, deduped_16_1 ), ConvertMatrixToRow( deduped_10_1 ) ) * KroneckerMat( CertainRows( deduped_7_1, List( [ 1 .. deduped_11_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                      end ) ), deduped_10_1 ) * KroneckerMat( deduped_7_1, (KroneckerMat( deduped_10_1, ConvertMatrixToRow( deduped_9_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_16_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                        end ) ), deduped_9_1 )) ) ) * (KroneckerMat( deduped_9_1, CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_16_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_16_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                    end ) ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_9_1 ), deduped_6_1 )), AsCapCategoryObject( cat_1, deduped_8_1 ) );
end
########
        
    ;
    
    ##
    AddMonoidalPostCoComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := AsInteger( r_1 );
    deduped_16_1 := AsInteger( b_1 );
    deduped_15_1 := AsInteger( a_1 );
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := AsInteger( c_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_17_1, deduped_14_1 );
    deduped_11_1 := deduped_13_1 * deduped_13_1;
    deduped_10_1 := deduped_17_1 * deduped_13_1;
    deduped_9_1 := deduped_16_1 * deduped_13_1;
    deduped_8_1 := deduped_15_1 * deduped_16_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_16_1, deduped_14_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_13_1, deduped_14_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_14_1 );
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( deduped_6_1, KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_14_1 ), ConvertMatrixToRow( deduped_7_1 ) ) * KroneckerMat( CertainRows( deduped_5_1, List( [ 1 .. deduped_8_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                      end ) ), deduped_7_1 ) * KroneckerMat( deduped_5_1, (KroneckerMat( deduped_7_1, ConvertMatrixToRow( deduped_6_1 ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_14_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_13_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_13_1 ) + 1);
                        end ) ), deduped_6_1 )) ) ) * (KroneckerMat( deduped_6_1, CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_14_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_13_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_13_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_14_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_13_1 ) * deduped_13_1 + QUO_INT( deduped_1_2, deduped_13_1 ) + 1);
                    end ) ), deduped_12_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_6_1 ), deduped_12_1 )), r_1 );
end
########
        
    , 12246 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPostComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := AsInteger( c_1 );
    deduped_17_1 := AsInteger( b_1 );
    deduped_16_1 := UnderlyingRing( cat_1 );
    deduped_15_1 := AsInteger( a_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_17_1, deduped_16_1 );
    deduped_13_1 := deduped_15_1 * deduped_15_1;
    deduped_12_1 := deduped_15_1 * deduped_17_1;
    deduped_11_1 := deduped_17_1 * deduped_18_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_15_1, deduped_16_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_11_1, deduped_16_1 );
    deduped_8_1 := deduped_11_1 * deduped_12_1;
    deduped_7_1 := deduped_15_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_16_1 );
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_10_1 ), deduped_6_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_16_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                  end ) ), deduped_6_1 ) * KroneckerMat( deduped_10_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_16_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                end ) ) ) * KroneckerMat( deduped_10_1, (KroneckerMat( deduped_9_1, KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_16_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                      end ) ), deduped_10_1 ) * KroneckerMat( deduped_14_1, ConvertMatrixToColumn( deduped_10_1 ) ) ) * (KroneckerMat( CertainRows( deduped_9_1, List( [ 1 .. deduped_11_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                    end ) ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_18_1, deduped_16_1 ), ConvertMatrixToColumn( deduped_14_1 ) ))) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 13253 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MonoidalPostComposeMorphism :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := AsInteger( a_1 );
    deduped_15_1 := AsInteger( c_1 );
    deduped_14_1 := AsInteger( b_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_14_1, deduped_17_1 );
    deduped_12_1 := deduped_16_1 * deduped_16_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_16_1, deduped_17_1 );
    deduped_10_1 := deduped_16_1 * deduped_14_1;
    deduped_9_1 := deduped_14_1 * deduped_15_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_9_1, deduped_17_1 );
    deduped_7_1 := deduped_9_1 * deduped_10_1;
    deduped_6_1 := deduped_16_1 * deduped_7_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_17_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_7_1 ), KroneckerMat( ConvertMatrixToRow( deduped_11_1 ), deduped_5_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_17_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                    end ) ), deduped_5_1 ) * KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_17_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_11_1, (KroneckerMat( deduped_8_1, KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_17_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                        end ) ), deduped_11_1 ) * KroneckerMat( deduped_13_1, ConvertMatrixToColumn( deduped_11_1 ) ) ) * (KroneckerMat( CertainRows( deduped_8_1, List( [ 1 .. deduped_9_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                      end ) ), deduped_13_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_17_1 ), ConvertMatrixToColumn( deduped_13_1 ) ))) ), AsCapCategoryObject( cat_1, deduped_16_1 * deduped_15_1 ) );
end
########
        
    ;
    
    ##
    AddMonoidalPostComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := AsInteger( c_1 );
    deduped_16_1 := AsInteger( b_1 );
    deduped_15_1 := AsInteger( s_1 );
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := AsInteger( a_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_16_1, deduped_14_1 );
    deduped_11_1 := deduped_13_1 * deduped_16_1;
    deduped_10_1 := deduped_16_1 * deduped_17_1;
    deduped_9_1 := deduped_13_1 * deduped_15_1;
    deduped_8_1 := deduped_13_1 * deduped_13_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_15_1, deduped_14_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_13_1, deduped_14_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_10_1, deduped_14_1 );
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( ConvertMatrixToRow( deduped_6_1 ), deduped_7_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_8_1, deduped_14_1 ), List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_13_1 ) * deduped_13_1 + QUO_INT( deduped_1_2, deduped_13_1 ) + 1);
                    end ) ), deduped_7_1 ) * KroneckerMat( deduped_6_1, CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_14_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_13_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_6_1, (KroneckerMat( deduped_5_1, KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_14_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_13_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                        end ) ), deduped_6_1 ) * KroneckerMat( deduped_12_1, ConvertMatrixToColumn( deduped_6_1 ) ) ) * (KroneckerMat( CertainRows( deduped_5_1, List( [ 1 .. deduped_10_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                      end ) ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_14_1 ), ConvertMatrixToColumn( deduped_12_1 ) ))) ), r_1 );
end
########
        
    , 12246 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreCoComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1;
    deduped_22_1 := AsInteger( b_1 );
    deduped_21_1 := AsInteger( a_1 );
    deduped_20_1 := UnderlyingRing( cat_1 );
    deduped_19_1 := AsInteger( c_1 );
    deduped_18_1 := deduped_19_1 * deduped_19_1;
    deduped_17_1 := deduped_22_1 * deduped_19_1;
    deduped_16_1 := deduped_21_1 * deduped_22_1;
    deduped_15_1 := HomalgIdentityMatrix( deduped_22_1, deduped_20_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_19_1, deduped_20_1 );
    deduped_13_1 := deduped_17_1 * deduped_16_1;
    deduped_12_1 := deduped_19_1 * deduped_16_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_17_1, deduped_20_1 );
    deduped_10_1 := deduped_16_1 * deduped_22_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_16_1, deduped_20_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_13_1, deduped_20_1 );
    deduped_7_1 := deduped_13_1 * deduped_19_1;
    morphism_attr_1_1 := KroneckerMat( deduped_14_1, KroneckerMat( HomalgIdentityMatrix( deduped_21_1, deduped_20_1 ), ConvertMatrixToRow( deduped_15_1 ) ) * KroneckerMat( CertainRows( deduped_9_1, List( [ 1 .. deduped_16_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_22_1 ) * deduped_21_1 + QUO_INT( deduped_1_2, deduped_22_1 ) + 1);
                        end ) ), deduped_15_1 ) * CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_20_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_22_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_22_1 ) + 1);
                    end ) ) * KroneckerMat( (KroneckerMat( deduped_15_1, ConvertMatrixToRow( deduped_14_1 ) ) * KroneckerMat( CertainRows( deduped_11_1, List( [ 1 .. deduped_17_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_22_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                        end ) ), deduped_14_1 )), deduped_9_1 ) * KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_20_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                  end ) ) ) ) * (KroneckerMat( deduped_14_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_20_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_13_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                  end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_18_1, deduped_20_1 ), List( [ 1 .. deduped_18_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                  end ) ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_14_1 ), deduped_8_1 ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 14358 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MonoidalPreCoComposeMorphism :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
    deduped_21_1 := AsInteger( b_1 );
    deduped_20_1 := UnderlyingRing( cat_1 );
    deduped_19_1 := AsInteger( c_1 );
    deduped_18_1 := AsInteger( a_1 );
    deduped_17_1 := deduped_19_1 * deduped_19_1;
    deduped_16_1 := deduped_21_1 * deduped_19_1;
    deduped_15_1 := deduped_18_1 * deduped_21_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_21_1, deduped_20_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_19_1, deduped_20_1 );
    deduped_12_1 := deduped_16_1 * deduped_15_1;
    deduped_11_1 := deduped_19_1 * deduped_15_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_16_1, deduped_20_1 );
    deduped_9_1 := deduped_15_1 * deduped_21_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_15_1, deduped_20_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_12_1, deduped_20_1 );
    deduped_6_1 := deduped_12_1 * deduped_19_1;
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_18_1 * deduped_19_1 ), KroneckerMat( deduped_13_1, KroneckerMat( HomalgIdentityMatrix( deduped_18_1, deduped_20_1 ), ConvertMatrixToRow( deduped_14_1 ) ) * KroneckerMat( CertainRows( deduped_8_1, List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_21_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_21_1 ) + 1);
                          end ) ), deduped_14_1 ) * CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_20_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_21_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_21_1 ) + 1);
                      end ) ) * KroneckerMat( (KroneckerMat( deduped_14_1, ConvertMatrixToRow( deduped_13_1 ) ) * KroneckerMat( CertainRows( deduped_10_1, List( [ 1 .. deduped_16_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_21_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                          end ) ), deduped_13_1 )), deduped_8_1 ) * KroneckerMat( deduped_10_1, CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_20_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                    end ) ) ) ) * (KroneckerMat( deduped_13_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_20_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_17_1, deduped_20_1 ), List( [ 1 .. deduped_17_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                    end ) ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_13_1 ), deduped_7_1 )), AsCapCategoryObject( cat_1, deduped_12_1 ) );
end
########
        
    ;
    
    ##
    AddMonoidalPreCoComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
    deduped_21_1 := AsInteger( r_1 );
    deduped_20_1 := AsInteger( b_1 );
    deduped_19_1 := AsInteger( a_1 );
    deduped_18_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := AsInteger( c_1 );
    deduped_16_1 := HomalgIdentityMatrix( deduped_21_1, deduped_18_1 );
    deduped_15_1 := deduped_17_1 * deduped_17_1;
    deduped_14_1 := deduped_21_1 * deduped_17_1;
    deduped_13_1 := deduped_20_1 * deduped_17_1;
    deduped_12_1 := deduped_19_1 * deduped_20_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_20_1, deduped_18_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_17_1, deduped_18_1 );
    deduped_9_1 := deduped_17_1 * deduped_12_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_13_1, deduped_18_1 );
    deduped_7_1 := deduped_12_1 * deduped_20_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_12_1, deduped_18_1 );
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( deduped_10_1, KroneckerMat( HomalgIdentityMatrix( deduped_19_1, deduped_18_1 ), ConvertMatrixToRow( deduped_11_1 ) ) * KroneckerMat( CertainRows( deduped_6_1, List( [ 1 .. deduped_12_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                          end ) ), deduped_11_1 ) * CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_18_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                      end ) ) * KroneckerMat( (KroneckerMat( deduped_11_1, ConvertMatrixToRow( deduped_10_1 ) ) * KroneckerMat( CertainRows( deduped_8_1, List( [ 1 .. deduped_13_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                          end ) ), deduped_10_1 )), deduped_6_1 ) * KroneckerMat( deduped_8_1, CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_18_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                    end ) ) ) ) * (KroneckerMat( deduped_10_1, CertainRows( HomalgIdentityMatrix( deduped_14_1, deduped_18_1 ), List( [ 1 .. deduped_14_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_21_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_15_1, deduped_18_1 ), List( [ 1 .. deduped_15_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                    end ) ), deduped_16_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_10_1 ), deduped_16_1 )), r_1 );
end
########
        
    , 13351 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1;
    deduped_22_1 := AsInteger( c_1 );
    deduped_21_1 := AsInteger( b_1 );
    deduped_20_1 := UnderlyingRing( cat_1 );
    deduped_19_1 := AsInteger( a_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_21_1, deduped_20_1 );
    deduped_17_1 := deduped_19_1 * deduped_19_1;
    deduped_16_1 := deduped_21_1 * deduped_22_1;
    deduped_15_1 := deduped_19_1 * deduped_21_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_19_1, deduped_20_1 );
    deduped_13_1 := deduped_21_1 * deduped_16_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_16_1, deduped_20_1 );
    deduped_11_1 := deduped_16_1 * deduped_19_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_15_1, deduped_20_1 );
    deduped_9_1 := deduped_15_1 * deduped_16_1;
    deduped_8_1 := deduped_19_1 * deduped_9_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_20_1 );
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_14_1 ), deduped_7_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_17_1, deduped_20_1 ), List( [ 1 .. deduped_17_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                  end ) ), deduped_7_1 ) * KroneckerMat( deduped_14_1, CertainRows( HomalgIdentityMatrix( deduped_8_1, deduped_20_1 ), List( [ 1 .. deduped_8_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                end ) ) ) * KroneckerMat( deduped_14_1, (KroneckerMat( deduped_10_1, CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_20_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                      end ) ) ) * KroneckerMat( (KroneckerMat( CertainRows( deduped_10_1, List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_21_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_21_1 ) + 1);
                          end ) ), deduped_14_1 ) * KroneckerMat( deduped_18_1, ConvertMatrixToColumn( deduped_14_1 ) )), deduped_12_1 ) * CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_20_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_21_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                  end ) ) * (KroneckerMat( CertainRows( deduped_12_1, List( [ 1 .. deduped_16_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_22_1 ) * deduped_21_1 + QUO_INT( deduped_1_2, deduped_22_1 ) + 1);
                    end ) ), deduped_18_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_22_1, deduped_20_1 ), ConvertMatrixToColumn( deduped_18_1 ) ))) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 14358 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MonoidalPreComposeMorphism :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
    deduped_21_1 := UnderlyingRing( cat_1 );
    deduped_20_1 := AsInteger( c_1 );
    deduped_19_1 := AsInteger( b_1 );
    deduped_18_1 := AsInteger( a_1 );
    deduped_17_1 := HomalgIdentityMatrix( deduped_19_1, deduped_21_1 );
    deduped_16_1 := deduped_18_1 * deduped_18_1;
    deduped_15_1 := HomalgIdentityMatrix( deduped_18_1, deduped_21_1 );
    deduped_14_1 := deduped_19_1 * deduped_20_1;
    deduped_13_1 := deduped_18_1 * deduped_19_1;
    deduped_12_1 := deduped_19_1 * deduped_14_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_14_1, deduped_21_1 );
    deduped_10_1 := deduped_14_1 * deduped_18_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_13_1, deduped_21_1 );
    deduped_8_1 := deduped_13_1 * deduped_14_1;
    deduped_7_1 := deduped_18_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_21_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_8_1 ), KroneckerMat( ConvertMatrixToRow( deduped_15_1 ), deduped_6_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_16_1, deduped_21_1 ), List( [ 1 .. deduped_16_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                    end ) ), deduped_6_1 ) * KroneckerMat( deduped_15_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_21_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_15_1, (KroneckerMat( deduped_9_1, CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_21_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                        end ) ) ) * KroneckerMat( (KroneckerMat( CertainRows( deduped_9_1, List( [ 1 .. deduped_13_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                            end ) ), deduped_15_1 ) * KroneckerMat( deduped_17_1, ConvertMatrixToColumn( deduped_15_1 ) )), deduped_11_1 ) * CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_21_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ) * (KroneckerMat( CertainRows( deduped_11_1, List( [ 1 .. deduped_14_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                      end ) ), deduped_17_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_20_1, deduped_21_1 ), ConvertMatrixToColumn( deduped_17_1 ) ))) ), AsCapCategoryObject( cat_1, deduped_18_1 * deduped_20_1 ) );
end
########
        
    ;
    
    ##
    AddMonoidalPreComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
    deduped_21_1 := AsInteger( c_1 );
    deduped_20_1 := AsInteger( b_1 );
    deduped_19_1 := AsInteger( s_1 );
    deduped_18_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := AsInteger( a_1 );
    deduped_16_1 := HomalgIdentityMatrix( deduped_20_1, deduped_18_1 );
    deduped_15_1 := deduped_20_1 * deduped_21_1;
    deduped_14_1 := deduped_17_1 * deduped_20_1;
    deduped_13_1 := deduped_17_1 * deduped_19_1;
    deduped_12_1 := deduped_17_1 * deduped_17_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_19_1, deduped_18_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_17_1, deduped_18_1 );
    deduped_9_1 := deduped_20_1 * deduped_15_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_15_1, deduped_18_1 );
    deduped_7_1 := deduped_15_1 * deduped_17_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_14_1, deduped_18_1 );
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( ConvertMatrixToRow( deduped_10_1 ), deduped_11_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_18_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                    end ) ), deduped_11_1 ) * KroneckerMat( deduped_10_1, CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_18_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_10_1, (KroneckerMat( deduped_6_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_18_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                        end ) ) ) * KroneckerMat( (KroneckerMat( CertainRows( deduped_6_1, List( [ 1 .. deduped_14_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                            end ) ), deduped_10_1 ) * KroneckerMat( deduped_16_1, ConvertMatrixToColumn( deduped_10_1 ) )), deduped_8_1 ) * CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_18_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                    end ) ) * (KroneckerMat( CertainRows( deduped_8_1, List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_21_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_21_1 ) + 1);
                      end ) ), deduped_16_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_21_1, deduped_18_1 ), ConvertMatrixToColumn( deduped_16_1 ) ))) ), r_1 );
end
########
        
    , 13351 : IsPrecompiledDerivation := true );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return AsCapCategoryMorphism( cat_1, A_1, HomalgIdentityMatrix( AsInteger( A_1 ), UnderlyingRing( cat_1 ) ), A_1 );
end
########
        
    , 100 );
    
    ##
    AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1, I_1 )
    return AsCapCategoryMorphism( cat_1, A_1, HomalgIdentityMatrix( AsInteger( A_1 ), UnderlyingRing( cat_1 ) ), A_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismBetweenDirectSums( cat,
        
########
function ( cat_1, source_diagram_1, mat_1, range_diagram_1 )
    local morphism_attr_1_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := UnionOfRows( deduped_3_1, Sum( List( range_diagram_1, AsInteger ) ), ListN( source_diagram_1, mat_1, function ( source_2, row_2 )
              return UnionOfColumns( deduped_3_1, AsInteger( source_2 ), List( row_2, AsHomalgMatrix ) );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 502 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismBetweenDirectSums :=
        
########
function ( cat_1, source_diagram_1, mat_1, range_diagram_1 )
    local deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := Sum( List( range_diagram_1, AsInteger ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( source_diagram_1, AsInteger ) ) ), UnionOfRows( deduped_3_1, deduped_2_1, ListN( source_diagram_1, mat_1, function ( source_2, row_2 )
                return UnionOfColumns( deduped_3_1, AsInteger( source_2 ), List( row_2, AsHomalgMatrix ) );
            end ) ), AsCapCategoryObject( cat_1, deduped_2_1 ) );
end
########
        
    ;
    
    ##
    AddMorphismBetweenDirectSumsWithGivenDirectSums( cat,
        
########
function ( cat_1, S_1, source_diagram_1, mat_1, range_diagram_1, T_1 )
    local deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    return AsCapCategoryMorphism( cat_1, S_1, UnionOfRows( deduped_2_1, AsInteger( T_1 ), ListN( source_diagram_1, mat_1, function ( source_2, row_2 )
                return UnionOfColumns( deduped_2_1, AsInteger( source_2 ), List( row_2, AsHomalgMatrix ) );
            end ) ), T_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return AsCapCategoryMorphism( cat_1, arg2_1, arg3_1, arg4_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return AsHomalgMatrix( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismFromBidual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, a_1, UniqueRightDivide( deduped_1_1, deduped_1_1 ), a_1 );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingRing( cat_1 );
    return AsCapCategoryMorphism( cat_1, s_1, UniqueRightDivide( HomalgIdentityMatrix( AsInteger( s_1 ), deduped_1_1 ), HomalgIdentityMatrix( AsInteger( a_1 ), deduped_1_1 ) ), a_1 );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromCoBidual( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromCoBidualWithGivenCoBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    return AsCapCategoryMorphism( cat_1, s_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismFromCoimageToImage( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_3_1 ) );
    morphism_attr_1_1 := UniqueRightDivide( UniqueLeftDivide( BasisOfColumns( deduped_3_1 ), deduped_3_1 ), deduped_2_1 ) * UniqueRightDivide( HomalgIdentityMatrix( NumberRows( deduped_2_1 ), UnderlyingRing( cat_1 ) ), UniqueRightDivide( BasisOfRows( deduped_3_1 ), deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1609 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromCoimageToImage :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    deduped_1_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, ColumnRankOfMatrix( deduped_2_1 ) ), UniqueRightDivide( UniqueLeftDivide( BasisOfColumns( deduped_2_1 ), deduped_2_1 ), deduped_1_1 ) * UniqueRightDivide( HomalgIdentityMatrix( NumberRows( deduped_1_1 ), UnderlyingRing( cat_1 ) ), UniqueRightDivide( BasisOfRows( deduped_2_1 ), deduped_1_1 ) ), AsCapCategoryObject( cat_1, RowRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := AsHomalgMatrix( alpha_1 );
    deduped_2_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_3_1 ) );
    morphism_attr_1_1 := UniqueRightDivide( UniqueLeftDivide( BasisOfColumns( deduped_3_1 ), deduped_3_1 ), deduped_2_1 ) * UniqueRightDivide( HomalgIdentityMatrix( NumberRows( deduped_2_1 ), UnderlyingRing( cat_1 ) ), UniqueRightDivide( BasisOfRows( deduped_3_1 ), deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, C_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1408 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromCoimageToImageWithGivenObjects :=
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    deduped_1_1 := SyzygiesOfRows( SyzygiesOfColumns( deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, C_1, UniqueRightDivide( UniqueLeftDivide( BasisOfColumns( deduped_2_1 ), deduped_2_1 ), deduped_1_1 ) * UniqueRightDivide( HomalgIdentityMatrix( NumberRows( deduped_1_1 ), UnderlyingRing( cat_1 ) ), UniqueRightDivide( BasisOfRows( deduped_2_1 ), deduped_1_1 ) ), AsCapCategoryObject( cat_1, RowRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddMorphismFromEqualizerToSink( cat,
        
########
function ( cat_1, Y_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := SyzygiesOfRows( (UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} )) ) * deduped_4_1[1];
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_1_1 ) ), deduped_1_1, CAP_JIT_INCOMPLETE_LOGIC( Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ) ) );
end
########
        
    , 2919 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromEqualizerToSink :=
        
########
function ( cat_1, Y_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( Y_1 );
    deduped_1_1 := UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_2_1 - RowRankOfMatrix( deduped_1_1 ) ), SyzygiesOfRows( deduped_1_1 ) * deduped_4_1[1], List( morphisms_1, Range )[1] );
end
########
        
    ;
    
    ##
    AddMorphismFromEqualizerToSinkWithGivenEqualizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := SyzygiesOfRows( (UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} )) ) * deduped_4_1[1];
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_1_1 ) ), deduped_1_1, CAP_JIT_INCOMPLETE_LOGIC( Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ) ) );
end
########
        
    , 2920 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromEqualizerToSinkWithGivenEqualizer :=
        
########
function ( cat_1, Y_1, morphisms_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( Y_1 );
    deduped_1_1 := UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_2_1 - RowRankOfMatrix( deduped_1_1 ) ), SyzygiesOfRows( deduped_1_1 ) * deduped_4_1[1], List( morphisms_1, Range )[1] );
end
########
        
    ;
    
    ##
    AddMorphismFromFiberProductToSink( cat,
        
########
function ( cat_1, morphisms_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return UnionOfRows( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_1_2, deduped_10_1 ) ] ) * deduped_12_1[i_2];
        end );
    deduped_5_1 := CertainColumns( SyzygiesOfRows( (UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} )) ), [ (deduped_7_1 + 1) .. (deduped_7_1 + deduped_9_1[1]) ] ) * deduped_12_1[1];
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_5_1 ) ), deduped_5_1, CAP_JIT_INCOMPLETE_LOGIC( Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ) ) );
end
########
        
    , 9162 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromFiberProductToSink :=
        
########
function ( cat_1, morphisms_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return UnionOfRows( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_1_2, deduped_10_1 ) ] ) * deduped_12_1[i_2];
        end );
    deduped_5_1 := UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_8_1 - RowRankOfMatrix( deduped_5_1 ) ), CertainColumns( SyzygiesOfRows( deduped_5_1 ), [ (deduped_7_1 + 1) .. (deduped_7_1 + deduped_9_1[1]) ] ) * deduped_12_1[1], List( morphisms_1, Range )[1] );
end
########
        
    ;
    
    ##
    AddMorphismFromFiberProductToSinkWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return UnionOfRows( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_1_2, deduped_10_1 ) ] ) * deduped_12_1[i_2];
        end );
    deduped_5_1 := CertainColumns( SyzygiesOfRows( (UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} )) ), [ (deduped_7_1 + 1) .. (deduped_7_1 + deduped_9_1[1]) ] ) * deduped_12_1[1];
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_5_1 ) ), deduped_5_1, CAP_JIT_INCOMPLETE_LOGIC( Range( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ) ) );
end
########
        
    , 9163 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromFiberProductToSinkWithGivenFiberProduct :=
        
########
function ( cat_1, morphisms_1, P_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return UnionOfRows( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_1_2, deduped_10_1 ) ] ) * deduped_12_1[i_2];
        end );
    deduped_5_1 := UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_8_1 - RowRankOfMatrix( deduped_5_1 ) ), CertainColumns( SyzygiesOfRows( deduped_5_1 ), [ (deduped_7_1 + 1) .. (deduped_7_1 + deduped_9_1[1]) ] ) * deduped_12_1[1], List( morphisms_1, Range )[1] );
end
########
        
    ;
    
    ##
    AddMorphismFromInternalCoHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromInternalCoHomToTensorProduct :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddMorphismFromInternalCoHomToTensorProductWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromInternalCoHomToTensorProductWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddMorphismFromInternalHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromInternalHomToTensorProduct :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddMorphismFromInternalHomToTensorProductWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromInternalHomToTensorProductWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddMorphismFromKernelObjectToSink( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := Range( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( AsInteger( Source( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) ), AsInteger( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, deduped_2_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromKernelObjectToSink :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Range( alpha_1 );
    deduped_1_1 := AsInteger( Source( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_1_1 ), HomalgZeroMatrix( deduped_1_1, AsInteger( deduped_2_1 ), UnderlyingRing( cat_1 ) ), deduped_2_1 );
end
########
        
    ;
    
    ##
    AddMorphismFromKernelObjectToSinkWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := Range( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( AsInteger( Source( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) ), AsInteger( deduped_2_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, deduped_2_1 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromKernelObjectToSinkWithGivenKernelObject :=
        
########
function ( cat_1, alpha_1, P_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Range( alpha_1 );
    deduped_1_1 := AsInteger( Source( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_1_1 ), HomalgZeroMatrix( deduped_1_1, AsInteger( deduped_2_1 ), UnderlyingRing( cat_1 ) ), deduped_2_1 );
end
########
        
    ;
    
    ##
    AddMorphismFromSourceToCoequalizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := AsInteger( Y_1 );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_1_1 := deduped_2_1[1] * SyzygiesOfColumns( (UnionOfRows( deduped_3_1, deduped_4_1, deduped_2_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_3_1, deduped_4_1, deduped_2_1{[ 2 .. deduped_5_1 ]} )) );
    return AsCapCategoryMorphism( cat_1, CAP_JIT_INCOMPLETE_LOGIC( Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ) ), deduped_1_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ) );
end
########
        
    , 2925 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromSourceToCoequalizer :=
        
########
function ( cat_1, Y_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := AsInteger( Y_1 );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_1_1 := UnionOfRows( deduped_3_1, deduped_4_1, deduped_2_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_3_1, deduped_4_1, deduped_2_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, List( morphisms_1, Source )[1], deduped_2_1[1] * SyzygiesOfColumns( deduped_1_1 ), AsCapCategoryObject( cat_1, deduped_4_1 - RowRankOfMatrix( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddMorphismFromSourceToCoequalizerWithGivenCoequalizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := AsInteger( Y_1 );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_1_1 := deduped_2_1[1] * SyzygiesOfColumns( (UnionOfRows( deduped_3_1, deduped_4_1, deduped_2_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_3_1, deduped_4_1, deduped_2_1{[ 2 .. deduped_5_1 ]} )) );
    return AsCapCategoryMorphism( cat_1, CAP_JIT_INCOMPLETE_LOGIC( Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ) ), deduped_1_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ) );
end
########
        
    , 2926 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromSourceToCoequalizerWithGivenCoequalizer :=
        
########
function ( cat_1, Y_1, morphisms_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := AsInteger( Y_1 );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_1_1 := UnionOfRows( deduped_3_1, deduped_4_1, deduped_2_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_3_1, deduped_4_1, deduped_2_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, List( morphisms_1, Source )[1], deduped_2_1[1] * SyzygiesOfColumns( deduped_1_1 ), AsCapCategoryObject( cat_1, deduped_4_1 - RowRankOfMatrix( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddMorphismFromSourceToCokernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := Source( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( AsInteger( deduped_2_1 ), AsInteger( Range( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, deduped_2_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromSourceToCokernelObject :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Source( alpha_1 );
    deduped_1_1 := AsInteger( Range( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, deduped_2_1, HomalgZeroMatrix( AsInteger( deduped_2_1 ), deduped_1_1, UnderlyingRing( cat_1 ) ), AsCapCategoryObject( cat_1, deduped_1_1 ) );
end
########
        
    ;
    
    ##
    AddMorphismFromSourceToCokernelObjectWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := Source( alpha_1 );
    morphism_attr_1_1 := HomalgZeroMatrix( AsInteger( deduped_2_1 ), AsInteger( Range( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, deduped_2_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromSourceToCokernelObjectWithGivenCokernelObject :=
        
########
function ( cat_1, alpha_1, P_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Source( alpha_1 );
    deduped_1_1 := AsInteger( Range( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, deduped_2_1, HomalgZeroMatrix( AsInteger( deduped_2_1 ), deduped_1_1, UnderlyingRing( cat_1 ) ), AsCapCategoryObject( cat_1, deduped_1_1 ) );
end
########
        
    ;
    
    ##
    AddMorphismFromSourceToPushout( cat,
        
########
function ( cat_1, morphisms_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} );
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return deduped_10_1[i_2] * UnionOfColumns( deduped_11_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_11_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_11_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ (i_2 + 1) .. deduped_12_1 ]} ), deduped_11_1 ) ] );
        end );
    deduped_5_1 := deduped_10_1[1] * CertainRows( SyzygiesOfColumns( (UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) - UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} )) ), [ (deduped_7_1 + 1) .. (deduped_7_1 + deduped_9_1[1]) ] );
    return AsCapCategoryMorphism( cat_1, CAP_JIT_INCOMPLETE_LOGIC( Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ) ), deduped_5_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_5_1 ) ) );
end
########
        
    , 9181 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromSourceToPushout :=
        
########
function ( cat_1, morphisms_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} );
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return deduped_10_1[i_2] * UnionOfColumns( deduped_11_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_11_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_11_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ (i_2 + 1) .. deduped_12_1 ]} ), deduped_11_1 ) ] );
        end );
    deduped_5_1 := UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) - UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} );
    return AsCapCategoryMorphism( cat_1, List( morphisms_1, Source )[1], deduped_10_1[1] * CertainRows( SyzygiesOfColumns( deduped_5_1 ), [ (deduped_7_1 + 1) .. (deduped_7_1 + deduped_9_1[1]) ] ), AsCapCategoryObject( cat_1, deduped_8_1 - RowRankOfMatrix( deduped_5_1 ) ) );
end
########
        
    ;
    
    ##
    AddMorphismFromSourceToPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} );
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return deduped_10_1[i_2] * UnionOfColumns( deduped_11_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_11_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_11_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ (i_2 + 1) .. deduped_12_1 ]} ), deduped_11_1 ) ] );
        end );
    deduped_5_1 := deduped_10_1[1] * CertainRows( SyzygiesOfColumns( (UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) - UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} )) ), [ (deduped_7_1 + 1) .. (deduped_7_1 + deduped_9_1[1]) ] );
    return AsCapCategoryMorphism( cat_1, CAP_JIT_INCOMPLETE_LOGIC( Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[1] ) ) ), deduped_5_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_5_1 ) ) );
end
########
        
    , 9182 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromSourceToPushoutWithGivenPushout :=
        
########
function ( cat_1, morphisms_1, P_1 )
    local deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := Length( morphisms_1 );
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. 1 - 1 ]} );
    deduped_6_1 := List( [ 1 .. deduped_12_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return deduped_10_1[i_2] * UnionOfColumns( deduped_11_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_11_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_11_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_9_1{[ (i_2 + 1) .. deduped_12_1 ]} ), deduped_11_1 ) ] );
        end );
    deduped_5_1 := UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_12_1 - 1 ]} ) - UnionOfRows( deduped_11_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_12_1 ]} );
    return AsCapCategoryMorphism( cat_1, List( morphisms_1, Source )[1], deduped_10_1[1] * CertainRows( SyzygiesOfColumns( deduped_5_1 ), [ (deduped_7_1 + 1) .. (deduped_7_1 + deduped_9_1[1]) ] ), AsCapCategoryObject( cat_1, deduped_8_1 - RowRankOfMatrix( deduped_5_1 ) ) );
end
########
        
    ;
    
    ##
    AddMorphismFromTensorProductToInternalCoHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromTensorProductToInternalCoHom :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddMorphismFromTensorProductToInternalCoHomWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromTensorProductToInternalCoHomWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddMorphismFromTensorProductToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromTensorProductToInternalHom :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddMorphismFromTensorProductToInternalHomWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ) * AsInteger( b_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.MorphismFromTensorProductToInternalHomWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsInteger( a_1 ) * AsInteger( b_1 );
    deduped_1_1 := AsCapCategoryObject( cat_1, deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    ;
    
    ##
    AddMorphismToBidual( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismToBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), r_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismToCoBidual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, a_1, UniqueRightDivide( deduped_1_1, deduped_1_1 ), a_1 );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismToCoBidualWithGivenCoBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, a_1, UniqueRightDivide( deduped_1_1, deduped_1_1 ), r_1 );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, alpha_1 )
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), r_1 * AsHomalgMatrix( alpha_1 ), Range( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return AsCapCategoryObject( cat_1, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return AsInteger( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), AsHomalgMatrix( alpha_1 ) * AsHomalgMatrix( beta_1 ), Range( beta_1 ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddPostComposeList( cat,
        
########
function ( cat_1, source_1, list_of_morphisms_1, range_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingRing( cat_1 );
    return AsCapCategoryMorphism( cat_1, source_1, Iterated( List( list_of_morphisms_1, AsHomalgMatrix ), function ( alpha_2, beta_2 )
              return beta_2 * alpha_2;
          end, HomalgIdentityMatrix( AsInteger( range_1 ), deduped_1_1 ), HomalgIdentityMatrix( AsInteger( source_1 ), deduped_1_1 ) ), range_1 );
end
########
        
    , 403 : IsPrecompiledDerivation := true );
    
    ##
    AddPostInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := Source( alpha_1 );
    return AsCapCategoryMorphism( cat_1, Range( alpha_1 ), SafeLeftDivide( AsHomalgMatrix( alpha_1 ), HomalgIdentityMatrix( AsInteger( deduped_1_1 ), UnderlyingRing( cat_1 ) ) ), deduped_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), AsHomalgMatrix( alpha_1 ) * AsHomalgMatrix( beta_1 ), Range( beta_1 ) );
end
########
        
    , 100 );
    
    ##
    AddPreComposeList( cat,
        
########
function ( cat_1, source_1, list_of_morphisms_1, range_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingRing( cat_1 );
    return AsCapCategoryMorphism( cat_1, source_1, Iterated( List( list_of_morphisms_1, AsHomalgMatrix ), function ( alpha_2, beta_2 )
              return alpha_2 * beta_2;
          end, HomalgIdentityMatrix( AsInteger( source_1 ), deduped_1_1 ), HomalgIdentityMatrix( AsInteger( range_1 ), deduped_1_1 ) ), range_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddPreInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := Range( alpha_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, SafeRightDivide( HomalgIdentityMatrix( AsInteger( deduped_1_1 ), UnderlyingRing( cat_1 ) ), AsHomalgMatrix( alpha_1 ) ), Source( alpha_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := List( objects_1, AsInteger );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := deduped_4_1[k_1];
    morphism_attr_1_1 := UnionOfRows( deduped_3_1, deduped_2_1, [ HomalgZeroMatrix( Sum( deduped_4_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_4_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1, deduped_3_1 ) ] );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, objects_1[k_1] );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ProjectionInFactorOfDirectProduct :=
        
########
function ( cat_1, objects_1, k_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( objects_1, AsInteger );
    deduped_1_1 := deduped_2_1[k_1];
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( deduped_2_1 ) ), UnionOfRows( deduped_3_1, deduped_1_1, [ HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_3_1 ) ] ), objects_1[k_1] );
end
########
        
    ;
    
    ##
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := List( objects_1, AsInteger );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := deduped_4_1[k_1];
    morphism_attr_1_1 := UnionOfRows( deduped_3_1, deduped_2_1, [ HomalgZeroMatrix( Sum( deduped_4_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_4_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1, deduped_3_1 ) ] );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, objects_1[k_1] );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ProjectionInFactorOfDirectProductWithGivenDirectProduct :=
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( objects_1, AsInteger );
    deduped_1_1 := deduped_2_1[k_1];
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( deduped_2_1 ) ), UnionOfRows( deduped_3_1, deduped_1_1, [ HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_3_1 ) ] ), objects_1[k_1] );
end
########
        
    ;
    
    ##
    AddProjectionInFactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := List( objects_1, AsInteger );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := deduped_4_1[k_1];
    morphism_attr_1_1 := UnionOfRows( deduped_3_1, deduped_2_1, [ HomalgZeroMatrix( Sum( deduped_4_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_4_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1, deduped_3_1 ) ] );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, objects_1[k_1] );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ProjectionInFactorOfDirectSum :=
        
########
function ( cat_1, objects_1, k_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( objects_1, AsInteger );
    deduped_1_1 := deduped_2_1[k_1];
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( deduped_2_1 ) ), UnionOfRows( deduped_3_1, deduped_1_1, [ HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_3_1 ) ] ), objects_1[k_1] );
end
########
        
    ;
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := List( objects_1, AsInteger );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := deduped_3_1[k_1];
    return AsCapCategoryMorphism( cat_1, P_1, UnionOfRows( deduped_2_1, deduped_1_1, [ HomalgZeroMatrix( Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_2_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ), HomalgZeroMatrix( Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_2_1 ) ] ), objects_1[k_1] );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    deduped_6_1 := Sum( deduped_8_1{[ 1 .. k_1 - 1 ]} );
    deduped_5_1 := List( [ 1 .. deduped_10_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_8_1[i_2];
            return UnionOfRows( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_8_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( Sum( deduped_8_1{[ (i_2 + 1) .. deduped_10_1 ]} ), deduped_1_2, deduped_9_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) );
        end );
    deduped_4_1 := CertainColumns( SyzygiesOfRows( UnionOfColumns( deduped_9_1, deduped_7_1, deduped_5_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_5_1{[ 2 .. deduped_10_1 ]} ) ), [ deduped_6_1 + 1 .. deduped_6_1 + deduped_8_1[k_1] ] );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, CAP_JIT_INCOMPLETE_LOGIC( Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[k_1] ) ) ) );
end
########
        
    , 9061 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ProjectionInFactorOfFiberProduct :=
        
########
function ( cat_1, morphisms_1, k_1 )
    local hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} );
    hoisted_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return UnionOfRows( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_1_2, deduped_10_1 ) ] ) * hoisted_4_1[i_2];
        end );
    deduped_5_1 := UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_8_1 - RowRankOfMatrix( deduped_5_1 ) ), CertainColumns( SyzygiesOfRows( deduped_5_1 ), [ deduped_7_1 + 1 .. deduped_7_1 + deduped_9_1[k_1] ] ), List( morphisms_1, Source )[k_1] );
end
########
        
    ;
    
    ##
    AddProjectionInFactorOfFiberProductWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    deduped_6_1 := Sum( deduped_8_1{[ 1 .. k_1 - 1 ]} );
    deduped_5_1 := List( [ 1 .. deduped_10_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_8_1[i_2];
            return UnionOfRows( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_8_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( Sum( deduped_8_1{[ (i_2 + 1) .. deduped_10_1 ]} ), deduped_1_2, deduped_9_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) );
        end );
    deduped_4_1 := CertainColumns( SyzygiesOfRows( UnionOfColumns( deduped_9_1, deduped_7_1, deduped_5_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_5_1{[ 2 .. deduped_10_1 ]} ) ), [ deduped_6_1 + 1 .. deduped_6_1 + deduped_8_1[k_1] ] );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, CAP_JIT_INCOMPLETE_LOGIC( Source( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[k_1] ) ) ) );
end
########
        
    , 9062 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ProjectionInFactorOfFiberProductWithGivenFiberProduct :=
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Length( morphisms_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := Sum( deduped_9_1 );
    deduped_7_1 := Sum( deduped_9_1{[ 1 .. k_1 - 1 ]} );
    hoisted_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_6_1 := List( [ 1 .. deduped_11_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_9_1[i_2];
            return UnionOfRows( deduped_10_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_9_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_10_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_10_1 ), HomalgZeroMatrix( Sum( deduped_9_1{[ (i_2 + 1) .. deduped_11_1 ]} ), deduped_1_2, deduped_10_1 ) ] ) * hoisted_4_1[i_2];
        end );
    deduped_5_1 := UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 1 .. deduped_11_1 - 1 ]} ) - UnionOfColumns( deduped_10_1, deduped_8_1, deduped_6_1{[ 2 .. deduped_11_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_8_1 - RowRankOfMatrix( deduped_5_1 ) ), CertainColumns( SyzygiesOfRows( deduped_5_1 ), [ deduped_7_1 + 1 .. deduped_7_1 + deduped_9_1[k_1] ] ), List( morphisms_1, Source )[k_1] );
end
########
        
    ;
    
    ##
    AddProjectionOntoCoequalizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := SyzygiesOfColumns( UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} ) );
    return AsCapCategoryMorphism( cat_1, Y_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 2823 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ProjectionOntoCoequalizer :=
        
########
function ( cat_1, Y_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, Y_1, SyzygiesOfColumns( deduped_1_1 ), AsCapCategoryObject( cat_1, deduped_3_1 - RowRankOfMatrix( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddProjectionOntoCoequalizerWithGivenCoequalizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := SyzygiesOfColumns( UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} ) );
    return AsCapCategoryMorphism( cat_1, Y_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 2824 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.ProjectionOntoCoequalizerWithGivenCoequalizer :=
        
########
function ( cat_1, Y_1, morphisms_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, Y_1, SyzygiesOfColumns( deduped_1_1 ), AsCapCategoryObject( cat_1, deduped_3_1 - RowRankOfMatrix( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddProjectiveLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), SafeRightDivide( AsHomalgMatrix( alpha_1 ), AsHomalgMatrix( beta_1 ) ), Source( beta_1 ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddPushout( cat,
        
########
function ( cat_1, morphisms_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := Length( morphisms_1 );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_5_1 := Sum( deduped_6_1 );
    deduped_4_1 := List( [ 1 .. deduped_8_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_6_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) ) * UnionOfColumns( deduped_7_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_6_1{[ 1 .. (i_2 - 1) ]} ), deduped_7_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_7_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_6_1{[ (i_2 + 1) .. deduped_8_1 ]} ), deduped_7_1 ) ] );
        end );
    return AsCapCategoryObject( cat_1, deduped_5_1 - RowRankOfMatrix( (UnionOfRows( deduped_7_1, deduped_5_1, deduped_4_1{[ 1 .. deduped_8_1 - 1 ]} ) - UnionOfRows( deduped_7_1, deduped_5_1, deduped_4_1{[ 2 .. deduped_8_1 ]} )) ) );
end
########
        
    , 4338 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.Pushout :=
        
########
function ( cat_1, morphisms_1 )
    local hoisted_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphisms_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    hoisted_1_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return hoisted_1_1[i_2] * UnionOfColumns( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_8_1 ) ] );
        end );
    return AsCapCategoryObject( cat_1, deduped_6_1 - RowRankOfMatrix( (UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} )) ) );
end
########
        
    ;
    
    ##
    AddPushoutFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := Length( morphismsp_1 );
    deduped_16_1 := Length( morphisms_1 );
    deduped_15_1 := UnderlyingRing( cat_1 );
    deduped_14_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_13_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_12_1 := Sum( deduped_14_1 );
    deduped_11_1 := Sum( deduped_13_1 );
    deduped_10_1 := List( [ 1 .. deduped_17_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_14_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphismsp_1[i_2] ) ) ) * UnionOfColumns( deduped_15_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_14_1{[ 1 .. (i_2 - 1) ]} ), deduped_15_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_15_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_14_1{[ (i_2 + 1) .. deduped_17_1 ]} ), deduped_15_1 ) ] );
        end );
    deduped_9_1 := List( [ 1 .. deduped_16_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_13_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) ) * UnionOfColumns( deduped_15_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_13_1{[ 1 .. (i_2 - 1) ]} ), deduped_15_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_15_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_13_1{[ (i_2 + 1) .. deduped_16_1 ]} ), deduped_15_1 ) ] );
        end );
    deduped_8_1 := UnionOfRows( deduped_15_1, deduped_12_1, deduped_10_1{[ 1 .. deduped_17_1 - 1 ]} ) - UnionOfRows( deduped_15_1, deduped_12_1, deduped_10_1{[ 2 .. deduped_17_1 ]} );
    hoisted_6_1 := SyzygiesOfColumns( deduped_8_1 );
    deduped_7_1 := UniqueLeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_15_1, deduped_11_1, deduped_9_1{[ 1 .. deduped_16_1 - 1 ]} ) - UnionOfRows( deduped_15_1, deduped_11_1, deduped_9_1{[ 2 .. deduped_16_1 ]} ) ), UnionOfRows( deduped_15_1, deduped_12_1 - RowRankOfMatrix( deduped_8_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( deduped_14_1{[ 1 .. i_2 - 1 ]} );
                return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( L_1[i_2] ) ) ) * CertainRows( hoisted_6_1, [ (deduped_1_2 + 1) .. (deduped_1_2 + deduped_14_1[i_2]) ] );
            end ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_7_1 ) ), deduped_7_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_7_1 ) ) );
end
########
        
    , 36322 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.PushoutFunctorial :=
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local hoisted_1_1, hoisted_5_1, hoisted_8_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
    deduped_21_1 := Length( morphismsp_1 );
    deduped_20_1 := Length( morphisms_1 );
    deduped_19_1 := UnderlyingRing( cat_1 );
    deduped_18_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_17_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_16_1 := Sum( deduped_18_1 );
    deduped_15_1 := Sum( deduped_17_1 );
    hoisted_5_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_14_1 := List( [ 1 .. deduped_21_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_18_1[i_2];
            return hoisted_5_1[i_2] * UnionOfColumns( deduped_19_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_18_1{[ 1 .. (i_2 - 1) ]} ), deduped_19_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_19_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_18_1{[ (i_2 + 1) .. deduped_21_1 ]} ), deduped_19_1 ) ] );
        end );
    hoisted_1_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_13_1 := List( [ 1 .. deduped_20_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_17_1[i_2];
            return hoisted_1_1[i_2] * UnionOfColumns( deduped_19_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_17_1{[ 1 .. (i_2 - 1) ]} ), deduped_19_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_19_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_17_1{[ (i_2 + 1) .. deduped_20_1 ]} ), deduped_19_1 ) ] );
        end );
    deduped_12_1 := UnionOfRows( deduped_19_1, deduped_16_1, deduped_14_1{[ 1 .. deduped_21_1 - 1 ]} ) - UnionOfRows( deduped_19_1, deduped_16_1, deduped_14_1{[ 2 .. deduped_21_1 ]} );
    deduped_11_1 := UnionOfRows( deduped_19_1, deduped_15_1, deduped_13_1{[ 1 .. deduped_20_1 - 1 ]} ) - UnionOfRows( deduped_19_1, deduped_15_1, deduped_13_1{[ 2 .. deduped_20_1 ]} );
    deduped_10_1 := deduped_16_1 - RowRankOfMatrix( deduped_12_1 );
    hoisted_9_1 := SyzygiesOfColumns( deduped_12_1 );
    hoisted_8_1 := List( L_1, AsHomalgMatrix );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_15_1 - RowRankOfMatrix( deduped_11_1 ) ), UniqueLeftDivide( SyzygiesOfColumns( deduped_11_1 ), UnionOfRows( deduped_19_1, deduped_10_1, List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := Sum( deduped_18_1{[ 1 .. i_2 - 1 ]} );
                  return hoisted_8_1[i_2] * CertainRows( hoisted_9_1, [ (deduped_1_2 + 1) .. (deduped_1_2 + deduped_18_1[i_2]) ] );
              end ) ) ), AsCapCategoryObject( cat_1, deduped_10_1 ) );
end
########
        
    ;
    
    ##
    AddPushoutFunctorialWithGivenPushouts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1;
    deduped_16_1 := Length( morphismsp_1 );
    deduped_15_1 := Length( morphisms_1 );
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_12_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_11_1 := Sum( deduped_13_1 );
    deduped_10_1 := Sum( deduped_12_1 );
    deduped_9_1 := List( [ 1 .. deduped_16_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_13_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphismsp_1[i_2] ) ) ) * UnionOfColumns( deduped_14_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_13_1{[ 1 .. (i_2 - 1) ]} ), deduped_14_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_14_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_13_1{[ (i_2 + 1) .. deduped_16_1 ]} ), deduped_14_1 ) ] );
        end );
    deduped_8_1 := List( [ 1 .. deduped_15_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_12_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) ) * UnionOfColumns( deduped_14_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_12_1{[ 1 .. (i_2 - 1) ]} ), deduped_14_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_14_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_12_1{[ (i_2 + 1) .. deduped_15_1 ]} ), deduped_14_1 ) ] );
        end );
    hoisted_6_1 := SyzygiesOfColumns( UnionOfRows( deduped_14_1, deduped_11_1, deduped_9_1{[ 1 .. deduped_16_1 - 1 ]} ) - UnionOfRows( deduped_14_1, deduped_11_1, deduped_9_1{[ 2 .. deduped_16_1 ]} ) );
    deduped_7_1 := UniqueLeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_14_1, deduped_10_1, deduped_8_1{[ 1 .. deduped_15_1 - 1 ]} ) - UnionOfRows( deduped_14_1, deduped_10_1, deduped_8_1{[ 2 .. deduped_15_1 ]} ) ), UnionOfRows( deduped_14_1, AsInteger( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := Sum( deduped_13_1{[ 1 .. i_2 - 1 ]} );
                return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( L_1[i_2] ) ) ) * CertainRows( hoisted_6_1, [ (deduped_1_2 + 1) .. (deduped_1_2 + deduped_13_1[i_2]) ] );
            end ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_7_1 ) ), deduped_7_1, Pp_1 );
end
########
        
    , 27645 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.PushoutFunctorialWithGivenPushouts :=
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local hoisted_1_1, hoisted_5_1, hoisted_6_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
    deduped_19_1 := Length( morphismsp_1 );
    deduped_18_1 := Length( morphisms_1 );
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := List( morphismsp_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_15_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_14_1 := Sum( deduped_16_1 );
    deduped_13_1 := Sum( deduped_15_1 );
    hoisted_6_1 := List( morphismsp_1, AsHomalgMatrix );
    deduped_12_1 := List( [ 1 .. deduped_19_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_16_1[i_2];
            return hoisted_6_1[i_2] * UnionOfColumns( deduped_17_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_16_1{[ 1 .. (i_2 - 1) ]} ), deduped_17_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_17_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_16_1{[ (i_2 + 1) .. deduped_19_1 ]} ), deduped_17_1 ) ] );
        end );
    hoisted_1_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_11_1 := List( [ 1 .. deduped_18_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_15_1[i_2];
            return hoisted_1_1[i_2] * UnionOfColumns( deduped_17_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_15_1{[ 1 .. (i_2 - 1) ]} ), deduped_17_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_17_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_15_1{[ (i_2 + 1) .. deduped_18_1 ]} ), deduped_17_1 ) ] );
        end );
    deduped_10_1 := UnionOfRows( deduped_17_1, deduped_13_1, deduped_11_1{[ 1 .. deduped_18_1 - 1 ]} ) - UnionOfRows( deduped_17_1, deduped_13_1, deduped_11_1{[ 2 .. deduped_18_1 ]} );
    hoisted_9_1 := SyzygiesOfColumns( UnionOfRows( deduped_17_1, deduped_14_1, deduped_12_1{[ 1 .. deduped_19_1 - 1 ]} ) - UnionOfRows( deduped_17_1, deduped_14_1, deduped_12_1{[ 2 .. deduped_19_1 ]} ) );
    hoisted_5_1 := List( L_1, AsHomalgMatrix );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_13_1 - RowRankOfMatrix( deduped_10_1 ) ), UniqueLeftDivide( SyzygiesOfColumns( deduped_10_1 ), UnionOfRows( deduped_17_1, AsInteger( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := Sum( deduped_16_1{[ 1 .. i_2 - 1 ]} );
                  return hoisted_5_1[i_2] * CertainRows( hoisted_9_1, [ (deduped_1_2 + 1) .. (deduped_1_2 + deduped_16_1[i_2]) ] );
              end ) ) ), Pp_1 );
end
########
        
    ;
    
    ##
    AddRankMorphism( cat,
        
########
function ( cat_1, a_1 )
    local deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsInteger( a_1 );
    deduped_4_1 := AsCapCategoryObject( cat_1, 1 );
    deduped_3_1 := deduped_5_1 * deduped_5_1;
    deduped_2_1 := HomalgIdentityMatrix( deduped_5_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_4_1, ConvertMatrixToRow( deduped_2_1 ) * CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_6_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_5_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_5_1 ) + 1);
                end ) ) * ConvertMatrixToColumn( deduped_2_1 ), deduped_4_1 );
end
########
        
    , 6930 : IsPrecompiledDerivation := true );
    
    ##
    AddRightDistributivityExpanding( cat,
        
########
function ( cat_1, L_1, a_1 )
    local morphism_attr_1_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( L_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := List( L_1, AsInteger );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_6_1 );
    morphism_attr_1_1 := UnionOfColumns( deduped_6_1, Sum( deduped_7_1 ) * deduped_8_1, List( [ 1 .. deduped_9_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_7_1[i_2];
              return KroneckerMat( UnionOfRows( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_7_1{[ 1 .. i_2 - 1 ]} ), deduped_1_2, deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( Sum( deduped_7_1{[ i_2 + 1 .. deduped_9_1 ]} ), deduped_1_2, deduped_6_1 ) ] ), hoisted_5_1 );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.RightDistributivityExpanding :=
        
########
function ( cat_1, L_1, a_1 )
    local hoisted_4_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( L_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := List( L_1, AsInteger );
    deduped_6_1 := Sum( deduped_7_1 ) * deduped_8_1;
    hoisted_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_6_1 ), UnionOfColumns( deduped_9_1, deduped_6_1, List( [ 1 .. deduped_10_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_7_1[i_2];
                return KroneckerMat( UnionOfRows( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_7_1{[ 1 .. i_2 - 1 ]} ), deduped_1_2, deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( Sum( deduped_7_1{[ i_2 + 1 .. deduped_10_1 ]} ), deduped_1_2, deduped_9_1 ) ] ), hoisted_4_1 );
            end ) ), AsCapCategoryObject( cat_1, Sum( List( L_1, function ( summand_2 )
                  return AsInteger( summand_2 ) * deduped_8_1;
              end ) ) ) );
end
########
        
    ;
    
    ##
    AddRightDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local morphism_attr_1_1, deduped_2_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( AsInteger( a_1 ), deduped_6_1 );
    deduped_2_1 := List( L_1, AsInteger );
    morphism_attr_1_1 := UnionOfColumns( deduped_6_1, AsInteger( s_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_2_1[i_2];
              return KroneckerMat( UnionOfRows( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. i_2 - 1 ]} ), deduped_1_2, deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ i_2 + 1 .. deduped_7_1 ]} ), deduped_1_2, deduped_6_1 ) ] ), hoisted_5_1 );
          end ) );
    return AsCapCategoryMorphism( cat_1, s_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.RightDistributivityExpandingWithGivenObjects :=
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local deduped_1_1, hoisted_4_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_6_1 );
    deduped_1_1 := List( L_1, AsInteger );
    return AsCapCategoryMorphism( cat_1, s_1, UnionOfColumns( deduped_6_1, AsInteger( s_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_1_1[i_2];
                return KroneckerMat( UnionOfRows( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_1_1{[ 1 .. i_2 - 1 ]} ), deduped_1_2, deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( Sum( deduped_1_1{[ i_2 + 1 .. deduped_7_1 ]} ), deduped_1_2, deduped_6_1 ) ] ), hoisted_4_1 );
            end ) ), AsCapCategoryObject( cat_1, Sum( List( L_1, function ( summand_2 )
                  return AsInteger( summand_2 ) * deduped_8_1;
              end ) ) ) );
end
########
        
    ;
    
    ##
    AddRightDistributivityFactoring( cat,
        
########
function ( cat_1, L_1, a_1 )
    local morphism_attr_1_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( L_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := List( L_1, AsInteger );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_6_1 );
    morphism_attr_1_1 := UnionOfRows( deduped_6_1, Sum( deduped_7_1 ) * deduped_8_1, List( [ 1 .. deduped_9_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_7_1[i_2];
              return KroneckerMat( UnionOfColumns( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ 1 .. i_2 - 1 ]} ), deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ i_2 + 1 .. deduped_9_1 ]} ), deduped_6_1 ) ] ), hoisted_5_1 );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.RightDistributivityFactoring :=
        
########
function ( cat_1, L_1, a_1 )
    local hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( L_1 );
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := List( L_1, AsInteger );
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := Sum( deduped_8_1 ) * deduped_9_1;
    hoisted_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_7_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( L_1, function ( summand_2 )
                  return AsInteger( summand_2 ) * deduped_9_1;
              end ) ) ), UnionOfRows( deduped_7_1, deduped_6_1, List( [ 1 .. deduped_10_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_8_1[i_2];
                return KroneckerMat( UnionOfColumns( deduped_7_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ 1 .. i_2 - 1 ]} ), deduped_7_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_7_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ i_2 + 1 .. deduped_10_1 ]} ), deduped_7_1 ) ] ), hoisted_5_1 );
            end ) ), AsCapCategoryObject( cat_1, deduped_6_1 ) );
end
########
        
    ;
    
    ##
    AddRightDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local morphism_attr_1_1, deduped_2_1, hoisted_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( AsInteger( a_1 ), deduped_6_1 );
    deduped_2_1 := List( L_1, AsInteger );
    morphism_attr_1_1 := UnionOfRows( deduped_6_1, AsInteger( r_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := deduped_2_1[i_2];
              return KroneckerMat( UnionOfColumns( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ 1 .. i_2 - 1 ]} ), deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ i_2 + 1 .. deduped_7_1 ]} ), deduped_6_1 ) ] ), hoisted_5_1 );
          end ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, r_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.RightDistributivityFactoringWithGivenObjects :=
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local deduped_2_1, hoisted_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := Length( L_1 );
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_6_1 );
    deduped_2_1 := List( L_1, AsInteger );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( L_1, function ( summand_2 )
                  return AsInteger( summand_2 ) * deduped_8_1;
              end ) ) ), UnionOfRows( deduped_6_1, AsInteger( r_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := deduped_2_1[i_2];
                return KroneckerMat( UnionOfColumns( deduped_6_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ 1 .. i_2 - 1 ]} ), deduped_6_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_6_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_2_1{[ i_2 + 1 .. deduped_7_1 ]} ), deduped_6_1 ) ] ), hoisted_5_1 );
            end ) ), r_1 );
end
########
        
    ;
    
    ##
    AddRightUnitor( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgIdentityMatrix( AsInteger( a_1 ), UnderlyingRing( cat_1 ) ), a_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddSimplifyRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    return AsCapCategoryMorphism( cat_1, Source( mor_1 ), SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( AsHomalgMatrix( mor_1 ) )[1], Range( mor_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Range( mor_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( AsHomalgMatrix( mor_1 ) )[2], deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Range( mor_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( AsHomalgMatrix( mor_1 ) )[3], deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    return AsCapCategoryMorphism( cat_1, Source( mor_1 ), SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( AsHomalgMatrix( mor_1 ) )[1], Range( mor_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    return AsCapCategoryMorphism( cat_1, Source( mor_1 ), SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( mor_1 ) )[1], Range( mor_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Range( mor_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( mor_1 ) )[3], deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Source( mor_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( mor_1 ) )[4], deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Range( mor_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( mor_1 ) )[5], deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Source( mor_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( mor_1 ) )[2], deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Source( mor_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( AsHomalgMatrix( mor_1 ) )[3], deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Source( mor_1 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( AsHomalgMatrix( mor_1 ) )[2], deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSolveLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, hoisted_6_1, hoisted_7_1, deduped_10_1, hoisted_11_1, hoisted_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_15_1 := CAP_JIT_INCOMPLETE_LOGIC( arg3_1[1] );
    deduped_14_1 := CAP_JIT_INCOMPLETE_LOGIC( arg2_1[1] );
    deduped_13_1 := [ 1 .. CAP_JIT_INCOMPLETE_LOGIC( Length( deduped_14_1 ) ) ];
    hoisted_12_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_15_1, Source ) );
    hoisted_7_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_6_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    deduped_5_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_15_1, function ( logic_new_func_x_2 )
              return AsInteger( Source( logic_new_func_x_2 ) );
          end ) );
    deduped_4_1 := CAP_JIT_INCOMPLETE_LOGIC( List( deduped_14_1, function ( logic_new_func_x_2 )
              return AsInteger( Range( logic_new_func_x_2 ) );
          end ) );
    hoisted_3_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Range( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_2_1 := List( arg4_1, function ( logic_new_func_x_2 )
            return ConvertMatrixToRow( AsHomalgMatrix( logic_new_func_x_2 ) );
        end );
    hoisted_11_1 := SafeRightDivide( UnionOfColumns( deduped_17_1, 1, List( deduped_16_1, function ( i_2 )
                return hoisted_2_1[i_2];
            end ) ), UnionOfRows( deduped_17_1, Sum( List( deduped_16_1, function ( i_2 )
                  return CAP_JIT_INCOMPLETE_LOGIC( AsInteger( Source( CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( arg2_1[i_2] )[1] ) ) ) ) * hoisted_3_1[i_2][1];
              end ) ), List( deduped_13_1, function ( j_2 )
                return UnionOfColumns( deduped_17_1, deduped_4_1[j_2] * deduped_5_1[j_2], List( deduped_16_1, function ( i_3 )
                          return KroneckerMat( hoisted_6_1[i_3][j_2], hoisted_7_1[i_3][j_2] );
                      end ) );
            end ) ) );
    deduped_10_1 := List( deduped_13_1, function ( j_2 )
            return deduped_4_1[j_2] * deduped_5_1[j_2];
        end );
    return List( deduped_13_1, function ( j_2 )
            local deduped_1_2;
            deduped_1_2 := Sum( deduped_10_1{[ 1 .. j_2 - 1 ]} );
            return AsCapCategoryMorphism( cat_1, CAP_JIT_INCOMPLETE_LOGIC( Range( CAP_JIT_INCOMPLETE_LOGIC( deduped_14_1[j_2] ) ) ), ConvertRowToMatrix( CertainColumns( hoisted_11_1, [ deduped_1_2 + 1 .. deduped_1_2 + deduped_10_1[j_2] ] ), deduped_4_1[j_2], deduped_5_1[j_2] ), hoisted_12_1[j_2] );
        end );
end
########
        
    , 2906 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.SolveLinearSystemInAbCategory :=
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1, deduped_6_1, hoisted_7_1, hoisted_8_1, deduped_11_1, hoisted_12_1, hoisted_13_1, deduped_14_1, deduped_15_1, deduped_16_1;
    deduped_16_1 := UnderlyingRing( cat_1 );
    deduped_15_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_14_1 := [ 1 .. List( arg2_1, Length )[1] ];
    hoisted_13_1 := List( arg3_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, Source );
          end )[1];
    hoisted_8_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, AsHomalgMatrix );
        end );
    hoisted_7_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return TransposedMatrix( AsHomalgMatrix( logic_new_func_x_3 ) );
                end );
        end );
    deduped_6_1 := List( arg3_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Source( logic_new_func_x_3 ) );
                  end );
          end )[1];
    deduped_5_1 := List( arg2_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                      return AsInteger( Range( logic_new_func_x_3 ) );
                  end );
          end )[1];
    hoisted_4_1 := List( arg3_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Range( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_3_1 := List( arg2_1, function ( logic_new_func_list_2 )
            return List( logic_new_func_list_2, function ( logic_new_func_x_3 )
                    return AsInteger( Source( logic_new_func_x_3 ) );
                end );
        end );
    hoisted_2_1 := List( arg4_1, function ( logic_new_func_x_2 )
            return ConvertMatrixToRow( AsHomalgMatrix( logic_new_func_x_2 ) );
        end );
    hoisted_12_1 := SafeRightDivide( UnionOfColumns( deduped_16_1, 1, List( deduped_15_1, function ( i_2 )
                return hoisted_2_1[i_2];
            end ) ), UnionOfRows( deduped_16_1, Sum( List( deduped_15_1, function ( i_2 )
                  return hoisted_3_1[i_2][1] * hoisted_4_1[i_2][1];
              end ) ), List( deduped_14_1, function ( j_2 )
                return UnionOfColumns( deduped_16_1, deduped_5_1[j_2] * deduped_6_1[j_2], List( deduped_15_1, function ( i_3 )
                          return KroneckerMat( hoisted_7_1[i_3][j_2], hoisted_8_1[i_3][j_2] );
                      end ) );
            end ) ) );
    deduped_11_1 := List( deduped_14_1, function ( j_2 )
            return deduped_5_1[j_2] * deduped_6_1[j_2];
        end );
    hoisted_1_1 := List( arg2_1, function ( logic_new_func_list_2 )
              return List( logic_new_func_list_2, Range );
          end )[1];
    return List( deduped_14_1, function ( j_2 )
            local deduped_1_2;
            deduped_1_2 := Sum( deduped_11_1{[ 1 .. j_2 - 1 ]} );
            return AsCapCategoryMorphism( cat_1, hoisted_1_1[j_2], ConvertRowToMatrix( CertainColumns( hoisted_12_1, [ deduped_1_2 + 1 .. deduped_1_2 + deduped_11_1[j_2] ] ), deduped_5_1[j_2], deduped_6_1[j_2] ), hoisted_13_1[j_2] );
        end );
end
########
        
    ;
    
    ##
    AddSomeInjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return arg2_1;
end
########
        
    , 100 );
    
    ##
    AddSomeIsomorphismBetweenObjects( cat,
        
########
function ( cat_1, object_1_1, object_2_1 )
    return AsCapCategoryMorphism( cat_1, object_1_1, HomalgIdentityMatrix( AsInteger( object_1_1 ), UnderlyingRing( cat_1 ) ), object_1_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
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
    morphism_attr_1_1 := HomalgZeroMatrix( 0, AsInteger( Range( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 0 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 100 );
    
    ##
    cat!.cached_precompiled_functions.SomeReductionBySplitEpiSummand :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := AsInteger( Range( alpha_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 0 ), HomalgZeroMatrix( 0, deduped_1_1, UnderlyingRing( cat_1 ) ), AsCapCategoryObject( cat_1, deduped_1_1 ) );
end
########
        
    ;
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) );
    return AsCapCategoryMorphism( cat_1, Range( alpha_1 ), deduped_1_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_1_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) );
    morphism_attr_1_1 := SafeRightDivide( HomalgIdentityMatrix( NumberColumns( deduped_2_1 ), UnderlyingRing( cat_1 ) ), deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Range( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    cat!.cached_precompiled_functions.SomeReductionBySplitEpiSummand_MorphismToInputRange :=
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( AsHomalgMatrix( alpha_1 ) );
    deduped_1_1 := NumberColumns( deduped_2_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_1_1 ), SafeRightDivide( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ), deduped_2_1 ), Range( alpha_1 ) );
end
########
        
    ;
    
    ##
    AddSubtractionForMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, Source( alpha_1 ), AsHomalgMatrix( alpha_1 ) - AsHomalgMatrix( beta_1 ), Range( alpha_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddSumOfMorphisms( cat,
        
########
function ( cat_1, source_1, list_of_morphisms_1, range_1 )
    return AsCapCategoryMorphism( cat_1, source_1, Sum( List( list_of_morphisms_1, AsHomalgMatrix ), HomalgZeroMatrix( AsInteger( source_1 ), AsInteger( range_1 ), UnderlyingRing( cat_1 ) ) ), range_1 );
end
########
        
    , 100 );
    
    ##
    AddTensorProductDualityCompatibilityMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1;
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := AsInteger( b_1 );
    deduped_12_1 := AsInteger( a_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_13_1, deduped_14_1 );
    deduped_10_1 := deduped_13_1 * deduped_12_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_12_1, deduped_14_1 );
    deduped_8_1 := deduped_12_1 * deduped_13_1;
    deduped_7_1 := deduped_8_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_14_1 );
    deduped_5_1 := CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_14_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1;
          end ) );
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_6_1 ), deduped_6_1 ) * KroneckerMat( deduped_5_1, deduped_6_1 ) * KroneckerMat( deduped_6_1, deduped_5_1 ) * KroneckerMat( deduped_6_1, (KroneckerMat( KroneckerMat( deduped_9_1, CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_14_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_13_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                      end ) ) ), deduped_11_1 ) * KroneckerMat( KroneckerMat( ConvertMatrixToColumn( deduped_9_1 ), deduped_11_1 ), deduped_11_1 ) * ConvertMatrixToColumn( deduped_11_1 )) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 17673 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductDualityCompatibilityMorphism :=
        
########
function ( cat_1, a_1, b_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1;
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := AsInteger( b_1 );
    deduped_12_1 := AsInteger( a_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_13_1, deduped_14_1 );
    deduped_10_1 := deduped_13_1 * deduped_12_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_12_1, deduped_14_1 );
    deduped_8_1 := deduped_12_1 * deduped_13_1;
    deduped_7_1 := deduped_8_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_14_1 );
    deduped_5_1 := AsCapCategoryObject( cat_1, deduped_8_1 );
    deduped_4_1 := CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_14_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1;
          end ) );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, KroneckerMat( ConvertMatrixToRow( deduped_6_1 ), deduped_6_1 ) * KroneckerMat( deduped_4_1, deduped_6_1 ) * KroneckerMat( deduped_6_1, deduped_4_1 ) * KroneckerMat( deduped_6_1, (KroneckerMat( KroneckerMat( deduped_9_1, CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_14_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_13_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                        end ) ) ), deduped_11_1 ) * KroneckerMat( KroneckerMat( ConvertMatrixToColumn( deduped_9_1 ), deduped_11_1 ), deduped_11_1 ) * ConvertMatrixToColumn( deduped_11_1 )) ), deduped_5_1 );
end
########
        
    ;
    
    ##
    AddTensorProductDualityCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_12_1 := AsInteger( b_1 );
    deduped_11_1 := AsInteger( a_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_12_1, deduped_13_1 );
    deduped_9_1 := deduped_12_1 * deduped_11_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_11_1, deduped_13_1 );
    deduped_7_1 := deduped_11_1 * deduped_12_1;
    deduped_6_1 := deduped_7_1 * deduped_7_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_13_1 );
    deduped_4_1 := CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_13_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1;
          end ) );
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( ConvertMatrixToRow( deduped_5_1 ), deduped_5_1 ) * KroneckerMat( deduped_4_1, deduped_5_1 ) * KroneckerMat( deduped_5_1, deduped_4_1 ) * KroneckerMat( deduped_5_1, (KroneckerMat( KroneckerMat( deduped_8_1, CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_13_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                        end ) ) ), deduped_10_1 ) * KroneckerMat( KroneckerMat( ConvertMatrixToColumn( deduped_8_1 ), deduped_10_1 ), deduped_10_1 ) * ConvertMatrixToColumn( deduped_10_1 )) ), r_1 );
end
########
        
    , 17172 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphism( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := List( list_1, AsInteger );
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
    deduped_12_1 := deduped_18_1 * deduped_19_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_17_1, deduped_28_1 );
    deduped_10_1 := deduped_17_1 * deduped_12_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_12_1, deduped_28_1 );
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_11_1 ), deduped_9_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_28_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                  end ) ), deduped_9_1 ) * KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_28_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                end ) ) ) * KroneckerMat( deduped_11_1, (KroneckerMat( KroneckerMat( deduped_14_1, CertainRows( HomalgIdentityMatrix( deduped_15_1, deduped_28_1 ), List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                      end ) ) ), deduped_20_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( CertainRows( deduped_14_1, List( [ 1 .. deduped_18_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_25_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_25_1 ) + 1);
                          end ) ), deduped_21_1 ) * KroneckerMat( deduped_22_1, ConvertMatrixToColumn( deduped_21_1 ) )), deduped_16_1 ), deduped_20_1 ) * KroneckerMat( deduped_22_1, (KroneckerMat( CertainRows( deduped_16_1, List( [ 1 .. deduped_19_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_26_1 ) * deduped_24_1 + QUO_INT( deduped_1_2, deduped_26_1 ) + 1);
                      end ) ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_28_1 ), ConvertMatrixToColumn( deduped_20_1 ) )) )) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 15660 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductInternalHomCompatibilityMorphism :=
        
########
function ( cat_1, list_1 )
    local deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    deduped_26_1 := List( list_1, AsInteger );
    deduped_25_1 := deduped_26_1[4];
    deduped_24_1 := deduped_26_1[3];
    deduped_23_1 := deduped_26_1[2];
    deduped_22_1 := deduped_26_1[1];
    deduped_21_1 := HomalgIdentityMatrix( deduped_23_1, deduped_27_1 );
    deduped_20_1 := HomalgIdentityMatrix( deduped_22_1, deduped_27_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_24_1, deduped_27_1 );
    deduped_18_1 := deduped_22_1 * deduped_24_1;
    deduped_17_1 := deduped_24_1 * deduped_25_1;
    deduped_16_1 := deduped_22_1 * deduped_23_1;
    deduped_15_1 := HomalgIdentityMatrix( deduped_17_1, deduped_27_1 );
    deduped_14_1 := deduped_17_1 * deduped_22_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_16_1, deduped_27_1 );
    deduped_12_1 := deduped_18_1 * deduped_18_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_18_1, deduped_27_1 );
    deduped_10_1 := deduped_16_1 * deduped_17_1;
    deduped_9_1 := deduped_18_1 * deduped_10_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_10_1, deduped_27_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_10_1 ), KroneckerMat( ConvertMatrixToRow( deduped_11_1 ), deduped_8_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_27_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                    end ) ), deduped_8_1 ) * KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_27_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_11_1, (KroneckerMat( KroneckerMat( deduped_13_1, CertainRows( HomalgIdentityMatrix( deduped_14_1, deduped_27_1 ), List( [ 1 .. deduped_14_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_22_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_22_1 ) + 1);
                        end ) ) ), deduped_19_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( CertainRows( deduped_13_1, List( [ 1 .. deduped_16_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_22_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                            end ) ), deduped_20_1 ) * KroneckerMat( deduped_21_1, ConvertMatrixToColumn( deduped_20_1 ) )), deduped_15_1 ), deduped_19_1 ) * KroneckerMat( deduped_21_1, (KroneckerMat( CertainRows( deduped_15_1, List( [ 1 .. deduped_17_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_25_1 ) * deduped_24_1 + QUO_INT( deduped_1_2, deduped_25_1 ) + 1);
                        end ) ), deduped_19_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_25_1, deduped_27_1 ), ConvertMatrixToColumn( deduped_19_1 ) )) )) ), AsCapCategoryObject( cat_1, deduped_18_1 * (deduped_23_1 * deduped_25_1) ) );
end
########
        
    ;
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverse( cat,
        
########
function ( cat_1, list_1 )
    local morphism_attr_1_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := List( list_1, AsInteger );
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
    deduped_12_1 := deduped_18_1 * deduped_19_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_17_1, deduped_28_1 );
    deduped_10_1 := deduped_17_1 * deduped_12_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_12_1, deduped_28_1 );
    morphism_attr_1_1 := UniqueRightDivide( HomalgIdentityMatrix( deduped_17_1 * (deduped_25_1 * deduped_26_1), deduped_28_1 ), KroneckerMat( ConvertMatrixToRow( deduped_11_1 ), deduped_9_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_28_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                    end ) ), deduped_9_1 ) * KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_28_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_11_1, (KroneckerMat( KroneckerMat( deduped_14_1, CertainRows( HomalgIdentityMatrix( deduped_15_1, deduped_28_1 ), List( [ 1 .. deduped_15_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                        end ) ) ), deduped_20_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( CertainRows( deduped_14_1, List( [ 1 .. deduped_18_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_25_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_25_1 ) + 1);
                            end ) ), deduped_21_1 ) * KroneckerMat( deduped_22_1, ConvertMatrixToColumn( deduped_21_1 ) )), deduped_16_1 ), deduped_20_1 ) * KroneckerMat( deduped_22_1, (KroneckerMat( CertainRows( deduped_16_1, List( [ 1 .. deduped_19_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_26_1 ) * deduped_24_1 + QUO_INT( deduped_1_2, deduped_26_1 ) + 1);
                        end ) ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_28_1 ), ConvertMatrixToColumn( deduped_20_1 ) )) )) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 15862 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductInternalHomCompatibilityMorphismInverse :=
        
########
function ( cat_1, list_1 )
    local deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := List( list_1, AsInteger );
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
    deduped_12_1 := deduped_18_1 * deduped_19_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_17_1, deduped_28_1 );
    deduped_10_1 := deduped_17_1 * (deduped_25_1 * deduped_26_1);
    deduped_9_1 := deduped_17_1 * deduped_12_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_12_1, deduped_28_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_10_1 ), UniqueRightDivide( HomalgIdentityMatrix( deduped_10_1, deduped_28_1 ), KroneckerMat( ConvertMatrixToRow( deduped_11_1 ), deduped_8_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_28_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                      end ) ), deduped_8_1 ) * KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_28_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                    end ) ) ) * KroneckerMat( deduped_11_1, (KroneckerMat( KroneckerMat( deduped_14_1, CertainRows( HomalgIdentityMatrix( deduped_15_1, deduped_28_1 ), List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                          end ) ) ), deduped_20_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( CertainRows( deduped_14_1, List( [ 1 .. deduped_18_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, deduped_25_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_25_1 ) + 1);
                              end ) ), deduped_21_1 ) * KroneckerMat( deduped_22_1, ConvertMatrixToColumn( deduped_21_1 ) )), deduped_16_1 ), deduped_20_1 ) * KroneckerMat( deduped_22_1, (KroneckerMat( CertainRows( deduped_16_1, List( [ 1 .. deduped_19_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_26_1 ) * deduped_24_1 + QUO_INT( deduped_1_2, deduped_26_1 ) + 1);
                          end ) ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_28_1 ), ConvertMatrixToColumn( deduped_20_1 ) )) )) ) ), AsCapCategoryObject( cat_1, deduped_12_1 ) );
end
########
        
    ;
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := AsInteger( range_1 );
    deduped_26_1 := List( list_1, AsInteger );
    deduped_25_1 := UnderlyingRing( cat_1 );
    deduped_24_1 := deduped_26_1[4];
    deduped_23_1 := deduped_26_1[2];
    deduped_22_1 := HomalgIdentityMatrix( deduped_27_1, deduped_25_1 );
    deduped_21_1 := deduped_26_1[3];
    deduped_20_1 := deduped_26_1[1];
    deduped_19_1 := HomalgIdentityMatrix( deduped_23_1, deduped_25_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_25_1 );
    deduped_17_1 := HomalgIdentityMatrix( deduped_21_1, deduped_25_1 );
    deduped_16_1 := deduped_21_1 * deduped_24_1;
    deduped_15_1 := deduped_20_1 * deduped_23_1;
    deduped_14_1 := deduped_20_1 * deduped_21_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_16_1, deduped_25_1 );
    deduped_12_1 := deduped_16_1 * deduped_20_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_15_1, deduped_25_1 );
    deduped_10_1 := deduped_14_1 * deduped_27_1;
    deduped_9_1 := deduped_14_1 * deduped_14_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_14_1, deduped_25_1 );
    return AsCapCategoryMorphism( cat_1, source_1, UniqueRightDivide( HomalgIdentityMatrix( AsInteger( source_1 ), deduped_25_1 ), KroneckerMat( ConvertMatrixToRow( deduped_8_1 ), deduped_22_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_25_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                      end ) ), deduped_22_1 ) * KroneckerMat( deduped_8_1, CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_25_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_27_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_27_1 ) + 1);
                    end ) ) ) * KroneckerMat( deduped_8_1, (KroneckerMat( KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_25_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                          end ) ) ), deduped_17_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( CertainRows( deduped_11_1, List( [ 1 .. deduped_15_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                              end ) ), deduped_18_1 ) * KroneckerMat( deduped_19_1, ConvertMatrixToColumn( deduped_18_1 ) )), deduped_13_1 ), deduped_17_1 ) * KroneckerMat( deduped_19_1, (KroneckerMat( CertainRows( deduped_13_1, List( [ 1 .. deduped_16_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_24_1 ) * deduped_21_1 + QUO_INT( deduped_1_2, deduped_24_1 ) + 1);
                          end ) ), deduped_17_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_24_1, deduped_25_1 ), ConvertMatrixToColumn( deduped_17_1 ) )) )) ) ), range_1 );
end
########
        
    , 14655 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1;
    deduped_27_1 := AsInteger( source_1 );
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_25_1 := List( list_1, AsInteger );
    deduped_24_1 := deduped_25_1[4];
    deduped_23_1 := deduped_25_1[2];
    deduped_22_1 := HomalgIdentityMatrix( deduped_27_1, deduped_26_1 );
    deduped_21_1 := deduped_25_1[3];
    deduped_20_1 := deduped_25_1[1];
    deduped_19_1 := HomalgIdentityMatrix( deduped_23_1, deduped_26_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_26_1 );
    deduped_17_1 := HomalgIdentityMatrix( deduped_21_1, deduped_26_1 );
    deduped_16_1 := deduped_21_1 * deduped_24_1;
    deduped_15_1 := deduped_20_1 * deduped_23_1;
    deduped_14_1 := deduped_20_1 * deduped_21_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_16_1, deduped_26_1 );
    deduped_12_1 := deduped_16_1 * deduped_20_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_15_1, deduped_26_1 );
    deduped_10_1 := deduped_14_1 * deduped_27_1;
    deduped_9_1 := deduped_14_1 * deduped_14_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_14_1, deduped_26_1 );
    return AsCapCategoryMorphism( cat_1, source_1, KroneckerMat( ConvertMatrixToRow( deduped_8_1 ), deduped_22_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_26_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_22_1 ) * KroneckerMat( deduped_8_1, CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_26_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_27_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_27_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_8_1, (KroneckerMat( KroneckerMat( deduped_11_1, CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_26_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                        end ) ) ), deduped_17_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( CertainRows( deduped_11_1, List( [ 1 .. deduped_15_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                            end ) ), deduped_18_1 ) * KroneckerMat( deduped_19_1, ConvertMatrixToColumn( deduped_18_1 ) )), deduped_13_1 ), deduped_17_1 ) * KroneckerMat( deduped_19_1, (KroneckerMat( CertainRows( deduped_13_1, List( [ 1 .. deduped_16_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_24_1 ) * deduped_21_1 + QUO_INT( deduped_1_2, deduped_24_1 ) + 1);
                        end ) ), deduped_17_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_24_1, deduped_26_1 ), ConvertMatrixToColumn( deduped_17_1 ) )) )) ), range_1 );
end
########
        
    , 14453 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( AsHomalgMatrix( alpha_1 ), AsHomalgMatrix( beta_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductOnMorphisms :=
        
########
function ( cat_1, alpha_1, beta_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, AsInteger( Source( alpha_1 ) ) * AsInteger( Source( beta_1 ) ) ), KroneckerMat( AsHomalgMatrix( alpha_1 ), AsHomalgMatrix( beta_1 ) ), AsCapCategoryObject( cat_1, AsInteger( Range( alpha_1 ) ) * AsInteger( Range( beta_1 ) ) ) );
end
########
        
    ;
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    return AsCapCategoryMorphism( cat_1, s_1, KroneckerMat( AsHomalgMatrix( alpha_1 ), AsHomalgMatrix( beta_1 ) ), r_1 );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return AsCapCategoryObject( cat_1, AsInteger( arg2_1 ) * AsInteger( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductToInternalCoHomLeftAdjunctMorphism( cat,
        
########
function ( cat_1, b_1, c_1, g_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( c_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_10_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    morphism_attr_1_1 := KroneckerMat( deduped_4_1, AsHomalgMatrix( g_1 ) ) * (KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_7_1 ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, b_1 );
end
########
        
    , 5322 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductToInternalCoHomLeftAdjunctMorphism :=
        
########
function ( cat_1, b_1, c_1, g_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( b_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( c_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := deduped_9_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, AsInteger( Source( g_1 ) ) * deduped_7_1 ), KroneckerMat( deduped_3_1, AsHomalgMatrix( g_1 ) ) * (KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_8_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_6_1 )), b_1 );
end
########
        
    ;
    
    ##
    AddTensorProductToInternalCoHomLeftAdjunctMorphismWithGivenInternalCoHom( cat,
        
########
function ( cat_1, b_1, c_1, g_1, i_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( b_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( c_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := deduped_9_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, i_1, KroneckerMat( deduped_3_1, AsHomalgMatrix( g_1 ) ) * (KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_8_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_6_1 )), b_1 );
end
########
        
    , 5019 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductToInternalCoHomRightAdjunctMorphism( cat,
        
########
function ( cat_1, b_1, c_1, g_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := AsInteger( c_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := AsInteger( b_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_11_1, deduped_10_1 );
    deduped_7_1 := deduped_9_1 * deduped_9_1;
    deduped_6_1 := deduped_11_1 * deduped_9_1;
    deduped_5_1 := AsInteger( Range( g_1 ) );
    deduped_4_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    morphism_attr_1_1 := KroneckerMat( deduped_4_1, AsHomalgMatrix( g_1 ) * CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_10_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                end ) ) ) * (KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_10_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_8_1 ));
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, c_1 );
end
########
        
    , 5623 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductToInternalCoHomRightAdjunctMorphism :=
        
########
function ( cat_1, b_1, c_1, g_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( c_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( b_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_10_1 * deduped_8_1;
    deduped_4_1 := AsInteger( Range( g_1 ) );
    deduped_3_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, AsInteger( Source( g_1 ) ) * deduped_8_1 ), KroneckerMat( deduped_3_1, AsHomalgMatrix( g_1 ) * CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_9_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ) ) * (KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_7_1 )), c_1 );
end
########
        
    ;
    
    ##
    AddTensorProductToInternalCoHomRightAdjunctMorphismWithGivenInternalCoHom( cat,
        
########
function ( cat_1, b_1, c_1, g_1, i_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( c_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( b_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := deduped_10_1 * deduped_8_1;
    deduped_4_1 := AsInteger( Range( g_1 ) );
    deduped_3_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    return AsCapCategoryMorphism( cat_1, i_1, KroneckerMat( deduped_3_1, AsHomalgMatrix( g_1 ) * CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_9_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ) ) * (KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_7_1 )), c_1 );
end
########
        
    , 5320 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductToInternalHomLeftAdjunctMorphism( cat,
        
########
function ( cat_1, a_1, b_1, f_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( a_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( b_1 );
    deduped_7_1 := deduped_8_1 * deduped_10_1;
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_5_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ), deduped_5_1 ) * KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                end ) ) ) * KroneckerMat( deduped_4_1, AsHomalgMatrix( f_1 ) );
    return AsCapCategoryMorphism( cat_1, a_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 5322 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductToInternalHomLeftAdjunctMorphism :=
        
########
function ( cat_1, a_1, b_1, f_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( b_1 );
    deduped_6_1 := deduped_7_1 * deduped_9_1;
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, a_1, KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_4_1 ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_3_1, AsHomalgMatrix( f_1 ) ), AsCapCategoryObject( cat_1, deduped_7_1 * AsInteger( Range( f_1 ) ) ) );
end
########
        
    ;
    
    ##
    AddTensorProductToInternalHomLeftAdjunctMorphismWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, b_1, f_1, i_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( b_1 );
    deduped_6_1 := deduped_7_1 * deduped_9_1;
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, a_1, KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_4_1 ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_3_1, AsHomalgMatrix( f_1 ) ), i_1 );
end
########
        
    , 5019 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductToInternalHomLeftAdjunctionIsomorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1;
    deduped_16_1 := UnderlyingRing( cat_1 );
    deduped_15_1 := AsInteger( c_1 );
    deduped_14_1 := AsInteger( b_1 );
    deduped_13_1 := AsInteger( a_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_14_1, deduped_16_1 );
    deduped_11_1 := deduped_14_1 * deduped_15_1;
    deduped_10_1 := deduped_13_1 * deduped_11_1;
    deduped_9_1 := deduped_13_1 * deduped_14_1 * deduped_15_1;
    hoisted_8_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_16_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
              end ) ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_16_1 ), ConvertMatrixToColumn( deduped_12_1 ) );
    hoisted_2_1 := HomalgIdentityMatrix( deduped_10_1, deduped_16_1 );
    morphism_attr_1_1 := UniqueRightDivide( HomalgIdentityMatrix( deduped_9_1, deduped_16_1 ), UnionOfRows( deduped_16_1, deduped_9_1, List( [ 1 .. deduped_10_1 ], function ( i_2 )
                return ConvertMatrixToRow( KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_2_1, [ i_2 ] ), deduped_13_1, deduped_11_1 ), deduped_12_1 ) * hoisted_8_1 );
            end ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 8737 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductToInternalHomLeftAdjunctionIsomorphism :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local hoisted_1_1, hoisted_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1;
    deduped_15_1 := UnderlyingRing( cat_1 );
    deduped_14_1 := AsInteger( c_1 );
    deduped_13_1 := AsInteger( b_1 );
    deduped_12_1 := AsInteger( a_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_13_1, deduped_15_1 );
    deduped_10_1 := deduped_13_1 * deduped_14_1;
    deduped_9_1 := deduped_12_1 * deduped_10_1;
    deduped_8_1 := deduped_12_1 * deduped_13_1 * deduped_14_1;
    hoisted_7_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_15_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_13_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
              end ) ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_14_1, deduped_15_1 ), ConvertMatrixToColumn( deduped_11_1 ) );
    hoisted_1_1 := HomalgIdentityMatrix( deduped_9_1, deduped_15_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_8_1 ), UniqueRightDivide( HomalgIdentityMatrix( deduped_8_1, deduped_15_1 ), UnionOfRows( deduped_15_1, deduped_8_1, List( [ 1 .. deduped_9_1 ], function ( i_2 )
                  return ConvertMatrixToRow( KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_1_1, [ i_2 ] ), deduped_12_1, deduped_10_1 ), deduped_11_1 ) * hoisted_7_1 );
              end ) ) ), AsCapCategoryObject( cat_1, Sum( List( ListWithIdenticalEntries( deduped_9_1, AsCapCategoryObject( cat_1, 1 ) ), AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddTensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_2_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1;
    deduped_16_1 := AsInteger( c_1 );
    deduped_15_1 := AsInteger( b_1 );
    deduped_14_1 := AsInteger( a_1 );
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_12_1 := AsInteger( s_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_15_1, deduped_13_1 );
    deduped_10_1 := deduped_15_1 * deduped_16_1;
    deduped_9_1 := deduped_14_1 * deduped_10_1;
    hoisted_8_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_13_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
              end ) ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_16_1, deduped_13_1 ), ConvertMatrixToColumn( deduped_11_1 ) );
    hoisted_2_1 := HomalgIdentityMatrix( deduped_9_1, deduped_13_1 );
    morphism_attr_1_1 := UniqueRightDivide( HomalgIdentityMatrix( deduped_12_1, deduped_13_1 ), UnionOfRows( deduped_13_1, deduped_12_1, List( [ 1 .. deduped_9_1 ], function ( i_2 )
                return ConvertMatrixToRow( KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_2_1, [ i_2 ] ), deduped_14_1, deduped_10_1 ), deduped_11_1 ) * hoisted_8_1 );
            end ) ) );
    return AsCapCategoryMorphism( cat_1, s_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 8134 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local hoisted_1_1, hoisted_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1;
    deduped_15_1 := AsInteger( c_1 );
    deduped_14_1 := AsInteger( b_1 );
    deduped_13_1 := AsInteger( a_1 );
    deduped_12_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := AsInteger( s_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_14_1, deduped_12_1 );
    deduped_9_1 := deduped_14_1 * deduped_15_1;
    deduped_8_1 := deduped_13_1 * deduped_9_1;
    hoisted_7_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_9_1, deduped_12_1 ), List( [ 1 .. deduped_9_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
              end ) ), deduped_10_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_12_1 ), ConvertMatrixToColumn( deduped_10_1 ) );
    hoisted_1_1 := HomalgIdentityMatrix( deduped_8_1, deduped_12_1 );
    return AsCapCategoryMorphism( cat_1, s_1, UniqueRightDivide( HomalgIdentityMatrix( deduped_11_1, deduped_12_1 ), UnionOfRows( deduped_12_1, deduped_11_1, List( [ 1 .. deduped_8_1 ], function ( i_2 )
                  return ConvertMatrixToRow( KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_1_1, [ i_2 ] ), deduped_13_1, deduped_9_1 ), deduped_10_1 ) * hoisted_7_1 );
              end ) ) ), AsCapCategoryObject( cat_1, Sum( List( ListWithIdenticalEntries( deduped_8_1, AsCapCategoryObject( cat_1, 1 ) ), AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddTensorProductToInternalHomRightAdjunctMorphism( cat,
        
########
function ( cat_1, a_1, b_1, f_1 )
    local morphism_attr_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := AsInteger( b_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := AsInteger( a_1 );
    deduped_8_1 := deduped_11_1 * deduped_9_1;
    deduped_7_1 := deduped_9_1 * deduped_11_1;
    deduped_6_1 := deduped_9_1 * deduped_9_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_11_1, deduped_10_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_9_1, deduped_10_1 );
    morphism_attr_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_5_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_10_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ), deduped_5_1 ) * KroneckerMat( deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_10_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                end ) ) ) * KroneckerMat( deduped_4_1, (CertainRows( HomalgIdentityMatrix( deduped_8_1, deduped_10_1 ), List( [ 1 .. deduped_8_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := (i_2 - 1);
                    return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                end ) ) * AsHomalgMatrix( f_1 )) );
    return AsCapCategoryMorphism( cat_1, b_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 5624 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductToInternalHomRightAdjunctMorphism :=
        
########
function ( cat_1, a_1, b_1, f_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := deduped_10_1 * deduped_8_1;
    deduped_6_1 := deduped_8_1 * deduped_10_1;
    deduped_5_1 := deduped_8_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_4_1 ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_3_1, (CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ) * AsHomalgMatrix( f_1 )) ), AsCapCategoryObject( cat_1, deduped_8_1 * AsInteger( Range( f_1 ) ) ) );
end
########
        
    ;
    
    ##
    AddTensorProductToInternalHomRightAdjunctMorphismWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, b_1, f_1, i_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := AsInteger( b_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := AsInteger( a_1 );
    deduped_7_1 := deduped_10_1 * deduped_8_1;
    deduped_6_1 := deduped_8_1 * deduped_10_1;
    deduped_5_1 := deduped_8_1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_10_1, deduped_9_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_8_1, deduped_9_1 );
    return AsCapCategoryMorphism( cat_1, b_1, KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_4_1 ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_9_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_3_1, (CertainRows( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ) * AsHomalgMatrix( f_1 )) ), i_1 );
end
########
        
    , 5321 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductToInternalHomRightAdjunctionIsomorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local morphism_attr_1_1, hoisted_4_1, hoisted_8_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := AsInteger( c_1 );
    deduped_16_1 := AsInteger( b_1 );
    deduped_15_1 := AsInteger( a_1 );
    deduped_14_1 := HomalgIdentityMatrix( deduped_15_1, deduped_18_1 );
    deduped_13_1 := deduped_15_1 * deduped_17_1;
    deduped_12_1 := deduped_15_1 * deduped_16_1;
    deduped_11_1 := deduped_16_1 * deduped_13_1;
    deduped_10_1 := deduped_12_1 * deduped_17_1;
    hoisted_9_1 := CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_18_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_16_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1;
          end ) );
    hoisted_8_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_18_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
              end ) ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_18_1 ), ConvertMatrixToColumn( deduped_14_1 ) );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_11_1, deduped_18_1 );
    morphism_attr_1_1 := UniqueRightDivide( HomalgIdentityMatrix( deduped_10_1, deduped_18_1 ), UnionOfRows( deduped_18_1, deduped_10_1, List( [ 1 .. deduped_11_1 ], function ( i_2 )
                return ConvertMatrixToRow( hoisted_9_1 * (KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_4_1, [ i_2 ] ), deduped_16_1, deduped_13_1 ), deduped_14_1 ) * hoisted_8_1) );
            end ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 9339 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductToInternalHomRightAdjunctionIsomorphism :=
        
########
function ( cat_1, a_1, b_1, c_1 )
    local hoisted_3_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := AsInteger( c_1 );
    deduped_15_1 := AsInteger( b_1 );
    deduped_14_1 := AsInteger( a_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_14_1, deduped_17_1 );
    deduped_12_1 := deduped_14_1 * deduped_16_1;
    deduped_11_1 := deduped_14_1 * deduped_15_1;
    deduped_10_1 := deduped_15_1 * deduped_12_1;
    deduped_9_1 := deduped_11_1 * deduped_16_1;
    hoisted_8_1 := CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_17_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_15_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1;
          end ) );
    hoisted_7_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_17_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
              end ) ), deduped_13_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_16_1, deduped_17_1 ), ConvertMatrixToColumn( deduped_13_1 ) );
    hoisted_3_1 := HomalgIdentityMatrix( deduped_10_1, deduped_17_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_9_1 ), UniqueRightDivide( HomalgIdentityMatrix( deduped_9_1, deduped_17_1 ), UnionOfRows( deduped_17_1, deduped_9_1, List( [ 1 .. deduped_10_1 ], function ( i_2 )
                  return ConvertMatrixToRow( hoisted_8_1 * (KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_3_1, [ i_2 ] ), deduped_15_1, deduped_12_1 ), deduped_13_1 ) * hoisted_7_1) );
              end ) ) ), AsCapCategoryObject( cat_1, Sum( List( ListWithIdenticalEntries( deduped_10_1, AsCapCategoryObject( cat_1, 1 ) ), AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddTensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local morphism_attr_1_1, hoisted_4_1, hoisted_8_1, hoisted_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := AsInteger( c_1 );
    deduped_17_1 := AsInteger( a_1 );
    deduped_16_1 := AsInteger( b_1 );
    deduped_15_1 := UnderlyingRing( cat_1 );
    deduped_14_1 := AsInteger( s_1 );
    deduped_13_1 := deduped_17_1 * deduped_16_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_17_1, deduped_15_1 );
    deduped_11_1 := deduped_17_1 * deduped_18_1;
    deduped_10_1 := deduped_16_1 * deduped_11_1;
    hoisted_9_1 := CertainRows( HomalgIdentityMatrix( deduped_13_1, deduped_15_1 ), List( [ 1 .. deduped_13_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_16_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1;
          end ) );
    hoisted_8_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_11_1, deduped_15_1 ), List( [ 1 .. deduped_11_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
              end ) ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_18_1, deduped_15_1 ), ConvertMatrixToColumn( deduped_12_1 ) );
    hoisted_4_1 := HomalgIdentityMatrix( deduped_10_1, deduped_15_1 );
    morphism_attr_1_1 := UniqueRightDivide( HomalgIdentityMatrix( deduped_14_1, deduped_15_1 ), UnionOfRows( deduped_15_1, deduped_14_1, List( [ 1 .. deduped_10_1 ], function ( i_2 )
                return ConvertMatrixToRow( hoisted_9_1 * (KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_4_1, [ i_2 ] ), deduped_16_1, deduped_11_1 ), deduped_12_1 ) * hoisted_8_1) );
            end ) ) );
    return AsCapCategoryMorphism( cat_1, s_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 8736 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects :=
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local hoisted_3_1, hoisted_7_1, hoisted_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := AsInteger( c_1 );
    deduped_16_1 := AsInteger( a_1 );
    deduped_15_1 := AsInteger( b_1 );
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_13_1 := AsInteger( s_1 );
    deduped_12_1 := deduped_16_1 * deduped_15_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_16_1, deduped_14_1 );
    deduped_10_1 := deduped_16_1 * deduped_17_1;
    deduped_9_1 := deduped_15_1 * deduped_10_1;
    hoisted_8_1 := CertainRows( HomalgIdentityMatrix( deduped_12_1, deduped_14_1 ), List( [ 1 .. deduped_12_1 ], function ( i_2 )
              local deduped_1_2;
              deduped_1_2 := i_2 - 1;
              return REM_INT( deduped_1_2, deduped_15_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1;
          end ) );
    hoisted_7_1 := KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_10_1, deduped_14_1 ), List( [ 1 .. deduped_10_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := (i_2 - 1);
                  return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
              end ) ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_14_1 ), ConvertMatrixToColumn( deduped_11_1 ) );
    hoisted_3_1 := HomalgIdentityMatrix( deduped_9_1, deduped_14_1 );
    return AsCapCategoryMorphism( cat_1, s_1, UniqueRightDivide( HomalgIdentityMatrix( deduped_13_1, deduped_14_1 ), UnionOfRows( deduped_14_1, deduped_13_1, List( [ 1 .. deduped_9_1 ], function ( i_2 )
                  return ConvertMatrixToRow( hoisted_8_1 * (KroneckerMat( ConvertRowToMatrix( CertainRows( hoisted_3_1, [ i_2 ] ), deduped_15_1, deduped_10_1 ), deduped_11_1 ) * hoisted_7_1) );
              end ) ) ), AsCapCategoryObject( cat_1, Sum( List( ListWithIdenticalEntries( deduped_9_1, AsCapCategoryObject( cat_1, 1 ) ), AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return AsCapCategoryObject( cat_1, 1 );
end
########
        
    , 100 );
    
    ##
    AddTerminalObject( cat,
        
########
function ( cat_1 )
    return AsCapCategoryObject( cat_1, 0 );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddTerminalObjectFunctorial( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := AsCapCategoryObject( cat_1, 0 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddTerminalObjectFunctorialWithGivenTerminalObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return AsCapCategoryMorphism( cat_1, P_1, HomalgZeroMatrix( AsInteger( P_1 ), AsInteger( Pp_1 ), UnderlyingRing( cat_1 ) ), Pp_1 );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddTraceMap( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := AsCapCategoryObject( cat_1, 1 );
    deduped_4_1 := AsInteger( Source( alpha_1 ) );
    deduped_3_1 := deduped_4_1 * deduped_4_1;
    deduped_2_1 := HomalgIdentityMatrix( deduped_4_1, deduped_6_1 );
    return AsCapCategoryMorphism( cat_1, deduped_5_1, ConvertMatrixToRow( deduped_2_1 ) * CertainRows( HomalgIdentityMatrix( deduped_3_1, deduped_6_1 ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_4_1 ) * deduped_4_1 + QUO_INT( deduped_1_2, deduped_4_1 ) + 1);
                  end ) ) * KroneckerMat( deduped_2_1, AsHomalgMatrix( alpha_1 ) ) * ConvertMatrixToColumn( deduped_2_1 ), deduped_5_1 );
end
########
        
    , 6829 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromCoequalizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1, T_1, tau_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := UniqueLeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} ) ), AsHomalgMatrix( tau_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Range( tau_1 ) );
end
########
        
    , 2924 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismFromCoequalizer :=
        
########
function ( cat_1, Y_1, morphisms_1, T_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( Y_1 );
    deduped_1_1 := UnionOfRows( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_2_1 - RowRankOfMatrix( deduped_1_1 ) ), UniqueLeftDivide( SyzygiesOfColumns( deduped_1_1 ), AsHomalgMatrix( tau_1 ) ), Range( tau_1 ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismFromCoequalizerWithGivenCoequalizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := UniqueLeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} ) ), AsHomalgMatrix( tau_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Range( tau_1 ) );
end
########
        
    , 2925 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismFromCoequalizerWithGivenCoequalizer :=
        
########
function ( cat_1, Y_1, morphisms_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := AsInteger( Y_1 );
    deduped_1_1 := UnionOfRows( deduped_3_1, deduped_2_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfRows( deduped_3_1, deduped_2_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_2_1 - RowRankOfMatrix( deduped_1_1 ) ), UniqueLeftDivide( SyzygiesOfColumns( deduped_1_1 ), AsHomalgMatrix( tau_1 ) ), Range( tau_1 ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismFromCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, T_1 );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismFromCoproduct :=
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) ), UnionOfRows( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), T_1 );
end
########
        
    ;
    
    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, T_1 );
end
########
        
    , 505 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismFromCoproductWithGivenCoproduct :=
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) ), UnionOfRows( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), T_1 );
end
########
        
    ;
    
    ##
    AddUniversalMorphismFromDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, T_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismFromDirectSum :=
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) ), UnionOfRows( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), T_1 );
end
########
        
    ;
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return AsCapCategoryMorphism( cat_1, P_1, UnionOfRows( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), T_1 );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromImage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := tau_1[2];
    morphism_attr_1_1 := UniqueRightDivide( BasisOfRows( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( deduped_2_1 ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), morphism_attr_1_1, Source( deduped_2_1 ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismFromImage :=
        
########
function ( cat_1, alpha_1, tau_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := tau_1[2];
    deduped_1_1 := AsHomalgMatrix( alpha_1 );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, RowRankOfMatrix( deduped_1_1 ) ), UniqueRightDivide( BasisOfRows( deduped_1_1 ), AsHomalgMatrix( deduped_2_1 ) ), Source( deduped_2_1 ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismFromImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, tau_1, I_1 )
    local deduped_1_1;
    deduped_1_1 := tau_1[2];
    return AsCapCategoryMorphism( cat_1, I_1, UniqueRightDivide( BasisOfRows( AsHomalgMatrix( alpha_1 ) ), AsHomalgMatrix( deduped_1_1 ) ), Source( deduped_1_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromInitialObject( cat,
        
########
function ( cat_1, T_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 0 ), HomalgZeroMatrix( 0, AsInteger( T_1 ), UnderlyingRing( cat_1 ) ), T_1 );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return AsCapCategoryMorphism( cat_1, P_1, HomalgZeroMatrix( AsInteger( P_1 ), AsInteger( T_1 ), UnderlyingRing( cat_1 ) ), T_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromPushout( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphisms_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) ) * UnionOfColumns( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_8_1 ) ] );
        end );
    deduped_4_1 := UniqueLeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} ) ), UnionOfRows( deduped_8_1, AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, T_1 );
end
########
        
    , 9281 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismFromPushout :=
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local hoisted_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_1_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_8_1[i_2];
            return hoisted_1_1[i_2] * UnionOfColumns( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ 1 .. (i_2 - 1) ]} ), deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ (i_2 + 1) .. deduped_10_1 ]} ), deduped_9_1 ) ] );
        end );
    deduped_5_1 := UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_7_1 - RowRankOfMatrix( deduped_5_1 ) ), UniqueLeftDivide( SyzygiesOfColumns( deduped_5_1 ), UnionOfRows( deduped_9_1, AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ) ), T_1 );
end
########
        
    ;
    
    ##
    AddUniversalMorphismFromPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphisms_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) ) * UnionOfColumns( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_8_1 ) ] );
        end );
    deduped_4_1 := UniqueLeftDivide( SyzygiesOfColumns( UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfRows( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} ) ), UnionOfRows( deduped_8_1, AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ) );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, NumberRows( deduped_4_1 ) ), deduped_4_1, T_1 );
end
########
        
    , 9282 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismFromPushoutWithGivenPushout :=
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local hoisted_1_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Range( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_1_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_8_1[i_2];
            return hoisted_1_1[i_2] * UnionOfColumns( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ 1 .. (i_2 - 1) ]} ), deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_8_1{[ (i_2 + 1) .. deduped_10_1 ]} ), deduped_9_1 ) ] );
        end );
    deduped_5_1 := UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfRows( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} );
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, deduped_7_1 - RowRankOfMatrix( deduped_5_1 ) ), UniqueLeftDivide( SyzygiesOfColumns( deduped_5_1 ), UnionOfRows( deduped_9_1, AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ) ), T_1 );
end
########
        
    ;
    
    ##
    AddUniversalMorphismFromZeroObject( cat,
        
########
function ( cat_1, T_1 )
    return AsCapCategoryMorphism( cat_1, AsCapCategoryObject( cat_1, 0 ), HomalgZeroMatrix( 0, AsInteger( T_1 ), UnderlyingRing( cat_1 ) ), T_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return AsCapCategoryMorphism( cat_1, P_1, HomalgZeroMatrix( 0, AsInteger( T_1 ), UnderlyingRing( cat_1 ) ), T_1 );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoCoimage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := tau_1[1];
    morphism_attr_1_1 := UniqueLeftDivide( AsHomalgMatrix( deduped_2_1 ), BasisOfColumns( AsHomalgMatrix( alpha_1 ) ) );
    return AsCapCategoryMorphism( cat_1, Range( deduped_2_1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismIntoCoimage :=
        
########
function ( cat_1, alpha_1, tau_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := AsHomalgMatrix( alpha_1 );
    deduped_1_1 := tau_1[1];
    return AsCapCategoryMorphism( cat_1, Range( deduped_1_1 ), UniqueLeftDivide( AsHomalgMatrix( deduped_1_1 ), BasisOfColumns( deduped_2_1 ) ), AsCapCategoryObject( cat_1, ColumnRankOfMatrix( deduped_2_1 ) ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismIntoCoimageWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, tau_1, C_1 )
    local deduped_1_1;
    deduped_1_1 := tau_1[1];
    return AsCapCategoryMorphism( cat_1, Range( deduped_1_1 ), UniqueLeftDivide( AsHomalgMatrix( deduped_1_1 ), BasisOfColumns( AsHomalgMatrix( alpha_1 ) ) ), C_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) );
    return AsCapCategoryMorphism( cat_1, T_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismIntoDirectProduct :=
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    return AsCapCategoryMorphism( cat_1, T_1, UnionOfColumns( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) );
    return AsCapCategoryMorphism( cat_1, T_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismIntoDirectProductWithGivenDirectProduct :=
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return AsCapCategoryMorphism( cat_1, T_1, UnionOfColumns( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismIntoDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) );
    return AsCapCategoryMorphism( cat_1, T_1, morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismIntoDirectSum :=
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    return AsCapCategoryMorphism( cat_1, T_1, UnionOfColumns( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), AsCapCategoryObject( cat_1, Sum( List( objects_1, AsInteger ) ) ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return AsCapCategoryMorphism( cat_1, T_1, UnionOfColumns( UnderlyingRing( cat_1 ), AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), P_1 );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoEqualizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1, T_1, tau_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := UniqueRightDivide( AsHomalgMatrix( tau_1 ), SyzygiesOfRows( UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} ) ) );
    return AsCapCategoryMorphism( cat_1, Source( tau_1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 2919 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismIntoEqualizer :=
        
########
function ( cat_1, Y_1, morphisms_1, T_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, Source( tau_1 ), UniqueRightDivide( AsHomalgMatrix( tau_1 ), SyzygiesOfRows( deduped_1_1 ) ), AsCapCategoryObject( cat_1, deduped_3_1 - RowRankOfMatrix( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismIntoEqualizerWithGivenEqualizer( cat,
        
########
function ( cat_1, Y_1, morphisms_1, T_1, tau_1, P_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    morphism_attr_1_1 := UniqueRightDivide( AsHomalgMatrix( tau_1 ), SyzygiesOfRows( UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} ) ) );
    return AsCapCategoryMorphism( cat_1, Source( tau_1 ), morphism_attr_1_1, AsCapCategoryObject( cat_1, NumberColumns( morphism_attr_1_1 ) ) );
end
########
        
    , 2920 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismIntoEqualizerWithGivenEqualizer :=
        
########
function ( cat_1, Y_1, morphisms_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Length( morphisms_1 );
    deduped_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_3_1 := AsInteger( Y_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 1 .. deduped_5_1 - 1 ]} ) - UnionOfColumns( deduped_2_1, deduped_3_1, deduped_4_1{[ 2 .. deduped_5_1 ]} );
    return AsCapCategoryMorphism( cat_1, Source( tau_1 ), UniqueRightDivide( AsHomalgMatrix( tau_1 ), SyzygiesOfRows( deduped_1_1 ) ), AsCapCategoryObject( cat_1, deduped_3_1 - RowRankOfMatrix( deduped_1_1 ) ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismIntoFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphisms_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return UnionOfRows( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_1_2, deduped_8_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) );
        end );
    deduped_4_1 := UniqueRightDivide( UnionOfColumns( deduped_8_1, AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), SyzygiesOfRows( UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} ) ) );
    return AsCapCategoryMorphism( cat_1, T_1, deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 9263 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismIntoFiberProduct :=
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_8_1[i_2];
            return UnionOfRows( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_8_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( Sum( deduped_8_1{[ (i_2 + 1) .. deduped_10_1 ]} ), deduped_1_2, deduped_9_1 ) ] ) * hoisted_4_1[i_2];
        end );
    deduped_5_1 := UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} );
    return AsCapCategoryMorphism( cat_1, T_1, UniqueRightDivide( UnionOfColumns( deduped_9_1, AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), SyzygiesOfRows( deduped_5_1 ) ), AsCapCategoryObject( cat_1, deduped_7_1 - RowRankOfMatrix( deduped_5_1 ) ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismIntoFiberProductWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Length( morphisms_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_6_1 := Sum( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_7_1[i_2];
            return UnionOfRows( deduped_8_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_7_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_8_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_8_1 ), HomalgZeroMatrix( Sum( deduped_7_1{[ (i_2 + 1) .. deduped_9_1 ]} ), deduped_1_2, deduped_8_1 ) ] ) * CAP_JIT_INCOMPLETE_LOGIC( AsHomalgMatrix( CAP_JIT_INCOMPLETE_LOGIC( morphisms_1[i_2] ) ) );
        end );
    deduped_4_1 := UniqueRightDivide( UnionOfColumns( deduped_8_1, AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), SyzygiesOfRows( UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} ) - UnionOfColumns( deduped_8_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} ) ) );
    return AsCapCategoryMorphism( cat_1, T_1, deduped_4_1, AsCapCategoryObject( cat_1, NumberColumns( deduped_4_1 ) ) );
end
########
        
    , 9264 : IsPrecompiledDerivation := true );
    
    ##
    cat!.cached_precompiled_functions.UniversalMorphismIntoFiberProductWithGivenFiberProduct :=
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local hoisted_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1;
    deduped_10_1 := Length( morphisms_1 );
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( morphisms_1, function ( logic_new_func_x_2 )
            return AsInteger( Source( logic_new_func_x_2 ) );
        end );
    deduped_7_1 := Sum( deduped_8_1 );
    hoisted_4_1 := List( morphisms_1, AsHomalgMatrix );
    deduped_6_1 := List( [ 1 .. deduped_10_1 ], function ( i_2 )
            local deduped_1_2;
            deduped_1_2 := deduped_8_1[i_2];
            return UnionOfRows( deduped_9_1, deduped_1_2, [ HomalgZeroMatrix( Sum( deduped_8_1{[ 1 .. (i_2 - 1) ]} ), deduped_1_2, deduped_9_1 ), HomalgIdentityMatrix( deduped_1_2, deduped_9_1 ), HomalgZeroMatrix( Sum( deduped_8_1{[ (i_2 + 1) .. deduped_10_1 ]} ), deduped_1_2, deduped_9_1 ) ] ) * hoisted_4_1[i_2];
        end );
    deduped_5_1 := UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 1 .. deduped_10_1 - 1 ]} ) - UnionOfColumns( deduped_9_1, deduped_7_1, deduped_6_1{[ 2 .. deduped_10_1 ]} );
    return AsCapCategoryMorphism( cat_1, T_1, UniqueRightDivide( UnionOfColumns( deduped_9_1, AsInteger( T_1 ), List( tau_1, AsHomalgMatrix ) ), SyzygiesOfRows( deduped_5_1 ) ), AsCapCategoryObject( cat_1, deduped_7_1 - RowRankOfMatrix( deduped_5_1 ) ) );
end
########
        
    ;
    
    ##
    AddUniversalMorphismIntoTerminalObject( cat,
        
########
function ( cat_1, T_1 )
    return AsCapCategoryMorphism( cat_1, T_1, HomalgZeroMatrix( AsInteger( T_1 ), 0, UnderlyingRing( cat_1 ) ), AsCapCategoryObject( cat_1, 0 ) );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return AsCapCategoryMorphism( cat_1, T_1, HomalgZeroMatrix( AsInteger( T_1 ), AsInteger( P_1 ), UnderlyingRing( cat_1 ) ), P_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoZeroObject( cat,
        
########
function ( cat_1, T_1 )
    return AsCapCategoryMorphism( cat_1, T_1, HomalgZeroMatrix( AsInteger( T_1 ), 0, UnderlyingRing( cat_1 ) ), AsCapCategoryObject( cat_1, 0 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return AsCapCategoryMorphism( cat_1, T_1, HomalgZeroMatrix( AsInteger( T_1 ), 0, UnderlyingRing( cat_1 ) ), P_1 );
end
########
        
    , 100 );
    
    ##
    AddUniversalPropertyOfCoDual( cat,
        
########
function ( cat_1, t_1, a_1, alpha_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( t_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := deduped_9_1 * deduped_7_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, a_1, KroneckerMat( deduped_3_1, AsHomalgMatrix( alpha_1 ) ) * (KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_4_1, deduped_8_1 ), List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ) ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_3_1 ), deduped_6_1 )), t_1 );
end
########
        
    , 5626 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalPropertyOfDual( cat,
        
########
function ( cat_1, t_1, a_1, alpha_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := AsInteger( t_1 );
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := AsInteger( a_1 );
    deduped_6_1 := deduped_7_1 * deduped_9_1;
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_9_1, deduped_8_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_7_1, deduped_8_1 );
    return AsCapCategoryMorphism( cat_1, t_1, KroneckerMat( ConvertMatrixToRow( deduped_3_1 ), deduped_4_1 ) * KroneckerMat( CertainRows( HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_4_1 ) * KroneckerMat( deduped_3_1, CertainRows( HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ) ) * KroneckerMat( deduped_3_1, AsHomalgMatrix( alpha_1 ) ), a_1 );
end
########
        
    , 5626 : IsPrecompiledDerivation := true );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return AsCapCategoryMorphism( cat_1, a_1, HomalgZeroMatrix( AsInteger( a_1 ), AsInteger( b_1 ), UnderlyingRing( cat_1 ) ), b_1 );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return AsCapCategoryObject( cat_1, 0 );
end
########
        
    , 100 );
    
    ##
    AddZeroObjectFunctorial( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := AsCapCategoryObject( cat_1, 0 );
    return AsCapCategoryMorphism( cat_1, deduped_1_1, HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) ), deduped_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddZeroObjectFunctorialWithGivenZeroObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return AsCapCategoryMorphism( cat_1, P_1, HomalgZeroMatrix( AsInteger( P_1 ), 0, UnderlyingRing( cat_1 ) ), Pp_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "MatrixCategory_precompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( field )
    return MatrixCategory_as_CategoryOfRows( field );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_MatrixCategory_precompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
