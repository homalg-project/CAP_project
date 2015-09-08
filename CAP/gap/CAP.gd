#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter CAP Categories
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
                "CanComputeIsomorphismFromInternalHomToObject",
                "CanComputeTensorProductInternalHomCompatibilityMorphismInverse"
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
#!  The category of CAP categories. Objects of this type handle
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
#!  Creates a new CAP category from scratch.
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

#############################################
##
#! @Section Well defined
##
#############################################

#! @Description
#! The argument is a cell $c$.
#! The output is <C>true</C> if $c$ is well-defined,
#! otherwise the output is <C>false</C>.
#! @Returns a boolean
#! @Arguments c
DeclareProperty( "IsWellDefined",
                 IsCapCategoryCell );


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
