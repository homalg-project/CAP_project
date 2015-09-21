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


DeclareCategory( "IsGeneralizedMorphismCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsGeneralizedMorphism",
                 IsCapCategoryMorphism );

DeclareAttributeWithToDoForIsWellDefined( "DomainOfGeneralizedMorphism",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "Codomain",
                                          IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "AssociatedMorphism",
                                          IsGeneralizedMorphism );

DeclareAttribute( "DomainAssociatedMorphismCodomainTriple",
                  IsGeneralizedMorphism );

DeclareAttributeWithToDoForIsWellDefined( "HonestRepresentative",
                                          IsGeneralizedMorphism );

