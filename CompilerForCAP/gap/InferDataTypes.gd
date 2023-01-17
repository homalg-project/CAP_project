# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Tries to infer the data types of expressions in the enhanced syntax tree <A>tree</A> of a function with data types.
#!   A data type is a record with component `filter` (a GAP filter) and, depending on the filter, additional components:
#!   * `IsFunction` with additional component `signature`: The signature is a list with two entries. The first entry is a list of data types
#!     of the inputs, the second entry is the data type of the output.
#!   * `IsList` with additional component `element_type`: The type of the elements of the list. Only homogeneous lists are supported.
#!   * filters implying `IsCapCategory`, `IsCapCategoryObject` or `IsCapCategoryMorphism` with additional component `category`:
#!     The category instance (to which the object or morphism belongs).
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitInferredDataTypes" );

# helpers
DeclareGlobalFunction( "CAP_JIT_INTERNAL_LOAD_DEFERRED_GLOBAL_VARIABLE_FILTERS" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_GET_DATA_TYPE_OF_VALUE" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_LOAD_DEFERRED_TYPE_SIGNATURES" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES" );
