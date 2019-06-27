#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Graded Module Presentations
##
#############################################################################

#############################
##
#! @Section GAP Categories
##
#############################

#! @Description
#! The GAP category of objects in the category
#! of graded left presentations or graded right presentations.
#! @Arguments object
DeclareCategory( "IsGradedLeftOrRightPresentation",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of objects in the category
#! of graded left presentations.
#! @Arguments object
DeclareCategory( "IsGradedLeftPresentation",
                 IsGradedLeftOrRightPresentation );

#! @Description
#! The GAP category of objects in the category
#! of graded right presentations.
#! @Arguments object
DeclareCategory( "IsGradedRightPresentation",
                 IsGradedLeftOrRightPresentation );

#############################
##
#! @Section Constructors
##
#############################

#! @Description
#! The argument is a homalg matrix $M$ over a graded ring $R$.
#! The output is an object in the category of graded left presentations
#! over $R$. This object has $M$ as its underlying matrix.
#! @Returns an object
#! @Arguments M
DeclareAttribute( "AsGradedLeftPresentation",
                  IsHomalgMatrix );

DeclareOperation( "AsGradedLeftPresentation",
                  [ IsHomalgMatrix, IsList ] );

DeclareAttribute( "AsGradedLeftPresentation",
                  IsLeftPresentation );

DeclareOperation( "AsGradedLeftPresentation",
                  [ IsLeftPresentation, IsList ] );

#! @Description
#! The argument is a homalg matrix $M$ over a ring $R$.
#! The output is an object in the category of right presentations
#! over $R$. This object has $M$ as its underlying matrix.
#! @Returns an object
#! @Arguments M
DeclareAttribute( "AsGradedRightPresentation",
                  IsHomalgMatrix );

DeclareOperation( "AsGradedRightPresentation",
                  [ IsHomalgMatrix, IsList ] );

DeclareAttribute( "AsGradedRightPresentation",
                  IsRightPresentation );

DeclareOperation( "AsGradedRightPresentation",
                  [ IsRightPresentation, IsList ] );



#! @Description
#! The arguments are a homalg matrix $M$ and a boolean $l$.
#! If $l$ is <C>true</C>, the output is an object in the category
#! of left presentations.
#! If $l$ is <C>false</C>, the output is an object in the category
#! of right presentations.
#! In both cases, the underlying matrix of the result is $M$.
#! @Returns an object
#! @Arguments M, l
DeclareGlobalFunction( "AsGradedLeftOrRightPresentation" );

DeclareGlobalFunction( "AsGradedLeftOrRightPresentationWithDegrees" );

#! @Description
#! The arguments are a non-negative integer $r$
#! and a graded homalg ring $R$.
#! The output is an object in the category of graded left presentations
#! over $R$. It is represented by the $0 \times r$ matrix and
#! thus it is free of rank $r$.
#! @Returns an object
#! @Arguments r, R
DeclareOperation( "GradedFreeLeftPresentation",
                  [ IsInt, IsHomalgRing ] );

DeclareOperation( "GradedFreeLeftPresentation",
                  [ IsInt, IsHomalgRing, IsList ] );


#! @Description
#! The arguments are a non-negative integer $r$
#! and a graded homalg ring $R$.
#! The output is an object in the category of graded right presentations
#! over $R$. It is represented by the $r \times 0$ matrix and
#! thus it is free of rank $r$.
#! @Returns an object
#! @Arguments r, R
DeclareOperation( "GradedFreeRightPresentation",
                  [ IsInt, IsHomalgRing ] );

DeclareOperation( "GradedFreeRightPresentation",
                  [ IsInt, IsHomalgRing, IsList ] );


#############################
##
## Properties
##
#############################

## TODO
DeclareFamilyProperty( "IsFree",
                       IsCapCategoryMorphism,
                       "ModuleCategory",
                       "object" );

#############################
##
## Attributes
##
#############################

#! @Description
#! The argument is an object $A$ in the category of graded left or right presentations
#! over a homalg ring $R$.
#! The output is the corresponding object in the category of left or right presentations.
#! @Returns a left or right presentation
#! @Arguments A
DeclareAttribute( "UnderlyingPresentationObject",
                  IsGradedLeftOrRightPresentation );

#! @Description
#! The argument is an object $A$ in the category of graded left or right presentations
#! over a homalg ring $R$.
#! The output is $R$.
#! @Returns a homalg ring
#! @Arguments A
DeclareAttribute( "UnderlyingHomalgRing",
                  IsGradedLeftOrRightPresentation );

#! @Description
#!  The argument is an object $A$ in the category of graded left of right presentations
#!  over a ring $R$. The output is a list of elements of the degree group of $R$, the
#!  weights of the generators of $A$.
#! @Returns a list
#! @Arguments A
DeclareAttribute( "GeneratorDegrees",
                  IsGradedLeftOrRightPresentation );

DeclareAttribute( "UnderlyingMatrix",
                  IsGradedLeftOrRightPresentation );

#! @Description
#!  Returns the Krull dimension (of the annihilator ideal)
#!  of the underlying nongraded module <A>A</A>.
#!  The underlying ring must be commutative.
#! @Returns an integer
#! @Arguments A
DeclareAttribute( "AffineDimension",
                  IsGradedLeftOrRightPresentation );

##############################################
##
## Non-categorical methods
##
##############################################

DeclareOperationWithCache( "INTERNAL_GRADED_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT",
                           [ IsGradedLeftOrRightPresentation, IsGradedLeftOrRightPresentation ] );

DeclareOperationWithCache( "INTERNAL_GRADED_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT",
                           [ IsGradedLeftOrRightPresentation, IsGradedLeftOrRightPresentation ] );
