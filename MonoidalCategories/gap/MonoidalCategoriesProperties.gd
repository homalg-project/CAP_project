# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsMonoidalCategory  := Concatenation( [
"TensorProductOnObjects",
"TensorProductOnMorphismsWithGivenTensorProducts",
"TensorUnit",
"AssociatorLeftToRightWithGivenTensorProducts",
"AssociatorRightToLeftWithGivenTensorProducts",
"LeftUnitorWithGivenTensorProduct",
"LeftUnitorInverseWithGivenTensorProduct",
"RightUnitorWithGivenTensorProduct",
"RightUnitorInverseWithGivenTensorProduct"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory );

Perform(
## This is the CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST
    [
      [ "IsMonoidalCategory", "IsMonoidalCategory" ],
      [ "IsStrictMonoidalCategory", "IsStrictMonoidalCategory" ],
    ],
    AddCategoricalProperty );
