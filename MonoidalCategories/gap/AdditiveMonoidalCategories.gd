####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Additive Monoidal Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_DISTRIBUTIVE_MONOIDAL_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

##
#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $a \otimes (b_1 \oplus \dots \oplus b_n) \rightarrow (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes (b_1 \oplus \dots \oplus b_n), (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftDistributivityExpanding",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = a \otimes (b_1 \oplus \dots \oplus b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>LeftDistributivityExpandingWithGivenObjects</C>.
#! $F: (a \otimes (b_1 \oplus \dots \oplus b_n), a, L, (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)) \mapsto \mathrm{LeftDistributivityExpandingWithGivenObjects}(a,L)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are an object $a$
#! and a list of objects $L = (b_1, \dots, b_n)$.
#! The output is the left distributivity morphism
#! $(a \otimes b_1) \oplus \dots \oplus (a \otimes b_n) \rightarrow a \otimes (b_1 \oplus \dots \oplus b_n)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n), a \otimes (b_1 \oplus \dots \oplus b_n) )$
#! @Arguments a, L
DeclareOperation( "LeftDistributivityFactoring",
                  [ IsCapCategoryObject, IsList ] );

#! @Description
#! The arguments are an object $s = (a \otimes b_1) \oplus \dots \oplus (a \otimes b_n)$,
#! an object $a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! and an object $r = a \otimes (b_1 \oplus \dots \oplus b_n)$.
#! The output is the left distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, a, L, r
DeclareOperation( "LeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>LeftDistributivityFactoringWithGivenObjects</C>.
#! $F: ((a \otimes b_1) \oplus \dots \oplus (a \otimes b_n), a, L, a \otimes (b_1 \oplus \dots \oplus b_n)) \mapsto \mathrm{LeftDistributivityFactoringWithGivenObjects}(a,L)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddLeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLeftDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \oplus \dots \oplus b_n) \otimes a \rightarrow (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)$.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \oplus \dots \oplus b_n) \otimes a, (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a) )$
#! @Arguments L, a
DeclareOperation( "RightDistributivityExpanding",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \oplus \dots \oplus b_n) \otimes a$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>RightDistributivityExpandingWithGivenObjects</C>.
#! $F: ((b_1 \oplus \dots \oplus b_n) \otimes a, L, a, (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)) \mapsto \mathrm{RightDistributivityExpandingWithGivenObjects}(L,a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightDistributivityExpandingWithGivenObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are a list of objects $L = (b_1, \dots, b_n)$
#! and an object $a$.
#! The output is the right distributivity morphism
#! $(b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a) \rightarrow (b_1 \oplus \dots \oplus b_n) \otimes a $.
#! @Returns a morphism in $\mathrm{Hom}( (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a), (b_1 \oplus \dots \oplus b_n) \otimes a)$
#! @Arguments L, a
DeclareOperation( "RightDistributivityFactoring",
                  [ IsList, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = (b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a)$,
#! a list of objects $L = (b_1, \dots, b_n)$,
#! an object $a$,
#! and an object $r = (b_1 \oplus \dots \oplus b_n) \otimes a$.
#! The output is the right distributivity morphism
#! $s \rightarrow r$.
#! @Returns a morphism in $\mathrm{Hom}( s, r )$
#! @Arguments s, L, a, r
DeclareOperation( "RightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategoryObject, IsList, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>RightDistributivityFactoringWithGivenObjects</C>.
#! $F: ((b_1 \otimes a) \oplus \dots \oplus (b_n \otimes a), L, a, (b_1 \oplus \dots \oplus b_n) \otimes a) \mapsto \mathrm{RightDistributivityFactoringWithGivenObjects}(L,a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRightDistributivityFactoringWithGivenObjects",
                  [ IsCapCategory, IsList ] );
