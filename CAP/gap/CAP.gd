#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Categories for homalg
#!  Categories are the main GAP objects in CAP.
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

####################################
##
#! @Section Computable categories
##
####################################

#! Let $C$ denote a category in CAP.

####################################
##
#! @Section Computable categories
##
####################################

#! We say $C$ is a $\textbf{computable category}$ if it passes the following filters:
#! * $\texttt{CanComputeIsCongruentForMorphisms}$
#! * $\texttt{CanComputePreCompose}$
#! * $\texttt{CanComputeIdentityMorphism}$

#! We say $C$ is a $\textbf{computable category}$ if it passes the following filters:
#! * $\texttt{CanComputeIsCongruentForMorphisms}$
#! * $\texttt{CanComputePreCompose}$
#! * $\texttt{CanComputeIdentityMorphism}$


###################################
##
#! @Section Internal stuff
##
###################################

DeclareGlobalVariable( "CAP_INTERNAL" );

DeclareGlobalFunction( "CAP_INTERNAL_NAME_COUNTER" );

DeclareGlobalFunction( "CATEGORIES_CACHE_GETTER" );

DeclareGlobalFunction( "GET_METHOD_CACHE" );

DeclareGlobalVariable( "CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST" );

DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_PRINT_FUNCTION" );

DeclareGlobalFunction( "INSTALL_CAN_COMPUTE_TO_DO_LISTS" );

DeclareGlobalVariable( "CAP_INTERNAL_DERIVATION_GRAPH" );


