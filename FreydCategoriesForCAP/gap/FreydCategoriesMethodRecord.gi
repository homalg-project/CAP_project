# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

InstallValue( FREYD_CATEGORIES_METHOD_NAME_RECORD, rec(

## an abelian construction
SomeProjectiveObjectForKernelObject := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object",
  dual_operation := "SomeInjectiveObjectForCokernelObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObjectForKernelObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  with_given_object_position := "Source",
  output_range_getter_string := "KernelObject( cat, alpha )",
  output_range_getter_preconditions := [ [ "KernelObject", 1 ] ],
  return_type := "morphism",
  dual_operation := "MonomorphismToSomeInjectiveObjectForCokernelObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "source" ],
  return_type := "morphism",
  output_source_getter_string := "source",
  output_range_getter_string := "KernelObject( cat, alpha )",
  output_range_getter_preconditions := [ [ "KernelObject", 1 ] ],
  dual_operation := "MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject",
  is_merely_set_theoretic := true ),

SomeInjectiveObjectForCokernelObject := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "object",
  dual_operation := "SomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

MonomorphismToSomeInjectiveObjectForCokernelObject := rec(
  filter_list := [ "category", "morphism" ],
  input_arguments_names := [ "cat", "alpha" ],
  output_source_getter_string := "CokernelObject( cat, alpha )",
  output_source_getter_preconditions := [ [ "CokernelObject", 1 ] ],
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "EpimorphismFromSomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

MonomorphismToSomeInjectiveObjectForCokernelObjectWithGivenSomeInjectiveObjectForCokernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  input_arguments_names := [ "cat", "alpha", "range" ],
  return_type := "morphism",
  output_source_getter_string := "CokernelObject( cat, alpha )",
  output_source_getter_preconditions := [ [ "CokernelObject", 1 ] ],
  output_range_getter_string := "range",
  dual_operation := "EpimorphismFromSomeProjectiveObjectForKernelObjectWithGivenSomeProjectiveObjectForKernelObject",
  is_merely_set_theoretic := true ),

  ) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( FREYD_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD(
    FREYD_CATEGORIES_METHOD_NAME_RECORD,
    "FreydCategoriesForCAP",
    "MethodRecord",
    "Add Functions",
    "Available Add functions"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( FREYD_CATEGORIES_METHOD_NAME_RECORD, "FreydCategoriesForCAP" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( FREYD_CATEGORIES_METHOD_NAME_RECORD );

####################################
##
## Free abelian category
##
####################################

InstallMethod( AsMorphismInFreeAbelianCategory,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return Opposite(
        AsFreydCategoryMorphism(
          Opposite(
            AsFreydCategoryMorphism(
              AsAdditiveClosureMorphism( morphism )
            )
          )
       )
      );
    
end );

###################################
##
## Finitely presented functors
##
####################################

##
InstallMethod( CovariantExtAsFreydCategoryObject,
               [ IsCapCategoryObject, IsInt ],
               
  function( object, i )
    local morphism, j;
    
    if i = 0 then
        
        return AsFreydCategoryObject( Opposite( object ) );
        
    fi;
    
    morphism := EpimorphismFromSomeProjectiveObject( object );
    
    for j in [ 2 .. i ] do
        
        morphism := EpimorphismFromSomeProjectiveObjectForKernelObject( morphism );
        
    od;
    
    return FreydCategoryObject( Opposite( KernelEmbedding( morphism ) ) );
    
end );
