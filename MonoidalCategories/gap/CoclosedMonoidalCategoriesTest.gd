# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

#! @Chapter Examples and Tests

#! @Section Test functions

#! @Description
#! The arguments are
#! a CAP category $cat$
#! objects $a, b, c, d$
#! * a morphism $\alpha: a \rightarrow b$
#! * a morphism $\beta: c \rightarrow d$
#! * a morphism $\gamma: 1 \rightarrow a \otimes b$
#! * a morphism $\delta: 1 \rightarrow c \otimes d$
#! * a morphism $\epsilon: \mathrm{coHom}(a,b) \rightarrow 1$
#! * a morphism $\zeta: \mathrm{coHom}(c,d) \rightarrow 1$
#! This function checks for every operation
#! declared in CoclosedMonoidalCategories.gd
#! if it is computable in the CAP category $cat$.
#! If yes, then the operation is executed
#! with the parameters given above and
#! compared to the equivalent computation in
#! the opposite category of $cat$.
#! Pass the option 'verbose := true' to output more information.
#! @Arguments cat, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta
DeclareGlobalFunction( "CoclosedMonoidalCategoriesTest" );