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

DeclareCategory( "IsLeftOrRightActionMorphism",
                 IsCategoryWithAttributesMorphism );

DeclareCategory( "IsLeftActionMorphism",
                 IsLeftOrRightActionMorphism );

DeclareCategory( "IsRightActionMorphism",
                 IsLeftOrRightActionMorphism );

#############################
##
## Constructors
##
#############################

DeclareOperation( "ActionMorphism",
                  [ IsLeftOrRightActionObject, IsCapCategoryMorphism, IsLeftOrRightActionObject ] );

#############################
##
## Attributes
##
#############################


DeclareAttribute( "UnderlyingActingObject",
                  IsLeftOrRightActionMorphism );

DeclareAttribute( "UnderlyingMorphism",
                  IsLeftOrRightActionMorphism );