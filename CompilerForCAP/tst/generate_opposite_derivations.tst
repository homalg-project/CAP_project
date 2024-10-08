gap> START_TEST( "generate_opposite_derivations" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> LoadPackage( "CAP", false );
true

#
# We introduce functions for viewing objects in different instances of "the same" category.
# We do not actually call those functions, so we do not need an implementation.
gap> BindGlobal( "CoercedObject", function ( cat_from, cat_to, object )
>   
>   Error( "not implemented" );
>   
> end );

#
gap> BindGlobal( "CoercedMorphism", function ( cat_from, cat_to, object )
>   
>   Error( "not implemented" );
>   
> end );

#
gap> CapJitAddTypeSignature( "CoercedObject", [ IsCapCategory, IsCapCategory, IsCapCategoryObject ], function ( input_types )
>   
>   return CapJitDataTypeOfObjectOfCategory( input_types[2].category );
>   
> end );

#
gap> CapJitAddTypeSignature( "CoercedMorphism", [ IsCapCategory, IsCapCategory, IsCapCategoryMorphism ], function ( input_types )
>   
>   return CapJitDataTypeOfMorphismOfCategory( input_types[2].category );
>   
> end );

#
# add logic templates which cancel coercions
gap> CapJitAddLogicTemplate(
>   rec(
>       variable_names := [ "cat", "cat2", "object" ],
>       src_template := "CoercedObject( cat2, cat, CoercedObject( cat, cat2, object ) )",
>       dst_template := "object",
>   )
> );
gap> CapJitAddLogicTemplate(
>   rec(
>       variable_names := [ "cat", "cat2", "morphism" ],
>       src_template := "CoercedMorphism( cat2, cat, CoercedMorphism( cat, cat2, morphism ) )",
>       dst_template := "morphism",
>   )
> );
gap> CapJitAddLogicTemplate(
>   rec(
>       variable_names := [ "cat", "cat2", "morphism" ],
>       src_template := "CoercedObject( cat2, cat, Source( CoercedMorphism( cat, cat2, morphism ) ) )",
>       dst_template := "Source( morphism )",
>   )
> );
gap> CapJitAddLogicTemplate(
>   rec(
>       variable_names := [ "cat", "cat2", "morphism" ],
>       src_template := "CoercedObject( cat2, cat, Range( CoercedMorphism( cat, cat2, morphism ) ) )",
>       dst_template := "Range( morphism )",
>   )
> );

#
# checks if `filter` is a filter of the form `HasProperty and Property` for a categorical property
# and returns `[ "Property", "DualProperty" ]` if this is the case
# `IsCapCategory` is handled as a self-dual special case
gap> BindGlobal( "PropertyAndOppositeProperty", function ( filter )
> local names_filter, pos;
>   
>   if IsIdenticalObj( filter, IsCapCategory ) then
>       
>       return [ "IsCapCategory", "IsCapCategory" ];
>       
>   fi;
>   
>   if not IsFilter( filter ) then
>       
>       return fail;
>       
>   fi;
>   
>   names_filter := NamesFilter( filter );
>   
>   if not Length( names_filter ) = 2 then
>       
>       return fail;
>       
>   fi;
>   
>   # `HasFilter` comes after `Filter` (if `Filter` was declared via `DeclareFilter`)
>   if names_filter[2] <> Concatenation( "Has", names_filter[1] ) then
>       
>       return fail;
>       
>   fi;
>   
>   pos := PositionProperty( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST, x -> x[1] = names_filter[1] );
>   
>   if pos = fail then
>       
>       return fail;
>       
>   fi;
>   
>   return CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST[pos];
>   
> end );

#
gap> CAP_JIT_INTERNAL_COPY_OF_CATEGORY := fail;;

#
gap> BindGlobal( "GenerateOppositeDerivation", function ( derivation )
> local operation_name, dual_operation_name, list_of_operations_to_install, property_pair, properties, dummy, op, weight_list, op_op, copy, info, input_arguments_names, filter_list, return_type, prepared_arguments_strings, recoercion_function_string, compiled_func, op_name;
>   
>   PushOptions( rec( overhead := false ) );
>   
>   operation_name := TargetOperation( derivation );
>   
>   dual_operation_name := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).dual_operation;
>   
>   # create a dummy category with dual preconditions
>   list_of_operations_to_install := List( UsedOperationsWithMultiplesAndCategoryGetters( derivation ), x -> CAP_INTERNAL_METHOD_NAME_RECORD.(x[1]).dual_operation );
>   
>   property_pair := PropertyAndOppositeProperty( CategoryFilter( derivation ) );
>   
>   if property_pair[2] = "IsCapCategory" then
>       
>       properties := [ ];
>       
>   else
>       
>       properties := [ property_pair[2] ];
>       
>   fi;
>   
>   dummy := DummyCategory( rec(
>       name := Concatenation( "Dummy for ", dual_operation_name ),
>       list_of_operations_to_install := list_of_operations_to_install,
>       properties := properties,
>   ) : FinalizeCategory := false );
>   
>   Finalize( dummy : disable_derivations := true );
>   
>   StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );
>   
>   # dualize the category
>   op := Opposite( dummy : only_primitive_operations := true, FinalizeCategory := false );
>   
>   # trigger the derivation manually
>   weight_list := MakeOperationWeightList( op, CAP_INTERNAL_DERIVATION_GRAPH );
>   op!.derivations_weight_list := weight_list;
>   for op_name in RecNames( op!.operations ) do
>       AddPrimitiveOperation( weight_list, op_name, op!.operations.(op_name).weight );
>   od;
>   TryToTriggerDerivation( weight_list, derivation );
>   InstallDerivationForCategory( derivation, CurrentOperationWeight( weight_list, operation_name ), op );
>   Assert( 0, CanCompute( op, operation_name ) );
>   
>   Finalize( op : disable_derivations := true );
>   
>   # take the opposite again, where the dual operation is now available
>   op_op := Opposite( op, Concatenation( "Double opposite of ", Name( dummy ) ) : FinalizeCategory := false );
>   
>   Finalize( op_op : disable_derivations := true );
>   
>   Assert( 0, CanCompute( op_op, dual_operation_name ) );
>   
>   # reinterpret the double dual as the original category
>   copy := ReinterpretationOfCategory( op_op, rec(
>       name := Concatenation( "Copy of ", Name( dummy ), " (as double opposite of itself)" ),
>       category_filter := IsDummyCategory,
>       category_object_filter := IsDummyCategoryObject,
>       category_morphism_filter := IsDummyCategoryMorphism,
>       object_constructor := { copy, orig_object } -> CoercedObject( OppositeCategory( OppositeCategory( ModelingCategory( copy ) ) ), copy, orig_object ),
>       object_datum := { copy, copy_object } -> CoercedObject( copy, OppositeCategory( OppositeCategory( ModelingCategory( copy ) ) ), copy_object ),
>       morphism_constructor := { copy, source, orig_morphism, range } -> CoercedMorphism( OppositeCategory( OppositeCategory( ModelingCategory( copy ) ) ), copy, orig_morphism ),
>       morphism_datum := { copy, copy_morphism } -> CoercedMorphism( copy, OppositeCategory( OppositeCategory( ModelingCategory( copy ) ) ), copy_morphism ),
>       modeling_tower_object_constructor := { copy, orig_object } -> ObjectConstructor( ModelingCategory( copy ), ObjectConstructor( OppositeCategory( ModelingCategory( copy ) ), orig_object ) ),
>       modeling_tower_object_datum := { copy, tower_object } -> Opposite( Opposite( tower_object ) ),
>       modeling_tower_morphism_constructor := { copy, source, orig_morphism, range } -> MorphismConstructor( ModelingCategory( copy ), source, MorphismConstructor( OppositeCategory( ModelingCategory( copy ) ), Opposite( range ), orig_morphism, Opposite( source ) ), range ),
>       modeling_tower_morphism_datum := { copy, tower_morphism } -> Opposite( Opposite( tower_morphism ) ),
>   ) : FinalizeCategory := false );
>   
>   Finalize( copy : disable_derivations := true );
>   
>   # to compute the dual operation in the original category, we coerce objects and morphism to the copy,
>   # compute the dual operation there, and re-coerce the result back to the original category
>   info := CAP_INTERNAL_METHOD_NAME_RECORD.(dual_operation_name);
>   
>   input_arguments_names := info.input_arguments_names;
>   filter_list := info.filter_list;
>   return_type := info.return_type;
>   
>   prepared_arguments_strings := List( [ 1 .. Length( filter_list ) ], function( i )
>     local filter, argument_name;
>       
>       filter := filter_list[i];
>       argument_name := input_arguments_names[i];
>       
>       if filter = "category" then
>           
>           return "copy";
>           
>       elif filter = "object" then
>           
>           return Concatenation( "CoercedObject( cat, copy, ", argument_name, " )" );
>           
>       elif filter = "morphism" then
>           
>           return Concatenation( "CoercedMorphism( cat, copy, ", argument_name, " )" );
>           
>       elif filter in [ "integer", "element_of_commutative_ring_of_linear_structure", "nonneg_integer_or_infinity", "list_of_elements_of_commutative_ring_of_linear_structure" ] then
>           
>           return argument_name;
>           
>       elif filter = "list_of_objects" then
>           
>           return Concatenation( "List( ", argument_name, ", x -> CoercedObject( cat, copy, x ) )" );
>           
>       elif filter = "list_of_morphisms" then
>           
>           return Concatenation( "List( ", argument_name, ", x -> CoercedMorphism( cat, copy, x ) )" );
>           
>       elif filter = "pair_of_morphisms" then
>           
>           return Concatenation( "Pair( CoercedMorphism( cat, copy, ", argument_name, "[1] ), CoercedMorphism( cat, copy, ", argument_name, "[2] ) )" );
>           
>       elif filter = "list_of_integers_and_list_of_morphisms" then
>           
>           return Concatenation( "Pair( ", argument_name, "[1], List( ", argument_name, "[2], x -> CoercedMorphism( cat, copy, x ) ) )" );
>           
>       else
>           
>           Error( "this case is not handled yet" );
>           
>       fi;
>       
>   end );
>   
>   if return_type = "bool" then
>       
>       recoercion_function_string := "IdFunc";
>   
>   elif return_type = "object" then
>       
>       recoercion_function_string := "(obj -> CoercedObject( copy, cat, obj ))";
>       
>   elif return_type = "morphism" then
>       
>       recoercion_function_string := "(mor -> CoercedMorphism( copy, cat, mor ))";
>       
>   else
>       
>       Error( "this case is not handled yet" );
>       
>   fi;
>   
>   CAP_JIT_INTERNAL_COPY_OF_CATEGORY := copy;
>   
>   compiled_func := CapJitCompiledFunction(
>       EvalString( ReplacedStringViaRecord(
>           """
>               function( input_arguments... )
>                 local copy;
>                   
>                   copy := CAP_JIT_INTERNAL_COPY_OF_CATEGORY;
>                   
>                   return recoercion_function( dual_operation( prepared_arguments... ) );
>                   
>               end
>           """,
>           rec(
>               input_arguments := input_arguments_names,
>               prepared_arguments := prepared_arguments_strings,
>               dual_operation := dual_operation_name,
>               recoercion_function := recoercion_function_string,
>           )
>       ) ),
>       dummy,
>       filter_list,
>       return_type
>   );
>   
>   Assert( 0, ValueOption( "overhead" ) = false );
>   
>   PopOptions( );
>   
>   Assert( 0, ValueOption( "overhead" ) = fail );
>   
>   return compiled_func;
>   
> end );

#
# collect all derivations
gap> derivations_by_target := CAP_INTERNAL_DERIVATION_GRAPH!.derivations_by_target;;
gap> derivations := Concatenation( List( SortedList( RecNames( derivations_by_target ) ), name -> derivations_by_target.(name) ) );;

#
# exclude various derivations
gap> derivations := Filtered( derivations, function ( d )
> local info, used_op_names_with_multiples_and_category_getters, dualized_used_op_names_with_multiples_and_category_getters, x;
>   
>   # exclude previously autogenerated derivations
>   if d!.is_autogenerated_by_CompilerForCAP then
>       
>       return false;
>       
>   fi;
>   
>   # exclude WithGiven derivations; those are automatically generated anyway
>   if d!.is_with_given_derivation then
>       
>       return false;
>       
>   fi;
>   
>   info := CAP_INTERNAL_METHOD_NAME_RECORD.(TargetOperation( d ));
>   
>   # exclude operations without duals
>   if not IsBound( info.dual_operation ) then
>       
>       return false;
>       
>   fi;
>   
>   # exclude operations from other packages for now
>   if PackageOfCAPOperation( info.dual_operation ) <> "CAP" then
>       
>       return false;
>       
>   fi;
>   
>   # exclude random functions
>   if StartsWith( TargetOperation( d ), "Random" ) then
>       
>       return false;
>       
>   fi;
>   
>   # exclude derivations with category filters for which we have no dual
>   if PropertyAndOppositeProperty( CategoryFilter( d ) ) = fail then
>       
>       return false;
>       
>   fi;
>   
>   # exclude derivations with FunctionCalledBeforeInstallation
>   if HasFunctionCalledBeforeInstallation( d ) then
>       
>       return false;
>       
>   fi;
>   
>   used_op_names_with_multiples_and_category_getters := UsedOperationsWithMultiplesAndCategoryGetters( d );
>   
>   dualized_used_op_names_with_multiples_and_category_getters := [ ];
>   
>   for x in used_op_names_with_multiples_and_category_getters do
>       
>       # exclude if preconditions do not have duals
>       if not IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(x[1]).dual_operation ) then
>           
>           return false;
>           
>       fi;
>       
>       # exclude operations from other packages for now
>       if PackageOfCAPOperation( CAP_INTERNAL_METHOD_NAME_RECORD.(x[1]).dual_operation ) <> "CAP" then
>           
>           return false;
>           
>       fi;
>       
>       # exclude if other categories are involved
>       if x[3] <> fail then
>           
>           return false;
>           
>       fi;
>       
>       Add( dualized_used_op_names_with_multiples_and_category_getters, [ CAP_INTERNAL_METHOD_NAME_RECORD.(x[1]).dual_operation, x[2], x[3] ] );
>       
>   od;
>   
>   # exclude if the derivation is self-dual
>   if info.dual_operation = TargetOperation( d ) and Set( used_op_names_with_multiples_and_category_getters ) = Set( dualized_used_op_names_with_multiples_and_category_getters ) then
>       
>       return false;
>       
>   fi;
>   
>   # exclude if twocells are involved
>   if "twocell" in info.filter_list or ForAny( used_op_names_with_multiples_and_category_getters, x -> "twocell" in CAP_INTERNAL_METHOD_NAME_RECORD.(x[1]).filter_list ) then
>       
>       return false;
>       
>   fi;
>   
>   return true;
>   
> end );;

