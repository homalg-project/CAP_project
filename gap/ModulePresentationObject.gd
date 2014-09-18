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

DeclareCategory( "IsLeftPresentation",
                 IsHomalgCategoryObject );

DeclareCategory( "IsRightPresentation",
                 IsHomalgCategoryObject );

#############################
##
## Constructors
##
#############################

DeclareAttribute( "AsLeftPresentation",
                  IsHomalgMatrix );

DeclareAttribute( "AsRightPresentation",
                  IsHomalgMatrix );
