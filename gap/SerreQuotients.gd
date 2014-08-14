#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Serre quotients
##
#############################################################################

DeclareCategory( "IsSerreQuotientCategoryObject",
                 IsHomalgCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryMorphism",
                 IsHomalgCategoryMorphism );

##############################################
##
## Attributes
##
##############################################

DeclareAttribute( "UnderlyingGeneralizedObject",
                  IsSerreQuotientCategoryObject );

DeclareAttribute( "UnderlyingHonestObject",
                  IsSerreQuotientCategoryObject );

DeclareAttribute( "UnderlyingGeneralizedMorphism",
                  IsSerreQuotientCategoryMorphism );

