# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_LeftPresentationsAsFreydCategoryOfCategoryOfRowsOfFieldPrecompiled", function ( cat )
    
    ##
    AddInternalHomOnMorphismsWithGivenInternalHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := AsCategoryOfModulePresentations( ModelingCategory( cat_1 ) );
    deduped_3_1 := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( deduped_4_1, CreateCapCategoryObjectWithAttributes( deduped_4_1, UnderlyingMatrix, UnderlyingMatrix( Source( alpha_1 ) ) ), CreateCapCategoryObjectWithAttributes( deduped_4_1, UnderlyingMatrix, UnderlyingMatrix( Range( beta_1 ) ) ) );
    deduped_2_1 := UnderlyingMatrix( Range( deduped_3_1 ) );
    deduped_1_1 := NrRows( deduped_2_1 ) + 1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, UnderlyingMatrix, CertainColumns( SafeRightDivide( UnderlyingMatrix( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( deduped_4_1, CreateCapCategoryObjectWithAttributes( deduped_4_1, UnderlyingMatrix, UnderlyingMatrix( Range( alpha_1 ) ) ), CreateCapCategoryObjectWithAttributes( deduped_4_1, UnderlyingMatrix, UnderlyingMatrix( Source( beta_1 ) ) ) ) ) * KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) ), UnionOfRows( UnderlyingRing( cat_1 ), NrColumns( deduped_2_1 ), [ deduped_2_1, UnderlyingMatrix( deduped_3_1 ) ] ) ), [ deduped_1_1 .. deduped_1_1 - 1 + NrColumns( UnderlyingMatrix( Source( deduped_3_1 ) ) ) ] ) );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "LeftPresentationsAsFreydCategoryOfCategoryOfRowsOfFieldPrecompiled", function ( ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( ring )
    return LeftPresentationsAsFreydCategoryOfCategoryOfRows( ring );
end;
        
        
    
    cat := category_constructor( ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_LeftPresentationsAsFreydCategoryOfCategoryOfRowsOfFieldPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
