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
function ( cat_1, morphism_1_1, morphism_2_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( morphism_1_1 ), Range( morphism_2_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnderlyingMatrix( morphism_1_1 ) + UnderlyingMatrix( morphism_2_1 ) );
end
########
        
    );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, morphism_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( morphism_1 ), Range( morphism_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, -1 * UnderlyingMatrix( morphism_1 ) );
end
########
        
    );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, S_1, T_1 )
    return List( [ 1 .. Dimension( S_1 ) * Dimension( T_1 ) ], function ( logic_new_func_x_2 )
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, S_1, T_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, ConvertRowToMatrix( CertainRows( HomalgIdentityMatrix( Dimension( S_1 ) * Dimension( T_1 ), UnderlyingFieldForHomalg( S_1 ) ), [ logic_new_func_x_2 ] ), Dimension( S_1 ), Dimension( T_1 ) ) );
        end );
end
########
        
    );
    
    ##
    AddCokernelColift( cat,
        
########
function ( cat_1, mor_1, test_object_1, test_morphism_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( mor_1 ) ), UnderlyingMatrix( test_morphism_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), Range( test_morphism_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat_1, mor_1, test_object_1, test_morphism_1, cokernel_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( mor_1 ) ), UnderlyingMatrix( test_morphism_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), Range( test_morphism_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, morphism_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( UnderlyingMatrix( morphism_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( morphism_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) );
end
########
        
    );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, morphism_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := SyzygiesOfColumns( UnderlyingMatrix( morphism_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( morphism_1 ), ObjectifyObjectForCAPWithAttributes( rec(
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
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, object_list_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( object_list_1, function ( object_2 )
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
function ( cat_1, obj_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, obj_1, obj_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( obj_1 ), UnderlyingRing( cat_1 ) ) );
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
function ( cat_1, object_1_1, object_2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( object_1_1 ) * Dimension( object_2_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) );
end
########
        
    );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, object_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, object_1, object_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( object_1 ), UnderlyingRing( cat_1 ) ) );
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
function ( cat_1, object_list_1, injection_number_1, coproduct_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, object_list_1[injection_number_1], coproduct_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( Dimension( object_list_1[injection_number_1] ), Sum( object_list_1{[ 1 .. injection_number_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), UnderlyingRing( cat_1 ) ), HomalgIdentityMatrix( Dimension( object_list_1[injection_number_1] ), UnderlyingRing( cat_1 ) ), HomalgZeroMatrix( Dimension( object_list_1[injection_number_1] ), Sum( object_list_1{[ injection_number_1 + 1 .. Length( object_list_1 ) ]}, function ( c_2 )
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
function ( cat_1, alpha_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
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
function ( cat_1, mor_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( mor_1 ), Source( mor_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, RightDivide( HomalgIdentityMatrix( Dimension( Range( mor_1 ) ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( mor_1 ) ) );
end
########
        
    );
    
    ##
    AddIsAutomorphism( cat,
        
########
function ( cat_1, morphism_1 )
    return Dimension( Source( morphism_1 ) ) = Dimension( Range( morphism_1 ) ) and (Dimension( Range( morphism_1 ) ) = Dimension( Source( morphism_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( morphism_1 ) ) = Dimension( Range( morphism_1 ) ));
end
########
        
    );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddIsColiftableAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( epsilon_1 ) ) );
end
########
        
    );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, morphism_1_1, morphism_2_1 )
    return UnderlyingMatrix( morphism_1_1 ) = UnderlyingMatrix( morphism_2_1 );
end
########
        
    );
    
    ##
    AddIsEndomorphism( cat,
        
########
function ( cat_1, morphism_1 )
    return Dimension( Source( morphism_1 ) ) = Dimension( Range( morphism_1 ) );
end
########
        
    );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat_1, morphism_1 )
    return ColumnRankOfMatrix( UnderlyingMatrix( morphism_1 ) ) = Dimension( Range( morphism_1 ) );
end
########
        
    );
    
    ##
    AddIsEqualForCacheForMorphisms( cat,
        
########
function ( cat_1, mor1_1, mor2_1 )
    return IS_IDENTICAL_OBJ( mor1_1, mor2_1 );
end
########
        
    );
    
    ##
    AddIsEqualForCacheForObjects( cat,
        
########
function ( cat_1, obj1_1, obj2_1 )
    return IS_IDENTICAL_OBJ( obj1_1, obj2_1 );
end
########
        
    );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, mor1_1, mor2_1 )
    return UnderlyingMatrix( mor1_1 ) = UnderlyingMatrix( mor2_1 );
end
########
        
    );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, object_1_1, object_2_1 )
    return Dimension( object_1_1 ) = Dimension( object_2_1 );
end
########
        
    );
    
    ##
    AddIsIdempotent( cat,
        
########
function ( cat_1, morphism_1 )
    return UnderlyingMatrix( morphism_1 ) * UnderlyingMatrix( morphism_1 ) = UnderlyingMatrix( morphism_1 );
end
########
        
    );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, object_1 )
    return Dimension( object_1 ) = 0;
