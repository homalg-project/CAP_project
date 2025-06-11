# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
BindGlobal( "CAP_INTERNAL_VALID_RETURN_TYPES",
#! @BeginCode CAP_INTERNAL_VALID_RETURN_TYPES
    [
        "object",
        "morphism",
        "twocell",
        "object_in_range_category_of_homomorphism_structure",
        "morphism_in_range_category_of_homomorphism_structure",
        "bool",
        "list_of_objects",
        "list_of_morphisms",
        "list_of_lists_of_morphisms",
        "object_datum",
        "morphism_datum",
        "nonneg_integer_or_infinity",
        "list_of_elements_of_commutative_ring_of_linear_structure",
    ]
#! @EndCode
);

BindGlobal( "CAP_INTERNAL_VALID_METHOD_NAME_RECORD_COMPONENTS",
#! @BeginCode CAP_INTERNAL_VALID_METHOD_NAME_RECORD_COMPONENTS
    [
        "filter_list",
        "input_arguments_names",
        "return_type",
        "output_source_getter_string",
        "output_source_getter_preconditions",
        "output_range_getter_string",
        "output_range_getter_preconditions",
        "with_given_object_position",
        "dual_operation",
        "dual_arguments_reversed",
        "dual_with_given_objects_reversed",
        "dual_preprocessor_func",
        "dual_preprocessor_func_string",
        "dual_postprocessor_func",
        "dual_postprocessor_func_string",
        "functorial",
        "compatible_with_congruence_of_morphisms",
        "redirect_function",
        "pre_function",
        "pre_function_full",
        "post_function",
    ]
#! @EndCode
);

# additional components which are deprecated or undocumented
BindGlobal( "CAP_INTERNAL_LEGACY_METHOD_NAME_RECORD_COMPONENTS",
    [
        "is_merely_set_theoretic",
        "is_reflected_by_faithful_functor",
    ]
);

BindGlobal( "CAP_INTERNAL_METHOD_NAME_RECORD", rec( ) );

InstallGlobalFunction( "CAP_INTERNAL_ENHANCE_NAME_RECORD_LIMITS",
  function ( limits )
    local object_specification, morphism_specification, source_position, type, range_position, unbound_morphism_positions, number_of_unbound_morphisms, unbound_objects, morphism, unbound_object_positions, number_of_unbound_objects, targets, target_positions, nontarget_positions, number_of_targets, number_of_nontargets, diagram_filter_list, diagram_arguments_names, limit, position;
    
    for limit in limits do
        object_specification := limit.object_specification;
        morphism_specification := limit.morphism_specification;
        
        #### check that given diagram is well-defined
        if not (IsDenseList( object_specification ) and IsDenseList( morphism_specification )) then
            Error( "the given diagram is not well-defined" );
        fi;

        if Length( object_specification ) = 0 and Length( morphism_specification ) > 0 then
            Error( "the given diagram is not well-defined" );
        fi;
        
        if not (ForAll( object_specification, object -> object in [ "fixedobject", "varobject" ] )) then
            Error( "the given diagram is not well-defined" );
        fi;

        for morphism in morphism_specification do
            if not (IsList( morphism ) and Length( morphism ) = 3) then
                Error( "the given diagram is not well-defined" );
            fi;
            source_position := morphism[1];
            type := morphism[2];
            range_position := morphism[3];

            if not (IsInt( source_position ) and source_position >= 1 and source_position <= Length( object_specification )) then
                Error( "the given diagram is not well-defined" );
            fi;

            if not (IsInt( range_position ) and range_position >= 1 and range_position <= Length( object_specification )) then
                Error( "the given diagram is not well-defined" );
            fi;

            if not type in [ "fixedmorphism", "varmorphism", "zeromorphism" ] then
                Error( "the given diagram is not well-defined" );
            fi;

            if type = "fixedmorphism" and (object_specification[source_position] = "varobject" or object_specification[range_position] = "varobject") then
                Error( "the given diagram is not well-defined" );
            fi;
        od;

        #### get number of variables
        # morphisms
        unbound_morphism_positions := PositionsProperty( morphism_specification, x -> x[2] = "varmorphism" or x[2] = "fixedmorphism" );
        if Length( unbound_morphism_positions ) = 0 then
            number_of_unbound_morphisms := 0;
        elif Length( unbound_morphism_positions ) = 1 and morphism_specification[unbound_morphism_positions[1]][2] = "fixedmorphism" then
            number_of_unbound_morphisms := 1;
        else
            number_of_unbound_morphisms := 2;
        fi;

        limit.unbound_morphism_positions := unbound_morphism_positions;
        limit.number_of_unbound_morphisms := number_of_unbound_morphisms;

        if not ForAll( unbound_morphism_positions, i -> morphism_specification[i][2] = "fixedmorphism" or i = Length( unbound_morphism_positions ) ) then
            Error( "diagrams of the given type are not supported" );
        fi;

        # objects
        unbound_objects := StructuralCopy( object_specification );
        for position in unbound_morphism_positions do
            morphism := morphism_specification[position];
            source_position := morphism[1];
            range_position := morphism[3];

            unbound_objects[source_position] := "";
            unbound_objects[range_position] := "";
        od;
        unbound_object_positions := PositionsProperty( unbound_objects, x -> x <> "" );
        if Length( unbound_object_positions ) = 0 then
            number_of_unbound_objects := 0;
        elif Length( unbound_object_positions ) = 1 and object_specification[unbound_object_positions[1]] = "fixedobject" then
            number_of_unbound_objects := 1;
        else
            number_of_unbound_objects := 2;
        fi;

        limit.unbound_object_positions := unbound_object_positions;
        limit.number_of_unbound_objects := number_of_unbound_objects;

        if not ForAll( unbound_object_positions, i -> object_specification[i] = "fixedobject" or i = Length( unbound_object_positions ) ) then
            Error( "diagrams of the given type are not supported" );
        fi;

        # (non-)targets
        targets := StructuralCopy( object_specification );
        for morphism in morphism_specification do
            range_position := morphism[3];
            
            targets[range_position] := "";
        od;
        target_positions := PositionsProperty( targets, x -> x <> "" );
        nontarget_positions := PositionsProperty( targets, x -> x = "" );
        if Length( target_positions ) = 0 then
            number_of_targets := 0;
        elif Length( target_positions ) = 1 and object_specification[target_positions[1]] = "fixedobject" then
            number_of_targets := 1;
        else
            number_of_targets := 2;
        fi;
        if Length( nontarget_positions ) = 0 then
            number_of_nontargets := 0;
        elif Length( nontarget_positions ) = 1 and object_specification[nontarget_positions[1]] = "fixedobject" then
            number_of_nontargets := 1;
        else
            number_of_nontargets := 2;
        fi;

        limit.target_positions := target_positions;
        limit.number_of_targets := number_of_targets;
        limit.nontarget_positions := nontarget_positions;
        limit.number_of_nontargets := number_of_nontargets;

        #### get filter list and names of input arguments of the diagram
        diagram_filter_list := [ ];
        diagram_arguments_names := [ ];
        if number_of_unbound_objects = 1 then
            Add( diagram_filter_list, "object" );
            Add( diagram_arguments_names, "X" );
        elif number_of_unbound_objects > 1 then
            Add( diagram_filter_list, "list_of_objects" );
            Add( diagram_arguments_names, "objects" );
        fi;
        if number_of_unbound_morphisms = 1 then
            Add( diagram_filter_list, "morphism" );
            Add( diagram_arguments_names, "alpha" );
        elif number_of_unbound_morphisms > 1 then
            if number_of_targets = 1 then
                Add( diagram_filter_list, "object" );
                Add( diagram_arguments_names, "Y" );
            fi;
            Add( diagram_filter_list, "list_of_morphisms" );
            Add( diagram_arguments_names, "morphisms" );
        fi;

        limit.diagram_filter_list := diagram_filter_list;
        limit.diagram_arguments_names := diagram_arguments_names;
        
        #### set default projection/injection/universal morphism names
        if number_of_targets > 0 and not IsBound( limit.limit_projection_name ) then
            limit.limit_projection_name := Concatenation( "ProjectionInFactorOf", limit.limit_object_name );
        fi;
        if not IsBound( limit.limit_universal_morphism_name ) then
            limit.limit_universal_morphism_name := Concatenation( "UniversalMorphismInto", limit.limit_object_name );
        fi;

        if number_of_targets > 0 and not IsBound( limit.colimit_injection_name ) then
            limit.colimit_injection_name := Concatenation( "InjectionOfCofactorOf", limit.colimit_object_name );
        fi;
        if not IsBound( limit.colimit_universal_morphism_name ) then
            limit.colimit_universal_morphism_name := Concatenation( "UniversalMorphismFrom", limit.colimit_object_name );
        fi;
        
        if number_of_targets > 0 then
            limit.limit_projection_with_given_name := Concatenation( limit.limit_projection_name, "WithGiven", limit.limit_object_name );
            limit.colimit_injection_with_given_name := Concatenation( limit.colimit_injection_name, "WithGiven", limit.colimit_object_name );
        fi;
        
        limit.limit_universal_morphism_with_given_name := Concatenation( limit.limit_universal_morphism_name, "WithGiven", limit.limit_object_name );
        limit.colimit_universal_morphism_with_given_name := Concatenation( limit.colimit_universal_morphism_name, "WithGiven", limit.colimit_object_name );
        
        limit.limit_functorial_name := Concatenation( limit.limit_object_name, "Functorial" );
        limit.colimit_functorial_name := Concatenation( limit.colimit_object_name, "Functorial" );

        limit.limit_functorial_with_given_name := Concatenation( limit.limit_functorial_name, "WithGiven", limit.limit_object_name, "s" );
        limit.colimit_functorial_with_given_name := Concatenation( limit.colimit_functorial_name, "WithGiven", limit.colimit_object_name, "s" );

        if limit.number_of_nontargets = 1 then
            limit.limit_morphism_to_sink_name := Concatenation( "MorphismFrom", limit.limit_object_name, "ToSink" );
            limit.colimit_morphism_from_source_name := Concatenation( "MorphismFromSourceTo", limit.colimit_object_name );
        fi;

        if Length( diagram_filter_list ) > 0 then
            if limit.number_of_targets = 1 then
                limit.diagram_morphism_filter_list := [ "morphism" ];
                limit.diagram_morphism_arguments_names := [ "mu" ];
            else
                limit.diagram_morphism_filter_list := [ "list_of_morphisms" ];
                limit.diagram_morphism_arguments_names := [ "L" ];
            fi;
        else
            limit.diagram_morphism_filter_list := [ ];
            limit.diagram_morphism_arguments_names := [ ];
        fi;
        
        limit.functorial_source_diagram_arguments_names := limit.diagram_arguments_names;
        limit.functorial_range_diagram_arguments_names := List( limit.diagram_arguments_names, x -> Concatenation( x, "p" ) );
        
    od;
end );

