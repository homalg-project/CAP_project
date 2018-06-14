#############################################################################
##
##                                               ToricSheaves package
##
##  Copyright 2016, Sebastian Gutsche, Universität Siegen
##                  Sebastian Posur,   Universität Siegen
##
#############################################################################

InstallMethod( CoverByProjective,
               [ IsSerreQuotientCategoryObject ],
                  
  function( object )
    local underlying_module, underlying_cover;
    
    underlying_module := UnderlyingHonestObject( object );
    
    underlying_cover := CoverByProjective( underlying_module );
    
    return AsSerreQuotientCategoryMorphism( CapCategory( object ), underlying_cover );
    
end );

InstallMethod( CoverByProjectiveWithLift,
               [ IsSerreQuotientCategoryMorphism ],
               
  function( morphism )
    local cimage_embedding, cimage_embedding_inverse, cover_of_source, cover, restricted_morphism, lift;
    
    cimage_embedding := GeneralizedImageEmbedding( UnderlyingGeneralizedMorphism( morphism ) );
    
    cimage_embedding := AsSerreQuotientCategoryMorphism( CapCategory( morphism ), cimage_embedding );
    
    cimage_embedding_inverse := Inverse( cimage_embedding );
    
    cover := CoverByProjective( Source( cimage_embedding ) );
    
    restricted_morphism := PreCompose( morphism, cimage_embedding_inverse );
    
    lift := Lift( cover, restricted_morphism );
    
    return [ PreCompose( cover, cimage_embedding ), lift ];
    
end );

InstallMethod( FreeResolutionComplexOfSheaf,
               [ IsSerreQuotientCategoryObject ],
               
  function( module )
    return ResolutionTo( module, CoverByProjective, true );
end );

InstallMethod( FreeResolutionCocomplexOfSheaf,
               [ IsSerreQuotientCategoryObject ],
               
  function( module )
    return ResolutionTo( module, CoverByProjective, false );
end );
