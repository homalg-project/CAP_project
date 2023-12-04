# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Drops bindings (and names) of variables in functions in <A>tree</A> which are never referenced.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitDroppedUnusedBindings" );
