#############################################################################
##
##                                       ModulePresentationsForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

##############################################
##
## Category
##
##############################################

DeclareAttribute( "LeftPresentations",
                  IsHomalgRing );

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



DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION" );

DeclareGlobalFunction( "ADD_KERNEL_RIGHT" );

DeclareGlobalFunction( "ADD_PRECOMPOSE_RIGHT" );

DeclareGlobalFunction( "ADD_ZERO_MORPHISM_RIGHT" );

DeclareGlobalFunction( "ADD_EQUAL_FOR_MORPHISMS_RIGHT" );

DeclareGlobalFunction( "ADD_COKERNEL_RIGHT" );

DeclareGlobalFunction( "ADD_DIRECT_SUM_RIGHT" );

DeclareGlobalFunction( "ADD_ZERO_OBJECT_RIGHT" );



DeclareGlobalFunction( "ADD_IS_ZERO_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_ADDITION_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_ADDITIVE_INVERSE_FOR_MORPHISMS" );
