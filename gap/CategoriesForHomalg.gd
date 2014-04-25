#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Categories for homalg
##
#############################################################################

###################################
##
#! @Level 1
#! @Section Internal stuff
##
###################################

DeclareGlobalVariable( "CATEGORIES_FOR_HOMALG" );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_NAME_COUNTER" );

DeclareGlobalFunction( "CATEGORIES_CACHE_GETTER" );

DeclareGlobalFunction( "DECIDE_INSTALL_FUNCTION" );

DeclareGlobalVariable( "CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST" );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_INSTALL_PRINT_FUNCTION" );

InstallValue( CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST,
              
              [ "CanComputeMonoAsKernelLift",
                "CanComputeEpiAsCokernelColift",
                "CanComputeIdentityMorphism",
                "CanComputeInverse",
                "CanComputeKernel",
                "CanComputeKernelEmb",
                "CanComputeKernelEmbWithGivenKernel",
                "CanComputeKernelLift",
                "CanComputeKernelLiftWithGivenKernel",
                "CanComputeCokernel",
                "CanComputeCokernelProj",
                "CanComputeCokernelProjWithGivenCokernel",
                "CanComputeCokernelColift",
                "CanComputeCokernelColiftWithGivenCokernel",
                "CanComputePreCompose",
                "CanComputePostCompose",
                "CanComputeZeroObject",
                "CanComputeMorphismFromZeroObject",
                "CanComputeMorphismIntoZeroObject",
                "CanComputeZeroMorphism",
                "CanComputeDirectSum",
                "CanComputeProjectionInFirstFactor",
                "CanComputeProjectionInSecondFactor",
                "CanComputeInjectionFromFirstSummand",
                "CanComputeInjectionFromSecondSummand",
                "CanComputeTerminalObject",
                "CanComputeUniversalMorphismIntoTerminalObject",
                "CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                "CanComputeDirectProduct",
                "CanComputeProjectionInFirstFactorOfDirectProduct",
                "CanComputeProjectionInSecondFactorOfDirectProduct",
                "CanComputeProjectionInFirstFactorWithGivenDirectProduct",
                "CanComputeProjectionInSecondFactorWithGivenDirectProduct",
                "CanComputeUniversalMorphismIntoDirectProduct",
                "CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                "CanComputeInitialObject",
                "CanComputeUniversalMorphismFromInitialObject",
                "CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject"
                 # .. 
              ] );

###################################
##
#! @ResetLevel
##
###################################

###################################
##
#! @Section Categories
##
###################################


#! @Description
#!  The category of homalg categories. Objects of this type handle
#!  the category information, the caching, and filters for objects in the category.
#!  Please note that the object itself is not related to methods, you only need it
#!  as a handler and a presentation of the category.
DeclareCategory( "IsHomalgCategory",
                 IsObject );

DeclareCategory( "IsHomalgCategoryCell",
                 IsObject );

## Earliest possible place
BindGlobal( "INSTALL_CAN_COMPUTE_PROPERTIES",
            
  function( )
    local i;
    
    for i in CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST do
        
        DeclareProperty( i, IsHomalgCategory );
        
        DeclareProperty( i, IsHomalgCategoryCell );
        
    od;
    
end );

INSTALL_CAN_COMPUTE_PROPERTIES( );

###################################
##
#! @Section Constructor
##
###################################

DeclareGlobalFunction( "CREATE_HOMALG_CATEGORY_OBJECT" );

DeclareGlobalFunction( "CREATE_HOMALG_CATEGORY_FILTERS" );

DeclareGlobalFunction( "INSTALL_ADD_FUNCTIONS_FOR_CATEGORY" );

#! @BeginGroup CreateHomalgCategory_Constructor

#! @Description
#!  Creates a new homalg category from scratch.
#!  The name is optional. If no name is given, the
#!  name will be set to a generic but unique name.
DeclareOperation( "CreateHomalgCategory",
                  [ ] );

#!
DeclareOperation( "CreateHomalgCategory",
                  [ IsString ] );
#! @EndGroup

###################################
##
#! @Section Internal attributes
##
###################################

#! @BeginGroup Filter_Attributes

#! @Description
#!  Contain filter for objects and morphisms in this category.
#!  These filters are set true once an object or morphism is added to the
#!  category. These filters are used to apply the right functions in the method selection.
DeclareAttribute( "ObjectFilter",
                  IsHomalgCategory );

#!
DeclareAttribute( "MorphismFilter",
                  IsHomalgCategory );
#! @EndGroup

#! @Description
#!  The zero object of the category, if a method for zero object is installed.
#!  Also aliases initial and terminal object once it is given.
DeclareAttribute( "ZeroObject",
                  IsHomalgCategory );

DeclareAttribute( "ZeroObject",
                  IsHomalgCategoryCell );

#############################################
##
#! @Section Add functions
##
#############################################

