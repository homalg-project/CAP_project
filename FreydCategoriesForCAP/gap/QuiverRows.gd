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

DeclareAttribute( "QuiverRowsDescentToZDefinedByBasisPaths",
                  IsQuiverAlgebra );

DeclareAttribute( "QuiverRowsDescentToZDefinedByBasisPaths",
                  IsQuiverRowsCategory );

DeclareOperation( "QuiverRows",
                  [ IsQuiverAlgebra, IsBool ] );

DeclareOperation( "QuiverRowsObject",
                  [ IsList, IsQuiverRowsCategory ] );

DeclareOperation( "AsQuiverRowsObject",
                  [ IsQuiverVertex, IsQuiverRowsCategory ] );

DeclareOperation( "QuiverRowsMorphism",
                  [ IsQuiverRowsObject, IsList, IsQuiverRowsObject ] );

DeclareOperation( "AsQuiverRowsMorphism",
                  [ IsQuiverAlgebraElement, IsQuiverRowsCategory ] );

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

DeclareAttribute( "SortedRepresentative",
                  IsQuiverRowsObject );

DeclareAttribute( "IsomorphismToSortedRepresentative",
                  IsQuiverRowsObject );

DeclareAttribute( "IsomorphismFromSortedRepresentative",
                  IsQuiverRowsObject );

DeclareAttribute( "PermutationToSortedRepresentative",
                  IsQuiverRowsObject );

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