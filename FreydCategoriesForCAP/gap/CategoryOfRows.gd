# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Category of rows

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

DeclareOperation( "\/",
                  [ IsHomalgMatrix, IsCategoryOfRows ] );

KeyDependentOperation( "StandardRowMorphism",
                       IsCategoryOfRowsObject, IsInt, ReturnTrue );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingRing",
                  IsCategoryOfRows );
CapJitAddTypeSignature( "UnderlyingRing", [ IsCategoryOfRows ], IsHomalgRing );

DeclareAttribute( "GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure",
                  IsCategoryOfRows );

DeclareAttribute( "ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure",
                  IsCategoryOfRows );

DeclareAttribute( "RingInclusionForHomomorphismStructure",
                  IsCategoryOfRows );

DeclareAttribute( "RankOfObject",
                  IsCategoryOfRowsObject );
CapJitAddTypeSignature( "RankOfObject", [ IsCategoryOfRowsObject ], IsInt );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfRowsMorphism );
CapJitAddTypeSignature( "UnderlyingMatrix", [ IsCategoryOfRowsMorphism ], IsHomalgMatrix );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfRowsMorphism );

DeclareAttribute( "CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple",
                  IsCategoryOfRowsMorphism );

####################################
##
#! @Section Global functions
##
####################################

DeclareGlobalFunction( "CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple" );

DeclareGlobalFunction( "CATEGORY_OF_ROWS_SimplificationSourceTuple" );

DeclareGlobalFunction( "CATEGORY_OF_ROWS_SimplificationRangeTuple" );
