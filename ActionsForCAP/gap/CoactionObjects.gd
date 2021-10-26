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

DeclareCategory( "IsLeftOrRightCoactionObject",
                 IsCapCategoryObject );

DeclareCategory( "IsLeftCoactionObject",
                 IsLeftOrRightCoactionObject );

DeclareCategory( "IsRightCoactionObject",
                 IsLeftOrRightCoactionObject );

#############################
##
## Constructors
##
#############################

DeclareGlobalFunction( "LeftOrRightCoactionObject" );

DeclareOperation( "LeftCoactionObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "LeftCoactionObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );

DeclareOperation( "RightCoactionObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "RightCoactionObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "StructureMorphism",
                  IsLeftOrRightCoactionObject );

DeclareAttribute( "UnderlyingCoactingObject",
                  IsLeftOrRightCoactionObject );

DeclareAttribute( "CoactionDomain",
                  IsLeftOrRightCoactionObject );

DeclareAttribute( "UnderlyingCategory",
                  IsLeftOrRightCoactionObject );
