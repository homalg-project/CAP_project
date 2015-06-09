#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#! @Chapter Category of categories
#!  Categories itself with functors as morphisms form a category.
#!  So the data structure of <C>CapCategory</C>s is designed to be objects in a
#!  category. This category is implemented in <C>CapCat</C>.
#!  For every category, the corresponding object in Cat can be obtained via <C>AsCatObject</C>.
#!  The implemetation of the category of categories offers a data structure for functors.
#!  Those are implemented as morphisms in this category, so functors can be handled like
#!  morphisms in a category. Also convinience functions to install functors as methods are
#!  implemented (in order to avoid <C>ApplyFunctor</C>).
##
#############################################################################

####################################
##
#! @Section The category Cat
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
#!  The GAP category of homalg categories seen as object in Cat.
DeclareCategory( "IsCapCategoryAsCatObject",
                 IsCapCategoryObject );

#! @Description
#!  The GAP category of functors.
DeclareCategory( "IsCapFunctor",
                 IsCapCategoryMorphism );

DeclareCategory( "IsHomalgNaturalTransformation",
                 IsCapCategoryTwoCell );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#!  Given a homalg category, this method returns the corresponding object in Cat.
#!  For technical reasons, the filter <C>IsCapCategory</C> must not imply the filter <C>IsCapCategoryObject</C>.
#!  For example, if <C>InitialObject</C> is applied to an object, it returns the initial object of its category. If it is
#!  applied to a category, it returns the initial object of the category. If a homalg category would be
#!  a category object itself, this would be ambiguous.
#!  So categories must be wrapped in a CatObject to be an object in Cat.
#!  This method returns the wrapper object. The category can be reobtained by <C>AsCapCategory</C>.
DeclareAttributeWithToDoForIsWellDefined( "AsCatObject",
                                          IsCapCategory );

#! @Description
#!  For an object in Cat, this method returns the underlying homalg category. This method is inverse to <C>AsCatObject</C>, i.e.
#!  AsCapCategory( AsCatObject( A ) ) = A.
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
#!  These methods construct a homalg functor, i.e. a morphism in Cat.
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

#! @BeginGroup

#! @Description
#!  This operation adds a function to the functor which can then be applied to
#!  objects in the source. The given function <A>function</A> has to take one argument which
#!  must be an object in the source category and should return a CapCategoryObject. The object
#!  is automatically added to the range of the functor when it is applied to the object.
#!  The function is stored in the attribute <C>ObjectFunction</C> of <A>functor</A>.
#! @Arguments functor, function
DeclareOperation( "AddObjectFunction",
                  [ IsCapFunctor, IsFunction ] );

DeclareOperation( "AddObjectFunction",
                  [ IsCapFunctor, IsList ] );


#!
DeclareAttribute( "FunctorObjectOperation",
                  IsCapFunctor );


#! @EndGroup

#! @BeginGroup

#! @Description
#!  This operation adds a function to the functor which can then be applied to
#!  morphisms in the source. The given function <A>function</A> has to take three arguments $A, \tau, B$.
#!  When the funtor <A>functor</A> is applied to the morphism $\tau$, $A$ is the result of <A>functor</A>
#!  applied to the source of $\tau$, $B$ is the result of <A>functor</A> applied to the range.
#!  The function is stored in the attribute <C>MorphismFunction</C> of <A>functor</A>.
DeclareOperation( "AddMorphismFunction",
                  [ IsCapFunctor, IsFunction ] );

DeclareOperation( "AddMorphismFunction",
                  [ IsCapFunctor, IsList ] );

#!
DeclareAttribute( "FunctorMorphismOperation",
                  IsCapFunctor );

#! @EndGroup

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

####################################
##
#! @Section Natural transformations
##
####################################

DeclareAttribute( "Name",
                  IsHomalgNaturalTransformation );

DeclareOperation( "NaturalTransformation",
                  [ IsCapFunctor, IsCapFunctor ] );

DeclareOperation( "NaturalTransformation",
                  [ IsString, IsCapFunctor, IsCapFunctor ] );

DeclareAttribute( "NaturalTransformationCache",
                  IsHomalgNaturalTransformation );

DeclareAttribute( "NaturalTransformationFunction",
                  IsHomalgNaturalTransformation );

DeclareOperation( "AddNaturalTransformationFunction",
                  [ IsHomalgNaturalTransformation, IsFunction ] );

DeclareOperation( "ApplyNaturalTransformation",
                  [ IsHomalgNaturalTransformation, IsCapCategoryObject ] );

####################################
##
#! @Chapter Technical Details
#! @Section The category Cat
##
####################################

#! @Description
#!  Every category cell which is the result of a functor computation stores its preimage(s) in this record.
#!  The preimages are stored because they CAN be elements of product categories.
#!  If this preimage is deleted and a new one is generated for the call of this functor
#!  a new image is created. This might cause inconsistencies.
#! @Returns IsRecord
DeclareOperation( "CatFunctorPreimageList",
                  [ IsCapCategoryCell ] );

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
