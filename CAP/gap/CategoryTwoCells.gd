# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Declarations
#
#! @Chapter Category 2-Cells

######################################
##
#! @Section Attributes for the Type of 2-Cells
##
######################################

#! @Description
#! The argument is a $2$-cell $c: \alpha \rightarrow \beta$.
#! The output is its source $\alpha$.
#! @Returns a morphism
#! @Arguments c
DeclareAttribute( "Source",
                  IsCapCategoryTwoCell );

#! @Description
#! The argument is a $2$-cell $c: \alpha \rightarrow \beta$.
#! The output is its range $\beta$.
#! @Returns a morphism
#! @Arguments c
DeclareAttribute( "Range",
                  IsCapCategoryTwoCell );

#! @Description
#! The argument is a $2$-cell $c: \alpha \rightarrow \beta$.
#! The output is its target $\beta$.
#! @Returns a morphism
#! @Arguments c
DeclareAttribute( "Target",
                  IsCapCategoryTwoCell );

###################################
##
#! @Section Adding 2-Cells to a Category
##
###################################

DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryTwoCell ] );

DeclareOperation( "AddTwoCell",
                  [ IsCapCategory, IsObject ] );
