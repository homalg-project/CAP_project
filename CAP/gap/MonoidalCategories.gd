#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Tensor Product and Internal Hom
#!
##
#############################################################################

####################################
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

## TensorProductOnObjects

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the tensor product $a \otimes b$.
#! @Returns an object
#! @Arguments a,b
DeclareOperationWithCache( "TensorProductOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>TensorProductOnObjects</C>.
#! $F: (a,b) \mapsto a \otimes b$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsList ] );

## TensorProductOnMorphisms

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the tensor product $\alpha \otimes \beta$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes b, a' \otimes b')$
#! @Arguments alpha, beta
DeclareOperation( "TensorProductOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = a \otimes b$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = a' \otimes b'$.
#! The output is the tensor product $\alpha \otimes \beta$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes b, a' \otimes b')$
#! @Arguments s, alpha, beta, r
DeclareOperation( "TensorProductOnMorphisms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>TensorProductOnMorphisms</C>.
#! $F: ( a \otimes b, \alpha: a \rightarrow a', \beta: b \rightarrow b', a' \otimes b' ) \mapsto \alpha \otimes \beta$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductOnMorphisms",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the associator $\alpha_{a,(b,c)}: a \otimes (b \otimes c) \rightarrow (a \otimes b) \otimes c$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes (b \otimes c), (a \otimes b) \otimes c )$.
#! @Arguments a, b, c
DeclareOperation( "AssociatorRightToLeft",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \otimes (b \otimes c)$,
#! three objects $a,b,c$,
#! and an object $r = (a \otimes b) \otimes c$.
#! The output is the associator $\alpha_{a,(b,c)}: a \otimes (b \otimes c) \rightarrow (a \otimes b) \otimes c$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes (b \otimes c), (a \otimes b) \otimes c )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "AssociatorRightToLeft",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>AssociatorRightToLeft</C>.
#! $F: ( a \otimes (b \otimes c), a, b, c, (a \otimes b) \otimes c ) \mapsto \alpha_{a,(b,c)}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorRightToLeft",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorRightToLeft",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeft",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeft",
                  [ IsCapCategory, IsList ] );



##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the associator $\alpha_{(a,b),c}: (a \otimes b) \otimes c \rightarrow a \otimes (b \otimes c)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \otimes b) \otimes c \rightarrow a \otimes (b \otimes c) )$.
#! @Arguments a, b, c
DeclareOperation( "AssociatorLeftToRight",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (a \otimes b) \otimes c$,
#! three objects $a,b,c$,
#! and an object $r = a \otimes (b \otimes c)$.
#! The output is the associator $\alpha_{(a,b),c}: (a \otimes b) \otimes c \rightarrow a \otimes (b \otimes c)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \otimes b) \otimes c \rightarrow a \otimes (b \otimes c) )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "AssociatorLeftToRight",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>AssociatorLeftToRight</C>.
#! $F: (( a \otimes b ) \otimes c, a, b, c, a \otimes (b \otimes c )) \mapsto \alpha_{(a,b),c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorLeftToRight",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorLeftToRight",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRight",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRight",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is a category $\mathbf{C}$.
#! The output is the tensor unit $1$ of $\mathbf{C}$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "TensorUnit",
                  IsCapCategory );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>TensorUnit</C>.
#! $F: ( ) \mapsto 1$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the left unitor $\lambda_a: 1 \otimes a \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(1 \otimes a, a )$
#! @Arguments a
DeclareAttribute( "LeftUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ and an object $s = 1 \otimes a$.
#! The output is the left unitor $\lambda_a: 1 \otimes a \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(1 \otimes a, a )$
#! @Arguments a, s
DeclareOperation( "LeftUnitor",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>LeftUnitor</C>.
#! $F: (a, 1 \otimes a) \mapsto \lambda_a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitor",
                  [ IsCapCategory, IsList ] );



##
#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the left unitor $\lambda_a^{-1}: a \rightarrow 1 \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}(a, 1 \otimes a)$
#! @Arguments a
DeclareAttribute( "LeftUnitorInverse",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$ and an object $r = 1 \otimes a$.
#! The output is the inverse of the left unitor $\lambda_a^{-1}: a \rightarrow 1 \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}(a, 1 \otimes a)$
#! @Arguments a, r
DeclareOperation( "LeftUnitorInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>LeftUnitorInverse</C>.
#! $F: (a, 1 \otimes a) \mapsto \lambda_a^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitorInverse",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the right unitor $\rho_a: a \otimes 1 \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes 1, a )$
#! @Arguments a
DeclareAttribute( "RightUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ and an object $s = a \otimes 1$.
#! The output is the right unitor $\rho_a: a \otimes 1 \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes 1, a )$
#! @Arguments a, s
DeclareOperation( "RightUnitor",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>RightUnitor</C>.
#! $F: (a, a \otimes 1) \mapsto \rho_a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitor",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the right unitor $\rho_a^{-1}: a \rightarrow a \otimes 1$.
#! @Returns a morphism in $\mathrm{Hom}( a, a \otimes 1 )$
#! @Arguments a
DeclareAttribute( "RightUnitorInverse",
                  IsCapCategoryObject );

# the second argument is the given tensor product
#! @Description
#! The arguments are an object $a$ and an object $r = a \otimes 1$.
#! The output is the inverse of the right unitor $\rho_a^{-1}: a \rightarrow a \otimes 1$.
#! @Returns a morphism in $\mathrm{Hom}( a, a \otimes 1 )$
#! @Arguments a, r
DeclareOperation( "RightUnitorInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>RightUnitorInverse</C>.
#! $F: (a, a \otimes 1) \mapsto \rho_a^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Braided Monoidal Categories
##
####################################

#! A monoidal category $\mathbf{C}$ equipped with a natural isomorphism
#! $B_{a,b}: a \otimes b \cong b \otimes a$
#! is called a <Emph>braided monoidal category</Emph>
#! if
#! * $\lambda_a \circ B_{a,1} = \rho_a$,
#! * $(B_{c,a} \otimes \mathrm{id}_b) \circ \alpha_{c,a,b} \circ B_{a \otimes b,c} = \alpha_{a,c,b} \circ ( \mathrm{id}_a \otimes B_{b,c}) \circ \alpha^{-1}_{a,b,c}$,
#! * $( \mathrm{id}_b \otimes B_{c,a} ) \circ \alpha^{-1}_{b,c,a} \circ B_{a,b \otimes c} = \alpha^{-1}_{b,a,c} \circ (B_{a,b} \otimes \mathrm{id}_c) \circ \alpha_{a,b,c}$.

#! The corresponding GAP property is given by
#! <C>IsBraidedMonoidalCategory</C>.
##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the braiding $ B_{a,b}: a \otimes b \rightarrow b \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b, b \otimes a )$.
#! @Arguments a,b
DeclareOperation( "Braiding",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \otimes b$, 
#! two objects $a,b$,
#! and an object $r = b \otimes a$.
#! The output is the braiding $ B_{a,b}: a \otimes b \rightarrow b \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b, b \otimes a )$.
#! @Arguments s,a,b,r
DeclareOperation( "Braiding",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>Braiding</C>.
#! $F: (a \otimes b, a, b, b \otimes a) \rightarrow B_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraiding",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of the braiding $ B_{a,b}^{-1}: b \otimes a \rightarrow a \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( b \otimes a, a \otimes b )$.
#! @Arguments a,b
DeclareOperation( "BraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = b \otimes a$, 
#! two objects $a,b$,
#! and an object $r = a \otimes b$.
#! The output is the braiding $ B_{a,b}^{-1}: b \otimes a \rightarrow a \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( b \otimes a, a \otimes b )$.
#! @Arguments s,a,b,r
DeclareOperation( "BraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>BraidingInverse</C>.
#! $F: (b \otimes a, a, b, a \otimes b) \rightarrow B_{a,b}^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Symmetric Monoidal Categories
##
####################################

#! A braided monoidal category $\mathbf{C}$ is called <Emph>symmetric monoidal category</Emph>
#! if $B_{a,b}^{-1} = B_{b,a}$.
#! The corresponding GAP property is given by
#! <C>IsSymmetricMonoidalCategory</C>.

####################################
##
#! @Section Symmetric Closed Monoidal Categories
##
####################################

#! A symmetric monoidal category $\mathbf{C}$
#! which has for each functor $- \otimes b: \mathbf{C} \rightarrow \mathbf{C}$
#! a right adjoint (denoted by $\underline{\mathrm{Hom}}(b,-)$)
#! is called a <Emph>symmetric closed monoidal category</Emph>.

#! The corresponding GAP property is given by
#! <C>IsSymmetricClosedMonoidalCategory</C>.

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal hom object $\underline{\mathrm{Hom}}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "InternalHomOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>InternalHomOnObjects</C>.
#! $F: (a,b) \mapsto \underline{\mathrm{Hom}}(a,b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalHomOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomOnObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal hom morphism
#! $\underline{\mathrm{Hom}}(\alpha,\beta): \underline{\mathrm{Hom}}(a',b) \rightarrow \underline{\mathrm{Hom}}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \underline{\mathrm{Hom}}(a',b), \underline{\mathrm{Hom}}(a,b') )$
#! @Arguments alpha, beta
DeclareOperation( "InternalHomOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \underline{\mathrm{Hom}}(a',b)$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \underline{\mathrm{Hom}}(a,b')$.
#! The output is the internal hom morphism 
#! $\underline{\mathrm{Hom}}(\alpha,\beta): \underline{\mathrm{Hom}}(a',b) \rightarrow \underline{\mathrm{Hom}}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \underline{\mathrm{Hom}}(a',b), \underline{\mathrm{Hom}}(a,b') )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "InternalHomOnMorphisms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>InternalHomOnMorphisms</C>.
#! $F: (\underline{\mathrm{Hom}}(a',b), \alpha: a \rightarrow a', \beta: b \rightarrow b', \underline{\mathrm{Hom}}(a,b') ) \mapsto \underline{\mathrm{Hom}}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphisms",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a, b$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{\underline{Hom}}(a,b) \otimes a \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b) \otimes a, b )$.
#! @Arguments a,b
DeclareOperation( "EvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## 3rd argument is $\mathrm{\underline{Hom}}(a,b) \otimes a$
#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{\underline{Hom}}(a,b) \otimes a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{\underline{Hom}}(a,b) \otimes a \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b) \otimes a, b )$.
#! @Arguments a,b, s
DeclareOperation( "EvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>EvaluationMorphism</C>.
#! $F: (a, b, \mathrm{\underline{Hom}}(a,b) \otimes a) \mapsto \mathrm{ev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEvaluationMorphism",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{\underline{Hom}(b, a \otimes b)}$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}}(b, a \otimes b) )$.
#! @Arguments a,b
DeclareOperation( "CoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## the last argument is $\mathrm{\underline{Hom}}(b, a \otimes b)$
#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{\underline{Hom}(b, a \otimes b)}$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{\underline{Hom}(b, a \otimes b)}$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}}(b, a \otimes b) )$.
#! @Arguments a,b,r
DeclareOperation( "CoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>CoevaluationMorphism</C>.
#! $F: (a, b, \mathrm{\underline{Hom}}(b, a \otimes b)) \mapsto \mathrm{coev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationMorphism",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are objects $a,b$ and a morphism $f: a \otimes b \rightarrow c$.
#! The output is a morphism $g: a \rightarrow \mathrm{\underline{Hom}}(b,c)$
#! corresponding to $f$ under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}}(b,c) )$.
#! @Arguments a, b, f
DeclareOperation( "TensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TensorProductToInternalHomAdjunctionMap</C>.
#! $F: (a, b, f: a \otimes b \rightarrow c) \mapsto ( g: a \rightarrow \mathrm{\underline{Hom}}(b,c) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductToInternalHomAdjunctionMap",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are objects $b,c$ and a morphism $g: a \rightarrow \mathrm{\underline{Hom}}(b,c)$.
#! The output is a morphism $f: a \otimes b \rightarrow c$ corresponding to $g$ under the
#! tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes b, c)$.
#! @Arguments b, c, g
DeclareOperation( "InternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InternalHomToTensorProductAdjunctionMap</C>.
#! $F: (b, c, g: a \rightarrow \mathrm{\underline{Hom}}(b,c)) \mapsto ( g: a \otimes b \rightarrow c )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precomposition morphism
#! $\mathrm{MonoidalPreComposeMorphism}_{a,b,c}: \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c), \mathrm{\underline{Hom}}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "MonoidalPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{Hom}}(a,c)$.
#! The output is the precomposition morphism
#! $\mathrm{MonoidalPreComposeMorphism}_{a,b,c}: \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c), \mathrm{\underline{Hom}}(a,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MonoidalPreComposeMorphism</C>.
#! $F: (\mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c),a,b,c,\mathrm{\underline{Hom}}(a,c)) \mapsto \mathrm{MonoidalPreComposeMorphism}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcomposition morphism
#! $\mathrm{MonoidalPostComposeMorphism}_{a,b,c}: \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b), \mathrm{\underline{Hom}}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "MonoidalPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{Hom}}(a,c)$.
#! The output is the postcomposition morphism
#! $\mathrm{MonoidalPostComposeMorphism}_{a,b,c}: \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b), \mathrm{\underline{Hom}}(a,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MonoidalPostComposeMorphism</C>.
#! $F: (\mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b),a,b,c,\mathrm{\underline{Hom}}(a,c)) \mapsto \mathrm{MonoidalPostComposeMorphism}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is its dual object $a^{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "DualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DualOnObjects</C>.
#! $F: a \mapsto a^{\vee}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b^{\vee}, a^{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "DualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b^{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a^{\vee}$.
#! The output is the dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b^{\vee}, a^{\vee} )$.
#! @Arguments s,alpha,r
DeclareOperation( "DualOnMorphisms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DualOnMorphisms</C>.
#! $F: (b^{\vee},\alpha,a^{\vee}) \mapsto \alpha^{\vee}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes a, 1 )$.
#! @Arguments a
DeclareAttribute( "EvaluationForDual",
                  IsCapCategoryObject );


#! @Description
#! The arguments are an object $s = a^{\vee} \otimes a$,
#! an object $a$,
#! and an object $r = 1$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \otimes a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes a, 1 )$.
#! @Arguments s,a,r
DeclareOperation( "EvaluationForDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>EvaluationForDual</C>.
#! $F: (a^{\vee} \otimes a, a, 1) \mapsto \mathrm{ev}_{a}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a}:1 \rightarrow a \otimes a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(1,a \otimes a^{\vee})$.
#! @Arguments a
DeclareAttribute( "CoevaluationForDual",
                  IsCapCategoryObject );


#! @Description
#! The arguments are an object $s = 1$,
#! an object $a$,
#! and an object $r = a \otimes a^{\vee}$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a}:1 \rightarrow a \otimes a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(1,a \otimes a^{\vee})$.
#! @Arguments s,a,r
DeclareOperation( "CoevaluationForDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoevaluationForDual</C>.
#! $F: (1, a, a \otimes a^{\vee}) \mapsto \mathrm{coev}_{a}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a^{\vee})^{\vee})$.
#! @Arguments a
DeclareAttribute( "MorphismToBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$,
#! and an object $r = (a^{\vee})^{\vee}$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a^{\vee})^{\vee})$.
#! @Arguments a, r
DeclareOperation( "MorphismToBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismToBidual</C>.
#! $F: (a, (a^{\vee})^{\vee}) \mapsto (a \rightarrow (a^{\vee})^{\vee})$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are four objects $a, a', b, b'$.
#! The output is the natural morphism
#! $\mathrm{TensorProductInternalHomCompatibilityMorphism}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b') \rightarrow \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b'))$.
#! @Arguments a,a',b,b'
DeclareOperation( "TensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

##
## The new_source and new_range arguments are the first and second element of the list.
## This construction is due to the fact that the maximal number of arguments for an operation is 6,
## but a basic operation with 6 arguments would install a setter having 7 arguments.
#! @Description
#! The arguments are four objects $a, a', b, b'$,
#! and a list $L = [ \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') ]$.
#! The output is the natural morphism
#! $\mathrm{TensorProductInternalHomCompatibilityMorphism}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b') \rightarrow \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b'))$.
#! @Arguments a,a',b,b',L
DeclareOperation( "TensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TensorProductInternalHomCompatibilityMorphism</C>.
#! $F: ( a,a',b,b', [ \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') ]) \mapsto \mathrm{TensorProductInternalHomCompatibilityMorphism}_{a,a',b,b'}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{TensorProductDualityCompatibilityMorphism}: a^{\vee} \otimes b^{\vee} \rightarrow (a \otimes b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b^{\vee}, (a \otimes b)^{\vee} )$.
#! @Arguments a,b
DeclareOperation( "TensorProductDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes b^{\vee}$,
#! two objects $a,b$,
#! and an object $r = (a \otimes b)^{\vee}$.
#! The output is the natural morphism
#! $\mathrm{TensorProductDualityCompatibilityMorphism}_{a,b}: a^{\vee} \otimes b^{\vee} \rightarrow (a \otimes b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b^{\vee}, (a \otimes b)^{\vee} )$.
#! @Arguments s,a,b,r
DeclareOperation( "TensorProductDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TensorProductDualityCompatibilityMorphism</C>.
#! $F: ( a^{\vee} \otimes b^{\vee}, a, b, (a \otimes b)^{\vee} ) \mapsto \mathrm{TensorProductDualityCompatibilityMorphism}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromTensorProductToInternalHom}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b, \mathrm{\underline{Hom}}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes b$,
#! two objects $a,b$,
#! and an object $r = \mathrm{\underline{Hom}}(a,b)$.
#! The output is the natural morphism $\mathrm{MorphismFromTensorProductToInternalHom}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b, \mathrm{\underline{Hom}}(a,b) )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromTensorProductToInternalHom</C>.
#! $F: ( a^{\vee} \otimes b, a, b, \mathrm{\underline{Hom}}(a,b) ) \mapsto \mathrm{MorphismFromTensorProductToInternalHom}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{IsomorphismFromTensorProductToInternalHom}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b, \mathrm{\underline{Hom}}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromTensorProductToInternalHom</C>.
#! $F: ( a, b ) \mapsto \mathrm{IsomorphismFromTensorProductToInternalHom}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{MorphismFromTensorProductToInternalHom}$, namely
#! $\mathrm{MorphismFromInternalHomToTensorProduct}_{a,b}: \mathrm{\underline{Hom}}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b), a^{\vee} \otimes b )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );


#! @Description
#! The arguments are an object $s = \mathrm{\underline{Hom}}(a,b)$,
#! two objects $a,b$,
#! and an object $r = a^{\vee} \otimes b$.
#! The output is the inverse of $\mathrm{MorphismFromTensorProductToInternalHom}$, namely
#! $\mathrm{MorphismFromInternalHomToTensorProduct}_{a,b}: \mathrm{\underline{Hom}}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b), a^{\vee} \otimes b )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromInternalHomToTensorProduct</C>.
#! $F: ( \mathrm{\underline{Hom}}(a,b),a,b,a^{\vee} \otimes b ) \mapsto \mathrm{MorphismFromInternalHomToTensorProduct}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of $\mathrm{IsomorphismFromTensorProductToInternalHom}$, namely
#! $\mathrm{IsomorphismFromInternalHomToTensorProduct}_{a,b}: \mathrm{\underline{Hom}}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b), a^{\vee} \otimes b )$.
#! @Arguments a,b
DeclareOperation( "IsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromInternalHomToTensorProduct</C>.
#! $F: ( a,b ) \mapsto \mathrm{IsomorphismFromInternalHomToTensorProduct}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $\alpha$.
#! The output is the trace morphism $\mathrm{trace}_{\alpha}: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments alpha
DeclareAttribute( "TraceMap",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TraceMap</C>.
#! $F: \alpha \mapsto \mathrm{trace}_{\alpha}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the rank morphism $\mathrm{rank}_a: 1 \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}(1,1)$.
#! @Arguments a
DeclareAttribute( "RankMorphism",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>RankMorphism</C>.
#! $F: a \mapsto \mathrm{rank}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromDualToInternalHom}_{a}: a^{\vee} \rightarrow \mathrm{Hom}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a^{\vee}, \mathrm{Hom}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromDualToInternalHom",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromDualToInternalHom</C>.
#! $F: a \mapsto \mathrm{IsomorphismFromDualToInternalHom}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromInternalHomToDual}_{a}: \mathrm{Hom}(a,1) \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Hom}(a,1), a^{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromInternalHomToDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromInternalHomToDual</C>.
#! $F: a \mapsto \mathrm{IsomorphismFromInternalHomToDual}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInternalHomToDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalHomToDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToDual",
                  [ IsCapCategory, IsList ] );


## input: (t, a, mu: t tensor a -> 1)
##
#! @Description
#! The arguments are two objects $t,a$,
#! and a morphism $\alpha: t \otimes a \rightarrow 1$.
#! The output is the morphism $t \rightarrow a^{\vee}$
#! given by the universal property of $a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(t, a^{\vee})$.
DeclareOperation( "UniversalPropertyOfDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalPropertyOfDual</C>.
#! $F: ( t,a,\alpha: t \otimes a \rightarrow 1 ) \mapsto ( t \rightarrow a^{\vee} )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is the corresponding morphism $1 \rightarrow \mathrm{\underline{Hom}}(a,b)$
#! under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( 1, \mathrm{\underline{Hom}}(a,b) )$.
#! @Arguments alpha
DeclareAttribute( "LambdaIntroduction",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>LambdaIntroduction</C>.
#! $F: ( \alpha: a \rightarrow b ) \mapsto ( 1 \rightarrow \mathrm{\underline{Hom}}(a,b) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$,
#! and a morphism $\alpha: 1 \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! The output is a morphism $a \rightarrow b$ corresponding to $\alpha$
#! under the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$.
#! @Arguments a,b,alpha
DeclareOperation( "LambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>LambdaElimination</C>.
#! $F: ( a,b,\alpha: 1 \rightarrow \mathrm{\underline{Hom}}(a,b) ) \mapsto ( a \rightarrow b )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{Hom}}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{\underline{Hom}}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromObjectToInternalHom",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = \mathrm{\underline{Hom}}(1,a)$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{\underline{Hom}}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{\underline{Hom}}(1,a))$.
#! @Arguments a,r
DeclareOperation( "IsomorphismFromObjectToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromObjectToInternalHom</C>.
#! $F: ( a, \mathrm{\underline{Hom}}(1,a) ) \mapsto ( a \rightarrow \mathrm{\underline{Hom}}(1,a) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromObjectToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHom",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $\mathrm{\underline{Hom}}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{Hom}}(1,a),a)$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromInternalHomToObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = \mathrm{\underline{Hom}}(1,a)$.
#! The output is the natural isomorphism $\mathrm{\underline{Hom}}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{Hom}}(1,a),a)$.
#! @Arguments a,s
DeclareOperation( "IsomorphismFromInternalHomToObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromInternalHomToObject</C>.
#! $F: ( a, \mathrm{\underline{Hom}}(1,a) ) \mapsto ( \mathrm{\underline{Hom}}(1,a) \rightarrow a )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInternalHomToObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObject",
                  [ IsCapCategory, IsList ] );

####################################
##
#! @Section Rigid Symmetric Closed Monoidal Categories
##
####################################

#! A symmetric closed monoidal category $\mathbf{C}$ satisfying
#! * the natural morphism
#!  $\underline{\mathrm{Hom}}(a_1,b_1) \otimes \underline{\mathrm{Hom}}(a_2,b_2) \rightarrow \underline{\mathrm{Hom}}(a_1 \otimes a_2,b_1 \otimes b_2)$
#!  is an isomorphism,
#! * the natural morphism
#!  $a \rightarrow \underline{\mathrm{Hom}}(\underline{\mathrm{Hom}}(a, 1), 1)$
#!  is an isomorphism
#! is called a <Emph>rigid symmetric closed monoidal category</Emph>.

##
#! @Description
#! The arguments are four objects $a, a', b, b'$.
#! The output is the natural morphism
#! $\mathrm{TensorProductInternalHomCompatibilityMorphismInverse}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') \rightarrow \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b'), \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'))$.
#! @Arguments a,a',b,b'
DeclareOperation( "TensorProductInternalHomCompatibilityMorphismInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

##
## The new_source and new_range arguments are the first and second element of the list.
## This construction is due to the fact that the maximal number of arguments for an operation is 6,
## but a basic operation with 6 arguments would install a setter having 7 arguments.
#! @Description
#! The arguments are four objects $a, a', b, b'$,
#! and a list $L = [ \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') ]$.
#! The output is the natural morphism
#! $\mathrm{TensorProductInternalHomCompatibilityMorphismInverse}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') \rightarrow \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b'), \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'))$.
#! @Arguments a,a',b,b',L
DeclareOperation( "TensorProductInternalHomCompatibilityMorphismInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TensorProductInternalHomCompatibilityMorphismInverse</C>.
#! $F: ( a,a',b,b', [ \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') ]) \mapsto \mathrm{TensorProductInternalHomCompatibilityMorphismInverse}_{a,a',b,b'}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverse",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the morphism to the bidual $(a^{\vee})^{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a^{\vee})^{\vee},a)$.
#! @Arguments a
DeclareAttribute( "MorphismFromBidual",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = (a^{\vee})^{\vee}$.
#! The output is the inverse of the morphism to the bidual $(a^{\vee})^{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a^{\vee})^{\vee},a)$.
#! @Arguments a
DeclareOperation( "MorphismFromBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromBidual</C>.
#! $F: (a, (a^{\vee})^{\vee}) \mapsto ((a^{\vee})^{\vee} \rightarrow a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsList ] );

