#
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Enhanced syntax trees

#! @Description
#!   Returns an enhanced syntax tree of the plain function <A>func</A> (see above). If the second argument is set to `true`,
#!   higher variables pointing to variables in the environment of <A>func</A> are assigned to global variables
#!   and referenced via these global variables in the tree. Otherwise, an error is thrown if such higher variables exist.
#! @Returns a record
#! @Arguments func[, globalize_hvars ]
DeclareGlobalFunction( "ENHANCED_SYNTAX_TREE" );

#! @Description
#!   Converts the enhanced syntax tree <A>tree</A> to a function.
#! @Returns a function
#! @Arguments tree
DeclareGlobalFunction( "ENHANCED_SYNTAX_TREE_CODE" );
