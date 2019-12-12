####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Braided Monoidal Categories
##
####################################

DeclareGlobalVariable( "CAP_INTERNAL_BRAIDED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD" );

##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the braiding $ B_{a,b}: a \otimes b \rightarrow b \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b, b \otimes a )$.
#! @Arguments a,b
DeclareOperation( "Braiding",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = a \otimes b$, 
#! two objects $a,b$,
#! and an object $r = b \otimes a$.
#! The output is the braiding $ B_{a,b}: a \otimes b \rightarrow b \otimes a$.
#! @Returns a morphism in $\mathrm{Hom}( a \otimes b, b \otimes a )$.
#! @Arguments s,a,b,r
DeclareOperation( "BraidingWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>BraidingWithGivenTensorProducts</C>.
#! $F: (a \otimes b, a, b, b \otimes a) \rightarrow B_{a,b}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingWithGivenTensorProducts",
                  [ IsCapCategory, IsList ] );


##
#! @Description
#! The arguments are two objects $a,b$.
#! The output is the inverse of the braiding $ B_{a,b}^{-1}: b \otimes a \rightarrow a \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( b \otimes a, a \otimes b )$.
#! @Arguments a,b
DeclareOperation( "BraidingInverse",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are an object $s = b \otimes a$, 
#! two objects $a,b$,
#! and an object $r = a \otimes b$.
#! The output is the braiding $ B_{a,b}^{-1}: b \otimes a \rightarrow a \otimes b$.
#! @Returns a morphism in $\mathrm{Hom}( b \otimes a, a \otimes b )$.
#! @Arguments s,a,b,r
DeclareOperation( "BraidingInverseWithGivenTensorProducts",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>BraidingInverseWithGivenTensorProducts</C>.
#! $F: (b \otimes a, a, b, a \otimes b) \rightarrow B_{a,b}^{-1}$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddBraidingInverseWithGivenTensorProducts",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "CheckBraiding",
                  [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ] );
