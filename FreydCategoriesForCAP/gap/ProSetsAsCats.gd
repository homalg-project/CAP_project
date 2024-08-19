# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Prosets as categories

####################################
##
#! @Section GAP Categories
##
####################################

##
DeclareCategory( "IsProSetAsCategoryObject",
                 IsCapCategoryObject );

DeclareCategory( "IsProSetAsCategoryMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsProSetAsCategory",
                 IsCapCategory );

DeclareGlobalFunction( "PRO_SET_AS_CATEGORY_SANITY_CHECK" );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_PROSET_AS_CATEGORY" );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "ProSetAsCategory",
                  [ IsList ] );

DeclareOperation( "ProSetAsCategoryObject",
                  [ IsInt, IsProSetAsCategory ] );

DeclareOperation( "ProSetAsCategoryMorphism",
                  [ IsProSetAsCategoryObject, IsProSetAsCategoryObject ] );

DeclareOperation( "ProSetAsCategoryMorphism",
                  [ IsInt, IsInt, IsProSetAsCategory ] );

####################################
##
#! @Section Attributes
##
####################################

DeclareAttribute( "UnderlyingInteger",
                  IsProSetAsCategoryObject );

DeclareAttribute( "IncidenceMatrix",
                  IsProSetAsCategory );

DeclareAttribute( "Size",
                  IsProSetAsCategory );

####################################
##
#! @Section Operations
##
####################################

##
DeclareOperation( "*",
                  [ IsProSetAsCategoryMorphism, IsProSetAsCategoryMorphism ] );

##
DeclareOperation( "/",
                  [ IsInt, IsProSetAsCategory ] );
