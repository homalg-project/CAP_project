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

DeclareGlobalName( "CAP_INTERNAL_TERMINAL_CATEGORY" );

DeclareGlobalName( "CAP_INTERNAL_TERMINAL_CATEGORY_AS_CAT_OBJECT" );

####################################
##
## Constructor
##
####################################

DeclareGlobalName( "CAP_INTERNAL_CREATE_TerminalCategory" );

DeclareGlobalName( "INSTALL_TERMINAL_CATEGORY_FUNCTIONS" );

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


