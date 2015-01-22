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
                 IsCapCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryMorphism",
                 IsCapCategoryMorphism );

##############################################
##
## Attributes for serre category
##
##############################################

DeclareFilter( "WasCreatedAsSerreQuotientCategory" );

DeclareAttribute( "SubcategoryMembershipTestFunctionForSerreQuotient",
                  IsCapCategory );

DeclareAttribute( "UnderlyingHonestCategory",
                  IsCapCategory );

DeclareAttribute( "UnderlyingGeneralizedMorphismCategory",
                  IsCapCategory );

##############################################
##
## Attributes
##
##############################################

DeclareOperation( "AsSerreQuotientObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

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
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategory",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AsSerreQuotientCategoryObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsGeneralizedMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphismWithSourceAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphismWithRangeAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AsSerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

