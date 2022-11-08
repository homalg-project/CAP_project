# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfArbitraryRingPrecompiled", function ( cat )
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfArbitraryRingPrecompiled", function ( homalg_ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( homalg_ring )
    return CategoryOfRowsAsAdditiveClosureOfRingAsCategory( homalg_ring );
end;
        
        
    
    cat := category_constructor( homalg_ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfRowsAsAdditiveClosureOfRingAsCategoryOfArbitraryRingPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
