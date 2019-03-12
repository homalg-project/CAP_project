#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#! @Chapter Adelman category
#!
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsAdelmanCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsAdelmanCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsAdelmanCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_ADELMAN_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareAttribute( "AdelmanCategory",
                  IsCapCategory );

DeclareOperation( "AdelmanCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AdelmanCategoryMorphism",
                  [ IsAdelmanCategoryObject, IsCapCategoryMorphism, IsAdelmanCategoryObject ] );

DeclareAttribute( "AsAdelmanCategoryObject",
                  IsCapCategoryObject );

DeclareAttribute( "AsAdelmanCategoryMorphism",
                  IsCapCategoryMorphism );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsAdelmanCategory );

DeclareAttribute( "RelationMorphism",
                  IsAdelmanCategoryObject );

DeclareAttribute( "CorelationMorphism",
                  IsAdelmanCategoryObject );

DeclareAttribute( "MorphismDatum",
                  IsAdelmanCategoryMorphism );

DeclareAttribute( "RelationWitness",
                  IsAdelmanCategoryMorphism );

DeclareAttribute( "CorelationWitness",
                  IsAdelmanCategoryMorphism );

DeclareAttribute( "WitnessPairForBeingCongruentToZero",
                  IsAdelmanCategoryMorphism );

DeclareOperation( "HomomorphismStructureOnObjectsForAdelmanCategoryGeneralizedEmbedding",
                  [ IsAdelmanCategoryObject, IsAdelmanCategoryObject ] );
