#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#! @Chapter Category of categories
#!  Categories itself with functors as morphisms form a category.
#!  So the data structure of <C>HomalgCategory</C>s is designed to be objects in a
#!  category. This category is implemented in <C>CATEGORIES_FOR_HOMALG_Cat</C>.
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
DeclareGlobalVariable( "CATEGORIES_FOR_HOMALG_Cat" );

####################################
##
## Constructor
##
####################################

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_CREATE_Cat" );

####################################
##
#! @Section Categories
##
####################################

#! @Description
#!  The GAP category of homalg categories seen as object in Cat.
DeclareCategory( "IsHomalgCategoryAsCatObject",
                 IsHomalgCategoryObject );

#! @Description
#!  The GAP category of functors.
DeclareCategory( "IsHomalgFunctor",
                 IsHomalgCategoryMorphism );

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#!  Given a homalg category, this method returns the corresponding object in Cat.
#!  For technical reasons, the filter <C>IsHomalgCategory</C> must not imply the filter <C>IsHomalgCategoryObject</C>.
#!  For example, if <C>InitialObject</C> is applied to an object, it returns the initial object of its category. If it is
#!  applied to a category, it returns the initial object of the category. If a homalg category would be
#!  a category object itself, this would be ambiguous.
#!  So categories must be wrapped in a CatObject to be an object in Cat.
#!  This method returns the wrapper object. The category can be reobtained by <C>AsHomalgCategory</C>.
DeclareAttribute( "AsCatObject",
                  IsHomalgCategory );

#! @Description
#!  For an object in Cat, this method returns the underlying homalg category. This method is inverse to <C>AsCatObject</C>, i.e.
#!  AsHomalgCategory( AsCatObject( A ) ) = A.
DeclareAttribute( "AsHomalgCategory",
                  IsHomalgCategoryAsCatObject );

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
DeclareOperation( "HomalgFunctor",
                  [ IsString, IsHomalgCategory, IsHomalgCategory ] );

#! @Arguments name,A,B
DeclareOperation( "HomalgFunctor",
                  [ IsString, IsHomalgCategoryAsCatObject, IsHomalgCategory ] );

#! @Arguments name,A,B
DeclareOperation( "HomalgFunctor",
                  [ IsString, IsHomalgCategory, IsHomalgCategoryAsCatObject ] );

#! @Arguments name,A,B
DeclareOperation( "HomalgFunctor",
                  [ IsString, IsHomalgCategoryAsCatObject, IsHomalgCategoryAsCatObject ] );

#! @EndGroup

####################################
##
## Add functions
##
####################################

DeclareOperation( "AddObjectFunction",
                  [ IsHomalgFunctor, IsFunction ] );

DeclareAttribute( "ObjectFunction",
                  IsHomalgFunctor );

DeclareOperation( "AddMorphismFunction",
                  [ IsHomalgFunctor, IsFunction ] );

DeclareAttribute( "MorphismFunction",
                  IsHomalgFunctor );

####################################
##
## Functor Constructors
##
####################################

DeclareOperation( "ApplyFunctor",
                  [ IsHomalgFunctor, IsHomalgCategoryObject ] );

DeclareOperation( "ApplyFunctor",
                  [ IsHomalgFunctor, IsHomalgCategoryMorphism ] );

####################################
##
## Functor convinience
##
####################################

DeclareOperation( "InstallFunctorOnObjects",
                  [ IsHomalgFunctor, IsString ] );

DeclareOperation( "InstallFunctorOnMorphisms",
                  [ IsHomalgFunctor, IsString ] );

DeclareOperation( "InstallFunctor",
                  [ IsHomalgFunctor, IsString, IsString ] );

DeclareOperation( "InstallFunctor",
                  [ IsHomalgFunctor, IsString ] );

DeclareOperation( "InstallFunctorOnObjects",
                  [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctorOnMorphisms",
                  [ IsHomalgFunctor ] );

DeclareOperation( "InstallFunctor",
                  [ IsHomalgFunctor ] );

DeclareAttribute( "ObjectFunctionName",
                  IsHomalgFunctor );

DeclareAttribute( "MorphismFunctionName",
                  IsHomalgFunctor );

####################################
##
## Technical stuff
##
####################################

DeclareOperation( "CatFunctorPreimageList",
                  [ IsHomalgCategoryCell ] );

DeclareAttribute( "ObjectCache",
                  IsHomalgFunctor );

DeclareAttribute( "MorphismCache",
                  IsHomalgFunctor );
