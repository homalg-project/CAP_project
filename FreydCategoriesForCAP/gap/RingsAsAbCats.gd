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

DeclareOperation( "RING_AS_CATEGORY",
                  [ IsRing ] );

DeclareAttribute( "RingAsCategoryUniqueObject",
                  IsRingAsCategory );

CapJitAddTypeSignature( "RingAsCategoryUniqueObject", [ IsRingAsCategory ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

DeclareOperation( "RingAsCategoryMorphism",
                  [ IsRingAsCategory, IsRingElement ] );

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

CapJitAddTypeSignature( "UnderlyingRing", [ IsRingAsCategory ], function ( input_types )
    
    if IsHomalgRing( UnderlyingRing( input_types[1].category ) ) then
        
        return rec( filter := IsHomalgRing );
        
    else
        
        return rec( filter := IsRing );
        
    fi;
    
end );

DeclareAttribute( "BasisOverBaseFieldAsColumnVector",
                  IsRingAsCategory );

CapJitAddTypeSignature( "BasisOverBaseFieldAsColumnVector", [ IsRingAsCategory ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec( filter := IsHomalgMatrix );
    
end );

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
