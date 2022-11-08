# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_RightPresentationsAsFreydCategoryOfCategoryOfColumnsOfFieldPrecompiled", function ( cat )
    
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
    deduped_1_1 := NumberRows( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_3_1, CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingMatrix, UnionOfColumns( deduped_4_1, deduped_1_1, [ deduped_2_1, UnderlyingMatrix( alpha_1 ) ] ) ), UnderlyingMatrix, HomalgIdentityMatrix( deduped_1_1, deduped_4_1 ) );
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
    deduped_1_1 := NumberRows( UnderlyingMatrix( A_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, UnderlyingMatrix, HomalgZeroMatrix( deduped_1_1, 0, deduped_2_1 ) ), A_1, UnderlyingMatrix, HomalgIdentityMatrix( deduped_1_1, deduped_2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( NumberRows( UnderlyingMatrix( a_1 ) ), UnderlyingRing( cat_1 ) ) );
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
            return NumberRows( UnderlyingMatrix( logic_new_func_x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], P_1, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_1_1, deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg2_1 ) - UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( Range( arg2_1 ) ) ) );
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
    AddIsZeroForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( Range( arg2_1 ) ) ) );
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
            return NumberRows( UnderlyingMatrix( logic_new_func_x_2 ) );
        end );
    deduped_1_1 := deduped_2_1[k_1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, objects_1[k_1], UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ 1 .. k_1 - 1 ]} ), deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( deduped_1_1, Sum( deduped_2_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), NumberRows( UnderlyingMatrix( T_1 ) ), List( tau_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( NumberRows( UnderlyingMatrix( T_1 ) ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), NumberRows( UnderlyingMatrix( T_1 ) ), List( tau_1, UnderlyingMatrix ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( 0, NumberRows( UnderlyingMatrix( T_1 ) ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( NumberRows( UnderlyingMatrix( b_1 ) ), NumberRows( UnderlyingMatrix( a_1 ) ), UnderlyingRing( cat_1 ) ) );
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
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, r_1 * UnderlyingMatrix( a_1 ) );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "RightPresentationsAsFreydCategoryOfCategoryOfColumnsOfFieldPrecompiled", function ( ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( ring )
    return RightPresentationsAsFreydCategoryOfCategoryOfColumns( ring );
end;
        
        
    
    cat := category_constructor( ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_RightPresentationsAsFreydCategoryOfCategoryOfColumnsOfFieldPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
