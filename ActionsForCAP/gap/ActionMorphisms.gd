# SPDX-License-Identifier: GPL-2.0-or-later
# ActionsForCAP: Actions and Coactions for CAP
#
# Declarations
#

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

DeclareOperation( "LeftActionMorphism",
                  [ IsLeftActionObject, IsCapCategoryMorphism, IsLeftActionObject ] );

DeclareOperation( "RightActionMorphism",
                  [ IsRightActionObject, IsCapCategoryMorphism, IsRightActionObject ] );

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
