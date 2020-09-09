#
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Serre subcategory functions

DeclareOperation( "MembershipFunctionSerreSubcategoryGeneratedByObjects",
                  [ IsList, IsInt, IsCapCategory ] );

DeclareOperation( "MembershipFunctionSerreSubcategoryGeneratedByObjects",
                  [ IsList, IsCapCategory ] );

DeclareGlobalFunction( "FREYD_CATEGORIES_REFINEMENT_FOR_SERRE_SUBCATEGORIES" );

DeclareGlobalFunction( "FREYD_CATEGORIES_CHOP_ABOVE_SERRE_SUBCATEGORIES" );

DeclareGlobalFunction( "FREYD_CATEGORIES_CHOP_BELOW_SERRE_SUBCATEGORIES" );

DeclareGlobalFunction( "FREYD_CATEGORIES_GENERATORS_OF_FREYD_OBJECT_OVER_ROWS" );