#
# sort derivations by the names of the dual operations
gap> StableSortBy( derivations, d -> CAP_INTERNAL_METHOD_NAME_RECORD.(TargetOperation( d )).dual_operation );

#
gap> output_string :=
> """# SPDX-License-Identifier: GPL-2.0-or-later
> # CAP: Categories, Algorithms, Programming
> #
> # Implementations
> #
> # THIS FILE IS AUTOMATICALLY GENERATED, SEE CompilerForCAP/tst/generate_opposite_derivations.tst
> """;;

#
# loop over derivations and dualize them
# 
gap> for derivation in derivations do
>   
>   operation_name := TargetOperation( derivation );
>   dual_operation_name := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).dual_operation;
>   
>   description := Description( derivation );
>   
>   description_op := Concatenation( "dualizing the derivation of ", TargetOperation( derivation ), " by ", description );
>   
>   func := GenerateOppositeDerivation( derivation );
>   
>   preconditions_string := JoinStringsWithSeparator( List( UsedOperationsWithMultiplesAndCategoryGetters( derivation ), function( x )
>     local operation_name, dual_operation_name;
>       
>       Assert( 0, x[3] = fail );
>       
>       operation_name := x[1];
>       
>       dual_operation_name := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).dual_operation;
>       
>       return Concatenation( "                        [ ", dual_operation_name, ", ", String( x[2] ), " ],\n" );
>       
>   end ), "" );
>   
>   function_string := CapJitPrettyPrintFunction( func );
>   
>   if PositionSublist( function_string, "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_" ) <> fail then
>       
>       # COVERAGE_IGNORE_NEXT_LINE
>       Error( "Could not get rid of all global variables, see <function_string>." );
>       
>   fi;
>   
>   current_string := Concatenation(
>       "\n",
>       "##\n",
>       "AddDerivationToCAP( ", dual_operation_name, ",\n",
>       "                    \"", description_op, "\",\n",
>       "                    [\n",
>       preconditions_string,
>       "                    ],\n",
>       "                    \n",
>       "  ", function_string, " : CategoryFilter := ", PropertyAndOppositeProperty( CategoryFilter( derivation ) )[2], ",\n",
>       "      Weight := ", String( AdditionalWeight( derivation ) ), ",\n",
>       "      is_autogenerated_by_CompilerForCAP := true );\n"
>   );
>   
>   output_string := Concatenation( output_string, current_string );
>   
> od;

#
# write result to file
gap> if not IsExistingFileInPackageForHomalg( "CAP", "DerivedMethods.autogen.gi" ) or output_string <> ReadFileFromPackageForHomalg( "CAP", "DerivedMethods.autogen.gi" ) then
>   
>   output_path := Filename( DirectoryTemporary( ), "DerivedMethods.autogen.gi" );
>   
>   WriteFileForHomalg( output_path, output_string );
>   
>   Display( Concatenation(
>       "WARNING: The file DerivedMethods.autogen.gi differs from the automatically generated one. ",
>       "You can view the automatically generated file at the following path: ",
>       output_path
>   ) );
>   
> fi;

#
gap> STOP_TEST( "generate_opposite_derivations" );
