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

#! @Description
#!  Adds <A>twocell</A> as a $2$-cell to <A>category</A>.
#! @Arguments category, twocell
DeclareOperation( "Add",
                  [ IsCapCategory, IsCapCategoryTwoCell ] );

#! @Description
#!  Adds <A>twocell</A> as a $2$-cell to <A>category</A>.
#!  If <A>twocell</A> already lies in the filter <C>IsCapCategoryTwoCell</C>,
#!  the operation <Ref Oper="Add" Label="for IsCapCategory, IsCapCategoryTwoCell" />
#!  can be used instead.
#! @Arguments category, twocell
DeclareOperation( "AddTwoCell",
                  [ IsCapCategory, IsAttributeStoringRep ] );
                  
#! @Arguments category, source, range[, attr1, val1, attr2, val2, ...]
#! @Description
#!  Creates a $2$-cell in <A>category</A> with the given attributes.
#! @Returns a twocell
DeclareGlobalFunction( "CreateCapCategoryTwoCellWithAttributes" );
