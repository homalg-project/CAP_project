####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Coclosed Monoidal Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_COCLOSED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCoclosedMonoidalCategory  := Concatenation( [
"InternalCoHomOnObjects",
"InternalCoHomOnMorphismsWithGivenInternalCoHoms",
"CoEvaluationMorphismWithGivenRange",
"DualCoEvaluationMorphismWithGivenSource"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsMonoidalCategory );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal cohom object $\mathrm{\underline{coHom}}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "InternalCoHomOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InternalCoHomOnObjects</C>.
#! $F: (a,b) \mapsto \mathrm{\underline{coHom}}(a,b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalCoHomOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalCoHomOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalCoHomOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalCoHomOnObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the internal cohom morphism
#! $\mathrm{\underline{coHom}}(\alpha,\beta): \mathrm{\underline{coHom}}(a,b') \rightarrow \mathrm{\underline{coHom}}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b'), \mathrm{\underline{coHom}}(a',b) )$
#! @Arguments alpha, beta
DeclareOperation( "InternalCoHomOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{\underline{coHom}}(a,b')$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{\underline{coHom}}(a',b)$.
#! The output is the internal cohom morphism
#! $\mathrm{\underline{coHom}}(\alpha,\beta): \mathrm{\underline{coHom}}(a,b') \rightarrow \mathrm{\underline{coHom}}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b'), \mathrm{\underline{coHom}}(a',b) )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "InternalCoHomOnMorphismsWithGivenInternalCoHoms",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InternalCoHomOnMorphismsWithGivenInternalCoHoms</C>.
#! $F: (\mathrm{\underline{coHom}}(a,b'), \alpha: a \rightarrow a', \beta: b \rightarrow b', \mathrm{\underline{coHom}}(a',b) ) \mapsto \mathrm{\underline{coHom}}(\alpha,\beta)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalCoHomOnMorphismsWithGivenInternalCoHoms",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalCoHomOnMorphismsWithGivenInternalCoHoms",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalCoHomOnMorphismsWithGivenInternalCoHoms",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalCoHomOnMorphismsWithGivenInternalCoHoms",
                  [ IsCapCategory, IsList ] );

## TODO: Find a better name!
#! @Description
#! The arguments are two objects $a, b$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow b \otimes \mathrm{\underline{coHom}}(a,b)$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, b \otimes \mathrm{\underline{coHom}}(a,b) )$.
#! @Arguments a,b
DeclareOperation( "CoEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## 3rd argument is $b \otimes \mathrm{\underline{coHom}}(a,b)$
#! @Description
#! The arguments are two objects $a,b$ and an object $r = b \otimes \mathrm{\underline{coHom}}(a,b)$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a,b}: a \rightarrow b \otimes \mathrm{\underline{coHom}}(a,b)$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( a, b \otimes \mathrm{\underline{coHom}}(a,b) )$.
#! @Arguments a,b, r
DeclareOperation( "CoEvaluationMorphismWithGivenRange",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoEvaluationMorphismWithGivenRange</C>.
#! $F: (a, b, b \otimes \mathrm{\underline{coHom}}(a,b)) \mapsto \mathrm{coev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoEvaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoEvaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoEvaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoEvaluationMorphismWithGivenRange",
                  [ IsCapCategory, IsList ] );

## TODO: Find a better name!
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the dual coevaluation morphism $\mathrm{dcoev}_{a,b}: \mathrm{\underline{coHom}}(a \otimes b, a) \rightarrow b$, i.e.,
#! the counit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a \otimes b, a), b )$.
#! @Arguments a,b
DeclareOperation( "DualCoEvaluationMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

## 3rd argument is $\mathrm{\underline{coHom}}(a \otimes b, a)$
#! @Description
#! The arguments are two objects $a,b$ and an object $s = \mathrm{\underline{coHom}(a \otimes b, a)}$.
#! The output is the dual coevaluation morphism $\mathrm{dcoev}_{a,b}: \mathrm{\underline{coHom}}(a \otimes b, a) \rightarrow b$, i.e.,
#! the unit of the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a \otimes b, a), b )$.
#! @Arguments a,b,s
DeclareOperation( "DualCoEvaluationMorphismWithGivenSource",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>DualCoEvaluationMorphismWithGivenSource</C>.
#! $F: (a, b, \mathrm{\underline{coHom}}(a \otimes b, a)) \mapsto \mathrm{dcoev}_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDualCoEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDualCoEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDualCoEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDualCoEvaluationMorphismWithGivenSource",
                  [ IsCapCategory, IsList ] );


#! @Description
#! The arguments are objects $a,b$ and a morphism $f: \mathrm{\underline{coHom}}(a,b) \rightarrow c$.
#! The output is a morphism $g: a \rightarrow b \otimes c$ corresponding to $f$ under the
#! cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}(a, b \otimes c)$.
#! @Arguments a, b, f
DeclareOperation( "InternalCoHomToTensorProductAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>InternalCoHomToTensorProductAdjunctionMap</C>.
#! $F: (a, b, f: \mathrm{\underline{coHom}}(a,b) \rightarrow c) \mapsto ( g: a \rightarrow b \otimes c )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalCoHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalCoHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalCoHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalCoHomToTensorProductAdjunctionMap",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are objects $b,c$ and a morphism $g: a \rightarrow b \otimes c$.
#! The output is a morphism $f: \mathrm{\underline{coHom}}(a,b) \rightarrow c$
#! corresponding to $g$ under the cohom tensor adjunction.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,b), c )$.
#! @Arguments b, c, g
DeclareOperation( "TensorProductToInternalCoHomAdjunctionMap",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>TensorProductToInternalCoHomAdjunctionMap</C>.
#! $F: (a, b, g: a \rightarrow b \otimes c) \mapsto ( f: \mathrm{\underline{coHom}}(a,b) \rightarrow c)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductToInternalCoHomAdjunctionMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductToInternalCoHomAdjunctionMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductToInternalCoHomAdjunctionMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductToInternalCoHomAdjunctionMap",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the precocomposition morphism
#! $\mathrm{MonoidalPreCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{coHom}}(a,c) \rightarrow \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,c), \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c) )$.
#! @Arguments a,b,c
DeclareOperation( "MonoidalPreCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{coHom}}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c)$.
#! The output is the precocomposition morphism
#! $\mathrm{MonoidalPreCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{coHom}}(a,c) \rightarrow \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,c), \mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MonoidalPreCoComposeMorphismWithGivenObjects</C>.
#! $F: (\mathrm{\underline{coHom}}(a,c),a,b,c,\mathrm{\underline{coHom}}(a,b) \otimes \mathrm{\underline{coHom}}(b,c)) \mapsto \mathrm{MonoidalPreCoComposeMorphismWithGivenObjects}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMonoidalPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPreCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the postcocomposition morphism
#! $\mathrm{MonoidalPostCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{coHom}}(a,c) \rightarrow \mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,c), \mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b) )$.
#! @Arguments a,b,c
DeclareOperation( "MonoidalPostCoComposeMorphism",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are
#! an object $s = \mathrm{\underline{coHom}}(a,c)$,
#! three objects $a,b,c$,
#! and an object $r = \mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b)$.
#! The output is the postcocomposition morphism
#! $\mathrm{MonoidalPostCoComposeMorphismWithGivenObjects}_{a,b,c}: \mathrm{\underline{coHom}}(a,c) \rightarrow \mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{\underline{coHom}}(a,c), \mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b) )$.
#! @Arguments s,a,b,c,r
DeclareOperation( "MonoidalPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MonoidalPostCoComposeMorphismWithGivenObjects</C>.
#! $F: (\mathrm{\underline{coHom}}(a,c),a,b,c,\mathrm{\underline{coHom}}(b,c) \otimes \mathrm{\underline{coHom}}(a,b)) \mapsto \mathrm{MonoidalPostComposeMorphismWithGivenObjects}_{a,b,c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMonoidalPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMonoidalPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMonoidalPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMonoidalPostCoComposeMorphismWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is its codual object $a_{\vee}$.
#! @Returns an object
#! @Arguments a
DeclareAttribute( "CoDualOnObjects",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoDualOnObjects</C>.
#! $F: a \mapsto a_{\vee}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoDualOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoDualOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoDualOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoDualOnObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a morphism $\alpha: a \rightarrow b$.
#! The output is its codual morphism $\alpha_{\vee}: b_{\vee} \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b_{\vee}, a_{\vee} )$.
#! @Arguments alpha
DeclareAttribute( "CoDualOnMorphisms",
                  IsCapCategoryMorphism );

#! @Description
#! The argument is an object $s = b_{\vee}$,
#! a morphism $\alpha: a \rightarrow b$,
#! and an object $r = a_{\vee}$.
#! The output is the dual morphism $\alpha_{\vee}: b^{\vee} \rightarrow a^{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( b_{\vee}, a_{\vee} )$.
#! @Arguments s,alpha,r
DeclareOperation( "CoDualOnMorphismsWithGivenCoDuals",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoDualOnMorphismsWithGivenCoDuals</C>.
#! $F: (b_{\vee},\alpha,a_{\vee}) \mapsto \alpha_{\vee}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoDualOnMorphismsWithGivenCoDuals",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoDualOnMorphismsWithGivenCoDuals",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoDualOnMorphismsWithGivenCoDuals",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoDualOnMorphismsWithGivenCoDuals",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a}: 1 \rightarrow a \otimes a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( 1, a \otimes a_{\vee} )$.
#! @Arguments a
DeclareAttribute( "CoEvaluationForCoDual",
                  IsCapCategoryObject );


#! @Description
#! The arguments are an object $s = 1$,
#! an object $a$,
#! and an object $r = a \otimes a_{\vee}$.
#! The output is the coevaluation morphism $\mathrm{coev}_{a}: 1 \rightarrow a \otimes a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}( 1, a \otimes a_{\vee} )$.
#! @Arguments s,a,r
DeclareOperation( "CoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>CoEvaluationForCoDualWithGivenTensorProduct</C>.
#! $F: (1, a, a \otimes a_{vee}) \mapsto \mathrm{coev}_{a}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoEvaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a cobidual object $(a_{\vee})_{\vee}$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a_{\vee})_{\vee}, a)$.
#! @Arguments avv
DeclareAttribute( "MorphismFromCoBidual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $s = (a_{\vee})_{\vee}$,
#! and an object $a$.
#! The output is the morphism from the cobidual $(a_{\vee})_{\vee} \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}((a_{\vee})_{\vee}, a)$.
#! @Arguments s, a
DeclareOperation( "MorphismFromCoBidualWithGivenCoBidual",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>MorphismFromCoBidualWithGivenCoBidual</C>.
#! $F: ((a_{\vee})_{\vee}, a) \mapsto ((a_{\vee})_{\vee} \rightarrow a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromCoDualToInternalCoHom}_{a}: a_{\vee} \rightarrow \mathrm{\underline{coHom}}(1,a)$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, \mathrm{\underline{coHom}}(1,a))$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromCoDualToInternalCoHom",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromCoDualToInternalCoHom</C>.
#! $F: a \mapsto \mathrm{IsomorphismFromCoDualToInternalCoHom}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromCoDualToInternalCoHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromCoDualToInternalCoHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoDualToInternalCoHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromCoDualToInternalCoHom",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is an object $a$.
#! The output is the isomorphism
#! $\mathrm{IsomorphismFromInternalCoHomToCoDual}_{a}: \mathrm{\underline{coHom}}(1,a) \rightarrow a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(\mathrm{\underline{coHom}}(1,a), a_{\vee})$.
#! @Arguments a
DeclareAttribute( "IsomorphismFromInternalCoHomToCoDual",
                  IsCapCategoryObject );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>IsomorphismFromInternalCoHomToCoDual</C>.
#! $F: a \mapsto \mathrm{IsomorphismFromInternalCoHomToCoDual}_{a}$
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInternalCoHomToCoDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalCoHomToCoDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalCoHomToCoDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalCoHomToCoDual",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,t$,
#! and a morphism $\alpha: 1 \rightarrow a \otimes t$.
#! The output is the morphism $a_{\vee} \rightarrow t$
#! given by the universal property of $a_{\vee}$.
#! @Returns a morphism in $\mathrm{Hom}(a_{\vee}, t)$.
#! @Arguments a, t, alpha
DeclareOperation( "UniversalPropertyOfCoDual",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>UniversalPropertyOfCoDual</C>.
#! $F: ( a,t,\alpha: 1 \rightarrow a \otimes t ) \mapsto ( a^{\vee} \rightarrow t )$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddUniversalPropertyOfCoDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalPropertyOfCoDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfCoDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddUniversalPropertyOfCoDual",
                  [ IsCapCategory, IsList ] );
