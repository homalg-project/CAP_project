# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter CoFreyd category

####################################
##
#! @Section GAP Categories
##
####################################

DeclareFilter( "IsCoFreydCategory",
               IsCapCategory );

DeclareFilter( "IsCoFreydCategoryObject",
               IsCapCategoryObject );

DeclareFilter( "IsCoFreydCategoryMorphism",
               IsCapCategoryMorphism );

####################################
##
#! @Section Constructors
##
####################################

DeclareGlobalFunction( "CO_FREYD_CATEGORY" );

DeclareAttribute( "CoFreydCategory",
                  IsCapCategory );

DeclareAttribute( "CoFreydCategoryObject",
                  IsCapCategoryMorphism );

DeclareOperation( "CoFreydCategoryMorphism",
                  [ IsCoFreydCategoryObject, IsCapCategoryMorphism, IsCoFreydCategoryObject ] );

DeclareAttribute( "AsCoFreydCategoryObject",
                  IsCapCategoryObject );

DeclareAttribute( "AsCoFreydCategoryMorphism",
                  IsCapCategoryMorphism );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsCoFreydCategory );

DeclareAttribute( "CoRelationMorphism",
                  IsCoFreydCategoryObject );

CapJitAddTypeSignature( "CoRelationMorphism", [ IsCoFreydCategoryObject ], function ( input_types )
    
    Assert( 0, IsCoFreydCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareAttribute( "UnderlyingMorphism",
                  IsCoFreydCategoryMorphism );

CapJitAddTypeSignature( "UnderlyingMorphism", [ IsCoFreydCategoryMorphism ], function ( input_types )
    
    Assert( 0, IsCoFreydCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );
