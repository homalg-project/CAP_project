# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Using the compiler

#! @Section Stopping the compiler at a certain level

#! @Description
#!   Stops the compiler from inlining and optimizing code of <A>category</A>.
#! @Arguments category
DeclareGlobalFunction( "StopCompilationAtCategory" );

#! @Description
#!   Allows the compiler to inline and optimize code of <A>category</A> (this is the default).
#! @Arguments category
DeclareGlobalFunction( "ContinueCompilationAtCategory" );

#! @Section Getting information about the compilation process

#! @Description
#!   Info class used for info messsages of the CAP compiler.
DeclareInfoClass( "InfoCapJit" );

#! @Section Compiling a function manually

#! @Description
#!   Returns a compiled version of the function <A>func</A> (if <A>func</A> is an operation or a kernel function, it is returned unchanged).
#!   The list of arguments <A>jit_args</A> is used to infer the types of variables.
#!   If <A>jit_args</A> is shorter than the number of arguments accepted by <A>func</A>,
#!   all steps which require knowledge about the types of variables are skipped.
#!   If the first entry of <A>jit_args</A> is a CAP category, this category is used to get the type
#!   information required to resolve CAP operations.
#! @Returns a function
#! @Arguments func, jit_args
DeclareGlobalFunction( "CapJitCompiledFunction" );

#! @Description
#!   Like <Ref Func="CapJitCompiledFunction" />, but returns an enhanced syntax tree of the compiled function.
#!   <A>func</A> must not be an operation or a kernel function because those cannot properly be represented as a syntax tree.
#! @Returns a record
#! @Arguments func, jit_args
DeclareGlobalFunction( "CapJitCompiledFunctionAsEnhancedSyntaxTree" );
