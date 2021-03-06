# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

InstallGlobalFunction( "CAP_INTERNAL_GENERATE_CONVENIENCE_METHODS_FOR_LIMITS",
  function ( package_name, method_name_record, limits )
    local output_string, generate_universal_morphism_convenience, generate_functorial_convenience_method, number_of_diagram_arguments, functorial_record, filter_list, input_type, replaced_filter_list, replaced_filter_list_string, arguments_string, source_diagram_arguments_string, range_diagram_arguments_string, source_diagram_input_type, range_diagram_input_type, call_arguments_string, limit, existing_string, output_path;
    
    output_string :=
"""# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE LimitConvenience.gi""";
    
    #### helper functions
    generate_universal_morphism_convenience := function( limit, universal_morphism_name, object_name, diagram_position )
      local current_string, test_object_position, diagram_filter_list_string, tau_filter, list_selector;
        
        if not diagram_position in [ "Source", "Range" ] then
            
            Error( "diagram_position must be \"Source\" or \"Range\"" );
            
        fi;
        
        if limit.number_of_unbound_morphisms = 0 then
            
            # diagram can be derived from morphism(s) via diagram_position
            
            if limit.number_of_targets = 1 then
                
                Error( "this case is currently not supported" );
                
            elif limit.number_of_targets > 1 then
                
                # derive diagram from morphisms via diagram_position
                current_string := Concatenation(
                    "\n",
                    "##\n",
                    "InstallMethod( ", universal_morphism_name, ",\n",
                    "               [ IsList ],\n",
                    "               \n",
                    "  function( list )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( CapCategory( list[1] ), list );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategory, IsList ],\n",
                    "               \n",
                    "  function( cat, list )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( cat, List( list, ", diagram_position, " ), list );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategoryObject, IsList ],\n",
                    "               \n",
                    "  function( test_object, list )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( CapCategory( test_object ), test_object, list );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategory, IsCapCategoryObject, IsList ],\n",
                    "               \n",
                    "  function( cat, test_object, list )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( cat, List( list, ", diagram_position, " ), test_object, list );\n",
                    "    \n",
                    "end );\n"
                );
                
                output_string := Concatenation( output_string, current_string );
                
                # redirect UniversalMorphism( mor1, mor2, ... ) to UniversalMorphism( [ mor1, mor2, ... ] )
                current_string := Concatenation(
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategoryMorphism ],\n",
                    "               \n",
                    "  function( mor1 )\n",
                    "    \n",
                    "    Print(\n",
                    "      Concatenation(\n",
                    "      \"WARNING: ", universal_morphism_name, "( IsCapCategoryMorphism, ... ) is deprecated and will not be supported after 2022.04.15. \",\n",
                    "      \"Please use ", universal_morphism_name, "( [ IsCapCategoryMorphism, ... ] ) instead.\\n\"\n",
                    "      )\n",
                    "    );\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( [ mor1 ] );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],\n",
                    "               \n",
                    "  function( mor1, mor2 )\n",
                    "    \n",
                    "    Print(\n",
                    "      Concatenation(\n",
                    "      \"WARNING: ", universal_morphism_name, "( IsCapCategoryMorphism, ... ) is deprecated and will not be supported after 2022.04.15. \",\n",
                    "      \"Please use ", universal_morphism_name, "( [ IsCapCategoryMorphism, ... ] ) instead.\\n\"\n",
                    "      )\n",
                    "    );\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( [ mor1, mor2 ] );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],\n",
                    "               \n",
                    "  function( mor1, mor2, mor3 )\n",
                    "    \n",
                    "    Print(\n",
                    "      Concatenation(\n",
                    "      \"WARNING: ", universal_morphism_name, "( IsCapCategoryMorphism, ... ) is deprecated and will not be supported after 2022.04.15. \",\n",
                    "      \"Please use ", universal_morphism_name, "( [ IsCapCategoryMorphism, ... ] ) instead.\\n\"\n",
                    "      )\n",
                    "    );\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( [ mor1, mor2, mor3 ] );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],\n",
                    "               \n",
                    "  function( mor1, mor2, mor3, mor4 )\n",
                    "    \n",
                    "    Print(\n",
                    "      Concatenation(\n",
                    "      \"WARNING: ", universal_morphism_name, "( IsCapCategoryMorphism, ... ) is deprecated and will not be supported after 2022.04.15. \",\n",
                    "      \"Please use ", universal_morphism_name, "( [ IsCapCategoryMorphism, ... ] ) instead.\\n\"\n",
                    "      )\n",
                    "    );\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( [ mor1, mor2, mor3, mor4 ] );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],\n",
                    "               \n",
                    "  function( mor1, mor2, mor3, mor4, mor5 )\n",
                    "    \n",
                    "    Print(\n",
                    "      Concatenation(\n",
                    "      \"WARNING: ", universal_morphism_name, "( IsCapCategoryMorphism, ... ) is deprecated and will not be supported after 2022.04.15. \",\n",
                    "      \"Please use ", universal_morphism_name, "( [ IsCapCategoryMorphism, ... ] ) instead.\\n\"\n",
                    "      )\n",
                    "    );\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( [ mor1, mor2, mor3, mor4, mor5 ] );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],\n",
                    "               \n",
                    "  function( mor1, mor2, mor3, mor4, mor5, mor6 )\n",
                    "    \n",
                    "    Print(\n",
                    "      Concatenation(\n",
                    "      \"WARNING: ", universal_morphism_name, "( IsCapCategoryMorphism, ... ) is deprecated and will not be supported after 2022.04.15. \",\n",
                    "      \"Please use ", universal_morphism_name, "( [ IsCapCategoryMorphism, ... ] ) instead.\\n\"\n",
                    "      )\n",
                    "    );\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( [ mor1, mor2, mor3, mor4, mor5, mor6 ] );\n",
                    "    \n",
                    "end );\n"
                );
                
                output_string := Concatenation( output_string, current_string );
                
            fi;
            
        fi;
        
        # derive test object
        if IsOperation( ValueGlobal( universal_morphism_name ) ) then
            
            if Length( limit.diagram_filter_list ) <> 1 then
                
                Error( "this case is not implemented" );
                
            fi;
            
            if diagram_position = "Source" then
                
                test_object_position := "Range";
                
            elif diagram_position = "Range" then
                
                test_object_position := "Source";
                
            else
                
                Error( "this should never happen" );
                
            fi;
            
            diagram_filter_list_string := NameFunction( CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( limit.diagram_filter_list )[1] );
            
            if limit.number_of_targets = 1 then
                
                tau_filter := "IsCapCategoryMorphism";
                list_selector := "";
                
            else
                
                tau_filter := "IsList";
                list_selector := "[1]";
                
            fi;
            
            current_string := Concatenation(
                "\n",
                "InstallOtherMethod( ", universal_morphism_name, ",\n",
                "                    [ ", diagram_filter_list_string, ", ", tau_filter, " ],\n",
                "                    \n",
                "    function( diagram, tau )\n",
                "        #% CAP_JIT_RESOLVE_FUNCTION\n",
                "        \n",
                "        return ", universal_morphism_name, "( diagram, ", test_object_position, "( tau", list_selector, " ), tau );\n",
                "        \n",
                "end );\n",
                "\n",
                "InstallOtherMethod( ", universal_morphism_name, ",\n",
                "                    [ IsCapCategory, ", diagram_filter_list_string, ", ", tau_filter, " ],\n",
                "                    \n",
                "    function( cat, diagram, tau )\n",
                "        #% CAP_JIT_RESOLVE_FUNCTION\n",
                "        \n",
                "        return ", universal_morphism_name, "( cat, diagram, ", test_object_position, "( tau", list_selector, " ), tau );\n",
                "        \n",
                "end );\n",
                "\n",
                "InstallOtherMethod( ", universal_morphism_name, "WithGiven", object_name, ",\n",
                "                    [ ", diagram_filter_list_string, ", ", tau_filter, ", IsCapCategoryObject ],\n",
                "                    \n",
                "    function( diagram, tau, P )\n",
                "        #% CAP_JIT_RESOLVE_FUNCTION\n",
                "        \n",
                "        return ", universal_morphism_name, "WithGiven", object_name, "( diagram, ", test_object_position, "( tau", list_selector, " ), tau, P );\n",
                "        \n",
                "end );\n",
                "\n",
                "InstallOtherMethod( ", universal_morphism_name, "WithGiven", object_name, ",\n",
                "                    [ IsCapCategory, ", diagram_filter_list_string, ", ", tau_filter, ", IsCapCategoryObject ],\n",
                "                    \n",
                "    function( cat, diagram, tau, P )\n",
                "        #% CAP_JIT_RESOLVE_FUNCTION\n",
                "        \n",
                "        return ", universal_morphism_name, "WithGiven", object_name, "( cat, diagram, ", test_object_position, "( tau", list_selector, " ), tau, P );\n",
                "        \n",
                "end );\n"
            );
            
            output_string := Concatenation( output_string, current_string );

        fi;
        
        # deprecated Adds without test object
        current_string := Concatenation(
            "\n",
            "##\n",
            "InstallMethod( Add", universal_morphism_name, ",\n",
            "               [ IsCapCategory, IsFunction ],\n",
            "               \n",
            "  function( category, func )\n",
            "    local nr_arguments, wrapper;\n",
            "    \n",
            "    nr_arguments := NumberArgumentsFunction( func );\n",
            "    \n",
            "    wrapper := fail;\n",
            "    \n",
            "    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then\n",
            "        \n",
            "        if nr_arguments = 3 then\n",
            "        \n",
            "            Print(\n",
            "              Concatenation(\n",
            "              \"WARNING: Add", universal_morphism_name, " with a function with 3 arguments is deprecated and will not be supported after 2022.04.18. \",\n",
            "              \"Please give a function with 4 arguments instead.\\n\"\n",
            "              )\n",
            "            );\n",
            "                \n",
            "            wrapper := { cat, diagram, T, tau } -> func( cat, diagram, tau );\n",
            "            \n",
            "        fi;\n",
            "        \n",
            "    else\n",
            "        \n",
            "        if nr_arguments = 2 then\n",
            "        \n",
            "            Print(\n",
            "              Concatenation(\n",
            "              \"WARNING: Add", universal_morphism_name, " with a function with 2 arguments is deprecated and will not be supported after 2022.04.18. \",\n",
            "              \"Please give a function with 3 arguments instead.\\n\"\n",
            "              )\n",
            "            );\n",
            "                \n",
            "            wrapper := { diagram, T, tau } -> func( diagram, tau );\n",
            "            \n",
            "        fi;\n",
            "        \n",
            "    fi;\n",
            "    \n",
            "    if wrapper = fail then\n",
            "        \n",
            "        TryNextMethod( );\n",
            "        \n",
            "    fi;\n",
            "    \n",
            "    Add", universal_morphism_name, "( category, wrapper );\n",
            "    \n",
            "end );\n",
            "\n",
            "##\n",
            "InstallMethod( Add", universal_morphism_name, "WithGiven", object_name, ",\n",
            "               [ IsCapCategory, IsFunction ],\n",
            "               \n",
            "  function( category, func )\n",
            "    local nr_arguments, wrapper;\n",
            "    \n",
            "    nr_arguments := NumberArgumentsFunction( func );\n",
            "    \n",
            "    wrapper := fail;\n",
            "    \n",
            "    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then\n",
            "        \n",
            "        if nr_arguments = 4 then\n",
            "        \n",
            "            Print(\n",
            "              Concatenation(\n",
            "              \"WARNING: Add", universal_morphism_name, "WithGiven", object_name, " with a function with 4 arguments is deprecated and will not be supported after 2022.04.18. \",\n",
            "              \"Please give a function with 5 arguments instead.\\n\"\n",
            "              )\n",
            "            );\n",
            "                \n",
            "            wrapper := { cat, diagram, T, tau, P } -> func( cat, diagram, tau, P );\n",
            "            \n",
            "        fi;\n",
            "        \n",
            "    else\n",
            "        \n",
            "        if nr_arguments = 3 then\n",
            "        \n",
            "            Print(\n",
            "              Concatenation(\n",
            "              \"WARNING: Add", universal_morphism_name, "WithGiven", object_name, " with a function with 3 arguments is deprecated and will not be supported after 2022.04.18. \",\n",
            "              \"Please give a function with 4 arguments instead.\\n\"\n",
            "              )\n",
            "            );\n",
            "                \n",
            "            wrapper := { diagram, T, tau, P } -> func( diagram, tau, P );\n",
            "            \n",
            "        fi;\n",
            "        \n",
            "    fi;\n",
            "    \n",
            "    if wrapper = fail then\n",
            "        \n",
            "        TryNextMethod( );\n",
            "        \n",
            "    fi;\n",
            "    \n",
            "    Add", universal_morphism_name, "WithGiven", object_name, "( category, wrapper );\n",
            "    \n",
            "end );\n"
        );
        
        output_string := Concatenation( output_string, current_string );
        
    end;
    
    generate_functorial_convenience_method := function( object_name, functorial_name, functorial_with_given_name, filter_list_string, arguments_string, source_diagram_arguments_string, range_diagram_arguments_string, call_arguments_string )
      local current_string;
        
        current_string := Concatenation(
            "\n",
            "##\n",
            "InstallMethod( ", functorial_name, ",\n",
            "               [ ", filter_list_string, " ],\n",
            "               \n",
            "  function( ", arguments_string, " )\n",
            "    \n",
            "    return ", functorial_with_given_name, "(\n",
            "        ", object_name, "( ", source_diagram_arguments_string, " ),\n",
            "        ", call_arguments_string, ",\n",
            "        ", object_name, "( ", range_diagram_arguments_string, " )\n",
            "    );\n",
            "    \n",
            "end );\n"
        );
        
        output_string := Concatenation( output_string, current_string );
        
        current_string := Concatenation(
            "\n",
            "##\n",
            "InstallOtherMethod( ", functorial_name, ",\n",
            "               [ IsCapCategory, ", filter_list_string, " ],\n",
            "               \n",
            "  function( cat, ", arguments_string, " )\n",
            "    #% CAP_JIT_RESOLVE_FUNCTION\n",
            "    \n",
            "    return ", functorial_with_given_name, "(\n",
            "        cat,\n",
            "        ", object_name, "( cat, ", source_diagram_arguments_string, " ),\n",
            "        ", call_arguments_string, ",\n",
            "        ", object_name, "( cat, ", range_diagram_arguments_string, " )\n",
            "    );\n",
            "    \n",
            "end );\n"
        );
        
        output_string := Concatenation( output_string, current_string );
        
        if limit.number_of_unbound_morphisms = 0 then
            
            if limit.number_of_targets = 1 then
                
                Error( "this case is currently not supported" );
                
            elif limit.number_of_targets > 1 then
                
                # diagram can be derived from morphisms
                
                current_string := Concatenation(
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", functorial_name, "WithGiven", object_name, "s,\n",
                    "               [ IsCapCategoryObject, ", filter_list_string, ", IsCapCategoryObject ],\n",
                    "               \n",
                    "  function( source, ", arguments_string, ", range )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", functorial_with_given_name, "(\n",
                    "        source,\n",
                    "        ", call_arguments_string, ",\n",
                    "        range\n",
                    "    );\n",
                    "    \n",
                    "end );\n"
                );
                
                output_string := Concatenation( output_string, current_string );
                
                current_string := Concatenation(
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", functorial_name, "WithGiven", object_name, "s,\n",
                    "               [ IsCapCategory, IsCapCategoryObject, ", filter_list_string, ", IsCapCategoryObject ],\n",
                    "               \n",
                    "  function( cat, source, ", arguments_string, ", range )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", functorial_with_given_name, "(\n",
                    "        cat,\n",
                    "        source,\n",
                    "        ", call_arguments_string, ",\n",
                    "        range\n",
                    "    );\n",
                    "    \n",
                    "end );\n"
                );
                
                output_string := Concatenation( output_string, current_string );
                
            fi;
            
        fi;
        
    end;
    
    for limit in limits do
        
        number_of_diagram_arguments := Length( limit.diagram_filter_list );
        
        if number_of_diagram_arguments > 0 then
            
            #### universal morphism convenience
            generate_universal_morphism_convenience( limit, limit.limit_universal_morphism_name, limit.limit_object_name, "Range" );
            generate_universal_morphism_convenience( limit, limit.colimit_universal_morphism_name, limit.colimit_object_name, "Source" );
            
            #### functorial convenience method
            functorial_record := method_name_record.( limit.limit_functorial_with_given_name );
            
            if limit.number_of_unbound_morphisms = 0 then
                # derive diagrams from arguments
                filter_list := limit.diagram_morphism_filter_list;
                input_type := limit.diagram_morphism_input_type;

                Assert( 0, Length( filter_list ) = 1 );
                Assert( 0, Length( input_type ) = 1 );

                arguments_string := JoinStringsWithSeparator( input_type, ", " );

                if limit.number_of_targets = 1 then
                    source_diagram_arguments_string := Concatenation( "Source( ", arguments_string, " )" );
                    range_diagram_arguments_string := Concatenation( "Range( ", arguments_string, " )" );
                else
                    source_diagram_arguments_string := Concatenation( "List( ", arguments_string, ", Source )" );
                    range_diagram_arguments_string := Concatenation( "List( ", arguments_string, ", Range )" );
                fi;
                
                call_arguments_string := JoinStringsWithSeparator( [ source_diagram_arguments_string, arguments_string, range_diagram_arguments_string ], ", " );
            else
                filter_list := functorial_record.filter_list;
                input_type := functorial_record.io_type[1];
                # the first entry is the category, the second and the last entries are the WithGiven-objects
                filter_list := filter_list{ [ 3 .. Length( filter_list ) - 1 ] };
                input_type := input_type{ [ 2 .. Length( input_type ) - 1 ] };
                
                arguments_string := JoinStringsWithSeparator( input_type, ", " );

                # diagrams are passed as first and last argument(s)
                source_diagram_input_type := input_type{ [ 1 .. number_of_diagram_arguments ] };
                range_diagram_input_type := input_type{ [ (Length( input_type ) - number_of_diagram_arguments + 1) .. Length( input_type ) ] };

                source_diagram_arguments_string := JoinStringsWithSeparator( source_diagram_input_type, ", " );
                range_diagram_arguments_string := JoinStringsWithSeparator( range_diagram_input_type, ", " );

                call_arguments_string := arguments_string;
            fi;
            
            replaced_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( filter_list );
            replaced_filter_list_string := JoinStringsWithSeparator( List( replaced_filter_list, NameFunction ), ", " );
            
            # limit
            generate_functorial_convenience_method( limit.limit_object_name, limit.limit_functorial_name, limit.limit_functorial_with_given_name, replaced_filter_list_string, arguments_string, source_diagram_arguments_string, range_diagram_arguments_string, call_arguments_string );
            
            # colimit
            if limit.limit_object_name <> limit.colimit_object_name then
                generate_functorial_convenience_method( limit.colimit_object_name, limit.colimit_functorial_name, limit.colimit_functorial_with_given_name, replaced_filter_list_string, arguments_string, source_diagram_arguments_string, range_diagram_arguments_string, call_arguments_string );
            fi;
            
        fi;
        
    od;
    
    existing_string := ReadFileFromPackageForHomalg( package_name, "LimitConvenienceOutput.gi" );
    
    if output_string <> existing_string then
        
        output_path := Filename( DirectoryTemporary( ), "LimitConvenienceOutput.gi" );
        
        WriteFileForHomalg( output_path, output_string );
        
        Display( Concatenation(
            "WARNING: The file LimitConvenienceOutput.gi differs from the automatically generated one. ",
            "You can view the automatically generated file at the following path: ",
            output_path
        ) );
        
    fi;
    
end );

CAP_INTERNAL_GENERATE_CONVENIENCE_METHODS_FOR_LIMITS( "CAP", CAP_INTERNAL_METHOD_NAME_RECORD, CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS );
