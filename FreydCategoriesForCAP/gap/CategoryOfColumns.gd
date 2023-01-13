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

##
DeclareOperation( "CategoryOfColumns",
                  [ IsHomalgRing ] );

##
DeclareOperation( "CategoryOfColumnsObject",
                  [ IsInt, IsCategoryOfColumns ] );

KeyDependentOperation( "CategoryOfColumnsObject",
                       IsCategoryOfColumns, IsInt, ReturnTrue );

CapJitAddTypeSignature( "CategoryOfColumnsObject", [ IsCategoryOfColumns, IsInt ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

##
DeclareOperation( "AsCategoryOfColumnsMorphism",
                  [ IsHomalgMatrix, IsCategoryOfColumns ] );

CapJitAddTypeSignature( "AsCategoryOfColumnsMorphism", [ IsCategoryOfColumns, IsHomalgMatrix ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

DeclareOperation( "CategoryOfColumnsMorphism",
                  [ IsCategoryOfColumnsObject, IsHomalgMatrix, IsCategoryOfColumnsObject ] );

CapJitAddTypeSignature( "CategoryOfColumnsMorphism", [ IsCategoryOfColumns, IsCategoryOfColumnsObject, IsHomalgMatrix, IsCategoryOfColumnsObject ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

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

DeclareAttribute( "BasisOfRingOverBaseFieldAsColumnVector",
                  IsCategoryOfColumns );

CapJitAddTypeSignature( "BasisOfRingOverBaseFieldAsColumnVector", [ IsCategoryOfColumns ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec( filter := IsHomalgMatrix );
    
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
