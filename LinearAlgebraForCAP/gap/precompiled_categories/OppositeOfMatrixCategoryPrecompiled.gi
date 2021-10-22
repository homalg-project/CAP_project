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
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( a_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( b_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( cap_jit_deduplicated_expression_1_1 ), Range( cap_jit_deduplicated_expression_2_1 ), UnderlyingMatrix, UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ) + UnderlyingMatrix( cap_jit_deduplicated_expression_2_1 ) ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( a_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( cap_jit_deduplicated_expression_1_1 ), Range( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix, -1 * UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ) ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_hoisted_expression_8_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_4_1 := Opposite( arg3_1 );
    cap_jit_deduplicated_expression_2_1 := Dimension( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_5_1 := Opposite( arg2_1 );
    cap_jit_deduplicated_expression_3_1 := Dimension( cap_jit_deduplicated_expression_5_1 );
    cap_jit_deduplicated_expression_1_1 := cap_jit_deduplicated_expression_2_1 * cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_6_1 := OppositeCategory( cat_1 );
    cap_jit_hoisted_expression_1_1 := HomalgIdentityMatrix( cap_jit_deduplicated_expression_1_1, UnderlyingRing( cap_jit_deduplicated_expression_6_1 ) );
    cap_jit_hoisted_expression_2_1 := cap_jit_deduplicated_expression_2_1;
    cap_jit_hoisted_expression_3_1 := cap_jit_deduplicated_expression_3_1;
    cap_jit_hoisted_expression_4_1 := cap_jit_deduplicated_expression_6_1;
    cap_jit_hoisted_expression_5_1 := cap_jit_deduplicated_expression_4_1;
    cap_jit_hoisted_expression_6_1 := cap_jit_deduplicated_expression_5_1;
    cap_jit_hoisted_expression_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, cap_jit_deduplicated_expression_5_1 );
    cap_jit_hoisted_expression_8_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, cap_jit_deduplicated_expression_4_1 );
    return List( [ 1 .. cap_jit_deduplicated_expression_1_1 ], function ( logic_new_func_x_2 )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, cap_jit_hoisted_expression_7_1, cap_jit_hoisted_expression_8_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, UnderlyingMatrix, ConvertRowToMatrix( CertainRows( cap_jit_hoisted_expression_1_1, [ logic_new_func_x_2 ] ), cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1 ) ) );
        end );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( Opposite( arg2_1 ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, NumberRows( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ) ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := Opposite( alpha_1 );
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfRows( UnderlyingMatrix( cap_jit_deduplicated_expression_3_1 ) );
    cap_jit_deduplicated_expression_2_1 := OppositeCategory( cat_1 );
    cap_jit_morphism_attribute_1_1 := cap_jit_deduplicated_expression_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), cap_jit_deduplicated_expression_2_1, Dimension, NumberRows( cap_jit_deduplicated_expression_1_1 ) ) ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_2_1, ObjectifyObjectForCAPWithAttributes( rec(
               ), cap_jit_deduplicated_expression_2_1, Dimension, NrRows( cap_jit_morphism_attribute_1_1 ) ), Source( cap_jit_deduplicated_expression_3_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 ) );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( beta_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( alpha_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( cap_jit_deduplicated_expression_1_1 ), Source( cap_jit_deduplicated_expression_2_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix( cap_jit_deduplicated_expression_2_1 ) ) ) );
end
########
        
    );
    
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
        
    );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return ID_FUNC( ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, 1 ) );
