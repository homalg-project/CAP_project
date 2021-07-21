# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Category of columns

####################################
##
#! @Section GAP Categories
##
####################################

#! @Description
#! The GAP category of objects in the category
#! of columns over a ring $R$.
#! @Arguments object
DeclareCategory( "IsCategoryOfColumnsObject",
                 IsCapCategoryObject );

DeclareCategory( "IsCategoryOfColumnsMorphism",
                 IsCapCategoryMorphism );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_CATEGORY_OF_COLUMNS" );

DeclareCategory( "IsCategoryOfColumns",
                 IsCapCategory );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "CategoryOfColumns",
                  [ IsHomalgRing ] );

DeclareAttribute( "CategoryOfColumnsAttr",
                  IsHomalgRing );

DeclareOperation( "CategoryOfColumnsObject",
                  [ IsInt, IsCategoryOfColumns ] );

KeyDependentOperation( "CategoryOfColumnsObject",
                       IsCategoryOfColumns, IsInt, ReturnTrue );

DeclareOperation( "AsCategoryOfColumnsMorphism",
                  [ IsHomalgMatrix, IsCategoryOfColumns ] );

DeclareOperation( "CategoryOfColumnsMorphism",
                  [ IsCategoryOfColumnsObject, IsHomalgMatrix, IsCategoryOfColumnsObject ] );

DeclareOperation( "\/",
                  [ IsHomalgMatrix, IsCategoryOfColumns ] );

DeclareOperation( "\/",
                  [ IsInt, IsCategoryOfColumns ] );


####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingRing",
                  IsCategoryOfColumns );

DeclareAttribute( "RankOfObject",
                  IsCategoryOfColumnsObject );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfColumnsMorphism );

DeclareAttribute( "CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple",
                  IsCategoryOfColumnsMorphism );

DeclareAttribute( "CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple",
                  IsCategoryOfColumnsMorphism );

DeclareAttribute( "CATEGORY_OF_COLUMNS_SimplificationSourceTuple",
                  IsCategoryOfColumnsMorphism );

DeclareAttribute( "CATEGORY_OF_COLUMNS_SimplificationRangeTuple",
                  IsCategoryOfColumnsMorphism );

