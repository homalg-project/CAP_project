# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

DeclareGlobalFunction( "CAP_JIT_INTERNAL_CONDITION_IMPLIES_CONDITION" );

#! @Description
#!   Idea: If the same edge case is handled multiple times in the tree by checking
#!   a condition and returning a value, all condition checks except the first can be dropped.
#!   Details: Keeps a record of conditions which immediately lead to a return,
#!   i.e., statements of the form `if condition1 then return value; fi;`. If another statement of the
#!   form `if condition2 then return value; fi;` is found later in the tree and if `condition2 = true`
#!   implies `condition1 = true`, the second statement is dropped.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitDroppedHandledEdgeCases" );
