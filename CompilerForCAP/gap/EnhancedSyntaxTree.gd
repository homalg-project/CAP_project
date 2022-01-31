# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Enhanced syntax trees

#! @Description
#!   Returns an enhanced syntax tree of the plain function <A>func</A> (see above). If the option `globalize_hvars` is set to `true`,
#!   higher variables pointing to variables in the environment of <A>func</A> are assigned to global variables
#!   and referenced via these global variables in the tree. Otherwise, an error is thrown if such higher variables exist.
#!   If a list is given as the option `given_arguments`, references to the `i`-th argument of the function are replaced by references
#!   to a global variable with the value of `given_arguments[i]` (only in case this position is bound).
#!   If a type signature (see <Ref Func="CapJitInferredDataTypes" />) of <A>func</A> is given as the option `type_signature`,
#!   it is attached to the resulting tree.
#! @Returns a record
#! @Arguments func
DeclareGlobalFunction( "ENHANCED_SYNTAX_TREE" );

#! @Description
#!   Converts the enhanced syntax tree <A>tree</A> to a function.
#! @Returns a function
#! @Arguments tree
DeclareGlobalFunction( "ENHANCED_SYNTAX_TREE_CODE" );
