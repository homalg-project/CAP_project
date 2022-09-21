# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Terminal category

########################################
#
#! @Section &GAP; Categories
#
########################################

#! @Description
#!  The &GAP; type of a terminal category.
#! @Arguments T
DeclareCategory( "IsCapTerminalCategoryWithSingleObject",
        IsCapCategory );

#! @Description
#!  The &GAP; type of a cell in a terminal category.
#! @Arguments T
DeclareCategory( "IsCellInCapTerminalCategoryWithSingleObject",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; type of an object in a terminal category.
#! @Arguments T
DeclareCategory( "IsObjectInCapTerminalCategoryWithSingleObject",
        IsCellInCapTerminalCategoryWithSingleObject and
        IsCapCategoryObject );

#! @Description
#!  The &GAP; type of a morphism in a terminal category.
#! @Arguments T
DeclareCategory( "IsMorphismInCapTerminalCategoryWithSingleObject",
        IsCellInCapTerminalCategoryWithSingleObject and
        IsCapCategoryMorphism );

#! @Description
#!  The &GAP; type of a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsCapTerminalCategoryWithMultipleObjects",
        IsCapCategory );

#! @Description
#!  The &GAP; type of a cell in a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsCellInCapTerminalCategoryWithMultipleObjects",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; type of an object in a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsObjectInCapTerminalCategoryWithMultipleObjects",
        IsCellInCapTerminalCategoryWithMultipleObjects and
        IsCapCategoryObject );

#! @Description
#!  The &GAP; type of a morphism in a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsMorphismInCapTerminalCategoryWithMultipleObjects",
        IsCellInCapTerminalCategoryWithMultipleObjects and
        IsCapCategoryMorphism );

AddCategoricalProperty( [ "IsTerminalCategory", "IsTerminalCategory" ] );

########################################
#
#! @Section Constructors
#
########################################

#! @Description
#!  Construct a terminal category.
DeclareGlobalFunction( "TerminalCategory" );
#! @InsertChunk TerminalCategory

#! @Description
#!  Construct a terminal category with multiple objects.
DeclareGlobalFunction( "TerminalCategoryWithMultipleObjects" );
#! @InsertChunk TerminalCategoryWithMultipleObjects

#! @Description
#!  This function takes a record of options suited for CategoryConstructor. 
#!  It makes common adjustments from TerminalCategory and TerminalCategoryWithMultipleObjects
#!  to the list of operations to install and the categorical properties of the given record,
#!  before passing it on to CategoryConstructor.
#! @Arguments options
#! @Returns a &CAP; category
DeclareGlobalFunction( "CAP_INTERNAL_CONSTRUCTOR_FOR_TERMINAL_CATEGORY" );

#########################################
#
#! @Section Attributes
#
#########################################

#! @Description
#!  The unique object in a terminal category.
#! @Returns a &CAP; object
DeclareAttribute( "UniqueObject",
                  IsCapTerminalCategoryWithSingleObject );

#! @Description
#!  The unique morphism in a terminal category.
#! @Returns a &CAP; morphism
DeclareAttribute( "UniqueMorphism",
                  IsCapTerminalCategoryWithSingleObject );

#########################################
##
## Functors
##
#########################################

#! @Description
#!  A functor from a terminal category to another category with a given cell **cell**.
#! @Arguments cell
#! @Returns a &CAP; morphism
DeclareAttribute( "FunctorFromTerminalCategory",
                  IsCapCategoryCell );

#########################################
#
#! @Section Variables
#
#########################################

#! @Description
#!  A terminal category.
DeclareGlobalVariable( "CAP_INTERNAL_TERMINAL_CATEGORY" );

#! @Description
#!  A terminal category as an object in CAT.
DeclareGlobalVariable( "CAP_INTERNAL_TERMINAL_CATEGORY_AS_CAT_OBJECT" );
