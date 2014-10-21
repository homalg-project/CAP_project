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
## Attributes for serre category
##
##############################################

DeclareFilter( "WasCreatedAsSerreQuotientCategory" );

DeclareAttribute( "SubcategoryMembershipTestFunctionForSerreQuotient",
                  IsHomalgCategory );

DeclareAttribute( "UnderlyingHonestCategory",
                  IsHomalgCategory );

DeclareAttribute( "UnderlyingGeneralizedMorphismCategory",
                  IsHomalgCategory );

##############################################
##
## Attributes
##
##############################################

DeclareOperation( "AsSerreQuotientObject",
                  [ IsHomalgCategory, IsHomalgCategoryObject ] );

DeclareAttribute( "UnderlyingGeneralizedObject",
                  IsSerreQuotientCategoryObject );

DeclareAttribute( "UnderlyingHonestObject",
                  IsSerreQuotientCategoryObject );

DeclareAttribute( "UnderlyingGeneralizedMorphism",
                  IsSerreQuotientCategoryMorphism );

##############################################
##
## Attributes of Serre quotient morphism
##
##############################################

DeclareAttribute( "SourceAid",
                  IsSerreQuotientCategoryMorphism );

DeclareAttribute( "RangeAid",
                  IsSerreQuotientCategoryMorphism );

DeclareAttribute( "MorphismAid",
                  IsSerreQuotientCategoryMorphism );

##############################################
##
## Constructor
##
##############################################

DeclareOperation( "SerreQuotientCategory",
                  [ IsHomalgCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategory",
                  [ IsHomalgCategory, IsFunction ] );

DeclareOperation( "AsSerreQuotientCategoryObject",
                  [ IsHomalgCategory, IsHomalgCategoryObject ] );

DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsHomalgCategory, IsGeneralizedMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsHomalgCategory, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphismWithSourceAid",
                  [ IsHomalgCategory, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphismWithRangeAid",
                  [ IsHomalgCategory, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "AsSerreQuotientCategoryMorphism",
                  [ IsHomalgCategory, IsHomalgCategoryMorphism ] );

