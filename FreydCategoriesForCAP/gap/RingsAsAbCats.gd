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
CapJitAddTypeSignature( "UnderlyingRingElement", [ IsRingAsCategoryMorphism ], function ( input_types )
    
    if IsHomalgRing( UnderlyingRing( input_types[1].category ) ) then
        
        return rec( filter := IsHomalgRingElement );
        
    else
        
        return rec( filter := IsRingElement );
        
    fi;
    
end );

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
