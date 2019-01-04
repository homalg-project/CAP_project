#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Module Presentations
##
#############################################################################

##############################################
##
#! @Section Constructors
##
##############################################

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the category of free left presentations
#! over $R$.
#! @Returns a category
#! @Arguments R
DeclareAttribute( "LeftPresentations",
                  IsHomalgRing );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the category of free right presentations
#! over $R$.
#! @Returns a category
#! @Arguments R
DeclareAttribute( "RightPresentations",
                  IsHomalgRing );

##############################################
##
## Add methods
##
##############################################

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_LEFT_PRESENTATION" );

DeclareGlobalFunction( "ADD_KERNEL_LEFT" );

DeclareGlobalFunction( "ADD_PRECOMPOSE_LEFT" );

DeclareGlobalFunction( "ADD_ZERO_MORPHISM_LEFT" );

DeclareGlobalFunction( "ADD_EQUAL_FOR_MORPHISMS_LEFT" );

DeclareGlobalFunction( "ADD_COKERNEL_LEFT" );

DeclareGlobalFunction( "ADD_DIRECT_SUM_LEFT" );

DeclareGlobalFunction( "ADD_ZERO_OBJECT_LEFT" );

DeclareGlobalFunction( "ADD_IDENTITY_LEFT" );

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

DeclareGlobalFunction( "ADD_PRECOMPOSE_RIGHT" );

DeclareGlobalFunction( "ADD_ZERO_MORPHISM_RIGHT" );

DeclareGlobalFunction( "ADD_EQUAL_FOR_MORPHISMS_RIGHT" );

DeclareGlobalFunction( "ADD_COKERNEL_RIGHT" );

DeclareGlobalFunction( "ADD_DIRECT_SUM_RIGHT" );

DeclareGlobalFunction( "ADD_ZERO_OBJECT_RIGHT" );

DeclareGlobalFunction( "ADD_IDENTITY_RIGHT" );

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

DeclareGlobalFunction( "ADD_IS_ZERO_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_ADDITION_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_ADDITIVE_INVERSE_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_IS_IDENTICAL_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_MORPHISMS" );

DeclareGlobalFunction( "ADD_EPIMORPHISM_FROM_SOME_PROJECTIVE_OBJECT" );

DeclareGlobalFunction( "ADD_LIFT_AND_COLIFT_LEFT" );

DeclareGlobalFunction( "ADD_LIFT_AND_COLIFT_RIGHT" );
