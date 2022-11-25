# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

#! @Description
#!  The property of the category <A>C</A> being codistributive.
#! @Arguments C
DeclareProperty( "IsCodistributiveCategory", IsCapCategory );

AddCategoricalProperty( [ "IsCodistributiveCategory", "IsDistributiveCategory" ] );

InstallTrueMethod( IsCartesianCategory, IsCodistributiveCategory );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCodistributiveCategory  := Concatenation( [
"LeftCocartesianCodistributivityFactoringWithGivenObjects",
"RightCocartesianCodistributivityFactoringWithGivenObjects",
],
CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory,
CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory );
