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
DeclareFilter( "IsInTheContextOfInternalExteriorAlgebraModuleCategory" );

##
DeclareFilter( "IsInternalExteriorAlgebraModuleCategoryObject" );

##
DeclareFilter( "IsInternalExteriorAlgebraModuleCategoryMorphism" );

##
InstallTrueMethod( IsInternalExteriorAlgebraModuleCategoryObject,
                   IsLeftActionObject and IsInTheContextOfInternalExteriorAlgebraModuleCategory );

##
InstallTrueMethod( IsInternalExteriorAlgebraModuleCategoryMorphism,
                   IsLeftActionMorphism and IsInTheContextOfInternalExteriorAlgebraModuleCategory );

####################################
##
#! @Section Constructors
##
####################################

##
DeclareAttribute( "InternalExteriorAlgebraModuleCategory", IsCapCategoryObject );

##
DeclareOperation( "InternalExteriorAlgebraModuleCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );
##
DeclareOperation( "InternalExteriorAlgebraModuleCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );
##
DeclareOperation( "InternalExteriorAlgebraModuleCategoryMorphism",
                  [ IsInternalExteriorAlgebraModuleCategoryObject,
                    IsCapCategoryMorphism,
                    IsInternalExteriorAlgebraModuleCategoryObject ] );

##
DeclareOperation( "FreeInternalExteriorAlgebraModule",
                  [ IsCapCategoryObject, IsCapCategory and IsInTheContextOfInternalExteriorAlgebraModuleCategory ] );

####################################
##
#! @Section Attributes
##
####################################

##
DeclareAttribute( "ExteriorAlgebraAsModule", IsCapCategory and IsInTheContextOfInternalExteriorAlgebraModuleCategory );

##
DeclareAttribute( "ExteriorAlgebraAsModuleMultiplicationList", IsCapCategory and IsInTheContextOfInternalExteriorAlgebraModuleCategory );

##
DeclareAttribute( "InternalExteriorAlgebraModuleHigherMultiplications", IsInternalExteriorAlgebraModuleCategoryObject );

##
DeclareAttribute( "ProjectionToHead", IsInternalExteriorAlgebraModuleCategoryObject );

##
DeclareAttribute( "Head", IsInternalExteriorAlgebraModuleCategoryObject );

##
DeclareAttribute( "InjectionOfSocle", IsInternalExteriorAlgebraModuleCategoryObject );

##
DeclareAttribute( "Socle", IsInternalExteriorAlgebraModuleCategoryObject );


####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "UniversalMorphismFromFreeModule",
                  [ IsInternalExteriorAlgebraModuleCategoryObject, IsCapCategoryMorphism ] );

##
DeclareAttribute( "StepOfMinimalFreeResolutionOfKernel",
                  IsInternalExteriorAlgebraModuleCategoryMorphism );
