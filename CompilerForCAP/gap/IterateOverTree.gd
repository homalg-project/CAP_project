# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Iterating over a syntax tree

#! @Description
#!   Iterates recursively over a syntax tree and calls <A>pre_func</A> and <A>result_func</A> for each node.
#!   Overview:
#!     * <A>pre_func</A> allows to modify a (sub-)tree before the recursion over its children. For example, you could
#!         detect occurrences of `if true then &lt;body&gt; fi;` and simply return the body to simplify the tree.
#!     * <A>result_func</A> allows to construct the return value of a (sub-)tree from the return values of its children.
#!         For example, if you want to check if a node of a certain type occurs in the tree, return `true`
#!         if <A>tree</A> has the type or any of the children returned `true`, otherwise return `false`.
#!     * <A>additional_arguments[_func]</A> allows to create and pass additional data to the children of <A>tree</A>,
#!         for example the path or the function stack.
#!
#!   Details:
#!     * First, <A>pre_func</A> is called with the following arguments:
#!         <A>tree</A> and <A>additional_arguments</A>.
#!       If it returns `fail`, the recursion is skipped and <A>result_func</A> is called immediately
#!       with `result` set to `fail` (see below).
#!       Otherwise it must return a syntax tree, which is then used as the value of <A>tree</A> for the remaining computation.
#!       If you do not need this function, use `ReturnFirst`.
#!     * Secondly, for each child of <A>tree</A>, <A>additional_arguments_func</A> is called with the following arguments:
#!         <A>tree</A>, the key of the child, and <A>additional_arguments</A>.
#!       If <A>tree</A> is a list, the key of a child is its list index.
#!       If <A>tree</A> is a record, the key of a child is the corresponding record name of <A>tree</A>.
#!       The return value is used in the next step.
#!     * Next, the recursion starts: for each child, <Ref Func="CapJitIterateOverTree" /> is called again with the following arguments:
#!         the child, <A>pre_func</A>, <A>result_func</A>, <A>additional_arguments_func</A>, and the return value of the
#!         call of <A>additional_arguments_func</A> in the step above.
#!     * The results of the recursive calls are stored in the variable `result`:
#!       If <A>tree</A> is a list, `result` is also a list
#!         and the `i`-th entry of this list is the return value of the `result_func` of the `i`-th child.
#!       If <A>tree</A> is a record, `result` is also a record
#!         and `result.(key)` is the return value of the `result_func` of the child named `key`.
#!     * Next, <A>result_func</A> is called with the following arguments:
#!         <A>tree</A>, `result`,  `keys` (a list containing the children's keys), and <A>additional_arguments</A>.
#!       The return value should be the result of the current tree formed by combining the results of the children.
#!       For an example see <Ref Func="CapJitResultFuncCombineChildren" />.
#!     * Finally, the return value of <A>result_func</A> is returned.
#!
#!   Note: This function on its own does not modify the tree.
#!   However, you can make modifications in <A>pre_func</A>, <A>result_func</A>, and <A>additional_arguments_func</A>.
#!   If you do not want to make these modifcations in-place, you can replace a (sub-)tree by a modified version in <A>pre_func</A>
#!   and combine the modified (sub-)trees again using <Ref Func="CapJitResultFuncCombineChildren" /> as <A>result_func</A>.
#! @Returns see description
#! @Arguments tree, pre_func, result_func, additional_arguments_func, additional_arguments
DeclareGlobalFunction( "CapJitIterateOverTree" );

#! @Description
#!   Same input and output as <Ref Func="CapJitIterateOverTree" />, but the results of bindings are cached and
#!   * if we reach an `EXPR_REF_FVAR` the result of the corresponding binding is given as `result` for <A>result_func</A>,
#!   * `pre_func` will not be called for `FVAR_BINDING_SEQ`s,
#!   * the `result` for `FVAR_BINDING_SEQ`s will only contain used bindings, and
#!   * the `keys` for `FVAR_BINDING_SEQ`s will only contain the names of used bindings and will be ordered compatible with the "uses" relation on bindings,
#!     i.e. if a binding contains references to another binding, the name of the other binding will come first in `keys`.
#!
#!   WARNING: Calls to `CapJitIterateOverTreeWithCachedBindingResults` must not be nested if this results in a function being visited twice.
#! @Arguments tree, pre_func, result_func, additional_arguments_func, additional_arguments
DeclareGlobalFunction( "CapJitIterateOverTreeWithCachedBindingResults" );

DeclareGlobalFunction( "CAP_JIT_INTERNAL_ITERATE_OVER_TREE" );
