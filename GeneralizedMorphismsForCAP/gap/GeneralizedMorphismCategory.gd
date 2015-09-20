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


DeclareFilter( "HasIdentityAsReversedArrow" );

DeclareCategory( "IsGeneralizedMorphismCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsGeneralizedMorphism",
                 IsCapCategoryMorphism );

DeclareAttributeWithToDoForIsWellDefined( "DomainOp",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "Codomain",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "AssociatedMorphism",
                                          IsGeneralizedMorphism );

DeclareAttribute( "DomainAssociatedMorphismCodomainTriple",
                  IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "HonestRepresentative",
                                          IsGeneralizedMorphism );

