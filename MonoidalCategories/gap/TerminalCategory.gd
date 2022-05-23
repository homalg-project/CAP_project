# SPDX-License-Identifier: GPL-2.0-or-later
# CategoryConstructor: Construct categories out of given ones
#
# Declarations
#

#! @Chapter The category constructor

####################################
#
#! @Section Example
#
####################################

#! This is an example of a category which is created using <C>CategoryConstructor</C>
#! out of no input.

#! This category <Q>lies</Q> in all doctrines and can hence
#! be used (in conjunction with <C>LazyCategory</C>)
#! in order to check the type-correctness of the various derived methods
#! provided by &CAP; or any &CAP;-based package.

#! @Description
#!  The &GAP; type of a terminal category with multiple objects.
#! @Arguments T
DeclareCategory( "IsTerminalCategoryWithMultipleObjects",
        IsCapCategory );

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
