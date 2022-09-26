# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

# helper
DeclareGlobalFunction( "CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS" );

#! @Description
#!   Hoists expressions which are part of but indepedent of inner functions to outer functions.
#!   Assumes that there are no unused bindings (i.e., you should use <Ref Func="CapJitDroppedUnusedBindings" /> first).
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitHoistedExpressions" );

#! @Description
#!   Hoists bindings which are part of but indepedent of inner functions to outer functions.
#!   Assumes that there are no unused bindings (i.e., you should use <Ref Func="CapJitDroppedUnusedBindings" /> first).
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitHoistedBindings" );
