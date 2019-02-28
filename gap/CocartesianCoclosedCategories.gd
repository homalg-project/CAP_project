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
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the internal hom object $\mathrm{Coexponential}(a,b)$.
#! @Returns an object
#! @Arguments a, b
DeclareOperation( "CoexponentialOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
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
#! The output is the internal hom morphism
#! $\mathrm{Coexponential}(\alpha,\beta): \mathrm{Coexponential}(a,b') \rightarrow \mathrm{Coexponential}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b'), \mathrm{Coexponential}(a',b) )$
#! @Arguments alpha, beta
DeclareOperation( "CoexponentialOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = \mathrm{Coexponential}(a,b')$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = \mathrm{Coexponential}(a',b)$.
#! The output is the internal hom morphism 
#! $\mathrm{Coexponential}(\alpha,\beta): \mathrm{Coexponential}(a,b') \rightarrow \mathrm{Coexponential}(a',b)$.
#! @Returns a morphism in $\mathrm{Hom}( \mathrm{Coexponential}(a,b'), \mathrm{Coexponential}(a',b) )$
#! @Arguments s, alpha, beta, r
DeclareOperation( "CoexponentialOnMorphismsWithGivenCoexponentials",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
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
