#
# CompilerForCAP: Speed up computations in CAP categories
#
# Declarations
#
#! @Chapter Improving and extending the compiler

#! @Section Tools

#! @Description
#!   Computes the arguments of the function call at the given <A>path</A> in <A>tree</A>
#!   when executing the function defined by <A>tree</A> with arguments <A>jit_args</A>.
#!   If the arguments cannot be determined, a list with first entry `false` is returned.
#!   Otherwise, a list with `true` as the first value and the computed arguments
#!   as the second value is returned.
#! @Returns a list
#! @Arguments tree, path, jit_args
DeclareGlobalFunction( "CapJitGetFunctionCallArgumentsFromJitArgs" );

#! @Description
#!   Computes the value of the expression at the given <A>path</A> in <A>tree</A>
#!   when executing the function defined by <A>tree</A> with arguments <A>jit_args</A>.
#!   If the value cannot be determined, a list with first entry `false` is returned.
#!   Otherwise, a list with `true` as the first value and the computed value
#!   as the second value is returned.
#! @Returns a list
#! @Arguments tree, path, jit_args
DeclareGlobalFunction( "CapJitGetExpressionValueFromJitArgs" );
