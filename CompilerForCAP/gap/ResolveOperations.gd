# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Tries to resolve operations in <A>tree</A>:
#!   * Operations of CAP categories are resolved by taking one of the functions added to the category via an `Add` function.
#!   * Operations announced to the compiler via `InstallMethodForCompilerForCAP` or `InstallOtherMethodForCompilerForCAP`
#!     (see the documentation of CAP) are resolved via the number of arguments.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitResolvedOperations" );
