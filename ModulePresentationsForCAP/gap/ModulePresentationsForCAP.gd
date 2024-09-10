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

CapJitAddTypeSignature( "UnderlyingRing", [ IsCategoryOfLeftOrRightPresentations ], input_types -> CapJitDataTypeOfRing( UnderlyingRing( input_types[1].category ) ) );

##############################################
##
## Add methods
##
##############################################

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_PRESENTATION" );

DeclareGlobalFunction( "ADD_KERNEL_LEFT" );

DeclareGlobalFunction( "ADD_IS_WELL_DEFINED_FOR_MORPHISM_LEFT" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_OBJECTS_LEFT" );

DeclareGlobalFunction( "ADD_TENSOR_UNIT_LEFT" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_OBJECTS_LEFT" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_MORPHISMS_LEFT" );

DeclareGlobalFunction( "ADD_BRAIDING_LEFT" );

DeclareGlobalFunction( "ADD_EVALUATION_MORPHISM_LEFT" );

DeclareGlobalFunction( "ADD_COEVALUATION_MORPHISM_LEFT" );

DeclareGlobalFunction( "ADD_ASSOCIATOR_LEFT" );


DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION" );

DeclareGlobalFunction( "ADD_KERNEL_RIGHT" );

DeclareGlobalFunction( "ADD_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_OBJECTS_RIGHT" );

DeclareGlobalFunction( "ADD_TENSOR_UNIT_RIGHT" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_OBJECTS_RIGHT" );

DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_MORPHISMS_RIGHT" );

DeclareGlobalFunction( "ADD_BRAIDING_RIGHT" );

DeclareGlobalFunction( "ADD_EVALUATION_MORPHISM_RIGHT" );

DeclareGlobalFunction( "ADD_COEVALUATION_MORPHISM_RIGHT" );

DeclareGlobalFunction( "ADD_ASSOCIATOR_RIGHT" );


DeclareGlobalFunction( "ADD_UNITOR" );

DeclareGlobalFunction( "ADD_IS_WELL_DEFINED_FOR_OBJECTS" );

DeclareGlobalFunction( "ADD_EQUAL_FOR_OBJECTS" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_MORPHISMS" );

DeclareGlobalFunction( "ADD_LIFT_AND_COLIFT_LEFT" );

DeclareGlobalFunction( "ADD_LIFT_AND_COLIFT_RIGHT" );
