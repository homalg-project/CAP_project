# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Terminal category

#########################################
##
## Setup for terminal category
##
#########################################

DeclareGlobalVariable( "CAP_INTERNAL_TERMINAL_CATEGORY_AS_CAT_OBJECT" );

DeclareGlobalVariable( "CAP_INTERNAL_TERMINAL_CATEGORY" );

#########################################
##
## Filter
##
#########################################

DeclareFilter( "IsCapTerminalCategory", IsCapCategory );

DeclareFilter( "IsCapTerminalCategoryObject", IsCapCategoryObject );

DeclareFilter( "IsCapTerminalCategoryMorphism", IsCapCategoryMorphism );

AddCategoricalProperty( [ "IsTerminalCategory", "IsTerminalCategory" ] );

#########################################
##
## Attributes
##
#########################################

DeclareAttribute( "UniqueObject",
                  IsCapTerminalCategory );

DeclareAttribute( "UniqueMorphism",
                  IsCapTerminalCategory );

#########################################
##
## Functors
##
#########################################

DeclareAttribute( "FunctorFromTerminalCategory",
                  IsCapCategoryCell );


