# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Declarations
#
#! @Chapter Module Presentations

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the category of left presentations
#! over $R$, constructed internally as the `FreydCategory`
#! of the `CategoryOfRows` of <A>R</A>.
#! Only available if the package `FreydCategoriesForCAP` is available.
#! @Returns a category
#! @Arguments R
DeclareOperation( "LeftPresentations_as_FreydCategory_CategoryOfRows",
                  [ IsHomalgRing ] );

#! @Description
#! The argument is a homalg ring $R$.
#! The output is the category of right presentations
#! over $R$, constructed internally as the `FreydCategory`
#! of the `CategoryOfColumns` of <A>R</A>.
#! Only available if the package `FreydCategoriesForCAP` is available.
#! @Returns a category
#! @Arguments R
DeclareOperation( "RightPresentations_as_FreydCategory_CategoryOfColumns",
                  [ IsHomalgRing ] );
