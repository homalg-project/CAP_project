#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##  Monoidal Categories
##
##
#############################################################################

##
InstallValue( CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.TensorProductOnMorphisms := 
  [ [ "TensorProductOnMorphismsWithGivenTensorProducts", 1 ],
    [ "TensorProductOnObjects", 2 ] ];
##
InstallMethod( TensorProductOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    return TensorProductOnMorphismsWithGivenTensorProducts( 
             TensorProductOnObjects( Source( morphism_1 ), Source( morphism_2 ) ),
             morphism_1, morphism_2,
             TensorProductOnObjects( Range( morphism_1 ), Range( morphism_2 ) )
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.AssociatorRightToLeft := 
  [ [ "AssociatorRightToLeftWithGivenTensorProducts", 1 ],
    [ "TensorProductOnObjects", 4 ] ];
##
InstallMethod( AssociatorRightToLeft,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return AssociatorRightToLeftWithGivenTensorProducts( 
             TensorProductOnObjects( object_1, TensorProductOnObjects( object_2, object_3 ) ),
             object_1, object_2, object_3,
             TensorProductOnObjects( TensorProductOnObjects( object_1, object_2 ), object_3 ) 
           );
    
end );

##
InstallMethod( AssociatorRightToLeft,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( object_1, TensorProductOnObjects( object_2, object_3 ) );
    
    return AssociatorRightToLeftWithGivenTensorProducts( 
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.AssociatorLeftToRight := 
  [ [ "AssociatorLeftToRightWithGivenTensorProducts", 1 ],
    [ "TensorProductOnObjects", 4 ] ];
##
InstallMethod( AssociatorLeftToRight,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return AssociatorLeftToRightWithGivenTensorProducts( 
             TensorProductOnObjects( TensorProductOnObjects( object_1, object_2 ), object_3 ),
             object_1, object_2, object_3,
             TensorProductOnObjects( object_1, TensorProductOnObjects( object_2, object_3 ) ) 
           );
    
end );

##
InstallMethod( AssociatorLeftToRight,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( object_1, TensorProductOnObjects( object_2, object_3 ) );
    
    return AssociatorLeftToRightWithGivenTensorProducts( 
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.LeftUnitor := 
  [ [ "LeftUnitorWithGivenTensorProduct", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "TensorUnit", 1 ] ];
##
InstallMethod( LeftUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return LeftUnitorWithGivenTensorProduct( object, TensorProductOnObjects( TensorUnit( category ), object ) );
    
end );

##
InstallMethod( LeftUnitor,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return LeftUnitorWithGivenTensorProduct( object, object );
    
end );


##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.LeftUnitorInverse := 
  [ [ "LeftUnitorInverseWithGivenTensorProduct", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "TensorUnit", 1 ] ];
##
InstallMethod( LeftUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return LeftUnitorInverseWithGivenTensorProduct( object, TensorProductOnObjects( TensorUnit( category ), object ) );
    
end );

##
InstallMethod( LeftUnitorInverse,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return LeftUnitorInverseWithGivenTensorProduct( object, object );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.RightUnitor := 
  [ [ "RightUnitorWithGivenTensorProduct", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "TensorUnit", 1 ] ];
##
InstallMethod( RightUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return RightUnitorWithGivenTensorProduct( object, TensorProductOnObjects( object, TensorUnit( category ) ) );
    
end );

##
InstallMethod( RightUnitor,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return RightUnitorWithGivenTensorProduct( object, object );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.RightUnitorInverse := 
  [ [ "RightUnitorInverseWithGivenTensorProduct", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "TensorUnit", 1 ] ];
##
InstallMethod( RightUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return RightUnitorInverseWithGivenTensorProduct( object, TensorProductOnObjects( object, TensorUnit( category ) ) );
    
end );

##
InstallMethod( RightUnitorInverse,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return RightUnitorInverseWithGivenTensorProduct( object, object );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS );
