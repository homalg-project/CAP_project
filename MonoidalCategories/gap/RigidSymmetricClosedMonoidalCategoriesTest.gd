# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

#! @Chapter Examples and Tests

#! @Section Test functions

#! @Description
#! This is a debug operation.
#! The argument is an object $obj$
#! in a rigid symmetric monoidal category $cat$.
#! The output is true if the zig zag identity for duals hold,
#! false otherwise.
#! @Returns a boolean
#! @Arguments cat, obj
DeclareOperation( "TestZigZagIdentitiesForDual", [ IsCapCategory, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * a CAP category $cat$
#! * objects $a, b, c, d$
#! * an endomorphism $\alpha: a \rightarrow a$
#! This function checks for every object and morphism
#! declared in RigidSymmetricClosedMonoidalCategories.gd
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
#! @Arguments cat, a, b, c, d, alpha
DeclareGlobalFunction( "RigidSymmetricClosedMonoidalCategoriesTest" );
