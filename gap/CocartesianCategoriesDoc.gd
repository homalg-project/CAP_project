# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.11-04
# USING CategoryConstructor v2021.11-07

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Categories
##
####################################

#! A $6$-tuple $( \mathbf{C}, \sqcup, 1, \alpha, \lambda, \rho )$
#!  consisting of 
#! * a category $\mathbf{C}$, 
#! * a functor $\sqcup: \mathbf{C} \times \mathbf{C} \rightarrow \mathbf{C}$,
#! * an object $1 \in \mathbf{C}$, 
#! * a natural isomorphism $\alpha_{a,b,c}: a \sqcup (b \sqcup c) \cong (a \sqcup b) \sqcup c$,
#! * a natural isomorphism $\lambda_{a}: 1 \sqcup a \cong a$, 
#! * a natural isomorphism $\rho_{a}: a \sqcup 1 \cong a$,
#! is called a <Emph>cocartesian category</Emph>, if
#! * for all objects $a,b,c,d$, the pentagon identity holds:
#!  $(\alpha_{a,b,c} \sqcup \mathrm{id}_d) \circ \alpha_{a,b \sqcup c, d} \circ ( \mathrm{id}_a \sqcup \alpha_{b,c,d} ) = \alpha_{a \sqcup b, c, d} \circ \alpha_{a,b,c \sqcup d}$,
#! * for all objects $a,c$, the triangle identity holds:
#!  $( \rho_a \sqcup \mathrm{id}_c ) \circ \alpha_{a,1,c} = \mathrm{id}_a \sqcup \lambda_c$.

#! The corresponding GAP property is given by
#! <C>IsCocartesianCategory</C>.
