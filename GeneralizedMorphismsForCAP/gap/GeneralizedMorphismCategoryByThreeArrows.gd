#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Generalized morphism category
##
#############################################################################

DeclareCategory( "IsGeneralizedMorphismCategoryByThreeArrowsObject",
                 IsGeneralizedMorphismCategoryObject );

DeclareCategory( "IsGeneralizedMorphismByThreeArrows",
                 IsGeneralizedMorphism );

####################################
##
## Technical stuff
##
####################################

DeclareGlobalFunction( "CREATE_PROPAGATION_LISTS_FOR_GENERALIZED_MORPHISM_CATEGORY" );

DeclareGlobalVariable( "GENERALIZED_MORPHISM_CATEGORY_PROPAGATION_LIST" );

DeclareGlobalVariable( "GENERALIZED_MORPHISM_CATEGORY_CELL_PROPAGATION_LIST" );

DeclareFilter( "WasCreatedAsGeneralizedMorphismCategoryByThreeArrows" );

DeclareProperty( "INSTALL_TODO_LIST_FOR_CanComputeIsWellDefinedForMorphisms",
                 IsCapCategory );

DeclareFilter( "HasIdentitiesAsReversedArrows" );

DeclareFilter( "HasIdentityAsSourceAid" );

DeclareFilter( "HasIdentityAsRangeAid" );

InstallTrueMethod( HasIdentitiesAsReversedArrows, HasIdentityAsRangeAid and HasIdentityAsSourceAid );

InstallTrueMethod( HasIdentityAsRangeAid, HasIdentitiesAsReversedArrows );

InstallTrueMethod( HasIdentityAsSourceAid, HasIdentitiesAsReversedArrows );

####################################
##
## Constructors
##
####################################

DeclareAttribute( "GeneralizedMorphismCategoryByThreeArrows",
                  IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_BY_THREE_ARROWS_CATEGORY" );

DeclareAttribute( "UnderlyingHonestCategory",
                  IsCapCategory );

DeclareAttributeWithToDoForIsWellDefined( "GeneralizedMorphismByThreeArrowsObject",
                                          IsCapCategoryObject );

DeclareAttribute( "UnderlyingHonestObject",
                  IsGeneralizedMorphismCategoryByThreeArrowsObject );

DeclareOperation( "GeneralizedMorphismByThreeArrows",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismByThreeArrows",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismByThreeArrowsWithSourceAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismByThreeArrowsWithRangeAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareAttributeWithToDoForIsWellDefined( "AsGeneralizedMorphismByThreeArrows",
                                          IsCapCategoryMorphism );

DeclareOperation( "GeneralizedMorphismFromFactorToSubobjectByThreeArrows",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CommonRestriction",
                  [ IsList ] );

DeclareOperation( "CommonRestrictionOp",
                  [ IsList, IsCapCategoryMorphism ] );

DeclareOperation( "CommonCoastriction",
                  [ IsList ] );

DeclareOperation( "CommonCoastrictionOp",
                  [ IsList, IsCapCategoryMorphism ] );

####################################
##
## Attributes
##
####################################

DeclareAttributeWithToDoForIsWellDefined( "SourceAid",
                                          IsGeneralizedMorphismByThreeArrows );

DeclareAttributeWithToDoForIsWellDefined( "RangeAid",
                                          IsGeneralizedMorphismByThreeArrows );

DeclareAttributeWithToDoForIsWellDefined( "Arrow",
                                          IsGeneralizedMorphismByThreeArrows );

DeclareAttributeWithToDoForIsWellDefined( "PseudoInverse",
                                          IsGeneralizedMorphismByThreeArrows );

##
## When calling this method on a generalized morphism, the effect
## differs from the effect of PseudoInverse.
DeclareAttributeWithToDoForIsWellDefined( "GeneralizedInverseByThreeArrows",
                                          IsCapCategoryMorphism );

DeclareProperty( "IsHonest",
                  IsGeneralizedMorphismByThreeArrows );

DeclareProperty( "HasHonestSource",
                  IsGeneralizedMorphismByThreeArrows );

DeclareProperty( "HasHonestRange",
                  IsGeneralizedMorphismByThreeArrows );

DeclareAttribute( "SubcategoryMembershipFunctionForGeneralizedMorphismCategoryByThreeArrows",
                  IsCapCategory );

InstallTrueMethod( IsHonest, HasHonestRange and HasHonestSource );

InstallTrueMethod( HasHonestRange, IsHonest );

InstallTrueMethod( HasHonestSource, IsHonest );

####################################
##
## Idempotents
##
####################################

DeclareAttribute( "IdempotentDefinedBySubobjectByThreeArrows",
                  IsCapCategoryMorphism );

DeclareAttribute( "IdempotentDefinedByFactorobjectByThreeArrows",
                  IsCapCategoryMorphism );

