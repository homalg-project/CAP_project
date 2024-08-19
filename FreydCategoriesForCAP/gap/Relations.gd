# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Category of relations

####################################
##
#! @Section GAP Categories
##
####################################

##
DeclareCategory( "IsRelCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsRelCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsRelCategory",
                 IsCapCategory );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_RELATIONS_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "RelCategory",
                  [ IsCapCategory ] );

DeclareOperation( "RelCategoryObject",
                  [ IsCapCategoryObject, IsRelCategory ] );

DeclareOperation( "RelCategoryMorphism",
                  [ IsRelCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsRelCategoryObject ] );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingCategory",
                  IsRelCategory );

DeclareAttribute( "UnderlyingOriginalObject",
                  IsRelCategoryObject );

DeclareAttribute( "Arrow",
                  IsRelCategoryMorphism );

DeclareAttribute( "ReversedArrow",
                  IsRelCategoryMorphism );

DeclareAttribute( "AssociatedSubobject",
                  IsRelCategoryMorphism );

DeclareAttribute( "PseudoInverse",
                  IsRelCategoryMorphism );

####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "/",
                  [ IsCapCategoryObject, IsRelCategory ] );

##
DeclareOperation( "/",
                  [ IsCapCategoryMorphism, IsRelCategory ] );

##
DeclareOperation( "/",
                  [ IsRelCategory, IsCapCategoryMorphism ] );
