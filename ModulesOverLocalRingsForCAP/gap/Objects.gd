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

##
DeclareOperation( "AsModulePresentationOverLocalRing",
                  [ IsCategoryOfModulePresentationsOverLocalRing, IsHomalgMatrix ] );

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
DeclareAttribute( "StandardGeneratorsModel",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

##
DeclareAttribute( "MinimalNumberOfGenerators",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

##
DeclareAttribute( "SuperfluousGeneratorsIndicesList",
                  IsCategoryOfModulePresentationsOverLocalRingObject );

##
DeclareAttribute( "SuperfluousRelationsIndicesList",
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