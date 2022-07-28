# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Rings as categories

####################################
##
#! @Section GAP Categories
##
####################################

##
DeclareCategory( "IsRingAsCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsRingAsCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsRingAsCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareAttribute( "RingAsCategory",
                  IsRing );

DeclareAttribute( "RingAsCategoryUniqueObject",
                  IsRingAsCategory );

DeclareOperation( "RingAsCategoryMorphism",
                  [ IsRingElement, IsRingAsCategory ] );

KeyDependentOperation( "RingAsCategoryMorphism", IsRingAsCategory, IsRingElement, ReturnTrue );


####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingRingElement",
                  IsRingAsCategoryMorphism );
CapJitAddTypeSignature( "UnderlyingRingElement", [ IsRingAsCategoryMorphism ], IsHomalgRingElement );

DeclareAttribute( "UnderlyingRing",
                  IsRingAsCategory );

DeclareAttribute( "GeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure",
                  IsRingAsCategory );

DeclareAttribute( "ColumnVectorOfGeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure",
                  IsRingAsCategory );

DeclareAttribute( "RingInclusionForHomomorphismStructure",
                  IsRingAsCategory );

####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "\*",
                  [ IsRingAsCategoryMorphism, IsRingAsCategoryMorphism ] );

##
DeclareOperation( "\/",
                  [ IsRingElement, IsRingAsCategory ] );
