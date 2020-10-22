# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

Perform(
## This is the CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST
    [
      [ "IsCocartesianCategory" ],
      [ "IsStrictCocartesianCategory" ],
    ],
    AddCategoricalProperty );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory  := Concatenation( [
"Coproduct",
"CoproductOnMorphismsWithGivenCoproducts",
"InitialObject",
"CocartesianAssociatorLeftToRightWithGivenCoproducts",
"CocartesianAssociatorRightToLeftWithGivenCoproducts",
"CocartesianLeftUnitorWithGivenCoproduct",
"CocartesianLeftUnitorInverseWithGivenCoproduct",
"CocartesianRightUnitorWithGivenCoproduct",
"CocartesianRightUnitorInverseWithGivenCoproduct"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory );

## CoproductOnMorphismsWithGivenCoproducts

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the coproduct $\alpha \sqcup \beta$.
#! @Returns a morphism in $\mathrm{Hom}(a \sqcup b, a' \sqcup b')$
#! @Arguments alpha, beta
DeclareOperation( "CoproductOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = a \sqcup b$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = a' \sqcup b'$.
#! The output is the coproduct $\alpha \sqcup \beta$.
#! @Returns a morphism in $\mathrm{Hom}(a \sqcup b, a' \sqcup b')$
#! @Arguments s, alpha, beta, r
DeclareOperation( "CoproductOnMorphismsWithGivenCoproducts",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CoproductOnMorphismsWithGivenCoproducts</C>.
#! $F: ( a \sqcup b, \alpha: a \rightarrow a', \beta: b \rightarrow b', a' \sqcup b' ) \mapsto \alpha \sqcup \beta$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoproductOnMorphismsWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoproductOnMorphismsWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoproductOnMorphismsWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoproductOnMorphismsWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the associator $\alpha_{a,(b,c)}: a \sqcup (b \sqcup c) \rightarrow (a \sqcup b) \sqcup c$.
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup (b \sqcup c), (a \sqcup b) \sqcup c )$.
#! @Arguments a, b, c
DeclareOperation( "CocartesianAssociatorRightToLeft",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \sqcup (b \sqcup c)$,
#! three objects $a,b,c$,
#! and an object $r = (a \sqcup b) \sqcup c$.
#! The output is the associator $\alpha_{a,(b,c)}: a \sqcup (b \sqcup c) \rightarrow (a \sqcup b) \sqcup c$.
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup (b \sqcup c), (a \sqcup b) \sqcup c )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "CocartesianAssociatorRightToLeftWithGivenCoproducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CocartesianAssociatorRightToLeftWithGivenCoproducts</C>.
#! $F: ( a \sqcup (b \sqcup c), a, b, c, (a \sqcup b) \sqcup c ) \mapsto \alpha_{a,(b,c)}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianAssociatorRightToLeftWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianAssociatorRightToLeftWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorRightToLeftWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorRightToLeftWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );



##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the associator $\alpha_{(a,b),c}: (a \sqcup b) \sqcup c \rightarrow a \sqcup (b \sqcup c)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b) \sqcup c \rightarrow a \sqcup (b \sqcup c) )$.
#! @Arguments a, b, c
DeclareOperation( "CocartesianAssociatorLeftToRight",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (a \sqcup b) \sqcup c$,
#! three objects $a,b,c$,
#! and an object $r = a \sqcup (b \sqcup c)$.
#! The output is the associator $\alpha_{(a,b),c}: (a \sqcup b) \sqcup c \rightarrow a \sqcup (b \sqcup c)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b) \sqcup c \rightarrow a \sqcup (b \sqcup c) )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "CocartesianAssociatorLeftToRightWithGivenCoproducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CocartesianAssociatorLeftToRightWithGivenCoproducts</C>.
#! $F: (( a \sqcup b ) \sqcup c, a, b, c, a \sqcup (b \sqcup c )) \mapsto \alpha_{(a,b),c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianAssociatorLeftToRightWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianAssociatorLeftToRightWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorLeftToRightWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianAssociatorLeftToRightWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the left unitor $\lambda_a: 1 \sqcup a \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(1 \sqcup a, a )$
#! @Arguments a
DeclareAttribute( "CocartesianLeftUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ and an object $s = 1 \sqcup a$.
#! The output is the left unitor $\lambda_a: 1 \sqcup a \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(1 \sqcup a, a )$
#! @Arguments a, s
DeclareOperation( "CocartesianLeftUnitorWithGivenCoproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CocartesianLeftUnitorWithGivenCoproduct</C>.
#! $F: (a, 1 \sqcup a) \mapsto \lambda_a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianLeftUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianLeftUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );



##
#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the left unitor $\lambda_a^{-1}: a \rightarrow 1 \sqcup a$.
#! @Returns a morphism in $\mathrm{Hom}(a, 1 \sqcup a)$
#! @Arguments a
DeclareAttribute( "CocartesianLeftUnitorInverse",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$ and an object $r = 1 \sqcup a$.
#! The output is the inverse of the left unitor $\lambda_a^{-1}: a \rightarrow 1 \sqcup a$.
#! @Returns a morphism in $\mathrm{Hom}(a, 1 \sqcup a)$
#! @Arguments a, r
DeclareOperation( "CocartesianLeftUnitorInverseWithGivenCoproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CocartesianLeftUnitorInverseWithGivenCoproduct</C>.
#! $F: (a, 1 \sqcup a) \mapsto \lambda_a^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianLeftUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianLeftUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianLeftUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the right unitor $\rho_a: a \sqcup 1 \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(a \sqcup 1, a )$
#! @Arguments a
DeclareAttribute( "CocartesianRightUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ and an object $s = a \sqcup 1$.
#! The output is the right unitor $\rho_a: a \sqcup 1 \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(a \sqcup 1, a )$
#! @Arguments a, s
DeclareOperation( "CocartesianRightUnitorWithGivenCoproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CocartesianRightUnitorWithGivenCoproduct</C>.
#! $F: (a, a \sqcup 1) \mapsto \rho_a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianRightUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianRightUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the right unitor $\rho_a^{-1}: a \rightarrow a \sqcup 1$.
#! @Returns a morphism in $\mathrm{Hom}( a, a \sqcup 1 )$
#! @Arguments a
DeclareAttribute( "CocartesianRightUnitorInverse",
                  IsCapCategoryObject );

# the second argument is the given coproduct
#! @Description
#! The arguments are an object $a$ and an object $r = a \sqcup 1$.
#! The output is the inverse of the right unitor $\rho_a^{-1}: a \rightarrow a \sqcup 1$.
#! @Returns a morphism in $\mathrm{Hom}( a, a \sqcup 1 )$
#! @Arguments a, r
DeclareOperation( "CocartesianRightUnitorInverseWithGivenCoproduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CocartesianRightUnitorInverseWithGivenCoproduct</C>.
#! $F: (a, a \sqcup 1) \mapsto \rho_a^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianRightUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianRightUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianRightUnitorInverseWithGivenCoproduct",
                  [ IsCapCategory, IsList ] );
