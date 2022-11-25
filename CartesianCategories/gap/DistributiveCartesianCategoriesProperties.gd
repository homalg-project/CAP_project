# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

#! @Description
#!  The property of the category <A>C</A> being distributive.
#! @Arguments C
DeclareProperty( "IsDistributiveCategory", IsCapCategory );

AddCategoricalProperty( [ "IsDistributiveCategory", "IsCodistributiveCategory" ] );

InstallTrueMethod( IsCocartesianCategory, IsDistributiveCategory );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsDistributiveCategory  := Concatenation( [
"LeftCartesianDistributivityExpandingWithGivenObjects",
"RightCartesianDistributivityExpandingWithGivenObjects",
],
CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory,
CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory );
