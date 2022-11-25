# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

#! @Description
#!  The property of the category <A>C</A> being initial.
#! @Arguments C
DeclareProperty( "IsInitialCategory", IsCapCategory );

AddCategoricalProperty( [ "IsInitialCategory", "IsInitialCategory" ] );
