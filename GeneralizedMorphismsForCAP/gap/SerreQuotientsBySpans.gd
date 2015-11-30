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

DeclareCategory( "IsSerreQuotientCategoryBySpansObject",
                 IsSerreQuotientCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryBySpansMorphism",
                 IsSerreQuotientCategoryMorphism );

##############################################
##
## Attributes for serre category
##
##############################################

DeclareFilter( "WasCreatedAsSerreQuotientCategoryBySpans" );

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

DeclareOperation( "SerreQuotientCategoryBySpans",
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategoryBySpans",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AsSerreQuotientCategoryBySpansObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "SerreQuotientCategoryBySpansMorphism",
                  [ IsCapCategory, IsGeneralizedMorphismBySpan ] );

DeclareOperation( "SerreQuotientCategoryBySpansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryBySpansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryBySpansMorphismWithRangeAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AsSerreQuotientCategoryBySpansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

