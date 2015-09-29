#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## @Chapter Module Presentations
##
#############################################################################

DeclareCategory( "IsLeftOrRightPresentationMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsLeftPresentationMorphism",
                 IsLeftOrRightPresentationMorphism );

DeclareCategory( "IsRightPresentationMorphism",
                 IsLeftOrRightPresentationMorphism );

#############################
##
## Constructors
##
#############################

DeclareOperation( "PresentationMorphism",
                  [ IsLeftOrRightPresentation, IsHomalgMatrix, IsLeftOrRightPresentation ] );

#############################
##
## Matrix
##
#############################

DeclareAttribute( "UnderlyingHomalgRing",
                  IsLeftOrRightPresentationMorphism );

DeclareAttribute( "UnderlyingMatrix",
                  IsLeftOrRightPresentationMorphism );

#############################
##
## Arithmetics
##
#############################

##
DeclareOperation( "\*",
                  [ IsRingElement, IsLeftPresentationMorphism ] );

##
DeclareOperation( "\*",
                  [ IsRightPresentationMorphism, IsRingElement ] );


##############################################
##
## Non-categorical methods
##
##############################################

DeclareOperation( "StandardGeneratorMorphism",
                  [ IsLeftOrRightPresentation, IsInt ] );