#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Lazy category
##
#############################################################################

###########################################
##
## Constructor
##
###########################################

DeclareAttribute( "LazyCategory",
                  IsCapCategory );

DeclareAttribute( "UnderlyingBusyCategory",
                  IsCapCategory );

DeclareAttribute( "Lazy",
                  IsCapCategoryCell );

DeclareGlobalFunction( "LazyObject" );

DeclareGlobalFunction( "LazyMorphism" );

DeclareGlobalFunction( "LazyMorphismWithoutSourceAndRange" );

DeclareGlobalFunction( "LazyMorphismWithoutSource" );

DeclareGlobalFunction( "LazyMorphismWithoutRange" );

###########################################
##
## Dummy Constructors
##
###########################################

DeclareOperation( "Object",
                  [ IsCapCategory ] );

DeclareOperation( "Object",
                  [ IsCapCategoryCell ] );

DeclareOperation( "Morphism",
                  [ IsCapCategory ] );

DeclareOperation( "Morphism",
                  [ IsCapCategoryObject, IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "Morphism",
                  [ IsCapCategoryCell ] );

DeclareOperation( "Morphism",
                  [ IsCapCategoryObject, IsCapCategoryCell, IsCapCategoryObject ] );

###########################################
##
## Content
##
###########################################

DeclareCategory( "IsLazyCategoryCell",
                 IsCapCategoryCell );

DeclareCategory( "IsLazyCategoryObject",
                 IsCapCategoryObject and IsLazyCategoryCell );

DeclareCategory( "IsLazyCategoryMorphism",
                 IsCapCategoryMorphism and IsLazyCategoryCell );

DeclareAttribute( "Eval",
                  IsLazyCategoryCell );