#!  All functions in this section install several functions for objects and morphisms 
#!  belonging to a category.

####################################
##
## Identity morphism
##
####################################

#! @BeginGroup IdentityMorphismFunction_installer

#! @Description
#!  Installs the function which returns the Identity morphism of an object. The argument <A>func</A> must be a function with one
#!  argument which returns a morphism with source and target are the argument.

DeclareAttribute( "IdentityMorphismFunction",
                  IsHomalgCategory );

DeclareOperation( "AddIdentityMorphism",
                  [ IsHomalgCategory, IsFunction ] );
#! @EndGroup

####################################
##
## Precompose
##
####################################

#! @BeginGroup PreComposeFunction_installer

#! @Description
#!  Installs the function which returns the pre-composition of two morphisms. Argument <A>func</A> must be a function which returns
#!  the composition of its two arguments, i.e. if the arguments are two morphisms <A>phi</A>: $A \rightarrow B$ and <A>psi</A>: $B \rightarrow C$ it
#!  has to return a morphism $\phi\psi : A \rightarrow C$. Source and target of this morphism will be set automatically. This function also installs
#!  PostCompose, which is just CoPreCompose.

DeclareAttribute( "PreComposeFunction",
                  IsHomalgCategory );

DeclareOperation( "AddPreCompose",
                  [ IsHomalgCategory, IsFunction ] );


#! @EndGroup

####################################
##
## Zero object
##
####################################

#! @BeginGroup ZeroObjectConstructor_installer

#! @Description
#!  Installs the Constructor function for the zero object of a given category. The argument <A>func</A> must take no argument. Later,
#!  ZeroObject can be called with an object or the category itself. Using ZeroObject, morphism into and from, and Precompose, one has ZeroMorphism
#!  installed.
#!  FIXME: Please add a bit more here.

DeclareAttribute( "ZeroObjectFunction",
                  IsHomalgCategory );

DeclareOperation( "AddZeroObject",
                  [ IsHomalgCategory, IsFunction ] );


DeclareAttribute( "MorphismIntoZeroObjectFunction",
                  IsHomalgCategory );

DeclareOperation( "AddMorphismIntoZeroObject",
                  [ IsHomalgCategory, IsFunction ] );


DeclareAttribute( "MorphismFromZeroObjectFunction",
                  IsHomalgCategory );

DeclareOperation( "AddMorphismFromZeroObject",
                  [ IsHomalgCategory, IsFunction ] );


#!  @EndGroup

####################################
##
## Direct sum
##
####################################


DeclareAttribute( "DirectSum_OnObjectsFunction",
                  IsHomalgCategory );

DeclareOperation( "AddDirectSum_OnObjects",
                  [ IsHomalgCategory, IsFunction ] );


DeclareAttribute( "InjectionFromFirstSummandFunction",
                  IsHomalgCategory );

DeclareOperation( "AddInjectionFromFirstSummand",
                  [ IsHomalgCategory, IsFunction ] );


DeclareAttribute( "InjectionFromSecondSummandFunction",
                  IsHomalgCategory );

DeclareOperation( "AddInjectionFromSecondSummand",
                  [ IsHomalgCategory, IsFunction ] );


DeclareAttribute( "ProjectionInFirstFactorFunction",
                  IsHomalgCategory );

DeclareOperation( "AddProjectionInFirstFactor",
                  [ IsHomalgCategory, IsFunction ] );


DeclareAttribute( "ProjectionInSecondFactorFunction",
                  IsHomalgCategory );

DeclareOperation( "AddProjectionInSecondFactor",
                  [ IsHomalgCategory, IsFunction ] );

# universal properties of direct sum?
# product/ coproduct?

####################################
##
## Monomorphism as kernel lift
##
####################################


DeclareAttribute( "MonoAsKernelLiftFunction",
                  IsHomalgCategory );

DeclareOperation( "AddMonoAsKernelLift",
                  [ IsHomalgCategory, IsFunction ] );

####################################
##
## Epismorphism as cokernel lift
##
####################################


DeclareAttribute( "EpiAsCokernelColiftFunction",
                  IsHomalgCategory );

DeclareOperation( "AddEpiAsCokernelColift",
                  [ IsHomalgCategory, IsFunction ] );

####################################
##
## Inverse
##
####################################


DeclareAttribute( "InverseFunction",
                  IsHomalgCategory );

DeclareOperation( "AddInverse",
                  [ IsHomalgCategory, IsFunction ] );

####################################
##
#! @Section Caching
##
####################################

DeclareOperation( "SetCaching",
                  [ IsHomalgCategory, IsString, IsString ] );

DeclareOperation( "SetCachingToWeak",
                  [ IsHomalgCategory, IsString ] );

DeclareOperation( "SetCachingToCrisp",
                  [ IsHomalgCategory, IsString ] );

DeclareOperation( "DeactivateCaching",
                  [ IsHomalgCategory, IsString ] );
