#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Categories for homalg
#!  Categories are the main GAP objects in CategoriesForHomalg.
#!  They are used to associate GAP objects which represent objects and
#!  morphisms with their category. By associating an GAP object to the
#!  category, one of two filters belonging to the category (Object/MorphismFilter)
#!  are set to true.
#!  The GAP object of the category then acts like the type of the objects,
#!  so categories should be seen as the type of their objects.
#!  Via Add methods, functions for specific existential quantifiers can be
#!  associated to the category and after that can be applied to GAP objects in the category.
#!  A GAP category object also knows which constructions
#!  are currently possible in this category.
##
#############################################################################

###################################
##
#! @Section Internal stuff
##
###################################

DeclareGlobalVariable( "CATEGORIES_FOR_HOMALG" );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_NAME_COUNTER" );

DeclareGlobalFunction( "CATEGORIES_CACHE_GETTER" );

DeclareGlobalFunction( "GET_METHOD_CACHE" );

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
                "CanComputeTerminalObject",
                "CanComputeUniversalMorphismIntoTerminalObject",
                "CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                "CanComputeInitialObject",
                "CanComputeUniversalMorphismFromInitialObject",
                "CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject",
                "CanComputeDirectProduct",
                "CanComputeProjectionInFactor",
                "CanComputeProjectionInFactorWithGivenDirectProduct",
                "CanComputeUniversalMorphismIntoDirectProduct",
                "CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                "CanComputeEqualityOfMorphisms",
                "CanComputeIsZeroForMorphisms",
                "CanComputeAdditionForMorphisms",
                "CanComputeAdditiveInverseForMorphisms",
                "CanComputeCoproduct",
                "CanComputeInjectionOfCofactor",
                "CanComputeInjectionOfCofactorWithGivenCoproduct",
                "CanComputeUniversalMorphismFromCoproduct",
                "CanComputeUniversalMorphismFromCoproductWithGivenCoproduct",
                "CanComputeEqualityOfSubobjects",
                "CanComputeEqualityOfFactorobjects",
                "CanComputeDominates",
                "CanComputeCodominates",
                "IsAbCategory", 
                "IsPreAdditiveCategory", 
                "IsAdditiveCategory", 
                "IsPreAbelianCategory", 
                "IsAbelianCategory",
                "CanComputePullback",
                "CanComputeProjectionInFactorOfPullback",
                "CanComputeProjectionInFactorWithGivenPullback",
                "CanComputeUniversalMorphismIntoPullback",
                "CanComputeUniversalMorphismIntoPullbackWithGivenPullback",
                "CanComputePushout",
                "CanComputeInjectionOfCofactorOfPushout",
                "CanComputeInjectionOfCofactorWithGivenPushout",
                "CanComputeUniversalMorphismFromPushout",
                "CanComputeUniversalMorphismFromPushoutWithGivenPushout"
                # .. 
              ] );

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

#############################################
##
#! @Section Properties
##
#############################################

DeclareProperty( "IsAbCategory", 
                 IsHomalgCategory );

DeclareProperty( "IsPreAdditiveCategory", 
                 IsHomalgCategory );

DeclareProperty( "IsAdditiveCategory", 
                 IsHomalgCategory );

DeclareProperty( "IsPreAbelianCategory", 
                 IsHomalgCategory );

DeclareProperty( "IsAbelianCategory", 
                 IsHomalgCategory );

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

#############################################
##
#! @Section Well defined
##
#############################################

DeclareProperty( "IsWellDefined",
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
