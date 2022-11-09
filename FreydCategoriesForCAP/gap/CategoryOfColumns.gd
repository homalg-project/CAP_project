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
CapJitAddTypeSignature( "UnderlyingRing", [ IsCategoryOfColumns ], IsHomalgRing );

DeclareAttribute( "GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure",
                  IsCategoryOfColumns );

CapJitAddTypeSignature( "GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure", [ IsCategoryOfColumns ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec( filter := IsList, element_type := rec( filter := IsHomalgRingElement ) );
    
end );

DeclareAttribute( "ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure",
                  IsCategoryOfColumns );

CapJitAddTypeSignature( "ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure", [ IsCategoryOfColumns ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec( filter := IsHomalgMatrix );
    
end );

DeclareAttribute( "RingInclusionForHomomorphismStructure",
                  IsCategoryOfColumns );

CapJitAddTypeSignature( "RingInclusionForHomomorphismStructure", [ IsCategoryOfColumns ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec( filter := IsHomalgRingMap );
    
end );

DeclareAttribute( "RankOfObject",
                  IsCategoryOfColumnsObject );
CapJitAddTypeSignature( "RankOfObject", [ IsCategoryOfColumnsObject ], IsInt );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfColumnsMorphism );
CapJitAddTypeSignature( "UnderlyingMatrix", [ IsCategoryOfColumnsMorphism ], IsHomalgMatrix );

DeclareAttribute( "CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple",
                  IsCategoryOfColumnsMorphism );

CapJitAddTypeSignature( "CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple", [ IsCategoryOfColumnsMorphism ], rec(
    filter := IsNTuple,
    element_types := [
        rec( filter := IsHomalgMatrix ),
        rec( filter := IsHomalgMatrix ),
        rec( filter := IsHomalgMatrix ),
    ],
) );
