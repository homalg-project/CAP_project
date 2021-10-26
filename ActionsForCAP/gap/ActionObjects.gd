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

DeclareCategory( "IsLeftOrRightActionObject",
                 IsCategoryWithAttributesObject );

DeclareCategory( "IsLeftActionObject",
                 IsLeftOrRightActionObject );

DeclareCategory( "IsRightActionObject",
                 IsLeftOrRightActionObject );

#############################
##
## Constructors
##
#############################

DeclareGlobalFunction( "LeftOrRightActionObject" );

DeclareOperation( "LeftActionObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );

DeclareOperation( "LeftActionObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "RightActionObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );

DeclareOperation( "RightActionObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "StructureMorphism",
                  IsLeftOrRightActionObject );

DeclareAttribute( "UnderlyingActingObject",
                  IsLeftOrRightActionObject );

DeclareAttribute( "ActionDomain",
                  IsLeftOrRightActionObject );

DeclareAttribute( "UnderlyingCategory",
                  IsLeftOrRightActionObject );
