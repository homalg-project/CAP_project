# SPDX-License-Identifier: GPL-2.0-or-later
# GroupsAsCategoriesForCAP: Groups as categories on one object
#
# Declarations
#
#! @Chapter Groups as categories

####################################
##
#! @Section GAP Categories
##
####################################

##
DeclareCategory( "IsGroupAsCategory",
                 IsCapCategory );

DeclareCategory( "IsObjectInGroupAsCategory",
                 IsCapCategoryObject );

DeclareCategory( "IsMorphismInGroupAsCategory",
                 FilterIntersection( IsCapCategoryMorphism, IsAutomorphism ) );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GROUP_AS_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "GROUP_AS_CATEGORY",
                  [ IsGroup ] );

DeclareAttribute( "GroupAsCategory",
                  IsGroup );

DeclareAttribute( "GroupAsCategoryUniqueObject",
                  IsGroupAsCategory );

CapJitAddTypeSignature( "GroupAsCategoryUniqueObject", [ IsGroupAsCategory ], function ( input_types )
    
    Assert( 0, IsGroupAsCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

DeclareOperation( "GroupAsCategoryMorphism",
                  [ IsGroupAsCategory, IsMultiplicativeElementWithInverse ] );

CapJitAddTypeSignature( "GroupAsCategoryMorphism", [ IsGroupAsCategory, IsMultiplicativeElementWithInverse ], function ( input_types )
    
    Assert( 0, IsGroupAsCategory( input_types[1].category ) );
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingGroup",
                  IsGroupAsCategory );

DeclareAttribute( "ElementsOfUnderlyingGroup",
                  IsGroupAsCategory );

DeclareAttribute( "UnderlyingGroupElement",
                  IsMorphismInGroupAsCategory );

CapJitAddTypeSignature( "UnderlyingGroupElement", [ IsMorphismInGroupAsCategory ], function ( input_types )
    
    Assert( 0, IsGroupAsCategory( input_types[1].category ) );
    
    return MorphismDatumType( input_types[1].category );
    
end );

DeclareAttribute( "PositionWithinElements",
                  IsMorphismInGroupAsCategory );

####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "MultiplyGroupElements",
                  [ IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ] );

CapJitAddTypeSignature( "MultiplyGroupElements", [ IsMultiplicativeElementWithInverse, IsMultiplicativeElementWithInverse ], IsMultiplicativeElementWithInverse );

##
DeclareOperation( "*",
                  [ IsMorphismInGroupAsCategory, IsMorphismInGroupAsCategory ] );

##
DeclareOperation( "/",
                  [ IsObject, IsGroupAsCategory ] );
