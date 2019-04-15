#############################################################################
##
## FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
## Copyright 2019, Martin Bies, Université libre Bruxelles
##
#! @Chapter Category of columns
#!
#############################################################################

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

DeclareAttribute( "CategoryOfColumns",
                  IsHomalgRing );


DeclareOperationWithCache( "CategoryOfColumnsObject",
                           [ IsInt, IsCategoryOfColumns ] );

DeclareAttribute( "AsCategoryOfColumnsMorphism",
                  IsHomalgMatrix );

DeclareOperation( "CategoryOfColumnsMorphism",
                  [ IsCategoryOfColumnsObject, IsHomalgMatrix, IsCategoryOfColumnsObject ] );

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
