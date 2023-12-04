# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Example: transforms `(function(x) return x; end)(1)` into `(function() local x; x := 1; return x; end)()`.
#!   Details: Searches for function calls of resolved functions. Assigns the argument values to local variables
#!   at the beginning of the function, and drops the arguments (i.e., makes the function a 0-ary function).
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitInlinedArguments" );
