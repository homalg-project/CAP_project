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

####################################
##
## Attributes
##
####################################

DeclareAttribute( "IsHonest",
                  IsGeneralizedMorphismByCospan );

DeclareAttribute( "Arrow",
                  IsGeneralizedMorphismByCospan );

DeclareAttribute( "ReverseArrow",
                  IsGeneralizedMorphismByCospan );

DeclareAttribute( "NormalizedCospanTuple",
                  IsGeneralizedMorphismByCospan );

DeclareAttribute( "PseudoInverse",
                  IsGeneralizedMorphismByCospan );

DeclareAttribute( "GeneralizedInverseByCospan",
                  IsCapCategoryMorphism );

####################################
##
## Constructors
##
####################################