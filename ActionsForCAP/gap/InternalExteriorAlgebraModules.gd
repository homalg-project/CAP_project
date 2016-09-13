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

## categories

DeclareCategory( "IsEModuleCategory", IsCapCategory );

DeclareCategory( "IsEModuleActionCategory", IsEModuleCategory );

DeclareCategory( "IsEModuleCoactionCategory", IsEModuleCategory );

## objects

DeclareCategory( "IsEModuleCategoryObject", IsCapCategoryObject );

DeclareCategory( "IsEModuleActionCategoryObject", IsEModuleCategoryObject and IsRightActionObject );

DeclareCategory( "IsEModuleCoactionCategoryObject", IsEModuleCategoryObject and IsLeftCoactionObject );

## morphisms

DeclareCategory( "IsEModuleCategoryMorphism", IsCapCategoryMorphism );

DeclareCategory( "IsEModuleActionCategoryMorphism", IsCapCategoryMorphism and IsRightActionMorphism );

DeclareCategory( "IsEModuleCoactionCategoryMorphism", IsCapCategoryMorphism and IsLeftCoactionMorphism );


####################################
##
#! @Section Constructors
##
####################################

## categories
##
DeclareAttribute( "EModuleActionCategory", IsCapCategoryObject );

##
DeclareAttribute( "EModuleCoactionCategory", IsCapCategoryObject );

## objects
##
DeclareOperation( "EModuleActionCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );

##
DeclareOperation( "EModuleActionCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

##
DeclareOperation( "EModuleCoactionCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );

##
DeclareOperation( "EModuleCoactionCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

## morphisms
##
DeclareOperation( "EModuleCategoryMorphism",
                  [ IsEModuleCategoryObject, IsCapCategoryMorphism, IsEModuleCategoryObject ] );

####################################
##
#! @Section Attributes
##
####################################

##
DeclareAttribute( "ExteriorAlgebraAsModule", IsEModuleCategory );

##
DeclareAttribute( "ExteriorAlgebraAsModuleMultiplicationList", IsEModuleCategory );

##
DeclareAttribute( "EModuleActionHigherMultiplications", IsEModuleActionCategoryObject );

##
DeclareAttribute( "ProjectionToHead", IsEModuleCategoryObject );

##
DeclareAttribute( "Head", IsEModuleCategoryObject );

##
DeclareAttribute( "InjectionOfSocle", IsEModuleCategoryObject );

##
DeclareAttribute( "Socle", IsEModuleCategoryObject );


####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "FreeEModule",
                  [ IsCapCategoryObject, IsEModuleCategory ] );

##
DeclareOperation( "UniversalMorphismFromFreeModule",
                  [ IsEModuleActionCategoryObject, IsCapCategoryMorphism ] );

##
DeclareAttribute( "StepOfMinimalFreeResolutionOfKernel",
                  IsEModuleActionCategoryMorphism );
