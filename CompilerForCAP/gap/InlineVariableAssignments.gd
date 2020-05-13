#! @Chapter Improving and extending the compiler

#! @Section Compilation steps

#! @Description
#!   Example: transforms `function() local x; x := 1; return x^2; end` into `function() return 1^2; end()`.
#!   Details: Searches for local variable assigments. Replace all references to the local variable in the same
#!   STAT_SEQ_STAT as the assignment by the right-hand side of the assignment.
#!   If the second argument is set to `true`, this is only done if the right-hand side is a reference to a global variable.
#!   Assumes that any local variable is assigned at most once (this includes function arguments, which are assigned at least once,
#!   namely when the function is called). An exception is made for "rapid reassignments": if the same variable is assigned
#!   and then reassigned immediately in the next statement, the right-hand side of the first assignment is inserted
#!   into the right-hand side of the second assignment.
#!   Assumes that unused variables are dropped (i.e., you should use <Ref Func="CapJitDroppedUnusedVariables" /> first).
#!   Drops the variables assignment after inlining if possible.
#! @Returns a record
#! @Arguments tree[, inline_gvars_only]
DeclareGlobalFunction( "CapJitInlinedVariableAssignments" );
