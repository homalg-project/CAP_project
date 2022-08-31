# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_LeftPresentationsAsFreydCategoryOfCategoryOfRowsOfFieldPrecompiled", function ( cat )
    
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
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, UnderlyingMatrix( tau_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := Range( alpha_1 );
    deduped_2_1 := UnderlyingMatrix( deduped_3_1 );
    deduped_1_1 := NumberColumns( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_3_1, CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingMatrix, UnionOfRows( deduped_4_1, deduped_1_1, [ deduped_2_1, UnderlyingMatrix( alpha_1 ) ] ) ), UnderlyingMatrix, HomalgIdentityMatrix( deduped_1_1, deduped_4_1 ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingMatrix, DiagMat( UnderlyingRing( cat_1 ), List( arg2_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := NumberColumns( UnderlyingMatrix( A_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingMatrix, HomalgZeroMatrix( 0, deduped_1_1, deduped_2_1 ) ), A_1, UnderlyingMatrix, HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( NumberColumns( UnderlyingMatrix( a_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( objects_1, function ( logic_new_func_x_2 )
            return NumberColumns( UnderlyingMatrix( logic_new_func_x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], P_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg2_1 ) - UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( Range( arg2_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphisms( cat,
        
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
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( arg3_1 );
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    if NumberRows( deduped_1_1 ) = NumberRows( deduped_2_1 ) and NumberColumns( deduped_1_1 ) = NumberColumns( deduped_2_1 ) then
        return deduped_1_1 = deduped_2_1;
    else
        return false;
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddIsZeroForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( Range( arg2_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( objects_1, function ( logic_new_func_x_2 )
            return NumberColumns( UnderlyingMatrix( logic_new_func_x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, objects_1[k_1], UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), NumberColumns( UnderlyingMatrix( T_1 ) ), List( tau_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( 0, NumberColumns( UnderlyingMatrix( T_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), NumberColumns( UnderlyingMatrix( T_1 ) ), List( tau_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( NumberColumns( UnderlyingMatrix( T_1 ) ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( NumberColumns( UnderlyingMatrix( a_1 ) ), NumberColumns( UnderlyingMatrix( b_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingMatrix, HomalgZeroMatrix( 0, 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, HomalgIdentityMatrix( NumberColumns( UnderlyingMatrix( s_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, HomalgIdentityMatrix( NumberColumns( UnderlyingMatrix( s_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := NumberColumns( UnderlyingMatrix( b_1 ) );
    deduped_4_1 := NumberColumns( UnderlyingMatrix( a_1 ) );
    deduped_3_1 := deduped_4_1 * deduped_5_1;
    hoisted_2_1 := deduped_4_1;
    hoisted_1_1 := deduped_5_1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, hoisted_1_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_1_1 ) + 1;
                end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoevaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1;
    deduped_22_1 := UnderlyingMatrix( a_1 );
    deduped_21_1 := UnderlyingRing( cat_1 );
    deduped_20_1 := UnderlyingMatrix( b_1 );
    deduped_19_1 := NumberColumns( deduped_22_1 );
    deduped_18_1 := NumberColumns( deduped_20_1 );
    deduped_17_1 := deduped_19_1 * deduped_18_1;
    deduped_16_1 := deduped_18_1 * deduped_19_1;
    deduped_15_1 := deduped_18_1 * deduped_18_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_19_1, deduped_21_1 );
    deduped_13_1 := HomalgIdentityMatrix( deduped_18_1, deduped_21_1 );
    deduped_12_1 := deduped_18_1 * deduped_17_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_12_1, deduped_21_1 );
    deduped_10_1 := UnionOfRows( deduped_21_1, deduped_17_1, [ KroneckerMat( deduped_22_1, deduped_13_1 ), DiagMat( deduped_21_1, ListWithIdenticalEntries( deduped_19_1, deduped_20_1 ) ) ] );
    deduped_9_1 := DiagMat( deduped_21_1, ListWithIdenticalEntries( deduped_18_1, deduped_10_1 ) );
    deduped_8_1 := ReducedSyzygiesOfRows( KroneckerMat( TransposedMatrix( deduped_20_1 ), HomalgIdentityMatrix( deduped_17_1, deduped_21_1 ) ), DiagMat( deduped_21_1, ListWithIdenticalEntries( NumberRows( deduped_20_1 ), deduped_10_1 ) ) );
    deduped_7_1 := DiagMat( deduped_21_1, ListWithIdenticalEntries( deduped_18_1, ReducedBasisOfRowModule( deduped_10_1 ) ) );
    deduped_6_1 := NumberRows( deduped_9_1 ) + 1;
    deduped_5_1 := UnionOfRows( deduped_21_1, NumberColumns( deduped_9_1 ), [ deduped_9_1, deduped_11_1 ] );
    deduped_4_1 := NumberRows( deduped_7_1 ) + 1;
    deduped_3_1 := [ deduped_6_1 .. deduped_6_1 - 1 + deduped_12_1 ];
    hoisted_2_1 := deduped_19_1;
    hoisted_1_1 := deduped_18_1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, r_1, UnderlyingMatrix, CertainColumns( SafeRightDivide( KroneckerMat( ConvertMatrixToRow( deduped_13_1 ), deduped_14_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_1_1 ) * hoisted_1_1 + QUO_INT( deduped_1_2, hoisted_1_1 ) + 1);
                            end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_21_1 ), deduped_14_1 ) * DiagMat( deduped_21_1, ListWithIdenticalEntries( deduped_18_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, hoisted_2_1 ) * hoisted_1_1 + QUO_INT( deduped_1_2, hoisted_2_1 ) + 1);
                            end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_21_1 ) ) ) * CertainColumns( SafeRightDivide( deduped_11_1, deduped_5_1 ), deduped_3_1 ), UnionOfRows( deduped_21_1, deduped_12_1, [ deduped_7_1, CertainColumns( SafeRightDivide( deduped_8_1, deduped_5_1 ), deduped_3_1 ) ] ) ), [ deduped_4_1 .. deduped_4_1 - 1 + NumberRows( deduped_8_1 ) ] ) );
end
########
        
    , 100 );
    
    ##
    AddEvaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1;
    deduped_18_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := UnderlyingMatrix( b_1 );
    deduped_16_1 := UnderlyingMatrix( a_1 );
    deduped_15_1 := NumberColumns( deduped_16_1 );
    deduped_14_1 := NumberRows( deduped_16_1 );
    deduped_13_1 := NumberColumns( deduped_17_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_15_1, deduped_18_1 );
    deduped_11_1 := deduped_15_1 * deduped_13_1;
    deduped_10_1 := DiagMat( deduped_18_1, ListWithIdenticalEntries( deduped_15_1, ReducedBasisOfRowModule( deduped_17_1 ) ) );
    deduped_9_1 := deduped_11_1 * deduped_15_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_11_1, deduped_18_1 );
    deduped_7_1 := DiagMat( deduped_18_1, ListWithIdenticalEntries( deduped_15_1, deduped_17_1 ) );
    deduped_6_1 := NumberRows( deduped_7_1 ) + 1;
    deduped_5_1 := UnionOfRows( deduped_18_1, NumberColumns( deduped_7_1 ), [ deduped_7_1, deduped_8_1 ] );
    deduped_4_1 := [ deduped_6_1 .. deduped_6_1 - 1 + deduped_11_1 ];
    deduped_3_1 := Sum( [ NumberRows( deduped_10_1 ) * deduped_15_1, deduped_11_1 * deduped_14_1 ] ) + 1;
    hoisted_2_1 := deduped_15_1;
    hoisted_1_1 := deduped_13_1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, b_1, UnderlyingMatrix, KroneckerMat( CertainColumns( SafeRightDivide( ReducedSyzygiesOfRows( KroneckerMat( TransposedMatrix( deduped_16_1 ), HomalgIdentityMatrix( deduped_13_1, deduped_18_1 ) ), DiagMat( deduped_18_1, ListWithIdenticalEntries( deduped_14_1, deduped_17_1 ) ) ), deduped_5_1 ), deduped_4_1 ), deduped_12_1 ) * (CertainColumns( SafeRightDivide( HomalgIdentityMatrix( deduped_9_1, deduped_18_1 ), UnionOfRows( deduped_18_1, deduped_9_1, [ UnionOfRows( deduped_18_1, deduped_9_1, [ KroneckerMat( deduped_10_1, deduped_12_1 ), DiagMat( deduped_18_1, ListWithIdenticalEntries( deduped_11_1, deduped_16_1 ) ) ] ), KroneckerMat( CertainColumns( SafeRightDivide( deduped_8_1, deduped_5_1 ), deduped_4_1 ), deduped_12_1 ) ] ) ), [ deduped_3_1 .. (deduped_3_1 - 1 + deduped_9_1) ] ) * (KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, hoisted_1_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_1_1 ) + 1);
                        end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_18_1 ), deduped_12_1 ) * DiagMat( deduped_18_1, ListWithIdenticalEntries( deduped_13_1, ConvertMatrixToColumn( deduped_12_1 ) ) ))) );
end
########
        
    , 100 );
    
    ##
    AddInternalHomOnMorphismsWithGivenInternalHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := UnderlyingMatrix( Range( beta_1 ) );
    deduped_6_1 := UnderlyingMatrix( Source( alpha_1 ) );
    deduped_5_1 := UnderlyingMatrix( Source( beta_1 ) );
    deduped_4_1 := UnderlyingMatrix( Range( alpha_1 ) );
    deduped_3_1 := DiagMat( deduped_8_1, ListWithIdenticalEntries( NumberColumns( deduped_6_1 ), deduped_7_1 ) );
    deduped_2_1 := ReducedSyzygiesOfRows( KroneckerMat( TransposedMatrix( deduped_6_1 ), HomalgIdentityMatrix( NumberColumns( deduped_7_1 ), deduped_8_1 ) ), DiagMat( deduped_8_1, ListWithIdenticalEntries( NumberRows( deduped_6_1 ), deduped_7_1 ) ) );
    deduped_1_1 := NumberRows( deduped_3_1 ) + 1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, CertainColumns( SafeRightDivide( ReducedSyzygiesOfRows( KroneckerMat( TransposedMatrix( deduped_4_1 ), HomalgIdentityMatrix( NumberColumns( deduped_5_1 ), deduped_8_1 ) ), DiagMat( deduped_8_1, ListWithIdenticalEntries( NumberRows( deduped_4_1 ), deduped_5_1 ) ) ) * KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) ), UnionOfRows( deduped_8_1, NumberColumns( deduped_3_1 ), [ deduped_3_1, deduped_2_1 ] ) ), [ deduped_1_1 .. deduped_1_1 - 1 + NumberRows( deduped_2_1 ) ] ) );
end
########
        
    , 100 );
    
    ##
    AddInternalHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := UnderlyingMatrix( b_1 );
    deduped_1_1 := UnderlyingMatrix( a_1 );
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingMatrix, ReducedSyzygiesOfRows( ReducedSyzygiesOfRows( KroneckerMat( TransposedMatrix( deduped_1_1 ), HomalgIdentityMatrix( NumberColumns( deduped_2_1 ), deduped_3_1 ) ), DiagMat( deduped_3_1, ListWithIdenticalEntries( NumberRows( deduped_1_1 ), deduped_2_1 ) ) ), DiagMat( deduped_3_1, ListWithIdenticalEntries( NumberColumns( deduped_1_1 ), deduped_2_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( NumberColumns( UnderlyingMatrix( a_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, r_1 * UnderlyingMatrix( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( NumberColumns( UnderlyingMatrix( a_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
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
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingMatrix( arg3_1 );
    deduped_4_1 := UnderlyingMatrix( arg2_1 );
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := NumberColumns( deduped_5_1 );
    deduped_1_1 := NumberColumns( deduped_4_1 );
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingMatrix, UnionOfRows( deduped_3_1, deduped_1_1 * deduped_2_1, [ KroneckerMat( deduped_4_1, HomalgIdentityMatrix( deduped_2_1, deduped_3_1 ) ), DiagMat( deduped_3_1, ListWithIdenticalEntries( deduped_1_1, deduped_5_1 ) ) ] ) );
end
########
        
    , 100 );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingMatrix, HomalgZeroMatrix( 0, 1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "LeftPresentationsAsFreydCategoryOfCategoryOfRowsOfFieldPrecompiled", function ( ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( ring )
    return LeftPresentationsAsFreydCategoryOfCategoryOfRows( ring );
end;
        
        
    
    cat := category_constructor( ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_LeftPresentationsAsFreydCategoryOfCategoryOfRowsOfFieldPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