InstallValue( CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST,
              rec( 
              MathematicalPropertiesOfCategories := [
                "IsEnrichedOverCommutativeRegularSemigroup",
                "IsAbCategory",
                "IsAdditiveCategory", 
                "IsPreAbelianCategory", 
                "IsAbelianCategory",
                "IsMonoidalCategory",
                "IsBraidedMonoidalCategory",
                "IsSymmetricMonoidalCategory",
                "IsSymmetricClosedMonoidalCategory",
                "IsRigidSymmetricClosedMonoidalCategory",
                "IsStrictMonoidalCategory"
              ],
              
              CanComputeForSpecialCategories := [
                "CanComputeDomainAssociatedMorphismCodomainTriple",
                "CanComputeDomain",
                "CanComputeCodomain",
                "CanComputeAssociatedMorphism",
                "CanComputePseudoInverse",
                "CanComputeKernelObjectFunctorial",
                "CanComputeCokernelFunctorial",
                "CanComputeTerminalObjectFunctorial",
                "CanComputeInitialObjectFunctorial",
                "CanComputeDirectProductFunctorial",
                "CanComputeCoproductFunctorial",
                "CanComputeDirectSumFunctorial",
                "CanComputeFiberProductFunctorial",
                "CanComputePushoutFunctorial",
                "CanComputeGeneralizedMorphismFromFactorToSubobject", #this actually is a general algorithm, but it does not have an Add
                "CanComputeHorizontalPreCompose", # for 2-categories
                "CanComputeVerticalPreCompose",
                "CanComputeIdentityTwoCell",
                "CanComputeHonestRepresentative",
                "CanComputeIsWellDefinedForTwoCells",
                "CanComputeHorizontalPostCompose",
                "CanComputeVerticalPostCompose"
              ],
              
              CanComputeForAllCategories := [ 
                "CanComputeMonoAsKernelLift",
                "CanComputeEpiAsCokernelColift",
                "CanComputeIdentityMorphism",
                "CanComputeInverseImmutable",
                "CanComputeKernelObject",
                "CanComputeKernelEmb",
                "CanComputeKernelEmbWithGivenKernelObject",
                "CanComputeKernelLift",
                "CanComputeKernelLiftWithGivenKernelObject",
                "CanComputeCokernel",
                "CanComputeCokernelProj",
                "CanComputeCokernelProjWithGivenCokernel",
                "CanComputeCokernelColift",
                "CanComputeCokernelColiftWithGivenCokernel",
                "CanComputePreCompose",
                "CanComputePostCompose",
                "CanComputeZeroObject",
                "CanComputeZeroMorphism",
                "CanComputeDirectSum",
                "CanComputeTerminalObject",
                "CanComputeUniversalMorphismIntoTerminalObject",
                "CanComputeUniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
                "CanComputeInitialObject",
                "CanComputeUniversalMorphismFromInitialObject",
                "CanComputeUniversalMorphismFromInitialObjectWithGivenInitialObject",
                "CanComputeDirectProduct",
                "CanComputeProjectionInFactorOfDirectProduct",
                "CanComputeProjectionInFactorOfDirectProductWithGivenDirectProduct",
                "CanComputeUniversalMorphismIntoDirectProduct",
                "CanComputeUniversalMorphismIntoDirectProductWithGivenDirectProduct",
                "CanComputeIsCongruentForMorphisms",
                "CanComputeIsEqualForObjects",
                "CanComputeIsZeroForMorphisms",
                "CanComputeAdditionForMorphisms",
                "CanComputeAdditiveInverseForMorphisms",
                "CanComputeCoproduct",
                "CanComputeInjectionOfCofactorOfCoproduct",
                "CanComputeInjectionOfCofactorOfCoproductWithGivenCoproduct",
                "CanComputeUniversalMorphismFromCoproduct",
                "CanComputeUniversalMorphismFromCoproductWithGivenCoproduct",
                "CanComputeIsEqualAsSubobjects",
                "CanComputeIsEqualAsFactorobjects",
                "CanComputeDominates",
                "CanComputeCodominates",
                "CanComputeFiberProduct",
                "CanComputeProjectionInFactorOfFiberProduct",
                "CanComputeProjectionInFactorOfFiberProductWithGivenFiberProduct",
                "CanComputeUniversalMorphismIntoFiberProduct",
                "CanComputeUniversalMorphismIntoFiberProductWithGivenFiberProduct",
                "CanComputePushout",
                "CanComputeInjectionOfCofactorOfPushout",
                "CanComputeInjectionOfCofactorOfPushoutWithGivenPushout",
                "CanComputeUniversalMorphismFromPushout",
                "CanComputeUniversalMorphismFromPushoutWithGivenPushout",
                "CanComputeImageObject",
                "CanComputeImageEmbedding",
                "CanComputeImageEmbeddingWithGivenImageObject",
                "CanComputeIsWellDefinedForMorphisms",
                "CanComputeIsWellDefinedForObjects",
                "CanComputeIsZeroForObjects",
                "CanComputeIsMonomorphism",
                "CanComputeIsEpimorphism",
                "CanComputeIsIsomorphism",
                "CanComputeCoastrictionToImage",
                "CanComputeCoastrictionToImageWithGivenImageObject",
                "CanComputeUniversalMorphismFromImage",
                "CanComputeUniversalMorphismFromImageWithGivenImageObject",
                "CanComputeDirectSumDiagonalDifference",
                "CanComputeFiberProductEmbeddingInDirectSum",
                "CanComputeDirectSumCodiagonalDifference",
                "CanComputeDirectSumProjectionInPushout",
                "CanComputeLift",
                "CanComputeColift",
                "CanComputeIsomorphismFromFiberProductToKernelOfDiagonalDifference",
                "CanComputeIsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
                "CanComputeIsomorphismFromPushoutToCokernelOfDiagonalDifference",
                "CanComputeIsomorphismFromCokernelOfDiagonalDifferenceToPushout",
                "CanComputeIsomorphismFromImageObjectToKernelOfCokernel",
                "CanComputeIsomorphismFromKernelOfCokernelToImageObject",
                "CanComputeIsomorphismFromCoimageToCokernelOfKernel",
                "CanComputeIsomorphismFromCokernelOfKernelToCoimage",
                "CanComputeIsEqualForMorphisms",
                "CanComputeUniversalMorphismIntoZeroObject",
                "CanComputeUniversalMorphismIntoZeroObjectWithGivenZeroObject",
                "CanComputeUniversalMorphismFromZeroObject",
                "CanComputeUniversalMorphismFromZeroObjectWithGivenZeroObject",
                "CanComputeIsomorphismFromZeroObjectToInitialObject",
                "CanComputeIsomorphismFromInitialObjectToZeroObject",
                "CanComputeIsomorphismFromZeroObjectToTerminalObject",
                "CanComputeIsomorphismFromTerminalObjectToZeroObject",
                "CanComputeProjectionInFactorOfDirectSum",
                "CanComputeProjectionInFactorOfDirectSumWithGivenDirectSum",
                "CanComputeInjectionOfCofactorOfDirectSum",
                "CanComputeInjectionOfCofactorOfDirectSumWithGivenDirectSum",
                "CanComputeUniversalMorphismIntoDirectSum",
                "CanComputeUniversalMorphismIntoDirectSumWithGivenDirectSum",
                "CanComputeUniversalMorphismFromDirectSum",
                "CanComputeUniversalMorphismFromDirectSumWithGivenDirectSum",
                "CanComputeIsomorphismFromDirectSumToDirectProduct",
                "CanComputeIsomorphismFromDirectProductToDirectSum",
                "CanComputeIsomorphismFromDirectSumToCoproduct",
                "CanComputeIsomorphismFromCoproductToDirectSum",
                "CanComputeIsEqualForMorphismsOnMor",
                "CanComputeIsIdenticalToIdentityMorphism",
                "CanComputeIsTerminal",
                "CanComputeIsInitial",
                "CanComputeIsEndomorphism",
                "CanComputeIsAutomorphism",
                "CanComputeIsOne",
                "CanComputeIsSplitMonomorphism",
                "CanComputeIsSplitEpimorphism",
                "CanComputeIsIdempotent",
                "CanComputeIsProjective",
                "CanComputeIsInjective",
                "CanComputeCoimage",
                "CanComputeCoimageProjection",
                "CanComputeCoimageProjectionWithGivenCoimage",
                "CanComputeAstrictionToCoimage",
                "CanComputeAstrictionToCoimageWithGivenCoimage",
                "CanComputeUniversalMorphismIntoCoimage",
                "CanComputeUniversalMorphismIntoCoimageWithGivenCoimage",
                
                "CanComputeTensorProductOnObjects",
                "CanComputeTensorProductOnMorphisms",
                "CanComputeTensorProductOnMorphismsWithGivenTensorProducts",
                "CanComputeAssociatorRightToLeft",
                "CanComputeAssociatorRightToLeftWithGivenTensorProducts",
                "CanComputeAssociatorLeftToRight",
                "CanComputeAssociatorLeftToRightWithGivenTensorProducts",
                "CanComputeTensorUnit",
                "CanComputeLeftUnitor",
                "CanComputeLeftUnitorWithGivenTensorProduct",
                "CanComputeLeftUnitorInverse",
                "CanComputeLeftUnitorInverseWithGivenTensorProduct",
                "CanComputeRightUnitor",
                "CanComputeRightUnitorWithGivenTensorProduct",
                "CanComputeRightUnitorInverse",
                "CanComputeRightUnitorInverseWithGivenTensorProduct",
                "CanComputeBraiding",
                "CanComputeBraidingWithGivenTensorProducts",
                "CanComputeBraidingInverse",
                "CanComputeBraidingInverseWithGivenTensorProducts",
                "CanComputeInternalHomOnObjects",
                "CanComputeInternalHomOnMorphisms",
                "CanComputeInternalHomOnMorphismsWithGivenInternalHoms",
                "CanComputeEvaluationMorphism",
                "CanComputeEvaluationMorphismWithGivenSource",
                "CanComputeCoevaluationMorphism",
                "CanComputeCoevaluationMorphismWithGivenRange",
                "CanComputeTensorProductToInternalHomAdjunctionMap",
                "CanComputeInternalHomToTensorProductAdjunctionMap",
                "CanComputeMonoidalPreComposeMorphism",
                "CanComputeMonoidalPostComposeMorphism",
                "CanComputeDualOnObjects",
                "CanComputeDualOnMorphisms",
                "CanComputeDualOnMorphismsWithGivenDuals",
                "CanComputeMorphismToBidual",
                "CanComputeMorphismFromBidual",
                "CanComputeMorphismToBidualWithGivenBidual",
                "CanComputeTensorProductInternalHomCompatibilityMorphism",
                "CanComputeTensorProductDualityCompatibilityMorphism",
                "CanComputeMorphismFromTensorProductToInternalHom",
                "CanComputeEvaluationForDual",
                "CanComputeEvaluationForDualWithGivenTensorProduct",
                "CanComputeCoevaluationForDual",
                "CanComputeCoevaluationForDualWithGivenTensorProduct",
                "CanComputeMorphismFromInternalHomToTensorProduct",
                "CanComputeTraceMap",
                "CanComputeRankMorphism",
                "CanComputeIsomorphismFromTensorProductToInternalHom",
                "CanComputeIsomorphismFromInternalHomToTensorProduct",
                "CanComputeIsomorphismFromInternalHomToDual",
                "CanComputeIsomorphismFromDualToInternalHom",
                "CanComputeUniversalPropertyOfDual",
                "CanComputeLambdaIntroduction",
                "CanComputeLambdaElimination",
                "CanComputeIsomorphismFromObjectToInternalHom",
                "CanComputeIsomorphismFromInternalHomToObject"
                ] )
);

