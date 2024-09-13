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
#!  The &GAP; type of a terminal category with a single object.
#! @Arguments T
DeclareCategory( "IsCapTerminalCategoryWithSingleObject",
        IsCapCategory );

#! @Description
#!  The &GAP; type of an object in a terminal category with a single object.
#! @Arguments T
DeclareCategory( "IsObjectInCapTerminalCategoryWithSingleObject",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; type of a morphism in a terminal category with a single object.
#! @Arguments T
DeclareCategory( "IsMorphismInCapTerminalCategoryWithSingleObject",
        IsCapCategoryMorphism );

#! @Description
#!  The &GAP; type of a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsCapTerminalCategoryWithMultipleObjects",
        IsCapCategory );

#! @Description
#!  The &GAP; type of an object in a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsObjectInCapTerminalCategoryWithMultipleObjects",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; type of a morphism in a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsMorphismInCapTerminalCategoryWithMultipleObjects",
        IsCapCategoryMorphism );

#! @Description
#!  The property of the category <A>C</A> being terminal.
#! @Arguments C
DeclareProperty( "IsTerminalCategory", IsCapCategory );

AddCategoricalProperty( [ "IsTerminalCategory", "IsTerminalCategory" ] );

########################################
#
#! @Section Constructors
#
########################################

#! @Description
#!  Construct a terminal category with a single object.
DeclareGlobalFunction( "TerminalCategoryWithSingleObject" );

#! @Description
#!  Construct a terminal category with multiple objects.
DeclareGlobalFunction( "TerminalCategoryWithMultipleObjects" );

#! @Description
#!  This function takes a record of options suited for CategoryConstructor. 
#!  It makes common adjustments for TerminalCategoryWithSingleObject and TerminalCategoryWithMultipleObjects
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
#!  The unique object in a terminal category with a single object.
#! @Returns a &CAP; object
DeclareAttribute( "TerminalCategoryWithSingleObjectUniqueObject",
                  IsCapTerminalCategoryWithSingleObject );

#! @Description
#!  The unique morphism in a terminal category with a single object.
#! @Returns a &CAP; morphism
DeclareAttribute( "TerminalCategoryWithSingleObjectUniqueMorphism",
                  IsCapTerminalCategoryWithSingleObject );

#########################################
##
## Functors
##
#########################################

#! @Description
#!  A functor from `AsCapCategory( TerminalObject( CapCat ) )` mapping the unique object to <A>object</A>.
#! @Arguments object
#! @Returns a &CAP; functor
DeclareAttribute( "FunctorFromTerminalCategory",
                  IsCapCategoryObject );
