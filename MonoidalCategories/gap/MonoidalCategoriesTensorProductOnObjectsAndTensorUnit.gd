# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

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

##
#! @Description
#! The argument is a category $\mathbf{C}$.
#! The output is the tensor unit $1$ of $\mathbf{C}$.
#! @Returns an object
#! @Arguments C
DeclareAttribute( "TensorUnit",
                  IsCapCategory );
