#############################################################################
##
##                                               ToricSheaves package
##
##  Copyright 2016, Sebastian Gutsche, Universität Siegen
##                  Sebastian Posur,   Universität Siegen
##
#############################################################################

InstallMethod( CoverByLocallyFreeObject,
               [ IsSerreQuotientCategoryObject ],
                  
  function( object )
    local underlying_module;
    
    underlying_module := UnderlyingHonestObject( object );
    
    underlying_cover := CoverByFreeModule( underlying_module );
    
    return AsSerreQuotientCategoryMorphism( CapCategory( object ), underlying_cover );
    
end );
