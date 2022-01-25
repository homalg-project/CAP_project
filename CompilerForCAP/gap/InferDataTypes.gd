# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Adds a type signature for the global function or operation given by <A>name</A>.
#!   <A>input_filters</A> must be a list of filters.
#!   <A>output_data_type</A> must be a filter, a data type, or a function accepting
#!   the arguments of a function call of <A>name</A> (as syntax trees) and the function stack and
#!   returning a record with components `args` (the possibly modified arguments) and `output_type`
#!   (the data type of the output).
#!   See <Ref Func="CapJitIterateOverTree" /> for more details on data types.
#! @Arguments name, input_filters, output_data_type
DeclareGlobalFunction( "CapJitAddTypeSignature" );

#! @Description
#!   Tries to infer the data types of expressions in <A>tree</A> and attaches it as component `data_type`.
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
DeclareGlobalFunction( "CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_FILTERS" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_WITH_INITIAL_FUNC_STACK" );
