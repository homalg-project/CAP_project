# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_OppositeOfMatrixCategoryPrecompiled", function ( cat )
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( a_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( deduped_1_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) + UnderlyingMatrix( Opposite( b_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( a_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( deduped_1_1 ), Range( deduped_1_1 ), UnderlyingMatrix, -1 * UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, hoisted_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1;
    deduped_17_1 := OppositeCategory( cat_1 );
    deduped_16_1 := Opposite( arg2_1 );
    deduped_15_1 := Opposite( arg3_1 );
    deduped_14_1 := Dimension( deduped_16_1 );
    deduped_13_1 := Dimension( deduped_15_1 );
    deduped_12_1 := deduped_13_1 * deduped_14_1;
    hoisted_11_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, deduped_15_1 );
    hoisted_10_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, deduped_16_1 );
    hoisted_9_1 := deduped_16_1;
    hoisted_8_1 := deduped_15_1;
    hoisted_7_1 := deduped_17_1;
    hoisted_6_1 := deduped_14_1;
    hoisted_5_1 := deduped_13_1;
    hoisted_4_1 := HomalgIdentityMatrix( deduped_12_1, UnderlyingRing( deduped_17_1 ) );
    return List( [ 1 .. deduped_12_1 ], function ( logic_new_func_x_2 )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, hoisted_10_1, hoisted_11_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), hoisted_7_1, hoisted_8_1, hoisted_9_1, UnderlyingMatrix, ConvertRowToMatrix( CertainRows( hoisted_4_1, [ logic_new_func_x_2 ] ), hoisted_5_1, hoisted_6_1 ) ) );
        end );
