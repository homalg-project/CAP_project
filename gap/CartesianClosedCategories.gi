InstallValue( CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.ExponentialOnMorphisms := 
  [ [ "ExponentialOnMorphismsWithGivenExponentials", 1 ],
    [ "ExponentialOnObjects", 2 ] ];
##
InstallMethod( ExponentialOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    return ExponentialOnMorphismsWithGivenExponentials( 
             ExponentialOnObjects( Range( morphism_1 ), Source( morphism_2 ) ),
             morphism_1, morphism_2,
             ExponentialOnObjects( Source( morphism_1 ), Range( morphism_2 ) )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.CartesianEvaluationMorphism := 
  [ [ "CartesianEvaluationMorphismWithGivenSource", 1 ],
    [ "DirectProduct", 1 ],
    [ "ExponentialOnObjects", 1 ] ];
##
InstallMethod( CartesianEvaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CartesianEvaluationMorphismWithGivenSource( 
             object_1, object_2,
             DirectProduct( ExponentialOnObjects( object_1, object_2 ), object_1 )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.CartesianCoevaluationMorphism := 
  [ [ "CartesianCoevaluationMorphismWithGivenRange", 1 ],
    [ "DirectProduct", 1 ],
    [ "ExponentialOnObjects", 1 ] ];
##
InstallMethod( CartesianCoevaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CartesianCoevaluationMorphismWithGivenRange( 
             object_1, object_2,
             ExponentialOnObjects( object_2, DirectProduct( object_1, object_2 ) )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.CartesianPreComposeMorphism := 
  [ [ "CartesianPreComposeMorphismWithGivenObjects", 1 ],
    [ "DirectProduct", 1 ],
    [ "ExponentialOnObjects", 3 ] ];
##
InstallMethod( CartesianPreComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return CartesianPreComposeMorphismWithGivenObjects( 
             DirectProduct( ExponentialOnObjects( object_1, object_2 ), ExponentialOnObjects( object_2, object_3 ) ),
             object_1, object_2, object_3,
             ExponentialOnObjects( object_1, object_3 )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.CartesianPostComposeMorphism := 
  [ [ "CartesianPostComposeMorphismWithGivenObjects", 1 ],
    [ "DirectProduct", 1 ],
    [ "ExponentialOnObjects", 3 ] ];
##
InstallMethod( CartesianPostComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return CartesianPostComposeMorphismWithGivenObjects( 
             DirectProduct( ExponentialOnObjects( object_2, object_3 ), ExponentialOnObjects( object_1, object_2 ) ),
             object_1, object_2, object_3,
             ExponentialOnObjects( object_1, object_3 )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.CartesianDualOnMorphisms := 
  [ [ "CartesianDualOnMorphismsWithGivenCartesianDuals", 1 ],
    [ "CartesianDualOnObjects", 2 ] ];
##
InstallMethod( CartesianDualOnMorphisms,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return CartesianDualOnMorphismsWithGivenCartesianDuals(
             CartesianDualOnObjects( Range( morphism ) ),
             morphism,
             CartesianDualOnObjects( Source( morphism ) )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.CartesianEvaluationForCartesianDual := 
  [ [ "CartesianEvaluationForCartesianDualWithGivenDirectProduct", 1 ],
    [ "DirectProduct", 1 ],
    [ "CartesianDualOnObjects", 1 ],
    [ "TerminalObject", 1 ] ];
##
InstallMethod( CartesianEvaluationForCartesianDual,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CartesianEvaluationForCartesianDualWithGivenDirectProduct( 
             DirectProduct( CartesianDualOnObjects( object ), object ),
             object,
             TerminalObject( category )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.MorphismToCartesianBidual := 
  [ [ "MorphismToCartesianBidualWithGivenCartesianBidual", 1 ],
    [ "CartesianDualOnObjects", 2 ] ];
##
InstallMethod( MorphismToCartesianBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismToCartesianBidualWithGivenCartesianBidual( object, CartesianDualOnObjects( CartesianDualOnObjects( object ) ) );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.DirectProductExponentialCompatibilityMorphism := 
  [ [ "DirectProductExponentialCompatibilityMorphismWithGivenObjects", 1 ],
    [ "DirectProduct", 3 ],
    [ "ExponentialOnObjects", 3 ] ];
##
InstallMethod( DirectProductExponentialCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1_1, object_1_2, object_2_1, object_2_2 )
    
    return DirectProductExponentialCompatibilityMorphismWithGivenObjects(
             object_1_1, object_1_2, object_2_1, object_2_2,
             [ DirectProduct( ExponentialOnObjects( object_1_1, object_1_2 ), ExponentialOnObjects( object_2_1, object_2_2 ) ),
               ExponentialOnObjects( DirectProduct( object_1_1, object_2_1 ), DirectProduct( object_1_2, object_2_2 ) ) ]
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.DirectProductCartesianDualityCompatibilityMorphism := 
  [ [ "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects", 1 ],
    [ "CartesianDualOnObjects", 3 ],
    [ "DirectProduct", 2 ] ];
##
InstallMethod( DirectProductCartesianDualityCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects(
             CartesianDualOnObjects( DirectProduct( object_1, object_2 ) ),
             object_1, object_2,
             DirectProduct( CartesianDualOnObjects( object_1 ), CartesianDualOnObjects( object_2 ) )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.MorphismFromDirectProductToExponential := 
  [ [ "MorphismFromDirectProductToExponentialWithGivenObjects", 1 ],
    [ "CartesianDualOnObjects", 1 ],
    [ "DirectProduct", 1 ],
    [ "ExponentialOnObjects", 1 ] ];
##
InstallMethod( MorphismFromDirectProductToExponential,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return MorphismFromDirectProductToExponentialWithGivenObjects( 
             DirectProduct( CartesianDualOnObjects( object_1 ), object_2 ),
             object_1, object_2,
             ExponentialOnObjects( object_1, object_2 )
           );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromExponentialToObject := 
  [ [ "IsomorphismFromExponentialToObjectWithGivenExponential", 1 ],
    [ "TerminalObject", 1 ],
    [ "ExponentialOnObjects", 1 ] ];
##
InstallMethod( IsomorphismFromExponentialToObject,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IsomorphismFromExponentialToObjectWithGivenExponential( object, ExponentialOnObjects( TerminalObject( category ), object ) );
    
end );

##
InstallMethod( IsomorphismFromExponentialToObject,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return IsomorphismFromExponentialToObjectWithGivenExponential( object, object );
    
end );

##
CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromObjectToExponential := 
  [ [ "IsomorphismFromObjectToExponentialWithGivenExponential", 1 ],
    [ "TerminalObject", 1 ],
    [ "ExponentialOnObjects", 1 ] ];
##
InstallMethod( IsomorphismFromObjectToExponential,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IsomorphismFromObjectToExponentialWithGivenExponential( object, ExponentialOnObjects( TerminalObject( category ), object ) );
    
end );

##
InstallMethod( IsomorphismFromObjectToExponential,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return IsomorphismFromObjectToExponentialWithGivenExponential( object, object );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS );
