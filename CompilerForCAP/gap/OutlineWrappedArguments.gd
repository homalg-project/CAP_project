# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Outlines wrapped arguments to local variables. This includes:
#!     * the attribute value(s) in `CreateCapCategoryObjectWithAttributes` and `AsCapCategoryObject`
#!     * the attribute values (including the arguments `source` and `range`) in `CreateCapCategoryMorphismWithAttributes` and `AsCapCategoryMorphism`
#!     * the arguments of `NTuple` (excluding the first argument)
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitOutlinedWrappedArguments" );
