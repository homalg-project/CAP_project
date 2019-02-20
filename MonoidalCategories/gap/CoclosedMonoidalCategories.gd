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