DeclareGlobalVariable( "CATEGORIES_FAMILY_PROPERTIES" );

InstallValue( CATEGORIES_FAMILY_PROPERTIES,
              
              rec( ) );

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
DeclareCategory( "IsCapCategory",
                 IsObject );

DeclareCategory( "IsCapCategoryCell",
                 IsObject );

DeclareCategory( "IsCapCategoryObject",
                 IsCapCategoryCell );

DeclareCategory( "IsCapCategoryMorphism",
                 IsCapCategoryCell and IsAdditiveElementWithInverse );

DeclareCategory( "IsCapCategoryTwoCell",
                 IsCapCategoryCell );

## Earliest possible place
BindGlobal( "INSTALL_CAN_COMPUTE_PROPERTIES",
            
  function( )
    local i, internal_list;
    
    internal_list := Concatenation( 
                       CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForAllCategories,
                       CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForSpecialCategories,
                       CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.MathematicalPropertiesOfCategories
                     );
    
    for i in internal_list do
        
        DeclareProperty( i, IsCapCategory );
        
        DeclareProperty( i, IsCapCategoryCell );
        
    od;
    
end );

INSTALL_CAN_COMPUTE_PROPERTIES( );

DeclareAttribute( "TheoremRecord",
                  IsCapCategory, "mutable" );

