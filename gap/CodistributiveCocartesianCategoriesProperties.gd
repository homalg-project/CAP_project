# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Declarations
#

AddCategoricalProperty( [ "IsCodistributiveCocartesianCategory", "IsDistributiveCartesianCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCodistributiveCocartesianCategory  := Concatenation( [
"LeftCocartesianCodistributivityFactoringWithGivenObjects",
"RightCocartesianCodistributivityFactoringWithGivenObjects",
],
CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory,
CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory );
