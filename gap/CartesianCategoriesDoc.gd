# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-04

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Categories
##
####################################

#! A $6$-tuple $( \mathbf{C}, \times, 1, \alpha, \lambda, \rho )$
#!  consisting of 
#! * a category $\mathbf{C}$, 
#! * a functor $\times: \mathbf{C} \times \mathbf{C} \rightarrow \mathbf{C}$,
#! * an object $1 \in \mathbf{C}$, 
#! * a natural isomorphism $\alpha_{a,b,c}: a \times (b \times c) \cong (a \times b) \times c$,
#! * a natural isomorphism $\lambda_{a}: 1 \times a \cong a$, 
#! * a natural isomorphism $\rho_{a}: a \times 1 \cong a$,
#! is called a <Emph>cartesian category</Emph>, if
#! * for all objects $a,b,c,d$, the pentagon identity holds:
#!  $(\alpha_{a,b,c} \times \mathrm{id}_d) \circ \alpha_{a,b \times c, d} \circ ( \mathrm{id}_a \times \alpha_{b,c,d} ) = \alpha_{a \times b, c, d} \circ \alpha_{a,b,c \times d}$,
#! * for all objects $a,c$, the triangle identity holds:
#!  $( \rho_a \times \mathrm{id}_c ) \circ \alpha_{a,1,c} = \mathrm{id}_a \times \lambda_c$.

#! The corresponding GAP property is given by
#! <C>IsCartesianCategory</C>.
