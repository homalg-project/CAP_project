####################################
##
#! @Chapter Cartesian Categories
##
#! @Section Cartesian Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_BRAIDED_CARTESIAN_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "BRAIDED_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD" );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the braiding $ B_{a,b}: a \times b \rightarrow b \times a$.
#! @Returns a morphism in $\mathrm{Hom}( a \times b, b \times a )$.
#! @Arguments a,b
DeclareOperation( "CartesianBraiding",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \times b$, 
#! two objects $a,b$,
#! and an object $r = b \times a$.
#! The output is the braiding $ B_{a,b}: a \times b \rightarrow b \times a$.
#! @Returns a morphism in $\mathrm{Hom}( a \times b, b \times a )$.
#! @Arguments s,a,b,r
DeclareOperation( "CartesianBraidingWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CartesianBraidingWithGivenDirectProducts</C>.
#! $F: (a \times b, a, b, b \times a) \rightarrow B_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianBraidingWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianBraidingWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianBraidingWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianBraidingWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of the braiding $ B_{a,b}^{-1}: b \times a \rightarrow a \times b$.
#! @Returns a morphism in $\mathrm{Hom}( b \times a, a \times b )$.
#! @Arguments a,b
DeclareOperation( "CartesianBraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = b \times a$, 
#! two objects $a,b$,
#! and an object $r = a \times b$.
#! The output is the braiding $ B_{a,b}^{-1}: b \times a \rightarrow a \times b$.
#! @Returns a morphism in $\mathrm{Hom}( b \times a, a \times b )$.
#! @Arguments s,a,b,r
DeclareOperation( "CartesianBraidingInverseWithGivenDirectProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>CartesianBraidingInverseWithGivenDirectProducts</C>.
#! $F: (b \times a, a, b, a \times b) \rightarrow B_{a,b}^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCartesianBraidingInverseWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCartesianBraidingInverseWithGivenDirectProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCartesianBraidingInverseWithGivenDirectProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCartesianBraidingInverseWithGivenDirectProducts",
                  [ IsCapCategory, IsList ] );
