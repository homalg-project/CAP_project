# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsBraidedMonoidalCategory  := Concatenation( [
"BraidingWithGivenTensorProducts",
"BraidingInverseWithGivenTensorProducts"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsMonoidalCategory );

InstallTrueMethod( IsMonoidalCategory, IsBraidedMonoidalCategory );
