#
# Toposes: Elementary toposes
#
# Declarations
#

####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_CARTESIAN_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "CARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

Perform(
## This is the CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST
    [
      [ "IsCartesianCategory" ],
      [ "IsStrictCartesianCategory" ],
    ],
    AddCategoricalProperty );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory  := Concatenation( [
"DirectProduct",
"DirectProductOnMorphismsWithGivenDirectProducts",
"TerminalObject",
"CartesianAssociatorLeftToRightWithGivenDirectProducts",
"CartesianAssociatorRightToLeftWithGivenDirectProducts",
"CartesianLeftUnitorWithGivenDirectProduct",
"CartesianLeftUnitorInverseWithGivenDirectProduct",
"CartesianRightUnitorWithGivenDirectProduct",
"CartesianRightUnitorInverseWithGivenDirectProduct"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory );

## DirectProductOnMorphismsWithGivenDirectProducts

#! @Description
#! The arguments are two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$.
#! The output is the direct product $\alpha \times \beta$.
#! @Returns a morphism in $\mathrm{Hom}(a \times b, a' \times b')$
#! @Arguments alpha, beta
DeclareOperation( "DirectProductOnMorphisms",
                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are an object $s = a \times b$,
#! two morphisms $\alpha: a \rightarrow a', \beta: b \rightarrow b'$,
#! and an object $r = a' \times b'$.
#! The output is the direct product $\alpha \times \beta$.
#! @Returns a morphism in $\mathrm{Hom}(a \times b, a' \times b')$
#! @Arguments s, alpha, beta, r
DeclareOperation( "DirectProductOnMorphismsWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>DirectProductOnMorphismsWithGivenDirectProducts</C>.
#! $F: ( a \times b, \alpha: a \rightarrow a', \beta: b \rightarrow b', a' \times b' ) \mapsto \alpha \times \beta$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddDirectProductOnMorphismsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDirectProductOnMorphismsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddDirectProductOnMorphismsWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddDirectProductOnMorphismsWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the associator $\alpha_{a,(b,c)}: a \times (b \times c) \rightarrow (a \times b) \times c$.
#! @Returns a morphism in $\mathrm{Hom}( a \times (b \times c), (a \times b) \times c )$.
#! @Arguments a, b, c
DeclareOperation( "CartesianAssociatorRightToLeft",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \times (b \times c)$,
#! three objects $a,b,c$,
#! and an object $r = (a \times b) \times c$.
#! The output is the associator $\alpha_{a,(b,c)}: a \times (b \times c) \rightarrow (a \times b) \times c$.
#! @Returns a morphism in $\mathrm{Hom}( a \times (b \times c), (a \times b) \times c )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "CartesianAssociatorRightToLeftWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CartesianAssociatorRightToLeftWithGivenDirectProducts</C>.
#! $F: ( a \times (b \times c), a, b, c, (a \times b) \times c ) \mapsto \alpha_{a,(b,c)}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianAssociatorRightToLeftWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianAssociatorRightToLeftWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianAssociatorRightToLeftWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianAssociatorRightToLeftWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );



##
#! @Description
#! The arguments are three objects $a,b,c$.
#! The output is the associator $\alpha_{(a,b),c}: (a \times b) \times c \rightarrow a \times (b \times c)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \times b) \times c \rightarrow a \times (b \times c) )$.
#! @Arguments a, b, c
DeclareOperation( "CartesianAssociatorLeftToRight",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (a \times b) \times c$,
#! three objects $a,b,c$,
#! and an object $r = a \times (b \times c)$.
#! The output is the associator $\alpha_{(a,b),c}: (a \times b) \times c \rightarrow a \times (b \times c)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \times b) \times c \rightarrow a \times (b \times c) )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "CartesianAssociatorLeftToRightWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CartesianAssociatorLeftToRightWithGivenDirectProducts</C>.
#! $F: (( a \times b ) \times c, a, b, c, a \times (b \times c )) \mapsto \alpha_{(a,b),c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianAssociatorLeftToRightWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianAssociatorLeftToRightWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianAssociatorLeftToRightWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianAssociatorLeftToRightWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the left unitor $\lambda_a: 1 \times a \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(1 \times a, a )$
#! @Arguments a
DeclareAttribute( "CartesianLeftUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ and an object $s = 1 \times a$.
#! The output is the left unitor $\lambda_a: 1 \times a \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(1 \times a, a )$
#! @Arguments a, s
DeclareOperation( "CartesianLeftUnitorWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CartesianLeftUnitorWithGivenDirectProduct</C>.
#! $F: (a, 1 \times a) \mapsto \lambda_a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianLeftUnitorWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianLeftUnitorWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianLeftUnitorWithGivenDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianLeftUnitorWithGivenDirectProduct",
                  [ IsCapCategory, IsList ] );



##
#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the left unitor $\lambda_a^{-1}: a \rightarrow 1 \times a$.
#! @Returns a morphism in $\mathrm{Hom}(a, 1 \times a)$
#! @Arguments a
DeclareAttribute( "CartesianLeftUnitorInverse",
                  IsCapCategoryObject );

#! @Description
#! The argument is an object $a$ and an object $r = 1 \times a$.
#! The output is the inverse of the left unitor $\lambda_a^{-1}: a \rightarrow 1 \times a$.
#! @Returns a morphism in $\mathrm{Hom}(a, 1 \times a)$
#! @Arguments a, r
DeclareOperation( "CartesianLeftUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CartesianLeftUnitorInverseWithGivenDirectProduct</C>.
#! $F: (a, 1 \times a) \mapsto \lambda_a^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianLeftUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianLeftUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianLeftUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianLeftUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the right unitor $\rho_a: a \times 1 \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(a \times 1, a )$
#! @Arguments a
DeclareAttribute( "CartesianRightUnitor",
                  IsCapCategoryObject );

#! @Description
#! The arguments are an object $a$ and an object $s = a \times 1$.
#! The output is the right unitor $\rho_a: a \times 1 \rightarrow a$.
#! @Returns a morphism in $\mathrm{Hom}(a \times 1, a )$
#! @Arguments a, s
DeclareOperation( "CartesianRightUnitorWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CartesianRightUnitorWithGivenDirectProduct</C>.
#! $F: (a, a \times 1) \mapsto \rho_a$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianRightUnitorWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianRightUnitorWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianRightUnitorWithGivenDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianRightUnitorWithGivenDirectProduct",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The argument is an object $a$.
#! The output is the inverse of the right unitor $\rho_a^{-1}: a \rightarrow a \times 1$.
#! @Returns a morphism in $\mathrm{Hom}( a, a \times 1 )$
#! @Arguments a
DeclareAttribute( "CartesianRightUnitorInverse",
                  IsCapCategoryObject );

# the second argument is the given direct product
#! @Description
#! The arguments are an object $a$ and an object $r = a \times 1$.
#! The output is the inverse of the right unitor $\rho_a^{-1}: a \rightarrow a \times 1$.
#! @Returns a morphism in $\mathrm{Hom}( a, a \times 1 )$
#! @Arguments a, r
DeclareOperation( "CartesianRightUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CartesianRightUnitorInverseWithGivenDirectProduct</C>.
#! $F: (a, a \times 1) \mapsto \rho_a^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianRightUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianRightUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianRightUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianRightUnitorInverseWithGivenDirectProduct",
                  [ IsCapCategory, IsList ] );
