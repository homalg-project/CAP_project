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

# the second argument is the given tensor product
DeclareOperation( "LeftUnitor",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsList ] );



##
DeclareAttribute( "LeftUnitorInverse",
                  IsCapCategoryObject );

# the second argument is the given tensor product
DeclareOperation( "LeftUnitorInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "RightUnitor",
                  IsCapCategoryObject );

# the second argument is the given tensor product
DeclareOperation( "RightUnitor",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "RightUnitorInverse",
                  IsCapCategoryObject );

# the second argument is the given tensor product
DeclareOperation( "RightUnitorInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "Braiding",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "Braiding",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "BraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "BraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingInverse",
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

DeclareOperation( "InternalHomOnMorphisms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a, b$.
#! The output is the evaluation morphism $\mathrm{\underline{Hom}}(a,b) \otimes a \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b) \otimes a, b )$.
#! @Arguments a,b
DeclareOperation( "EvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## 3rd argument is $\mathrm{\underline{Hom}}(a,b) \otimes a$
DeclareOperation( "EvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coevaluation morphism $a \rightarrow \mathrm{\underline{Hom}(b, a \otimes b)}$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}}(b, a \otimes b) )$.
#! @Arguments a,b
DeclareOperation( "CoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## the last argument is $\mathrm{\underline{Hom}}(b, a \otimes b)$
DeclareOperation( "CoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are objects $a,b$ and a morphism $f: a \otimes b \rightarrow c$.
#! The output is a morphism $g: a \rightarrow \mathrm{\underline{Hom}}(b,c)$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}}(b,c) )$.
#! @Arguments a, b, f
DeclareOperation( "TensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are objects $b,c$ and a morphism $g: a \rightarrow \mathrm{\underline{Hom}}(b,c)$.
#! The output is a morphism $f: a \otimes b \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes b, c)$.
#! @Arguments b, c, g
DeclareOperation( "InternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

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

DeclareOperation( "MonoidalPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

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

DeclareOperation( "MonoidalPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

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

##
DeclareAttribute( "DualOnMorphisms",
                  IsCapCategoryMorphism );

DeclareOperation( "DualOnMorphisms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "EvaluationForDual",
                  IsCapCategoryObject );

## [ Dual( a ) tensored a, a, TensorUnit ]
DeclareOperation( "EvaluationForDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "CoevaluationForDual",
                  IsCapCategoryObject );

## [ 1, a, a tensored Dual( a ) ]
DeclareOperation( "CoevaluationForDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "MorphismToBidual",
                  IsCapCategoryObject );

## the second argument is the bidual
DeclareOperation( "MorphismToBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "MorphismFromBidual",
                  IsCapCategoryObject );

## the second argument is the bidual
DeclareOperation( "MorphismFromBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "TensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

##
## The new_source and new_range arguments are the first and second element of the list.
## This construction is due to the fact that the maximal number of arguments for an operation is 6,
## but a basic operation with 6 arguments would install a setter having 7 arguments.
DeclareOperation( "TensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

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

DeclareOperation( "TensorProductDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

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

DeclareOperation( "MorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "IsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "MorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "MorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "IsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
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
                  IsCapCategoryObject );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "IsomorphismFromDualToInternalHom",
                  IsCapCategoryObject );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "IsomorphismFromInternalHomToDual",
                  IsCapCategoryObject );

DeclareOperation( "AddIsomorphismFromInternalHomToDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalHomToDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToDual",
                  [ IsCapCategory, IsList ] );


## input: (t, a, mu: t tensor a -> 1)
##
DeclareOperation( "UniversalPropertyOfDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "LambdaIntroduction",
                  IsCapCategoryMorphism );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "LambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsList ] );

