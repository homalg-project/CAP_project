#############################################################################
##
##                                               CategoriesForHomalg package
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
                  IsHomalgCategory );

DeclareAttribute( "UnderlyingBusyCategory",
                  IsHomalgCategory );

DeclareAttribute( "Lazy",
                  IsHomalgCategoryCell );

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
                  [ IsHomalgCategory ] );

DeclareOperation( "Object",
                  [ IsHomalgCategoryCell ] );

DeclareOperation( "Morphism",
                  [ IsHomalgCategory ] );

DeclareOperation( "Morphism",
                  [ IsHomalgCategoryObject, IsHomalgCategory, IsHomalgCategoryObject ] );

DeclareOperation( "Morphism",
                  [ IsHomalgCategoryCell ] );

DeclareOperation( "Morphism",
                  [ IsHomalgCategoryObject, IsHomalgCategoryCell, IsHomalgCategoryObject ] );

###########################################
##
## Content
##
###########################################

DeclareCategory( "IsLazyCategoryCell",
                 IsHomalgCategoryCell );

DeclareCategory( "IsLazyCategoryObject",
                 IsHomalgCategoryObject and IsLazyCategoryCell );

DeclareCategory( "IsLazyCategoryMorphism",
                 IsHomalgCategoryMorphism and IsLazyCategoryCell );

DeclareAttribute( "Eval",
                  IsLazyCategoryCell );


