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
                 IsCapCategoryObject );

DeclareCategory( "IsGeneralizedMorphismByCospan",
                 IsCapCategoryMorphism );

####################################
##
## Technical stuff
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_COSPANS" );

DeclareFilter( "WasCreatedAsGeneralizedMorphismCategoryByCospans" );

####################################
##
## Attributes
##
####################################

DeclareProperty( "IsHonest",
                  IsGeneralizedMorphismByCospan );

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

DeclareAttribute( "NormalizedCospan",
                  IsGeneralizedMorphismByCospan );

####################################
##
## Constructors
##
####################################

DeclareOperation( "GeneralizedMorphismByCospan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareAttribute( "AsGeneralizedMorphismByCospan",
                  IsCapCategoryMorphism );

DeclareAttribute( "GeneralizedMorphismCategoryByCospans",
                  IsCapCategory );

DeclareAttribute( "GeneralizedMorphismByCospansObject",
                  IsCapCategoryObject );


