####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Closed Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_CARTESIAN_CLOSED_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianClosedCategory  := Concatenation( [
"ExponentialOnObjects",
"ExponentialOnMorphismsWithGivenExponentials",
"CartesianEvaluationMorphismWithGivenSource",
"CartesianCoevaluationMorphismWithGivenRange"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal hom object $\mathrm{Exponential}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "ExponentialOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ExponentialOnObjects</C>.
#! $F: (a,b) \mapsto \mathrm{Exponential}(a,b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddExponentialOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExponentialOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddExponentialOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddExponentialOnObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal hom morphism
#! $\mathrm{Exponential}(\alpha,\beta): \mathrm{Exponential}(a',b) \rightarrow \mathrm{Exponential}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a',b), \mathrm{Exponential}(a,b') )$
#! @Arguments alpha, beta
DeclareOperation( "ExponentialOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{Exponential}(a',b)$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{Exponential}(a,b')$.
#! The output is the internal hom morphism
#! $\mathrm{Exponential}(\alpha,\beta): \mathrm{Exponential}(a',b) \rightarrow \mathrm{Exponential}(a,b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a',b), \mathrm{Exponential}(a,b') )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "ExponentialOnMorphismsWithGivenExponentials",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ExponentialOnMorphismsWithGivenExponentials</C>.
#! $F: (\mathrm{Exponential}(a',b), \alpha: a \rightarrow a', \beta: b \rightarrow b', \mathrm{Exponential}(a,b') ) \mapsto \mathrm{Exponential}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddExponentialOnMorphismsWithGivenExponentials",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExponentialOnMorphismsWithGivenExponentials",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddExponentialOnMorphismsWithGivenExponentials",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddExponentialOnMorphismsWithGivenExponentials",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a, b$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{Exponential}(a,b) \times a \rightarrow b$, i.e.,
#! the counit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,b) \times a, b )$.
#! @Arguments a,b
DeclareOperation( "CartesianEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## 3rd argument is $\mathrm{Exponential}(a,b) \times a$
#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{Exponential}(a,b) \times a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a,b}: \mathrm{Exponential}(a,b) \times a \rightarrow b$, i.e.,
#! the counit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,b) \times a, b )$.
#! @Arguments a,b, s
DeclareOperation( "CartesianEvaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CartesianEvaluationMorphismWithGivenSource</C>.
#! $F: (a, b, \mathrm{Exponential}(a,b) \times a) \mapsto \mathrm{ev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{Exponential}(b, a \times b)$, i.e.,
#! the unit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Exponential}(b, a \times b) )$.
#! @Arguments a,b
DeclareOperation( "CartesianCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## the last argument is $\mathrm{Exponential}(b, a \times b)$
#! @Description
#! The arguments are two objects $a,b$ and an object $r = \mathrm{Exponential}(b, a \times b)$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow \mathrm{Exponential}(b, a \times b)$, i.e.,
#! the unit of the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Exponential}(b, a \times b) )$.
#! @Arguments a,b,r
DeclareOperation( "CartesianCoevaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CartesianCoevaluationMorphismWithGivenRange</C>.
#! $F: (a, b, \mathrm{Exponential}(b, a \times b)) \mapsto \mathrm{coev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianCoevaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianCoevaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianCoevaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianCoevaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are objects $a,b$ and a morphism $f: a \times b \rightarrow c$.
#! The output is a morphism $g: a \rightarrow \mathrm{Exponential}(b,c)$
#! corresponding to $f$ under the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, \mathrm{Exponential}(b,c) )$.
#! @Arguments a, b, f
DeclareOperation( "DirectProductToExponentialAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectProductToExponentialAdjunctionMap</C>.
#! $F: (a, b, f: a \times b \rightarrow c) \mapsto ( g: a \rightarrow \mathrm{Exponential}(b,c) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectProductToExponentialAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectProductToExponentialAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectProductToExponentialAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectProductToExponentialAdjunctionMap",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are objects $b,c$ and a morphism $g: a \rightarrow \mathrm{Exponential}(b,c)$.
#! The output is a morphism $f: a \times b \rightarrow c$ corresponding to $g$ under the
#! direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a \times b, c)$.
#! @Arguments b, c, g
DeclareOperation( "ExponentialToDirectProductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>ExponentialToDirectProductAdjunctionMap</C>.
#! $F: (b, c, g: a \rightarrow \mathrm{Exponential}(b,c)) \mapsto ( f: a \times b \rightarrow c )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddExponentialToDirectProductAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExponentialToDirectProductAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddExponentialToDirectProductAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddExponentialToDirectProductAdjunctionMap",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precomposition morphism
#! $\mathrm{CartesianPreComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c) \rightarrow \mathrm{Exponential}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c), \mathrm{Exponential}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "CartesianPreComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{Exponential}(a,c)$.
#! The output is the precomposition morphism
#! $\mathrm{CartesianPreComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c) \rightarrow \mathrm{Exponential}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c), \mathrm{Exponential}(a,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "CartesianPreComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CartesianPreComposeMorphismWithGivenObjects</C>.
#! $F: (\mathrm{Exponential}(a,b) \times \mathrm{Exponential}(b,c),a,b,c,\mathrm{Exponential}(a,c)) \mapsto \mathrm{CartesianPreComposeMorphismWithGivenObjects}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianPreComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianPreComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianPreComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianPreComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcomposition morphism
#! $\mathrm{CartesianPostComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b) \rightarrow \mathrm{Exponential}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b), \mathrm{Exponential}(a,c) )$.
#! @Arguments a,b,c
DeclareOperation( "CartesianPostComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{Exponential}(a,c)$.
#! The output is the postcomposition morphism
#! $\mathrm{CartesianPostComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b) \rightarrow \mathrm{Exponential}(a,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b), \mathrm{Exponential}(a,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "CartesianPostComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CartesianPostComposeMorphismWithGivenObjects</C>.
#! $F: (\mathrm{Exponential}(b,c) \times \mathrm{Exponential}(a,b),a,b,c,\mathrm{Exponential}(a,c)) \mapsto \mathrm{CartesianPostComposeMorphismWithGivenObjects}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianPostComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianPostComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianPostComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianPostComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is its dual object $a^{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "CartesianDualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CartesianDualOnObjects</C>.
#! $F: a \mapsto a^{\vee}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianDualOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianDualOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianDualOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianDualOnObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b^{\vee}, a^{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "CartesianDualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b^{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a^{\vee}$.
#! The output is the dual morphism $\alpha^{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b^{\vee}, a^{\vee} )$.
#! @Arguments s,alpha,r
DeclareOperation( "CartesianDualOnMorphismsWithGivenCartesianDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CartesianDualOnMorphismsWithGivenCartesianDuals</C>.
#! $F: (b^{\vee},\alpha,a^{\vee}) \mapsto \alpha^{\vee}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianDualOnMorphismsWithGivenCartesianDuals",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianDualOnMorphismsWithGivenCartesianDuals",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianDualOnMorphismsWithGivenCartesianDuals",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianDualOnMorphismsWithGivenCartesianDuals",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \times a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times a, 1 )$.
#! @Arguments a
DeclareAttribute( "CartesianEvaluationForCartesianDual",
                  IsCapCategoryObject );


#! @Description
#! The arguments are an object $s = a^{\vee} \times a$,
#! an object $a$,
#! and an object $r = 1$.
#! The output is the evaluation morphism $\mathrm{ev}_{a}: a^{\vee} \times a \rightarrow 1$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times a, 1 )$.
#! @Arguments s,a,r
DeclareOperation( "CartesianEvaluationForCartesianDualWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CartesianEvaluationForCartesianDualWithGivenDirectProduct</C>.
#! $F: (a^{\vee} \times a, a, 1) \mapsto \mathrm{ev}_{a}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianEvaluationForCartesianDualWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianEvaluationForCartesianDualWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianEvaluationForCartesianDualWithGivenDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianEvaluationForCartesianDualWithGivenDirectProduct",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a^{\vee})^{\vee})$.
#! @Arguments a
DeclareAttribute( "MorphismToCartesianBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$,
#! and an object $r = (a^{\vee})^{\vee}$.
#! The output is the morphism to the bidual $a \rightarrow (a^{\vee})^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a, (a^{\vee})^{\vee})$.
#! @Arguments a, r
DeclareOperation( "MorphismToCartesianBidualWithGivenCartesianBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismToCartesianBidualWithGivenCartesianBidual</C>.
#! $F: (a, (a^{\vee})^{\vee}) \mapsto (a \rightarrow (a^{\vee})^{\vee})$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismToCartesianBidualWithGivenCartesianBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToCartesianBidualWithGivenCartesianBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToCartesianBidualWithGivenCartesianBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToCartesianBidualWithGivenCartesianBidual",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are four objects $a, a', b, b'$.
#! The output is the natural morphism
#! $\mathrm{DirectProductExponentialCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b') \rightarrow \mathrm{Exponential}(a \times b,a' \times b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b'), \mathrm{Exponential}(a \times b,a' \times b'))$.
#! @Arguments a,a',b,b'
DeclareOperation( "DirectProductExponentialCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

##
## The new_source and new_range arguments are the first and second element of the list.
## This construction is due to the fact that the maximal number of arguments for an operation is 6,
## but a basic operation with 6 arguments would install a setter having 7 arguments.
#! @Description
#! The arguments are four objects $a, a', b, b'$,
#! and a list $L = [ \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b'), \mathrm{Exponential}(a \times b,a' \times b') ]$.
#! The output is the natural morphism
#! $\mathrm{DirectProductExponentialCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b') \rightarrow \mathrm{Exponential}(a \times b,a' \times b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b'), \mathrm{Exponential}(a \times b,a' \times b'))$.
#! @Arguments a,a',b,b',L
DeclareOperation( "DirectProductExponentialCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectProductExponentialCompatibilityMorphismWithGivenObjects</C>.
#! $F: ( a,a',b,b', [ \mathrm{Exponential}(a,a') \times \mathrm{Exponential}(b,b'), \mathrm{Exponential}(a \times b,a' \times b') ]) \mapsto \mathrm{DirectProductExponentialCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectProductExponentialCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectProductExponentialCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectProductExponentialCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectProductExponentialCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects}: a^{\vee} \times b^{\vee} \rightarrow (a \times b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times b^{\vee}, (a \times b)^{\vee} )$.
#! @Arguments a,b
DeclareOperation( "DirectProductCartesianDualityCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \times b^{\vee}$,
#! two objects $a,b$,
#! and an object $r = (a \times b)^{\vee}$.
#! The output is the natural morphism
#! $\mathrm{DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects}_{a,b}: a^{\vee} \times b^{\vee} \rightarrow (a \times b)^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times b^{\vee}, (a \times b)^{\vee} )$.
#! @Arguments s,a,b,r
DeclareOperation( "DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects</C>.
#! $F: ( a^{\vee} \times b^{\vee}, a, b, (a \times b)^{\vee} ) \mapsto \mathrm{DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectProductCartesianDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectProductCartesianDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectProductCartesianDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectProductCartesianDualityCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromDirectProductToExponentialWithGivenObjects}_{a,b}: a^{\vee} \times b \rightarrow \mathrm{Exponential}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times b, \mathrm{Exponential}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromDirectProductToExponential",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a^{\vee} \times b$,
#! two objects $a,b$,
#! and an object $r = \mathrm{Exponential}(a,b)$.
#! The output is the natural morphism $\mathrm{MorphismFromDirectProductToExponentialWithGivenObjects}_{a,b}: a^{\vee} \times b \rightarrow \mathrm{Exponential}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( a^{\vee} \times b, \mathrm{Exponential}(a,b) )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromDirectProductToExponentialWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromDirectProductToExponentialWithGivenObjects</C>.
#! $F: ( a^{\vee} \times b, a, b, \mathrm{Exponential}(a,b) ) \mapsto \mathrm{MorphismFromDirectProductToExponentialWithGivenObjects}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromDirectProductToExponentialWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromDirectProductToExponentialWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromDirectProductToExponentialWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromDirectProductToExponentialWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromCartesianDualToExponential}_{a}: a^{\vee} \rightarrow \mathrm{Exponential}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a^{\vee}, \mathrm{Exponential}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCartesianDualToExponential",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCartesianDualToExponential</C>.
#! $F: a \mapsto \mathrm{IsomorphismFromCartesianDualToExponential}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromCartesianDualToExponential",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCartesianDualToExponential",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCartesianDualToExponential",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCartesianDualToExponential",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromExponentialToCartesianDual}_{a}: \mathrm{Exponential}(a,1) \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Exponential}(a,1), a^{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromExponentialToCartesianDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromExponentialToCartesianDual</C>.
#! $F: a \mapsto \mathrm{IsomorphismFromExponentialToCartesianDual}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromExponentialToCartesianDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromExponentialToCartesianDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromExponentialToCartesianDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromExponentialToCartesianDual",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $t,a$,
#! and a morphism $\alpha: t \times a \rightarrow 1$.
#! The output is the morphism $t \rightarrow a^{\vee}$
#! given by the universal property of $a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(t, a^{\vee})$.
#! @Arguments t, a, alpha
DeclareOperation( "UniversalPropertyOfCartesianDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalPropertyOfCartesianDual</C>.
#! $F: ( t,a,\alpha: t \times a \rightarrow 1 ) \mapsto ( t \rightarrow a^{\vee} )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalPropertyOfCartesianDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalPropertyOfCartesianDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfCartesianDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfCartesianDual",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is the corresponding morphism $1 \rightarrow \mathrm{Exponential}(a,b)$
#! under the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}( 1, \mathrm{Exponential}(a,b) )$.
#! @Arguments alpha
DeclareAttribute( "CartesianLambdaIntroduction",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CartesianLambdaIntroduction</C>.
#! $F: ( \alpha: a \rightarrow b ) \mapsto ( 1 \rightarrow \mathrm{Exponential}(a,b) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianLambdaIntroduction",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianLambdaIntroduction",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianLambdaIntroduction",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianLambdaIntroduction",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$,
#! and a morphism $\alpha: 1 \rightarrow \mathrm{Exponential}(a,b)$.
#! The output is a morphism $a \rightarrow b$ corresponding to $\alpha$
#! under the direct product-exponential adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$.
#! @Arguments a,b,alpha
DeclareOperation( "CartesianLambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CartesianLambdaElimination</C>.
#! $F: ( a,b,\alpha: 1 \rightarrow \mathrm{Exponential}(a,b) ) \mapsto ( a \rightarrow b )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianLambdaElimination",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianLambdaElimination",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianLambdaElimination",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianLambdaElimination",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{Exponential}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{Exponential}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromObjectToExponential",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = \mathrm{Exponential}(1,a)$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{Exponential}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{Exponential}(1,a))$.
#! @Arguments a,r
DeclareOperation( "IsomorphismFromObjectToExponentialWithGivenExponential",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromObjectToExponentialWithGivenExponential</C>.
#! $F: ( a, \mathrm{Exponential}(1,a) ) \mapsto ( a \rightarrow \mathrm{Exponential}(1,a) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromObjectToExponentialWithGivenExponential",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromObjectToExponentialWithGivenExponential",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToExponentialWithGivenExponential",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToExponentialWithGivenExponential",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $\mathrm{Exponential}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Exponential}(1,a),a)$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromExponentialToObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = \mathrm{Exponential}(1,a)$.
#! The output is the natural isomorphism $\mathrm{Exponential}(1,a) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Exponential}(1,a),a)$.
#! @Arguments a,s
DeclareOperation( "IsomorphismFromExponentialToObjectWithGivenExponential",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromExponentialToObjectWithGivenExponential</C>.
#! $F: ( a, \mathrm{Exponential}(1,a) ) \mapsto ( \mathrm{Exponential}(1,a) \rightarrow a )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromExponentialToObjectWithGivenExponential",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromExponentialToObjectWithGivenExponential",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromExponentialToObjectWithGivenExponential",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromExponentialToObjectWithGivenExponential",
                  [ IsCapCategory, IsList ] );
