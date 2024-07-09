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

CapJitAddTypeSignature( "UnderlyingRing", [ IsCategoryOfColumns ], function ( input_types )
    
    return CapJitDataTypeOfRing( UnderlyingRing( input_types[1].category ) );
    
end );

DeclareAttribute( "BasisOfRingOverBaseFieldAsColumnVector",
                  IsCategoryOfColumns );

DeclareAttribute( "RankOfObject",
                  IsCategoryOfColumnsObject );
CapJitAddTypeSignature( "RankOfObject", [ IsCategoryOfColumnsObject ], IsInt );

DeclareAttribute( "UnderlyingMatrix",
                  IsCategoryOfColumnsMorphism );

CapJitAddTypeSignature( "UnderlyingMatrix", [ IsCategoryOfColumnsMorphism ], function ( input_types )
    
    Assert( 0, IsHomalgRing( UnderlyingRing( input_types[1].category ) ) );
    
    return rec(
        filter := IsHomalgMatrix,
        ring := UnderlyingRing( input_types[1].category ),
    );
    
end );

DeclareAttribute( "CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple",
                  IsCategoryOfColumnsMorphism );

CapJitAddTypeSignature( "CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple", [ IsCategoryOfColumnsMorphism ], function ( input_types )
  local ring;
    
    ring := UnderlyingRing( input_types[1].category );
    
    Assert( 0, IsHomalgRing( ring ) );
    
    return CapJitDataTypeOfNTupleOf( 3, rec( filter := IsHomalgMatrix, ring := ring ), rec( filter := IsHomalgMatrix, ring := ring ), rec( filter := IsHomalgMatrix, ring := ring ) );
    
end );
