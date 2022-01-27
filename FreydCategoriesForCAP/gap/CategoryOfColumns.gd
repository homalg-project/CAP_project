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
# TODO: make the second filter more specific once categories know their filter
CapJitAddTypeSignature( "AsCategoryOfColumnsMorphism", [ IsHomalgMatrix, IsCapCategory ], function ( args, func_stack )
    
    Assert( 0, IsCategoryOfColumns( args.2.data_type.category ) );
    
    return rec( args := args, output_type := rec( filter := args.2.data_type.category!.morphism_representation, category := args.2.data_type.category ) );
    
end );

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
CapJitAddTypeSignature( "RankOfObject", [ IsCategoryOfColumnsObject ], IsInt );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfColumnsMorphism );
CapJitAddTypeSignature( "UnderlyingMatrix", [ IsCategoryOfColumnsMorphism ], IsHomalgMatrix );

DeclareAttribute( "CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple",
                  IsCategoryOfColumnsMorphism );
