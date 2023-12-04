# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Resolves global variables (except those which are listed in `CAP_JIT_NON_RESOLVABLE_GLOBAL_VARIABLE_NAMES`):
#!   * Replaces a global variable referencing a plain function by the syntax tree of this function in case the function is annotated with the pragma `CAP_JIT_RESOLVE_FUNCTION`.
#!   * Computes attributes of categories stored in global variables and places the results into global variables again.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitResolvedGlobalVariables" );
