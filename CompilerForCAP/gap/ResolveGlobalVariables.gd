# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Resolves global variables (except those which are listed in `CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES`):
#!   * Replaces a global variable referencing an integer, a string, or a boolean by EXPR_INT, EXPR_STRING, EXPR_TRUE or EXPR_FALSE.
#!   * Replaces a global variable referencing a plain function by the syntax tree of this function in case the function is annotated with the pragma `CAP_JIT_RESOLVE_FUNCTION`.
#!   * Replaces a record access of a global function by the value of this record access.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitResolvedGlobalVariables" );
