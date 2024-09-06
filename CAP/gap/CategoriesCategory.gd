# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Category of Categories
#!  Categories itself with functors as morphisms form a category Cat.
#!  So the data structure of <C>CapCategory</C>s is designed to be objects in a
#!  category. This category is implemented in <C>CapCat</C>.
#!  For every category, the corresponding object in Cat can be obtained via <C>AsCatObject</C>.
#!  The implemetation of the category of categories offers a data structure for functors.
#!  Those are implemented as morphisms in this category, so functors can be handled like
#!  morphisms in a category. Also convenience functions to install functors as methods are
#!  implemented (in order to avoid <C>ApplyFunctor</C>).

####################################
##
#! @Section The Category Cat
##
####################################

#! @Description
#!  This variable stores the category of categories. Every category object is
#!  constructed as an object in this category, so Cat is constructed when loading
#!  the package. 
DeclareGlobalName( "CapCat" );

####################################
##
## Constructor
##
####################################

DeclareGlobalName( "CAP_INTERNAL_CREATE_Cat" );

DeclareGlobalName( "INSTALL_CAP_CAT_FUNCTIONS" );

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
#!  However, the user can explicitly decide the arity of a functor (which will only have technical implications).
#!  Thus, it is for example possible to consider a functor $A \times B \rightarrow C$
#!  either as a unary functor with source category $A \times B$ or as a binary functor.
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
#!  These methods construct a unary CAP functor.
#!  The first argument is a string for the functor's name.
#!  <A>A</A> and <A>B</A> are the source and target of the functor,
#!  and they can be given as objects in <C>CapCat</C> or as a CAP-category.
#! @Arguments name, A, B
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

#! @EndGroup

#! @BeginGroup

#! @Description
#!  These methods construct a possible multivariate CAP functor.
#!  The first argument is a string for the functor's name.
#!  The second argument is a list
#!  encoding the input signature of the functor.
#!  It can be given as a list of pairs
#!  $[ [ A_1, b_1 ], \dots, [ A_n, b_n ] ]$
#!  where a pair consists of a category $A_i$ (given as an object in <C>CapCat</C> or as a CAP-category)
#!  and a boolean $b_i$ for $i = 1, \dots, n$. Instead of a pair
#!  $[ A_i, b_i ]$, you can also give simply $A_i$, which will be interpreted as
#!  the pair $[ A_i, \mathtt{false} ]$.
#!  The third argument is the target <A>B</A> of the functor,
#!  and it can be given as an object in <C>CapCat</C> or as a CAP-category.
#!  The output is a functor
#!  with source given by the product category $D_1 \times ... \times D_n$,
#!  where $D_i = A_i$ if $b_i = \mathtt{false}$, and $D_i = A_i^{\mathrm{op}}$ otherwise.
#! @Arguments name, list, B
DeclareOperation( "CapFunctor",
                  [ IsString, IsList, IsCapCategory ] );

#! @Arguments name, list, B
DeclareOperation( "CapFunctor",
                  [ IsString, IsList, IsCapCategoryAsCatObject ] );
#! @EndGroup

#! @Description
#! The argument is a functor $F$. The output is its source as CAP category.
#! @Arguments F
DeclareAttribute( "SourceOfFunctor", IsCapFunctor );

#! @Description
#! The argument is a functor $F$. The output is its range as CAP category.
#! @Arguments F
DeclareAttribute( "RangeOfFunctor", IsCapFunctor );

####################################
##
## Add functions
##
####################################

#! @Description
#!  This operation adds a function $f$ to the functor $F$ which can then be applied to
#!  objects in the source. The given function $f$ has to take 
#!  arguments according to the <C>InputSignature</C> of $F$, i.e., if the input signature is
#!  given by
#!  $[ [A_1, b_1], \dots, [A_n,b_n] ]$,
#!  then $f$ must take $n$ arguments, where the $i$-th
#!  argument is an object in the category $A_i$ (the boolean $b_i$ is ignored).
#!  The function should return an object in the range of the functor, except when
#!  the automatic call of <C>AddObject</C> was enabled via <C>EnableAddForCategoricalOperations</C>.
#!  In this case the output only has to be a GAP object in <C>IsAttributeStoringRep</C>,
#!  which will be automatically added as an object to the range of the functor.
#! @Arguments F, f
DeclareOperation( "AddObjectFunction",
                  [ IsCapFunctor, IsFunction ] );

#! @Description
#! The argument is a functor $F$.
#! The output is the GAP operation
#! realizing the action of $F$ on objects.
#! @Arguments F
#! @Returns a GAP operation
DeclareAttribute( "FunctorObjectOperation",
                  IsCapFunctor );


#! @Description
#!  This operation adds a function $f$ to the functor $F$ which can then be applied to
#!  morphisms in the source. The given function $f$ has to take
#!  as its first argument an object $s$ that is equal (via <C>IsEqualForObjects</C>)
#!  to the source of the result of applying
#!  $F$ to the input morphisms.
#!  The next arguments of $f$ have to morphisms according to
#!  the <C>InputSignature</C> of $F$, i.e., if the input signature is
#!  given by
#!  $[ [A_1, b_1], \dots, [A_n,b_n] ]$,
#!  then $f$ must take $n$ arguments, where the $i$-th
#!  argument is a morphism in the category $A_i$ (the boolean $b_i$ is ignored).
#!  The last argument of $f$ must be an object $r$ that is equal (via <C>IsEqualForObjects</C>)
#!  to the range of the result of applying
#!  $F$ to the input morphisms.
#!  The function should return a morphism in the range of the functor, except when
#!  the automatic call of <C>AddMorphism</C> was enabled via <C>EnableAddForCategoricalOperations</C>.
#!  In this case the output only has to be a GAP object in <C>IsAttributeStoringRep</C>
#!  (with attributes <C>Source</C> and <C>Range</C> containing also GAP objects in <C>IsAttributeStoringRep</C>),
#!  which will be automatically added as a morphism to the range of the functor.
#! @Arguments F, f
DeclareOperation( "AddMorphismFunction",
                  [ IsCapFunctor, IsFunction ] );

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
#!  Applies the functor <A>func</A> either to
#!   * an object or morphism <A>A</A> in the source of <A>func</A> or
#!   * to objects or morphisms belonging to the categories
#!     in the input signature of <A>func</A>.
#! @Returns IsCapCategoryCell
#! @Arguments func, A[, B, ...]
DeclareGlobalFunction( "ApplyFunctor" );

