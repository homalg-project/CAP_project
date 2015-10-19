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

DeclareGlobalVariable( "CAP_INTERNAL_MONOIDAL_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

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

## TensorProductOnMorphismsWithGivenTensorProducts

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
DeclareOperation( "TensorProductOnMorphismsWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>TensorProductOnMorphismsWithGivenTensorProducts</C>.
#! $F: ( a \otimes b, \alpha: a \rightarrow a', \beta: b \rightarrow b', a' \otimes b' ) \mapsto \alpha \otimes \beta$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductOnMorphismsWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductOnMorphismsWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductOnMorphismsWithGivenTensorProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductOnMorphismsWithGivenTensorProducts",
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
DeclareOperation( "AssociatorRightToLeftWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>AssociatorRightToLeftWithGivenTensorProducts</C>.
#! $F: ( a \otimes (b \otimes c), a, b, c, (a \otimes b) \otimes c ) \mapsto \alpha_{a,(b,c)}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorRightToLeftWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorRightToLeftWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeftWithGivenTensorProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeftWithGivenTensorProducts",
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
DeclareOperation( "AssociatorLeftToRightWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>AssociatorLeftToRightWithGivenTensorProducts</C>.
#! $F: (( a \otimes b ) \otimes c, a, b, c, a \otimes (b \otimes c )) \mapsto \alpha_{(a,b),c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorLeftToRightWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorLeftToRightWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRightWithGivenTensorProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRightWithGivenTensorProducts",
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
DeclareOperation( "LeftUnitorWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>LeftUnitorWithGivenTensorProduct</C>.
#! $F: (a, 1 \otimes a) \mapsto \lambda_a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitorWithGivenTensorProduct",
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
DeclareOperation( "LeftUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>LeftUnitorInverseWithGivenTensorProduct</C>.
#! $F: (a, 1 \otimes a) \mapsto \lambda_a^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftUnitorInverseWithGivenTensorProduct",
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
DeclareOperation( "RightUnitorWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>RightUnitorWithGivenTensorProduct</C>.
#! $F: (a, a \otimes 1) \mapsto \rho_a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitorWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitorWithGivenTensorProduct",
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
DeclareOperation( "RightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>RightUnitorInverseWithGivenTensorProduct</C>.
#! $F: (a, a \otimes 1) \mapsto \rho_a^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $a \otimes (b_1 \oplus \dots \oplus b_n) \rightarrow (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes (b_1 \oplus \dots \oplus b_n), (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftDistributivityExpanding",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = a \otimes (b_1 \oplus \dots \oplus b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>LeftDistributivityExpandingWithGivenObjects</C>.
#! $F: (a \otimes (b_1 \oplus \dots \oplus b_n), a, L, (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)) \mapsto \mathrm{LeftDistributivityExpandingWithGivenObjects}(a,L)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $(a \otimes b_1) \oplus \dots \oplus (a \otimes b_n) \rightarrow a \otimes (b_1 \oplus \dots \oplus b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n), a \otimes (b_1 \oplus \dots \oplus b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftDistributivityFactoring",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = a \otimes (b_1 \oplus \dots \oplus b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>LeftDistributivityFactoringWithGivenObjects</C>.
#! $F: ((a \otimes b_1) \oplus \dots \oplus (a \otimes b_n), a, L, a \otimes (b_1 \oplus \dots \oplus b_n)) \mapsto \mathrm{LeftDistributivityFactoringWithGivenObjects}(a,L)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \oplus \dots \oplus b_n) \otimes a \rightarrow (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)$.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \oplus \dots \oplus b_n) \otimes a, (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a) )$
#! @Arguments L, a
DeclareOperation( "RightDistributivityExpanding",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \oplus \dots \oplus b_n) \otimes a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>RightDistributivityExpandingWithGivenObjects</C>.
#! $F: ((b_1 \oplus \dots \oplus b_n) \otimes a, L, a, (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)) \mapsto \mathrm{RightDistributivityExpandingWithGivenObjects}(L,a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a) \rightarrow (b_1 \oplus \dots \oplus b_n) \otimes a $.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a), (b_1 \oplus \dots \oplus b_n) \otimes a)$
#! @Arguments L, a
DeclareOperation( "RightDistributivityFactoring",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \oplus \dots \oplus b_n) \otimes a$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>RightDistributivityFactoringWithGivenObjects</C>.
#! $F: ((b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a), L, a, (b_1 \oplus \dots \oplus b_n) \otimes a) \mapsto \mathrm{RightDistributivityFactoringWithGivenObjects}(L,a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightDistributivityFactoringWithGivenObjects",
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
DeclareOperation( "BraidingWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>BraidingWithGivenTensorProducts</C>.
#! $F: (a \otimes b, a, b, b \otimes a) \rightarrow B_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
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
DeclareOperation( "BraidingInverseWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>BraidingInverseWithGivenTensorProducts</C>.
#! $F: (b \otimes a, a, b, a \otimes b) \rightarrow B_{a,b}^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
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
DeclareOperation( "InternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>InternalHomOnMorphismsWithGivenInternalHoms</C>.
#! $F: (\underline{\mathrm{Hom}}(a',b), \alpha: a \rightarrow a', \beta: b \rightarrow b', \underline{\mathrm{Hom}}(a,b') ) \mapsto \underline{\mathrm{Hom}}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomOnMorphismsWithGivenInternalHoms",
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
DeclareOperation( "EvaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>EvaluationMorphismWithGivenSource</C>.
#! $F: (a, b, \mathrm{\underline{Hom}}(a,b) \otimes a) \mapsto \mathrm{ev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEvaluationMorphismWithGivenSource",
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
DeclareOperation( "CoevaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>CoevaluationMorphismWithGivenRange</C>.
#! $F: (a, b, \mathrm{\underline{Hom}}(b, a \otimes b)) \mapsto \mathrm{coev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoevaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationMorphismWithGivenRange",
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
#! $\mathrm{MonoidalPreComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
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
#! $\mathrm{MonoidalPreComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c), \mathrm{\underline{Hom}}(a,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPreComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MonoidalPreComposeMorphismWithGivenObjects</C>.
#! $F: (\mathrm{\underline{Hom}}(a,b) \otimes \mathrm{\underline{Hom}}(b,c),a,b,c,\mathrm{\underline{Hom}}(a,c)) \mapsto \mathrm{MonoidalPreComposeMorphismWithGivenObjects}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMonoidalPreComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPreComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPreComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPreComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcomposition morphism
#! $\mathrm{MonoidalPostComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
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
#! $\mathrm{MonoidalPostComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b) \rightarrow \mathrm{\underline{Hom}}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b), \mathrm{\underline{Hom}}(a,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPostComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MonoidalPostComposeMorphismWithGivenObjects</C>.
#! $F: (\mathrm{\underline{Hom}}(b,c) \otimes \mathrm{\underline{Hom}}(a,b),a,b,c,\mathrm{\underline{Hom}}(a,c)) \mapsto \mathrm{MonoidalPostComposeMorphismWithGivenObjects}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMonoidalPostComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPostComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPostComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPostComposeMorphismWithGivenObjects",
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
DeclareOperation( "DualOnMorphismsWithGivenDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DualOnMorphismsWithGivenDuals</C>.
#! $F: (b^{\vee},\alpha,a^{\vee}) \mapsto \alpha^{\vee}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDualOnMorphismsWithGivenDuals",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualOnMorphismsWithGivenDuals",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualOnMorphismsWithGivenDuals",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualOnMorphismsWithGivenDuals",
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
DeclareOperation( "EvaluationForDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>EvaluationForDualWithGivenTensorProduct</C>.
#! $F: (a^{\vee} \otimes a, a, 1) \mapsto \mathrm{ev}_{a}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddEvaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEvaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEvaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEvaluationForDualWithGivenTensorProduct",
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
DeclareOperation( "CoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoevaluationForDualWithGivenTensorProduct</C>.
#! $F: (1, a, a \otimes a^{\vee}) \mapsto \mathrm{coev}_{a}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
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
DeclareOperation( "MorphismToBidualWithGivenBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismToBidualWithGivenBidual</C>.
#! $F: (a, (a^{\vee})^{\vee}) \mapsto (a \rightarrow (a^{\vee})^{\vee})$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismToBidualWithGivenBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToBidualWithGivenBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToBidualWithGivenBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToBidualWithGivenBidual",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are four objects $a, a', b, b'$.
#! The output is the natural morphism
#! $\mathrm{TensorProductInternalHomCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b') \rightarrow \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b')$.
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
#! $\mathrm{TensorProductInternalHomCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b') \rightarrow \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b'))$.
#! @Arguments a,a',b,b',L
DeclareOperation( "TensorProductInternalHomCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TensorProductInternalHomCompatibilityMorphismWithGivenObjects</C>.
#! $F: ( a,a',b,b', [ \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') ]) \mapsto \mathrm{TensorProductInternalHomCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{TensorProductDualityCompatibilityMorphismWithGivenObjects}: a^{\vee} \otimes b^{\vee} \rightarrow (a \otimes b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b^{\vee}, (a \otimes b)^{\vee} )$.
#! @Arguments a,b
DeclareOperation( "TensorProductDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes b^{\vee}$,
#! two objects $a,b$,
#! and an object $r = (a \otimes b)^{\vee}$.
#! The output is the natural morphism
#! $\mathrm{TensorProductDualityCompatibilityMorphismWithGivenObjects}_{a,b}: a^{\vee} \otimes b^{\vee} \rightarrow (a \otimes b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b^{\vee}, (a \otimes b)^{\vee} )$.
#! @Arguments s,a,b,r
DeclareOperation( "TensorProductDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TensorProductDualityCompatibilityMorphismWithGivenObjects</C>.
#! $F: ( a^{\vee} \otimes b^{\vee}, a, b, (a \otimes b)^{\vee} ) \mapsto \mathrm{TensorProductDualityCompatibilityMorphismWithGivenObjects}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromTensorProductToInternalHomWithGivenObjects}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b, \mathrm{\underline{Hom}}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \otimes b$,
#! two objects $a,b$,
#! and an object $r = \mathrm{\underline{Hom}}(a,b)$.
#! The output is the natural morphism $\mathrm{MorphismFromTensorProductToInternalHomWithGivenObjects}_{a,b}: a^{\vee} \otimes b \rightarrow \mathrm{\underline{Hom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \otimes b, \mathrm{\underline{Hom}}(a,b) )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromTensorProductToInternalHomWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromTensorProductToInternalHomWithGivenObjects</C>.
#! $F: ( a^{\vee} \otimes b, a, b, \mathrm{\underline{Hom}}(a,b) ) \mapsto \mathrm{MorphismFromTensorProductToInternalHomWithGivenObjects}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromTensorProductToInternalHomWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHomWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHomWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHomWithGivenObjects",
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
#! The output is the inverse of $\mathrm{MorphismFromTensorProductToInternalHomWithGivenObjects}$, namely
#! $\mathrm{MorphismFromInternalHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{Hom}}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b), a^{\vee} \otimes b )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );


#! @Description
#! The arguments are an object $s = \mathrm{\underline{Hom}}(a,b)$,
#! two objects $a,b$,
#! and an object $r = a^{\vee} \otimes b$.
#! The output is the inverse of $\mathrm{MorphismFromTensorProductToInternalHomWithGivenObjects}$, namely
#! $\mathrm{MorphismFromInternalHomToTensorProductWithGivenObjects}_{a,b}: \mathrm{\underline{Hom}}(a,b) \rightarrow a^{\vee} \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b), a^{\vee} \otimes b )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromInternalHomToTensorProductWithGivenObjects</C>.
#! $F: ( \mathrm{\underline{Hom}}(a,b),a,b,a^{\vee} \otimes b ) \mapsto \mathrm{MorphismFromInternalHomToTensorProductWithGivenObjects}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
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
#! @Arguments t, a, alpha
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
DeclareOperation( "IsomorphismFromObjectToInternalHomWithGivenInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromObjectToInternalHomWithGivenInternalHom</C>.
#! $F: ( a, \mathrm{\underline{Hom}}(1,a) ) \mapsto ( a \rightarrow \mathrm{\underline{Hom}}(1,a) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromObjectToInternalHomWithGivenInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHomWithGivenInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHomWithGivenInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHomWithGivenInternalHom",
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
DeclareOperation( "IsomorphismFromInternalHomToObjectWithGivenInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromInternalHomToObjectWithGivenInternalHom</C>.
#! $F: ( a, \mathrm{\underline{Hom}}(1,a) ) \mapsto ( \mathrm{\underline{Hom}}(1,a) \rightarrow a )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInternalHomToObjectWithGivenInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObjectWithGivenInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObjectWithGivenInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObjectWithGivenInternalHom",
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
#! $\mathrm{TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') \rightarrow \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b')$.
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
#! $\mathrm{TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}: \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') \rightarrow \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b'), \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'))$.
#! @Arguments a,a',b,b',L
DeclareOperation( "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects</C>.
#! $F: ( a,a',b,b', [ \mathrm{\underline{Hom}}(a,a') \otimes \mathrm{\underline{Hom}}(b,b'), \mathrm{\underline{Hom}}(a \otimes b,a' \otimes b') ]) \mapsto \mathrm{TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects}_{a,a',b,b'}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
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
#! @Arguments a, s
DeclareOperation( "MorphismFromBidualWithGivenBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromBidualWithGivenBidual</C>.
#! $F: (a, (a^{\vee})^{\vee}) \mapsto ((a^{\vee})^{\vee} \rightarrow a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsList ] );

DeclareGlobalFunction( "CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION_FOR_MONOIDAL_CATEGORIES" );

