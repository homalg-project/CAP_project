#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#! @Chapter Freyd category
#!
#############################################################################

####################################
##
#! @Section GAP Categories
##
####################################

DeclareCategory( "IsFreydCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsFreydCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsFreydCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_FREYD_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareAttribute( "FreydCategory",
                  IsCapCategory );

DeclareAttribute( "FreydCategoryObject",
                  IsCapCategoryMorphism );

DeclareOperation( "FreydCategoryMorphism",
                  [ IsFreydCategoryObject, IsCapCategoryMorphism, IsFreydCategoryObject ] );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsFreydCategory );

DeclareAttribute( "RelationMorphism",
                  IsFreydCategoryObject );

DeclareAttribute( "MorphismDatum",
                  IsFreydCategoryMorphism );

DeclareAttribute( "MorphismWitness",
                  IsFreydCategoryMorphism );
