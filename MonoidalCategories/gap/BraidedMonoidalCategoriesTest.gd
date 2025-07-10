# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

#! @Chapter Examples and Tests

#! @Section Test functions

#! @Description
#! This is a debug operation.
#! The arguments are three objects $obj_1, obj_2, obj_3$
#! in a braided monoidal category $cat$.
#! The output is true if the braiding compatabilities with the associator hold,
#! false otherwise.
#! @Returns a boolean
#! @Arguments cat, obj_1, obj_2, obj_3
DeclareOperation( "TestBraidingCompatibility",
              [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The argument is a list $L$ of objects in a braided monoidal category $cat$.
#! The output is true if the braiding compatabilities with the associator hold
#! for all triples of objects in $L$, otherwise false.
#! @Returns a boolean
#! @Arguments cat, L
DeclareOperation( "TestBraidingCompatibilityForAllTriplesInList", [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are
#! * a CAP category $cat$
#! * objects $a, b$
#! This function checks for every operation
#! declared in BraidedMonoidalCategories.gd
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
#! @Arguments cat, a, b
DeclareGlobalFunction( "BraidedMonoidalCategoriesTest" );
