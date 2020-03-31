####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Coclosed Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_COCARTESIAN_COCLOSED_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "COCARTESIAN_COCLOSED_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCoclosedCategory  := Concatenation( [
"CoexponentialOnObjects",
"CoexponentialOnMorphismsWithGivenCoexponentials",
"CocartesianEvaluationMorphismWithGivenRange",
"CocartesianCoevaluationMorphismWithGivenSource"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal cohom object $\mathrm{Coexponential}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "CoexponentialOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CoexponentialOnObjects</C>.
#! $F: (a,b) \mapsto \mathrm{Coexponential}(a,b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoexponentialOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoexponentialOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoexponentialOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoexponentialOnObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal cohom morphism
#! $\mathrm{Coexponential}(\alpha,\beta): \mathrm{Coexponential}(a,b') \rightarrow \mathrm{Coexponential}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b'), \mathrm{Coexponential}(a',b) )$
#! @Arguments alpha, beta
DeclareOperation( "CoexponentialOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{Coexponential}(a,b')$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{Coexponential}(a',b)$.
#! The output is the internal cohom morphism
#! $\mathrm{Coexponential}(\alpha,\beta): \mathrm{Coexponential}(a,b') \rightarrow \mathrm{Coexponential}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b'), \mathrm{Coexponential}(a',b) )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "CoexponentialOnMorphismsWithGivenCoexponentials",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CoexponentialOnMorphismsWithGivenCoexponentials</C>.
#! $F: (\mathrm{Coexponential}(a,b'), \alpha: a \rightarrow a', \beta: b \rightarrow b', \mathrm{Coexponential}(a',b) ) \mapsto \mathrm{Coexponential}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoexponentialOnMorphismsWithGivenCoexponentials",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoexponentialOnMorphismsWithGivenCoexponentials",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoexponentialOnMorphismsWithGivenCoexponentials",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoexponentialOnMorphismsWithGivenCoexponentials",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are two objects $a, b$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a,b}: a \rightarrow b \sqcup \mathrm{Coexponential}(a,b)$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, b \sqcup \mathrm{Coexponential}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "CocartesianEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## 3rd argument is $b \sqcup \mathrm{Coexponential}(a,b)$
#! @Description
#! The arguments are two objects $a,b$ and an object $r = b \sqcup \mathrm{Coexponential}(a,b)$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a,b}: a \rightarrow b \sqcup \mathrm{Coexponential}(a,b)$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, b \sqcup \mathrm{Coexponential}(a,b) )$.
#! @Arguments a,b, r
DeclareOperation( "CocartesianEvaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianEvaluationMorphismWithGivenRange</C>.
#! $F: (a, b, b \sqcup \mathrm{Coexponential}(a,b)) \mapsto \mathrm{coev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianEvaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianEvaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianEvaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianEvaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are two objects $a,b$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{Coexponential}(a \sqcup b, a) \rightarrow b$, i.e.,
#! the counit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a \sqcup b, a), b )$.
#! @Arguments a,b
DeclareOperation( "CocartesianCoevaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## 3rd argument is $\mathrm{Coexponential}(a \sqcup b, a)$
#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{Coexponential(a \sqcup b, a)}$.
#! The output is the coclosed coevaluation morphism $\mathrm{coclcoev}_{a,b}: \mathrm{Coexponential}(a \sqcup b, a) \rightarrow b$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a \sqcup b, a), b )$.
#! @Arguments a,b,s
DeclareOperation( "CocartesianCoevaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianCoevaluationMorphismWithGivenSource</C>.
#! $F: (a, b, \mathrm{Coexponential}(a \sqcup b, a)) \mapsto \mathrm{dcoev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianCoevaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianCoevaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianCoevaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianCoevaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are objects $a,b$ and a morphism $f: \mathrm{Coexponential}(a,b) \rightarrow c$.
#! The output is a morphism $g: a \rightarrow b \sqcup c$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a, b \sqcup c)$.
#! @Arguments a, b, f
DeclareOperation( "CoexponentialToCoproductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CoexponentialToCoproductAdjunctionMap</C>.
#! $F: (a, b, f: \mathrm{Coexponential}(a,b) \rightarrow c) \mapsto ( g: a \rightarrow b \sqcup c )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoexponentialToCoproductAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoexponentialToCoproductAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoexponentialToCoproductAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoexponentialToCoproductAdjunctionMap",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are objects $b,c$ and a morphism $g: a \rightarrow b \sqcup c$.
#! The output is a morphism $f: \mathrm{Coexponential}(a,b) \rightarrow c$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b), c )$.
#! @Arguments b, c, g
DeclareOperation( "CoproductToCoexponentialAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CoproductToCoexponentialAdjunctionMap</C>.
#! $F: (a, b, g: a \rightarrow b \sqcup c) \mapsto ( f: \mathrm{Coexponential}(a,b) \rightarrow c)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoproductToCoexponentialAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoproductToCoexponentialAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoproductToCoexponentialAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoproductToCoexponentialAdjunctionMap",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precocomposition morphism
#! $\mathrm{CocartesianPreCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Coexponential}(a,c) \rightarrow \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,c), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c) )$.
#! @Arguments a,b,c
DeclareOperation( "CocartesianPreCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{Coexponential}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c)$.
#! The output is the precocomposition morphism
#! $\mathrm{CocartesianPreCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Coexponential}(a,c) \rightarrow \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,c), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "CocartesianPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianPreCoComposeMorphismWithGivenObjects</C>.
#! $F: (\mathrm{Coexponential}(a,c),a,b,c,\mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(b,c)) \mapsto \mathrm{CocartesianPreCoComposeMorphismWithGivenObjects}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcocomposition morphism
#! $\mathrm{CocartesianPostCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Coexponential}(a,c) \rightarrow \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,c), \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b) )$.
#! @Arguments a,b,c
DeclareOperation( "CocartesianPostCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{Coexponential}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b)$.
#! The output is the postcocomposition morphism
#! $\mathrm{CocartesianPostCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{Coexponential}(a,c) \rightarrow \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,c), \mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "CocartesianPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianPostCoComposeMorphismWithGivenObjects</C>.
#! $F: (\mathrm{Coexponential}(a,c),a,b,c,\mathrm{Coexponential}(b,c) \sqcup \mathrm{Coexponential}(a,b)) \mapsto \mathrm{CocartesianPostComposeMorphismWithGivenObjects}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is its codual object $a_{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "CocartesianDualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianDualOnObjects</C>.
#! $F: a \mapsto a_{\vee}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianDualOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianDualOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianDualOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianDualOnObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its codual morphism $\alpha_{\vee}: b_{\vee} \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b_{\vee}, a_{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "CocartesianDualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b_{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a_{\vee}$.
#! The output is the dual morphism $\alpha_{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b_{\vee}, a_{\vee} )$.
#! @Arguments s,alpha,r
DeclareOperation( "CocartesianDualOnMorphismsWithGivenCocartesianDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianDualOnMorphismsWithGivenCocartesianDuals</C>.
#! $F: (b_{\vee},\alpha,a_{\vee}) \mapsto \alpha_{\vee}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianDualOnMorphismsWithGivenCocartesianDuals",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianDualOnMorphismsWithGivenCocartesianDuals",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianDualOnMorphismsWithGivenCocartesianDuals",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianDualOnMorphismsWithGivenCocartesianDuals",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the coclosed evaluation morphism $\mathrm{coclev}_{a}: 1 \rightarrow a \sqcup a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( 1, a \sqcup a_{\vee} )$.
#! @Arguments a
DeclareAttribute( "CocartesianEvaluationForCocartesianDual",
                  IsCapCategoryObject );


#! @Description
#! The arguments are an object $s = 1$,
#! an object $a$,
#! and an object $r = a \sqcup a_{\vee}$.
#! The output is the coclosed evaluation morphism $\mathrm{cocloev}_{a}: 1 \rightarrow a \sqcup a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( 1, a \sqcup a_{\vee} )$.
#! @Arguments s,a,r
DeclareOperation( "CocartesianEvaluationForCocartesianDualWithGivenCoproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianEvaluationForCocartesianDualWithGivenCoproduct</C>.
#! $F: (1, a, a \sqcup a_{vee}) \mapsto \mathrm{coev}_{a}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianEvaluationForCocartesianDualWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianEvaluationForCocartesianDualWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianEvaluationForCocartesianDualWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianEvaluationForCocartesianDualWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a cobidual object $(a_{\vee})_{\vee}$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a_{\vee})_{\vee}, a)$.
#! @Arguments avv
DeclareAttribute( "MorphismFromCocartesianBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = (a_{\vee})_{\vee}$,
#! and an object $a$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a_{\vee})_{\vee}, a)$.
#! @Arguments s, a
DeclareOperation( "MorphismFromCocartesianBidualWithGivenCocartesianBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>MorphismFromCocartesianBidualWithGivenCocartesianBidual</C>.
#! $F: ((a_{\vee})_{\vee}, a) \mapsto ((a_{\vee})_{\vee} \rightarrow a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromCocartesianBidualWithGivenCocartesianBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromCocartesianBidualWithGivenCocartesianBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromCocartesianBidualWithGivenCocartesianBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromCocartesianBidualWithGivenCocartesianBidual",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are four objects $a, a', b, b'$.
#! The output is the natural morphism
#! $\mathrm{CoexponentialCoproductCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{Coexponential}(a \sqcup a', b \sqcup b') \rightarrow \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a \sqcup a', b \sqcup b'), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b'))$.
#! @Arguments a,a',b,b'
DeclareOperation( "CoexponentialCoproductCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

##
## The new_source and new_range arguments are the first and second element of the list.
## This construction is due to the fact that the maximal number of arguments for an operation is 6,
## but a basic operation with 6 arguments would install a setter having 7 arguments.
#! @Description
#! The arguments are four objects $a, a', b, b'$,
#! and a list $L = [ \mathrm{Coexponential}(a \sqcup a', b \sqcup b'), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b') ]$.
#! The output is the natural morphism
#! $\mathrm{CoexponentialCoproductCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}: \mathrm{Coexponential}(a \sqcup a', b \sqcup b') \rightarrow \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b')$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a \sqcup a', b \sqcup b'), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b') )$.
#! @Arguments a,a',b,b',L
DeclareOperation( "CoexponentialCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CoexponentialCoproductCompatibilityMorphismWithGivenObjects</C>.
#! $F: ( a,a',b,b', [ \mathrm{Coexponential}(a \sqcup a', b \sqcup b'), \mathrm{Coexponential}(a,b) \sqcup \mathrm{Coexponential}(a',b') ]) \mapsto \mathrm{CoexponentialCoproductCompatibilityMorphismWithGivenObjects}_{a,a',b,b'}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoexponentialCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoexponentialCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoexponentialCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoexponentialCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism
#! $\mathrm{CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects}: (a \sqcup b)_{\vee} \rightarrow a_{\vee} \sqcup b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b)_{\vee}, a_{\vee} \sqcup b_{\vee} )$.
#! @Arguments a,b
DeclareOperation( "CocartesianDualityCoproductCompatibilityMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (a \sqcup b)_{\vee}$,
#! two objects $a,b$,
#! and an object $r = a_{\vee} \sqcup b_{\vee}$.
#! The output is the natural morphism
#! $\mathrm{CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects}_{a,b}: (a \sqcup b)_{\vee} \rightarrow a_{\vee} \sqcup b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b)_{\vee}, a_{\vee} \sqcup b_{\vee} )$.
#! @Arguments s,a,b,r
DeclareOperation( "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects</C>.
#! $F: ( (a \sqcup b)_{\vee}, a, b, a_{\vee} \sqcup b_{\vee} ) \mapsto \mathrm{CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the natural morphism $\mathrm{MorphismFromCoexponentialToCoproductWithGivenObjects}_{a,b}: \mathrm{Coexponential}(a,b) \rightarrow a \sqcup b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b), a \sqcup b_{\vee} )$.
#! @Arguments a,b
DeclareOperation( "MorphismFromCoexponentialToCoproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = \mathrm{Coexponential}(a,b)$,
#! two objects $a,b$,
#! and an object $r = a \sqcup b_{\vee}$.
#! The output is the natural morphism $\mathrm{MorphismFromCoexponentialToCoproductWithGivenObjects}_{a,b}: \mathrm{Coexponential}(a,b) \rightarrow a \sqcup b_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b), a \sqcup b_{\vee} )$.
#! @Arguments s,a,b,r
DeclareOperation( "MorphismFromCoexponentialToCoproductWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>MorphismFromCoexponentialToCoproductWithGivenObjects</C>.
#! $F: ( \mathrm{Coexponential}(a,b), a, b, a \sqcup b_{\vee} ) \mapsto \mathrm{MorphismFromCoexponentialToCoproductWithGivenObjects}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromCoexponentialToCoproductWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromCoexponentialToCoproductWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromCoexponentialToCoproductWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromCoexponentialToCoproductWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromCocartesianDualToCoexponential}_{a}: a_{\vee} \rightarrow \mathrm{Coexponential}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, \mathrm{Coexponential}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCocartesianDualToCoexponential",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCocartesianDualToCoexponential</C>.
#! $F: a \mapsto \mathrm{IsomorphismFromCocartesianDualToCoexponential}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromCocartesianDualToCoexponential",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCocartesianDualToCoexponential",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCocartesianDualToCoexponential",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCocartesianDualToCoexponential",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromCoexponentialToCocartesianDual}_{a}: \mathrm{Coexponential}(1,a) \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Coexponential}(1,a), a_{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCoexponentialToCocartesianDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCoexponentialToCocartesianDual</C>.
#! $F: a \mapsto \mathrm{IsomorphismFromCoexponentialToCocartesianDual}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromCoexponentialToCocartesianDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCoexponentialToCocartesianDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoexponentialToCocartesianDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoexponentialToCocartesianDual",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,t$,
#! and a morphism $\alpha: 1 \rightarrow a \sqcup t$.
#! The output is the morphism $a_{\vee} \rightarrow t$
#! given by the universal property of $a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, t)$.
#! @Arguments a, t, alpha
DeclareOperation( "UniversalPropertyOfCocartesianDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>UniversalPropertyOfCocartesianDual</C>.
#! $F: ( a,t,\alpha: 1 \rightarrow a \sqcup t ) \mapsto ( a^{\vee} \rightarrow t )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalPropertyOfCocartesianDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalPropertyOfCocartesianDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfCocartesianDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfCocartesianDual",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is the corresponding morphism $ \mathrm{Coexponential}(a,b) \rightarrow 1$
#! under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b), 1 )$.
#! @Arguments alpha
DeclareAttribute( "CocartesianLambdaIntroduction",
                  IsCapCategoryMorphism );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianLambdaIntroduction</C>.
#! $F: ( \alpha: a \rightarrow b ) \mapsto ( \mathrm{Coexponential}(a,b) \rightarrow 1 )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianLambdaIntroduction",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianLambdaIntroduction",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianLambdaIntroduction",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianLambdaIntroduction",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are two objects $a,b$,
#! and a morphism $\alpha: \mathrm{Coexponential}(a,b) \rightarrow 1$.
#! The output is a morphism $a \rightarrow b$ corresponding to $\alpha$
#! under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a,b)$.
#! @Arguments a,b,alpha
DeclareOperation( "CocartesianLambdaElimination",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>CocartesianLambdaElimination</C>.
#! $F: ( a,b,\alpha: \mathrm{Coexponential}(a,b) \rightarrow 1 ) \mapsto ( a \rightarrow b )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianLambdaElimination",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianLambdaElimination",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianLambdaElimination",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianLambdaElimination",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{Coexponential}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{Coexponential}(a,1))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromObjectToCoexponential",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $r = \mathrm{Coexponential}(a,1)$.
#! The output is the natural isomorphism $a \rightarrow \mathrm{Coexponential}(a,1)$.
#! @Returns a morphism in $\mathrm{Hom}(a, \mathrm{Coexponential}(a,1))$.
#! @Arguments a,r
DeclareOperation( "IsomorphismFromObjectToCoexponentialWithGivenCoexponential",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromObjectToCoexponentialWithGivenCoexponential</C>.
#! $F: ( a, \mathrm{Coexponential}(a,1) ) \mapsto ( a \rightarrow \mathrm{Coexponential}(a,1) )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromObjectToCoexponentialWithGivenCoexponential",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromObjectToCoexponentialWithGivenCoexponential",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToCoexponentialWithGivenCoexponential",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromObjectToCoexponentialWithGivenCoexponential",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the natural isomorphism $\mathrm{Coexponential}(a,1) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Coexponential}(a,1), a)$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCoexponentialToObject",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$,
#! and an object $s = \mathrm{Coexponential}(1,a)$.
#! The output is the natural isomorphism $\mathrm{Coexponential}(a,1) \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{Coexponential}(a,1), a)$.
#! @Arguments a,s
DeclareOperation( "IsomorphismFromCoexponentialToObjectWithGivenCoexponential",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCoexponentialToObjectWithGivenCoexponential</C>.
#! $F: ( a, \mathrm{Coexponential}(a,1) ) \mapsto ( \mathrm{Coexponential}(a,1) \rightarrow a )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromCoexponentialToObjectWithGivenCoexponential",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCoexponentialToObjectWithGivenCoexponential",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoexponentialToObjectWithGivenCoexponential",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoexponentialToObjectWithGivenCoexponential",
                  [ IsCapCategory, IsList ] );
