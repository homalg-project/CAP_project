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
    
    return TensorProductOnMorphismsWithGivenTensorProducts( TensorProductOnObjects( Source( morphism_1 ), Source( morphism_2 ) ),
                                     morphism_1, morphism_2,
                                     TensorProductOnObjects( Range( morphism_1 ), Range( morphism_2 ) )
                                   );
    
end );

##
InstallMethod( AssociatorRightToLeft,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return AssociatorRightToLeftWithGivenTensorProducts( TensorProductOnObjects( object_1, TensorProductOnObjects( object_2, object_3 ) ),
                                  object_1, object_2, object_3,
                                  TensorProductOnObjects( TensorProductOnObjects( object_1, object_2 ), object_3 ) 
                                );
    
end );

##
InstallMethod( AssociatorLeftToRight,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return AssociatorLeftToRightWithGivenTensorProducts( TensorProductOnObjects( TensorProductOnObjects( object_1, object_2 ), object_3 ),
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
    
    return LeftUnitorWithGivenTensorProduct( object, TensorProductOnObjects( TensorUnit( category ), object ) );
    
end );

##
InstallMethod( LeftUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return LeftUnitorInverseWithGivenTensorProduct( object, TensorProductOnObjects( TensorUnit( category ), object ) );
    
end );

##
InstallMethod( RightUnitor,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return RightUnitorWithGivenTensorProduct( object, TensorProductOnObjects( object, TensorUnit( category ) ) );
    
end );

##
InstallMethod( RightUnitorInverse,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return RightUnitorInverseWithGivenTensorProduct( object, TensorProductOnObjects( object, TensorUnit( category ) ) );
    
end );

##
InstallMethod( Braiding,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return BraidingWithGivenTensorProducts( TensorProductOnObjects( object_1, object_2 ), object_1, object_2, TensorProductOnObjects( object_2, object_1 ) );
    
end );

##
InstallMethod( BraidingInverse,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return BraidingWithGivenTensorProducts( TensorProductOnObjects( object_2, object_1 ), object_1, object_2, TensorProductOnObjects( object_1, object_2 ) );
    
end );

##
InstallMethod( InternalHomOnMorphisms,
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
               
  function( morphism_1, morphism_2 )
    
    return InternalHomOnMorphismsWithGivenInternalHoms( InternalHomOnObjects( Range( morphism_1 ), Source( morphism_2 ) ),
                                   morphism_1, morphism_2,
                                   InternalHomOnObjects( Source( morphism_1 ), Range( morphism_2 ) )
                                 );
    
end );

##
InstallMethod( EvaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return EvaluationMorphismWithGivenSource( object_1, object_2,
                               TensorProductOnObjects( InternalHomOnObjects( object_1, object_2 ), object_1 )
                             );
    
end );

##
InstallMethod( CoevaluationMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CoevaluationMorphismWithGivenRange( object_1, object_2,
                                 InternalHomOnObjects( object_1, TensorProductOnObjects( object_2, object_1 ) )
                               );
    
end );

##
InstallMethod( MonoidalPreComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return MonoidalPreComposeMorphismWithGivenObjects( TensorProductOnObjects( InternalHomOnObjects( object_1, object_2 ), InternalHomOnObjects( object_2, object_3 ) ),
                                       object_1, object_2, object_3,
                                       InternalHomOnObjects( object_1, object_3 )
                                     );
    
end );

##
InstallMethod( MonoidalPostComposeMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2, object_3 )
    
    return MonoidalPostComposeMorphismWithGivenObjects( TensorProductOnObjects( InternalHomOnObjects( object_2, object_3 ), InternalHomOnObjects( object_1, object_2 ) ),
                                        object_1, object_2, object_3,
                                        InternalHomOnObjects( object_1, object_3 )
                                      );
    
end );

##
InstallMethod( DualOnMorphisms,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return DualOnMorphismsWithGivenDuals( DualOnObjects( Range( morphism ) ),
                            morphism,
                            DualOnObjects( Source( morphism ) )
                          );
    
end );

##
InstallMethod( EvaluationForDual,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return EvaluationForDual( TensorProductOnObjects( DualOnObjects( object ), object ), 
                              object,
                              TensorUnit( category ) 
                            );
    
end );

##
InstallMethod( CoevaluationForDual,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return CoevaluationForDual( TensorUnit( category ),
                                object, 
                                TensorProductOnObjects( object, DualOnObjects( object ) ) 
                              );
    
end );

##
InstallMethod( MorphismToBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismToBidual( object, DualOnObjects( DualOnObjects( object ) ) );
    
end );

##
InstallMethod( MorphismFromBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismFromBidual( object, DualOnObjects( DualOnObjects( object ) ) );
    
end );

##
InstallMethod( TensorProductInternalHomCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1_1, object_1_2, object_2_1, object_2_2 )
    
    return TensorProductInternalHomCompatibilityMorphism(
             object_1_1, object_1_2, object_2_1, object_2_2,
             [ TensorProductOnObjects( InternalHomOnObjects( object_1_1, object_1_2 ), InternalHomOnObjects( object_2_1, object_2_2 ) ),
               InternalHomOnObjects( TensorProductOnObjects( object_1_1, object_2_1 ), TensorProductOnObjects( object_1_2, object_2_2 ) ) ]
           );
    
end );

##
InstallMethod( TensorProductInternalHomCompatibilityMorphismInverse,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1_1, object_1_2, object_2_1, object_2_2 )
    
    return TensorProductInternalHomCompatibilityMorphismInverse(
             object_1_1, object_1_2, object_2_1, object_2_2,
             [ TensorProductOnObjects( InternalHomOnObjects( object_1_1, object_1_2 ), InternalHomOnObjects( object_2_1, object_2_2 ) ),
               InternalHomOnObjects( TensorProductOnObjects( object_1_1, object_2_1 ), TensorProductOnObjects( object_1_2, object_2_2 ) ) ]
           );
    
end );

##
InstallMethod( TensorProductDualityCompatibilityMorphism,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return TensorProductDualityCompatibilityMorphism( DualOnObjects( TensorProductOnObjects( object_1, object_2 ) ),
                                                      object_1, object_2,
                                                      TensorProductOnObjects( DualOnObjects( object_1 ), DualOnObjects( object_2 ) )
                                                    );
    
end );

##
InstallMethod( MorphismFromTensorProductToInternalHom,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return MorphismFromTensorProductToInternalHom( TensorProductOnObjects( DualOnObjects( object_1 ), object_2 ),
                                                   object_1, object_2,
                                                   InternalHomOnObjects( object_1, object_2 )
                                                 );
    
end );

##
InstallMethod( MorphismFromInternalHomToTensorProduct,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return MorphismFromInternalHomToTensorProduct( InternalHomOnObjects( object_1, object_2 ),
                                                   object_1, object_2,
                                                   TensorProductOnObjects( DualOnObjects( object_1 ), object_2 )
                                                 );
    
end );

##
InstallMethod( IsomorphismFromInternalHomToObject,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IsomorphismFromInternalHomToObject( object, InternalHomOnObjects( TensorUnit( category ), object ) );
    
end );

##
InstallMethod( IsomorphismFromObjectToInternalHom,
               [ IsCapCategoryObject ],
               
  function( object )
    local category;
    
    category := CapCategory( object );
    
    return IsomorphismFromObjectToInternalHom( object, InternalHomOnObjects( TensorUnit( category ), object ) );
    
end );

