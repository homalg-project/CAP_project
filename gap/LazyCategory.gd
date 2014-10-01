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

DeclareGlobalFunction( "DummyLazyObject" );

DeclareGlobalFunction( "DummyLazyMorphism" );

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

DeclareAttribute( "EvalUnderlyingObject",
                  IsLazyCategoryCell );


