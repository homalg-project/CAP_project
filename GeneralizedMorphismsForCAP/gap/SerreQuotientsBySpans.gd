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
                 IsCapCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryBySpansMorphism",
                 IsCapCategoryMorphism );

##############################################
##
## Attributes for serre category
##
##############################################

DeclareFilter( "WasCreatedAsSerreQuotientCategoryBySpans" );

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

DeclareOperation( "AsSerreQuotientBySpansObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareAttribute( "UnderlyingGeneralizedObject",
                  IsSerreQuotientCategoryBySpansObject );

DeclareAttribute( "UnderlyingHonestObject",
                  IsSerreQuotientCategoryBySpansObject );

DeclareAttribute( "UnderlyingGeneralizedMorphism",
                  IsSerreQuotientCategoryBySpansMorphism );

##############################################
##
## Attributes of Serre quotient morphism
##
##############################################

DeclareAttribute( "SourceAid",
                  IsSerreQuotientCategoryBySpansMorphism );

DeclareAttribute( "RangeAid",
                  IsSerreQuotientCategoryBySpansMorphism );

DeclareAttribute( "Arrow",
                  IsSerreQuotientCategoryBySpansMorphism );

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

