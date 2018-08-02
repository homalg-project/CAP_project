#############################################################################
##
##                                               CAP package
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

DeclareGlobalFunction( "INSTALL_OPERATIONS_FOR_ZFUNCTOR_CATEGORY" );

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

DeclareAttribute( "UnderlyingCategory",
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

DeclareOperation( "ZFunctorObjectExtendedByInitialAndIdentity",
                  [ IsFunction, IsFunction, IsCapCategory, IsInt, IsInt ] );

DeclareOperation( "ZFunctorObjectExtendedByInitialAndIdentity",
                  [ IsZFunctorObject, IsInt, IsInt ] );

DeclareOperation( "ZFunctorObjectFromMorphismList",
                  [ IsList, IsInt ] );

DeclareOperation( "ZFunctorObjectFromMorphismList",
                  [ IsList ] );

KeyDependentOperation( "AsZFunctorObject", IsCapCategoryObject, IsInt, RETURN_TRUE );

DeclareOperation( "ZFunctorMorphism",
                  [ IsZFunctorObject, IsFunction, IsZFunctorObject ] );

DeclareOperation( "ZFunctorMorphism",
                  [ IsZFunctorObject, IsList, IsInt, IsZFunctorObject ] );

DeclareOperation( "ZFunctorMorphism",
                  [ IsZFunctorObject, IsList, IsZFunctorObject ] );

DeclareOperation( "ZFunctorMorphismExtendedByInitialAndIdentity",
                  [ IsZFunctorObject, IsFunction, IsZFunctorObject, IsInt, IsInt ] );

DeclareOperation( "ZFunctorMorphismExtendedByInitialAndIdentity",
                  [ IsZFunctorMorphism, IsInt, IsInt ] );

KeyDependentOperation( "AsZFunctorMorphism", IsCapCategoryMorphism, IsInt, RETURN_TRUE );


DeclareOperation( "ZFunctorObjectByInitialMorphismAndRecursiveFunction",
                  [ IsCapCategoryMorphism, IsFunction, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsZFunctorObject, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsZFunctorMorphism, IsInt ] );
