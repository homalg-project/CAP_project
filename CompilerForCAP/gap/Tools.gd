# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Tools

DeclareGlobalName( "CAP_JIT_INTERNAL_NAMES_OF_LOOP_FUNCTIONS" );

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
#!  Checks if <A>tree</A> (with function ID stack <A>initial_func_id_stack</A>) contains
#!  an FVAR which references a function outside of its function stack.
#!  Such a tree is not well-defined.
#! @Returns a boolean
#! @Arguments tree, initial_func_id_stack
DeclareGlobalFunction( "CapJitContainsRefToFVAROutsideOfFuncStack" );

#! @Description
#!   Assigns <A>value</A> to a global variable and returns the name of the global variable.
#!   If <A>value</A> has already been assigned to a global variable by this function before,
#!   simply returns the name of that global variable.
#! @Returns a string
#! @Arguments value
DeclareGlobalFunction( "CapJitGetOrCreateGlobalVariable" );

#! @Description
#!   Finds a node in <A>tree</A> for which <A>condition_func</A> returns `true`.
#!   For each node, <A>condition_func</A> is called with the node and current path as arguments, and must return a boolean.
#!   If multiple nodes are found, children are preferred over their parents (i.e. a "deep" node is returned).
#!   If no node can be found, `fail` is returned.
#! @Returns a record or fail
#! @Arguments tree, condition_func
DeclareGlobalFunction( "CapJitFindNodeDeep" );

#! @Description
#!   Finds all nodes in <A>tree</A> for which <A>condition_func</A> returns `true`.
#!   For each node, <A>condition_func</A> is called with the node and current path as arguments, and must return a boolean.
#!   Returns a list of nodes for which this call yields true.
#! @Returns a list
#! @Arguments tree, condition_func
DeclareGlobalFunction( "CapJitFindNodes" );

#! @Description
#!   Gets the node of <A>tree</A> with path <A>path</A>. Throws an error if no such node exists.
#! @Returns a record
#! @Arguments tree, path
DeclareGlobalFunction( "CapJitGetNodeByPath" );

#! @Description
#!   Removes removes any statement of the form `if condition then return fail; fi;` (or similar) from the statements of a <A>tree</A> of type `EXPR_FUNC`.
#!   Throws an error if it cannot find such a statement.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitRemovedReturnFail" );

#! @Description
#!   Pretty prints the function <A>func</A> and returns the result.
#!   <A>func</A> must be a regular function, i.e. not an operation or a kernel function.
#! @Returns a string
#! @Arguments func
DeclareGlobalFunction( "CapJitPrettyPrintFunction" );

#! @Description
#!   Returns a structural copy of the enhanced syntax <A>tree</A> which is 1:1 except that all functions have new, unused IDs.
#! @Returns a record
#! @Arguments tree
DeclareGlobalFunction( "CapJitCopyWithNewFunctionIDs" );

#! @Description
#!   Returns `true` if the enhanced syntax trees <A>tree1</A> and <A>tree2</A> are equal up to:
#!     * renaming of arguments,
#!     * replacement of function IDs,
#!     * changing the names of global variables while still referencing the identical value.
#! @Returns a boolean
#! @Arguments tree1, tree2
DeclareGlobalFunction( "CapJitIsEqualForEnhancedSyntaxTrees" );

#! @Description
#!   Adds a binding for <A>name</A> with value <A>value</A> to a syntax tree <A>bindings</A> of type `FVAR_BINDING_SEQ`.
#! @Returns a record
#! @Arguments bindings, name, value
DeclareGlobalFunction( "CapJitAddBinding" );

#! @Description
#!   Gets the value of the binding named <A>name</A> from a syntax tree <A>bindings</A> of type `FVAR_BINDING_SEQ`.
#! @Returns a record
#! @Arguments bindings, name
DeclareGlobalFunction( "CapJitValueOfBinding" );

#! @Description
#!   Unbinds the the binding named <A>name</A> from a syntax tree <A>bindings</A> of type `FVAR_BINDING_SEQ`.
#! @Arguments bindings, name
DeclareGlobalFunction( "CapJitUnbindBinding" );

#! @Description
#!   Replaces all subtrees of the enhanced syntax tree <A>tree</A> which are of type EXPR_REF_FVAR
#!   with given <A>func_id</A> and <A>name</A> by <A>value</A>.
#! @Returns a record
#! @Arguments tree, func_id, name, value
DeclareGlobalFunction( "CapJitReplacedEXPR_REF_FVARByValue" );

#! @Description
#!   Returns the minimal positive integer $n$ such that no name of a local variable of the function <A>func</A>
#!   (given as an enhanced syntax tree) ends with `Concatenation( "_", String( `$m$` ) )` for any $m \geq n$.
#! @Returns an integer
#! @Arguments func
DeclareGlobalFunction( "CapJitGetNextUnusedVariableID" );

## allow to handle SYNTAX_TREE_LISTs like lists
# Declare attributes as mutable because we want to modify them (after taking StructuralCopy, which preserves mutability).
DeclareAttribute( "AsSyntaxTreeList", IsList, "mutable" );
DeclareAttribute( "AsListMut", IsRecord, "mutable" );
# GAP does not allow to implement \{\} for records :(
DeclareOperation( "Sublist", [ IsRecord, IsDenseList and IsSmallList ] );
# GAP does not allow to implement Add for records :(
# DeclareOperation( "Add", [ IsRecord and IsMutable, IsObject ] );
DeclareOperation( "Remove", [ IsRecord and IsMutable, IsPosInt ] );
DeclareOperation( "PositionProperty", [ IsRecord, IsFunction ] );
DeclareGlobalFunction( "ConcatenationForSyntaxTreeLists" );
DeclareOperation( "ListOp", [ IsRecord, IsFunction ] );
DeclareOperation( "FilteredOp", [ IsRecord, IsFunction ] );
DeclareOperation( "PositionsProperty", [ IsRecord, IsFunction ] );
DeclareOperation( "FirstOp", [ IsRecord, IsFunction ] );
DeclareOperation( "LastOp", [ IsRecord ] );
DeclareOperation( "ForAllOp", [ IsRecord, IsFunction ] );
DeclareOperation( "ForAnyOp", [ IsRecord, IsFunction ] );
DeclareOperation( "Iterator", [ IsRecord ] );

#! @Description
#!   Prints <A>args...</A> followed by the location of the currently compiled function.
#! @Arguments args...
DeclareGlobalFunction( "PrintWithCurrentlyCompiledFunctionLocation" );

#! @Description
#!   Displays <A>obj</A> followed by the location of the currently compiled function.
#! @Arguments obj
DeclareGlobalFunction( "DisplayWithCurrentlyCompiledFunctionLocation" );

#! @Description
#!   Prints <A>args...</A> as an error followed by the location of the currently compiled function.
#! @Arguments args...
DeclareGlobalFunction( "ErrorWithCurrentlyCompiledFunctionLocation" );

#! @Description
#!   Same as `EvalString`, but enters a break-loop when encountering syntax errors.
#! @Arguments string
DeclareGlobalFunction( "EvalStringStrict" );
