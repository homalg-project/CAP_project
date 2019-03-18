#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, Uni Siegen
##                  Sebastian Posur,   Uni Siegen
##
#! @Chapter Graded Module Presentations
##
#############################################################################

##############################################
##
#! @Section Constructors
##
##############################################

#! @Description
#! The argument is a graded homalg ring $R$.
#! The output is the category of graded free left presentations
#! over $R$.
#! @Returns a category
#! @Arguments R
DeclareAttribute( "GradedLeftPresentations",
                  IsHomalgRing );

#! @Description
#! The argument is a graded homalg ring $R$.
#! The output is the category of graded free right presentations
#! over $R$.
#! @Returns a category
#! @Arguments R
DeclareAttribute( "GradedRightPresentations",
                  IsHomalgRing );

##############################################
##
## Add methods
##
##############################################

DeclareGlobalFunction( "ADD_GRADED_FUNCTIONS_FOR_LEFT_PRESENTATION" );

DeclareGlobalFunction( "ADD_GRADED_KERNEL_LEFT" );

DeclareGlobalFunction( "ADD_GRADED_IS_WELL_DEFINED_FOR_MORPHISM_LEFT" );

DeclareGlobalFunction( "ADD_GRADED_IS_WELL_DEFINED_FOR_OBJECTS_LEFT" );

DeclareGlobalFunction( "ADD_GRADED_INTERNAL_HOM_ON_OBJECTS_LEFT" );

DeclareGlobalFunction( "ADD_GRADED_INTERNAL_HOM_ON_MORPHISMS_LEFT" );

DeclareGlobalFunction( "ADD_GRADED_ASSOCIATOR_LEFT" );
# 
# DeclareGlobalFunction( "ADD_GRADED_BRAIDING_LEFT" );
# 
# DeclareGlobalFunction( "ADD_GRADED_EVALUATION_MORPHISM_LEFT" );
# 
# DeclareGlobalFunction( "ADD_GRADED_COEVALUATION_MORPHISM_LEFT" );


DeclareGlobalFunction( "ADD_GRADED_FUNCTIONS_FOR_RIGHT_PRESENTATION" );

DeclareGlobalFunction( "ADD_GRADED_KERNEL_RIGHT" );

DeclareGlobalFunction( "ADD_GRADED_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT" );

DeclareGlobalFunction( "ADD_GRADED_IS_WELL_DEFINED_FOR_OBJECTS_RIGHT" );

DeclareGlobalFunction( "ADD_GRADED_INTERNAL_HOM_ON_OBJECTS_RIGHT" );

DeclareGlobalFunction( "ADD_GRADED_INTERNAL_HOM_ON_MORPHISMS_RIGHT" );

DeclareGlobalFunction( "ADD_GRADED_ASSOCIATOR_RIGHT" );
# 
# DeclareGlobalFunction( "ADD_GRADED_BRAIDING_RIGHT" );
# 
# DeclareGlobalFunction( "ADD_GRADED_EVALUATION_MORPHISM_RIGHT" );
# 
# DeclareGlobalFunction( "ADD_GRADED_COEVALUATION_MORPHISM_RIGHT" );


DeclareGlobalFunction( "ADD_GRADED_COKERNEL" );

DeclareGlobalFunction( "ADD_GRADED_PRECOMPOSE" );

DeclareGlobalFunction( "ADD_GRADED_EQUAL_FOR_OBJECTS" );

DeclareGlobalFunction( "ADD_GRADED_ADDITION_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_GRADED_ADDITIVE_INVERSE_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_GRADED_IS_IDENTICAL_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_GRADED_TENSOR_PRODUCT_ON_MORPHISMS" );

DeclareGlobalFunction( "ADD_GRADED_ZERO_MORPHISM" );

DeclareGlobalFunction( "ADD_GRADED_DIRECT_SUM" );

DeclareGlobalFunction( "ADD_GRADED_ZERO_OBJECT" );

DeclareGlobalFunction( "ADD_GRADED_IDENTITY" );

DeclareGlobalFunction( "ADD_GRADED_TENSOR_PRODUCT_ON_OBJECTS" );

DeclareGlobalFunction( "ADD_GRADED_TENSOR_UNIT" );

DeclareGlobalFunction( "ADD_GRADED_EQUAL_FOR_MORPHISMS" );

DeclareGlobalFunction( "ADD_GRADED_LIFT" );

DeclareGlobalFunction( "ADD_GRADED_COLIFT" );

DeclareGlobalFunction( "ADD_GRADED_EPIMORPHISM_FROM_SOME_PROJECTIVE_OBJECT" );

DeclareGlobalFunction( "ADD_GRADED_UNITOR" );

DeclareGlobalFunction( "ADD_GRADED_LIFT_ALONG_MONOMORPHISM" );

DeclareGlobalFunction( "ADD_GRADED_COLIFT_ALONG_EPIMORPHISM" );

