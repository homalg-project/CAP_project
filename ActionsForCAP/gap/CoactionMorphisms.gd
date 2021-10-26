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

DeclareOperation( "LeftCoactionMorphism",
                  [ IsLeftCoactionObject, IsCapCategoryMorphism, IsLeftCoactionObject ] );

DeclareOperation( "RightCoactionMorphism",
                  [ IsRightCoactionObject, IsCapCategoryMorphism, IsRightCoactionObject ] );

#############################
##
## Attributes
##
#############################


DeclareAttribute( "UnderlyingCoactingObject",
                  IsLeftOrRightCoactionMorphism );

DeclareAttribute( "UnderlyingMorphism",
                  IsLeftOrRightCoactionMorphism );
