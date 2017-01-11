#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Semisimple Categories
##
#############################################################################

DeclareCategory( "IsSemisimpleCategory",
                 IsCapCategory );

####################################
##
#! @Section Constructors
##
####################################

##
DeclareOperation( "SemisimpleCategory",
                  [ IsFieldForHomalg, IsFunction, IsObject, IsString, IsBool, IsList ] );

##
DeclareOperation( "SemisimpleCategory",
                  [ IsFieldForHomalg, IsFunction, IsObject, IsString, IsBool ] );

####################################
##
#! @Section Attributes
##
####################################

##
DeclareAttribute( "MembershipFunctionForSemisimpleCategory",
                  IsSemisimpleCategory );
##
DeclareAttribute( "UnderlyingCategoryForSemisimpleCategory",
                  IsSemisimpleCategory );

##
DeclareAttribute( "UnderlyingFieldForHomalgForSemisimpleCategory",
                  IsSemisimpleCategory );

##
DeclareAttribute( "GivenObjectFilterForSemisimpleCategory",
                  IsSemisimpleCategory );

##
DeclareAttribute( "GivenMorphismFilterForSemisimpleCategory",
                  IsSemisimpleCategory );


####################################
##
#! @Section Internals
##
####################################

##
DeclareOperationWithCache( "CAP_INTERNAL_AssociatorOnIrreducibles", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject ] );

##
DeclareOperationWithCache( "CAP_INTERNAL_AssociatorFromCoherenceAxiomLeft", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject,
                             IsSemisimpleCategoryMorphism, IsSemisimpleCategoryMorphism ] );

##
DeclareOperationWithCache( "CAP_INTERNAL_AssociatorFromCoherenceAxiomRight", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject,
                             IsSemisimpleCategoryMorphism, IsSemisimpleCategoryMorphism ] );
##
DeclareOperationWithCache( "CAP_INTERNAL_Braiding_On_Irreducibles", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject ] );

##
DeclareAttribute( "CAP_INTERNAL_EvaluationForDualOnIrreduciblesAsString", IsSemisimpleCategoryObject );


##
DeclareOperation( "CAP_INTERNAL_DirectSumForPermutationLists",
                  [ IsList, IsList ] );

##
DeclareOperation( "CAP_INTERNAL_TensorProductOfPermutationWithIdentityFromRight",
                  [ IsList, IsInt ] );

##
DeclareOperation( "CAP_INTERNAL_TensorProductOfPermutationWithIdentityFromLeft",
                  [ IsList, IsInt ] );

##
DeclareOperation( "CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromRight",
                  [ IsList, IsSemisimpleCategoryObject, IsList ] );

##
DeclareOperation( "CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromLeft",
                  [ IsList, IsSemisimpleCategoryObject, IsList ] );

##
DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY" );

##
DeclareGlobalVariable( "CAP_INTERNAL_FIELD_FOR_SEMISIMPLE_CATEGORY" );

##
DeclareOperationWithCache( "CAP_INTERNAL_ExpandSemisimpleCategoryObjectList",
                           [ IsList ] );