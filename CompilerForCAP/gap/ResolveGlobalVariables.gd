#
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Resolves global variables:
#!   * Replaces a global variable referencing an integer, a string, or a boolean by EXPR_INT, EXPR_STRING, EXPR_TRUE or EXPR_FALSE.
#!   * Replaces a global variable referencing a plain function by the syntax tree of this function.
#!   * Replaces a record access of a global function by the value of this record access.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitResolvedGlobalVariables" );
