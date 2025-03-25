# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsSymmetricCoclosedMonoidalCategory :=
  DuplicateFreeList(
          Concatenation(
                  ListOfDefiningOperations( "IsSymmetricMonoidalCategory" ),
                  ListOfDefiningOperations( "IsCoclosedMonoidalCategory" ) ) );

InstallTrueMethod( IsCoclosedMonoidalCategory, IsSymmetricCoclosedMonoidalCategory );

InstallTrueMethod( IsSymmetricMonoidalCategory, IsSymmetricCoclosedMonoidalCategory );
