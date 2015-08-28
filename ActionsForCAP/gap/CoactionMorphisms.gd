#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareCategory( "IsLeftOrRightCoactionMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsLeftCoactionMorphism",
                 IsLeftOrRightCoactionMorphism );

DeclareCategory( "IsRightCoactionMorphism",
                 IsLeftOrRightCoactionMorphism );

#############################
##
## Constructors
##
#############################

DeclareOperation( "CoactionMorphism",
                  [ IsLeftOrRightCoactionObject, IsCapCategoryMorphism, IsLeftOrRightCoactionObject ] );

#############################
##
## Attributes
##
#############################


DeclareAttribute( "UnderlyingCoactingObject",
                  IsLeftOrRightCoactionMorphism );

DeclareAttribute( "UnderlyingMorphism",
                  IsLeftOrRightCoactionMorphism );