# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( "CapJitPrecompileCategory", function ( category_constructor, given_arguments, package_name, compiled_category_name )
  local cat1, cat2, cat, operations, diff, output_string, package_info, parameters_string, current_string, compiled_tree, compiled_func, function_string, weight, IsPrecompiledDerivation_string, function_name, current_rec;
    
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
        
        operations := ListInstalledOperationsOfCategory( cat );
        
    elif ValueOption( "operations" ) = "primitive" then
        
        operations := ListPrimitivelyInstalledOperationsOfCategory( cat );
        
    elif IsString( ValueOption( "operations" ) ) then
        
        operations := [ ValueOption( "operations" ) ];
        
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
    
    output_string := "";
    
    package_info := First( PackageInfo( package_name ) );
    
    if package_info = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "could not find package info" );
        
    fi;
    
    parameters_string := JoinStringsWithSeparator( NamesLocalVariablesFunction( category_constructor ){[ 1 .. NumberArgumentsFunction( category_constructor ) ]}, ", " );
    
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
        
        current_rec := CAP_INTERNAL_METHOD_NAME_RECORD.(function_name);
        
        # operations/derivations returning fail usually do not fulfill the requirements that all branches of an if statement can be executed
        # even if the corresponding condition does not hold
        if IsString( current_rec.return_type ) and EndsWith( current_rec.return_type, "fail" ) then
            
            continue;
            
        fi;
        
        compiled_tree := CapJitCompiledCAPOperationAsEnhancedSyntaxTree( cat, function_name );
        
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
        
        if not IsEmpty(
                CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION(
                    compiled_func,
                    RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ),
                    2,
                    CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS
                )
            ) then
            
            Display( Concatenation( "WARNING: Could not resolve all CAP operations while precompiling ", function_name, "." ) );
            
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
    
    current_string := Concatenation(
        "    \n",
        "end );\n",
        "\n",
        "BindGlobal( \"", compiled_category_name, "\", function ( ", parameters_string, " )\n",
        "  local category_constructor, cat;\n",
        "    \n",
        "    category_constructor :=\n",
        "        \n",
        "        \n",
        "        ", CapJitPrettyPrintFunction( category_constructor ), ";\n",
        "        \n",
        "        \n",
        "    \n",
        "    cat := category_constructor( ", parameters_string, " : FinalizeCategory := false, no_precompiled_code := true );\n",
        "    \n",
        "    ADD_FUNCTIONS_FOR_", compiled_category_name, "( cat );\n",
        "    \n",
        "    Finalize( cat );\n",
        "    \n",
        "    return cat;\n",
        "    \n",
        "end );\n"
    );
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
