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

DeclareFilter( "IsInTheContextOfInternalExteriorAlgebraModuleCategory" );

DeclareFilter( "IsInternalExteriorAlgebraModuleCategoryObject" );

DeclareFilter( "IsInternalExteriorAlgebraModuleCategoryMorphism" );

InstallTrueMethod( IsInternalExteriorAlgebraModuleCategoryObject,
                   IsLeftActionObject and IsInTheContextOfInternalExteriorAlgebraModuleCategory );

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
                  [ IsCapCategoryObject, IsInternalExteriorAlgebraModuleCategoryObject ] );

DeclareOperation( "FreeInternalExteriorAlgebraModule",
                  [ IsCapCategoryObject, IsCapCategory and IsInTheContextOfInternalExteriorAlgebraModuleCategory ] );

####################################
##
#! @Section Operations
##
####################################

DeclareAttribute( "ExteriorAlgebraAsModule", IsCapCategory and IsInTheContextOfInternalExteriorAlgebraModuleCategory );

DeclareAttribute( "ExteriorAlgebraAsModuleMultiplicationList", IsCapCategory and IsInTheContextOfInternalExteriorAlgebraModuleCategory );
