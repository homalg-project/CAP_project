#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Monoidal Categories
#!
##
#############################################################################

####################################
##
#! @Section Basic Operations for Monoidal Categories
##
####################################

## TensorProductOnObjects

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the tensor product $a \otimes b$.
#! @Returns an object
#! @Arguments a,b
DeclareOperationWithCache( "TensorProductOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>TensorProductOnObjects</C>.
#! $f: (a,b) \mapsto a \otimes b$.
#! @Returns nothing
#! @Arguments C, f
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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>TensorProductOnMorphisms</C>.
#! $f: ( \alpha, \beta ) \mapsto \alpha \otimes \beta$.
#! @Returns nothing
#! @Arguments C, f
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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>AssociatorRightToLeft</C>.
#! $f: ( a \otimes (b \otimes c), a, b, c, (a \otimes b) \otimes c ) \mapsto \alpha_{a,(b,c)}$.
#! @Returns nothing
#! @Arguments C, f
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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>AssociatorLeftToRight</C>.
#! $f: ( a \otimes b ) \otimes c, a, b, c, a \otimes (b \otimes c ) \mapsto \alpha_{(a,b),c}$.
#! @Returns nothing
#! @Arguments C, f
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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>TensorUnit</C>.
#! $f: ( ) \mapsto 1$.
#! @Returns nothing
#! @Arguments C, f
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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>LeftUnitor</C>.
#! $f: (a, 1 \otimes a) \mapsto \lambda_a$.
#! @Returns nothing
#! @Arguments C, f
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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>LeftUnitorInverse</C>.
#! $f: (a, 1 \otimes a) \mapsto \lambda_a^{-1}$.
#! @Returns nothing
#! @Arguments C, f
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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>RightUnitor</C>.
#! $f: (a, a \otimes 1) \mapsto \rho_a$.
#! @Returns nothing
#! @Arguments C, f
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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>RightUnitorInverse</C>.
#! $f: (a, a \otimes 1) \mapsto \rho_a^{-1}$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightUnitorInverse",
                  [ IsCapCategory, IsList ] );


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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>Braiding</C>.
#! $f: (a \otimes b, a, b, b \otimes a) \rightarrow B_{a,b}$.
#! @Returns nothing
#! @Arguments C, f
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
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>BraidingInverse</C>.
#! $f: (b \otimes a, a, b, a \otimes b) \rightarrow B_{a,b}^{-1}$.
#! @Returns nothing
#! @Arguments C, f
DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingInverse",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal hom object $\underline{\mathrm{Hom}}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "InternalHomOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>InternalHomOnObjects</C>.
#! $f: (a,b) \mapsto \underline{\mathrm{Hom}}(a,b)$.
#! @Returns nothing
#! @Arguments C, f
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
#! The output is the internal hom morphism $\underline{\mathrm{Hom}}(\alpha,\beta)$.
#! @Returns a morphism in $\mathrm{Hom}( \underline{\mathrm{Hom}}(a',b), \underline{\mathrm{Hom}}(a,b') )$
#! @Arguments alpha, beta
DeclareOperation( "InternalHomOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \underline{\mathrm{Hom}}(a',b)$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \underline{\mathrm{Hom}}(a,b')$.
#! The output is the internal hom morphism $\underline{\mathrm{Hom}}(\alpha,\beta)$.
#! @Returns a morphism in $\mathrm{Hom}( \underline{\mathrm{Hom}}(a',b), \underline{\mathrm{Hom}}(a,b') )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "InternalHomOnMorphisms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $f$.
#! This operations adds the given function $f$ 
#! to the category for the basic operation <C>InternalHomOnMorphisms</C>.
#! $f: (\underline{\mathrm{Hom}}(a',b), \alpha: a \rightarrow a', \beta: b \rightarrow b', \underline{\mathrm{Hom}}(a,b') ) \mapsto \underline{\mathrm{Hom}}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, f
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
#! The output is the evaluation morphism $\mathrm{\underline{Hom}}(a,b) \otimes a \rightarrow b$, i.e.,
#! the counit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a,b) \otimes a, b )$.
#! @Arguments a,b
DeclareOperation( "EvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## 3rd argument is $\mathrm{\underline{Hom}}(a,b) \otimes a$
DeclareOperation( "EvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

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
#! The output is the coevaluation morphism $a \rightarrow \mathrm{\underline{Hom}(b, a \otimes b)}$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}}(b, a \otimes b) )$.
#! @Arguments a,b
DeclareOperation( "CoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## the last argument is $\mathrm{\underline{Hom}}(b, a \otimes b)$
DeclareOperation( "CoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

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

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "MonoidalPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "MonoidalPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPreComposeMorphism",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "MonoidalPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "MonoidalPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPostComposeMorphism",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "DualOnObjects",
                  IsCapCategoryObject );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualOnObjects",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "DualOnMorphisms",
                  IsCapCategoryMorphism );

DeclareOperation( "DualOnMorphisms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualOnMorphisms",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "EvaluationForDual",
                  IsCapCategoryObject );

## [ Dual( a ) tensored a, a, TensorUnit ]
DeclareOperation( "EvaluationForDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddEvaluationForDual",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "CoevaluationForDual",
                  IsCapCategoryObject );

## [ 1, a, a tensored Dual( a ) ]
DeclareOperation( "CoevaluationForDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "MorphismToBidual",
                  IsCapCategoryObject );

## the second argument is the bidual
DeclareOperation( "MorphismToBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToBidual",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "MorphismFromBidual",
                  IsCapCategoryObject );

## the second argument is the bidual
DeclareOperation( "MorphismFromBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "TensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

##
## The new_source and new_range arguments are the first and second element of the list.
## This construction is due to the fact that the maximal number of arguments for an operation is 6,
## but a basic operation with 6 arguments would install a setter having 7 arguments.
DeclareOperation( "TensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphism",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "TensorProductDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "TensorProductDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductDualityCompatibilityMorphism",
                  [ IsCapCategory, IsList ] );


##
DeclareOperation( "MorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "MorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "IsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalHom",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "MorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "MorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "IsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "TraceMap",
                  IsCapCategoryMorphism );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "RankMorphism",
                  IsCapCategoryObject );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsList ] );


##
DeclareAttribute( "IsomorphismFromDualToInternalHom",
                  IsCapCategoryObject );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromDualToInternalHom",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "IsomorphismFromInternalHomToDual",
                  IsCapCategoryObject );

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
DeclareOperation( "UniversalPropertyOfDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfDual",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "LambdaIntroduction",
                  IsCapCategoryMorphism );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLambdaIntroduction",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "LambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLambdaElimination",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "IsomorphismFromObjectToInternalHom",
                  [ IsCapCategoryObject ] );

DeclareOperation( "IsomorphismFromObjectToInternalHom",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToInternalHom",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "IsomorphismFromInternalHomToObject",
                  [ IsCapCategoryObject] );

DeclareOperation( "IsomorphismFromInternalHomToObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalHomToObject",
                  [ IsCapCategory, IsList ] );


