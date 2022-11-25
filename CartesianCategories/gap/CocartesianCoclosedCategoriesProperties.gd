# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

#! @Description
#!  The property of the category <A>C</A> being cocartesian coclosed.
#! @Arguments C
DeclareProperty( "IsCocartesianCoclosedCategory", IsCapCategory );

AddCategoricalProperty( [ "IsCocartesianCoclosedCategory", "IsCartesianClosedCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being bicartesian coclosed.
#! @Arguments C
DeclareProperty( "IsBicartesianCoclosedCategory", IsCapCategory );

AddCategoricalProperty( [ "IsBicartesianCoclosedCategory", "IsBicartesianClosedCategory" ] );
