# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsMonoidalCategory  :=
  Concatenation(
          ListOfDefiningOperations( "IsCapCategory" ),
          [ "TensorProductOnObjects",
            "TensorProductOnMorphisms",
            "TensorUnit",
            "AssociatorLeftToRight",
            "AssociatorRightToLeft",
            "LeftUnitor",
            "LeftUnitorInverse",
            "RightUnitor",
            "RightUnitorInverse"
            ] );

#! @Description
#!  The property of the category <A>C</A> being monoidal.
#! @Arguments C
DeclareProperty( "IsMonoidalCategory", IsCapCategory );

AddCategoricalProperty( [ "IsMonoidalCategory", "IsMonoidalCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being strict monoidal.
#! @Arguments C
DeclareProperty( "IsStrictMonoidalCategory", IsCapCategory );

AddCategoricalProperty( [ "IsStrictMonoidalCategory", "IsStrictMonoidalCategory" ] );
