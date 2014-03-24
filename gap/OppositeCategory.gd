#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Opposite category
##
#############################################################################

###################################
##
#! @Section Technical attributes
##
###################################

DeclareProperty( "WasCreatedAsOppositeCategory",
                 IsHomalgCategory );

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_OPPOSITE_CATEGORY" );

###################################
##
#! @Section Constructor
##
###################################

DeclareAttribute( "Opposite",
                  IsHomalgCategory );

DeclareOperation( "Opposite",
                  [ IsHomalgCategory, IsString ] );

DeclareAttribute( "Opposite",
                  IsHomalgCategoryObject );

DeclareAttribute( "Opposite",
                  IsHomalgCategoryMorphism );



