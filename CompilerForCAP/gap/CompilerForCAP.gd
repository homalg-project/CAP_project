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
#!   Returns a compiled version of the function <A>func</A> with signature <A>type_signature</A> (see <Ref Func="CapJitInferredDataTypes" />).
#!   If <A>func</A> is an operation or a kernel function, it is returned unchanged.
#!   If <A>type_signature</A> is not given, all steps which require knowledge about the types of variables are skipped.
#!   The type signature can also be given by three separate arguments:
#!   a CAP category, a list of input filters (as in `filter_list` in the method name record) and an output filter (as in `return_type` in the method name record).
#!   If a full type signature is not available but the first argument of <A>func</A> is a CAP category, an instance of a CAP category can be given as the second argument.
#!   In this case, the category is used to get the type information required to resolve CAP operations.
#! @Returns a function
#! @Arguments func[, type_signature]
DeclareGlobalFunction( "CapJitCompiledFunction" );

#! @Description
#!   Like <Ref Func="CapJitCompiledFunction" />, but returns an enhanced syntax tree of the compiled function.
#!   <A>func</A> must not be an operation or a kernel function because those cannot properly be represented as a syntax tree.
#! @Returns a record
#! @Arguments func[, type_signature]
DeclareGlobalFunction( "CapJitCompiledFunctionAsEnhancedSyntaxTree" );
