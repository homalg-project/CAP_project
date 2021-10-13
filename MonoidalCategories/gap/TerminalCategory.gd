# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

#! @Chapter The terminal category with multiple objects

####################################
#
#! @Section &GAP; Categories
#
####################################

#! @Description
#!  The &GAP; type of a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsTerminalCategoryWithMultipleObjects",
        IsCapCategory );

#! @Description
#!  The &GAP; type of a cell in a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsCellInTerminalCategoryWithMultipleObjects",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; type of an object in a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsObjectInTerminalCategoryWithMultipleObjects",
        IsCellInTerminalCategoryWithMultipleObjects and
        IsCapTerminalCategoryObjectRep );

#! @Description
#!  The &GAP; type of a morphism in a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsMorphismInTerminalCategoryWithMultipleObjects",
        IsCellInTerminalCategoryWithMultipleObjects and
        IsCapTerminalCategoryMorphismRep );

####################################
#
#! @Section Constructors
#
####################################

DeclareGlobalFunction( "CAP_INTERNAL_CONSTRUCTOR_FOR_TERMINAL_CATEGORY" );

#! @Description
#!  Construct a terminal category possibly with multiple objects.
#! @Arguments
DeclareGlobalFunction( "TerminalCategory" );
#! @InsertChunk TerminalCategory

#! @Description
#!  Construct a terminal category with multiple objects.
#! @Arguments
DeclareGlobalFunction( "TerminalCategoryWithMultipleObjects" );
#! @InsertChunk TerminalCategoryWithMultipleObjects
