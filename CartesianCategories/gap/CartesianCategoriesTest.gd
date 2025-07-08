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
#! The arguments are 4
#! objects $v_1, v_2, v_3, v_4$
#! in a category.
#! The output is true if the pentagon identity holds
#! for those 4 objects, false otherwise.
#! @Returns a boolean
#! @Arguments v_1, v_2, v_3, v_4
DeclareOperation( "TestCartesianPentagonIdentity",
              [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The argument is a list $L$
#! consisting of quadruples of objects
#! in a cartesian category.
#! The output is true if the pentagon identity holds
#! for all those quadruples, false otherwise.
#! @Returns a boolean
#! @Arguments L
DeclareOperation( "TestCartesianPentagonIdentityForAllQuadruplesInList", [ IsList ] );

#! @Description
#! The arguments are
#! * a CAP category $cat$
#! * objects $a, b, c$
#! * a morphism $\alpha: a \rightarrow b$
#! * a morphism $\beta: c \rightarrow d$
#! This function checks for every operation
#! declared in CartesianCategories.gd
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
DeclareGlobalFunction( "CartesianCategoriesTest" );
