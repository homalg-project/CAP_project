# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( "CapJitPrecompileCategory", function ( category_constructor, given_arguments, package_name, compiled_category_name )
  local cat1, cat2, cat, transitively_needed_other_packages, operations, diff, source_attribute_getter_name, range_attribute_getter_name, output_string, package_info, parameters, current_string, compiled_tree, compiled_func, function_string, number_of_occurrences_in_string, weight, IsPrecompiledDerivation_string, function_name, current_rec;
    
    if IsOperation( category_constructor ) or IsKernelFunction( category_constructor ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "category_constructor must be a regular function, i.e. not an operation or a kernel function" );
        
    fi;
    
    # check if category_constructor returns a new instance of the category every time
    cat1 := CallFuncList( category_constructor, given_arguments : no_precompiled_code := true );
    cat2 := CallFuncList( category_constructor, given_arguments : no_precompiled_code := true );
    
    if IsIdenticalObj( cat1, cat2 ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the category constructor must not return the same instance of the category if called twice" );
        
    fi;
    
    # check that category_constructor supports `FinalizeCategory`
    cat := CallFuncList( category_constructor, given_arguments : FinalizeCategory := false, no_precompiled_code := true );
    
    if IsFinalized( cat ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the category constructor must support the option `FinalizeCategory`" );
        
    fi;
    
    Finalize( cat );
    
    if ValueOption( "operations" ) = fail then
        
        transitively_needed_other_packages := TransitivelyNeededOtherPackages( package_name );
        
        # the case `PackageOfCAPOperation( operation_name ) = fail` is handled implicitely
        operations := Filtered( ListInstalledOperationsOfCategory( cat ), operation_name -> PackageOfCAPOperation( operation_name ) in transitively_needed_other_packages );
        
    elif ValueOption( "operations" ) = "primitive" then
        
        operations := ListPrimitivelyInstalledOperationsOfCategory( cat );
        
    elif IsStringRep( ValueOption( "operations" ) ) then # use IsStringRep instead of IsString to distinguish between the empty string and an empty list
        
        # COVERAGE_IGNORE_BLOCK_START
        Display( "WARNING: the option <operations> is a string. This is a convenience for debugging which should not be used in production code." );
        operations := [ ValueOption( "operations" ) ];
        # COVERAGE_IGNORE_BLOCK_END
        
        # due to https://github.com/gap-system/gap/issues/4995 we have to ignore the following line
        # COVERAGE_IGNORE_NEXT_LINE
    else
        
        operations := ValueOption( "operations" );
        
    fi;
    
    diff := Difference( operations, RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) );
    
    if Length( diff ) > 0 then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "The following strings are no CAP operations and can thus not be compiled: ", diff );
        
    fi;
    
    diff := Difference( operations, ListInstalledOperationsOfCategory( cat ) );
    
    if Length( diff ) > 0 then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "The following operations you want to have compiled are not computable in the given category: ", diff );
        
    fi;
    
    if IsBound( cat!.compiler_hints ) and IsBound( cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute ) then
        
        source_attribute_getter_name := cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.source_attribute_getter_name;
        
        if source_attribute_getter_name <> NameFunction( ValueGlobal( source_attribute_getter_name ) ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Display( Concatenation( "WARNING: the source_attribute_getter_name ", source_attribute_getter_name, " is not equal to its canonical name ", NameFunction( ValueGlobal( source_attribute_getter_name ) ), ". This might cause errors." ) );
            
        fi;
        
        range_attribute_getter_name := cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.range_attribute_getter_name;
        
        if range_attribute_getter_name <> NameFunction( ValueGlobal( range_attribute_getter_name ) ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Display( Concatenation( "WARNING: the range_attribute_getter_name ", range_attribute_getter_name, " is not equal to its canonical name ", NameFunction( ValueGlobal( range_attribute_getter_name ) ), ". This might cause errors." ) );
            
        fi;
        
    fi;
    
    output_string := "";
    
    package_info := First( PackageInfo( package_name ) );
    
    if package_info = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "could not find package info" );
        
    fi;
    
    current_string := Concatenation(
        "# SPDX-License-Identifier: GPL-2.0-or-later\n",
        "# ", package_name, ": ", package_info.Subtitle, "\n",
        "#\n",
        "# Implementations\n",
        "#\n",
        "BindGlobal( \"ADD_FUNCTIONS_FOR_", compiled_category_name, "\", function ( cat )\n"
    );
    output_string := Concatenation( output_string, current_string );
    
    for function_name in operations do
        
        # random functions are not functional and for example inlining might produce wrong results
        if StartsWith( function_name, "Random" ) then
            
            continue;
            
        fi;
        
        current_rec := CAP_INTERNAL_METHOD_NAME_RECORD.(function_name);
        
        # operations/derivations returning fail usually do not fulfill the requirements that all branches of an if statement can be executed
        # even if the corresponding condition does not hold
        if IsString( current_rec.return_type ) and EndsWith( current_rec.return_type, "fail" ) then
            
            continue;
            
        fi;
        
        compiled_tree := CapJitCompiledCAPOperationAsEnhancedSyntaxTree( cat, function_name, true );
        
        # change names of arguments
        compiled_tree := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID(
            compiled_tree,
            compiled_tree.id,
            Concatenation( current_rec.input_arguments_names, compiled_tree.nams{[ compiled_tree.narg + 1 .. Length( compiled_tree.nams ) ]} )
        );
        
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( compiled_tree );
        
        function_string := CapJitPrettyPrintFunction( compiled_func );
        
        if PositionSublist( function_string, "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_" ) <> fail then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "Could not get rid of all global variables, see <function_string>. You should use category_hints.category_attribute_names." );
            
        fi;
        
        # heuristic: if some given argument is a CAP category at which compilation is stopped, CAP operations in the compiled code are expected
        if not ForAny( given_arguments, a -> IsCapCategory( a ) and ((IsBound( a!.stop_compilation ) and a!.stop_compilation = true) or (IsBound( a!.stop_compilation_at_primitively_installed_operations ) and a!.stop_compilation_at_primitively_installed_operations = true)) ) then
        
            if not IsEmpty(
                    CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION(
                        compiled_func,
                        RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ),
                        2,
                        CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS,
                        rec( )
                    )
                ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( Concatenation( "WARNING: Could not resolve all CAP operations while precompiling ", function_name, "." ) );
                
            fi;
            
        fi;
        
        number_of_occurrences_in_string := function ( haystack, needle )
            
            return (Length( haystack ) - Length( ReplacedString( haystack, needle, "" ) )) / Length( needle );
            
        end;
        
        # plausibility checks for the number of occurrences of `CreateCapCategory*WithAttributes`
        # we check for > instead of <> because deduplication or WithGiven operations might reduce the number
        
        if current_rec.return_type = "bool" then
            
            if number_of_occurrences_in_string( function_string, "CreateCapCategoryObjectWithAttributes" ) > 0 then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( Concatenation( "WARNING: Could not eliminate `CreateCapCategoryObjectWithAttributes` while precompiling ", function_name, "." ) );
                
            fi;
            
            if number_of_occurrences_in_string( function_string, "CreateCapCategoryMorphismWithAttributes" ) > 0 then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( Concatenation( "WARNING: Could not eliminate `CreateCapCategoryMorphismWithAttributes` while precompiling ", function_name, "." ) );
                
            fi;
            
        fi;
        
        if current_rec.return_type = "object" and ValueOption( "number_of_objectified_objects_in_data_structure_of_object" ) <> fail then
            
            if number_of_occurrences_in_string( function_string, "CreateCapCategoryObjectWithAttributes" ) > ValueOption( "number_of_objectified_objects_in_data_structure_of_object" ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( Concatenation( "WARNING: Found more than the expected number of occurrences of `CreateCapCategoryObjectWithAttributes` while precompiling ", function_name, "." ) );
                
            fi;
            
        fi;
        
        if current_rec.return_type = "object" and ValueOption( "number_of_objectified_morphisms_in_data_structure_of_object" ) <> fail then
            
            if number_of_occurrences_in_string( function_string, "CreateCapCategoryMorphismWithAttributes" ) > ValueOption( "number_of_objectified_morphisms_in_data_structure_of_object" ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( Concatenation( "WARNING: Found more than the expected number of occurrences of `CreateCapCategoryMorphismWithAttributes` while precompiling ", function_name, "." ) );
                
            fi;
            
        fi;
        
        if current_rec.return_type = "morphism" and ValueOption( "number_of_objectified_objects_in_data_structure_of_morphism" ) <> fail then
            
            if number_of_occurrences_in_string( function_string, "CreateCapCategoryObjectWithAttributes" ) > ValueOption( "number_of_objectified_objects_in_data_structure_of_morphism" ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( Concatenation( "WARNING: Found more than the expected number of occurrences of `CreateCapCategoryObjectWithAttributes` while precompiling ", function_name, "." ) );
                
            fi;
            
        fi;
        
        if current_rec.return_type = "morphism" and ValueOption( "number_of_objectified_morphisms_in_data_structure_of_morphism" ) <> fail then
            
            if number_of_occurrences_in_string( function_string, "CreateCapCategoryMorphismWithAttributes" ) > ValueOption( "number_of_objectified_morphisms_in_data_structure_of_morphism" ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( Concatenation( "WARNING: Found more than the expected number of occurrences of `CreateCapCategoryMorphismWithAttributes` while precompiling ", function_name, "." ) );
                
            fi;
            
        fi;
        
        # Taking the original weight is not optimal because the compilation might have simplified things drastically.
        # However, this is still better than just setting everything to the default weight.
        weight := CurrentOperationWeight( cat!.derivations_weight_list, function_name );
        
        Assert( 0, weight < infinity );
        
        if IsBound( cat!.primitive_operations.(function_name) ) and cat!.primitive_operations.(function_name) = true then
            
            IsPrecompiledDerivation_string := "";
            
        else
            
            IsPrecompiledDerivation_string := " : IsPrecompiledDerivation := true";
            
        fi;
        
        current_string := Concatenation(
            "    \n",
            "    ##\n",
            "    Add", function_name, "( cat,\n",
            "        \n",
            "########\n",
            function_string, "\n",
            "########\n",
            "        \n",
            "    , ", String( weight ), IsPrecompiledDerivation_string, " );\n"
        );
        output_string := Concatenation( output_string, current_string );
        
    od;
    
    parameters := NamesLocalVariablesFunction( category_constructor ){[ 1 .. NumberArgumentsFunction( category_constructor ) ]};
    
    current_string := Concatenation( "    ", ReplacedStringViaRecord( """
    if IsBound( cat!.precompiled_functions_added ) then
        
        # coverage_ignore_next_line
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "compiled_category_name", function ( parameters... )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        implementation;
        
        
    
    cat := category_constructor( parameters... : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_compiled_category_name( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
""",
    rec(
        compiled_category_name := compiled_category_name,
        parameters := parameters,
        implementation := CapJitPrettyPrintFunction( category_constructor ),
        coverage_ignore_next_line := "COVERAGE_IGNORE_NEXT_LINE", # handled here to make COVERAGE_IGNORE_NEXT_LINE not trigger in the above string
    ) ) );
    output_string := Concatenation( output_string, current_string );
    
    WriteFileInPackageForHomalg( package_name, Concatenation( "precompiled_categories/", compiled_category_name, ".gi" ), output_string );
    
end );

InstallGlobalFunction( "CapJitPrecompileCategoryAndCompareResult", function ( category_constructor, given_arguments, package_name, compiled_category_name )
  local filepath, old_file_content, new_file_content;
    
    filepath := Concatenation( "precompiled_categories/", compiled_category_name, ".gi" );
    
    if IsExistingFileInPackageForHomalg( package_name, filepath ) then
        
        old_file_content := ReadFileFromPackageForHomalg( package_name, filepath );
        
    else
        
        # this should never happen in tests
        # COVERAGE_IGNORE_NEXT_LINE
        old_file_content := "";
        
    fi;
    
    CapJitPrecompileCategory(
        category_constructor,
        given_arguments,
        package_name,
        compiled_category_name
    );
    
    new_file_content := ReadFileFromPackageForHomalg( package_name, filepath );
    
    if old_file_content <> new_file_content then
        
        # this should never happen in tests
        # COVERAGE_IGNORE_NEXT_LINE
        Display( "WARNING: old and new file contents differ" );
        
    fi;
    
end );
