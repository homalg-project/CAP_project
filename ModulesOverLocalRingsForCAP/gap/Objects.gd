#############################################################################
##
##                                       ModulesOverLocalRingsForCAP package
##
##  Copyright 2017, Sebastian Posur,  University of Siegen
##
#! @Chapter Objects
##
#############################################################################

####################################
##
#! @Section GAP Category
##
####################################

DeclareCategory( "IsCategoryOfModulePresentationsOverLocalRingObject",
                 IsSerreQuotientCategoryObject );

####################################
##
#! @Section Constructors
##
####################################

##
DeclareOperation( "FreeModulePresentationOverLocalRing",
                  [ IsCategoryOfModulePresentationsOverLocalRing, IsInt ] );

####################################
##
#! @Section Attributes
##
####################################

##
DeclareAttribute( "MinimalGeneratorsModel",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

##
DeclareAttribute( "MinimalRelationsModel",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

##
DeclareAttribute( "MinimalNumberOfGenerators",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

##
DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

##
DeclareAttribute( "FiltrationByPrimeIdealEmbedding",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

##
DeclareAttribute( "CoverByFreeModule",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

##
KeyDependentOperation( "MinimalFreeResolutionDifferential", 
                       IsCategoryOfModulePresentationsOverLocalRingObject, IsInt, ReturnTrue );

##
DeclareAttribute( "MinimalFreeResolution",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

####################################
##
#! @Section Operations
##
####################################

DeclareOperationWithCache( "TorComplex",
                           [ IsCategoryOfModulePresentationsOverLocalRingObject,
                             IsCategoryOfModulePresentationsOverLocalRingObject ] );