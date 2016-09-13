############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, University of Siegen
##                  Sebastian Posur,   University of Siegen
##
#! @Chapter Internal Exterior Algebra Modules
##
#############################################################################

####################################
##
#! @Section Internals
##
####################################

##
DeclareFilter( "IsInTheContextOfEModuleActionCategory" );

##
DeclareFilter( "IsEModuleActionCategoryObject" );

##
DeclareFilter( "IsEModuleActionCategoryMorphism" );

##
InstallTrueMethod( IsEModuleActionCategoryObject,
                   IsRightActionObject and IsInTheContextOfEModuleActionCategory );

##
InstallTrueMethod( IsEModuleActionCategoryMorphism,
                   IsRightActionMorphism and IsInTheContextOfEModuleActionCategory );

####################################
##
#! @Section Constructors
##
####################################

##
DeclareAttribute( "EModuleActionCategory", IsCapCategoryObject );

##
DeclareOperation( "EModuleActionCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );
##
DeclareOperation( "EModuleActionCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );
##
DeclareOperation( "EModuleActionCategoryMorphism",
                  [ IsEModuleActionCategoryObject,
                    IsCapCategoryMorphism,
                    IsEModuleActionCategoryObject ] );

##
DeclareOperation( "FreeEModuleAction",
                  [ IsCapCategoryObject, IsCapCategory and IsInTheContextOfEModuleActionCategory ] );

####################################
##
#! @Section Attributes
##
####################################

##
DeclareAttribute( "ExteriorAlgebraAsModule", IsCapCategory and IsInTheContextOfEModuleActionCategory );

##
DeclareAttribute( "ExteriorAlgebraAsModuleMultiplicationList", IsCapCategory and IsInTheContextOfEModuleActionCategory );

##
DeclareAttribute( "EModuleActionHigherMultiplications", IsEModuleActionCategoryObject );

##
DeclareAttribute( "ProjectionToHead", IsEModuleActionCategoryObject );

##
DeclareAttribute( "Head", IsEModuleActionCategoryObject );

##
DeclareAttribute( "InjectionOfSocle", IsEModuleActionCategoryObject );

##
DeclareAttribute( "Socle", IsEModuleActionCategoryObject );


####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "UniversalMorphismFromFreeModule",
                  [ IsEModuleActionCategoryObject, IsCapCategoryMorphism ] );

##
DeclareAttribute( "StepOfMinimalFreeResolutionOfKernel",
                  IsEModuleActionCategoryMorphism );
