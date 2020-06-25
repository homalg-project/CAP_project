#! @Chapter Improving and extending the compiler

#! @Section Tools

#! @Description
#!   Checks if <A>tree</A> is an EXPR_FUNCCALL with `funcref` EXPR_GVAR such that `gvar` fulfills <A>condition</A>.
#!   If <A>condition</A> is a string, `gvar` must be equal to the string.
#!   Othwerwise, <A>condition</A> must be a function returning a boolean when applied to `gvar`.
#! @Returns a boolean
#! @Arguments tree, condition
DeclareGlobalFunction( "CapJitIsCallToGlobalFunction" );

#! @Description
#!   Can be used as a `result_func` for <Ref Func="CapJitIterateOverTree" />.
#!   Replaces <A>tree</A>`.(key)` (resp. <A>tree</A>`[key]`) by <A>result</A>`.(key)` (resp. <A>result</A>`[key]`) for all
#!   keys of children of <A>tree</A> and returns the result. See <Ref Func="CapJitIterateOverTree" /> for more details.
#! @Returns a list or a record
#! @Arguments tree, result, additional_arguments
DeclareGlobalFunction( "CapJitResultFuncCombineChildren" );

#! @Description
#!  Checks if <A>tree</A> contains an FVAR which references a function outside of its function stack.
#!  Such a tree is not well-defined.
#! @Returns a boolean
#! @Arguments tree
DeclareGlobalFunction( "CapJitContainsRefToFVAROutsideOfFuncStack" );

#! @Description
#!   Assigns <A>value</A> to a global variable and returns the name of the global variable.
#!   If <A>value</A> has already been assigned to a global variable by this function before,
#!   simply returns the name of that global variable.
#! @Returns a string
#! @Arguments value
DeclareGlobalFunction( "CapJitGetOrCreateGlobalVariable" );

#! @Description
#!   Checks if <A>tree</A> contains statements or expressions indicating side effects. If yes, it throws an error.
#!   The following checks are performed:
#!     * <A>tree</A> must be an enhanced syntax tree. In particular, it may not contain LVARs or HVARs.
#!     * The following statements and expressions are forbidden: STAT_ASS_GVAR, EXPR_ISB_GVAR, STAT_UNB_GVAR,
#!         EXPR_ISB_FVAR, EXPR_UNB_FVAR, STAT_PROCCALL.
#!     * An FVAR must not reference functions outside of its function stack (see also <Ref Func="CapJitContainsRefToFVAROutsideOfFuncStack" />).
#!     * An FVAR must be assigned at most once (this includes function arguments, which are assigned at least once,
#!         namely when the function is called). An exception is made for "rapid reassignments": if the same variable
#!         is assigned and then reassigned immediately in the next statement, this only counts as a single assignment.
#! @Arguments tree
DeclareGlobalFunction( "CapJitThrowErrorOnSideEffects" );

#! @Description
#!   Finds a node in <A>tree</A> for which <A>condition_func</A> returns `true`.
#!   For each node, <A>condition_func</A> is called with the node and current path as arguments, and must return a boolean.
#!   If multiple nodes are found, children are preferred over their parents (i.e. a "deep" node is returned).
#!   If no node can be found, `fail` is returned.
#! @Returns a record or fail
#! @Arguments tree, condition_func
DeclareGlobalFunction( "CapJitFindNodeDeep" );

#! @Description
#!   Gets the node of <A>tree</A> with path <A>path</A>. Throws an error if no such node exists.
#! @Returns a record
#! @Arguments tree, path
DeclareGlobalFunction( "CapJitGetNodeByPath" );
