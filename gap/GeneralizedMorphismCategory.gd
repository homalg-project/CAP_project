#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Generalized morphism category
##
#############################################################################

DeclareCategory( "IsGeneralizedMorphismCategoryObject",
                 IsHomalgCategoryObject );

DeclareCategory( "IsGeneralizedMorphism",
                 IsHomalgCategoryMorphism );

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
                 IsHomalgCategory );

####################################
##
## Constructors
##
####################################

DeclareAttribute( "GeneralizedMorphismCategory",
                  IsHomalgCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY" );

DeclareAttribute( "UnderlyingHonestCategory",
                  IsHomalgCategory );

DeclareAttributeWithToDoForIsWellDefined( "GeneralizedMorphismObject",
                                          IsHomalgCategoryObject );

DeclareAttribute( "UnderlyingHonestObject",
                  IsGeneralizedMorphismCategoryObject );

DeclareOperation( "GeneralizedMorphism",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismWithSourceAid",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismWithRangeAid",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareAttributeWithToDoForIsWellDefined( "AsGeneralizedMorphism",
                                          IsHomalgCategoryMorphism );

DeclareOperation( "GeneralizedMorphismFromFactorToSubobject",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

DeclareAttributeWithToDoForIsWellDefined( "HonestRepresentative",
                                          IsGeneralizedMorphism );

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

DeclareProperty( "IsHonest",
                  IsGeneralizedMorphism );

DeclareProperty( "HasHonestSource",
                  IsGeneralizedMorphism );

DeclareProperty( "HasHonestRange",
                  IsGeneralizedMorphism );

DeclareAttribute( "SubcategoryMembershipFunctionForGeneralizedMorphismCategory",
                  IsHomalgCategory );

InstallTrueMethod( IsHonest, HasHonestRange and HasHonestSource );

InstallTrueMethod( HasHonestRange, IsHonest );

InstallTrueMethod( HasHonestSource, IsHonest );