BindGlobal( "CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES", FunctionWithNamedArguments(
  [
    [ "subset_only", false ],
  ],
  function ( CAP_NAMED_ARGUMENTS, method_record, entry_name, generated_entry )
  local excluded_names, method_record_entry, name;
    
    excluded_names := [ "function_name", "pre_function", "pre_function_full", "post_function" ];
    
    if not IsBound( method_record.(entry_name) ) then
        Display( Concatenation( "WARNING: The method record is missing a component named \"", entry_name, "\" which is expected by the validator.\n" ) );
        return;
    fi;
    
    method_record_entry := method_record.(entry_name);
    
    for name in RecNames( method_record_entry ) do
        if name in excluded_names then
            continue;
        fi;
        if not IsBound( generated_entry.(name) ) then
            if CAP_NAMED_ARGUMENTS.subset_only then
                continue;
            else
                Display( Concatenation( "WARNING: The entry \"", entry_name, "\" in the method record has a component named \"", name, "\" which is not expected by the validator.\n" ) );
            fi;
        elif method_record_entry.(name) <> generated_entry.(name) then
            Display( Concatenation( "WARNING: The entry \"", entry_name, "\" in the method record has a component named \"", name, "\" with value \"", String( method_record_entry.(name) ), "\". The value expected by the validator is \"", String( generated_entry.(name) ), "\".\n" ) );
        fi;
    od;
    for name in RecNames( generated_entry ) do
        if name in excluded_names then
            continue;
        fi;
        if not IsBound( method_record_entry.(name) ) then
            Display( Concatenation( "WARNING: The entry \"", entry_name, "\" in the method record is missing a component named \"", name, "\" which is expected by the validator.\n" ) );
        fi;
    od;
end ) );