end
########
        
    );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( A_1 );
    cap_jit_deduplicated_expression_2_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, cap_jit_deduplicated_expression_1_1 ), A_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cap_jit_deduplicated_expression_2_1 ) ) ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := [ OppositeCategory( cat_1 ), source_1, MorphismDatum( cat_1, beta_1 ), MorphismDatum( cat_1, alpha_1 ), range_1 ];
    return ID_FUNC( HomomorphismStructureOnMorphismsWithGivenObjects( cap_jit_deduplicated_expression_1_1[1], cap_jit_deduplicated_expression_1_1[2], cap_jit_deduplicated_expression_1_1[3], cap_jit_deduplicated_expression_1_1[4], cap_jit_deduplicated_expression_1_1[5] ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ID_FUNC( ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, Dimension( Opposite( arg3_1 ) ) * Dimension( Opposite( arg2_1 ) ) ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := OppositeCategory( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( a_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( cap_jit_deduplicated_expression_2_1 ), UnderlyingRing( cap_jit_deduplicated_expression_1_1 ) ) ) );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_1_1 := List( objects_1, function ( x_2 )
            return Opposite( x_2 );
        end );
    cap_jit_deduplicated_expression_6_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_4_1 := Opposite( cap_jit_deduplicated_expression_6_1 );
    cap_jit_deduplicated_expression_2_1 := Dimension( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_5_1 := OppositeCategory( cat_1 );
    cap_jit_deduplicated_expression_3_1 := UnderlyingRing( cap_jit_deduplicated_expression_5_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, cap_jit_deduplicated_expression_6_1, P_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_5_1, Opposite( P_1 ), cap_jit_deduplicated_expression_4_1, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( cap_jit_deduplicated_expression_1_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                    return Dimension( c_2 );
                end ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1 ), HomalgZeroMatrix( Sum( cap_jit_deduplicated_expression_1_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                    return Dimension( c_2 );
                end ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1 ) ) ) );
end
########
        
    );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := OppositeCategory( cat_1 );
    cap_jit_morphism_attribute_1_1 := ConvertMatrixToRow( UnderlyingMatrix( Opposite( alpha_1 ) ) );
    return ID_FUNC( ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_1_1, ObjectifyObjectForCAPWithAttributes( rec(
               ), cap_jit_deduplicated_expression_1_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), cap_jit_deduplicated_expression_1_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 ) );
end
########
        
    );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( Opposite( arg3_1 ) ), UnderlyingMatrix( Opposite( arg2_1 ) ) ) );
end
########
        
    );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( Opposite( arg2_1 ) ) = UnderlyingMatrix( Opposite( arg3_1 ) );
end
########
        
    );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( arg2_1 );
    return RowRankOfMatrix( UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ) ) = Dimension( Source( cap_jit_deduplicated_expression_1_1 ) );
end
########
        
    );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return Dimension( Opposite( arg2_1 ) ) = Dimension( Opposite( arg3_1 ) );
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
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_2_1 := Opposite( arg2_1 );
    cap_jit_deduplicated_expression_1_1 := Dimension( Range( cap_jit_deduplicated_expression_2_1 ) );
    return cap_jit_deduplicated_expression_1_1 = Dimension( Source( cap_jit_deduplicated_expression_2_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( cap_jit_deduplicated_expression_2_1 ) ) = cap_jit_deduplicated_expression_1_1;
end
########
        
    );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( Opposite( arg2_1 ) ), UnderlyingMatrix( Opposite( arg3_1 ) ) ) );
