InstallValue( CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS.CoexponentialOnMorphisms := 
  [ [ "CoexponentialOnMorphismsWithGivenCoexponentials", 1 ],
    [ "CoexponentialOnObjects", 2 ] ];
##
InstallMethod( CoexponentialOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    return CoexponentialOnMorphismsWithGivenCoexponentials( 
             CoexponentialOnObjects( Source( morphism_1 ), Range( morphism_2 ) ),
             morphism_1, morphism_2,
             CoexponentialOnObjects( Range( morphism_1 ), Source( morphism_2 ) )
           );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS );
