####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Closed Monoidal Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_CLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsClosedMonoidalCategory  := Concatenation( [
"InternalHomOnObjects",
"InternalHomOnMorphismsWithGivenInternalHoms",
"EvaluationMorphismWithGivenSource",
"CoevaluationMorphismWithGivenRange"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsMonoidalCategory );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal hom object $\mathrm{\underline{Hom}}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "InternalHomOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>InternalHomOnObjects</C>.
#! $F: (a,b) \mapsto \mathrm{\underline{Hom}}(a,b)$.
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
#! $\mathrm{\underline{Hom}}(\alpha,\beta): \mathrm{\underline{Hom}}(a',b) \rightarrow \mathrm{\underline{Hom}}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a',b), \mathrm{\underline{Hom}}(a,b') )$
#! @Arguments alpha, beta
DeclareOperation( "InternalHomOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{\underline{Hom}}(a',b)$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{\underline{Hom}}(a,b')$.
#! The output is the internal hom morphism
#! $\mathrm{\underline{Hom}}(\alpha,\beta): \mathrm{\underline{Hom}}(a',b) \rightarrow \mathrm{\underline{Hom}}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{Hom}}(a',b), \mathrm{\underline{Hom}}(a,b') )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "InternalHomOnMorphismsWithGivenInternalHoms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>InternalHomOnMorphismsWithGivenInternalHoms</C>.
#! $F: (\mathrm{\underline{Hom}}(a',b), \alpha: a \rightarrow a', \beta: b \rightarrow b', \mathrm{\underline{Hom}}(a,b') ) \mapsto \mathrm{\underline{Hom}}(\alpha,\beta)$.
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
#! This operation adds the given function $F$
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
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{\underline{Hom}}(b, a \otimes b)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}}(b, a \otimes b) )$.
#! @Arguments a,b
DeclareOperation( "CoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## the last argument is $\mathrm{\underline{Hom}}(b, a \otimes b)$
#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{\underline{Hom}}(b, a \otimes b)$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{\underline{Hom}}(b, a \otimes b)$, i.e.,
#! the unit of the tensor hom adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{\underline{Hom}}(b, a \otimes b) )$.
#! @Arguments a,b,r
DeclareOperation( "CoevaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
#! to the category for the basic operation <C>InternalHomToTensorProductAdjunctionMap</C>.
#! $F: (b, c, g: a \rightarrow \mathrm{\underline{Hom}}(b,c)) \mapsto ( f: a \otimes b \rightarrow c )$.
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromDualToInternalHom}_{a}: a^{\vee} \rightarrow \mathrm{\underline{Hom}}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a^{\vee}, \mathrm{\underline{Hom}}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromDualToInternalHom",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
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
#! $\mathrm{IsomorphismFromInternalHomToDual}_{a}: \mathrm{\underline{Hom}}(a,1) \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{Hom}}(a,1), a^{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromInternalHomToDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! This operation adds the given function $F$
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
#! @Section Convenience Methods
##
####################################

##
#! @Description
#! This is a convenience method.
#! The arguments are two cells $a,b$.
#! The output is the internal hom cell.
#! If $a,b$ are two CAP objects the output is the internal Hom object
#! $\mathrm{\underline{Hom}}(a,b)$.
#! If at least on of the arguments is a CAP morphism the output is a CAP morphism,
#! namely the internal Hom on morphisms, where any object is replaced by its identity morphism.
#! @Returns a cell
#! @Arguments a, b
DeclareOperation( "InternalHom",
                  [ IsCapCategoryCell, IsCapCategoryCell ] );
