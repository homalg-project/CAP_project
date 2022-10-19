# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryOfColumnsAsOppositeOfCategoryOfRowsOfFieldPrecompiled", function ( cat )
    
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
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := RankOfObject( arg2_1 );
    deduped_5_1 := RankOfObject( arg3_1 );
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
    AddBraidingInverseWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := RankOfObject( s_1 );
    hoisted_2_1 := RankOfObject( a_1 );
    hoisted_1_1 := RankOfObject( b_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, hoisted_1_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, hoisted_1_1 ) + 1;
                end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, UnderlyingRing( cat_1 ) ) );
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
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := RankOfObject( a_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, function (  )
              if deduped_1_1 = 0 then
                  return HomalgZeroMatrix( RankOfObject( r_1 ), RankOfObject( s_1 ), deduped_2_1 );
              else
                  return ConvertMatrixToRow( HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) );
              fi;
              return;
          end(  ) );
end
########
        
    , 100 );
    
    ##
    AddCoclosedEvaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := RankOfObject( a_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, function (  )
              if deduped_1_1 = 0 then
                  return HomalgZeroMatrix( RankOfObject( r_1 ), RankOfObject( s_1 ), deduped_2_1 );
              else
                  return ConvertMatrixToColumn( HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) );
              fi;
              return;
          end(  ) );
end
########
        
    , 100 );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return EntriesOfHomalgMatrix( UnderlyingMatrix( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := RankOfObject( a_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, function (  )
              if deduped_1_1 = 0 then
                  return HomalgZeroMatrix( RankOfObject( r_1 ), RankOfObject( s_1 ), deduped_2_1 );
              else
                  return ConvertMatrixToColumn( HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) );
              fi;
              return;
          end(  ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, RankOfObject( Range( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, RankOfObject );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, S_1[i_1], Range( alpha_1 ), UnderlyingMatrix, CertainColumns( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismIntoDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, RankOfObject );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), S_1[i_1], UnderlyingMatrix, CertainRows( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, Sum( List( arg2_1, RankOfObject ) ) );
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
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    deduped_1_1 := RankOfObject( a_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, function (  )
              if deduped_1_1 = 0 then
                  return HomalgZeroMatrix( RankOfObject( r_1 ), RankOfObject( s_1 ), deduped_2_1 );
              else
                  return ConvertMatrixToRow( HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) );
              fi;
              return;
          end(  ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return CreateCapCategoryMorphismWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, range_1, UnderlyingMatrix, KroneckerMat( TransposedMatrix( UnderlyingMatrix( beta_1 ) ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), RankOfObject, RankOfObject( arg3_1 ) * RankOfObject( arg2_1 ) );
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
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( a_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    return CreateCapCategoryMorphismWithAttributes( RangeCategoryOfHomomorphismStructure( cat_1 ), source_1, range_1, UnderlyingMatrix, ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( UnderlyingMatrix( arg4_1 ), RankOfObject( arg3_1 ), RankOfObject( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
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
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
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
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    if NumberRows( deduped_1_1 ) <> RankOfObject( Range( arg2_1 ) ) then
        return false;
    elif NumberColumns( deduped_1_1 ) <> RankOfObject( Source( arg2_1 ) ) then
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
    if RankOfObject( arg2_1 ) < 0 then
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
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, RankOfObject( Source( arg2_1 ) ) - RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( beta_1 ), UnderlyingMatrix( alpha_1 ) ) );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismToBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, r_1, UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
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
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( beta_1 ) * UnderlyingMatrix( alpha_1 ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionOfBiasedWeakFiberProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( a_1 ), UnderlyingMatrix( b_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), Source( a_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddRandomMorphismWithFixedSourceAndRangeByInteger( cat,
        
########
function ( cat_1, A_1, B_1, n_1 )
    local hoisted_1_1;
    hoisted_1_1 := RandomMatrix( RankOfObject( B_1 ), RankOfObject( A_1 ), UnderlyingRing( cat_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, B_1, UnderlyingMatrix, Sum( [ 1 ], function ( c_2 )
              return c_2 * hoisted_1_1;
          end ) );
end
########
        
    , 100 );
    
    ##
    AddRandomObjectByInteger( cat,
        
########
function ( cat_1, n_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, Random( [ 0 .. n_1 ] ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[2];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[5];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[4];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), Range( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( mor_1 ) )[3];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), Source( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[3];
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( mor_1 ) )[2];
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), Source( mor_1 ), UnderlyingMatrix, morphism_attr_1_1 );
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
    return AsCategoryOfColumnsMorphism( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha_1 )[1], cat_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCategoryOfColumnsMorphism( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha_1 )[2], cat_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    return AsCategoryOfColumnsMorphism( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha_1 )[3], cat_1 );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), RankOfObject( T_1 ), List( tau_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( T_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), RankOfObject( T_1 ), List( tau_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( 0, RankOfObject( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddWeakCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberRows( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddWeakKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := ReducedSyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, NumberColumns( morphism_attr_1_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( RankOfObject( b_1 ), RankOfObject( a_1 ), UnderlyingRing( cat_1 ) ) );
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
    
end );

BindGlobal( "CategoryOfColumnsAsOppositeOfCategoryOfRowsOfFieldPrecompiled", function ( homalg_ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( homalg_ring )
    return CategoryOfColumnsAsOppositeOfCategoryOfRows( homalg_ring );
end;
        
        
    
    cat := category_constructor( homalg_ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfColumnsAsOppositeOfCategoryOfRowsOfFieldPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
