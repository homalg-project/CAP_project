#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Functors from integers category
#! Convention: A morphism in Z from an integer a to an integer b
#! exists if and only if a <= b.
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

DeclareOperation( "AsZFunctorObject",
                  [ IsHomalgCategoryObject, IsInt ] );

DeclareAttribute( "AsZFunctorObject",
                  IsHomalgCategoryObject );

DeclareOperation( "ZFunctorMorphism",
                  [ IsZFunctorObject, IsFunction, IsZFunctorObject ] );

DeclareOperation( "AsZFunctorMorphism",
                  [ IsHomalgCategoryMorphism, IsInt ] );

DeclareAttribute( "AsZFunctorMorphism",
                  IsHomalgCategoryMorphism );