#############################################################################
##
##                                       ModulesOverLocalRingsForCAP package
##
##  Copyright 2017, Sebastian Posur,  University of Siegen
##
#! @Chapter Cap category
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareCategory( "IsCategoryOfModulePresentationsOverLocalRing",
                 IsCapCategory );

#############################
##
#! @Section Constructors
##
#############################

#! @Description
#!   Insert documentation for your function here
DeclareOperation( "CategoryOfLeftModulePresentationsOverLocalRing",
                  [ IsHomalgRing, IsList ] );

#############################
##
#! @Section Attributes
##
#############################

##
DeclareAttribute( "PrimeIdealAsHomalgMatrix",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "PrimeIdealAsModuleEmbedding",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "PrimeIdealQuotientModuleProjection",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "UnderlyingHomalgRing",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "UnderlyingHomalgRingModuloPrimeIdeal",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareAttribute( "UnderlyingHomalgRingDegreeFunction",
                  IsCategoryOfModulePresentationsOverLocalRing, "mutable" );

##
DeclareAttribute( "EmbeddingDimension",
                  IsCategoryOfModulePresentationsOverLocalRing );

##
DeclareProperty( "IsRegular",
                  IsCategoryOfModulePresentationsOverLocalRing );

