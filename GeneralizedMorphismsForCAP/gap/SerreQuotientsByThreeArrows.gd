#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Serre quotients
##
#############################################################################

DeclareCategory( "IsSerreQuotientCategoryByThreeArrowsObject",
                 IsCapCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryByThreeArrowsMorphism",
                 IsCapCategoryMorphism );

##############################################
##
## Attributes for serre category
##
##############################################

DeclareFilter( "WasCreatedAsSerreQuotientCategoryByThreeArrows" );

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

DeclareOperation( "AsSerreQuotientByThreeArrowsObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareAttribute( "UnderlyingGeneralizedObject",
                  IsSerreQuotientCategoryByThreeArrowsObject );

DeclareAttribute( "UnderlyingHonestObject",
                  IsSerreQuotientCategoryByThreeArrowsObject );

DeclareAttribute( "UnderlyingGeneralizedMorphism",
                  IsSerreQuotientCategoryByThreeArrowsMorphism );

##############################################
##
## Attributes of Serre quotient morphism
##
##############################################

DeclareAttribute( "SourceAid",
                  IsSerreQuotientCategoryByThreeArrowsMorphism );

DeclareAttribute( "RangeAid",
                  IsSerreQuotientCategoryByThreeArrowsMorphism );

DeclareAttribute( "Arrow",
                  IsSerreQuotientCategoryByThreeArrowsMorphism );

##############################################
##
## Constructor
##
##############################################

DeclareOperation( "SerreQuotientCategoryByThreeArrows",
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategoryByThreeArrows",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "\/",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AsSerreQuotientCategoryByThreeArrowsObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "SerreQuotientCategoryByThreeArrowsMorphism",
                  [ IsCapCategory, IsGeneralizedMorphismByThreeArrows ] );

DeclareOperation( "SerreQuotientCategoryByThreeArrowsMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryByThreeArrowsMorphismWithSourceAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryByThreeArrowsMorphismWithRangeAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AsSerreQuotientCategoryByThreeArrowsMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

