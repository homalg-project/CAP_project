#
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Replaces function calls of the form `(function() return value; end)()` by `value`.
#!   Assumes that arguments of function calls are inlined (i.e., you should use <Ref Func="CapJitInlinedArguments" /> first).
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitInlinedSimpleFunctionCalls" );
