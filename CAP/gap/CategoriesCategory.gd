#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#! @Chapter Category of Categories
#!  Categories itself with functors as morphisms form a category.
#!  So the data structure of <C>CapCategory</C>s is designed to be objects in a
#!  category. This category is implemented in <C>CapCat</C>.
#!  For every category, the corresponding object in Cat can be obtained via <C>AsCatObject</C>.
#!  The implemetation of the category of categories offers a data structure for functors.
#!  Those are implemented as morphisms in this category, so functors can be handled like
#!  morphisms in a category. Also convenience functions to install functors as methods are
#!  implemented (in order to avoid <C>ApplyFunctor</C>).
##
#############################################################################

####################################
##
#! @Section The Category Cat
##
####################################

#! @Description
#!  This variable stores the category of categories. Every category object is
#!  constructed as an object in this category, so Cat is constructed when loading
#!  the package. 
DeclareGlobalVariable( "CapCat" );

####################################
##
## Constructor
##
####################################

DeclareGlobalFunction( "CAP_INTERNAL_CREATE_Cat" );

####################################
##
#! @Section Categories
##
####################################

#! @Description
#!  The GAP category of CAP categories seen as object in Cat.
#! @Arguments object
DeclareCategory( "IsCapCategoryAsCatObject",
                 IsCapCategoryObject );

#! @Description
#!  The GAP category of functors.
#! @Arguments object
DeclareCategory( "IsCapFunctor",
                 IsCapCategoryMorphism );

#! @Description
#! The GAP category of natural transformations.
#! @Arguments object
DeclareCategory( "IsCapNaturalTransformation",
                 IsCapCategoryTwoCell );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#!  Given a CAP category $C$, this method returns the corresponding object in Cat.
#!  For technical reasons, the filter <C>IsCapCategory</C> must not imply the filter <C>IsCapCategoryObject</C>.
#!  For example, if <C>InitialObject</C> is applied to an object, it returns the initial object of its category. If it is
#!  applied to a category, it returns the initial object of the category. If a CAP category would be
#!  a category object itself, this would be ambiguous.
#!  So categories must be wrapped in a CatObject to be an object in Cat.
#!  This method returns the wrapper object. The category can be reobtained by <C>AsCapCategory</C>.
#! @Arguments C
DeclareAttribute( "AsCatObject",
                                          IsCapCategory );

#! @Description
#!  For an object $C$ in Cat, this method returns the underlying CAP category. This method is inverse to <C>AsCatObject</C>, i.e.
#!  AsCapCategory( AsCatObject( A ) ) = A.
#! @Arguments C
DeclareAttribute( "AsCapCategory",
                  IsCapCategoryAsCatObject );

####################################
##
#! @Section Functors
##
#!  Functors are morphisms in Cat, thus they have source and target which are categories.
#!  A multivariate functor can be constructed via a product category as source,
#!  a presheaf is constructed via the opposite category as source.
#!  Moreover, an object and a morphism function can be added to a functor, to apply it
#!  to objects or morphisms in the source category.
##
####################################

####################################
##
## Functor Constructors
##
####################################

#! @BeginGroup

#! @Description
#!  These methods construct a CAP functor, i.e. a morphism in Cat.
#!  Name should be an unique name for the functor, it is also used when the functor is
#!  installed as a method. <A>A</A> and <A>B</A> are source and target.
#!  Both can be given as object in Cat or as category itself.
#! @Arguments name,A,B
DeclareOperation( "CapFunctor",
                  [ IsString, IsCapCategory, IsCapCategory ] );

#! @Arguments name,A,B
DeclareOperation( "CapFunctor",
                  [ IsString, IsCapCategoryAsCatObject, IsCapCategory ] );

#! @Arguments name,A,B
DeclareOperation( "CapFunctor",
                  [ IsString, IsCapCategory, IsCapCategoryAsCatObject ] );

#! @Arguments name,A,B
DeclareOperation( "CapFunctor",
                  [ IsString, IsCapCategoryAsCatObject, IsCapCategoryAsCatObject ] );

#! @Arguments name,A,B
DeclareOperation( "CapFunctor",
                  [ IsString, IsList, IsCapCategory ] );

#! @Arguments name,A,B
DeclareOperation( "CapFunctor",
                  [ IsString, IsList, IsCapCategoryAsCatObject ] );
#! @EndGroup

####################################
##
## Add functions
##
####################################

#! @Description
#!  This operation adds a function to the functor which can then be applied to
#!  objects in the source. The given function <A>function</A> has to take one argument which
#!  must be an object in the source category and should return a CapCategoryObject. The object
#!  is automatically added to the range of the functor when it is applied to the object.
#! @Arguments functor, function
DeclareOperation( "AddObjectFunction",
                  [ IsCapFunctor, IsFunction ] );

DeclareOperation( "AddObjectFunction",
                  [ IsCapFunctor, IsList ] );


#! @Description
#! The argument is a functor $F$.
#! The output is the GAP operation
#! realizing the action of $F$ on objects.
#! @Arguments F
#! @Returns a GAP operation
DeclareAttribute( "FunctorObjectOperation",
                  IsCapFunctor );


#! @Description
#!  This operation adds a function to the functor which can then be applied to
#!  morphisms in the source. The given function <A>function</A> has to take three arguments $A, \tau, B$.
#!  When the funtor <A>functor</A> is applied to the morphism $\tau$, $A$ is the result of <A>functor</A>
#!  applied to the source of $\tau$, $B$ is the result of <A>functor</A> applied to the range.
#! @Arguments functor, function
DeclareOperation( "AddMorphismFunction",
                  [ IsCapFunctor, IsFunction ] );

DeclareOperation( "AddMorphismFunction",
                  [ IsCapFunctor, IsList ] );

#! @Description
#! The argument is a functor $F$.
#! The output is the GAP operation
#! realizing the action of $F$ on morphisms.
#! @Arguments F
#! @Returns a GAP operation
DeclareAttribute( "FunctorMorphismOperation",
                  IsCapFunctor );


####################################
##
## Functor Constructors
##
####################################

#! @BeginGroup

#! @Description
#!  Applies the functor <A>func</A> to the object or morphism <A>A</A>.
#! @Returns IsCapCategoryCell
#! @Arguments func,A
DeclareGlobalFunction( "ApplyFunctor" );

#! @EndGroup

####################################
##
## Functor convinience
##
####################################

#! @BeginGroup

#! @Description
#! TODO


# This one does not exist because spaces
# in operation names are okay, but cause
# terrible problems.
# DeclareOperation( "InstallFunctor",
#                   [ IsCapFunctor ] );

#! @Arguments functor,method_name
DeclareOperation( "InstallFunctor",
                  [ IsCapFunctor, IsString ] );

DeclareAttribute( "ObjectFunctionName",
                  IsCapFunctor );

DeclareAttribute( "MorphismFunctionName",
                  IsCapFunctor );

#! @EndGroup


#! @Description
#!  Returns the identity functor of the
#!  category <A>cat</A> viewed as an object
#!  in the category of categories.
#! @Arguments category
#! @Returns a functor
DeclareAttribute( "IdentityFunctor",
                  IsCapCategory );

#! @Description
#!  Returns the endofunctor of the
#!  category <A>cat</A> with zero which maps each
#!  (object isomorphic to the) zero object
#!  to <C>ZeroObject</C>(<A>cat</A>) and to itself otherwise.
#!  This functor is equivalent to the identity functor.
#! @Arguments category
#! @Returns a functor
DeclareAttribute( "FunctorCanonicalizeZeroObjects",
                  IsCapCategory );

#! @Description
#!  Returns the natural isomorphism from the identity functor
#!  to <C>FunctorCanonicalizeZeroObjects</C>(<A>cat</A>).
#! @Arguments category
#! @Returns a natural transformation
DeclareAttribute( "NaturalIsomorophismFromIdentityToCanonicalizeZeroObjects",
                  IsCapCategory );

#! @Description
#!  Returns the endofunctor of the
#!  category <A>cat</A> with zero which maps each
#!  object to itself, each morphism <M>\phi</M> to itself, unless
#!  it is congruent to the zero morphism; in this case it is mapped to
#!  <C>ZeroMorphism</C>(<C>Source</C>(<M>\phi</M>), <C>Range</C>(<M>\phi</M>)).
#!  This functor is equivalent to the identity functor.
#! @Arguments category
#! @Returns a functor
DeclareAttribute( "FunctorCanonicalizeZeroMorphisms",
                  IsCapCategory );

#! @Description
#!  Returns the natural isomorphism from the identity functor
#!  to <C>FunctorCanonicalizeZeroMorphisms</C>(<A>cat</A>).
#! @Arguments category
#! @Returns a natural transformation
DeclareAttribute( "NaturalIsomorophismFromIdentityToCanonicalizeZeroMorphisms",
                  IsCapCategory );


####################################
##
#! @Section Natural transformations
##
####################################

#! @Description
#!  As every functor, every natural transformation has a name attribute.
#!  It has to be a string and will be set by the Constructor.
#! @Returns a string
DeclareAttribute( "Name",
                  IsCapNaturalTransformation );

#! @BeginGroup

#! @Description
#!  Constructs a natural transformation between the functors <A>F</A>$:A \rightarrow B$
#!  and <A>G</A>$:A \rightarrow B$. The string <A>name</A> is optional, and, if not given,
#!  set automatically from the names of the functors
#! @Arguments [name,],F,G
#! @Returns a natural transformation
DeclareOperation( "NaturalTransformation",
                  [ IsCapFunctor, IsCapFunctor ] );

DeclareOperation( "NaturalTransformation",
                  [ IsString, IsCapFunctor, IsCapFunctor ] );
#! @EndGroup

DeclareAttribute( "NaturalTransformationCache",
                  IsCapNaturalTransformation );

DeclareAttribute( "NaturalTransformationFunction",
                  IsCapNaturalTransformation );

DeclareAttribute( "NaturalTransformationOperation",
                  IsCapNaturalTransformation );

#! @BeginGroup

#! @Description
#!  Adds the function (or list of functions) <A>func</A> to the natural transformation <A>N</A>.
#!  The function or each function in the list should take three arguments. If $N: F \rightarrow G$,
#!  the arguments should be $F(A), A, G(A)$. The ouptput should be a morphism, $F(A) \rightarrow G(A)$.
#! @Arguments N, func
DeclareOperation( "AddNaturalTransformationFunction",
                  [ IsCapNaturalTransformation, IsFunction ] );

DeclareOperation( "AddNaturalTransformationFunction",
                  [ IsCapNaturalTransformation, IsList ] );

#! @EndGroup

#! @Description
#!  Given a natural transformation <A>N</A>$:F \rightarrow G$ and an object <A>A</A>,
#!  this function should return the morphism $F(A) \rightarrow G(A)$, corresponding to
#!  <A>N</A>.
#! @Arguments N, A
#! @Returns a morphism
DeclareGlobalFunction( "ApplyNaturalTransformation" );

#! @Description
#!  Installs the natural transformation <A>N</A> as operation with the name <A>name</A>.
#!  Argument for this operation is an object, output is a morphism.
#! @Arguments N, name
DeclareOperation( "InstallNaturalTransformation",
                  [ IsCapNaturalTransformation, IsString ] );

#! @Description
#!  Computes the horizontal composition of the natural transformation <A>N</A> and
#   the functor <A>F</A>.
#! @Arguments N,F
#! @Returns a natural transformation
DeclareOperationWithCache( "HorizontalPreComposeNaturalTransformationWithFunctor",
                           [ IsCapNaturalTransformation, IsCapFunctor ] );

#! @Description
#!  Computes the horizontal composition of the functor <A>F</A> and
#!  the natural transformation <A>N</A>.
#! @Arguments F,N
#! @Returns a natural transformation
DeclareOperationWithCache( "HorizontalPreComposeFunctorWithNaturalTransformation",
                           [ IsCapFunctor, IsCapNaturalTransformation ] );


####################################
##
#! @Chapter Technical Details
#! @Section The Category Cat
##
####################################

#! @Description
#!  Retuns the caching object which stores the results of the functor <A>functor</A> applied to objects.
#! @Arguments functor
#! @Returns IsCachingObject
DeclareAttribute( "ObjectCache",
                  IsCapFunctor );

#! @Description
#!  Retuns the caching object which stores the results of the functor <A>functor</A> applied to morphisms.
#! @Arguments functor
#! @Returns IsCachingObject
DeclareAttribute( "MorphismCache",
                  IsCapFunctor );
