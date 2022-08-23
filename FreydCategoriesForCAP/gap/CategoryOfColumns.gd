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

DeclareOperation( "CategoryOfColumnsObject",
                  [ IsInt, IsCategoryOfColumns ] );

KeyDependentOperation( "CategoryOfColumnsObject",
                       IsCategoryOfColumns, IsInt, ReturnTrue );

DeclareOperation( "AsCategoryOfColumnsMorphism",
                  [ IsHomalgMatrix, IsCategoryOfColumns ] );

CapJitAddTypeSignature( "AsCategoryOfColumnsMorphism", [ IsHomalgMatrix, IsCategoryOfColumns ], function ( input_types )
    
    Assert( 0, IsCategoryOfColumns( input_types[2].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
    
end );

DeclareOperation( "CategoryOfColumnsMorphism",
                  [ IsCategoryOfColumnsObject, IsHomalgMatrix, IsCategoryOfColumnsObject ] );

DeclareOperation( "\/",
                  [ IsHomalgMatrix, IsCategoryOfColumns ] );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingRing",
                  IsCategoryOfColumns );

DeclareAttribute( "RankOfObject",
                  IsCategoryOfColumnsObject );
CapJitAddTypeSignature( "RankOfObject", [ IsCategoryOfColumnsObject ], IsInt );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfColumnsMorphism );
CapJitAddTypeSignature( "UnderlyingMatrix", [ IsCategoryOfColumnsMorphism ], IsHomalgMatrix );

DeclareAttribute( "CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple",
                  IsCategoryOfColumnsMorphism );
