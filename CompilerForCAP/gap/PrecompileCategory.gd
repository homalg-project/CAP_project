# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Using the compiler

#! @Section Precompiling categories

#! @Description
#!   Compiles operations of the CAP category returned by the function <A>category_constructor</A> applied to <A>given_arguments</A>.
#!   The result is available via a global function called <A>compiled_category_name</A> which is written to the file <A>package_name</A>`/precompiled_categories/`<A>compiled_category_name</A>`.gi`.
#!   The global function takes the same arguments as <A>category_constructor</A> and returns the category with the compiled functions installed as primitive operations.
#!   If a list of operations is given via the option `operations`, only operations in this list are precompiled.
#!   Else all installed operations of the category are precompiled.
#!   Technical requirements:
#!     * <A>category_constructor</A> must be a regular function, i.e. not an operation or a kernel function.
#!     * <A>category_constructor</A> must support the options `FinalizeCategory` and `enable_compilation`.
#!       WARNING: When using attributes you might run into errors because the options are only respected the first time you call the attribute getter.
#!       To catch such a situation, <A>category_constructor</A> is applied to <A>given_arguments</A> twice and if the results are identical (`IsIdenticalObj`)
#!       an error is raised.
#!     * The compiler has to create a valid input for the operations which should be compiled. Currently, this leads to the following restrictions
#!       (detailed errors are thrown if any of the restrictions is not met):
#!       * Only categories with a zero object and zero morphisms can be compiled.
#!       * Not all CAP operations are available for compilation.
#!       * `WithGiven` operations can only be compiled if the object operation is computable.
#! @Returns a record
#! @Arguments category_constructor, given_arguments, package_name, compiled_category_name
DeclareGlobalFunction( "CapJitPrecompileCategory" );