InstallGlobalFunction( CAP_INTERNAL_VALIDATE_LIMITS_IN_NAME_RECORD,
  function ( method_name_record, limits )
    local make_record_with_given, make_colimit, object_filter_list, object_input_arguments_names, projection_filter_list, projection_input_arguments_names, projection_range_getter_string, morphism_to_sink_filter_list, morphism_to_sink_input_arguments_names, morphism_to_sink_range_getter_string, universal_morphism_filter_list, universal_morphism_input_arguments_names, object_record, projection_record, morphism_to_sink_record, universal_morphism_record, functorial_record, functorial_with_given_record, limit;
    
    #### helper functions
    make_record_with_given := function ( record, object_name, coobject_name )
        record := StructuralCopy( record );
        
        record.function_name := Concatenation( record.function_name, "WithGiven", object_name );
        Add( record.filter_list, "object" );
        Add( record.input_arguments_names, "P" );
        if record.with_given_object_position = "Source" then
            record.output_source_getter_string := "P";
            record.output_source_getter_preconditions := [ ];
        else
            record.output_range_getter_string := "P";
            record.output_range_getter_preconditions := [ ];
        fi;
        record.dual_operation := Concatenation( record.dual_operation, "WithGiven", coobject_name );
        Unbind( record.with_given_object_position );

        return record;
    end;

    make_colimit := function ( limit, record )
      local orig_function_name, orig_output_source_getter_string, orig_output_source_getter_preconditions;
        
        record := StructuralCopy( record );
        
        orig_function_name := record.function_name;
        record.function_name := record.dual_operation;
        record.dual_operation := orig_function_name;
        
        if IsBound( record.functorial ) then
            
            Assert( 0, record.functorial = limit.limit_functorial_name );
            
            record.functorial := limit.colimit_functorial_name;
            
        fi;
        
        if IsBound( record.with_given_object_position ) then
            if record.with_given_object_position = "Source" then
                record.with_given_object_position := "Range";
            elif record.with_given_object_position = "Range" then
                record.with_given_object_position := "Source";
            fi;
        fi;
        
        # reverse output getters, except if the input is reversed
        if not (IsBound( record.dual_arguments_reversed ) and record.dual_arguments_reversed) then
            
            orig_output_source_getter_string := fail;
            
            if IsBound( record.output_source_getter_string ) then
                
                orig_output_source_getter_string := record.output_source_getter_string;
                orig_output_source_getter_preconditions := record.output_source_getter_preconditions;
                
            fi;
            
            if IsBound( record.output_range_getter_string ) then
                
                record.output_source_getter_string := record.output_range_getter_string;
                record.output_source_getter_preconditions := record.output_range_getter_preconditions;
                
            else
                
                Unbind( record.output_source_getter_string );
                Unbind( record.output_source_getter_preconditions );
                
            fi;
            
            if orig_output_source_getter_string <> fail then
                
                record.output_range_getter_string := orig_output_source_getter_string;
                record.output_range_getter_preconditions := orig_output_source_getter_preconditions;
                
            else
                
                Unbind( record.output_range_getter_string );
                Unbind( record.output_range_getter_preconditions );
                
            fi;
            
        fi;
        
        if IsBound( record.output_source_getter_string ) then
            
            record.output_source_getter_string := ReplacedString( record.output_source_getter_string, "Source", "tmp" );
            record.output_source_getter_string := ReplacedString( record.output_source_getter_string, "Range", "Source" );
            record.output_source_getter_string := ReplacedString( record.output_source_getter_string, "tmp", "Range" );
            
            if IsEmpty( record.output_source_getter_preconditions ) then
                # do nothing
            elif record.output_source_getter_preconditions = [ [ limit.limit_object_name, 1 ] ] then
                record.output_source_getter_string := ReplacedString( record.output_source_getter_string, limit.limit_object_name, limit.colimit_object_name );
                record.output_source_getter_preconditions := [ [ limit.colimit_object_name, 1 ] ];
            else
                Error( "this case is not supported yet" );
            fi;
            
        fi;
        
        if IsBound( record.output_range_getter_string ) then
            
            record.output_range_getter_string := ReplacedString( record.output_range_getter_string, "Source", "tmp" );
            record.output_range_getter_string := ReplacedString( record.output_range_getter_string, "Range", "Source" );
            record.output_range_getter_string := ReplacedString( record.output_range_getter_string, "tmp", "Range" );
            
            if IsEmpty( record.output_range_getter_preconditions ) then
                # do nothing
            elif record.output_range_getter_preconditions = [ [ limit.limit_object_name, 1 ] ] then
                record.output_range_getter_string := ReplacedString( record.output_range_getter_string, limit.limit_object_name, limit.colimit_object_name );
                record.output_range_getter_preconditions := [ [ limit.colimit_object_name, 1 ] ];
            else
                Error( "this case is not supported yet" );
            fi;
            
        fi;
        
        return record;
    end;

    for limit in limits do
        
        #### get filter lists and io types
        object_filter_list := Concatenation( [ "category" ], StructuralCopy( limit.diagram_filter_list ) );
        object_input_arguments_names := Concatenation( [ "cat" ], limit.diagram_arguments_names );
        
        # only used if limit.number_of_targets > 0
        projection_filter_list := Concatenation( [ "category" ], StructuralCopy( limit.diagram_filter_list ) );
        projection_input_arguments_names := Concatenation( [ "cat" ], limit.diagram_arguments_names );
        if limit.number_of_targets > 1 then
            Add( projection_filter_list, "integer" );
            Add( projection_input_arguments_names, "k" );
        fi;
        if limit.target_positions = limit.unbound_object_positions then
            # range can be derived from the objects
            if limit.number_of_targets = 1 then
                projection_range_getter_string := "X";
            else
                projection_range_getter_string := "objects[k]";
            fi;
        elif limit.target_positions = List( limit.unbound_morphism_positions, i -> limit.morphism_specification[i][1] ) then
            # range can be derived from the morphisms as sources
            if limit.number_of_unbound_morphisms = 1 then
                projection_range_getter_string := "Source( alpha )";
            elif limit.number_of_targets = 1 then
                projection_range_getter_string := "Y";
            else
                projection_range_getter_string := "Source( morphisms[k] )";
            fi;
        elif limit.target_positions = List( limit.unbound_morphism_positions, i -> limit.morphism_specification[i][3] ) then
            # range can be derived from the morphisms as ranges
            if limit.number_of_unbound_morphisms = 1 then
                projection_range_getter_string := "Range( alpha )";
            elif limit.number_of_targets = 1 then
                projection_range_getter_string := "Y";
            else
                projection_range_getter_string := "Range( morphisms[k] )";
            fi;
        else
            Error( "Warning: cannot express range getter" );
        fi;

        # only used if limit.number_of_nontargets = 1
        morphism_to_sink_filter_list := Concatenation( [ "category" ], StructuralCopy( limit.diagram_filter_list ) );
        morphism_to_sink_input_arguments_names := Concatenation( [ "cat" ], limit.diagram_arguments_names );
        morphism_to_sink_range_getter_string := [ StructuralCopy( limit.diagram_arguments_names ), [ ] ];
        if limit.number_of_unbound_morphisms = 1 then
            morphism_to_sink_range_getter_string := "Range( alpha )";
        elif limit.number_of_unbound_morphisms > 1 then
            morphism_to_sink_range_getter_string := "Range( morphisms[1] )";
        fi;

        universal_morphism_filter_list := Concatenation( [ "category" ], StructuralCopy( limit.diagram_filter_list ), [ "object" ] );
        universal_morphism_input_arguments_names := Concatenation( [ "cat" ], limit.diagram_arguments_names, [ "T" ] );
        if limit.number_of_targets = 1 then
            Add( universal_morphism_filter_list, "morphism" );
            Add( universal_morphism_input_arguments_names, "tau" );
        elif limit.number_of_targets > 1 then
            Add( universal_morphism_filter_list, "list_of_morphisms" );
            Add( universal_morphism_input_arguments_names, "tau" );
        fi;

        
        #### get base records
        object_record :=  rec(
            function_name := limit.limit_object_name,
            filter_list := object_filter_list,
            input_arguments_names := object_input_arguments_names,
            return_type := "object",
            dual_operation := limit.colimit_object_name,
            functorial := limit.limit_functorial_name,
        );

        if limit.number_of_targets > 0 then
            projection_record := rec(
                function_name := limit.limit_projection_name,
                filter_list := projection_filter_list,
                input_arguments_names := projection_input_arguments_names,
                return_type := "morphism",
                output_range_getter_string := projection_range_getter_string,
                output_range_getter_preconditions := [ ],
                with_given_object_position := "Source",
                dual_operation := limit.colimit_injection_name,
            );
        fi;

        if limit.number_of_nontargets = 1 then
            morphism_to_sink_record := rec(
                function_name := Concatenation( "MorphismFrom", limit.limit_object_name, "ToSink" ),
                filter_list := morphism_to_sink_filter_list,
                input_arguments_names := morphism_to_sink_input_arguments_names,
                return_type := "morphism",
                output_range_getter_string := morphism_to_sink_range_getter_string,
                output_range_getter_preconditions := [ ],
                with_given_object_position := "Source",
                dual_operation := limit.colimit_morphism_from_source_name,
            );
        fi;

        universal_morphism_record := rec(
            function_name := limit.limit_universal_morphism_name,
            filter_list := universal_morphism_filter_list,
            input_arguments_names := universal_morphism_input_arguments_names,
            return_type := "morphism",
            output_source_getter_string := "T",
            output_source_getter_preconditions := [ ],
            with_given_object_position := "Range",
            dual_operation := limit.colimit_universal_morphism_name,
        );
        
        functorial_record := rec(
            function_name := limit.limit_functorial_name,
            filter_list := Concatenation( [ "category" ], limit.diagram_filter_list, limit.diagram_morphism_filter_list, limit.diagram_filter_list ),
            input_arguments_names := Concatenation( [ "cat" ], limit.functorial_source_diagram_arguments_names, limit.diagram_morphism_arguments_names, limit.functorial_range_diagram_arguments_names ),
            return_type := "morphism",
            # object_name
            output_source_getter_string := ReplacedStringViaRecord(
                "object_name( arguments... )",
                rec( object_name := limit.limit_object_name, arguments := Concatenation( [ "cat" ], limit.functorial_source_diagram_arguments_names ) )
            ),
            output_source_getter_preconditions := [ [ limit.limit_object_name, 1 ] ],
            output_range_getter_string := ReplacedStringViaRecord(
                "object_name( arguments... )",
                rec( object_name := limit.limit_object_name, arguments := Concatenation( [ "cat" ], limit.functorial_range_diagram_arguments_names ) )
            ),
            output_range_getter_preconditions := [ [ limit.limit_object_name, 1 ] ],
            with_given_object_position := "both",
            dual_operation := limit.colimit_functorial_name,
            dual_arguments_reversed := true,
        );
        
        functorial_with_given_record := rec(
            function_name := limit.limit_functorial_with_given_name,
            filter_list := Concatenation( [ "category", "object" ], limit.diagram_filter_list, limit.diagram_morphism_filter_list, limit.diagram_filter_list, [ "object" ] ),
            input_arguments_names := Concatenation( [ "cat", "P" ], limit.functorial_source_diagram_arguments_names, limit.diagram_morphism_arguments_names, limit.functorial_range_diagram_arguments_names, [ "Pp" ] ),
            return_type := "morphism",
            output_source_getter_string := "P",
            output_source_getter_preconditions := [ ],
            output_range_getter_string := "Pp",
            output_range_getter_preconditions := [ ],
            dual_operation := limit.colimit_functorial_with_given_name,
            dual_arguments_reversed := true,
        );
        
        if limit.number_of_unbound_morphisms = 0 then
            
            # The diagram has only objects as input -> all operations are compatible with the congruence of morphisms:
            # For the universal morphisms and functorials, this follows from the universal property.
            # All other operations are automatically compatible because they do not have morphisms as input.
            
            # if limit.number_of_targets = 0, the universal morphism has no test morphism as input anyway
            if limit.number_of_targets > 0 then
                
                universal_morphism_record.compatible_with_congruence_of_morphisms := true;
                functorial_record.compatible_with_congruence_of_morphisms := true;
                functorial_with_given_record.compatible_with_congruence_of_morphisms := true;
                
            fi;
            
        else
            
            # The universal object might depend on the morphism datum.
            # Thus, the operations are in general not compatible with the congruence of morphisms.
            
            object_record.compatible_with_congruence_of_morphisms := false;
            projection_record.compatible_with_congruence_of_morphisms := false;
            morphism_to_sink_record.compatible_with_congruence_of_morphisms := false;
            universal_morphism_record.compatible_with_congruence_of_morphisms := false;
            functorial_record.compatible_with_congruence_of_morphisms := false;
            functorial_with_given_record.compatible_with_congruence_of_morphisms := false;
            
        fi;
        
        #### validate limit records
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_object_name, object_record );
        
        if limit.number_of_targets > 0 then
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_projection_name, projection_record );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_projection_with_given_name, make_record_with_given( projection_record, limit.limit_object_name, limit.colimit_object_name ) );
        fi;
        
        if limit.number_of_nontargets = 1 then
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_morphism_to_sink_name, morphism_to_sink_record );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, Concatenation( limit.limit_morphism_to_sink_name, "WithGiven", limit.limit_object_name ), make_record_with_given( morphism_to_sink_record, limit.limit_object_name, limit.colimit_object_name ) );
        fi;
        
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_universal_morphism_name, universal_morphism_record );
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_universal_morphism_with_given_name, make_record_with_given( universal_morphism_record, limit.limit_object_name, limit.colimit_object_name ) );
        
        # GAP has a limit of 6 arguments per operation -> operations which would have more than 6 arguments have to work around this
        if Length( functorial_with_given_record.filter_list ) <= 6 then
            
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, functorial_record.function_name, functorial_record );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, functorial_with_given_record.function_name, functorial_with_given_record );
            
        fi;
        
        #### validate colimit records
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_object_name, make_colimit( limit, object_record ) );
        
        if limit.number_of_targets > 0 then
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_injection_name, make_colimit( limit, projection_record ) );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_injection_with_given_name, make_record_with_given( make_colimit( limit, projection_record ), limit.colimit_object_name, limit.limit_object_name ) );
        fi;
        
        if limit.number_of_nontargets = 1 then
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_morphism_from_source_name, make_colimit( limit, morphism_to_sink_record ) );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, Concatenation( limit.colimit_morphism_from_source_name, "WithGiven", limit.colimit_object_name ), make_record_with_given( make_colimit( limit, morphism_to_sink_record ), limit.colimit_object_name, limit.limit_object_name ) );
        fi;
        
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_universal_morphism_name, make_colimit( limit, universal_morphism_record ) );
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_universal_morphism_with_given_name, make_record_with_given( make_colimit( limit, universal_morphism_record ), limit.colimit_object_name, limit.limit_object_name ) );
        
        # GAP has a limit of 6 arguments per operation -> operations which would have more than 6 arguments have to work around this
        if Length( functorial_with_given_record.filter_list ) <= 6 then
            
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, functorial_record.dual_operation, make_colimit( limit, functorial_record ) );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, functorial_with_given_record.dual_operation, make_colimit( limit, functorial_with_given_record ) );
            
        fi;
        
    od;
    
end );

BindGlobal( "CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS", rec( ) );

InstallGlobalFunction( CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD,
  function( replacement_data )
    local current_name;

    for current_name in RecNames( replacement_data ) do
        if IsBound( CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS.(current_name) ) then
            Error( Concatenation( current_name, " already has a replacement" ) );
        fi;
        CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS.(current_name) := replacement_data.(current_name);
    od;
    
end );

BindGlobal( "CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_OBJECTS", [ ] );

BindGlobal( "CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_MORPHISMS", [ ] );

InstallGlobalFunction( CAP_INTERNAL_FIND_OPPOSITE_PROPERTY_PAIRS_IN_METHOD_NAME_RECORD,
  function( method_name_record )
    local recnames, current_recname, current_entry, current_rec, category_property_list, elem;
    
    recnames := RecNames( method_name_record );
    
    for current_recname in recnames do
        
        current_rec := method_name_record.( current_recname );
        
        if not (current_rec.return_type = "bool" and Length( current_rec.filter_list ) = 2) then
            continue;
        fi;
        
        if current_recname in [ "IsWellDefinedForObjects", "IsWellDefinedForMorphisms", "IsWellDefinedForTwoCells" ] then
            continue;
        fi;
        
        if not IsBound( current_rec.dual_operation ) or current_rec.dual_operation = current_recname then
            
            current_entry := NameFunction( current_rec.operation );
            
        else
            
            current_entry := [ NameFunction( current_rec.operation ), NameFunction( method_name_record.( current_rec.dual_operation ).operation ) ];
            current_entry := [ Concatenation( current_entry[ 1 ], " vs ", current_entry[ 2 ] ), current_entry ];
            
        fi;
        
        if current_rec.filter_list[2] = "object" then
            
            if not current_entry in CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_OBJECTS then
                
                Add( CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_OBJECTS, current_entry );
                
            fi;
            
        elif current_rec.filter_list[2] = "morphism" then
            
            if not current_entry in CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_MORPHISMS then
                
                Add( CAP_INTERNAL_OPPOSITE_PROPERTY_PAIRS_FOR_MORPHISMS, current_entry );
                
            fi;
            
        fi;
        
    od;
    
end );

