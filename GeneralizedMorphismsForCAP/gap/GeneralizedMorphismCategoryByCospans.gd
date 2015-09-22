#############################################################################
##
##                  GeneralizedMorphismsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Generalized morphism category
##
#############################################################################

DeclareCategory( "IsGeneralizedMorphismCategoryByCospansObject",
                 IsGeneralizedMorphismCategoryObject );

DeclareCategory( "IsGeneralizedMorphismByCospan",
                 IsGeneralizedMorphism );

####################################
##
## Technical stuff
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_COSPANS" );

DeclareFilter( "WasCreatedAsGeneralizedMorphismCategoryByCospans" );

DeclareProperty( "HasIdentityAsReversedArrow",
                 IsGeneralizedMorphismByCospan );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "Arrow",
                  IsGeneralizedMorphismByCospan );

DeclareAttribute( "ReversedArrow",
                  IsGeneralizedMorphismByCospan );

DeclareAttribute( "NormalizedCospanTuple",
                  IsGeneralizedMorphismByCospan );

DeclareAttribute( "PseudoInverse",
                  IsGeneralizedMorphismByCospan );

DeclareAttribute( "GeneralizedInverseByCospan",
                  IsCapCategoryMorphism );

DeclareAttribute( "IdempotentDefinedBySubobjectByCospan",
                  IsCapCategoryMorphism );

DeclareAttribute( "IdempotentDefinedByFactorobjectByCospan",
                  IsCapCategoryMorphism );

DeclareAttribute( "NormalizedCospan",
                  IsGeneralizedMorphismByCospan );

####################################
##
## Constructors
##
####################################

DeclareOperation( "GeneralizedMorphismFromFactorToSubobjectByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

####################################
##
## Constructors
##
####################################

DeclareOperation( "GeneralizedMorphismByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismByCospanWithSourceAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareAttribute( "AsGeneralizedMorphismByCospan",
                  IsCapCategoryMorphism );

DeclareAttribute( "GeneralizedMorphismCategoryByCospans",
                  IsCapCategory );

DeclareAttribute( "GeneralizedMorphismByCospansObject",
                  IsCapCategoryObject );


