# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Declarations
#

#! @Description
#!  The property of the category <A>C</A> being cartesian.
#! @Arguments C
DeclareProperty( "IsCartesianCategory", IsCapCategory );

AddCategoricalProperty( [ "IsCartesianCategory", "IsCocartesianCategory" ] );

#!  The property of the category <A>C</A> being strict cartesian.
#! @Arguments C
DeclareProperty( "IsStrictCartesianCategory", IsCapCategory );

AddCategoricalProperty( [ "IsStrictCartesianCategory", "IsStrictCocartesianCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory  := Concatenation( [
"DirectProduct",
"ProjectionInFactorOfDirectProductWithGivenDirectProduct",
"UniversalMorphismIntoDirectProductWithGivenDirectProduct",
"TerminalObject",
"UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory );

##
DeclareOperation( "BinaryDirectProduct",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    BinaryDirectProduct :=
      [ [ "DirectProduct", 1 ] ]
  )
);