BindGlobal( "CAP_INTERNAL_PREPARE_INHERITED_PRE_FUNCTION",
  function( func, drop_both )
    
    if drop_both then
        
        return function( arg_list... )
            # drop second and last argument
            return CallFuncList( func, arg_list{Concatenation( [ 1 ], [ 3 .. Length( arg_list ) - 1 ] )} );
        end;
        
    else
        
        return function( arg_list... )
            # drop last argument
            return CallFuncList( func, arg_list{[ 1 .. Length( arg_list ) - 1 ]} );
        end;
        
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_REDIRECTION",
  
  function( without_given_name, with_given_name, object_function_name, object_filter_list, object_arguments_positions )
    local object_function, with_given_name_function, is_attribute, attribute_tester;
    
    object_function := ValueGlobal( object_function_name );
    
    with_given_name_function := ValueGlobal( with_given_name );
    
    # Check if `object_function` is declared as an attribute and can actually be used as one in our context.
    is_attribute := IsAttribute( object_function ) and Length( object_filter_list ) <= 2 and IsSpecializationOfFilter( IsAttributeStoringRep, CAP_INTERNAL_REPLACED_STRING_WITH_FILTER( Last( object_filter_list ) ) );
    
    if not is_attribute then
        
        return function( arg )
          local category, without_given_weight, with_given_weight, object_args, cache, cache_value;
            
            category := arg[ 1 ];
            
            without_given_weight := OperationWeight( category, without_given_name );
            with_given_weight := OperationWeight( category, with_given_name );
            
            # If the WithGiven version is more expensive than the WithoutGiven version, redirection makes no sense and
            # might even lead to inifite loops if the WithGiven version is derived from the WithoutGiven version.
            if with_given_weight > without_given_weight then
                
                return [ false ];
                
            fi;
            
            object_args := arg{ object_arguments_positions };
            
            cache := GET_METHOD_CACHE( category, object_function_name, Length( object_arguments_positions ) );
            
            cache_value := CallFuncList( CacheValue, [ cache, object_args ] );
            
            if cache_value = [ ] then
                
                return [ false ];
                
            fi;
            
            return [ true, CallFuncList( with_given_name_function, Concatenation( arg, [ cache_value[ 1 ] ] ) ) ];
            
        end;
        
    else
        
        if not Length( object_arguments_positions ) in [ 1, 2 ] then
            
            Error( "we can only handle attributes of the category or of a single object/morphism/twocell" );
            
        fi;
        
        attribute_tester := Tester( object_function );
        
        return function( arg )
          local category, without_given_weight, with_given_weight, object_args, cache_value, cache;
            
            category := arg[ 1 ];
            
            without_given_weight := OperationWeight( category, without_given_name );
            with_given_weight := OperationWeight( category, with_given_name );
            
            # If the WithGiven version is more expensive than the WithoutGiven version, redirection makes no sense and
            # might even lead to inifite loops if the WithGiven version is derived from the WithoutGiven version.
            if with_given_weight > without_given_weight then
                
                return [ false ];
                
            fi;
            
            object_args := arg{ object_arguments_positions };

            if attribute_tester( object_args[ Length( object_args ) ] ) then
                
                cache_value := [ object_function( object_args[ Length( object_args ) ] ) ];
                
            else
                
                cache := GET_METHOD_CACHE( category, object_function_name, Length( object_arguments_positions ) );
                
                cache_value := CallFuncList( CacheValue, [ cache, object_args ] );
                
                if cache_value = [ ] then
                    
                    return [ false ];
                    
                fi;
                
            fi;
            
            return [ true, CallFuncList( with_given_name_function, Concatenation( arg, [ cache_value[ 1 ] ] ) ) ];
            
        end;
        
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_POST_FUNCTION",
  
  function( source_range_object, object_function_name, object_filter_list, object_arguments_positions )
    local object_getter, object_function, cache_key_length, is_attribute, setter_function;
    
    if source_range_object = "Source" then
        object_getter := Source;
    elif source_range_object = "Range" then
        object_getter := Range;
    else
        Error( "the first argument of CAP_INTERNAL_CREATE_POST_FUNCTION must be 'Source' or 'Range'" );
    fi;
    
    object_function := ValueGlobal( object_function_name );
    
    cache_key_length := Length( object_arguments_positions );
    
    # Check if `object_function` is declared as an attribute and can actually be used as one in our context.
    is_attribute := IsAttribute( object_function ) and Length( object_filter_list ) <= 2 and IsSpecializationOfFilter( IsAttributeStoringRep, CAP_INTERNAL_REPLACED_STRING_WITH_FILTER( Last( object_filter_list ) ) );
    
    if not is_attribute then
    
        return function( arg )
          local category, object_args, result, object;
            
            category := arg[ 1 ];
            
            object_args := arg{ object_arguments_positions };
            
            result := arg[ Length( arg ) ];
            object := object_getter( result );
            
            SET_VALUE_OF_CATEGORY_CACHE( category, object_function_name, cache_key_length, object_args, object );
            
        end;
        
    else
        
        if not Length( object_arguments_positions ) in [ 1, 2 ] then
            
            Error( "we can only handle attributes of the category or of a single object/morphism/twocell" );
            
        fi;
        
        setter_function := Setter( object_function );
        
        return function( arg )
          local category, object_args, result, object;
            
            category := arg[ 1 ];

            object_args := arg{ object_arguments_positions };
            
            result := arg[ Length( arg ) ];
            object := object_getter( result );
            
            SET_VALUE_OF_CATEGORY_CACHE( category, object_function_name, cache_key_length, object_args, object );
            setter_function( object_args[ Length( object_args ) ], object );
            
        end;
        
    fi;
    
end );

