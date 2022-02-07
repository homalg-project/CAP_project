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

DeclareProperty( "WasCreatedAsOppositeCategory",
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
    
    return rec( filter := IsCapCategory, category := Opposite( input_types[1].category ) );
    
end );

DeclareAttribute( "OppositeCategory",
                  WasCreatedAsOppositeCategory );
# TODO: make the filter more specific once categories know their filters
CapJitAddTypeSignature( "OppositeCategory", [ IsCapCategory ], function ( input_types )
    
    return rec( filter := IsCapCategory, category := Opposite( input_types[1].category ) );
    
end );

DeclareOperation( "Opposite",
                  [ IsCapCategory, IsString ] );

# FIXME: Usage of DeclareAttribute leads to recursion error
DeclareAttribute( "Opposite",
                  IsCapCategoryObject );

CapJitAddTypeSignature( "Opposite", [ IsCapCategoryObject ], function ( input_types )
    
    return rec( filter := Opposite( input_types[1].category )!.object_representation, category := Opposite( input_types[1].category ) );
    
end );

DeclareAttribute( "Opposite",
                  IsCapCategoryMorphism );

CapJitAddTypeSignature( "Opposite", [ IsCapCategoryMorphism ], function ( input_types )
    
    return rec( filter := Opposite( input_types[1].category )!.morphism_representation, category := Opposite( input_types[1].category ) );
    
end );
