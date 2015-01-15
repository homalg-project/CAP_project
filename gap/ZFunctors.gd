#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Functors from integers category
#! Convention: A morphism in $\mathbb{Z}$ from an integer $a$ to an integer $b$
#! exists if and only if $a \leq b$.
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

KeyDependentOperation( "AsZFunctorObject", IsHomalgCategoryObject, IsInt, RETURN_TRUE );

DeclareOperation( "ZFunctorMorphism",
                  [ IsZFunctorObject, IsFunction, IsZFunctorObject ] );

KeyDependentOperation( "AsZFunctorMorphism", IsHomalgCategoryMorphism, IsInt, RETURN_TRUE );