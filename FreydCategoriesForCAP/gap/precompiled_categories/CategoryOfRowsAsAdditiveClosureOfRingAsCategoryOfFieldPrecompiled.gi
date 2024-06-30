# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfFieldPrecompiled", function ( cat )
    
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
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := RankOfObject( arg3_1 );
    deduped_5_1 := RankOfObject( arg2_1 );
    deduped_4_1 := deduped_5_1 * deduped_6_1;
    hoisted_1_1 := HomalgIdentityMatrix( deduped_4_1, UnderlyingRing( cat_1 ) );
    return List( [ 1 .. deduped_4_1 ], function ( i_2 )
            return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( CertainRows( hoisted_1_1, [ i_2 ] ), deduped_5_1, deduped_6_1 ) );
        end );
end
########
        
    , 100 );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := RankOfObject( s_1 );
    hoisted_4_1 := RankOfObject( a_1 );
    deduped_3_1 := RankOfObject( b_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrixListList( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, deduped_3_1 ) * hoisted_4_1 + QUO_INT( deduped_1_2, deduped_3_1 ) + 1;
                end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
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
    AddCoclosedCoevaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoclosedEvaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoefficientsOfMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return EntriesOfHomalgMatrix( UnderlyingMatrix( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoimageObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoimageProjectionWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), C_1, UnderlyingMatrix, BasisOfColumns( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, RankOfObject( Range( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
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
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 1 );
end
########
        
    , 100 );
    
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
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
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, RankOfObject( arg2_1 ) * RankOfObject( arg3_1 ) );
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
    AddImageEmbeddingWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, I_1, Range( alpha_1 ), UnderlyingMatrix, BasisOfRows( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddImageObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfBiasedWeakPushout( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_3_1;
    morphism_attr_3_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( a_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( objects_1, RankOfObject );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], P_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_3_1 ) ) );
end
########
        
    , 100 );
    
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
function ( cat_1, source_1, range_1, alpha_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, UnderlyingMatrix, ConvertRowToMatrix( UnderlyingMatrix( alpha_1 ), RankOfObject( source_1 ), RankOfObject( range_1 ) ) );
end
########
        
    , 100 );
    
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
    AddIsInjective( cat,
        
########
function ( cat_1, arg2_1 )
    return true;
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
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, RankOfObject( Source( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ) );
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
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( A_1 ), UnderlyingRing( cat_1 ) ) );
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
    AddMorphismFromCoBidualWithGivenCoBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismToBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, alpha_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( alpha_1 ), UnderlyingMatrix, r_1 * UnderlyingMatrix( alpha_1 ) );
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
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := List( objects_1, RankOfObject );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, objects_1[k_1], UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionOfBiasedWeakFiberProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_3_1;
    morphism_attr_3_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_3_1 ) ), Source( a_1 ), UnderlyingMatrix, morphism_attr_3_1 );
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
    morphism_attr_1_1 := HomalgZeroMatrix( 0, RankOfObject( Range( alpha_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 0 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_1_1 := SafeRightDivide( HomalgIdentityMatrix( NumberColumns( deduped_2_1 ), UnderlyingRing( cat_1 ) ), deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), Range( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
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
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, RankOfObject( arg2_1 ) * RankOfObject( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 1 );
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
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddWeakKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
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

BindGlobal( "CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfFieldPrecompiled", function ( homalg_ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( homalg_ring )
    return CategoryOfRows( homalg_ring );
end;
        
        
    
    cat := category_constructor( homalg_ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfFieldPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
