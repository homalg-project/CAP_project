# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

InstallValue( MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD, rec(

TensorProductOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "object",
  dual_operation := "TensorProductOnObjects",
  dual_arguments_reversed := false,
  # Test in MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest
),

TensorUnit := rec(
  filter_list := [ "category" ],
  return_type := "object",
  dual_operation := "TensorUnit",
  # Test in MonoidalCategoriesTensorProductOnObjectsAndTensorUnitTest
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "MonoidalCategoriesTensorProductOnObjectsAndTensorUnitMethodRecord",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD );
