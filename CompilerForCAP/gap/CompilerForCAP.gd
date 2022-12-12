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

#! @Description
#!   Stops the compiler from inlining and optimizing code of primitively installed operations of <A>category</A>.
#!   Warning: Due to caching of compiled CAP operations, this has to be called before any compilation involving <A>category</A>.
#! @Arguments category
DeclareGlobalFunction( "StopCompilationAtPrimitivelyInstalledOperationsOfCategory" );

#! @Description
#!   Allows the compiler to inline and optimize code of primitively installed operations of <A>category</A> (this is the default).
#! @Arguments category
DeclareGlobalFunction( "ContinueCompilationAtPrimitivelyInstalledOperationsOfCategory" );

#! @Section Disabling the automatic inference of data types

#! @BeginGroup
#! @Description
#!   In case of errors, the automatic inference of data types can be disabled (and re-enabled later on).
#! @Arguments
DeclareGlobalFunction( "CapJitDisableDataTypeInference" );
#! @Arguments
DeclareGlobalFunction( "CapJitEnableDataTypeInference" );
#! @EndGroup

#! @Section Compiling step-by-step

#! @BeginGroup
#! @Description
#!   Enables or disables step-by-step compilation for demonstration or debugging purposes.
#!   If enabled, only the first level of CAP operations and known methods is resolved (instead of resolving recursively).
#!   Caveats:
#!     * This does not work if fully compiled operations are already cached, so this should be used before starting any compilation.
#!     * This does not work if the CAP category is not immediately available from the input (e.g. because it is a range category of a homomorphism structure of the input category).
#! @Arguments
DeclareGlobalFunction( "CapJitEnableStepByStepCompilation" );
#! @Arguments
DeclareGlobalFunction( "CapJitDisableStepByStepCompilation" );
#! @EndGroup

#! @Section Getting information about the compilation process

#! @Description
#!   Info class used for info messsages of the CAP compiler.
DeclareInfoClass( "InfoCapJit" );

DeclareGlobalName( "CAP_JIT_INTERNAL_DEBUG_LEVEL" );
CAP_JIT_INTERNAL_DEBUG_LEVEL := 0;

#! @Description
#!   Set the debug level. At level 0, no debug information is printed. At level 1 (or higher), compiled functions are printed at the beginning of the compilation,
#!   before the resolving phase, before the rule phase, before the post-processing starts, and at the end of the compilation. At level 2 (or higher), compiled functions
#!   are printed after every compilation step. These levels are not fixed and may change in the future.
#! @Arguments level
DeclareGlobalFunction( "CapJitSetDebugLevel" );

#! @Section Compiling a function manually

#! @Description
#!   Returns a compiled version of the function <A>func</A> with signature <A>type_signature</A> (see <Ref Func="CapJitInferredDataTypes" />).
#!   If <A>func</A> is an operation or a kernel function, it is returned unchanged.
#!   If <A>type_signature</A> is not given, all steps which require knowledge about the types of variables are skipped.
#!   If the first argument of <A>func</A> is a CAP category, the type signature can also be given by three separate arguments:
#!   an instance of a CAP category, a list of input filters (as in `filter_list` in the method name record) and an output filter (as in `return_type` in the method name record).
#!   If a full type signature is not available but the first argument of <A>func</A> is a CAP category, an instance of a CAP category can be given as the second argument.
#!   In this case, the category is used to get the type information required to resolve CAP operations.
#! @Returns a function
#! @Arguments func[, type_signature]
DeclareGlobalFunction( "CapJitCompiledFunction" );

#! @Description
#!   Like <Ref Func="CapJitCompiledFunction" />, but returns an enhanced syntax tree of the compiled function.
#!   <A>func</A> must not be an operation or a kernel function because those cannot properly be represented as a syntax tree.
#!   <A>post_processing</A> can be one of the following strings:
#!   * `"with_post_processing"`: The post-processing step, e.g. the application of compiler hints, is executed.
#!   * `"without_post_processing"`: The post-processing step is not executed.
#!   * `"with_and_without_post_processing"`: A pair of trees is returned: The second tree with post-processing applied, the first tree without.
#! @Returns a record
#! @Arguments func, post_processing[, type_signature]
DeclareGlobalFunction( "CapJitCompiledFunctionAsEnhancedSyntaxTree" );
