# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

#! @Chapter Examples and Tests

#! @Section Test functions

#! @Description
#! The arguments are
#! * a CAP category $cat$
#! * objects $a, b, c, d$
#! * a morphism $\alpha: a \rightarrow b$
#! This function checks for every object and morphism
#! declared in RigidSymmetricCoclosedMonoidalCategories.gd
#! if it is computable in the CAP category $cat$.
#! If yes, then the operation is executed
#! with the parameters given above and
#! compared to the equivalent computation in
#! the opposite category of $cat$.
#! Pass the option 'verbose := true' to output more information.
#! @Arguments cat, assertlevel, a, b, c, d, alpha
DeclareGlobalFunction( "RigidSymmetricCoclosedMonoidalCategoriesTest" );
