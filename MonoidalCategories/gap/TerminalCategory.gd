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

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Construct a terminal category with multiple objects.
#! @Arguments
DeclareGlobalFunction( "TerminalCategoryWithMultipleObjects" );
#! @InsertChunk TerminalCategoryWithMultipleObjects

#! @Description
#!  Create an object $a$ in the terminal category <A>T</A> with multiple objects
#!  with <C>String</C>(<A>str</A>) = $a$.
#! @Arguments T, str
DeclareOperation( "/",
        [ IsString, IsTerminalCategoryWithMultipleObjects ] );
