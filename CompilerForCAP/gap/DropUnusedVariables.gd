# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Drops assignments to local variables which are never referenced. If a path to a function
#!   is given as the second argument, only variables in this function are considered. Otherwise,
#!   all functions in <A>tree</A> are considered.
#!   Marks unused variables with the prefix _UNUSED_. Assumes that arguments of function calls
#!   are inlined (i.e., you should use <Ref Func="CapJitInlinedArguments" /> first).
#! @Returns a record
#! @Arguments tree[, func_path]
DeclareGlobalFunction( "CapJitDroppedUnusedVariables" );
