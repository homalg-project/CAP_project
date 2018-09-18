#
# Toposes: universal objects
#
# Declarations
#

# @Chapter Universal objects

# @Section Tools

##
#! @Description
#! The arguments are an object $s = a \times (b \times c)$,
#! three objects $a,b,c$,
#! and an object $r = (a \times b) \times c$.
#! The output is the associator $\alpha_{a,(b,c)}: a \times (b \times c) \rightarrow (a \times b) \times c$.
#! @Returns a morphism in $\mathrm{Hom}( a \times (b \times c), (a \times b) \times c )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts</C>.
#! $F: ( a \times (b \times c), a, b, c, (a \times b) \times c ) \mapsto \alpha_{a,(b,c)}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are an object $s = (a \times b) \times c$,
#! three objects $a,b,c$,
#! and an object $r = a \times (b \times c)$.
#! The output is the associator $\alpha_{(a,b),c}: (a \times b) \times c \rightarrow a \times (b \times c)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \times b) \times c \rightarrow a \times (b \times c) )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts</C>.
#! $F: (( a \times b ) \times c, a, b, c, a \times (b \times c )) \mapsto \alpha_{(a,b),c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRightOfDirectProductsWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The arguments are an object $s = a \sqcup (b \sqcup c)$,
#! three objects $a,b,c$,
#! and an object $r = (a \sqcup b) \sqcup c$.
#! The output is the associator $\alpha_{a,(b,c)}: a \sqcup (b \sqcup c) \rightarrow (a \sqcup b) \sqcup c$.
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup (b \sqcup c), (a \sqcup b) \sqcup c )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "AssociatorRightToLeftOfCoproductsWithGivenCoproducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AssociatorRightToLeftOfCoproductsWithGivenCoproducts</C>.
#! $F: ( a \sqcup (b \sqcup c), a, b, c, (a \sqcup b) \sqcup c ) \mapsto \alpha_{a,(b,c)}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorRightToLeftOfCoproductsWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorRightToLeftOfCoproductsWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeftOfCoproductsWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorRightToLeftOfCoproductsWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are an object $s = (a \sqcup b) \sqcup c$,
#! three objects $a,b,c$,
#! and an object $r = a \sqcup (b \sqcup c)$.
#! The output is the associator $\alpha_{(a,b),c}: (a \sqcup b) \sqcup c \rightarrow a \sqcup (b \sqcup c)$.
#! @Returns a morphism in $\mathrm{Hom}( (a \sqcup b) \sqcup c \rightarrow a \sqcup (b \sqcup c) )$.
#! @Arguments s, a, b, c, r
DeclareOperation( "AssociatorLeftToRightOfCoproductsWithGivenCoproducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$
#! to the category for the basic operation <C>AssociatorLeftToRightOfCoproductsWithGivenCoproducts</C>.
#! $F: (( a \sqcup b ) \sqcup c, a, b, c, a \sqcup (b \sqcup c )) \mapsto \alpha_{(a,b),c}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddAssociatorLeftToRightOfCoproductsWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddAssociatorLeftToRightOfCoproductsWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRightOfCoproductsWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddAssociatorLeftToRightOfCoproductsWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );
