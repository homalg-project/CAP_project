# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

#! @Description
#!  The property of the category <A>C</A> being symmetric closed monoidal.
#! @Arguments C
DeclareProperty( "IsSymmetricClosedMonoidalCategory", IsCapCategory );

AddCategoricalProperty( [ "IsSymmetricClosedMonoidalCategory", "IsSymmetricCoclosedMonoidalCategory" ] );
