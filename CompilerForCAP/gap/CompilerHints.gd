# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Applies compiler hints (see <Ref Sect="Section_CompilerHints" />) to <A>tree</A>.
#!   Depending on <A>apply_irreversible_optimizations</A>, only reversible optimizations or all optimizations are applied.
#! @Returns a record
#! @Arguments tree, category, apply_irreversible_optimizations
DeclareGlobalFunction( "CapJitAppliedCompilerHints" );

#! @Description
#!   Applies the compiler hint `category_attribute_names` (see <Ref Sect="Section_CompilerHints" />) to <A>tree</A>.
#!   Assumes that <A>category</A> is the first argument of the function defined by <A>tree</A>.
#! @Returns a record
#! @Arguments tree, category
DeclareGlobalFunction( "CapJitReplacedGlobalVariablesByCategoryAttributes" );

#! @Description
#!   Applies the compiler hint `source_and_range_attributes_from_morphism_attribute` (see <Ref Sect="Section_CompilerHints" />) to <A>tree</A>.
#! @Returns a record
#! @Arguments tree, category
DeclareGlobalFunction( "CapJitReplacedSourceAndRangeAttributes" );
