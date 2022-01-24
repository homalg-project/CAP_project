# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

Perform(
## This is the CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST
    [
      [ "IsCartesianCategory", "IsCocartesianCategory" ],
      [ "IsStrictCartesianCategory", "IsStrictCocartesianCategory" ],
    ],
    AddCategoricalProperty );

Append( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory,
        [ "UniversalMorphismIntoDirectProductWithGivenDirectProduct" ] );
