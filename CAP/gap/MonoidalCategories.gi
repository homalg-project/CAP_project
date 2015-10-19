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

InstallValue( CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS, rec( ) );

InstallValue( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Monoidal Categories

TensorProductOnObjects := rec(
  installation_name := "TensorProductOnObjects",
  filter_list := [ "object", "object" ],
  cache_name := "TensorProductOnObjects",
  return_type := "object" ),

TensorProductOnMorphismsWithGivenTensorProducts := rec(
  installation_name := "TensorProductOnMorphismsWithGivenTensorProducts",
  filter_list := [ "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "TensorProductOnMorphismsWithGivenTensorProducts",
  return_type := "morphism" ),

AssociatorRightToLeftWithGivenTensorProducts := rec(
  installation_name := "AssociatorRightToLeftWithGivenTensorProducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorRightToLeftWithGivenTensorProducts",
  return_type := "morphism" ),

AssociatorLeftToRightWithGivenTensorProducts := rec(
  installation_name := "AssociatorLeftToRightWithGivenTensorProducts",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "AssociatorLeftToRightWithGivenTensorProducts",
  return_type := "morphism" ),

TensorUnit := rec(
  installation_name := "TensorUnit",
  filter_list := [ "category" ],
  cache_name := "TensorUnit",
  return_type := "object" ),

LeftUnitorWithGivenTensorProduct := rec(
  installation_name := "LeftUnitorWithGivenTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "LeftUnitorWithGivenTensorProduct",
  return_type := "morphism" ),

LeftUnitorInverseWithGivenTensorProduct := rec(
  installation_name := "LeftUnitorInverseWithGivenTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "LeftUnitorInverseWithGivenTensorProduct",
  return_type := "morphism" ),

RightUnitorWithGivenTensorProduct := rec(
  installation_name := "RightUnitorWithGivenTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "RightUnitorWithGivenTensorProduct",
  return_type := "morphism" ),

RightUnitorInverseWithGivenTensorProduct := rec(
  installation_name := "RightUnitorInverseWithGivenTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "RightUnitorInverseWithGivenTensorProduct",
  return_type := "morphism" ),

BraidingWithGivenTensorProducts := rec(
  installation_name := "BraidingWithGivenTensorProducts",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "BraidingWithGivenTensorProducts",
  return_type := "morphism" ),

BraidingInverseWithGivenTensorProducts := rec(
  installation_name := "BraidingInverseWithGivenTensorProducts",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "BraidingInverseWithGivenTensorProducts",
  return_type := "morphism" ),

InternalHomOnObjects := rec(
  installation_name := "InternalHomOnObjects",
  filter_list := [ "object", "object" ],
  cache_name := "InternalHomOnObjects",
  return_type := "object" ),

InternalHomOnMorphismsWithGivenInternalHoms := rec(
  installation_name := "InternalHomOnMorphismsWithGivenInternalHoms",
  filter_list := [ "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  cache_name := "InternalHomOnMorphismsWithGivenInternalHoms",
  return_type := "morphism" ),

EvaluationMorphismWithGivenSource := rec(
  installation_name := "EvaluationMorphismWithGivenSource",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "a", "b", "s" ], [ "s", "b" ] ],
  cache_name := "EvaluationMorphismWithGivenSource",
  return_type := "morphism" ),

CoevaluationMorphismWithGivenRange := rec(
  installation_name := "CoevaluationMorphismWithGivenRange",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "a", "b", "r" ], [ "a", "r" ] ],
  cache_name := "CoevaluationMorphismWithGivenRange",
  return_type := "morphism" ),

TensorProductToInternalHomAdjunctionMap := rec(
  installation_name := "TensorProductToInternalHomAdjunctionMap",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "f" ], [ "a", "i" ] ],
  cache_name := "TensorProductToInternalHomAdjunctionMap",
  return_type := "morphism" ),

InternalHomToTensorProductAdjunctionMap := rec(
  installation_name := "InternalHomToTensorProductAdjunctionMap",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "b", "c", "g" ], [ "t", "c" ] ],
  cache_name := "InternalHomToTensorProductAdjunctionMap",
  return_type := "morphism" ),

