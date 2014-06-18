#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Cocomplexes
##
#############################################################################

DeclareCategory( "IsHomalgCocomplex",
                 IsHomalgCategoryObject );

DeclareCategory( "IsHomalgCochainMorphism",
                 IsHomalgCategoryMorphism );

#################################################
##
## Constructors
##
#################################################

DeclareAttribute( "CocomplexCategory",
                  IsHomalgCategory );
