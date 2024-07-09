# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
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
#!   * `IsNTuple` with additional component `element_types`: The types of the elements of the tuple.
#!   * filters implying `IsRing`, `IsRingElement`, `IsHomalgMatrix` with additional component `ring`:
#!     The ring instance (to which the element or matrix belongs).
#!     Exception: If the filter `IsInt` describes a ``technical'' integer (e.g. an index) and not an integer used in a mathematical context, the component `ring` should not be set.
#!   * filters implying `IsCapCategory`, `IsCapCategoryObject`, `IsCapCategoryMorphism`, or `IsCapCategoryTwoCell` with additional component `category`:
#!     The category instance (to which the object, morphism or two cell belongs).
#!   WARNING: `IsString` implies `IsList`, so when creating a data type with filter implying `IsString` one must set `element_type` to
#!   a data type with filter `IsChar`, or use `IsStringRep` instead of `IsString`.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitInferredDataTypes" );

# helpers
DeclareGlobalFunction( "CAP_JIT_INTERNAL_GET_DATA_TYPE_OF_VALUE" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_GET_OUTPUT_TYPE_OF_GLOBAL_FUNCTION_BY_INPUT_TYPES" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES_OF_FUNCTION_BY_ARGUMENTS_TYPES" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_INFERRED_DATA_TYPES" );
