# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_Opposite_MatrixCategory_precompiled", function ( cat )
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( alpha_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( alpha_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_1_1 ), AsHomalgMatrix( deduped_1_1 ) + AsHomalgMatrix( Opposite( beta_1 ) ), Range( deduped_1_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddAdditiveGenerators( cat,
        
########
function ( cat_1 )
    return [ CreateCapCategoryObjectWithAttributes( cat_1, Opposite, AsCapCategoryObject( OppositeCategory( cat_1 ), 1 ) ) ];
end
########
        
    , 100 );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( alpha_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( alpha_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_1_1 ), - AsHomalgMatrix( deduped_1_1 ), Range( deduped_1_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local hoisted_1_1, hoisted_4_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1;
    deduped_11_1 := Opposite( arg2_1 );
    deduped_10_1 := Opposite( arg3_1 );
    deduped_9_1 := AsInteger( deduped_11_1 );
    deduped_8_1 := AsInteger( deduped_10_1 );
    deduped_7_1 := deduped_8_1 * deduped_9_1;
    hoisted_4_1 := OppositeCategory( cat_1 );
    hoisted_1_1 := HomalgIdentityMatrix( deduped_7_1, CommutativeRingOfLinearCategory( cat_1 ) );
    return List( [ 1 .. deduped_7_1 ], function ( i_2 )
            return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg3_1, Opposite, AsCapCategoryMorphism( hoisted_4_1, deduped_10_1, ConvertRowToMatrix( CertainRows( hoisted_1_1, [ i_2 ] ), deduped_8_1, deduped_9_1 ), deduped_11_1 ) );
        end );
end
########
        
    , 100 );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1, hoisted_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Opposite( r_1 );
    deduped_3_1 := AsInteger( deduped_4_1 );
    hoisted_2_1 := AsInteger( Opposite( a_1 ) );
    deduped_1_1 := AsInteger( Opposite( b_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_4_1, CertainRows( HomalgIdentityMatrix( deduped_3_1, CommutativeRingOfLinearCategory( cat_1 ) ), List( [ 1 .. deduped_3_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, deduped_1_1 ) * hoisted_2_1 + QUO_INT( deduped_1_2, deduped_1_1 ) + 1;
              end ) ), Opposite( s_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoDualOnMorphismsWithGivenCoDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( r_1 ), TransposedMatrix( AsHomalgMatrix( Opposite( alpha_1 ) ) ), Opposite( s_1 ) ) );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( r_1 ), ConvertMatrixToRow( HomalgIdentityMatrix( AsInteger( Opposite( a_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ), Opposite( s_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoclosedEvaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( r_1 ), ConvertMatrixToColumn( HomalgIdentityMatrix( AsInteger( Opposite( a_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ), Opposite( s_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoefficientsOfMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return EntriesOfHomalgMatrix( AsHomalgMatrix( Opposite( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( r_1 ), ConvertMatrixToColumn( HomalgIdentityMatrix( AsInteger( Opposite( a_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ), Opposite( s_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoimageObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Opposite, AsCapCategoryObject( OppositeCategory( cat_1 ), RowRankOfMatrix( AsHomalgMatrix( Opposite( arg2_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoimageProjectionWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( alpha_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), C_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( C_1 ), BasisOfRows( AsHomalgMatrix( deduped_1_1 ) ), Range( deduped_1_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( alpha_1 );
    return CreateCapCategoryObjectWithAttributes( cat_1, Opposite, AsCapCategoryObject( OppositeCategory( cat_1 ), AsInteger( Source( deduped_1_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( deduped_1_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Opposite( alpha_1 );
    deduped_3_1 := OppositeCategory( cat_1 );
    deduped_2_1 := SyzygiesOfRows( AsHomalgMatrix( deduped_4_1 ) );
    deduped_1_1 := AsCapCategoryObject( deduped_3_1, NumberRows( deduped_2_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Opposite, AsCapCategoryMorphism( deduped_3_1, deduped_1_1, deduped_2_1, Source( deduped_4_1 ) ) );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( alpha_1 ), Range( beta_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_1_1 ), SafeRightDivide( AsHomalgMatrix( deduped_1_1 ), AsHomalgMatrix( deduped_2_1 ) ), Source( deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( epsilon_1 );
    deduped_1_1 := Opposite( tau_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( epsilon_1 ), Range( tau_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_1_1 ), UniqueRightDivide( AsHomalgMatrix( deduped_1_1 ), AsHomalgMatrix( deduped_2_1 ) ), Source( deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Opposite( alpha_1 );
    deduped_3_1 := S_1[i_1];
    deduped_2_1 := List( S_1, function ( x_2 )
            return AsInteger( Opposite( x_2 ) );
        end );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_3_1, Range( alpha_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_4_1 ), CertainColumns( AsHomalgMatrix( deduped_4_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ), CAP_JIT_INCOMPLETE_LOGIC( Opposite( CAP_JIT_INCOMPLETE_LOGIC( deduped_3_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    cat!.cached_precompiled_functions.ComponentOfMorphismFromDirectSum :=
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Opposite( alpha_1 );
    deduped_2_1 := List( S_1, function ( x_2 )
            return AsInteger( Opposite( x_2 ) );
        end );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return CreateCapCategoryMorphismWithAttributes( cat_1, S_1[i_1], Range( alpha_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_3_1 ), CertainColumns( AsHomalgMatrix( deduped_3_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ), List( S_1, Opposite )[i_1] ) );
end
########
        
    ;
    
    ##
    AddComponentOfMorphismIntoDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Opposite( alpha_1 );
    deduped_3_1 := S_1[i_1];
    deduped_2_1 := List( S_1, function ( x_2 )
            return AsInteger( Opposite( x_2 ) );
        end );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), deduped_3_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), CAP_JIT_INCOMPLETE_LOGIC( Opposite( CAP_JIT_INCOMPLETE_LOGIC( deduped_3_1 ) ) ), CertainRows( AsHomalgMatrix( deduped_4_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ), Range( deduped_4_1 ) ) );
end
########
        
    , 100 );
    
    ##
    cat!.cached_precompiled_functions.ComponentOfMorphismIntoDirectSum :=
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Opposite( alpha_1 );
    deduped_2_1 := List( S_1, function ( x_2 )
            return AsInteger( Opposite( x_2 ) );
        end );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), S_1[i_1], Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), List( S_1, Opposite )[i_1], CertainRows( AsHomalgMatrix( deduped_3_1 ), [ deduped_1_1 + 1 .. deduped_1_1 + deduped_2_1[i_1] ] ), Range( deduped_3_1 ) ) );
end
########
        
    ;
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, objects_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Opposite, AsCapCategoryObject( OppositeCategory( cat_1 ), Sum( List( objects_1, function ( x_2 )
                  return AsInteger( Opposite( x_2 ) );
              end ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, Pp_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( Pp_1 ), DiagMat( CommutativeRingOfLinearCategory( cat_1 ), List( L_1, function ( x_2 )
                  return AsHomalgMatrix( Opposite( x_2 ) );
              end ) ), Opposite( P_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return AsCapCategoryObject( OppositeCategory( cat_1 ), 1 );
end
########
        
    , 100 );
    
    ##
    AddDualOnMorphismsWithGivenDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( r_1 ), TransposedMatrix( AsHomalgMatrix( Opposite( alpha_1 ) ) ), Opposite( s_1 ) ) );
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
    local deduped_1_1;
    deduped_1_1 := Opposite( A_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, A_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, HomalgIdentityMatrix( AsInteger( deduped_1_1 ), CommutativeRingOfLinearCategory( cat_1 ) ), deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( r_1 ), ConvertMatrixToRow( HomalgIdentityMatrix( AsInteger( Opposite( a_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ), Opposite( s_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return AsCapCategoryMorphism( OppositeCategory( cat_1 ), source_1, KroneckerMat( TransposedMatrix( AsHomalgMatrix( Opposite( beta_1 ) ) ), AsHomalgMatrix( Opposite( alpha_1 ) ) ), range_1 );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return AsCapCategoryObject( OppositeCategory( cat_1 ), AsInteger( Opposite( arg3_1 ) ) * AsInteger( Opposite( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( a_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, HomalgIdentityMatrix( AsInteger( deduped_1_1 ), CommutativeRingOfLinearCategory( cat_1 ) ), deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddImageEmbeddingWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( alpha_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, I_1, Range( alpha_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_1_1 ), BasisOfColumns( AsHomalgMatrix( deduped_1_1 ) ), Opposite( I_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddImageObject( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Opposite, AsCapCategoryObject( OppositeCategory( cat_1 ), ColumnRankOfMatrix( AsHomalgMatrix( Opposite( arg2_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := CommutativeRingOfLinearCategory( cat_1 );
    deduped_3_1 := objects_1[k_1];
    deduped_2_1 := List( objects_1, function ( x_2 )
            return AsInteger( Opposite( x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_3_1, P_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( P_1 ), UnionOfRows( deduped_4_1, deduped_1_1, [ HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_4_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_4_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_4_1 ) ] ), CAP_JIT_INCOMPLETE_LOGIC( Opposite( CAP_JIT_INCOMPLETE_LOGIC( deduped_3_1 ) ) ) ) );
end
########
        
    , 100 );
    
    ##
    cat!.cached_precompiled_functions.InjectionOfCofactorOfDirectSumWithGivenDirectSum :=
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := CommutativeRingOfLinearCategory( cat_1 );
    deduped_2_1 := List( objects_1, function ( x_2 )
            return AsInteger( Opposite( x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], P_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( P_1 ), UnionOfRows( deduped_3_1, deduped_1_1, [ HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_3_1 ) ] ), List( objects_1, Opposite )[k_1] ) );
end
########
        
    ;
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    return AsCapCategoryMorphism( OppositeCategory( cat_1 ), source_1, ConvertMatrixToRow( AsHomalgMatrix( Opposite( alpha_1 ) ) ), range_1 );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, source_1, range_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( source_1 );
    deduped_1_1 := Opposite( range_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, ConvertRowToMatrix( AsHomalgMatrix( alpha_1 ), AsInteger( deduped_1_1 ), AsInteger( deduped_2_1 ) ), deduped_2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( AsHomalgMatrix( Opposite( arg3_1 ) ), AsHomalgMatrix( Opposite( arg2_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return AsHomalgMatrix( Opposite( arg2_1 ) ) = AsHomalgMatrix( Opposite( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return AsHomalgMatrix( Opposite( arg2_1 ) ) = AsHomalgMatrix( Opposite( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return AsInteger( Opposite( arg2_1 ) ) = AsInteger( Opposite( arg3_1 ) );
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
        
    , 1 );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( AsHomalgMatrix( Opposite( arg2_1 ) ), AsHomalgMatrix( Opposite( arg3_1 ) ) ) );
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
        
    , 1 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( alpha_1 );
    deduped_1_1 := AsHomalgMatrix( deduped_2_1 );
    if not IsHomalgMatrix( deduped_1_1 ) then
        return false;
    elif not NumberRows( deduped_1_1 ) = AsInteger( Source( deduped_2_1 ) ) then
        return false;
    elif not NumberColumns( deduped_1_1 ) = AsInteger( Range( deduped_2_1 ) ) then
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
    deduped_1_1 := AsInteger( Opposite( arg2_1 ) );
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
    return IsZero( AsHomalgMatrix( Opposite( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return AsInteger( Opposite( arg2_1 ) ) = 0;
end
########
        
    , 100 );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Opposite( alpha_1 );
    deduped_3_1 := OppositeCategory( cat_1 );
    deduped_2_1 := SyzygiesOfColumns( AsHomalgMatrix( deduped_4_1 ) );
    deduped_1_1 := AsCapCategoryObject( deduped_3_1, NumberColumns( deduped_2_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Source( alpha_1 ), Opposite, AsCapCategoryMorphism( deduped_3_1, Range( deduped_4_1 ), deduped_2_1, deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( alpha_1 );
    return CreateCapCategoryObjectWithAttributes( cat_1, Opposite, AsCapCategoryObject( OppositeCategory( cat_1 ), AsInteger( Range( deduped_1_1 ) ) - RowRankOfMatrix( AsHomalgMatrix( deduped_1_1 ) ) ) );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Source( beta_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Range( deduped_1_1 ), SafeLeftDivide( AsHomalgMatrix( deduped_1_1 ), AsHomalgMatrix( deduped_2_1 ) ), Range( deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( tau_1 );
    deduped_1_1 := Opposite( iota_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( tau_1 ), Source( iota_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Range( deduped_1_1 ), UniqueLeftDivide( AsHomalgMatrix( deduped_1_1 ), AsHomalgMatrix( deduped_2_1 ) ), Range( deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( A_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, A_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, HomalgIdentityMatrix( AsInteger( deduped_1_1 ), CommutativeRingOfLinearCategory( cat_1 ) ), deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg4_1, Opposite, arg3_1 );
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
    local deduped_1_1;
    deduped_1_1 := Opposite( a_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, a_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, HomalgIdentityMatrix( AsInteger( deduped_1_1 ), CommutativeRingOfLinearCategory( cat_1 ) ), Opposite( s_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismToBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( a_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, r_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( r_1 ), HomalgIdentityMatrix( AsInteger( deduped_1_1 ), CommutativeRingOfLinearCategory( cat_1 ) ), deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, alpha_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( alpha_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( alpha_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_1_1 ), r_1 * AsHomalgMatrix( deduped_1_1 ), Range( deduped_1_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Opposite, arg2_1 );
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
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( beta_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_1_1 ), AsHomalgMatrix( deduped_1_1 ) * AsHomalgMatrix( deduped_2_1 ), Range( deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := CommutativeRingOfLinearCategory( cat_1 );
    deduped_3_1 := objects_1[k_1];
    deduped_2_1 := List( objects_1, function ( x_2 )
            return AsInteger( Opposite( x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, deduped_3_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), CAP_JIT_INCOMPLETE_LOGIC( Opposite( CAP_JIT_INCOMPLETE_LOGIC( deduped_3_1 ) ) ), UnionOfColumns( deduped_4_1, deduped_1_1, [ HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_4_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_4_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_4_1 ) ] ), Opposite( P_1 ) ) );
end
########
        
    , 100 );
    
    ##
    cat!.cached_precompiled_functions.ProjectionInFactorOfDirectSumWithGivenDirectSum :=
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := CommutativeRingOfLinearCategory( cat_1 );
    deduped_2_1 := List( objects_1, function ( x_2 )
            return AsInteger( Opposite( x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, objects_1[k_1], Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), List( objects_1, Opposite )[k_1], UnionOfColumns( deduped_3_1, deduped_1_1, [ HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_3_1 ) ] ), Opposite( P_1 ) ) );
end
########
        
    ;
    
    ##
    AddSimplifyRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Source( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( AsHomalgMatrix( deduped_2_1 ) )[1], Range( deduped_2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Source( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( AsHomalgMatrix( deduped_2_1 ) )[2], deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifyRange_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Source( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Range( mor_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( AsHomalgMatrix( deduped_2_1 ) )[3], deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Range( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Range( mor_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Source( deduped_2_1 ), SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( AsHomalgMatrix( deduped_2_1 ) )[1], deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Opposite( mor_1 );
    deduped_2_1 := Source( deduped_3_1 );
    deduped_1_1 := Range( deduped_3_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_2_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_2_1, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( deduped_3_1 ) )[1], deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Source( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Range( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( deduped_2_1 ) )[2], deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Range( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( deduped_2_1 ) )[5], deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Source( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Range( mor_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( deduped_2_1 ) )[4], deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Range( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Source( mor_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( AsHomalgMatrix( deduped_2_1 ) )[3], deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoFromInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Range( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( mor_1 ), CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( AsHomalgMatrix( deduped_2_1 ) )[3], deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddSimplifySource_IsoToInputObject( cat,
        
########
function ( cat_1, mor_1, n_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( mor_1 );
    deduped_1_1 := Range( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, Opposite, deduped_1_1 ), Source( mor_1 ), Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( AsHomalgMatrix( deduped_2_1 ) )[2], deduped_1_1 ) );
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
    AddSumOfMorphisms( cat,
        
########
function ( cat_1, source_1, list_of_morphisms_1, range_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( source_1 );
    deduped_1_1 := Opposite( range_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, Sum( List( list_of_morphisms_1, function ( x_2 )
                  return AsHomalgMatrix( Opposite( x_2 ) );
              end ), HomalgZeroMatrix( AsInteger( deduped_1_1 ), AsInteger( deduped_2_1 ), CommutativeRingOfLinearCategory( cat_1 ) ) ), deduped_2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( r_1 ), KroneckerMat( AsHomalgMatrix( Opposite( alpha_1 ) ), AsHomalgMatrix( Opposite( beta_1 ) ) ), Opposite( s_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Opposite, AsCapCategoryObject( OppositeCategory( cat_1 ), AsInteger( Opposite( arg2_1 ) ) * AsInteger( Opposite( arg3_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Opposite, AsCapCategoryObject( OppositeCategory( cat_1 ), 1 ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( T_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, UnionOfColumns( CommutativeRingOfLinearCategory( cat_1 ), AsInteger( deduped_1_1 ), List( tau_1, function ( x_2 )
                  return AsHomalgMatrix( Opposite( x_2 ) );
              end ) ), Opposite( P_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( T_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, HomalgZeroMatrix( AsInteger( deduped_1_1 ), 0, CommutativeRingOfLinearCategory( cat_1 ) ), Opposite( P_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( T_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( P_1 ), UnionOfRows( CommutativeRingOfLinearCategory( cat_1 ), AsInteger( deduped_1_1 ), List( tau_1, function ( x_2 )
                  return AsHomalgMatrix( Opposite( x_2 ) );
              end ) ), deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    local deduped_1_1;
    deduped_1_1 := Opposite( T_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), Opposite( P_1 ), HomalgZeroMatrix( 0, AsInteger( deduped_1_1 ), CommutativeRingOfLinearCategory( cat_1 ) ), deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Opposite( a_1 );
    deduped_1_1 := Opposite( b_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, b_1, Opposite, AsCapCategoryMorphism( OppositeCategory( cat_1 ), deduped_1_1, HomalgZeroMatrix( AsInteger( deduped_1_1 ), AsInteger( deduped_2_1 ), CommutativeRingOfLinearCategory( cat_1 ) ), deduped_2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Opposite, AsCapCategoryObject( OppositeCategory( cat_1 ), 0 ) );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "Opposite_MatrixCategory_precompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( field )
    return Opposite( MatrixCategory( field : no_precompiled_code := false,
          FinalizeCategory := true ) : only_primitive_operations := true );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_Opposite_MatrixCategory_precompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
