# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

DeclareGlobalFunction( "CAP_JIT_INTERNAL_FUNCTION_CAN_BE_INLINED" );
DeclareGlobalFunction( "CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID" );

#! @Description
#!   Example: transforms `function() local x; x := (y -> y + 2)(1); return x; end` into
#!            `function() local x, y, r; y := 1; r := y + 2; x := r; return x; end`.
#!   Details: Searches for function calls of a resolved function in the right hand side of a variable assignment
#!   or a return statement. Inserts the body of the function right before the variable assignment / return statement
#!   to avoid the function call.
#!   Assumes that arguments of function calls are inlined (i.e., you should use <Ref Func="CapJitInlinedArguments" /> first).
#!   Due to the nature of a `return` statement breaking the execution and having no `goto` keyword in GAP, only
#!   functions
#!   * ending with a `return` statement, or
#!   * ending with an if-(elif)-else-statement with `return` statements at the end of all branches
#!
#!   and not containing other `return` statements can be inlined.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitInlinedFunctionCalls" );
