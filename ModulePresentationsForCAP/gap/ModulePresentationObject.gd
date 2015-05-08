#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

#############################
##
## Category
##
#############################

DeclareCategory( "IsLeftOrRightPresentation",
                 IsCapCategoryObject );

DeclareCategory( "IsLeftPresentation",
                 IsLeftOrRightPresentation );

DeclareCategory( "IsRightPresentation",
                 IsLeftOrRightPresentation );

#############################
##
## Constructors
##
#############################

DeclareOperation( "AsLeftPresentation",
                  [ IsHomalgMatrix ] );

DeclareOperation( "AsRightPresentation",
                  [ IsHomalgMatrix ] );

DeclareGlobalFunction( "AsLeftOrRightPresentation" );

DeclareOperation( "FreeLeftPresentation",
                  [ IsInt, IsHomalgRing ] );

DeclareOperation( "FreeRightPresentation",
                  [ IsInt, IsHomalgRing ] );

#############################
##
## Properties
##
#############################


DeclareFamilyProperty( "IsFree",
                       IsCapCategoryMorphism,
                       "ModuleCategory",
                       "object" );

#############################
##
## Attributes
##
#############################

DeclareAttribute( "UnderlyingMatrix",
                  IsLeftOrRightPresentation );

DeclareAttribute( "UnderlyingHomalgRing",
                  IsLeftOrRightPresentation );
