# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Monoidal Categories
##
####################################

DeclareGlobalVariable( "MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

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
#! The argument is an object $a$.
#! The output is the left unitor $\lambda_a: 1 \otimes a \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(1 \otimes a, a)$
#! @Arguments a
DeclareAttribute( "LeftUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ and an object $s = 1 \otimes a$.
#! The output is the left unitor $\lambda_a: 1 \otimes a \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(1 \otimes a, a)$
#! @Arguments a, s
DeclareOperation( "LeftUnitorWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

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
#! The argument is an object $a$.
#! The output is the right unitor $\rho_a: a \otimes 1 \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes 1, a)$
#! @Arguments a
DeclareAttribute( "RightUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ and an object $s = a \otimes 1$.
#! The output is the right unitor $\rho_a: a \otimes 1 \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(a \otimes 1, a)$
#! @Arguments a, s
DeclareOperation( "RightUnitorWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the right unitor $\rho_a^{-1}: a \rightarrow a \otimes 1$.
#! @Returns a morphism in $\mathrm{Hom}(a, a \otimes 1)$
#! @Arguments a
DeclareAttribute( "RightUnitorInverse",
                  IsCapCategoryObject );

# the second argument is the given tensor product
#! @Description
#! The arguments are an object $a$ and an object $r = a \otimes 1$.
#! The output is the inverse of the right unitor $\rho_a^{-1}: a \rightarrow a \otimes 1$.
#! @Returns a morphism in $\mathrm{Hom}(a, a \otimes 1)$
#! @Arguments a, r
DeclareOperation( "RightUnitorInverseWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );
