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
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( Opposite( a_1 ) ), Range( Opposite( b_1 ) ), UnderlyingMatrix, UnderlyingMatrix( Opposite( a_1 ) ) + UnderlyingMatrix( Opposite( b_1 ) ) ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( Opposite( a_1 ) ), Range( Opposite( a_1 ) ), UnderlyingMatrix, -1 * UnderlyingMatrix( Opposite( a_1 ) ) ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1, cap_jit_hoisted_expression_5_1, cap_jit_hoisted_expression_6_1, cap_jit_hoisted_expression_7_1, cap_jit_hoisted_expression_8_1;
    cap_jit_hoisted_expression_1_1 := HomalgIdentityMatrix( Dimension( Opposite( arg3_1 ) ) * Dimension( Opposite( arg2_1 ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) );
    cap_jit_hoisted_expression_2_1 := Dimension( Opposite( arg3_1 ) );
    cap_jit_hoisted_expression_3_1 := Dimension( Opposite( arg2_1 ) );
    cap_jit_hoisted_expression_4_1 := OppositeCategory( cat_1 );
    cap_jit_hoisted_expression_5_1 := Opposite( arg3_1 );
    cap_jit_hoisted_expression_6_1 := Opposite( arg2_1 );
    cap_jit_hoisted_expression_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, Opposite( arg2_1 ) );
    cap_jit_hoisted_expression_8_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, Opposite( arg3_1 ) );
    return List( [ 1 .. Dimension( Opposite( arg3_1 ) ) * Dimension( Opposite( arg2_1 ) ) ], function ( logic_new_func_x_2 )
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
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, NumberRows( UnderlyingMatrix( Opposite( arg2_1 ) ) ) - RowRankOfMatrix( UnderlyingMatrix( Opposite( arg2_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), OppositeCategory( cat_1 ), Dimension, NumberRows( SyzygiesOfRows( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) ) ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), OppositeCategory( cat_1 ), Dimension, NumberRows( SyzygiesOfRows( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) ), Source( Opposite( alpha_1 ) ), UnderlyingMatrix, SyzygiesOfRows( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( Opposite( beta_1 ) ), Source( Opposite( alpha_1 ) ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( Opposite( beta_1 ) ), UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) );
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
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, Opposite( A_1 ) ), A_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( A_1 ), Opposite( A_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Opposite( A_1 ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return ID_FUNC( HomomorphismStructureOnMorphismsWithGivenObjects( [ OppositeCategory( cat_1 ), source_1, MorphismDatum( cat_1, beta_1 ), MorphismDatum( cat_1, alpha_1 ), range_1 ][1], [ OppositeCategory( cat_1 ), source_1, MorphismDatum( cat_1, beta_1 ), MorphismDatum( cat_1, alpha_1 ), range_1 ][2], [ OppositeCategory( cat_1 ), source_1, MorphismDatum( cat_1, beta_1 ), MorphismDatum( cat_1, alpha_1 ), range_1 ][3], [ OppositeCategory( cat_1 ), source_1, MorphismDatum( cat_1, beta_1 ), MorphismDatum( cat_1, alpha_1 ), range_1 ][4], [ OppositeCategory( cat_1 ), source_1, MorphismDatum( cat_1, beta_1 ), MorphismDatum( cat_1, alpha_1 ), range_1 ][5] ) );
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
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( a_1 ), Opposite( a_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Opposite( a_1 ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, objects_1[k_1], P_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( P_1 ), Opposite( objects_1[k_1] ), UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( List( objects_1, function ( x_2 )
                        return Opposite( x_2 );
                    end ){[ 1 .. k_1 - 1 ]}, function ( c_2 )
                    return Dimension( c_2 );
                end ), Dimension( Opposite( objects_1[k_1] ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) ), HomalgIdentityMatrix( Dimension( Opposite( objects_1[k_1] ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) ), HomalgZeroMatrix( Sum( List( objects_1, function ( x_2 )
                        return Opposite( x_2 );
                    end ){[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                    return Dimension( c_2 );
                end ), Dimension( Opposite( objects_1[k_1] ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) ) ) ) );
end
########
        
    );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    return ID_FUNC( ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), OppositeCategory( cat_1 ), Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
               ), OppositeCategory( cat_1 ), Dimension, NumberColumns( ConvertMatrixToRow( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) ), UnderlyingMatrix, ConvertMatrixToRow( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) );
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
    return RowRankOfMatrix( UnderlyingMatrix( Opposite( arg2_1 ) ) ) = Dimension( Source( Opposite( arg2_1 ) ) );
end
########
        
    );
    
    ##
    AddIsEqualForCacheForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IS_IDENTICAL_OBJ( Opposite( arg2_1 ), Opposite( arg3_1 ) );
end
########
        
    );
    
    ##
    AddIsEqualForCacheForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IS_IDENTICAL_OBJ( Opposite( arg2_1 ), Opposite( arg3_1 ) );
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
    return Dimension( Range( Opposite( arg2_1 ) ) ) = Dimension( Source( Opposite( arg2_1 ) ) ) and ColumnRankOfMatrix( UnderlyingMatrix( Opposite( arg2_1 ) ) ) = Dimension( Range( Opposite( arg2_1 ) ) );
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
    return ColumnRankOfMatrix( UnderlyingMatrix( Opposite( arg2_1 ) ) ) = Dimension( Range( Opposite( arg2_1 ) ) );
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
    if not true then
        return false;
    elif NumberRows( UnderlyingMatrix( Opposite( arg2_1 ) ) ) <> Dimension( Source( Opposite( arg2_1 ) ) ) then
        return false;
    elif NumberColumns( UnderlyingMatrix( Opposite( arg2_1 ) ) ) <> Dimension( Range( Opposite( arg2_1 ) ) ) then
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
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
               ), OppositeCategory( cat_1 ), Dimension, NumberColumns( SyzygiesOfColumns( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) ) ), Source( alpha_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Range( Opposite( alpha_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
               ), OppositeCategory( cat_1 ), Dimension, NumberColumns( SyzygiesOfColumns( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) ), UnderlyingMatrix, SyzygiesOfColumns( UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Opposite, ObjectifyObjectForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Dimension, NumberColumns( UnderlyingMatrix( Opposite( arg2_1 ) ) ) - RowRankOfMatrix( UnderlyingMatrix( Opposite( arg2_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Range( Opposite( beta_1 ) ), Range( Opposite( alpha_1 ) ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( Opposite( beta_1 ) ), UnderlyingMatrix( Opposite( alpha_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Opposite, Opposite( A_1 ) ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( A_1 ), Opposite( A_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( Opposite( A_1 ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Source( Opposite( beta_1 ) ), Range( Opposite( alpha_1 ) ), UnderlyingMatrix, UnderlyingMatrix( Opposite( beta_1 ) ) * UnderlyingMatrix( Opposite( alpha_1 ) ) ) );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, objects_1[k_1], Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( objects_1[k_1] ), Opposite( P_1 ), UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( Dimension( Opposite( objects_1[k_1] ) ), Sum( List( objects_1, function ( x_2 )
                        return Opposite( x_2 );
                    end ){[ 1 .. k_1 - 1 ]}, function ( c_2 )
                    return Dimension( c_2 );
                end ), UnderlyingRing( OppositeCategory( cat_1 ) ) ), HomalgIdentityMatrix( Dimension( Opposite( objects_1[k_1] ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) ), HomalgZeroMatrix( Dimension( Opposite( objects_1[k_1] ) ), Sum( List( objects_1, function ( x_2 )
                        return Opposite( x_2 );
                    end ){[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                    return Dimension( c_2 );
                end ), UnderlyingRing( OppositeCategory( cat_1 ) ) ) ) ) );
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
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( T_1 ), Opposite( P_1 ), UnderlyingMatrix, UnionOfColumns( UnderlyingRing( OppositeCategory( cat_1 ) ), Dimension( Opposite( T_1 ) ), List( tau_1, function ( logic_new_func_x_2 )
                  return UnderlyingMatrix( Opposite( logic_new_func_x_2 ) );
              end ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( T_1 ), Opposite( P_1 ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( Opposite( T_1 ) ), 0, UnderlyingRing( OppositeCategory( cat_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( P_1 ), Opposite( T_1 ), UnderlyingMatrix, UnionOfRows( UnderlyingRing( OppositeCategory( cat_1 ) ), Dimension( Opposite( T_1 ) ), List( tau_1, function ( logic_new_func_x_2 )
                  return UnderlyingMatrix( Opposite( logic_new_func_x_2 ) );
              end ) ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( P_1 ), Opposite( T_1 ), UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( Opposite( T_1 ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, b_1, Opposite, ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
             ), OppositeCategory( cat_1 ), Opposite( b_1 ), Opposite( a_1 ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( Opposite( b_1 ) ), Dimension( Opposite( a_1 ) ), UnderlyingRing( OppositeCategory( cat_1 ) ) ) ) );
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
    return Opposite( MATRIX_CATEGORY( field : FinalizeCategory := true,
          enable_compilation := false ) );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_OppositeOfMatrixCategoryPrecompiled( cat );
    
    if ValueOption( "FinalizeCategory" ) = false then
        
        return cat;
        
    fi;
    
    Finalize( cat );
    
    return cat;
    
end );