MonoidalPreComposeMorphismWithGivenObjects := rec(
  installation_name := "MonoidalPreComposeMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "MonoidalPreComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

MonoidalPostComposeMorphismWithGivenObjects := rec(
  installation_name := "MonoidalPostComposeMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  cache_name := "MonoidalPostComposeMorphismWithGivenObjects",
  return_type := "morphism" ),

DualOnObjects := rec(
  installation_name := "DualOnObjects",
  filter_list := [ "object" ],
  cache_name := "DualOnObjects",
  return_type := "object" ),

DualOnMorphismsWithGivenDuals := rec(
  installation_name := "DualOnMorphismsWithGivenDuals",
  io_type := [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  filter_list := [ "object", "morphism", "object" ],
  cache_name := "DualOnMorphismsWithGivenDuals",
  return_type := "morphism" ),

EvaluationForDualWithGivenTensorProduct := rec(
  installation_name := "EvaluationForDualWithGivenTensorProduct",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  cache_name := "EvaluationForDualWithGivenTensorProduct",
  return_type := "morphism" ),

CoevaluationForDualWithGivenTensorProduct := rec(
  installation_name := "CoevaluationForDualWithGivenTensorProduct",
  filter_list := [ "object", "object", "object" ],
  io_type := [ [ "s", "a", "r" ], [ "s", "r" ] ],
  cache_name := "CoevaluationForDualWithGivenTensorProduct",
  return_type := "morphism" ),

MorphismToBidualWithGivenBidual := rec(
  installation_name := "MorphismToBidualWithGivenBidual",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "MorphismToBidualWithGivenBidual",
  return_type := "morphism" ),

MorphismFromBidualWithGivenBidual := rec(
  installation_name := "MorphismFromBidualWithGivenBidual",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "MorphismFromBidualWithGivenBidual",
  return_type := "morphism" ),

TensorProductInternalHomCompatibilityMorphismWithGivenObjects := rec(
  installation_name := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", IsList ],
  io_type := [ [ "a", "ap", "b", "bp", "L" ], [ "L_1", "L_2" ] ],
  cache_name := "TensorProductInternalHomCompatibilityMorphismWithGivenObjects",
  return_type := "morphism" ),

TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects := rec(
  installation_name := "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
  filter_list := [ "object", "object", "object", "object", IsList ],
  io_type := [ [ "a", "ap", "b", "bp", "L" ], [ "L_2", "L_1" ] ],
  cache_name := "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
  return_type := "morphism" ),

TensorProductDualityCompatibilityMorphismWithGivenObjects := rec(
  installation_name := "TensorProductDualityCompatibilityMorphismWithGivenObjects",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "TensorProductDualityCompatibilityMorphismWithGivenObjects",
  return_type := "morphism" ),

MorphismFromTensorProductToInternalHomWithGivenObjects := rec(
  installation_name := "MorphismFromTensorProductToInternalHomWithGivenObjects",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "MorphismFromTensorProductToInternalHomWithGivenObjects",
  return_type := "morphism" ),

MorphismFromInternalHomToTensorProductWithGivenObjects := rec(
  installation_name := "MorphismFromInternalHomToTensorProductWithGivenObjects",
  filter_list := [ "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  cache_name := "MorphismFromInternalHomToTensorProductWithGivenObjects",
  return_type := "morphism" ),

TraceMap := rec(
  installation_name := "TraceMap",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "u" ] ],
  cache_name := "TraceMap",
  return_type := "morphism" ),

RankMorphism := rec(
  installation_name := "RankMorphism",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "u", "u" ] ],
  cache_name := "RankMorphism",
  return_type := "morphism" ),

IsomorphismFromTensorProductToInternalHom := rec(
  installation_name := "IsomorphismFromTensorProductToInternalHom",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "b" ], [ "t", "i" ] ],
  cache_name := "IsomorphismFromTensorProductToInternalHom",
  return_type := "morphism" ),

IsomorphismFromInternalHomToTensorProduct := rec(
  installation_name := "IsomorphismFromInternalHomToTensorProduct",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "b" ], [ "i", "t" ] ],
  cache_name := "IsomorphismFromInternalHomToTensorProduct",
  return_type := "morphism" ),
  
