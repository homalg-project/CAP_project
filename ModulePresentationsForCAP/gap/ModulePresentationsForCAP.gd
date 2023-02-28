# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Declarations
#
#! @Chapter Module Presentations

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsCategoryOfLeftOrRightPresentations",
                 IsCapCategory );

DeclareCategory( "IsCategoryOfLeftPresentations",
                 IsCategoryOfLeftOrRightPresentations );

DeclareCategory( "IsCategoryOfRightPresentations",
                 IsCategoryOfLeftOrRightPresentations );

##############################################
##
#! @Section Constructors
##
##############################################

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the category of left presentations
#! over $R$.
#! @Returns a category
#! @Arguments R
DeclareAttribute( "LeftPresentations",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the category of right presentations
#! over $R$.
#! @Returns a category
#! @Arguments R
DeclareAttribute( "RightPresentations",
                  IsHomalgRing );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingRing",
                  IsCategoryOfLeftOrRightPresentations );

##############################################
##
## Add methods
##
##############################################

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_PRESENTATION" );

DeclareGlobalFunction( "ADD_KERNEL_LEFT" );

DeclareGlobalFunction( "ADD_PRECOMPOSE_LEFT" );

DeclareGlobalFunction( "ADD_IS_WELL_DEFINED_FOR_MORPHISM_LEFT" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION" );

DeclareGlobalFunction( "ADD_KERNEL_RIGHT" );

DeclareGlobalFunction( "ADD_PRECOMPOSE_RIGHT" );

DeclareGlobalFunction( "ADD_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT" );

DeclareGlobalFunction( "ADD_IS_WELL_DEFINED_FOR_OBJECTS" );

DeclareGlobalFunction( "ADD_LIFT_AND_COLIFT_LEFT" );

DeclareGlobalFunction( "ADD_LIFT_AND_COLIFT_RIGHT" );
