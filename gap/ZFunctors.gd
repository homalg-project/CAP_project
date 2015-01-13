#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Functors from integers category
##
#############################################################################

####################################
##
## Technical stuff
##
####################################

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_ZFUNCTOR_CATEGORY" );

DeclareCategory( "IsZFunctorObject",
                 IsHomalgCategoryObject );

DeclareCategory( "IsZFunctorMorphism",
                 IsHomalgCategoryMorphism );

####################################
##
## Category
##
####################################

DeclareAttribute( "ZFunctorCategory",
                  IsHomalgCategory );

####################################
##
## Getter
##
####################################

DeclareOperation( "Differential",
                  [ IsZFunctorObject, IsInt ] );

####################################
##
## Constructors
##
####################################

DeclareOperation( "ZFunctorObject",
                  [ IsFunction, IsFunction, IsHomalgCategory ] );

DeclareOperation( "ZFunctorMorphism",
                  [ IsZFunctorObject, IsFunction, IsZFunctorObject ] );
