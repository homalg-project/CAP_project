####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Monoidal Categories
##
####################################

DeclareGlobalVariable( "MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD" );

## TensorProductOnObjects

DeclareOperation( "TensorProductOp",
                  [ IsList, IsCapCategoryObject ] );

DeclareOperation( "TensorProductOp",
                  [ IsList, IsCapCategoryMorphism ] );

#! @Description
#! The arguments are two objects $a, b$.
#! The output is the tensor product $a \otimes b$.
#! @Returns an object
#! @Arguments a,b
DeclareOperationWithCache( "TensorProductOnObjects",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>TensorProductOnObjects</C>.
#! $F: (a,b) \mapsto a \otimes b$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorProductOnObjects",
                  [ IsCapCategory, IsList ] );

##
#! @Description
#! The argument is a category $\mathbf{C}$.
#! The output is the tensor unit $1$ of $\mathbf{C}$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "TensorUnit",
                  IsCapCategory );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$ 
#! to the category for the basic operation <C>TensorUnit</C>.
#! $F: ( ) \mapsto 1$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddTensorUnit",
                  [ IsCapCategory, IsList ] );
