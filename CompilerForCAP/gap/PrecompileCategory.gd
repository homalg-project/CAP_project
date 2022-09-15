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
#!   Else all installed operations (excluding operations which are part of suggested dependencies) of the category are precompiled.
#!   Furthermore, the options `number_of_objectified_objects_in_data_structure_of_object`, `number_of_objectified_morphisms_in_data_structure_of_object`,
#!   `number_of_objectified_objects_in_data_structure_of_morphism`, and `number_of_objectified_morphisms_in_data_structure_of_morphism` can optionally be set to allow the compiler
#!   to warn about about bad compilation results. For example, `number_of_objectified_objects_in_data_structure_of_object` should be the number of calls to `CreateCapCategoryObjectWithAttributes`
#!   required for creating an object in the tower defined by <A>category_constructor</A>, e.g. 1 if the tower has height one, or 2 if the tower has height two and the objects of the category at the top are given by
#!   objects in the category one level below. Warnings will be displayed if this number is exceeded (because this implies that not all wrap-unwrap-pairs could be canceled).
#!   Technical requirements:
#!     * <A>category_constructor</A> must be a regular function, i.e. not an operation or a kernel function.
#!     * <A>category_constructor</A> must support the option `FinalizeCategory`.
#!       WARNING: When using attributes you might run into errors because the options are only respected the first time you call the attribute getter.
#!       To catch such a situation, <A>category_constructor</A> is applied to <A>given_arguments</A> twice and if the results are identical (`IsIdenticalObj`)
#!       an error is raised.
#!     * CAP operations returning `fail` are excluded from the compilation because they usually do not fulfill all requirements of the compiler.
#! @Arguments category_constructor, given_arguments, package_name, compiled_category_name
DeclareGlobalFunction( "CapJitPrecompileCategory" );

#! @Description
#!   Calls <Ref Func="CapJitPrecompileCategory" /> with the given arguments and displays a warning if this changes the contents of
#!   <A>package_name</A>`/precompiled_categories/`<A>compiled_category_name</A>`.gi`.
#! @Arguments category_constructor, given_arguments, package_name, compiled_category_name
DeclareGlobalFunction( "CapJitPrecompileCategoryAndCompareResult" );
