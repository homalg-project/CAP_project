# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

#! @Description
#!  The property of the category <A>C</A> being cartesian closed.
#! @Arguments C
DeclareProperty( "IsCartesianClosedCategory", IsCapCategory );

AddCategoricalProperty( [ "IsCartesianClosedCategory", "IsCocartesianCoclosedCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being bicartesian closed.
#! @Arguments C
DeclareProperty( "IsBicartesianClosedCategory", IsCapCategory );

AddCategoricalProperty( [ "IsBicartesianClosedCategory", "IsBicartesianCoclosedCategory" ] );
