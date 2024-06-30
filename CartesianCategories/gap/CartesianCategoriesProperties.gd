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

#! @Description
#!  The property of the category <A>C</A> being strict cartesian.
#! @Arguments C
DeclareProperty( "IsStrictCartesianCategory", IsCapCategory );

AddCategoricalProperty( [ "IsStrictCartesianCategory", "IsStrictCocartesianCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCartesianCategory :=
  DuplicateFreeList(
          Concatenation(
                  CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithTerminalObject,
                  [ "DirectProduct",
                    "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
                    "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
                    ] ) );

## For internal use only:
## we need an operation name different from `DirectProduct`, since CompilerForCAP
## seems to be unable to compile the CAP operation `DirectProduct`
## if declared in a way different from that in the method record
DeclareOperation( "BinaryDirectProduct",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

CapJitAddTypeSignature( "BinaryDirectProduct", [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    BinaryDirectProduct :=
      [ [ "DirectProduct", 1 ] ]
  )
);
