#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## @Chapter Serre Quotients
##
#############################################################################

DeclareCategory( "IsSerreQuotientCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareOperation( "SerreQuotientCategory",
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategory",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "\/",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AsSerreQuotientCategoryObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsGeneralizedMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphismWithSourceAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphismWithRangeAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AsSerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

DeclareAttribute( "SubcategoryMembershipTestFunctionForSerreQuotient",
                  IsCapCategory );

DeclareAttribute( "UnderlyingHonestCategory",
                  IsCapCategory );

DeclareAttribute( "UnderlyingGeneralizedMorphismCategory",
                  IsCapCategory );

DeclareAttribute( "UnderlyingGeneralizedObject",
                  IsSerreQuotientCategoryObject );

DeclareAttribute( "UnderlyingHonestObject",
                  IsSerreQuotientCategoryObject );

DeclareAttribute( "UnderlyingGeneralizedMorphism",
                  IsSerreQuotientCategoryMorphism );