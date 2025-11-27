# SPDX-License-Identifier: GPL-2.0-or-later
# AdditiveClosuresForCAP: Additive closures for pre-additive categories
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryOfRows_as_AdditiveClosure_RingAsCategory_HomalgExteriorRingOverField_precompiled", function ( cat )
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( alpha_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) + UnderlyingMatrix( beta_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAdditiveGenerators( cat,
        
########
function ( cat_1 )
    return [ CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 1 ) ];
end
########
        
    , 100 );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( alpha_1 ), UnderlyingMatrix, - UnderlyingMatrix( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, SafeLeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( epsilon_1 ), Range( tau_1 ), UnderlyingMatrix, UniqueLeftDivide( UnderlyingMatrix( epsilon_1 ), UnderlyingMatrix( tau_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, RankOfObject );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return CreateCapCategoryMorphismWithAttributes( cat_1, S_1[i_1], Range( alpha_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismIntoDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, RankOfObject );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), S_1[i_1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, objects_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, Sum( List( objects_1, RankOfObject ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, Pp_1, UnderlyingMatrix, DiagMat( UnderlyingRing( cat_1 ), List( L_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, 1 );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    local deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingMatrix( beta_1 );
    deduped_4_1 := BasisOfRingOverBaseFieldAsColumnVector( cat_1 );
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := UnderlyingRing( cat_1 );
    return CreateCapCategoryMorphismWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, range_1, UnderlyingMatrix, CoercedMatrix( deduped_2_1, CommutativeRingOfLinearCategory( cat_1 ), CoefficientsWithGivenMonomials( KroneckerMat( TransposedMatrix( deduped_3_1 ), DualKroneckerMat( UnionOfRows( deduped_2_1, NumberColumns( deduped_4_1 ), List( EntriesOfHomalgColumnVector( deduped_4_1 ), function ( x_2 )
                        return COMPILATION_HELPER_HomalgMatrixFromRingElement( x_2, deduped_2_1 );
                    end ) ), deduped_5_1 ) ), DiagMat( deduped_2_1, ListWithIdenticalEntries( NumberRows( deduped_3_1 ), DiagMat( deduped_2_1, ListWithIdenticalEntries( NumberColumns( deduped_5_1 ), deduped_4_1 ) ) ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg2_1 ) * (RankOfObject( arg3_1 ) * Length( EntriesOfHomalgColumnVector( BasisOfRingOverBaseFieldAsColumnVector( cat_1 ) ) )) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfBiasedWeakPushout( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1;
    deduped_3_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( a_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( deduped_3_1 ) ), UnderlyingMatrix, deduped_3_1 );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := List( objects_1, RankOfObject );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := deduped_3_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], P_1, UnderlyingMatrix, UnionOfColumns( deduped_2_1, deduped_1_1, [ HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_2_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_2_1 ) ] ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    deduped_1_1 := UnderlyingRing( cat_1 );
    return CreateCapCategoryMorphismWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, range_1, UnderlyingMatrix, CoercedMatrix( deduped_1_1, CommutativeRingOfLinearCategory( cat_1 ), CoefficientsWithGivenMonomials( ConvertMatrixToRow( deduped_2_1 ), DiagMat( deduped_1_1, ListWithIdenticalEntries( NumberRows( deduped_2_1 ), DiagMat( deduped_1_1, ListWithIdenticalEntries( NumberColumns( deduped_2_1 ), BasisOfRingOverBaseFieldAsColumnVector( cat_1 ) ) ) ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, source_1, range_1, alpha_1 )
    local hoisted_1_1, hoisted_3_1, hoisted_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := BasisOfRingOverBaseFieldAsColumnVector( cat_1 );
    deduped_10_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := RankOfObject( range_1 );
    deduped_8_1 := RankOfObject( source_1 );
    deduped_7_1 := Length( EntriesOfHomalgColumnVector( deduped_11_1 ) );
    hoisted_6_1 := [ 1 .. deduped_9_1 ];
    hoisted_3_1 := UnderlyingMatrix( alpha_1 );
    hoisted_1_1 := deduped_9_1 * deduped_7_1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, UnderlyingMatrix, HomalgMatrixListList( List( [ 1 .. deduped_8_1 ], function ( j_2 )
                local deduped_1_2;
                deduped_1_2 := (CAP_JIT_INCOMPLETE_LOGIC( j_2 ) - 1) * hoisted_1_1;
                return List( hoisted_6_1, function ( s_3 )
                        local deduped_1_3;
                        deduped_1_3 := (CAP_JIT_INCOMPLETE_LOGIC( s_3 ) - 1) * deduped_7_1;
                        return EntriesOfHomalgMatrix( CoercedMatrix( deduped_10_1, CAP_JIT_INCOMPLETE_LOGIC( CertainColumns( hoisted_3_1, [ deduped_1_2 + (deduped_1_3 + 1) .. deduped_1_2 + (deduped_1_3 + deduped_7_1) ] ) ) ) * deduped_11_1 )[1];
                    end );
            end ), deduped_8_1, deduped_9_1, deduped_10_1 ) );
end
########
        
    , 100 );
    
    ##
    cat!.cached_precompiled_functions.InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism :=
        
########
function ( cat_1, source_1, range_1, alpha_1 )
    local hoisted_1_1, hoisted_3_1, deduped_5_1, hoisted_6_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1;
    deduped_14_1 := BasisOfRingOverBaseFieldAsColumnVector( cat_1 );
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_12_1 := RankOfObject( range_1 );
    deduped_11_1 := RankOfObject( source_1 );
    deduped_10_1 := [ 1 .. deduped_11_1 ];
    deduped_9_1 := Length( EntriesOfHomalgColumnVector( deduped_14_1 ) );
    deduped_5_1 := [ 1 .. deduped_12_1 ];
    hoisted_3_1 := UnderlyingMatrix( alpha_1 );
    hoisted_1_1 := deduped_12_1 * deduped_9_1;
    hoisted_6_1 := List( deduped_10_1, function ( j_2 )
            return List( deduped_5_1, function ( s_3 )
                    local hoisted_1_3, hoisted_2_3, deduped_3_3;
                    deduped_3_3 := (s_3 - 1) * deduped_9_1;
                    hoisted_2_3 := deduped_3_3 + deduped_9_1;
                    hoisted_1_3 := deduped_3_3 + 1;
                    return List( deduped_10_1, function ( j_4 )
                              local deduped_1_4;
                              deduped_1_4 := (j_4 - 1) * hoisted_1_1;
                              return CertainColumns( hoisted_3_1, [ deduped_1_4 + hoisted_1_3 .. deduped_1_4 + hoisted_2_3 ] );
                          end )[j_2];
                end );
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, UnderlyingMatrix, HomalgMatrixListList( List( deduped_10_1, function ( j_2 )
                local hoisted_1_2;
                hoisted_1_2 := hoisted_6_1[j_2];
                return List( deduped_5_1, function ( s_3 )
                        return EntriesOfHomalgMatrix( CoercedMatrix( deduped_13_1, hoisted_1_2[s_3] ) * deduped_14_1 )[1];
                    end );
            end ), deduped_11_1, deduped_12_1, deduped_13_1 ) );
end
########
        
    ;
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
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
    return RankOfObject( arg2_1 ) = RankOfObject( arg3_1 );
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
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( alpha_1 );
    if not IsHomalgMatrix( deduped_1_1 ) then
        return false;
    elif not NumberRows( deduped_1_1 ) = RankOfObject( Source( alpha_1 ) ) then
        return false;
    elif not NumberColumns( deduped_1_1 ) = RankOfObject( Range( alpha_1 ) ) then
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
    local deduped_1_1;
    deduped_1_1 := RankOfObject( arg2_1 );
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
    return IsZero( UnderlyingMatrix( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return RankOfObject( arg2_1 ) = 0;
end
########
        
    , 100 );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, SafeRightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( tau_1 ), Source( iota_1 ), UnderlyingMatrix, UniqueRightDivide( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( iota_1 ) ) );
end
########
        
    , 100 );
    
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
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, alpha_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( alpha_1 ), UnderlyingMatrix, r_1 / UnderlyingRing( cat_1 ) * UnderlyingMatrix( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return RankOfObject( arg2_1 );
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
    deduped_3_1 := List( objects_1, RankOfObject );
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := deduped_3_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, objects_1[k_1], UnderlyingMatrix, UnionOfRows( deduped_2_1, deduped_1_1, [ HomalgZeroMatrix( Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_2_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ), HomalgZeroMatrix( Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_2_1 ) ] ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionOfBiasedWeakFiberProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1;
    deduped_3_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( deduped_3_1 ) ), Source( a_1 ), UnderlyingMatrix, deduped_3_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), Range( mor_1 ), UnderlyingMatrix, SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1] );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Range( mor_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2] );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Range( mor_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3] );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), Range( mor_1 ), UnderlyingMatrix, SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1] );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), Range( mor_1 ), UnderlyingMatrix, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[1] );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Range( mor_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[3] );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Source( mor_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[4] );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Range( mor_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[5] );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Source( mor_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[2] );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Source( mor_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3] );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1;
    deduped_1_1 := Source( mor_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2] );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple( alpha_1 )[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( deduped_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( deduped_1_1 ) ), UnderlyingMatrix, deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple( alpha_1 )[2];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( deduped_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( deduped_1_1 ) ), UnderlyingMatrix, deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple( alpha_1 )[3];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( deduped_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( deduped_1_1 ) ), UnderlyingMatrix, deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSumOfMorphisms( cat,
        
########
function ( cat_1, source_1, list_of_morphisms_1, range_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, UnderlyingMatrix, Sum( List( list_of_morphisms_1, UnderlyingMatrix ), HomalgZeroMatrix( RankOfObject( source_1 ), RankOfObject( range_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), RankOfObject( T_1 ), List( tau_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( 0, RankOfObject( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), RankOfObject( T_1 ), List( tau_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( T_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddWeakCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( deduped_1_1 ) ), UnderlyingMatrix, deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddWeakKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( deduped_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, deduped_1_1 );
end
########
        
    , 100 );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( a_1 ), RankOfObject( b_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 0 );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "CategoryOfRows_as_AdditiveClosure_RingAsCategory_HomalgExteriorRingOverField_precompiled", function ( homalg_ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( homalg_ring )
    return CategoryOfRows( homalg_ring );
end;
        
        
    
    cat := category_constructor( homalg_ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfRows_as_AdditiveClosure_RingAsCategory_HomalgExteriorRingOverField_precompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
