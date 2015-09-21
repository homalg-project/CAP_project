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

DeclareCategory( "IsSerreQuotientCategoryByCospansObject",
                 IsCapCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryByCospansMorphism",
                 IsCapCategoryMorphism );

##############################################
##
## Attributes for serre category
##
##############################################

DeclareFilter( "WasCreatedAsSerreQuotientCategoryByCospans" );

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

DeclareOperation( "AsSerreQuotientByCospansObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareAttribute( "UnderlyingGeneralizedObject",
                  IsSerreQuotientCategoryByCospansObject );

DeclareAttribute( "UnderlyingHonestObject",
                  IsSerreQuotientCategoryByCospansObject );

DeclareAttribute( "UnderlyingGeneralizedMorphism",
                  IsSerreQuotientCategoryByCospansMorphism );

##############################################
##
## Attributes of Serre quotient morphism
##
##############################################

DeclareAttribute( "SourceAid",
                  IsSerreQuotientCategoryByCospansMorphism );

DeclareAttribute( "RangeAid",
                  IsSerreQuotientCategoryByCospansMorphism );

DeclareAttribute( "Arrow",
                  IsSerreQuotientCategoryByCospansMorphism );

##############################################
##
## Constructor
##
##############################################

DeclareOperation( "SerreQuotientCategoryByCospans",
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategoryByCospans",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "\/",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AsSerreQuotientCategoryByCospansObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "SerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsGeneralizedMorphismByCospans ] );

DeclareOperation( "SerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryByCospansMorphismWithSourceAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryByCospansMorphismWithRangeAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AsSerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

