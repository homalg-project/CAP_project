#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Categories for homalg
##
#############################################################################

###################################
##
#! @Section Categories
##
###################################

DeclareCategory( "IsHomalgCategory",
                 IsObject );

DeclareCategory( "IsHomalgCategoryMorphism",
                 IsObject );

###################################
##
#! @Section Constructor
##
###################################

DeclareGlobalFunction( "CREATE_HOMALG_CATEGORY_OBJECT" );

DeclareOperation( "HomalgCategory",
                  [ ] );

DeclareOperation( "HomalgCategory",
                  [ IsString ] );

###################################
##
#! @Section Morphism functions
##
###################################

DeclareAttribute( "HomalgCategoryOfMorphism",
                  [ IsHomalgCategoryMorphism ] );

DeclareOperation( "PreComposition",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