IsomorphismFromInternalHomToDual := rec(
  installation_name := "IsomorphismFromInternalHomToDual",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "i", "d" ] ],
  cache_name := "IsomorphismFromInternalHomToDual",
  return_type := "morphism" ),

IsomorphismFromDualToInternalHom := rec(
  installation_name := "IsomorphismFromDualToInternalHom",
  filter_list := [ "object" ],
  io_type := [ [ "a" ], [ "d", "i" ] ],
  cache_name := "IsomorphismFromDualToInternalHom",
  return_type := "morphism" ),

UniversalPropertyOfDual := rec(
  installation_name := "UniversalPropertyOfDual",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "t", "a", "alpha" ], [ "t", "d" ] ],
  cache_name := "UniversalPropertyOfDual",
  return_type := "morphism" ),

LambdaIntroduction := rec(
  installation_name := "LambdaIntroduction",
  filter_list := [ "morphism" ],
  io_type := [ [ "alpha" ], [ "u", "i" ] ],
  cache_name := "LambdaIntroduction",
  return_type := "morphism" ),

LambdaElimination := rec(
  installation_name := "LambdaElimination",
  filter_list := [ "object", "object", "morphism" ],
  io_type := [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  cache_name := "LambdaElimination",
  return_type := "morphism" ),

IsomorphismFromObjectToInternalHomWithGivenInternalHom := rec(
  installation_name := "IsomorphismFromObjectToInternalHomWithGivenInternalHom",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  cache_name := "IsomorphismFromObjectToInternalHomWithGivenInternalHom",
  return_type := "morphism" ),

IsomorphismFromInternalHomToObjectWithGivenInternalHom := rec(
  installation_name := "IsomorphismFromInternalHomToObjectWithGivenInternalHom",
  filter_list := [ "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  cache_name := "IsomorphismFromInternalHomToObjectWithGivenInternalHom",
  return_type := "morphism" ),


LeftDistributivityExpandingWithGivenObjects := rec(
  installation_name := "LeftDistributivityExpandingWithGivenObjects",
  filter_list := [ "object", "object", IsList, "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  cache_name := "LeftDistributivityExpandingWithGivenObjects",
  return_type := "morphism" ),

LeftDistributivityFactoringWithGivenObjects := rec(
  installation_name := "LeftDistributivityFactoringWithGivenObjects",
  filter_list := [ "object", "object", IsList, "object" ],
  io_type := [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  cache_name := "LeftDistributivityFactoringWithGivenObjects",
  return_type := "morphism" ),

RightDistributivityExpandingWithGivenObjects := rec(
  installation_name := "RightDistributivityExpandingWithGivenObjects",
  filter_list := [ "object", IsList, "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  cache_name := "RightDistributivityExpandingWithGivenObjects",
  return_type := "morphism" ),

RightDistributivityFactoringWithGivenObjects := rec(
  installation_name := "RightDistributivityFactoringWithGivenObjects",
  filter_list := [ "object", IsList, "object", "object" ],
  io_type := [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  cache_name := "RightDistributivityFactoringWithGivenObjects",
  return_type := "morphism" ),
  ) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

##
InstallMethod( AddTensorUnit,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddTensorUnit( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.TensorProductOnMorphisms := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.AssociatorRightToLeft := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.AssociatorLeftToRight := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.LeftUnitor := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.LeftUnitorInverse := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.RightUnitor := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.RightUnitorInverse := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.Braiding := 
  [ [ BraidingWithGivenTensorProducts, 1 ],
    [ TensorProductOnObjects, 2 ] ];
##
InstallMethod( Braiding,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return BraidingWithGivenTensorProducts( TensorProductOnObjects( object_1, object_2 ), object_1, object_2, TensorProductOnObjects( object_2, object_1 ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.BraidingInverse := 
  [ [ BraidingInverseWithGivenTensorProducts, 1 ],
    [ TensorProductOnObjects, 2 ] ];
##
InstallMethod( BraidingInverse,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return BraidingInverseWithGivenTensorProducts( TensorProductOnObjects( object_2, object_1 ), object_1, object_2, TensorProductOnObjects( object_1, object_2 ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.InternalHomOnMorphisms := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.EvaluationMorphism := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.CoevaluationMorphism := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MonoidalPreComposeMorphism := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MonoidalPostComposeMorphism := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.DualOnMorphisms := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.EvaluationForDual := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.CoevaluationForDual := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismToBidual := 
  [ [ MorphismToBidualWithGivenBidual, 1 ],
    [ DualOnObjects, 2 ] ];
##
InstallMethod( MorphismToBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismToBidualWithGivenBidual( object, DualOnObjects( DualOnObjects( object ) ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismFromBidual := 
  [ [ MorphismFromBidualWithGivenBidual, 1 ],
    [ DualOnObjects, 2 ] ];
##
InstallMethod( MorphismFromBidual,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return MorphismFromBidualWithGivenBidual( object, DualOnObjects( DualOnObjects( object ) ) );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.TensorProductInternalHomCompatibilityMorphism := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.TensorProductInternalHomCompatibilityMorphismInverse := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.TensorProductDualityCompatibilityMorphism := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismFromTensorProductToInternalHom := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.MorphismFromInternalHomToTensorProduct := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromInternalHomToObject := 
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
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.IsomorphismFromObjectToInternalHom := 
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

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.LeftDistributivityExpanding := 
  [ [ TensorProductOnObjects, 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ DirectSum, 2 ] ];
##
InstallMethod( LeftDistributivityExpanding,
               [ IsCapCategoryObject, IsList ],
               
  function( object, summands_list )
    
    return LeftDistributivityExpandingWithGivenObjects(
             TensorProductOnObjects( object, DirectSum( summands_list ) ),
             object, summands_list,
             DirectSum( List( summands_list, summand -> TensorProductOnObjects( object, summand ) ) )
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.LeftDistributivityFactoring := 
  [ [ TensorProductOnObjects, 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ DirectSum, 2 ] ];
##
InstallMethod( LeftDistributivityFactoring,
               [ IsCapCategoryObject, IsList ],
               
  function( object, summands_list )
    
    return LeftDistributivityFactoringWithGivenObjects(
             DirectSum( List( summands_list, summand -> TensorProductOnObjects( object, summand ) ) ),
             object, summands_list,
             TensorProductOnObjects( object, DirectSum( summands_list ) )
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.RightDistributivityExpanding := 
  [ [ TensorProductOnObjects, 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ DirectSum, 2 ] ];
##
InstallMethod( RightDistributivityExpanding,
               [ IsList, IsCapCategoryObject ],
               
  function( summands_list, object )
    
    return RightDistributivityExpandingWithGivenObjects(
             TensorProductOnObjects( DirectSum( summands_list ), object ),
             summands_list, object,
             DirectSum( List( summands_list, summand -> TensorProductOnObjects( summand, object ) ) )
           );
    
end );

##
CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.RightDistributivityFactoring := 
  [ [ TensorProductOnObjects, 1 + 2 ], ## 1 + Size( summands_list ) would be the correct number
    [ DirectSum, 2 ] ];
##
InstallMethod( RightDistributivityFactoring,
               [ IsList, IsCapCategoryObject ],
               
  function( summands_list, object )
    
    return RightDistributivityFactoringWithGivenObjects(
             DirectSum( List( summands_list, summand -> TensorProductOnObjects( summand, object ) ) ),
             summands_list, object,
             TensorProductOnObjects( DirectSum( summands_list ), object )
           );
    
end );

InstallGlobalFunction( CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION_FOR_MONOIDAL_CATEGORIES,
  
  function( func, loop_multiplier )
    local monoidal_symbols, symbol, list, added_symbol, added_symbols;
    
    monoidal_symbols := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( func, RecNames( CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS ), loop_multiplier );
    
    list := [ ];
    
    for symbol in monoidal_symbols do
        
        added_symbols := CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.( symbol[ 1 ] );
        
        for added_symbol in added_symbols do
            
            Add( list, [ added_symbol[ 1 ], added_symbol[ 2 ] * symbol[ 2 ] ] );
            
        od;
        
    od;
    
    return list;
    
end );
