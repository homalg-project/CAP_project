# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CoFreydCategoryAsOppositeOfFreydCategoryOfOppositePrecompiled", function ( cat )
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( alpha_1 ), UnderlyingMorphism, AdditionForMorphisms( UnderlyingCategory( cat_1 ), UnderlyingMorphism( alpha_1 ), UnderlyingMorphism( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( alpha_1 ), UnderlyingMorphism, AdditiveInverseForMorphisms( UnderlyingCategory( cat_1 ), UnderlyingMorphism( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, objects_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, CoRelationMorphism, DirectSumFunctorial( UnderlyingCategory( cat_1 ), List( objects_1, function ( x_2 )
                return Source( CoRelationMorphism( x_2 ) );
            end ), List( objects_1, CoRelationMorphism ), List( objects_1, function ( x_2 )
                return Range( CoRelationMorphism( x_2 ) );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, Pp_1, UnderlyingMorphism, DirectSumFunctorial( UnderlyingCategory( cat_1 ), List( L_1, function ( x_2 )
                return Source( CoRelationMorphism( Source( x_2 ) ) );
            end ), List( L_1, UnderlyingMorphism ), List( L_1, function ( x_2 )
                return Source( CoRelationMorphism( Range( x_2 ) ) );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, UnderlyingMorphism, IdentityMorphism( UnderlyingCategory( cat_1 ), Source( CoRelationMorphism( a_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, objects_1[k_1], P_1, UnderlyingMorphism, InjectionOfCofactorOfDirectSum( UnderlyingCategory( cat_1 ), List( objects_1, function ( x_2 )
                return Source( CoRelationMorphism( x_2 ) );
            end ), k_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingCategory( cat_1 );
    return IsColiftable( deduped_1_1, CoRelationMorphism( Source( arg2_1 ) ), AdditionForMorphisms( deduped_1_1, UnderlyingMorphism( arg2_1 ), AdditiveInverseForMorphisms( deduped_1_1, UnderlyingMorphism( arg3_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsEqualForMorphisms( UnderlyingCategory( cat_1 ), UnderlyingMorphism( arg2_1 ), UnderlyingMorphism( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsEqualForMorphismsOnMor( UnderlyingCategory( cat_1 ), CoRelationMorphism( arg2_1 ), CoRelationMorphism( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingMorphism( arg2_1 );
    deduped_1_1 := UnderlyingCategory( cat_1 );
    if not IsWellDefinedForMorphisms( deduped_1_1, deduped_2_1 ) then
        return false;
    elif not IsColiftable( deduped_1_1, CoRelationMorphism( Source( arg2_1 ) ), PreCompose( deduped_1_1, deduped_2_1, CoRelationMorphism( Range( arg2_1 ) ) ) ) then
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
    if not IsWellDefinedForMorphisms( UnderlyingCategory( cat_1 ), CoRelationMorphism( arg2_1 ) ) then
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
    return IsColiftable( UnderlyingCategory( cat_1 ), CoRelationMorphism( Source( arg2_1 ) ), UnderlyingMorphism( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Source( alpha_1 );
    deduped_3_1 := UnderlyingCategory( cat_1 );
    deduped_2_1 := CoRelationMorphism( deduped_4_1 );
    deduped_1_1 := Source( deduped_2_1 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, CreateCapCategoryObjectWithAttributes( cat_1, CoRelationMorphism, UniversalMorphismIntoDirectSum( deduped_3_1, [ Range( deduped_2_1 ), Source( CoRelationMorphism( Range( alpha_1 ) ) ) ], deduped_1_1, [ deduped_2_1, UnderlyingMorphism( alpha_1 ) ] ) ), deduped_4_1, UnderlyingMorphism, IdentityMorphism( deduped_3_1, deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMorphism, UnderlyingMorphism( tau_1 ) );
end
########
        
    , 100 );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingCategory( cat_1 );
    deduped_1_1 := Source( CoRelationMorphism( A_1 ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, A_1, CreateCapCategoryObjectWithAttributes( cat_1, CoRelationMorphism, UniversalMorphismIntoZeroObject( deduped_2_1, deduped_1_1 ) ), UnderlyingMorphism, IdentityMorphism( deduped_2_1, deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg4_1, UnderlyingMorphism, arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return UnderlyingMorphism( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, CoRelationMorphism, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return CoRelationMorphism( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMorphism, PreCompose( UnderlyingCategory( cat_1 ), UnderlyingMorphism( alpha_1 ), UnderlyingMorphism( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, objects_1[k_1], UnderlyingMorphism, ProjectionInFactorOfDirectSum( UnderlyingCategory( cat_1 ), List( objects_1, function ( x_2 )
                return Source( CoRelationMorphism( x_2 ) );
            end ), k_1 ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMorphism, UniversalMorphismFromDirectSum( UnderlyingCategory( cat_1 ), List( objects_1, function ( x_2 )
                return Source( CoRelationMorphism( x_2 ) );
            end ), Source( CoRelationMorphism( T_1 ) ), List( tau_1, UnderlyingMorphism ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, P_1, T_1, UnderlyingMorphism, UniversalMorphismFromZeroObject( UnderlyingCategory( cat_1 ), Source( CoRelationMorphism( T_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMorphism, UniversalMorphismIntoDirectSum( UnderlyingCategory( cat_1 ), List( objects_1, function ( x_2 )
                return Source( CoRelationMorphism( x_2 ) );
            end ), Source( CoRelationMorphism( T_1 ) ), List( tau_1, UnderlyingMorphism ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, T_1, P_1, UnderlyingMorphism, UniversalMorphismIntoZeroObject( UnderlyingCategory( cat_1 ), Source( CoRelationMorphism( T_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, b_1, UnderlyingMorphism, ZeroMorphism( UnderlyingCategory( cat_1 ), Source( CoRelationMorphism( a_1 ) ), Source( CoRelationMorphism( b_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, CoRelationMorphism, ZeroObjectFunctorial( UnderlyingCategory( cat_1 ) ) );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "CoFreydCategoryAsOppositeOfFreydCategoryOfOppositePrecompiled", function ( underlying_category )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( underlying_category )
    return CoFreydCategoryAsOppositeOfFreydCategoryOfOpposite( underlying_category );
end;
        
        
    
    cat := category_constructor( underlying_category : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CoFreydCategoryAsOppositeOfFreydCategoryOfOppositePrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
