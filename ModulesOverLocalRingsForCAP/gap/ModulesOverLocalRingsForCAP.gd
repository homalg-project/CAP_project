# SPDX-License-Identifier: GPL-2.0-or-later
# ModulesOverLocalRingsForCAP: Category of modules over a local ring modeled by Serre quotients for CAP
#
# Declarations
#

#! @Chapter Cap category

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

