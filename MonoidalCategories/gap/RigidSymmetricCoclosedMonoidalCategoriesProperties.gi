# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsRigidSymmetricCoclosedMonoidalCategory :=
  Concatenation(
          ListOfDefiningOperations( "IsSymmetricCoclosedMonoidalCategory" ),
          [ "CoDualOnObjects",
            "CoDualOnMorphismsWithGivenCoDuals",
            "CoclosedEvaluationForCoDualWithGivenTensorProduct",
            "CoclosedCoevaluationForCoDualWithGivenTensorProduct",
            "InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
            "MorphismToCoBidualWithGivenCoBidual",
            ] );

InstallTrueMethod( IsSymmetricCoclosedMonoidalCategory, IsRigidSymmetricCoclosedMonoidalCategory );
