#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2019, Sebastian Posur, University of Siegen
##
#! @Chapter Linear closure of a category
#!
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

##
DeclareCategory( "IsLinearClosureObject",
                 IsCapCategoryObject );

DeclareCategory( "IsLinearClosureMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsLinearClosure",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_LINEAR_CLOSURE" );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "LinearClosure",
                  [ IsHomalgRing, IsGroupAsCategory ] );

DeclareOperation( "LinearClosure",
                  [ IsHomalgRing, IsCapCategory, IsFunction ] );

DeclareOperation( "LinearClosureObject",
                  [ IsCapCategory, IsLinearClosure ] );

DeclareOperation( "LinearClosureObject",
                  [ IsLinearClosure, IsCapCategoryObject ] );

DeclareOperation( "LinearClosureMorphism",
                  [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ] );

DeclareOperation( "LinearClosureMorphismNC",
                  [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ] );

####################################
##
#! @Section Attributes
##
####################################


DeclareAttribute( "UnderlyingCategory",
                   IsLinearClosure );

DeclareAttribute( "UnderlyingRing",
                   IsLinearClosure );

DeclareAttribute( "UnderlyingOriginalObject",
                   IsLinearClosureObject );

DeclareAttribute( "CoefficientsList",
                  IsLinearClosureMorphism );

DeclareAttribute( "SupportMorphisms",
                  IsLinearClosureMorphism );

####################################
##
#! @Section Functors
##
####################################

#! @Description
#!  The arguments are a functor <A>F</A>$:C\to D$, some linear closure <A>linear_closure</A> of $C$ over some
#!  commutative ring $S$ and a function <A>ring_map</A>; where $D$ is a linear category over some commutative ring $R$.
#!  The <A>ring_map</A> is a function that converts an element $s$ in $S$ to an element in $R$,
#!  such that <A>ring_map</A> defines a ring homomorphism.
#!  The output is the linear extension functor of <A>F</A> from <A>linear_closure</A> to $D$.
#! @Arguments F, linear_closure, ring_map
#! @Returns
DeclareOperation( "ExtendFunctorToLinearClosureOfSource",
      [ IsCapFunctor, IsLinearClosure, IsFunction ] );

#! @Description
#!  The arguments are a functor <A>F</A>$:C\to D$, some linear closure <A>linear_closure</A> of $C$ over some
#!  commutative ring $S$; where $D$ is a linear category over $S$.
#!  The output is the linear extension functor of <A>F</A> from <A>linear_closure</A> to $D$.
#! @Arguments F, linear_closure
#! @Returns
DeclareOperation( "ExtendFunctorToLinearClosureOfSource",
      [ IsCapFunctor, IsLinearClosure ] );

####################################
##
#! @Section Operations
##
####################################

DeclareOperation( "\*",
                  [ IsLinearClosureMorphism, IsLinearClosureMorphism ] );

DeclareOperation( "\/",
                  [ IsCapCategoryMorphism, IsLinearClosure ] );