end
########
        
    , 100 );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Opposite( s_1 );
    deduped_4_1 := OppositeCategory( cat_1 );
    deduped_3_1 := Dimension( deduped_5_1 );
    hoisted_2_1 := Dimension( Opposite( a_1 ) );
    hoisted_1_1 := Dimension( Opposite( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_4_1, deduped_5_1, Opposite( r_1 ), UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := i_2 - 1;
                      return REM_INT( deduped_1_2, hoisted_1_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_1_1 ) + 1;
                  end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, UnderlyingRing( deduped_4_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoDualOnMorphismsWithGivenCoDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( r_1 ), Opposite( s_1 ), UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoDualOnObjects( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, Opposite( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCoclosedCoevaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, Opposite( r_1 ), Opposite( s_1 ), UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( Dimension( Opposite( a_1 ) ), UnderlyingRing( deduped_1_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoclosedEvaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, Opposite( r_1 ), Opposite( s_1 ), UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( Dimension( Opposite( a_1 ) ), UnderlyingRing( deduped_1_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return EntriesOfHomalgMatrix( UnderlyingMatrix( Opposite( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, Opposite( r_1 ), Opposite( s_1 ), UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( Dimension( Opposite( a_1 ) ), UnderlyingRing( deduped_1_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( Opposite( arg2_1 ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, NumberRows( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Opposite( alpha_1 );
    deduped_3_1 := OppositeCategory( cat_1 );
    deduped_2_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_4_1 ) );
    morphism_attr_1_1 := deduped_2_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_3_1, Dimension, NumberRows( deduped_2_1 ) ) ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_3_1, ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_3_1, Dimension, NumberRows( morphism_attr_1_1 ) ), Source( deduped_4_1 ), UnderlyingMatrix, morphism_attr_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( alpha_1 );
    deduped_1_1 := Opposite( beta_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( deduped_1_1 ), Source( deduped_2_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_2_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Opposite( alpha_1 );
    deduped_2_1 := List( S_1, function ( logic_new_func_x_2 )
            return Dimension( Opposite( logic_new_func_x_2 ) );
        end );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1[i_1], Range( alpha_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( deduped_3_1 ), List( S_1, function ( x_2 )
                  return Opposite( x_2 );
              end )[i_1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( deduped_3_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismIntoDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Opposite( alpha_1 );
    deduped_2_1 := List( S_1, function ( logic_new_func_x_2 )
            return Dimension( Opposite( logic_new_func_x_2 ) );
        end );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), S_1[i_1], Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), List( S_1, function ( x_2 )
                  return Opposite( x_2 );
              end )[i_1], Range( deduped_3_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( deduped_3_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, Sum( List( arg2_1, function ( logic_new_func_x_2 )
                  return Dimension( Opposite( logic_new_func_x_2 ) );
              end ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local deduped_1_1;
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, Opposite( Pp_1 ), Opposite( P_1 ), UnderlyingMatrix, DiagMat( UnderlyingRing( deduped_1_1 ), List( L_1, function ( logic_new_func_x_2 )
                  return UnderlyingMatrix( Opposite( logic_new_func_x_2 ) );
              end ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), OppositeCategory( cat_1 ), Dimension, 1 );
end
########
        
    , 100 );
    
    ##
    AddDualOnMorphismsWithGivenDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( r_1 ), Opposite( s_1 ), UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddDualOnObjects( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, Opposite( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := OppositeCategory( cat_1 );
    deduped_1_1 := Opposite( A_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, deduped_1_1 ), A_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_2_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( deduped_2_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, Opposite( r_1 ), Opposite( s_1 ), UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( Dimension( Opposite( a_1 ) ), UnderlyingRing( deduped_1_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), OppositeCategory( cat_1 ), source_1, range_1, UnderlyingMatrix, KroneckerMat( TransposedMatrix( UnderlyingMatrix( Opposite( beta_1 ) ) ), UnderlyingMatrix( Opposite( alpha_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), OppositeCategory( cat_1 ), Dimension, Dimension( Opposite( arg3_1 ) ) * Dimension( Opposite( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( a_1 );
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), UnderlyingRing( deduped_1_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := OppositeCategory( cat_1 );
    deduped_3_1 := UnderlyingRing( deduped_4_1 );
    deduped_2_1 := List( objects_1, function ( logic_new_func_x_2 )
            return Dimension( Opposite( logic_new_func_x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, objects_1[k_1], P_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_4_1, Opposite( P_1 ), List( objects_1, function ( x_2 )
                  return Opposite( x_2 );
              end )[k_1], UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_3_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := OppositeCategory( cat_1 );
    morphism_attr_1_1 := ConvertMatrixToRow( UnderlyingMatrix( Opposite( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), deduped_2_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), deduped_2_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), deduped_2_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local deduped_5_1, deduped_6_1;
    deduped_6_1 := Opposite( arg3_1 );
    deduped_5_1 := Opposite( arg2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, deduped_5_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, deduped_6_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), deduped_6_1, deduped_5_1, UnderlyingMatrix, ConvertRowToMatrix( UnderlyingMatrix( arg4_1 ), Dimension( deduped_6_1 ), Dimension( deduped_5_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( Opposite( arg3_1 ) ), UnderlyingMatrix( Opposite( arg2_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( Opposite( arg2_1 ) ) = UnderlyingMatrix( Opposite( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_3_1;
    deduped_3_1 := Opposite( arg2_1 );
    return RowRankOfMatrix( UnderlyingMatrix( deduped_3_1 ) ) = Dimension( Source( deduped_3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return Dimension( Opposite( arg2_1 ) ) = Dimension( Opposite( arg3_1 ) );
end
########
        
    , 100 );
    
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
    local deduped_3_1, deduped_4_1;
    deduped_4_1 := Opposite( arg2_1 );
    deduped_3_1 := Dimension( Range( deduped_4_1 ) );
    return deduped_3_1 = Dimension( Source( deduped_4_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( deduped_4_1 ) ) = deduped_3_1;
end
########
        
    , 100 );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( Opposite( arg2_1 ) ), UnderlyingMatrix( Opposite( arg3_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_3_1;
    deduped_3_1 := Opposite( arg2_1 );
    return ColumnRankOfMatrix( UnderlyingMatrix( deduped_3_1 ) ) = Dimension( Range( deduped_3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsProjective( cat,
        
########
function ( cat_1, arg2_1 )
    return true;
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_3_1, deduped_4_1;
    deduped_4_1 := Opposite( arg2_1 );
    deduped_3_1 := UnderlyingMatrix( deduped_4_1 );
    if NumberRows( deduped_3_1 ) <> Dimension( Source( deduped_4_1 ) ) then
        return false;
    elif NumberColumns( deduped_3_1 ) <> Dimension( Range( deduped_4_1 ) ) then
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
    if Dimension( Opposite( arg2_1 ) ) < 0 then
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
    return IsZero( UnderlyingMatrix( Opposite( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( Opposite( arg2_1 ) ) = 0;
end
########
        
    , 100 );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Opposite( alpha_1 );
    deduped_3_1 := OppositeCategory( cat_1 );
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_4_1 ) );
    morphism_attr_1_1 := deduped_2_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_3_1, Dimension, NumberColumns( deduped_2_1 ) ) ), Source( alpha_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_3_1, Range( deduped_4_1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), deduped_3_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( Opposite( arg2_1 ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, NumberColumns( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( alpha_1 );
    deduped_1_1 := Opposite( beta_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Range( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_2_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := OppositeCategory( cat_1 );
    deduped_1_1 := Opposite( A_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, deduped_1_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_2_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( deduped_2_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismBetweenDirectSumsWithGivenDirectSums( cat,
        
########
function ( cat_1, S_1, source_diagram_1, mat_1, range_diagram_1, T_1 )
    local hoisted_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := OppositeCategory( cat_1 );
    deduped_4_1 := UnderlyingRing( deduped_5_1 );
    deduped_3_1 := CAP_INTERNAL_OPPOSITE_RECURSIVE( [ cat_1, S_1, source_diagram_1, mat_1, range_diagram_1, T_1 ] );
    deduped_2_1 := deduped_3_1[2];
    hoisted_1_1 := deduped_4_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1, T_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_5_1, deduped_3_1[6], deduped_2_1, UnderlyingMatrix, UnionOfRows( deduped_4_1, Dimension( deduped_2_1 ), ListN( deduped_3_1[5], List( TransposedMatImmutable( deduped_3_1[4] ), function ( row_2 )
                    return List( row_2, UnderlyingMatrix );
                end ), function ( source_2, row_2 )
                  return UnionOfColumns( hoisted_1_1, Dimension( source_2 ), row_2 );
              end ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg4_1, Opposite, arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return Opposite( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismFromCoBidualWithGivenCoBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( a_1 );
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, a_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, deduped_2_1, Opposite( s_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), UnderlyingRing( deduped_1_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismToBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( a_1 );
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, r_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, Opposite( r_1 ), deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), UnderlyingRing( deduped_1_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( a_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( deduped_1_1 ), Range( deduped_1_1 ), UnderlyingMatrix, r_1 * UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return Opposite( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( alpha_1 );
    deduped_1_1 := Opposite( beta_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := OppositeCategory( cat_1 );
    deduped_3_1 := UnderlyingRing( deduped_4_1 );
    deduped_2_1 := List( objects_1, function ( logic_new_func_x_2 )
            return Dimension( Opposite( logic_new_func_x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, objects_1[k_1], Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_4_1, List( objects_1, function ( x_2 )
                  return Opposite( x_2 );
              end )[k_1], Opposite( P_1 ), UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_3_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddSomeInjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, Opposite( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSomeProjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, Opposite( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( r_1 ), Opposite( s_1 ), UnderlyingMatrix, KroneckerMat( UnderlyingMatrix( Opposite( alpha_1 ) ), UnderlyingMatrix( Opposite( beta_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, Dimension( Opposite( arg2_1 ) ) * Dimension( Opposite( arg3_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, 1 ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( T_1 );
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, deduped_2_1, Opposite( P_1 ), UnderlyingMatrix, UnionOfColumns( UnderlyingRing( deduped_1_1 ), Dimension( deduped_2_1 ), List( tau_1, function ( logic_new_func_x_2 )
                  return UnderlyingMatrix( Opposite( logic_new_func_x_2 ) );
              end ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( T_1 );
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, deduped_2_1, Opposite( P_1 ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( deduped_2_1 ), 0, UnderlyingRing( deduped_1_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( T_1 );
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, Opposite( P_1 ), deduped_2_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( deduped_1_1 ), Dimension( deduped_2_1 ), List( tau_1, function ( logic_new_func_x_2 )
                  return UnderlyingMatrix( Opposite( logic_new_func_x_2 ) );
              end ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( T_1 );
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, Opposite( P_1 ), deduped_2_1, UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( deduped_2_1 ), UnderlyingRing( deduped_1_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Opposite( a_1 );
    deduped_2_1 := Opposite( b_1 );
    deduped_1_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, b_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), deduped_1_1, deduped_2_1, deduped_3_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( deduped_2_1 ), Dimension( deduped_3_1 ), UnderlyingRing( deduped_1_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, 0 ) );
end
########
        
    , 100 );
    
end );

BindGlobal( "OppositeOfMatrixCategoryPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( field )
    return Opposite( MATRIX_CATEGORY( field : no_precompiled_code := true,
          FinalizeCategory := true ) : only_primitive_operations := true );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_OppositeOfMatrixCategoryPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
