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

InstallValue( CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS, rec( ) );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.TensorProductOnMorphisms := 
  [ [ TensorProductOnMorphismsWithGivenTensorProducts, 1 ],
    [ TensorProductOnObjects, 2 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.AssociatorRightToLeft := 
  [ [ AssociatorRightToLeftWithGivenTensorProducts, 1 ],
    [ TensorProductOnObjects, 4 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.AssociatorLeftToRight := 
  [ [ AssociatorLeftToRightWithGivenTensorProducts, 1 ],
    [ TensorProductOnObjects, 4 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.LeftUnitor := 
  [ [ LeftUnitorWithGivenTensorProduct, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ TensorUnit, 1 ] ];
##
InstallMethod( LeftUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return LeftUnitorWithGivenTensorProduct( object, TensorProductOnObjects( TensorUnit( category ), object ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.LeftUnitorInverse := 
  [ [ LeftUnitorInverseWithGivenTensorProduct, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ TensorUnit, 1 ] ];
##
InstallMethod( LeftUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return LeftUnitorInverseWithGivenTensorProduct( object, TensorProductOnObjects( TensorUnit( category ), object ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.RightUnitor := 
  [ [ RightUnitorWithGivenTensorProduct, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ TensorUnit, 1 ] ];
##
InstallMethod( RightUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return RightUnitorWithGivenTensorProduct( object, TensorProductOnObjects( object, TensorUnit( category ) ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.RightUnitorInverse := 
  [ [ RightUnitorInverseWithGivenTensorProduct, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ TensorUnit, 1 ] ];
##
InstallMethod( RightUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return RightUnitorInverseWithGivenTensorProduct( object, TensorProductOnObjects( object, TensorUnit( category ) ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.Braiding := 
  [ [ BraidingWithGivenTensorProducts, 1 ],
    [ TensorProductOnObjects, 2 ] ];
##
InstallMethod( Braiding,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return BraidingWithGivenTensorProducts( TensorProductOnObjects( object_1, object_2 ), object_1, object_2, TensorProductOnObjects( object_2, object_1 ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.BraidingInverse := 
  [ [ BraidingInverseWithGivenTensorProducts, 1 ],
    [ TensorProductOnObjects, 2 ] ];
##
InstallMethod( BraidingInverse,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return BraidingInverseWithGivenTensorProducts( TensorProductOnObjects( object_2, object_1 ), object_1, object_2, TensorProductOnObjects( object_1, object_2 ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.InternalHomOnMorphisms := 
  [ [ InternalHomOnMorphismsWithGivenInternalHoms, 1 ],
    [ InternalHomOnObjects, 2 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.EvaluationMorphism := 
  [ [ EvaluationMorphismWithGivenSource, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ InternalHomOnObjects, 1 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.CoevaluationMorphism := 
  [ [ CoevaluationMorphismWithGivenRange, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ InternalHomOnObjects, 1 ] ];
##
InstallMethod( CoevaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CoevaluationMorphismWithGivenRange( 
             object_1, object_2,
             InternalHomOnObjects( object_1, TensorProductOnObjects( object_2, object_1 ) )
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.MonoidalPreComposeMorphism := 
  [ [ MonoidalPreComposeMorphismWithGivenObjects, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ InternalHomOnObjects, 3 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.MonoidalPostComposeMorphism := 
  [ [ MonoidalPostComposeMorphismWithGivenObjects, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ InternalHomOnObjects, 3 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.DualOnMorphisms := 
  [ [ DualOnMorphismsWithGivenDuals, 1 ],
    [ DualOnObjects, 2 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.EvaluationForDual := 
  [ [ EvaluationForDualWithGivenTensorProduct, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ DualOnObjects, 1 ],
    [ TensorUnit, 1 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.CoevaluationForDual := 
  [ [ CoevaluationForDualWithGivenTensorProduct, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ DualOnObjects, 1 ],
    [ TensorUnit, 1 ] ];
##
InstallMethod( CoevaluationForDual,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CoevaluationForDualWithGivenTensorProduct( 
             TensorUnit( category ),
             object,
             TensorProductOnObjects( object, DualOnObjects( object ) )
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.MorphismToBidual := 
  [ [ MorphismToBidualWithGivenBidual, 1 ],
    [ DualOnObjects, 2 ] ];
##
InstallMethod( MorphismToBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismToBidualWithGivenBidual( object, DualOnObjects( DualOnObjects( object ) ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.MorphismFromBidual := 
  [ [ MorphismFromBidualWithGivenBidual, 1 ],
    [ DualOnObjects, 2 ] ];
##
InstallMethod( MorphismFromBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismFromBidualWithGivenBidual( object, DualOnObjects( DualOnObjects( object ) ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.TensorProductInternalHomCompatibilityMorphism := 
  [ [ TensorProductInternalHomCompatibilityMorphismWithGivenObjects, 1 ],
    [ TensorProductOnObjects, 3 ],
    [ InternalHomOnObjects, 3 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.TensorProductInternalHomCompatibilityMorphismInverse := 
  [ [ TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects, 1 ],
    [ TensorProductOnObjects, 3 ],
    [ InternalHomOnObjects, 3 ] ];
##
InstallMethod( TensorProductInternalHomCompatibilityMorphismInverse,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1_1, object_1_2, object_2_1, object_2_2 )
    
    return TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects(
             object_1_1, object_1_2, object_2_1, object_2_2,
             [ TensorProductOnObjects( InternalHomOnObjects( object_1_1, object_1_2 ), InternalHomOnObjects( object_2_1, object_2_2 ) ),
               InternalHomOnObjects( TensorProductOnObjects( object_1_1, object_2_1 ), TensorProductOnObjects( object_1_2, object_2_2 ) ) ]
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.TensorProductDualityCompatibilityMorphism := 
  [ [ TensorProductDualityCompatibilityMorphismWithGivenObjects, 1 ],
    [ DualOnObjects, 3 ],
    [ TensorProductOnObjects, 2 ] ];
##
InstallMethod( TensorProductDualityCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return TensorProductDualityCompatibilityMorphismWithGivenObjects(
             DualOnObjects( TensorProductOnObjects( object_1, object_2 ) ),
             object_1, object_2,
             TensorProductOnObjects( DualOnObjects( object_1 ), DualOnObjects( object_2 ) )
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.MorphismFromTensorProductToInternalHom := 
  [ [ MorphismFromTensorProductToInternalHomWithGivenObjects, 1 ],
    [ DualOnObjects, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ InternalHomOnObjects, 1 ] ];
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.MorphismFromInternalHomToTensorProduct := 
  [ [ MorphismFromInternalHomToTensorProductWithGivenObjects, 1 ],
    [ DualOnObjects, 1 ],
    [ TensorProductOnObjects, 1 ],
    [ InternalHomOnObjects, 1 ] ];
##
InstallMethod( MorphismFromInternalHomToTensorProduct,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return MorphismFromInternalHomToTensorProductWithGivenObjects(
             InternalHomOnObjects( object_1, object_2 ),
             object_1, object_2,
             TensorProductOnObjects( DualOnObjects( object_1 ), object_2 )
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.IsomorphismFromInternalHomToObject := 
  [ [ IsomorphismFromInternalHomToObjectWithGivenInternalHom, 1 ],
    [ TensorUnit, 1 ],
    [ InternalHomOnObjects, 1 ] ];
##
InstallMethod( IsomorphismFromInternalHomToObject,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IsomorphismFromInternalHomToObjectWithGivenInternalHom( object, InternalHomOnObjects( TensorUnit( category ), object ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIIONS.IsomorphismFromObjectToInternalHom := 
  [ [ IsomorphismFromObjectToInternalHomWithGivenInternalHom, 1 ],
    [ TensorUnit, 1 ],
    [ InternalHomOnObjects, 1 ] ];
##
InstallMethod( IsomorphismFromObjectToInternalHom,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IsomorphismFromObjectToInternalHomWithGivenInternalHom( object, InternalHomOnObjects( TensorUnit( category ), object ) );
    
end );

