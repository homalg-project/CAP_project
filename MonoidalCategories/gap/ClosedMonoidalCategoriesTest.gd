# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

#! @Chapter Examples and Tests

#! @Section Test functions

#! @Description
#! This is a debug operation.
#! The arguments are a monoidal category $cat$ and two objects $a$, $b$ therein.
#! The output is true if the zigzag rule
#! $L(b) \to (LRL)(b) \to L(b) = id_b$ is satisfied for
#! * $L = a \otimes -$,
#! * $R = \mathrm{Hom}(a, -)$.
#! @Returns a boolean
#! @Arguments cat, a, b
DeclareOperation( "TestZigzagOfClosedMonoidalRightTensorProduct",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The arguments are a monoidal category $cat$ and two objects $a$, $b$ therein.
#! The output is true if the zigzag rule
#! $R(b) \to (RLR)(b) \to R(b) = id_b$ is satisfied for
#! * $L = a \otimes -$,
#! * $R = \mathrm{Hom}(a, -)$.
#! @Returns a boolean
#! @Arguments cat, a, b
DeclareOperation( "TestZigzagOfClosedMonoidalRightInternalHom",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The arguments are a monoidal category $cat$ and two objects $a$, $b$ therein.
#! The output is true if the zigzag rule
#! $L(b) \to (LRL)(b) \to L(b) = id_b$ is satisfied for
#! * $L = - \otimes a$,
#! * $R = \mathrm{Hom}(a, -)$.
#! @Returns a boolean
#! @Arguments cat, a, b
DeclareOperation( "TestZigzagOfClosedMonoidalLeftTensorProduct",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! This is a debug operation.
#! The arguments are a monoidal category $cat$ and two objects $a$, $b$ therein.
#! The output is true if the zigzag rule
#! $R(b) \to (RLR)(b) \to R(b) = id_b$ is satisfied for
#! * $L = - \otimes a$,
#! * $R = \mathrm{Hom}(a, -)$.
#! @Returns a boolean
#! @Arguments cat, a, b
DeclareOperation( "TestZigzagOfClosedMonoidalLeftInternalHom",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! * a CAP category $cat$
#! * objects $a, b, c, d$
#! * a morphism $\alpha: a \rightarrow b$
#! * a morphism $\beta: c \rightarrow d$
#! * a morphism $\gamma: a \otimes b \rightarrow 1$
#! * a morphism $\delta: c \otimes d \rightarrow 1$
#! * a morphism $\epsilon: 1 \rightarrow \mathrm{Hom}(a,b)$
#! * a morphism $\zeta: 1 \rightarrow \mathrm{Hom}(c,d)$
#! This function checks for every operation
#! declared in ClosedMonoidalCategories.gd
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
#! @Arguments cat, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta
DeclareGlobalFunction( "ClosedMonoidalCategoriesTest" );
