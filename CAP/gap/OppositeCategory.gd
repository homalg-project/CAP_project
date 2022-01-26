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

CapJitAddTypeSignature( "Opposite", [ IsCapCategory ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := IsCapCategory, category := Opposite( args.1.data_type.category ) ) );
    
end );

DeclareAttribute( "OppositeCategory",
                  WasCreatedAsOppositeCategory );
# TODO: make the filter more specific once categories know their filters
CapJitAddTypeSignature( "OppositeCategory", [ IsCapCategory ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := IsCapCategory, category := Opposite( args.1.data_type.category ) ) );
    
end );

DeclareOperation( "Opposite",
                  [ IsCapCategory, IsString ] );

# FIXME: Usage of DeclareAttribute leads to recursion error
DeclareAttribute( "Opposite",
                  IsCapCategoryObject );

CapJitAddTypeSignature( "Opposite", [ IsCapCategoryObject ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := Opposite( args.1.data_type.category )!.object_representation, category := Opposite( args.1.data_type.category ) ) );
    
end );

DeclareAttribute( "Opposite",
                  IsCapCategoryMorphism );

CapJitAddTypeSignature( "Opposite", [ IsCapCategoryMorphism ], function ( args, func_stack )
    
    return rec( args := args, output_type := rec( filter := Opposite( args.1.data_type.category )!.morphism_representation, category := Opposite( args.1.data_type.category ) ) );
    
end );
