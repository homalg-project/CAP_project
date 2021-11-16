# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

####################################
##
#! @Chapter Monoidal Categories
##
#! @Section Symmetric Monoidal Categories
##
####################################

#! A braided monoidal category $\mathbf{C}$ is called <Emph>symmetric monoidal category</Emph>
#! if $B_{a,b}^{-1} = B_{b,a}$.
#! The corresponding GAP property is given by
#! <C>IsSymmetricMonoidalCategory</C>.

AddCategoricalProperty( [ "IsSymmetricMonoidalCategory", "IsSymmetricMonoidalCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsSymmetricMonoidalCategory  := Concatenation( [
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsBraidedMonoidalCategory );

InstallTrueMethod( IsBraidedMonoidalCategory, IsSymmetricMonoidalCategory );
