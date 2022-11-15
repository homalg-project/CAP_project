# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Opposite category

###################################
##
#! @Section GAP Categories
##
###################################

DeclareCategory( "IsCapCategoryOppositeObject",
                 IsCapCategoryObject );

DeclareCategory( "IsCapCategoryOppositeMorphism",
                 IsCapCategoryMorphism );

###################################
##
#! @Section Technical attributes
##
###################################

DeclareFilter( "WasCreatedAsOppositeCategory",
               IsCapCategory );

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_MORPHISM" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_OBJECT" );

DeclareGlobalFunction( "CAP_INTERNAL_OPPOSITE_RECURSIVE" );

###################################
##
#! @Section Constructor
##
###################################

DeclareAttribute( "Opposite",
                  IsCapCategory );

CapJitAddTypeSignature( "Opposite", [ IsCapCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( Opposite( input_types[1].category ) );
    
end );

DeclareAttribute( "OppositeCategory",
                  WasCreatedAsOppositeCategory );

CapJitAddTypeSignature( "OppositeCategory", [ WasCreatedAsOppositeCategory ], function ( input_types )
    
    return CapJitDataTypeOfCategory( Opposite( input_types[1].category ) );
    
end );

DeclareOperation( "Opposite",
                  [ IsCapCategory, IsString ] );

# FIXME: Usage of DeclareAttribute leads to recursion error
DeclareAttribute( "Opposite",
                  IsCapCategoryObject );

CapJitAddTypeSignature( "Opposite", [ IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( Opposite( input_types[1].category ) );
    
end );

DeclareAttribute( "Opposite",
                  IsCapCategoryMorphism );

CapJitAddTypeSignature( "Opposite", [ IsCapCategoryMorphism ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( Opposite( input_types[1].category ) );
    
end );
