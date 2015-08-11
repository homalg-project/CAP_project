#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Monoidal Categories
#!
##
#############################################################################

##
InstallMethod( TensorProductOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    return TensorProductOnMorphisms( TensorProductOnObjects( Source( morphism_1 ), Source( morphism_2 ) ),
                                     morphism_1, morphism_2,
                                     TensorProductOnObjects( Range( morphism_1 ), Range( morphism_2 ) )
                                   );
    
end );

##
InstallMethod( AssociatorRightToLeft,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return AssociatorRightToLeft( TensorProductOnObjects( object_1, TensorProductOnObjects( object_2, object_3 ) ),
                                  object_1, object_2, object_3,
                                  TensorProductOnObjects( TensorProductOnObjects( object_1, object_2 ), object_3 ) 
                                );
    
end );

##
InstallMethod( AssociatorLeftToRight,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return AssociatorLeftToRight( TensorProductOnObjects( TensorProductOnObjects( object_1, object_2 ), object_3 ),
                                  object_1, object_2, object_3,
                                  TensorProductOnObjects( object_1, TensorProductOnObjects( object_2, object_3 ) ) 
                                );
    
end );

##
InstallMethod( LeftUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return LeftUnitor( object, TensorProductOnObjects( TensorUnit( category ), object ) );
    
end );

##
InstallMethod( LeftUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return LeftUnitorInverse( object, TensorProductOnObjects( TensorUnit( category ), object ) );
    
end );

##
InstallMethod( RightUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return RightUnitor( object, TensorProductOnObjects( object, TensorUnit( category ) ) );
    
end );

##
InstallMethod( RightUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return RightUnitorInverse( object, TensorProductOnObjects( object, TensorUnit( category ) ) );
    
end );

##
InstallMethod( Braiding,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return Braiding( TensorProductOnObjects( object_1, object_2 ), object_1, object_2, TensorProductOnObjects( object_2, object_1 ) );
    
end );

##
InstallMethod( BraidingInverse,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return Braiding( TensorProductOnObjects( object_2, object_1 ), object_1, object_2, TensorProductOnObjects( object_1, object_2 ) );
    
end );

