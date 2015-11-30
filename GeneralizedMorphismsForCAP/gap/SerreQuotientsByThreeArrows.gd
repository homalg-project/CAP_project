#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## @Chapter Serre Quotients
##
#############################################################################

DeclareCategory( "IsSerreQuotientCategoryByThreeArrowsObject",
                 IsSerreQuotientCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryByThreeArrowsMorphism",
                 IsSerreQuotientCategoryMorphism );

##############################################
##
## Attributes for serre category
##
##############################################

DeclareFilter( "WasCreatedAsSerreQuotientCategoryByThreeArrows" );

##############################################
##
## Attributes
##
##############################################

##############################################
##
## Constructor
##
##############################################

DeclareOperation( "SerreQuotientCategoryByThreeArrows",
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategoryByThreeArrows",
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

