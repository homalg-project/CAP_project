####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Monoidal Categories
##
####################################

#! A $6$-tuple $( \mathbf{C}, \otimes, 1, \alpha, \lambda, \rho )$
#!  consisting of 
#! * a category $\mathbf{C}$, 
#! * a functor $\otimes: \mathbf{C} \times \mathbf{C} \rightarrow \mathbf{C}$,
#! * an object $1 \in \mathbf{C}$, 
#! * a natural isomorphism $\alpha_{a,b,c}: a \otimes (b \otimes c) \cong (a \otimes b) \otimes c$,
#! * a natural isomorphism $\lambda_{a}: 1 \otimes a \cong a$, 
#! * a natural isomorphism $\rho_{a}: a \otimes 1 \cong a$,
#! is called a <Emph>monoidal category</Emph>, if
#! * for all objects $a,b,c,d$, the pentagon identity holds:
#!  $(\alpha_{a,b,c} \otimes \mathrm{id}_d) \circ \alpha_{a,b \otimes c, d} \circ ( \mathrm{id}_a \otimes \alpha_{b,c,d} ) = \alpha_{a \otimes b, c, d} \circ \alpha_{a,b,c \otimes d}$,
#! * for all objects $a,c$, the triangle identity holds:
#!  $( \rho_a \otimes \mathrm{id}_c ) \circ \alpha_{a,1,c} = \mathrm{id}_a \otimes \lambda_c$.

#! The corresponding GAP property is given by
#! <C>IsMonoidalCategory</C>.