end
########
        
    );
    
    ##
    AddIsInjective( cat,
        
########
function ( cat_1, obj_1 )
    return true;
end
########
        
    );
    
    ##
    AddIsIsomorphism( cat,
        
########
function ( cat_1, morphism_1 )
    return Dimension( Range( morphism_1 ) ) = Dimension( Source( morphism_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( morphism_1 ) ) = Dimension( Range( morphism_1 ) );
end
########
        
    );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    );
    
    ##
    AddIsLiftableAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( iota_1 ) ) );
end
########
        
    );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat_1, morphism_1 )
    return RowRankOfMatrix( UnderlyingMatrix( morphism_1 ) ) = Dimension( Source( morphism_1 ) );
end
########
        
    );
    
    ##
    AddIsOne( cat,
        
########
function ( cat_1, morphism_1 )
    return HomalgIdentityMatrix( Dimension( Source( morphism_1 ) ), UnderlyingRing( cat_1 ) ) = UnderlyingMatrix( morphism_1 );
end
########
        
    );
    
    ##
    AddIsProjective( cat,
        
########
function ( cat_1, obj_1 )
    return true;
end
########
        
    );
    
    ##
    AddIsSplitEpimorphism( cat,
        
########
function ( cat_1, morphism_1 )
    return IsZero( DecideZeroRows( HomalgIdentityMatrix( Dimension( Range( morphism_1 ) ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( morphism_1 ) ) );
end
########
        
    );
    
    ##
    AddIsSplitMonomorphism( cat,
        
########
function ( cat_1, morphism_1 )
    return IsZero( DecideZeroColumns( HomalgIdentityMatrix( Dimension( Source( morphism_1 ) ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( morphism_1 ) ) );
end
########
        
    );
    
    ##
    AddIsTerminal( cat,
        
########
function ( cat_1, object_1 )
    return Dimension( object_1 ) = 0;
end
########
        
    );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, morphism_1 )
    if not true then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Source( morphism_1 ) ), UnderlyingRing( cat_1 ) ) then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( morphism_1 ), UnderlyingRing( cat_1 ) ) then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( Range( morphism_1 ) ), UnderlyingRing( cat_1 ) ) then
        return false;
    elif NumberRows( UnderlyingMatrix( morphism_1 ) ) <> Dimension( Source( morphism_1 ) ) then
        return false;
    elif NumberColumns( UnderlyingMatrix( morphism_1 ) ) <> Dimension( Range( morphism_1 ) ) then
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
function ( cat_1, object_1 )
    if not true then
        return false;
    elif not IS_IDENTICAL_OBJ( UnderlyingFieldForHomalg( object_1 ), UnderlyingRing( cat_1 ) ) then
        return false;
    elif Dimension( object_1 ) < 0 then
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
function ( cat_1, object_1 )
    return Dimension( object_1 ) = 0;
