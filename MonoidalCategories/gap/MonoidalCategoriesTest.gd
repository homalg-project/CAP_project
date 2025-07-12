# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

#! @Chapter Examples and Tests

#! @Section Test functions

#! @Description
#! This is a debug operation.
#! The arguments are two objects $obj$ in a monoidal category $cat$.
#! The output is true if the left and right unitors are invertible for $obj$.
#! @Returns a boolean
#! @Arguments cat, obj
DeclareOperation( "TestMonoidalUnitorsForInvertibility",
              [ IsCapCategory, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The arguments are two objects $obj_1, obj_2, obj_3$ in a monoidal category $cat$.
#! The output is true if the associator are invertible
#! for these 3 objects, false otherwise.
#! @Returns a boolean
#! @Arguments cat, obj_1, obj_2, obj_3
DeclareOperation( "TestAssociatorForInvertibility",
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The arguments are two objects $obj_1, obj_2$ in a monoidal category $cat$.
#! The output is true if the triangle identity holds
#! for these 2 objects, false otherwise.
#! @Returns a boolean
#! @Arguments cat, obj_1, obj_2
DeclareOperation( "TestMonoidalTriangleIdentity",
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The argument is a list $L$ of objects in a monoidal category $cat$.
#! The output is true if the triangle identity holds
#! for all pairs of objects in $L$, otherwise false.
#! @Returns a boolean
#! @Arguments cat, L
DeclareOperation( "TestMonoidalTriangleIdentityForAllPairsInList", [ IsCapCategory, IsList ] );

#! @Description
#! This is a debug operation.
#! The arguments are 4 objects $obj_1, obj_2, obj_3, obj_4$ in a monoidal category $cat$.
#! The output is true if the pentagon identity holds
#! for these 4 objects, false otherwise.
#! @Returns a boolean
#! @Arguments cat, obj_1, obj_2, obj_3, obj_4
DeclareOperation( "TestMonoidalPentagonIdentity",
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The arguments are 4 objects $obj_1, obj_2, obj_3, obj_4$ in a monoidal category $cat$.
#! The output is true if the pentagon identity holds
#! for these 4 objects, false otherwise.
#! This test uses the WithGiven-operations.
#! @Returns a boolean
#! @Arguments cat, obj_1, obj_2, obj_3, obj_4
DeclareOperation( "TestMonoidalPentagonIdentityUsingWithGivenOperations",
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The argument is a list $L$ of objects in a monoidal category $cat$.
#! The output is true if the pentagon identity holds
#! for all quadruples of objects in $L$, otherwise false.
#! @Returns a boolean
#! @Arguments cat, L
DeclareOperation( "TestMonoidalPentagonIdentityForAllQuadruplesInList", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are
#! * a CAP category $cat$
#! * objects $a, b, c$
#! * a morphism $\alpha: a \rightarrow b$
#! * a morphism $\beta: c \rightarrow d$
#! This function checks for every operation
#! declared in MonoidalCategories.gd
#! if it is computable in the CAP category $cat$.
#! If yes, then the operation is executed
#! with the parameters given above and
#! compared to the equivalent computation in
#! the opposite category of $cat$.
#! Pass the options
#! * `verbose := true` to output more information.
#! * `only_primitive_operations := true`,
#!    which is passed on to Opposite(),
#!    to only primitively install
#!    dual operations for primitively
#!    installed operations in $cat$.
#!    The advantage is, that more derivations might be tested.
#!    On the downside, this might test fewer dual_pre/postprocessor_funcs.
#! @Arguments cat, a, b, c, alpha, beta
DeclareGlobalFunction( "MonoidalCategoriesTest" );
