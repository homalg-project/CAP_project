#############################################################################
##
##                                               CAP package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Opposite category
##
#############################################################################

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

DeclareGlobalVariable( "CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_MORPHISMS" );

DeclareGlobalVariable( "CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_OBJECTS" );

DeclareGlobalVariable( "CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_CATEGORY" );

DeclareGlobalFunction( "CAP_INTERNAL_OPPOSITE_RECURSIVE" );

###################################
##
#! @Section Constructor
##
###################################

DeclareAttribute( "Opposite",
                  IsCapCategory );

DeclareOperation( "Opposite",
                  [ IsCapCategory, IsString ] );

# FIXME: Usage of DeclareAttribute leads to recursion error
DeclareAttribute( "Opposite",
                  IsCapCategoryObject );

DeclareAttribute( "Opposite",
                  IsCapCategoryMorphism );