#! @EndGroup

####################################
##
## Functor attributes
##
####################################

#! @Description
#! The argument is a functor $F$.
#! The output is a list of pairs
#!  $[ [ A_1, b_1 ], \dots, [ A_n, b_n ] ]$
#!  where a pair consists of a CAP-category $A_i$
#!  and a boolean $b_i$ for $i = 1, \dots, n$.
#! The source of $F$ is given by the product category $D_1 \times ... \times D_n$,
#!  where $D_i = A_i$ if $b_i = \mathtt{false}$, and $D_i = A_i^{\mathrm{op}}$ otherwise.
#! @Returns IsList
#! @Arguments F
DeclareAttribute( "InputSignature",
                  IsCapFunctor );

####################################
##
## Functor convinience
##
####################################

# This one does not exist because spaces
# in operation names are okay, but cause
# terrible problems.
# DeclareOperation( "InstallFunctor",
#                   [ IsCapFunctor ] );

#! @Description
#! The arguments are a functor $F$ and a string $s$.
#! To simplify the description of this operation, we let
#! $[ [ A_1, b_1 ], \dots, [ A_n, b_n ] ]$
#! denote the input signature of $F$.
#! This method tries to install $3$ operations:
#! an operation $\omega_1$ with the name $s$, an operation $\omega_2$ with 
#! the name $s\mathtt{OnObjects}$,
#! and an operation $\omega_3$ with the name $s\mathtt{OnMorphisms}$.
#! The operation $\omega_1$
#! takes as input either $n$- objects/morphisms in $A_i$
#! or a single object/morphism in the source of $F$,
#! and outputs the result of applying $F$ to this input.
#! $\omega_2$ and $\omega_3$ are the corresponding variants for objects or morphisms only.
#! This function can only be called once for each functor, every further call will be ignored.
#! @Returns nothing
#! @Arguments F, s
DeclareOperation( "InstallFunctor",
                  [ IsCapFunctor, IsString ] );

DeclareAttribute( "ObjectFunctionName",
                  IsCapFunctor );

DeclareAttribute( "MorphismFunctionName",
                  IsCapFunctor );



#! @Description
#!  Returns the identity functor of the
#!  category <A>cat</A> viewed as an object
#!  in the category of categories.
#! @Arguments cat
#! @Returns a functor
DeclareAttribute( "IdentityFunctor",
                  IsCapCategory );

#! @Description
#!  Returns the endofunctor of the
#!  category <A>cat</A> with zero which maps each
#!  (object isomorphic to the) zero object
#!  to <C>ZeroObject</C>(<A>cat</A>) and to itself otherwise.
#!  This functor is equivalent to the identity functor.
#! @Arguments cat
#! @Returns a functor
DeclareAttribute( "FunctorCanonicalizeZeroObjects",
                  IsCapCategory );

#! @Description
#!  Returns the natural isomorphism from the identity functor
#!  to <C>FunctorCanonicalizeZeroObjects</C>(<A>cat</A>).
#! @Arguments cat
#! @Returns a natural transformation
DeclareAttribute( "NaturalIsomorphismFromIdentityToCanonicalizeZeroObjects",
                  IsCapCategory );

#! @Description
#!  Returns the endofunctor of the
#!  category <A>cat</A> with zero which maps each
#!  object to itself, each morphism <M>\phi</M> to itself, unless
#!  it is congruent to the zero morphism; in this case it is mapped to
#!  <C>ZeroMorphism</C>(<C>Source</C>(<M>\phi</M>), <C>Range</C>(<M>\phi</M>)).
#!  This functor is equivalent to the identity functor.
#! @Arguments cat
#! @Returns a functor
DeclareAttribute( "FunctorCanonicalizeZeroMorphisms",
                  IsCapCategory );

#! @Description
#!  Returns the natural isomorphism from the identity functor
#!  to <C>FunctorCanonicalizeZeroMorphisms</C>(<A>cat</A>).
#! @Arguments cat
#! @Returns a natural transformation
DeclareAttribute( "NaturalIsomorphismFromIdentityToCanonicalizeZeroMorphisms",
                  IsCapCategory );


####################################
##
#! @Section Natural transformations
##
####################################

#! Natural transformations form the $2$-cells
#! of Cat. As such, it is possible to compose them
#! vertically and horizontally, see Section
#! <Ref Sect="Section_id2cellsandcomp" />.

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
#!  Adds the function <A>func</A> to the natural transformation <A>N</A>.
#!  The function should take three arguments. If $N: F \rightarrow G$,
#!  the arguments should be $F(A), A, G(A)$. The ouptput should be a morphism, $F(A) \rightarrow G(A)$.
#! @Arguments N, func
DeclareOperation( "AddNaturalTransformationFunction",
                  [ IsCapNaturalTransformation, IsFunction ] );

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
#!  the functor <A>F</A>.
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
