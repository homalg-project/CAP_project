InstallValue( CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.InternalHomOnMorphisms := 
  [ [ "InternalHomOnMorphismsWithGivenInternalHoms", 1 ],
    [ "InternalHomOnObjects", 2 ] ];
##
InstallMethod( InternalHomOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    return InternalHomOnMorphismsWithGivenInternalHoms( 
             InternalHomOnObjects( Range( morphism_1 ), Source( morphism_2 ) ),
             morphism_1, morphism_2,
             InternalHomOnObjects( Source( morphism_1 ), Range( morphism_2 ) )
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.EvaluationMorphism := 
  [ [ "EvaluationMorphismWithGivenSource", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalHomOnObjects", 1 ] ];
##
InstallMethod( EvaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return EvaluationMorphismWithGivenSource( 
             object_1, object_2,
             TensorProductOnObjects( InternalHomOnObjects( object_1, object_2 ), object_1 )
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.CoevaluationMorphism := 
  [ [ "CoevaluationMorphismWithGivenRange", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalHomOnObjects", 1 ] ];
##
InstallMethod( CoevaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CoevaluationMorphismWithGivenRange( 
             object_1, object_2,
             InternalHomOnObjects( object_2, TensorProductOnObjects( object_1, object_2 ) )
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MonoidalPreComposeMorphism := 
  [ [ "MonoidalPreComposeMorphismWithGivenObjects", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalHomOnObjects", 3 ] ];
##
InstallMethod( MonoidalPreComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return MonoidalPreComposeMorphismWithGivenObjects( 
             TensorProductOnObjects( InternalHomOnObjects( object_1, object_2 ), InternalHomOnObjects( object_2, object_3 ) ),
             object_1, object_2, object_3,
             InternalHomOnObjects( object_1, object_3 )
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MonoidalPostComposeMorphism := 
  [ [ "MonoidalPostComposeMorphismWithGivenObjects", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalHomOnObjects", 3 ] ];
##
InstallMethod( MonoidalPostComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return MonoidalPostComposeMorphismWithGivenObjects( 
             TensorProductOnObjects( InternalHomOnObjects( object_2, object_3 ), InternalHomOnObjects( object_1, object_2 ) ),
             object_1, object_2, object_3,
             InternalHomOnObjects( object_1, object_3 )
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.DualOnMorphisms := 
  [ [ "DualOnMorphismsWithGivenDuals", 1 ],
    [ "DualOnObjects", 2 ] ];
##
InstallMethod( DualOnMorphisms,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return DualOnMorphismsWithGivenDuals(
             DualOnObjects( Range( morphism ) ),
             morphism,
             DualOnObjects( Source( morphism ) )
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.EvaluationForDual := 
  [ [ "EvaluationForDualWithGivenTensorProduct", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "DualOnObjects", 1 ],
    [ "TensorUnit", 1 ] ];
##
InstallMethod( EvaluationForDual,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return EvaluationForDualWithGivenTensorProduct( 
             TensorProductOnObjects( DualOnObjects( object ), object ),
             object,
             TensorUnit( category )
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismToBidual := 
  [ [ "MorphismToBidualWithGivenBidual", 1 ],
    [ "DualOnObjects", 2 ] ];
##
InstallMethod( MorphismToBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismToBidualWithGivenBidual( object, DualOnObjects( DualOnObjects( object ) ) );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.TensorProductInternalHomCompatibilityMorphism := 
  [ [ "TensorProductInternalHomCompatibilityMorphismWithGivenObjects", 1 ],
    [ "TensorProductOnObjects", 3 ],
    [ "InternalHomOnObjects", 3 ] ];
##
InstallMethod( TensorProductInternalHomCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1_1, object_1_2, object_2_1, object_2_2 )
    
    return TensorProductInternalHomCompatibilityMorphismWithGivenObjects(
             object_1_1, object_1_2, object_2_1, object_2_2,
             [ TensorProductOnObjects( InternalHomOnObjects( object_1_1, object_1_2 ), InternalHomOnObjects( object_2_1, object_2_2 ) ),
               InternalHomOnObjects( TensorProductOnObjects( object_1_1, object_2_1 ), TensorProductOnObjects( object_1_2, object_2_2 ) ) ]
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.TensorProductDualityCompatibilityMorphism := 
  [ [ "TensorProductDualityCompatibilityMorphismWithGivenObjects", 1 ],
    [ "DualOnObjects", 3 ],
    [ "TensorProductOnObjects", 2 ] ];
##
InstallMethod( TensorProductDualityCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return TensorProductDualityCompatibilityMorphismWithGivenObjects(
             TensorProductOnObjects( DualOnObjects( object_1 ), DualOnObjects( object_2 ) ),
             object_1, object_2,
             DualOnObjects( TensorProductOnObjects( object_1, object_2 ) )
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismFromTensorProductToInternalHom := 
  [ [ "MorphismFromTensorProductToInternalHomWithGivenObjects", 1 ],
    [ "DualOnObjects", 1 ],
    [ "TensorProductOnObjects", 1 ],
    [ "InternalHomOnObjects", 1 ] ];
##
InstallMethod( MorphismFromTensorProductToInternalHom,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return MorphismFromTensorProductToInternalHomWithGivenObjects( 
             TensorProductOnObjects( DualOnObjects( object_1 ), object_2 ),
             object_1, object_2,
             InternalHomOnObjects( object_1, object_2 )
           );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromInternalHomToObject := 
  [ [ "IsomorphismFromInternalHomToObjectWithGivenInternalHom", 1 ],
    [ "TensorUnit", 1 ],
    [ "InternalHomOnObjects", 1 ] ];
##
InstallMethod( IsomorphismFromInternalHomToObject,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IsomorphismFromInternalHomToObjectWithGivenInternalHom( object, InternalHomOnObjects( TensorUnit( category ), object ) );
    
end );

##
InstallMethod( IsomorphismFromInternalHomToObject,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return IsomorphismFromInternalHomToObjectWithGivenInternalHom( object, object );
    
end );

##
CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromObjectToInternalHom := 
  [ [ "IsomorphismFromObjectToInternalHomWithGivenInternalHom", 1 ],
    [ "TensorUnit", 1 ],
    [ "InternalHomOnObjects", 1 ] ];
##
InstallMethod( IsomorphismFromObjectToInternalHom,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IsomorphismFromObjectToInternalHomWithGivenInternalHom( object, InternalHomOnObjects( TensorUnit( category ), object ) );
    
end );

##
InstallMethod( IsomorphismFromObjectToInternalHom,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory ],
               
  function( object )
    
    return IsomorphismFromObjectToInternalHomWithGivenInternalHom( object, object );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS );

####################################
# Convenience Methods
####################################

##
InstallMethod( InternalHom,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  InternalHomOnObjects );

##
InstallMethod( InternalHom,
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
        
  InternalHomOnMorphisms );

##
InstallMethod( InternalHom,
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( a, beta )
    
    return InternalHomOnMorphisms( IdentityMorphism( a ), beta );
    
end );

##
InstallMethod( InternalHom,
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( alpha, b )
    
    return InternalHomOnMorphisms( alpha, IdentityMorphism( b ) );
    
end );