end
########
        
    );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( arg2_1 );
    return ColumnRankOfMatrix( UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ) ) = Dimension( Range( cap_jit_deduplicated_expression_1_1 ) );
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
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_2_1 := Opposite( arg2_1 );
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( cap_jit_deduplicated_expression_2_1 );
    if not true then
        return false;
    elif NumberRows( cap_jit_deduplicated_expression_1_1 ) <> Dimension( Source( cap_jit_deduplicated_expression_2_1 ) ) then
        return false;
    elif NumberColumns( cap_jit_deduplicated_expression_1_1 ) <> Dimension( Range( cap_jit_deduplicated_expression_2_1 ) ) then
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
    elif Dimension( Opposite( arg2_1 ) ) < 0 then
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
    return IsZero( UnderlyingMatrix( Opposite( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( Opposite( arg2_1 ) ) = 0;
end
########
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_3_1 := Opposite( alpha_1 );
    cap_jit_deduplicated_expression_1_1 := SyzygiesOfColumns( UnderlyingMatrix( cap_jit_deduplicated_expression_3_1 ) );
    cap_jit_deduplicated_expression_2_1 := OppositeCategory( cat_1 );
    cap_jit_morphism_attribute_1_1 := cap_jit_deduplicated_expression_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), cap_jit_deduplicated_expression_2_1, Dimension, NumberColumns( cap_jit_deduplicated_expression_1_1 ) ) ), Source( alpha_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_2_1, Range( cap_jit_deduplicated_expression_3_1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), cap_jit_deduplicated_expression_2_1, Dimension, NrColumns( cap_jit_morphism_attribute_1_1 ) ), UnderlyingMatrix, cap_jit_morphism_attribute_1_1 ) );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_deduplicated_expression_1_1;
    cap_jit_deduplicated_expression_1_1 := UnderlyingMatrix( Opposite( arg2_1 ) );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, NumberColumns( cap_jit_deduplicated_expression_1_1 ) - RowRankOfMatrix( cap_jit_deduplicated_expression_1_1 ) ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( beta_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( alpha_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Range( cap_jit_deduplicated_expression_1_1 ), Range( cap_jit_deduplicated_expression_2_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ), UnderlyingMatrix( cap_jit_deduplicated_expression_2_1 ) ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( A_1 );
    cap_jit_deduplicated_expression_2_1 := OppositeCategory( cat_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, cap_jit_deduplicated_expression_1_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( cap_jit_deduplicated_expression_1_1 ), UnderlyingRing( cap_jit_deduplicated_expression_2_1 ) ) ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := Opposite( beta_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( alpha_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( cap_jit_deduplicated_expression_1_1 ), Range( cap_jit_deduplicated_expression_2_1 ), UnderlyingMatrix, UnderlyingMatrix( cap_jit_deduplicated_expression_1_1 ) * UnderlyingMatrix( cap_jit_deduplicated_expression_2_1 ) ) );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, cap_jit_deduplicated_expression_4_1, cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_6_1;
    cap_jit_deduplicated_expression_1_1 := List( objects_1, function ( x_2 )
            return Opposite( x_2 );
        end );
    cap_jit_deduplicated_expression_6_1 := objects_1[k_1];
    cap_jit_deduplicated_expression_4_1 := Opposite( cap_jit_deduplicated_expression_6_1 );
    cap_jit_deduplicated_expression_2_1 := Dimension( cap_jit_deduplicated_expression_4_1 );
    cap_jit_deduplicated_expression_5_1 := OppositeCategory( cat_1 );
    cap_jit_deduplicated_expression_3_1 := UnderlyingRing( cap_jit_deduplicated_expression_5_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, cap_jit_deduplicated_expression_6_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_5_1, cap_jit_deduplicated_expression_4_1, Opposite( P_1 ), UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( cap_jit_deduplicated_expression_2_1, Sum( cap_jit_deduplicated_expression_1_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                    return Dimension( c_2 );
                end ), cap_jit_deduplicated_expression_3_1 ), HomalgIdentityMatrix( cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1 ), HomalgZeroMatrix( cap_jit_deduplicated_expression_2_1, Sum( cap_jit_deduplicated_expression_1_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                    return Dimension( c_2 );
                end ), cap_jit_deduplicated_expression_3_1 ) ) ) );
end
########
        
    );
    
    ##
    AddSomeInjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, Opposite( arg2_1 ) );
end
########
        
    );
    
    ##
    AddSomeProjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, Opposite( arg2_1 ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := OppositeCategory( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( T_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, Opposite( P_1 ), UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cap_jit_deduplicated_expression_1_1 ), Dimension( cap_jit_deduplicated_expression_2_1 ), List( tau_1, function ( logic_new_func_x_2 )
                  return UnderlyingMatrix( Opposite( logic_new_func_x_2 ) );
              end ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := OppositeCategory( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( T_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, Opposite( P_1 ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( cap_jit_deduplicated_expression_2_1 ), 0, UnderlyingRing( cap_jit_deduplicated_expression_1_1 ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := OppositeCategory( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( T_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_1_1, Opposite( P_1 ), cap_jit_deduplicated_expression_2_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cap_jit_deduplicated_expression_1_1 ), Dimension( cap_jit_deduplicated_expression_2_1 ), List( tau_1, function ( logic_new_func_x_2 )
                  return UnderlyingMatrix( Opposite( logic_new_func_x_2 ) );
              end ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1;
    cap_jit_deduplicated_expression_1_1 := OppositeCategory( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( T_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_1_1, Opposite( P_1 ), cap_jit_deduplicated_expression_2_1, UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( cap_jit_deduplicated_expression_2_1 ), UnderlyingRing( cap_jit_deduplicated_expression_1_1 ) ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1;
    cap_jit_deduplicated_expression_1_1 := OppositeCategory( cat_1 );
    cap_jit_deduplicated_expression_2_1 := Opposite( b_1 );
    cap_jit_deduplicated_expression_3_1 := Opposite( a_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, b_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), cap_jit_deduplicated_expression_1_1, cap_jit_deduplicated_expression_2_1, cap_jit_deduplicated_expression_3_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( cap_jit_deduplicated_expression_2_1 ), Dimension( cap_jit_deduplicated_expression_3_1 ), UnderlyingRing( cap_jit_deduplicated_expression_1_1 ) ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, 0 ) );
end
########
        
    );
    
end );

BindGlobal( "OppositeOfMatrixCategoryPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( field )
    return Opposite( MATRIX_CATEGORY( field : FinalizeCategory := true ) );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_OppositeOfMatrixCategoryPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
