# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "MatrixCategoryPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor := 
        
        
        function ( field )
    return MATRIX_CATEGORY( field );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false );
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( b_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + UnderlyingMatrix( b_1 ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, -1 * UnderlyingMatrix( a_1 ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return List( [ 1 .. Dimension( arg2_1 ) * Dimension( arg3_1 ) ], function ( logic_new_func_x_2 )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, arg2_1, arg3_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, ConvertRowToMatrix( CertainRows( HomalgIdentityMatrix( Dimension( arg2_1 ) * Dimension( arg3_1 ), UnderlyingFieldForHomalg( arg2_1 ) ), [ logic_new_func_x_2 ] ), Dimension( arg2_1 ), Dimension( arg3_1 ) ) );
        end );
end
########
        
    );
    
    ##
    AddCokernelColift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( tau_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), Range( tau_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( tau_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), Range( tau_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( UnderlyingMatrix( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( epsilon_1 ), Range( tau_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( epsilon_1 ), UnderlyingMatrix( tau_1 ) ) );
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
            end ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) );
end
########
        
    );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) );
end
########
        
    );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( arg2_1 ) * Dimension( arg3_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := UnionOfColumns( HomalgZeroMatrix( Dimension( objects_1[k_1] ), Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2_2 )
                return Dimension( c_2_2 );
            end ), UnderlyingRing( cat_1 ) ), HomalgIdentityMatrix( Dimension( objects_1[k_1] ), UnderlyingRing( cat_1 ) ), HomalgZeroMatrix( Dimension( objects_1[k_1] ), Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2_2 )
                return Dimension( c_2_2 );
            end ), UnderlyingRing( cat_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, objects_1[k_1], ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, objects_1[k_1], P_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( Dimension( objects_1[k_1] ), Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), UnderlyingRing( cat_1 ) ), HomalgIdentityMatrix( Dimension( objects_1[k_1] ), UnderlyingRing( cat_1 ) ), HomalgZeroMatrix( Dimension( objects_1[k_1] ), Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    );
    
    ##
    AddInjectiveColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, arg2_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := ConvertMatrixToRow( UnderlyingMatrix( arg2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Source( alpha_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( Range( alpha_1 ) ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddIsAutomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( Source( arg2_1 ) ) = Dimension( Range( arg2_1 ) ) and (Dimension( Range( arg2_1 ) ) = Dimension( Source( arg2_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = Dimension( Range( arg2_1 ) ));
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
    AddIsEqualForCacheForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IS_IDENTICAL_OBJ( arg2_1, arg3_1 );
end
########
        
    );
    
    ##
    AddIsEqualForCacheForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IS_IDENTICAL_OBJ( arg2_1, arg3_1 );
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
    return UnderlyingMatrix( arg2_1 ) * UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg2_1 );
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
    return Dimension( Range( arg2_1 ) ) = Dimension( Source( arg2_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = Dimension( Range( arg2_1 ) );
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
    if not true then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Source( arg2_1 ) ), UnderlyingRing( cat_1 ) ) then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( arg2_1 ), UnderlyingRing( cat_1 ) ) then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Range( arg2_1 ) ), UnderlyingRing( cat_1 ) ) then
        return false;
    elif NumberRows( UnderlyingMatrix( arg2_1 ) ) <> Dimension( Source( arg2_1 ) ) then
        return false;
    elif NumberColumns( UnderlyingMatrix( arg2_1 ) ) <> Dimension( Range( arg2_1 ) ) then
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
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( arg2_1 ), UnderlyingRing( cat_1 ) ) then
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
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), Source( alpha_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddKernelEmbeddingWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), Source( alpha_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddKernelLift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := RightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := RightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( UnderlyingMatrix( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) );
end
########
        
    );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), Source( iota_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( iota_1 ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1, I_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddMorphismFromKernelObjectToSink( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := HomalgZeroMatrix( NumberRows( UnderlyingMatrix( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), Dimension( Range( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), Range( alpha_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddMorphismFromKernelObjectToSinkWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := HomalgZeroMatrix( NumberRows( UnderlyingMatrix( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), Dimension( Range( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), Range( alpha_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddMorphismFromSourceToCokernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := HomalgZeroMatrix( Dimension( Source( alpha_1 ) ), NumberColumns( UnderlyingMatrix( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddMorphismFromSourceToCokernelObjectWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := HomalgZeroMatrix( Dimension( Source( alpha_1 ) ), NumberColumns( UnderlyingMatrix( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2_2 )
                return Dimension( c_2_2 );
            end ), Dimension( objects_1[k_1] ), UnderlyingRing( cat_1 ) ), HomalgIdentityMatrix( Dimension( objects_1[k_1] ), UnderlyingRing( cat_1 ) ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2_2 )
                return Dimension( c_2_2 );
            end ), Dimension( objects_1[k_1] ), UnderlyingRing( cat_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), objects_1[k_1], UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, objects_1[k_1], UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), Dimension( objects_1[k_1] ), UnderlyingRing( cat_1 ) ), HomalgIdentityMatrix( Dimension( objects_1[k_1] ), UnderlyingRing( cat_1 ) ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), Dimension( objects_1[k_1] ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    );
    
    ##
    AddProjectiveLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
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
    AddSubtractionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( b_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + -1 * UnderlyingMatrix( b_1 ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2_2 )
              return UnderlyingMatrix( s_2_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), T_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), T_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2_2 )
              return UnderlyingMatrix( s_2_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, b_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( a_1 ), Dimension( b_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) );
end
########
        
    );
    
    ##
    AddZeroObjectFunctorial( cat,
        
########
function ( cat_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := HomalgIdentityMatrix( 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, DiagMat( UnderlyingRing( cat_1 ), List( L_1, function ( mor_2 )
                return UnderlyingMatrix( mor_2 );
            end ) ) );
end
########
        
    );
    
    if ValueOption( "FinalizeCategory" ) = false then
        
        return cat;
        
    fi;
    
    Finalize( cat );
    
    return cat;
    
end );