InstallGlobalFunction( CAP_INTERNAL_ENHANCE_NAME_RECORD,
  function( record )
    local recnames, current_recname, current_rec, diff, number_of_arguments, func,
          without_given_name, with_given_prefix, with_given_names, with_given_name, without_given_rec, with_given_object_position, object_name,
          object_filter_list, with_given_object_filter, given_source_argument_name, given_range_argument_name, with_given_rec,
          collected_list, preconditions, can_always_compute_output_source_getter, can_always_compute_output_range_getter;
    
    recnames := RecNames( record );
    
    # loop before detecting With(out)Given pairs
    for current_recname in recnames do
        
        current_rec := record.(current_recname);
        
        diff := Difference( RecNames( current_rec ), CAP_INTERNAL_VALID_METHOD_NAME_RECORD_COMPONENTS );
        diff := Difference( diff, CAP_INTERNAL_LEGACY_METHOD_NAME_RECORD_COMPONENTS );
        
        if not IsEmpty( diff ) then
            
            Print( "WARNING: The following method name record components are not known: " );
            Display( diff );
            
        fi;
        
        # validity checks
        if not IsBound( current_rec.return_type ) then
            Error( "<current_rec> has no return_type" );
        fi;
        
        if current_rec.return_type in [ "other_object", "other_morphism" ] then
            Error( "The return types \"other_object\" and \"other_morphism\" are not supported anymore. If you need those, please report this using the CAP_projects's issue tracker." );
        fi;
        
        if not current_rec.return_type in CAP_INTERNAL_VALID_RETURN_TYPES then
            Error( "The return_type of <current_rec> does not appear in CAP_INTERNAL_VALID_RETURN_TYPES. Note that proper filters are not supported anymore." );
        fi;
        
        if current_rec.filter_list[1] <> "category" then
            
            Error( "The first entry of `filter_list` must be the string \"category\"." );
            
        fi;
        
        if ForAny( current_rec.filter_list, x -> x in [ "other_category", "other_object", "other_morphism", "other_twocell" ] ) then
            Error( "The filters \"other_category\", \"other_object\", \"other_morphism\", and \"other_twocell\" are not supported anymore. If you need those, please report this using the CAP_projects's issue tracker." );
        fi;
        
        if IsBound( current_rec.output_source_getter_preconditions ) and not IsBound( current_rec.output_source_getter_string ) then
            
            Error( "output_source_getter_preconditions may only be set if output_source_getter_string is set" );
            
        fi;
        
        if IsBound( current_rec.output_range_getter_preconditions ) and not IsBound( current_rec.output_range_getter_string ) then
            
            Error( "output_range_getter_preconditions may only be set if output_range_getter_string is set" );
            
        fi;
        
        current_rec.function_name := current_recname;
        
        if IsBound( current_rec.pre_function ) and IsString( current_rec.pre_function ) then
            
            if IsBound( record.(current_rec.pre_function) ) and IsBound( record.(current_rec.pre_function).pre_function ) and IsFunction( record.(current_rec.pre_function).pre_function ) then
                
                current_rec.pre_function := record.(current_rec.pre_function).pre_function;
                
            else
                
                Error( "Could not find pre function for ", current_recname, ". ", current_rec.pre_function, " is not the name of an operation in the record, has no pre function, or has itself a string as pre function." );
                
            fi;
            
        fi;
        
        if IsBound( current_rec.pre_function_full ) and IsString( current_rec.pre_function_full ) then
            
            if IsBound( record.(current_rec.pre_function_full) ) and IsBound( record.(current_rec.pre_function_full).pre_function_full ) and IsFunction( record.(current_rec.pre_function_full).pre_function_full ) then
                
                current_rec.pre_function_full := record.(current_rec.pre_function_full).pre_function_full;
                
            else
                
                Error( "Could not find full pre function for ", current_recname, ". ", current_rec.pre_function_full, " is not the name of an operation in the record, has no full pre function, or has itself a string as full pre function." );
                
            fi;
            
        fi;
        
        if IsBound( current_rec.redirect_function ) and IsString( current_rec.redirect_function ) then
            
            if IsBound( record.(current_rec.redirect_function) ) and IsBound( record.(current_rec.redirect_function).redirect_function ) and IsFunction( record.(current_rec.redirect_function).redirect_function ) then
                
                current_rec.redirect_function := record.(current_rec.redirect_function).redirect_function;
                
            else
                
                Error( "Could not find redirect function for ", current_recname, ". ", current_rec.redirect_function, " is not the name of an operation in the record, has no redirect function, or has itself a string as redirect function." );
                
            fi;
            
        fi;
        
        number_of_arguments := Length( current_rec.filter_list );
        
        if IsBound( current_rec.pre_function ) and NumberArgumentsFunction( current_rec.pre_function ) >= 0 and NumberArgumentsFunction( current_rec.pre_function ) <> number_of_arguments then
            Error( "the pre function of <current_rec> has the wrong number of arguments" );
        fi;
        
        if IsBound( current_rec.pre_function_full ) and NumberArgumentsFunction( current_rec.pre_function_full ) >= 0 and NumberArgumentsFunction( current_rec.pre_function_full ) <> number_of_arguments then
            Error( "the full pre function of <current_rec> has the wrong number of arguments" );
        fi;
        
        if IsBound( current_rec.redirect_function ) and NumberArgumentsFunction( current_rec.redirect_function ) >= 0 and NumberArgumentsFunction( current_rec.redirect_function ) <> number_of_arguments then
            Error( "the redirect function of <current_rec> has the wrong number of arguments" );
        fi;
        
        if IsBound( current_rec.post_function ) and NumberArgumentsFunction( current_rec.post_function ) >= 0 and NumberArgumentsFunction( current_rec.post_function ) <> number_of_arguments + 1 then
            Error( "the post function of <current_rec> has the wrong number of arguments" );
        fi;
        
        if IsBound( current_rec.dual_preprocessor_func ) and NumberArgumentsFunction( current_rec.dual_preprocessor_func ) >= 0 and NumberArgumentsFunction( current_rec.dual_preprocessor_func ) <> number_of_arguments then
            Error( "the dual preprocessor function of ", current_recname, " has the wrong number of arguments" );
        fi;
        
        if not ForAll( current_rec.filter_list, IsString ) then
            Error( "Not all entries of filter_list of ", current_recname, " are strings. This is not supported anymore." );
        fi;
        
        if not IsBound( current_rec.install_convenience_without_category ) then
            
            if ForAny( [ "object", "morphism", "twocell", "list_of_objects", "list_of_morphisms", "list_of_twocells" ], filter -> filter in current_rec.filter_list ) then
                
                current_rec.install_convenience_without_category := true;
                
            else
                
                current_rec.install_convenience_without_category := false;
                
            fi;
            
        fi;
        
        if IsBound( current_rec.universal_object_position ) then
            
            Display( "WARNING: universal_object_position was renamed to with_given_object_position" );
            
            current_rec.with_given_object_position := current_rec.universal_object_position;
            
        fi;
        
        if IsBound( current_rec.with_given_object_position ) and not current_rec.with_given_object_position in [ "Source", "Range", "both" ] then
            
            Error( "with_given_object_position must be one of the strings \"Source\", \"Range\", or \"both\", not ", current_rec.with_given_object_position );
            
        fi;
        
        if not IsBound( current_rec.is_with_given ) then
            
            current_rec.is_with_given := false;
            
        fi;
        
        if not IsBound( current_rec.with_given_without_given_name_pair ) then
            
            current_rec.with_given_without_given_name_pair := fail;
            
        fi;
        
        if IsBound( current_rec.dual_operation ) then
            
            # check that dual of the dual is the original operation
            
            if not IsBound( record.( current_rec.dual_operation ) ) then
                
                Error( "the dual operation must be added in the same call to `CAP_INTERNAL_ENHANCE_NAME_RECORD`" );
                
            fi;
            
            if not IsBound( record.( current_rec.dual_operation ).dual_operation ) then
                
                Error( "the dual operation of ", current_recname, ", i.e. ", current_rec.dual_operation, ", has no dual operation"  );
                
            fi;
            
            if record.( current_rec.dual_operation ).dual_operation <> current_recname then
                
                Error( "the dual operation of ", current_recname, ", i.e. ", current_rec.dual_operation, ", has the unexpected dual operation ", record.( current_rec.dual_operation ).dual_operation  );
                
            fi;
            
        fi;
        
        if not IsBound( current_rec.dual_arguments_reversed ) then
            
            current_rec.dual_arguments_reversed := false;
            
        fi;
        
        if Length( Filtered( [ "dual_preprocessor_func", "dual_arguments_reversed", "dual_with_given_objects_reversed" ],
                             name -> IsBound( current_rec.(name) ) and ( IsFunction( current_rec.(name) ) or current_rec.(name) = true )
                           ) ) >= 2 then
            
            Error( "dual_preprocessor_func, dual_arguments_reversed = true and dual_with_given_objects_reversed = true are mutually exclusive" );
            
        fi;
        
        if IsBound( current_rec.dual_preprocessor_func ) then
            
            if IsBound( current_rec.dual_preprocessor_func_string ) then
                
                Error( "dual_preprocessor_func and dual_preprocessor_func_string are mutually exclusive" );
                
            fi;
            
            if IsOperation( current_rec.dual_preprocessor_func ) or IsKernelFunction( current_rec.dual_preprocessor_func ) then
                
                current_rec.dual_preprocessor_func_string := NameFunction( current_rec.dual_preprocessor_func );
                
            else
                
                current_rec.dual_preprocessor_func_string := String( current_rec.dual_preprocessor_func );
                
            fi;
            
        fi;
        
        if IsBound( current_rec.dual_postprocessor_func ) then
            
            if IsBound( current_rec.dual_postprocessor_func_string ) then
                
                Error( "dual_postprocessor_func and dual_postprocessor_func_string are mutually exclusive" );
                
            fi;
            
            if IsOperation( current_rec.dual_postprocessor_func ) or IsKernelFunction( current_rec.dual_postprocessor_func ) then
                
                current_rec.dual_postprocessor_func_string := NameFunction( current_rec.dual_postprocessor_func );
                
            else
                
                current_rec.dual_postprocessor_func_string := String( current_rec.dual_postprocessor_func );
                
            fi;
            
        fi;
        
        func := ValueGlobal( current_recname );
        
        if IsOperation( func ) then
            
            current_rec.operation := func;
            
        elif IsFunction( func ) then
            
            current_rec.operation := ValueGlobal( Concatenation( current_recname, "Op" ) );
            
        else
            
            Error( "`ValueGlobal( current_recname )` is neither an operation nor a function" );
            
        fi;
        
        if not IsBound( current_rec.input_arguments_names ) then
            
            current_rec.input_arguments_names := Concatenation( [ "cat" ], List( [ 2 .. Length( current_rec.filter_list ) ], i -> Concatenation( "arg", String( i ) ) ) );
            
        fi;
        
        if current_rec.input_arguments_names[1] <> "cat" then
            
            Error( "the category argument must always be called \"cat\", please adjust the method record entry of ", current_recname );
            
        fi;
        
        if not ForAll( current_rec.input_arguments_names, x -> IsString( x ) ) then
            
            Error( "the entries of input_arguments_names must be strings, please adjust the method record entry of ", current_recname );
            
        fi;
        
        if not IsDuplicateFreeList( current_rec.input_arguments_names ) then
            
            Error( "input_arguments_names must be duplicate free, please adjust the method record entry of ", current_recname );
            
        fi;
        
        if ForAll( current_rec.filter_list, x -> x in [ "element_of_commutative_ring_of_linear_structure", "integer", "nonneg_integer_or_infinity", "category", "object", "object_in_range_category_of_homomorphism_structure", "list_of_objects" ] ) then
            
            if not IsBound( current_rec.compatible_with_congruence_of_morphisms ) then
                
                current_rec.compatible_with_congruence_of_morphisms := true;
                
            fi;
            
            if current_rec.compatible_with_congruence_of_morphisms <> true then
                
                Error( current_recname, " does not depend on morphisms but is still marked as not compatible with the congruence of morphisms" );
                
            fi;
            
        fi;
        
    od;
    
    # detect With(out)Given pairs
    for current_recname in recnames do
        
        current_rec := record.(current_recname);
        
        if IsBound( current_rec.with_given_object_position ) then
            
            if PositionSublist( current_recname, "WithGiven" ) <> fail then
                
                Error( "WithGiven operations must NOT have the component with_given_object_position set, please adjust the method record entry of ", current_recname );
                
            fi;
            
            without_given_name := current_recname;
            
            with_given_prefix := Concatenation( without_given_name, "WithGiven" );
            
            with_given_names := Filtered( recnames, x -> StartsWith( x, with_given_prefix ) );
            
            if Length( with_given_names ) <> 1 then
                
                Error( "Could not find unique WithGiven version for ", without_given_name );
                
            fi;
            
            with_given_name := with_given_names[1];
            
            without_given_rec := record.(without_given_name);
            
            with_given_object_position := without_given_rec.with_given_object_position;
            
            object_name := ReplacedString( with_given_name, with_given_prefix, "" );
            
            # generate output_source_getter_string resp. output_range_getter_string automatically if possible
            if object_name in recnames then
                
                object_filter_list := record.( object_name ).filter_list;
                
                if with_given_object_position = "Source" then
                    
                    if not IsBound( without_given_rec.output_source_getter_string ) then
                        
                        without_given_rec.output_source_getter_string := Concatenation( object_name, "( ", JoinStringsWithSeparator( without_given_rec.input_arguments_names{[ 1 .. Length( object_filter_list ) ]}, ", " ), " )" );
                        without_given_rec.output_source_getter_preconditions := [ [ object_name, 1 ] ];
                        
                    fi;
                    
                fi;
                
                if with_given_object_position = "Range" then
                    
                    if not IsBound( without_given_rec.output_range_getter_string ) then
                        
                        without_given_rec.output_range_getter_string := Concatenation( object_name, "( ", JoinStringsWithSeparator( without_given_rec.input_arguments_names{[ 1 .. Length( object_filter_list ) ]}, ", " ), " )" );
                        without_given_rec.output_range_getter_preconditions := [ [ object_name, 1 ] ];
                        
                    fi;
                    
                fi;
                
            fi;
            
            # plausibility checks for without_given_rec
            if with_given_object_position in [ "Source", "both" ] then
                
                if not IsBound( without_given_rec.output_source_getter_string ) then
                    
                    Error( "This is a WithoutGiven record, but output_source_getter_string is not set. This is not supported." );
                    
                fi;
                
            fi;
            
            if with_given_object_position in [ "Range", "both" ] then
                
                if not IsBound( without_given_rec.output_range_getter_string ) then
                    
                    Error( "This is a WithoutGiven record, but output_range_getter_string is not set. This is not supported." );
                    
                fi;
                
            fi;
            
            if not without_given_rec.return_type in [ "morphism", "morphism_in_range_category_of_homomorphism_structure" ] then
                
                Error( "This is a WithoutGiven record, but return_type is neither \"morphism\" nor \"morphism_in_range_category_of_homomorphism_structure\". This is not supported." );
                
            fi;
            
            # generate with_given_rec
            if without_given_rec.return_type = "morphism" then
                
                with_given_object_filter := "object";
                
            elif without_given_rec.return_type = "morphism_in_range_category_of_homomorphism_structure" then
                
                with_given_object_filter := "object_in_range_category_of_homomorphism_structure";
                
            else
                
                Error( "this should never happen" );
                
            fi;
            
            if with_given_object_position = "Source" then
                
                given_source_argument_name := Last( record.(with_given_name).input_arguments_names );
                
            elif with_given_object_position = "Range" then
                
                given_range_argument_name := Last( record.(with_given_name).input_arguments_names );
                
            else
                
                given_source_argument_name := record.(with_given_name).input_arguments_names[2];
                given_range_argument_name := Last( record.(with_given_name).input_arguments_names );
                
            fi;
            
            with_given_rec := rec(
                return_type := without_given_rec.return_type,
            );
            
            if with_given_object_position = "Source" then
                
                with_given_rec.filter_list := Concatenation( without_given_rec.filter_list, [ with_given_object_filter ] );
                with_given_rec.input_arguments_names := Concatenation( without_given_rec.input_arguments_names, [ given_source_argument_name ] );
                with_given_rec.output_source_getter_string := given_source_argument_name;
                
                if IsBound( without_given_rec.output_range_getter_string ) then
                    
                    with_given_rec.output_range_getter_string := without_given_rec.output_range_getter_string;
                    
                fi;
                
                if IsBound( without_given_rec.output_range_getter_preconditions ) then
                    
                    with_given_rec.output_range_getter_preconditions := without_given_rec.output_range_getter_preconditions;
                    
                fi;
                
            elif with_given_object_position = "Range" then
                
                with_given_rec.filter_list := Concatenation( without_given_rec.filter_list, [ with_given_object_filter ] );
                with_given_rec.input_arguments_names := Concatenation( without_given_rec.input_arguments_names, [ given_range_argument_name ] );
                with_given_rec.output_range_getter_string := given_range_argument_name;
                
                if IsBound( without_given_rec.output_source_getter_string ) then
                    
                    with_given_rec.output_source_getter_string := without_given_rec.output_source_getter_string;
                    
                fi;
                
                if IsBound( without_given_rec.output_source_getter_preconditions ) then
                    
                    with_given_rec.output_source_getter_preconditions := without_given_rec.output_source_getter_preconditions;
                    
                fi;
                
            elif with_given_object_position = "both" then
                
                with_given_rec.filter_list := Concatenation(
                    [ without_given_rec.filter_list[1] ],
                    [ with_given_object_filter ],
                    without_given_rec.filter_list{[ 2 .. Length( without_given_rec.filter_list ) ]},
                    [ with_given_object_filter ]
                );
                with_given_rec.input_arguments_names := Concatenation(
                    [ without_given_rec.input_arguments_names[1] ],
                    [ given_source_argument_name ],
                    without_given_rec.input_arguments_names{[ 2 .. Length( without_given_rec.input_arguments_names ) ]},
                    [ given_range_argument_name ]
                );
                
                with_given_rec.output_source_getter_string := given_source_argument_name;
                with_given_rec.output_range_getter_string := given_range_argument_name;
                
            else
                
                Error( "this should never happen" );
                
            fi;
            
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( record, with_given_name, with_given_rec : subset_only := true );
            
            # now enhance the actual with_given_rec
            with_given_rec := record.(with_given_name);
            
            if IsBound( without_given_rec.pre_function ) and not IsBound( with_given_rec.pre_function ) then
                with_given_rec.pre_function := CAP_INTERNAL_PREPARE_INHERITED_PRE_FUNCTION( record.(without_given_name).pre_function, with_given_object_position = "both" );
            fi;
            
            if IsBound( without_given_rec.pre_function_full ) and not IsBound( with_given_rec.pre_function_full ) then
                with_given_rec.pre_function_full := CAP_INTERNAL_PREPARE_INHERITED_PRE_FUNCTION( record.(without_given_name).pre_function_full, with_given_object_position = "both" );
            fi;
            
            with_given_rec.is_with_given := true;
            with_given_rec.with_given_without_given_name_pair := [ without_given_name, with_given_name ];
            without_given_rec.with_given_without_given_name_pair := [ without_given_name, with_given_name ];
            
            if object_name in recnames then
                
                if with_given_object_position = "both" then
                    
                    Error( "with_given_object_position is \"both\", but the WithGiven name suggests that only a single object of name ", object_name, " is given. This is not supported." );
                    
                fi;
                
                with_given_rec.with_given_object_name := object_name;
                
                object_filter_list := record.( object_name ).filter_list;
                
                if with_given_object_position = "Source" then
                    
                    if not StartsWith( without_given_rec.output_source_getter_string, object_name ) then
                        
                        Error( "the output_source_getter_string of the WithoutGiven record does not call the detected object ", object_name );
                        
                    fi;
                    
                fi;
                
                if with_given_object_position = "Range" then
                    
                    if not StartsWith( without_given_rec.output_range_getter_string, object_name ) then
                        
                        Error( "the output_range_getter_string of the WithoutGiven record does not call the detected object ", object_name );
                        
                    fi;
                    
                fi;
                
                if not StartsWith( without_given_rec.filter_list, object_filter_list ) then
                    
                    Error( "the object arguments must be the first arguments of the without given method, but the corresponding filters do not match" );
                    
                fi;
                
                if not IsBound( without_given_rec.redirect_function ) then
                    
                    if Length( record.( without_given_name ).filter_list ) + 1 <> Length( record.( with_given_name ).filter_list ) then
                        
                        Display( Concatenation(
                            "WARNING: You seem to be relying on automatically installed redirect functions. ",
                            "For this, the with given method must have exactly one additional argument compared to the without given method. ",
                            "This is not the case, so no automatic redirect function will be installed. ",
                            "Install a custom redirect function to prevent this warning."
                        ) );
                        
                    else
                        
                        without_given_rec.redirect_function := CAP_INTERNAL_CREATE_REDIRECTION( without_given_name, with_given_name, object_name, object_filter_list, [ 1 .. Length( object_filter_list ) ] );
                        
                    fi;
                    
                fi;
                
                if not IsBound( without_given_rec.post_function ) then
                    
                    without_given_rec.post_function := CAP_INTERNAL_CREATE_POST_FUNCTION( with_given_object_position, object_name, object_filter_list, [ 1 .. Length( object_filter_list ) ] );
                    
                fi;
                
            fi;
            
        fi;
        
    od;
    
    # loop after detecting With(out)Given pairs
    for current_recname in recnames do
        
        current_rec := record.(current_recname);
        
        if IsBound( current_rec.dual_with_given_objects_reversed ) and current_rec.dual_with_given_objects_reversed then
            
            if not current_rec.is_with_given then
                
                Error( "dual_with_given_objects_reversed may only be set for with given records" );
                
            fi;
            
            without_given_rec := record.(current_rec.with_given_without_given_name_pair[1]);
            
            with_given_object_position := without_given_rec.with_given_object_position;
            
            if with_given_object_position <> "both" then
                
                Error( "dual_with_given_objects_reversed may only be set if both source and range are given" );
                
            fi;
            
        fi;
        
        # set `output_source_getter` and `output_range_getter`
        if IsBound( current_rec.output_source_getter_string ) then
            
            current_rec.output_source_getter := EvalString( ReplacedStringViaRecord(
                "{ arguments... } -> getter",
                rec(
                    arguments := current_rec.input_arguments_names,
                    getter := current_rec.output_source_getter_string,
                )
            ) );
            
            if current_rec.output_source_getter_string in current_rec.input_arguments_names then
                
                if not IsBound( current_rec.output_source_getter_preconditions ) then
                    
                    current_rec.output_source_getter_preconditions := [ ];
                    
                fi;
                
                if not IsEmpty( current_rec.output_source_getter_preconditions ) then
                    
                    Error( "<current_rec.output_source_getter_preconditions> does not match the automatically detected value" );
                    
                fi;
                
            fi;
            
            #= comment for Julia
            if IsBound( current_rec.output_source_getter_preconditions ) then
                
                if ForAny( current_rec.output_source_getter_preconditions, x -> IsList( x ) and Length( x ) = 3 ) then
                    
                    Print( "WARNING: preconditions in other categories are not yet supported, please report this using the CAP_projects's issue tracker.\n" );
                    
                fi;
                
                if ForAny( current_rec.output_source_getter_preconditions, x -> not IsList( x ) or Length( x ) <> 2 or not IsString( x[1] ) or not IsInt( x[2] ) ) then
                    
                    Error( "Preconditions must be pairs of names of CAP operations and integers." );
                    
                fi;
                
                collected_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION(
                        current_rec.output_source_getter,
                        Concatenation( recnames, RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) ),
                        2,
                        CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS,
                        rec( )
                );
                
                Assert( 0, ForAll( collected_list, x -> Length( x ) = 3 and x[3] = fail ) );
                
                preconditions := Set( List( collected_list, x -> [ x[1], x[2] ] ) );
                
                if Set( current_rec.output_source_getter_preconditions ) <> preconditions then
                    
                    Error( "output_source_getter_preconditions of ", current_recname, " is ", current_rec.output_source_getter_preconditions, " but expected ", preconditions );
                    
                fi;
                
            fi;
            # =#
            
            if IsBound( current_rec.output_source_getter_preconditions ) then
                
                can_always_compute_output_source_getter := IsEmpty( current_rec.output_source_getter_preconditions );
                
                if IsBound( current_rec.can_always_compute_output_source_getter ) then
                    
                    if current_rec.can_always_compute_output_source_getter <> can_always_compute_output_source_getter then
                        
                        Error( "<current_rec.can_always_compute_output_source_getter> does not match the automatically detected value" );
                        
                    fi;
                    
                else
                    
                    current_rec.can_always_compute_output_source_getter := can_always_compute_output_source_getter;
                    
                fi;
                
            fi;
            
        fi;
        
        if IsBound( current_rec.output_range_getter_string ) then
            
            current_rec.output_range_getter := EvalString( ReplacedStringViaRecord(
                "{ arguments... } -> getter",
                rec(
                    arguments := current_rec.input_arguments_names,
                    getter := current_rec.output_range_getter_string,
                )
            ) );
            
            if current_rec.output_range_getter_string in current_rec.input_arguments_names then
                
                if not IsBound( current_rec.output_range_getter_preconditions ) then
                    
                    current_rec.output_range_getter_preconditions := [ ];
                    
                fi;
                
                if not IsEmpty( current_rec.output_range_getter_preconditions ) then
                    
                    Error( "<current_rec.output_range_getter_preconditions> does not match the automatically detected value" );
                    
                fi;
                
            fi;
            
            #= comment for Julia
            if IsBound( current_rec.output_range_getter_preconditions ) then
                
                if ForAny( current_rec.output_range_getter_preconditions, x -> IsList( x ) and Length( x ) = 3 ) then
                    
                    Print( "WARNING: preconditions in other categories are not yet supported, please report this using the CAP_projects's issue tracker.\n" );
                    
                fi;
                
                if ForAny( current_rec.output_range_getter_preconditions, x -> not IsList( x ) or Length( x ) <> 2 or not IsString( x[1] ) or not IsInt( x[2] ) ) then
                    
                    Error( "Preconditions must be pairs of names of CAP operations and integers." );
                    
                fi;
                
                collected_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION(
                        current_rec.output_range_getter,
                        Concatenation( recnames, RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) ),
                        2,
                        CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS,
                        rec( )
                );
                
                Assert( 0, ForAll( collected_list, x -> Length( x ) = 3 and x[3] = fail ) );
                
                preconditions := Set( List( collected_list, x -> [ x[1], x[2] ] ) );
                
                if Set( current_rec.output_range_getter_preconditions ) <> preconditions then
                    
                    Error( "output_range_getter_preconditions of ", current_recname, " is ", current_rec.output_range_getter_preconditions, " but expected ", preconditions );
                    
                fi;
                
            fi;
            # =#
            
            if IsBound( current_rec.output_range_getter_preconditions ) then
                
                can_always_compute_output_range_getter := IsEmpty( current_rec.output_range_getter_preconditions );
                
                if IsBound( current_rec.can_always_compute_output_range_getter ) then
                    
                    if current_rec.can_always_compute_output_range_getter <> can_always_compute_output_range_getter then
                        
                        Error( "<current_rec.can_always_compute_output_range_getter> does not match the automatically detected value" );
                        
                    fi;
                    
                else
                    
                    current_rec.can_always_compute_output_range_getter := can_always_compute_output_range_getter;
                    
                fi;
                
            fi;
            
        fi;
        
        if current_rec.return_type = "object" then
            current_rec.add_value_to_category_function := AddObject;
        elif current_rec.return_type = "morphism" then
            current_rec.add_value_to_category_function := AddMorphism;
        elif current_rec.return_type = "twocell" then
            current_rec.add_value_to_category_function := AddTwoCell;
        else
            current_rec.add_value_to_category_function := ReturnTrue;
        fi;
        
    od;
    
    CAP_INTERNAL_FIND_OPPOSITE_PROPERTY_PAIRS_IN_METHOD_NAME_RECORD( record );
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_GENERATE_DECLARATIONS_AND_INSTALLATIONS_FROM_METHOD_NAME_RECORD,
  function ( record, package_name, filename_prefix, chapter_name, section_name )
    local recnames, package_info, gd_output_string, gi_output_string, current_string, current_recname, current_rec, without_given_name, with_given_name, without_given_rec, with_given_rec, without_given_arguments_names, with_given_arguments_names, with_given_object_position, with_given_arguments_strings, additional_preconditions, x, pos, preconditions_string, gd_filename, gi_filename, output_path;
    
    #= comment for Julia
    
    recnames := SortedList( RecNames( record ) );
    
    package_info := First( PackageInfo( package_name ) );
    
    if package_info = fail then
        
        Error( "could not find package info" );
        
    fi;
    
    gd_output_string := "";
    gi_output_string := "";
    
    ## declarations
    
    # the space between # and ! prevents AutoDoc from parsing these strings and is removed below
    current_string := ReplacedStringViaRecord(
"""# SPDX-License-Identifier: GPL-2.0-or-later
# package_name: package_subtitle
#
# Declarations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecordTools.gi

# ! @Chapter chapter_name

# ! @Section section_name
""",
        rec(
            package_name := package_name,
            package_subtitle := package_info.Subtitle,
            chapter_name := chapter_name,
            section_name := section_name,
        )
    );
    
    # see comment above
    current_string := ReplacedString( current_string, "# !", "#!" );
    
    gd_output_string := Concatenation( gd_output_string, current_string );
    
    ## implementations
    
    current_string := ReplacedStringViaRecord(
"""# SPDX-License-Identifier: GPL-2.0-or-later
# package_name: package_subtitle
#
# Implementations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecordTools.gi
""",
        rec(
            package_name := package_name,
            package_subtitle := package_info.Subtitle,
        )
    );
    
    gi_output_string := Concatenation( gi_output_string, current_string );
    
    for current_recname in recnames do
        
        current_rec := record.(current_recname);
        
        ## declarations
        
        # the space between # and ! prevents AutoDoc from parsing these strings and is removed below
        current_string := ReplacedStringViaRecord(
"""
# ! @BeginGroup
# ! @Description
# ! The arguments are a category $C$ and a function $F$.
# ! This operation adds the given function $F$
# ! to the category for the basic operation `function_name`.
# ! Optionally, a weight (default: 100) can be specified which should roughly correspond
# ! to the computational complexity of the function (lower weight = less complex = faster execution).
# ! $F: ( input_arguments... ) \mapsto \mathtt{function_name}(input_arguments...)$.
# ! @Returns nothing
# ! @Arguments C, F
DeclareOperation( "Addfunction_name",
                  [ IsCapCategory, IsFunction ] );

# ! @Arguments C, F, weight
DeclareOperation( "Addfunction_name",
                  [ IsCapCategory, IsFunction, IsInt ] );
# ! @EndGroup

""",
            rec(
                function_name := current_recname,
                input_arguments := current_rec.input_arguments_names{[ 2 .. Length( current_rec.input_arguments_names ) ]},
            )
        );
        
        # see comment above
        current_string := ReplacedString( current_string, "# !", "#!" );
        
        gd_output_string := Concatenation( gd_output_string, current_string );
        
        ## implementations
        
        current_string := ReplacedStringViaRecord(
"""
## function_name
InstallMethod( Addfunction_name,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "function_name", category, func, -1 );
    
end );

InstallMethod( Addfunction_name,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "function_name", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);
""",
            rec(
                function_name := current_recname,
                input_arguments := current_rec.input_arguments_names{[ 2 .. Length( current_rec.input_arguments_names ) ]},
            )
        );
        
        gi_output_string := Concatenation( gi_output_string, current_string );
        
        ## WithGiven derivations
        if current_rec.is_with_given then
            
            without_given_name := current_rec.with_given_without_given_name_pair[1];
            with_given_name := current_rec.with_given_without_given_name_pair[2];
            
            without_given_rec := record.(without_given_name);
            with_given_rec := record.(with_given_name);
            
            without_given_arguments_names := without_given_rec.input_arguments_names;
            with_given_arguments_names := with_given_rec.input_arguments_names;
            
            with_given_object_position := without_given_rec.with_given_object_position;
            
            current_string := ReplacedStringViaRecord(
"""
AddDerivationToCAP( with_given_name,
                    "with_given_name by calling without_given_name with the WithGiven argument(s) dropped",
                    [
                        [ without_given_name, 1 ],
                    ],
  function( with_given_arguments... )
    
    return without_given_name( without_given_arguments... );
        
end : is_with_given_derivation := true );
""",
                rec(
                    with_given_name := with_given_name,
                    without_given_name := without_given_name,
                    with_given_arguments := with_given_arguments_names,
                    without_given_arguments := without_given_arguments_names,
                )
            );
            
            gi_output_string := Concatenation( gi_output_string, current_string );
            
            if with_given_object_position = "Source" then
                
                with_given_arguments_strings := Concatenation( without_given_arguments_names, [ without_given_rec.output_source_getter_string ] );
                
                if not IsBound( without_given_rec.output_source_getter_preconditions ) then
                    
                    Print( "WARNING: Cannot install with given derivation pair for ", without_given_name, " because <without_given_rec.output_source_getter_preconditions> is not set.\n" );
                    return;
                    
                fi;
                
                additional_preconditions := without_given_rec.output_source_getter_preconditions;
                
            elif with_given_object_position = "Range" then
                
                with_given_arguments_strings := Concatenation( without_given_arguments_names, [ without_given_rec.output_range_getter_string ] );
                
                if not IsBound( without_given_rec.output_range_getter_preconditions ) then
                    
                    Print( "WARNING: Cannot install with given derivation pair for ", without_given_name, " because <without_given_rec.output_range_getter_preconditions> is not set.\n" );
                    return;
                    
                fi;
                
                additional_preconditions := without_given_rec.output_range_getter_preconditions;
                
            elif with_given_object_position = "both" then
                
                with_given_arguments_strings := Concatenation(
                    [ without_given_arguments_names[1] ],
                    [ without_given_rec.output_source_getter_string ],
                    without_given_arguments_names{[ 2 .. Length( without_given_arguments_names ) ]},
                    [ without_given_rec.output_range_getter_string ]
                );
                
                if not IsBound( without_given_rec.output_source_getter_preconditions ) then
                    
                    Print( "WARNING: Cannot install with given derivation pair for ", without_given_name, " because <without_given_rec.output_source_getter_preconditions> is not set.\n" );
                    return;
                    
                fi;
                
                if not IsBound( without_given_rec.output_range_getter_preconditions ) then
                    
                    Print( "WARNING: Cannot install with given derivation pair for ", without_given_name, " because <without_given_rec.output_range_getter_preconditions> is not set.\n" );
                    return;
                    
                fi;
                
                # merge output_source_getter_preconditions and output_range_getter_preconditions
                additional_preconditions := without_given_rec.output_source_getter_preconditions;
                
                for x in without_given_rec.output_range_getter_preconditions do
                    
                    pos := PositionProperty( additional_preconditions, y -> y[1] = x[1] );
                    
                    if pos = fail then
                        
                        Add( additional_preconditions, x );
                        
                    else
                        
                        additional_preconditions[pos][2] := additional_preconditions[pos][2] + x[2];
                        
                    fi;
                    
                od;
                
            else
                
                Error( "this should never happen" );
                
            fi;
            
            preconditions_string := Concatenation( "[ ", with_given_name, ", 1 ]" );
            
            for x in additional_preconditions do
                
                Append( preconditions_string, Concatenation( ",\n                        [ ", x[1], ", ", String( x[2] ), " ]" ) );
                
            od;
            
            current_string := ReplacedStringViaRecord(
"""
AddDerivationToCAP( without_given_name,
                    "without_given_name by calling with_given_name with the WithGiven object(s)",
                    [
                        preconditions_string,
                    ],
  function( without_given_arguments... )
    
    return with_given_name( with_given_arguments... );
    
end : is_with_given_derivation := true );
""",
                rec(
                    without_given_name := without_given_name,
                    with_given_name := with_given_name,
                    preconditions_string := preconditions_string,
                    without_given_arguments := without_given_arguments_names,
                    with_given_arguments := with_given_arguments_strings,
                )
            );
            
            gi_output_string := Concatenation( gi_output_string, current_string );
            
        fi;
        
        
    od;
    
    ## declarations
    
    gd_filename := Concatenation( filename_prefix, "Declarations.autogen.gd" );
    
    if not IsExistingFileInPackageForHomalg( package_name, gd_filename ) or gd_output_string <> ReadFileFromPackageForHomalg( package_name, gd_filename ) then
        
        output_path := Filename( DirectoryTemporary( ), gd_filename );
        
        WriteFileForHomalg( output_path, gd_output_string );
        
        Display( Concatenation(
            "WARNING: The file ", gd_filename, " in package ", package_name, " differs from the automatically generated one. ",
            "You can view the automatically generated file at the following path: ",
            output_path
        ) );
        
    fi;
    
    ## implementations
    
    gi_filename := Concatenation( filename_prefix, "Installations.autogen.gi" );
    
    if not IsExistingFileInPackageForHomalg( package_name, gi_filename ) or gi_output_string <> ReadFileFromPackageForHomalg( package_name, gi_filename ) then
        
        output_path := Filename( DirectoryTemporary( ), gi_filename );
        
        WriteFileForHomalg( output_path, gi_output_string );
        
        Display( Concatenation(
            "WARNING: The file ", gi_filename, " in package ", package_name, " differs from the automatically generated one. ",
            "You can view the automatically generated file at the following path: ",
            output_path
        ) );
        
    fi;
    # =#
    
