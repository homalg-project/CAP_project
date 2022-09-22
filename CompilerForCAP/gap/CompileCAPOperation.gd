# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Using the compiler

#! @Section Compiling a function manually

#! @Description
#!   A special version of <Ref Func="CapJitCompiledFunctionAsEnhancedSyntaxTree" /> compiling the operation
#!   given by <A>operation_name</A> in <A>cat</A>. The boolean <A>post_processing_enabled</A> decides
#!   whether the tree before or after post-processing should be returned.
#! @Arguments cat, operation_name, post_processing_enabled
DeclareGlobalFunction( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree" );
