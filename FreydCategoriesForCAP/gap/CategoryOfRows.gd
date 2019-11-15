#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#! @Chapter Category of rows
#!
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in the category
#! of rows over a ring $R$.
#! @Arguments object
DeclareCategory( "IsCategoryOfRowsObject",
                 IsCapCategoryObject );

DeclareCategory( "IsCategoryOfRowsMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CATEGORY_OF_ROWS" );

DeclareCategory( "IsCategoryOfRows",
                 IsCapCategory );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "CategoryOfRows",
                  [ IsHomalgRing ] );

DeclareOperation( "CategoryOfRowsObject",
                  [ IsInt, IsCategoryOfRows ] );

KeyDependentOperation( "CategoryOfRowsObject",
                       IsCategoryOfRows, IsInt, ReturnTrue );

DeclareOperation( "AsCategoryOfRowsMorphism",
                  [ IsHomalgMatrix, IsCategoryOfRows ] );

DeclareOperation( "CategoryOfRowsMorphism",
                  [ IsCategoryOfRowsObject, IsHomalgMatrix, IsCategoryOfRowsObject ] );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingRing",
                  IsCategoryOfRows );

DeclareAttribute( "RankOfObject",
                  IsCategoryOfRowsObject );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfRowsMorphism );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfRowsMorphism );

DeclareAttribute( "CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple",
                  IsCategoryOfRowsMorphism );

DeclareAttribute( "CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple",
                  IsCategoryOfRowsMorphism );

DeclareAttribute( "CATEGORY_OF_ROWS_SimplificationSourceTuple",
                  IsCategoryOfRowsMorphism );

DeclareAttribute( "CATEGORY_OF_ROWS_SimplificationRangeTuple",
                  IsCategoryOfRowsMorphism );
