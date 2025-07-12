# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



#! @Chapter Examples and Tests

#! @Section Test functions

#! @Description
#! This is a debug operation.
#! The arguments are two objects $obj$ in a cocartesian category $cat$.
#! The output is true if the left and right unitors are invertible for $obj$.
#! @Returns a boolean
#! @Arguments cat, obj
DeclareOperation( "TestCocartesianUnitorsForInvertibility",
              [ IsCapCategory, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The arguments are two objects $obj_1, obj_2$ in a cocartesian category $cat$.
#! The output is true if the triangle identity holds
#! for these 2 objects, false otherwise.
#! @Returns a boolean
#! @Arguments cat, obj_1, obj_2
DeclareOperation( "TestCocartesianTriangleIdentity",
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The argument is a list $L$ of objects in a cocartesian category $cat$.
#! The output is true if the triangle identity holds
#! for all pairs of objects in $L$, otherwise false.
#! @Returns a boolean
#! @Arguments cat, L
DeclareOperation( "TestCocartesianTriangleIdentityForAllPairsInList", [ IsCapCategory, IsList ] );

#! @Description
#! This is a debug operation.
#! The arguments are 4 objects $obj_1, obj_2, obj_3, obj_4$ in a cocartesian category $cat$.
#! The output is true if the pentagon identity holds
#! for these 4 objects, false otherwise.
#! @Returns a boolean
#! @Arguments cat, obj_1, obj_2, obj_3, obj_4
DeclareOperation( "TestCocartesianPentagonIdentity",
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The arguments are 4 objects $obj_1, obj_2, obj_3, obj_4$ in a cocartesian category $cat$.
#! The output is true if the pentagon identity holds
#! for these 4 objects, false otherwise.
#! This test uses the WithGiven-operations.
#! @Returns a boolean
#! @Arguments cat, obj_1, obj_2, obj_3, obj_4
DeclareOperation( "TestCocartesianPentagonIdentityUsingWithGivenOperations",
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The argument is a list $L$ of objects in a cocartesian category $cat$.
#! The output is true if the pentagon identity holds
#! for all quadruples of objects in $L$, otherwise false.
#! @Returns a boolean
#! @Arguments cat, L
DeclareOperation( "TestCocartesianPentagonIdentityForAllQuadruplesInList", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are
#! * a CAP category $cat$
#! * objects $a, b, c$
#! * a morphism $\alpha: a \rightarrow b$
#! * a morphism $\beta: c \rightarrow d$
#! This function checks for every operation
#! declared in CocartesianCategories.gd
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
DeclareGlobalFunction( "CocartesianCategoriesTest" );
