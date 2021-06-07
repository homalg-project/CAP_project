# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

# helper function
DeclareGlobalFunction( "CapJitGetCapCategoryFromArguments" );

#! @Description
#!   Tries to resolve operations in <A>tree</A>:
#!   * The attribute `CapCategory` is resolved by computing the category using <A>jit_args</A> and storing it in a global variable.
#!   * Operations of CAP categories are resolved by taking one of the functions added to the category via an `Add` function.
#!   * Operations announced to the compiler via `InstallMethodForCompilerForCAP` or `InstallOtherMethodForCompilerForCAP`
#!     (see the documentation of CAP) are resolved via the number of arguments.
#!   * Other operations are resolved by considering applicable methods of the operation with regard to arguments infered
#!     from <A>jit_args</A>, except if the operation is listed in `CAP_JIT_NON_RESOLVABLE_OPERATION_NAMES`.
#!     Only methods annotated with the pragma `CAP_JIT_RESOLVE_FUNCTION` are resolved.
#!
#!   If the arguments of the operation cannot be infered from <A>jit_args</A>, the operation is not resolved.
#! @Returns a record
#! @Arguments tree, jit_args
DeclareGlobalFunction( "CapJitResolvedOperations" );
