#
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Tools

DeclareGlobalFunction( "CAP_JIT_INTERNAL_PREPARE_SYNTAX_TREE_FOR_PRETTY_PRINT" );

#! @Description
#!   Displays an enhanced syntax tree in a more useful way. For example, prints the
#!   type of a node on top.
#! @Arguments tree
DeclareGlobalFunction( "CapJitPrettyPrintSyntaxTree" );
