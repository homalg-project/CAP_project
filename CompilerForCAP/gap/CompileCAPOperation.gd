# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Using the compiler

#! @Section Compiling a function manually

#! @Description
#!   A special version of <Ref Func="CapJitCompiledFunctionAsEnhancedSyntaxTree" /> compiling the operation
#!   given by <A>operation_name</A> in <A>cat</A>. `jit_args` are constructed by taking `ZeroObject` and
#!   `ZeroMorphism` if possible.
#! @Arguments cat, operation_name
DeclareGlobalFunction( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree" );
