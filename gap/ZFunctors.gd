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

DeclareCategory( "IsZFunctorCell",
                 IsCapCategoryCell );

DeclareCategory( "IsZFunctorObject",
                 IsCapCategoryObject and IsZFunctorCell );

DeclareCategory( "IsZFunctorMorphism",
                 IsCapCategoryMorphism and IsZFunctorCell );


####################################
##
## Category
##
####################################

DeclareAttribute( "ZFunctorCategory",
                  IsCapCategory );

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
                  [ IsFunction, IsFunction, IsCapCategory ] );

KeyDependentOperation( "AsZFunctorObject", IsCapCategoryObject, IsInt, RETURN_TRUE );

DeclareOperation( "ZFunctorMorphism",
                  [ IsZFunctorObject, IsFunction, IsZFunctorObject ] );

KeyDependentOperation( "AsZFunctorMorphism", IsCapCategoryMorphism, IsInt, RETURN_TRUE );