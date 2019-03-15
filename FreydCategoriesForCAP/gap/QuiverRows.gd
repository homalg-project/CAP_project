#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2019, Sebastian Posur, University of Siegen
##
#! @Chapter Quiver rows
#!
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsQuiverRowsObject",
                 IsCapCategoryObject );

DeclareCategory( "IsQuiverRowsMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_QUIVER_ROWS" );

DeclareCategory( "IsQuiverRowsCategory",
                 IsCapCategory );

####################################
##
#! @Section Constructors
##
####################################

DeclareAttribute( "QuiverRows",
                  IsQuiverAlgebra );

DeclareOperation( "QuiverRowsObject",
                  [ IsList, IsQuiverRowsCategory ] );

DeclareAttribute( "AsQuiverRowsObject",
                  IsQuiverVertex );

DeclareOperation( "QuiverRowsMorphism",
                  [ IsQuiverRowsObject, IsList, IsQuiverRowsObject ] );

DeclareAttribute( "AsQuiverRowsMorphism",
                  IsQuiverAlgebraElement );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingQuiverAlgebra",
                  IsQuiverRowsCategory );

DeclareAttribute( "UnderlyingQuiver",
                  IsQuiverRowsCategory );

DeclareAttribute( "ListOfQuiverVertices",
                  IsQuiverRowsObject );

DeclareAttribute( "NrSummands",
                  IsQuiverRowsObject );

DeclareAttribute( "MorphismMatrix",
                  IsQuiverRowsMorphism );

DeclareAttribute( "NrRows",
                  IsQuiverRowsMorphism );

DeclareAttribute( "NrColumns",
                  IsQuiverRowsMorphism );

DeclareAttribute( "AsListListOfMatrices",
                  IsQuiverRowsMorphism );

####################################
##
#! @Section Operators
##
####################################

DeclareOperation( "\[\]",
                  [ IsQuiverRowsMorphism, IsInt ] );

DeclareOperation( "\[\]",
                  [ IsQuiverRowsObject, IsInt ] );

DeclareGlobalFunction( "CAP_INTERNAL_MORPHISM_BETWEEN_DIRECT_SUMS_LIST_LIST" );

DeclareGlobalFunction( "CAP_INTERNAL_QUIVER_ROWS_MORPHISM_AS_LIST_LIST" );