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
#!   Returns a compiled version of the function <A>func</A>.
#!   The arguments <A>jit_args</A> are used to infer the types of variables.
#! @Returns a function
#! @Arguments func, jit_args
DeclareGlobalFunction( "CapJitCompiledFunction" );
