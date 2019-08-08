InstallGlobalFunction( "CAP_INTERNAL_INSTALL_CONVENIENCE_METHODS_FOR_LIMITS",
  function ( method_name_record, limits )
    local install_functorial_convenience_method, number_of_diagram_arguments, functorial_record, filter_list, input_type, replaced_filter_list, arguments_string, source_diagram_arguments_string, range_diagram_arguments_string, source_diagram_input_type, range_diagram_input_type, limit;

    #### helper functions
    install_functorial_convenience_method := function( object_name, functorial_name, functorial_with_given_name, filter_list, arguments_string, source_diagram_arguments_string, range_diagram_arguments_string )
      local method;
        method := EvalString( Concatenation(
            "function( ", arguments_string, " ) \
                   \
                  return ", functorial_with_given_name, "( \
                           ", object_name, "( ", source_diagram_arguments_string, " ), \
                           ", arguments_string, ", \
                           ", object_name, "( ", range_diagram_arguments_string, " ) \
                         ); \
                   \
            end"
        ) );

        InstallMethod( ValueGlobal( functorial_name ), filter_list, method );
    end;

    for limit in limits do
        number_of_diagram_arguments := Length( limit.diagram_filter_list );

        if number_of_diagram_arguments > 0 then
            functorial_record := method_name_record!.( limit.limit_functorial_with_given_name );

            #### functorial convenience method
            filter_list := functorial_record.filter_list;
            input_type := functorial_record.io_type[1];
            # first and last entries are the WithGiven-objects
            filter_list := filter_list{ [ 2 .. Length( filter_list ) - 1 ] };
            input_type := input_type{ [ 2 .. Length( input_type ) - 1 ] };

            replaced_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( filter_list );
            arguments_string := JoinStringsWithSeparator( input_type, "," );

            if limit.number_of_unbound_morphisms = 0 then
                # derive diagrams from arguments
                if limit.number_of_targets = 1 then
                    source_diagram_arguments_string := Concatenation( "Source( ", arguments_string, " )" );
                    range_diagram_arguments_string := Concatenation( "Range( ", arguments_string, " )" );
                else
                    source_diagram_arguments_string := Concatenation( "List( ", arguments_string, ", Source )" );
                    range_diagram_arguments_string := Concatenation( "List( ", arguments_string, ", Range )" );
                fi;
            else
                # diagrams are passed as first and last argument(s)
                source_diagram_input_type := input_type{ [ 1 .. number_of_diagram_arguments ] };
                range_diagram_input_type := input_type{ [ (Length( input_type ) - number_of_diagram_arguments + 1) .. Length( input_type ) ] };

                source_diagram_arguments_string := JoinStringsWithSeparator( source_diagram_input_type, "," );
                range_diagram_arguments_string := JoinStringsWithSeparator( range_diagram_input_type, "," );
            fi;

            # limit
            install_functorial_convenience_method( limit.limit_object_name, limit.limit_functorial_name, limit.limit_functorial_with_given_name, replaced_filter_list, arguments_string, source_diagram_arguments_string, range_diagram_arguments_string );

            # colimit
            if limit.limit_object_name <> limit.colimit_object_name then
                install_functorial_convenience_method( limit.colimit_object_name, limit.colimit_functorial_name, limit.colimit_functorial_with_given_name, replaced_filter_list, arguments_string, source_diagram_arguments_string, range_diagram_arguments_string );
            fi;
        fi;
    od;
end );

CAP_INTERNAL_INSTALL_CONVENIENCE_METHODS_FOR_LIMITS( CAP_INTERNAL_METHOD_NAME_RECORD, CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS );
