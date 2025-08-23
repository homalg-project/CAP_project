# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

#! @Description
#!  The property of the category <A>C</A> being additive monoidal,
#!  i.e., where the tensor product preserves finite direct sums.
#! @Arguments C
DeclareProperty( "IsAdditiveMonoidalCategory", IsCapCategory );

AddCategoricalProperty( [ "IsAdditiveMonoidalCategory", "IsAdditiveMonoidalCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAdditiveMonoidalCategory :=
  Concatenation(
          ListOfDefiningOperations( "IsMonoidalCategory" ),
          ListOfDefiningOperations( "IsAdditiveCategory" ),
          [ "LeftDistributivityExpanding",
            "LeftDistributivityFactoring",
            "RightDistributivityExpanding",
            "RightDistributivityFactoring",
            ] );

InstallTrueMethod( IsMonoidalCategory, IsAdditiveMonoidalCategory );
InstallTrueMethod( IsAdditiveCategory, IsAdditiveMonoidalCategory );
