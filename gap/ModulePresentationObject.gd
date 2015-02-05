#############################################################################
##
##                                       ModulePresentationsForHomalg package
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

DeclareAttribute( "AsLeftPresentation",
                  IsHomalgMatrix );

DeclareAttribute( "AsRightPresentation",
                  IsHomalgMatrix );

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
                       IsHomalgCategoryMorphism,
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
