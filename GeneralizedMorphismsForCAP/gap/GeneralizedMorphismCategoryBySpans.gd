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

DeclareCategory( "IsGeneralizedMorphismCategoryBySpansObject",
                 IsGeneralizedMorphismCategoryObject );

DeclareCategory( "IsGeneralizedMorphismBySpan",
                 IsGeneralizedMorphism );

####################################
##
## Technical stuff
##
####################################

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_SPANS" );

DeclareFilter( "WasCreatedAsGeneralizedMorphismCategoryBySpans" );

DeclareProperty( "HasIdentityAsReversedArrow",
                 IsGeneralizedMorphismBySpan );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "Arrow",
                  IsGeneralizedMorphismBySpan );

DeclareAttribute( "ReversedArrow",
                  IsGeneralizedMorphismBySpan );

DeclareAttribute( "NormalizedSpanTuple",
                  IsGeneralizedMorphismBySpan );

DeclareAttribute( "PseudoInverse",
                  IsGeneralizedMorphismBySpan );

DeclareAttribute( "GeneralizedInverseBySpan",
                  IsCapCategoryMorphism );

DeclareAttribute( "IdempotentDefinedBySubobjectBySpan",
                  IsCapCategoryMorphism );

DeclareAttribute( "IdempotentDefinedByFactorobjectBySpan",
                  IsCapCategoryMorphism );

DeclareAttribute( "NormalizedSpan",
                  IsGeneralizedMorphismBySpan );

####################################
##
## Constructors
##
####################################

DeclareOperation( "GeneralizedMorphismFromFactorToSubobjectBySpan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

####################################
##
## Constructors
##
####################################

DeclareOperation( "GeneralizedMorphismBySpan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismBySpan",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "GeneralizedMorphismBySpanWithRangeAid",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareAttribute( "AsGeneralizedMorphismBySpan",
                  IsCapCategoryMorphism );

DeclareAttribute( "GeneralizedMorphismCategoryBySpans",
                  IsCapCategory );

DeclareAttribute( "GeneralizedMorphismBySpansObject",
                  IsCapCategoryObject );


