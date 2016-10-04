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
