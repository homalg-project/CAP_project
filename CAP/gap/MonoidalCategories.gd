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

####################################
##
#! @Section Basic Operations for Monoidal Categories
##
####################################

## TensorProductOnObjects
DeclareOperationWithCache( "TensorProductOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsList ] );

## TensorProductOnMorphisms
DeclareOperation( "TensorProductOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "TensorProductOnMorphisms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddTensorProductOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductOnMorphisms",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "AssociatorRightToLeft",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AssociatorRightToLeft",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddAssociatorRightToLeft",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorRightToLeft",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeft",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeft",
                  [ IsCapCategory, IsList ] );



##
DeclareOperation( "AssociatorLeftToRight",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AssociatorLeftToRight",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddAssociatorLeftToRight",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorLeftToRight",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRight",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRight",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "TensorUnit",
                  IsCapCategory );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "LeftUnitor",
                  IsCapCategoryObject );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsList ] );


# the second argument is the given tensor product
DeclareOperation( "LeftUnitorWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddLeftUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "LeftUnitorInverse",
                  IsCapCategoryObject );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsList ] );


# the second argument is the given tensor product
DeclareOperation( "LeftUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddLeftUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "RightUnitor",
                  IsCapCategoryObject );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsList ] );


# the second argument is the given tensor product
DeclareOperation( "RightUnitorWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddRightUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "RightUnitorInverse",
                  IsCapCategoryObject );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsList ] );


# # the second argument is the given tensor product
DeclareOperation( "RightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddRightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "Braiding",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "BraidingWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "BraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "BraidingInverseWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "InternalHomOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddInternalHomOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomOnObjects",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "InternalHomOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "InternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddInternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "EvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsList ] );


# ## the last argument is the source
# DeclareOperation( "EvaluationMorphismWithGivenSource",
#                   [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );
# 
# DeclareOperation( "AddEvaluationMorphismWithGivenSource",
#                   [ IsCapCategory, IsFunction ] );
# 
# DeclareOperation( "AddEvaluationMorphismWithGivenSource",
#                   [ IsCapCategory, IsFunction, IsInt ] );
# 
# DeclareOperation( "AddEvaluationMorphismWithGivenSource",
#                   [ IsCapCategory, IsList, IsInt ] );
# 
# DeclareOperation( "AddEvaluationMorphismWithGivenSource",
#                   [ IsCapCategory, IsList ] );


##
DeclareOperation( "CoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsList ] );


# ## the last argument is the range
# DeclareOperation( "CoevaluationMorphismWithGivenRange",
#                   [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );
# 
# DeclareOperation( "AddCoevaluationMorphismWithGivenRange",
#                   [ IsCapCategory, IsFunction ] );
# 
# DeclareOperation( "AddCoevaluationMorphismWithGivenRange",
#                   [ IsCapCategory, IsFunction, IsInt ] );
# 
# DeclareOperation( "AddCoevaluationMorphismWithGivenRange",
#                   [ IsCapCategory, IsList, IsInt ] );
# 
# DeclareOperation( "AddCoevaluationMorphismWithGivenRange",
#                   [ IsCapCategory, IsList ] );


##
DeclareOperation( "TensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "InternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "MonoidalPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "MonoidalPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "DualOnObjects",
                  IsCapCategoryObject );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsList ] );


DeclareAttribute( "DualOnMorphisms",
                  IsCapCategoryMorphism );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "DualOnMorphismsWithGivenDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddDualOnMorphismsWithGivenDuals",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualOnMorphismsWithGivenDuals",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualOnMorphismsWithGivenDuals",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualOnMorphismsWithGivenDuals",
                  [ IsCapCategory, IsList ] );


DeclareAttribute( "EvaluationForDual",
                  IsCapCategoryObject );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsList ] );


# ## the second argument is the tensor product
# DeclareOperation( "EvaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategoryObject, IsCapCategoryObject ] );
# 
# DeclareOperation( "AddEvaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategory, IsFunction ] );
# 
# DeclareOperation( "AddEvaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategory, IsFunction, IsInt ] );
# 
# DeclareOperation( "AddEvaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategory, IsList, IsInt ] );
# 
# DeclareOperation( "AddEvaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategory, IsList ] );


DeclareAttribute( "CoevaluationForDual",
                  IsCapCategoryObject );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsList ] );


# DeclareOperation( "CoevaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategoryObject, IsCapCategoryObject ] );
# 
# DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategory, IsFunction ] );
# 
# DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategory, IsFunction, IsInt ] );
# 
# DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategory, IsList, IsInt ] );
# 
# DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
#                   [ IsCapCategory, IsList ] );


##
DeclareAttribute( "MorphismToBidual",
                  IsCapCategoryObject );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsList ] );


# DeclareOperation( "MorphismToBidualWithGivenBidual",
#                   [ IsCapCategoryObject, IsCapCategoryObject ] );
# 
# DeclareOperation( "AddMorphismToBidualWithGivenBidual",
#                   [ IsCapCategory, IsFunction ] );
# 
# DeclareOperation( "AddMorphismToBidualWithGivenBidual",
#                   [ IsCapCategory, IsFunction, IsInt ] );
# 
# DeclareOperation( "AddMorphismToBidualWithGivenBidual",
#                   [ IsCapCategory, IsList, IsInt ] );
# 
# DeclareOperation( "AddMorphismToBidualWithGivenBidual",
#                   [ IsCapCategory, IsList ] );


##
DeclareOperation( "TensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "TensorProductDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "MorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "MorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "TraceMap",
                  IsCapCategoryMorphism );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "RankMorphism",
                  IsCapCategoryMorphism );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList ] );


