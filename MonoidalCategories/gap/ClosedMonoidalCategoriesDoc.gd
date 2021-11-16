# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Closed Monoidal Categories
##
####################################

#! A monoidal category $\mathbf{C}$
#! which has for each functor $- \otimes b: \mathbf{C} \rightarrow \mathbf{C}$
#! a right adjoint (denoted by $\mathrm{\underline{Hom}}(b,-)$)
#! is called a <Emph>closed monoidal category</Emph>.

#! The corresponding GAP property is called
#! <C>IsClosedMonoidalCategory</C>.

AddCategoricalProperty( [ "IsClosedMonoidalCategory", fail ] );

InstallTrueMethod( IsMonoidalCategory, IsClosedMonoidalCategory );