end
########
        
    );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, morphism_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := SyzygiesOfRows( UnderlyingMatrix( morphism_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), Source( morphism_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
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
function ( cat_1, mor_1, test_object_1, test_morphism_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := RightDivide( UnderlyingMatrix( test_morphism_1 ), SyzygiesOfRows( UnderlyingMatrix( mor_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( test_morphism_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat_1, mor_1, test_object_1, test_morphism_1, kernel_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := RightDivide( UnderlyingMatrix( test_morphism_1 ), SyzygiesOfRows( UnderlyingMatrix( mor_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( test_morphism_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NrColumns( cap_jit_morphism_attribute_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, morphism_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( UnderlyingMatrix( morphism_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( morphism_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) );
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
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( beta_1 ), Source( alpha_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, obj_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, obj_1, obj_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgIdentityMatrix( Dimension( obj_1 ), UnderlyingRing( cat_1 ) ) );
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
function ( cat_1, right_mor_1, left_mor_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( left_mor_1 ), Range( right_mor_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnderlyingMatrix( left_mor_1 ) * UnderlyingMatrix( right_mor_1 ) );
end
########
        
    );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, morphism_1_1, morphism_2_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( morphism_1_1 ), Range( morphism_2_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnderlyingMatrix( morphism_1_1 ) * UnderlyingMatrix( morphism_2_1 ) );
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
function ( cat_1, object_list_1, projection_number_1, direct_sum_object_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, direct_sum_object_1, object_list_1[projection_number_1], UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( object_list_1{[ 1 .. projection_number_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), Dimension( object_list_1[projection_number_1] ), UnderlyingRing( cat_1 ) ), HomalgIdentityMatrix( Dimension( object_list_1[projection_number_1] ), UnderlyingRing( cat_1 ) ), HomalgZeroMatrix( Sum( object_list_1{[ projection_number_1 + 1 .. Length( object_list_1 ) ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), Dimension( object_list_1[projection_number_1] ), UnderlyingRing( cat_1 ) ) ) );
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
function ( cat_1, obj_1 )
    return obj_1;
end
########
        
    );
    
    ##
    AddSomeProjectiveObject( cat,
        
########
function ( cat_1, obj_1 )
    return obj_1;
end
########
        
    );
    
    ##
    AddSubtractionForMorphisms( cat,
        
########
function ( cat_1, mor1_1, mor2_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( mor1_1 ), Range( mor2_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnderlyingMatrix( mor1_1 ) + -1 * UnderlyingMatrix( mor2_1 ) );
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
function ( cat_1, diagram_1, test_object_1, sink_1, coproduct_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, coproduct_1, test_object_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), Dimension( test_object_1 ), List( sink_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObject( cat,
        
########
function ( cat_1, test_sink_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := HomalgZeroMatrix( 0, Dimension( test_sink_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), test_sink_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, source_1, zero_object_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, zero_object_1, source_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( source_1 ), UnderlyingRing( cat_1 ) ) );
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
function ( cat_1, diagram_1, test_object_1, sink_1, direct_sum_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, test_object_1, direct_sum_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( test_object_1 ), List( sink_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObject( cat,
        
########
function ( cat_1, test_source_1 )
    local cap_jit_morphism_attribute_1;
    cap_jit_morphism_attribute_1 := HomalgZeroMatrix( Dimension( test_source_1 ), 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, test_source_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, cap_jit_morphism_attribute_1 );
end
########
        
    );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, sink_1, zero_object_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, sink_1, zero_object_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( sink_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, source_1, range_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, source_1, range_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, HomalgZeroMatrix( Dimension( source_1 ), Dimension( range_1 ), UnderlyingRing( cat_1 ) ) );
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
function ( cat_1, direct_sum_source_1, source_diagram_1, diagram_1, range_diagram_1, direct_sum_range_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, direct_sum_source_1, direct_sum_range_1, UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ), UnderlyingMatrix, DiagMat( UnderlyingRing( cat_1 ), List( diagram_1, function ( mor_2 )
                return UnderlyingMatrix( mor_2 );
            end ) ) );
end
########
        
    );
    
    Finalize( cat );
    
    return cat;
    
end );
