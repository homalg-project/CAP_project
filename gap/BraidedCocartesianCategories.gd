####################################
##
#! @Chapter Cocartesian Categories
##
#! @Section Cocartesian Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_BRAIDED_COCARTESIAN_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "BRAIDED_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the braiding $ B_{a,b}: a \sqcup b \rightarrow b \sqcup a$.
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup b, b \sqcup a )$.
#! @Arguments a,b
DeclareOperation( "CocartesianBraiding",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \sqcup b$, 
#! two objects $a,b$,
#! and an object $r = b \sqcup a$.
#! The output is the braiding $ B_{a,b}: a \sqcup b \rightarrow b \sqcup a$.
#! @Returns a morphism in $\mathrm{Hom}( a \sqcup b, b \sqcup a )$.
#! @Arguments s,a,b,r
DeclareOperation( "CocartesianBraidingWithGivenCoproducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>CocartesianBraidingWithGivenCoproducts</C>.
#! $F: (a \sqcup b, a, b, b \sqcup a) \rightarrow B_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianBraidingWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianBraidingWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianBraidingWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianBraidingWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of the braiding $ B_{a,b}^{-1}: b \sqcup a \rightarrow a \sqcup b$.
#! @Returns a morphism in $\mathrm{Hom}( b \sqcup a, a \sqcup b )$.
#! @Arguments a,b
DeclareOperation( "CocartesianBraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = b \sqcup a$, 
#! two objects $a,b$,
#! and an object $r = a \sqcup b$.
#! The output is the braiding $ B_{a,b}^{-1}: b \sqcup a \rightarrow a \sqcup b$.
#! @Returns a morphism in $\mathrm{Hom}( b \sqcup a, a \sqcup b )$.
#! @Arguments s,a,b,r
DeclareOperation( "CocartesianBraidingInverseWithGivenCoproducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operations adds the given function $F$ 
#! to the category for the basic operation <C>CocartesianBraidingInverseWithGivenCoproducts</C>.
#! $F: (b \sqcup a, a, b, a \sqcup b) \rightarrow B_{a,b}^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCocartesianBraidingInverseWithGivenCoproducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCocartesianBraidingInverseWithGivenCoproducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCocartesianBraidingInverseWithGivenCoproducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCocartesianBraidingInverseWithGivenCoproducts",
                  [ IsCapCategory, IsList ] );