end );

BindGlobal( "CAP_INTERNAL_METHOD_NAME_RECORDS_BY_PACKAGE", rec( ) );

##
InstallGlobalFunction( CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE,
  function ( record, package_name )
    local recname;
    
    if not IsBound( CAP_INTERNAL_METHOD_NAME_RECORDS_BY_PACKAGE.(package_name) ) then
        
        CAP_INTERNAL_METHOD_NAME_RECORDS_BY_PACKAGE.(package_name) := rec( );
        
    fi;
    
    for recname in RecNames( record ) do
        
        if IsBound( CAP_INTERNAL_METHOD_NAME_RECORDS_BY_PACKAGE.(package_name).(recname) ) then
            
            Error( recname, " is already registered for this package" );
            
        fi;
        
        CAP_INTERNAL_METHOD_NAME_RECORDS_BY_PACKAGE.(package_name).(recname) := record.(recname);
        
    od;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_GENERATE_DOCUMENTATION_FOR_CATEGORY_INSTANCES,
  function ( subsections, package_name, filename, chapter_name, section_name )
    local output_string, package_info, current_string, transitively_needed_other_packages, parent_index, subsection, category, subsection_title, operations, bookname, info, label, match, nr, res, test_string, test_string_legacy, output_path, i, name;
    
    output_string := "";
    
    package_info := First( PackageInfo( package_name ) );
    
    if package_info = fail then
        
        Error( "could not find package info" );
        
    fi;
    
    # the space between # and ! prevents AutoDoc from parsing these strings and is removed below
    current_string := ReplacedStringViaRecord(
"""# SPDX-License-Identifier: GPL-2.0-or-later
# package_name: package_subtitle
#
# Declarations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecord.gi

# ! @Chapter chapter_name

# ! @Section section_name
""",
        rec(
            package_name := package_name,
            package_subtitle := package_info.Subtitle,
            chapter_name := chapter_name,
            section_name := section_name,
        )
    );
    
    output_string := Concatenation( output_string, current_string );
    
    # We do not want to include operations from optional dependencies because those might not be available.
    transitively_needed_other_packages := TransitivelyNeededOtherPackages( package_name );
    
    for i in [ 1 .. Length( subsections ) ] do
        
        subsection := subsections[i];
        
        Assert( 0, IsList( subsection ) and Length( subsection ) in [ 2, 3 ] );
        
        category := subsection[1];
        subsection_title := subsection[2];
        
        if Length( subsection ) <> 3 then
            subsection[3] := i - 1;
        fi;
        
        parent_index := subsection[3];
        
        Assert( 0, IsCapCategory( category ) );
        Assert( 0, IsString( subsection_title ) );
        
        # the space between # and ! prevents AutoDoc from parsing these strings and is removed below
        
        current_string := Concatenation( "\n# ! @Subsection ", subsection_title );
        output_string := Concatenation( output_string, current_string );
        
        if i = 1 then
            
            operations := AsSortedList( ListInstalledOperationsOfCategory( category ) );
            
            Add( subsection, operations );
            
            current_string := "\n\n# ! The following CAP operations are supported:";
            
        else
            
            operations := ListInstalledOperationsOfCategory( category );
            
            if not IsSubset( operations, subsections[parent_index][4] ) then
                
                Error( "the operations of the category", Name( subsections[i - 1][1] ), " are not a subset of the operations of the category ", Name( subsections[i][1] ) );
                
            fi;
            
            Add( subsection, operations );
            
            operations := AsSortedList( Difference( operations, subsections[parent_index][4] ) );
            
            current_string := Concatenation( "\n\n# ! Additional to the operations listed in “", subsections[parent_index][2], "” the following operations are supported:" );
            
        fi;
        
        if IsEmpty( operations ) then
            
            Display( "WARNING: No operations found, skipping subection" );
            
        fi;
        
        output_string := Concatenation( output_string, current_string );
        
        for name in operations do
            
            # find package name = bookname
            bookname := PackageOfCAPOperation( name );
            
            if bookname = fail then
                
                Display( Concatenation( "WARNING: Could not find package for CAP operation ", name, ", skipping." ) );
                continue;
                
            fi;
            
            # skip operation if it comes from an optional dependency
            if not bookname in transitively_needed_other_packages then
                
                continue;
                
            fi;
            
            # simulate GAPDoc's `ResolveExternalRef` to make sure we get a correct reference
            info := HELP_BOOK_INFO( bookname );
            
            if info = fail then
                
                Error( "Could not get HELP_BOOK_INFO for book ", bookname, ". You probably have to execute `make doc` for the corresponding package." );
                
            fi;
            
            if IsOperation( ValueGlobal( name ) ) then
                
                # the "for Is" makes sure we only match operations with a filter and not functions
                label := "for Is";
                
            else
                
                label := "";
                
            fi;
            
            match := Concatenation( HELP_GET_MATCHES( info, SIMPLE_STRING( Concatenation( name, " (", label, ")" ) ), true ) );
            
            nr := 1;
            
            if Length(match) < nr then
                
                Error( "Could not get HELP_GET_MATCHES for book ", bookname, ", operation ", name, ", and label ", SIMPLE_STRING( label ) );
                
            fi;
            
            res := GetHelpDataRef(info, match[nr][2]);
            res[1] := SubstitutionSublist(res[1], " (not loaded): ", ": ", "one");
            
            if IsOperation( ValueGlobal( name ) ) then
                
                test_string := Concatenation( bookname, ": ", name, " for Is" );
                # needed for GAPDoc < 1.6.5
                test_string_legacy := Concatenation( bookname, ": ", name, " for is" );
                
                if not (StartsWith( res[1], test_string ) or StartsWith( res[1], test_string_legacy )) then
                    
                    Error( res[1], " does not start with ", test_string, ", matching wrong operation?" );
                    
                fi;
                
            else
                
                test_string := Concatenation( bookname, ": ", name );
                
                if not res[1] = test_string then
                    
                    Error( res[1], " is not equal to ", test_string, ", matching wrong function?" );
                    
                fi;
                
            fi;
            
            current_string := ReplacedStringViaRecord(
                "\n# ! * <Ref BookName=\"bookname\" Func=\"operation_name\" Label=\"label\" />", # GAPDoc does not care if we use `Func` or `Oper` for external refs
                rec(
                    bookname := bookname,
                    operation_name := name,
                    label := label,
                )
            );
            output_string := Concatenation( output_string, current_string );
            
        od;
        
        output_string := Concatenation( output_string, "\n" );
        
    od;
    
    # see comments above
    output_string := ReplacedString( output_string, "# !", "#!" );
    
    if not IsExistingFileInPackageForHomalg( package_name, filename ) or output_string <> ReadFileFromPackageForHomalg( package_name, filename ) then
        
        output_path := Filename( DirectoryTemporary( ), filename );
        
        WriteFileForHomalg( output_path, output_string );
        
        Display( Concatenation(
            "WARNING: The file ", filename, " in package ", package_name, " differs from the automatically generated one. ",
            "You can view the automatically generated file at the following path: ",
            output_path
        ) );
        
    fi;
    
end );
