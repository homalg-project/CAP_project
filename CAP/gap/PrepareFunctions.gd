# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Add Functions

#! @Section Prepare functions

DeclareGlobalVariable( "CAP_PREPARE_FUNCTION_RECORD" );

#! @Arguments prepare_function, category, func
#! @Returns a function
#! @Description
#!  Given a non-CAP-conform function for any of the categorical operations, i.e.,
#!  a function that computes the direct sum of two objects instead of a list of objects,
#!  this function wraps the function with a wrapper function to fit in the CAP context.
#!  For the mentioned binary direct sum one can call this function with
#!  <C>"BinaryDirectSumToDirectSum"</C> as <A>prepare_function</A>, the category, and
#!  the binary direct sum function. The function then returns a function that can be used
#!  for the direct sum categorical operation.
#!  
#!  Note that <A>func</A> is not handled by the CAP caching mechanism and that the use
#!  of prepare functions is incompatible with <C>WithGiven</C> operations. Thus, one has
#!  to ensure manually that the equality and typing specifications are fulfilled.
DeclareGlobalFunction( "CAPOperationPrepareFunction" );

#! @Arguments prepare_function, name, doc_string[, precondition_list]
#! @Description
#!  Adds a prepare function to the list of CAP's prepare functions.
#!  The first argument is the prepare function itself. It should always be a function that takes a category and
#!  a function and returns a function.
#!  The argument <A>name</A> is the name of the prepare function, which is used in <C>CAPOperationPrepareFunction</C>.
#!  The argument <A>doc_string</A> should be a short string describing the functions.
#!  The optional argument <A>precondition_list</A> can describe preconditions for the prepare function to work, i.e.,
#!  if the category does need to have PreCompose computable. This information is also recovered automatically from the
#!  prepare function itself, so the <A>precondition_list</A> is only necessary if the function needed is not explicitly
#!  used in the prepare function, e.g., if you use <C>+</C> instead of <C>AdditionForMorphisms</C>.
DeclareGlobalFunction( "CAPAddPrepareFunction" );

#! @Description
#!  Lists all prepare functions.
DeclareGlobalFunction( "ListCAPPrepareFunctions" );

