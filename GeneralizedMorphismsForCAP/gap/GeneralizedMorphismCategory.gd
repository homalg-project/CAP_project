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

DeclareCategory( "IsGeneralizedMorphismCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsGeneralizedMorphism",
                 IsCapCategoryMorphism );

####################################
##
## Technical stuff
##
####################################

DeclareGlobalFunction( "CREATE_PROPAGATION_LISTS_FOR_GENERALIZED_MORPHISM_CATEGORY" );

DeclareGlobalVariable( "GENERALIZED_MORPHISM_CATEGORY_PROPAGATION_LIST" );

DeclareGlobalVariable( "GENERALIZED_MORPHISM_CATEGORY_CELL_PROPAGATION_LIST" );

DeclareFilter( "WasCreatedAsGeneralizedMorphismCategory" );

DeclareProperty( "INSTALL_TODO_LIST_FOR_CanComputeIsWellDefinedForMorphisms",
                 IsCapCategory );

####################################
##
## Constructors
##
####################################

DeclareAttribute( "GeneralizedMorphismCategory",
                  IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY" );

DeclareAttribute( "UnderlyingHonestCategory",
                  IsCapCategory );

DeclareAttributeWithToDoForIsWellDefined( "GeneralizedMorphismObject",
                                          IsCapCategoryObject );

DeclareAttribute( "UnderlyingHonestObject",
                  IsGeneralizedMorphismCategoryObject );

DeclareOperation( "GeneralizedMorphism",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismWithSourceAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismWithRangeAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareAttributeWithToDoForIsWellDefined( "AsGeneralizedMorphism",
                                          IsCapCategoryMorphism );

DeclareOperation( "GeneralizedMorphismFromFactorToSubobject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareAttributeWithToDoForIsWellDefined( "HonestRepresentative",
                                          IsGeneralizedMorphism );

DeclareOperation( "CommonRestriction",
                  [ IsList ] );

####################################
##
## Attributes
##
####################################

DeclareAttributeWithToDoForIsWellDefined( "SourceAid",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "RangeAid",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "MorphismAid",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "DomainOp",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "Codomain",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "AssociatedMorphism",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "DomainAssociatedMorphismCodomainTriple",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "PseudoInverse",
                                          IsGeneralizedMorphism );

##
## When calling this method on a generalized morphism, the effect
## differs from the effect of PseudoInverse.
DeclareAttributeWithToDoForIsWellDefined( "GeneralizedInverse",
                                          IsCapCategoryMorphism );

DeclareProperty( "IsHonest",
                  IsGeneralizedMorphism );

DeclareProperty( "HasHonestSource",
                  IsGeneralizedMorphism );

DeclareProperty( "HasHonestRange",
                  IsGeneralizedMorphism );

DeclareAttribute( "SubcategoryMembershipFunctionForGeneralizedMorphismCategory",
                  IsCapCategory );

InstallTrueMethod( IsHonest, HasHonestRange and HasHonestSource );

InstallTrueMethod( HasHonestRange, IsHonest );

InstallTrueMethod( HasHonestSource, IsHonest );



####################################
##
## Idempotents
##
####################################

DeclareAttribute( "IdempotentDefinedBySubobject",
                  IsCapCategoryMorphism );

DeclareAttribute( "IdempotentDefinedByFactorobject",
                  IsCapCategoryMorphism );