DeclareOperation( "AddCategoryToFamily",
                  [ IsCapCategory, IsString ] );

###################################
##
#! @Section Constructor
##
###################################

DeclareGlobalFunction( "CREATE_CAP_CATEGORY_OBJECT" );

DeclareGlobalFunction( "CREATE_CAP_CATEGORY_FILTERS" );

DeclareGlobalFunction( "INSTALL_ADD_FUNCTIONS_FOR_CATEGORY" );

#! @BeginGroup CreateCapCategory_Constructor

#! @Description
#!  Creates a new homalg category from scratch.
#!  The name is optional. If no name is given, the
#!  name will be set to a generic but unique name.
DeclareOperation( "CreateCapCategory",
                  [ ] );

#!
DeclareOperation( "CreateCapCategory",
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
DeclareAttribute( "CategoryFilter",
                  IsCapCategory );

#!
DeclareAttribute( "CellFilter",
                  IsCapCategory );

#!
DeclareAttribute( "ObjectFilter",
                  IsCapCategory );

#!
DeclareAttribute( "MorphismFilter",
                  IsCapCategory );

#!
DeclareAttribute( "TwoCellFilter",
                  IsCapCategory );

DeclareAttribute( "CanComputeFilter",
                  IsCapCategory );

#! @EndGroup

DeclareAttribute( "UnderlyingCategory",
                  IsCapCategory );

#############################################
##
#! @Section Well defined
##
#############################################

DeclareProperty( "IsWellDefined",
                 IsCapCategoryCell );

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

DeclareOperation( "AddIdentityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIdentityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIdentityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIdentityMorphism",
                  [ IsCapCategory, IsList ] );

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

DeclareOperation( "AddPreCompose",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddPreCompose",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddPreCompose",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddPreCompose",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "AddPostCompose",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddPostCompose",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddPostCompose",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddPostCompose",
                  [ IsCapCategory, IsList ] );


#! @EndGroup


####################################
##
## Monomorphism as kernel lift
##
####################################


DeclareOperation( "AddMonoAsKernelLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoAsKernelLift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoAsKernelLift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoAsKernelLift",
                  [ IsCapCategory, IsList ] );


####################################
##
## Epismorphism as cokernel lift
##
####################################

DeclareOperation( "AddEpiAsCokernelColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEpiAsCokernelColift",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEpiAsCokernelColift",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEpiAsCokernelColift",
                  [ IsCapCategory, IsList ] );


####################################
##
## Inverse
##
####################################

DeclareOperation( "AddInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInverse",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "AddInverseImmutable",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInverseImmutable",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInverseImmutable",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInverseImmutable",
                  [ IsCapCategory, IsList ] );


####################################
##
#! @Section Caching
##
####################################

DeclareOperation( "SetCaching",
                  [ IsCapCategory, IsString, IsString ] );

DeclareOperation( "SetCachingToWeak",
                  [ IsCapCategory, IsString ] );

DeclareOperation( "SetCachingToCrisp",
                  [ IsCapCategory, IsString ] );

DeclareOperation( "DeactivateCaching",
                  [ IsCapCategory, IsString ] );

DeclareGlobalFunction( "SetCachingOfCategory" );
DeclareGlobalFunction( "SetCachingOfCategoryWeak" );
DeclareGlobalFunction( "SetCachingOfCategoryCrisp" );
DeclareGlobalFunction( "DeactivateCachingOfCategory" );
