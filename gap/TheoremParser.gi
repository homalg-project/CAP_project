#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

BindGlobal( "SPLIT_STRING_MULTIPLE",
            
  function( string, substring )
    local list, lenght_substring, current_pos;
    
    list := [ ];
    
    lenght_substring := Length( substring );
    
    current_pos := PositionSublist( string, substring );
    
    while true do
        
        current_pos := PositionSublist( string, substring );
        
        if current_pos = fail then
            
            Add( list, string );
            
            break;
            
        fi;
        
        Add( list, string{[ 1 .. current_pos - 1 ]} );
        
        string := string{[ current_pos + lenght_substring .. Length( string ) ]};
        
    od;
    
    return list;
    
end );

BindGlobal( "CONVERT_STRING_TO_BOOL_OR_INT",
            
  function( string )
    
    string := LowercaseString( NormalizedWhitespace( string ) );
    
    if string = "true" then
        
        return true;
        
    elif string = "false" then
        
        return false;
        
    else
        
        return Int( string );
        
    fi;
    
end );

BindGlobal( "SANITIZE_ARGUMENT_LIST",
            
  function( string )
    local list, arg, tmp_list, new_list, position;
    
    NormalizeWhitespace( string );
    
    list := SplitString( string, "," );
    
    ## collect lists
    
    arg := 1;
    
    new_list := [ ];
    
    while arg <= Length( list ) do
        
        position := PositionSublist( list[ arg ], "[" );
        
        if position = fail then
            
            Add( new_list, NormalizedWhitespace( list[ arg ] ) );
            
        else
            
            tmp_list := [ ];
            
            Remove( list[ arg ], position );
            
            position := fail;
            
            while position = fail do
                
                Add( tmp_list, NormalizedWhitespace( list[ arg ] ) );
                
                arg := arg + 1;
                
                position := PositionSublist( list[ arg ], "]" );
                
            od;
            
            Remove( list[ arg ], position );
            
            Add( tmp_list, NormalizedWhitespace( list[ arg ] ) );
            
            Add( new_list, tmp_list );
            
        fi;
        
        arg := arg + 1;
        
    od;
    
    return new_list;
    
end );

BindGlobal( "REMOVE_PART_AFTER_FIRST_SUBSTRING",
            
  function( string, substring )
    local position;
    
    position := PositionSublist( string, substring );
    
    if position = fail then
        
        return string;
        
    else
        
        return string{[ 1 .. position - 1 ]};
        
    fi;
    
end );

BindGlobal( "COUNT_SUBSTRING_APPEARANCE",
            
  function( string, substring )
    
    string := SPLIT_STRING_MULTIPLE( string, substring );
    
    return Length( string ) - 1;
    
end );

BindGlobal( "FIND_PART_WHICH_CONTAINS_FUNCTION",
            
  function( part )
    local nr_substring_close_bracket, return_record, splitted_part, predicate, func, variables, position_equal, value, position_close_bracket;
    
    nr_substring_close_bracket := COUNT_SUBSTRING_APPEARANCE( part, "(" );
    
    if nr_substring_close_bracket < 2 then
        
        return fail;
        
    fi;
    
    if nr_substring_close_bracket > 2 then
        
        part := Concatenation( "this is not a valid part: ", part );
        
        Error( part );
        
    fi;
    
    return_record := rec( );
    
    splitted_part := SplitString( part, "(" );
    
    predicate := NormalizedWhitespace( splitted_part[ 1 ] );
    
    func := NormalizedWhitespace( splitted_part[ 2 ] );
    
    variables := NormalizedWhitespace( splitted_part[ 3 ] );
    
    position_equal := PositionSublist( variables, "=" );
    
    if position_equal <> fail then
        
        variables := SplitString( variables, "=" );
        
        value := variables[ 2 ];
        
        variables := variables[ 1 ];
        
        value := CONVERT_STRING_TO_BOOL_OR_INT( value );
        
    else
        
        value := true;
        
    fi;
    
    position_close_bracket := PositionSublist( variables, ")" );
    
    if position_close_bracket = fail then
        
        Error( "some ) should have been found" );
        
    else
        
        variables := variables{[ 1 .. position_close_bracket - 1 ]};
        
    fi;
    
    return_record!.TheoremPart := rec( Value := value, ValueFunction := ValueGlobal( NormalizedWhitespace( predicate ) ), Object := "result" );
    
    return_record!.Variables := SANITIZE_ARGUMENT_LIST( variables );
    
    return_record!.Function := func;
    
    return return_record;
    
end );

BindGlobal( "FIND_PREDICATE_VARIABLES",
            
  function( source_part, range_variables )
    local split_source_part, func, predicate, variables, source_rec, bound_variable, value,
          position_exists, position_forall, i;
    
    split_source_part := SplitString( source_part, "(" );
    
    if Length( split_source_part ) <> 2 then
        
        Error( "this should not happen, too many (" );
        
    fi;
    
    source_rec := rec( );
    
    ## find bound variables
    predicate := split_source_part[ 1 ];
    
    variables := SplitString( split_source_part[ 2 ], "=" );
    
    if Length( variables ) = 2 then
        
        value := CONVERT_STRING_TO_BOOL_OR_INT( variables[ 2 ] );
        
        variables := variables[ 1 ];
        
    else
        
        value := true;
        
        variables := variables[ 1 ];
        
    fi;
    
    position_forall := PositionSublist( predicate, "forall" );
    
    position_exists := PositionSublist( predicate, "exists" );
    
    if Minimum( [ position_forall, position_exists ] ) <> fail then
        
        predicate := predicate{[ Minimum( [ position_forall, position_exists ] ) + 7 .. Length( predicate ) ]};
        
        predicate := SplitString( predicate, ":" );
        
        bound_variable := predicate[ 1 ];
        
        predicate := predicate[ 2 ];
        
        bound_variable := SPLIT_STRING_MULTIPLE( bound_variable, "in" );
        
        bound_variable := List( bound_variable, NormalizedWhitespace );
        
        bound_variable := Position( range_variables, bound_variable[ 2 ] );
        
        if position_forall <> fail then
            
            bound_variable := [ bound_variable, "all" ];
            
        else
            
            bound_variable := [ bound_variable, "any" ];
            
        fi;
        
    else
        
        predicate := split_source_part[ 1 ];
        
        variables := NormalizedWhitespace( variables{[ 1 .. PositionSublist( variables, ")" ) - 1 ]} );
        
        for i in [ 1 .. Length( range_variables ) ] do
            
            if IsString( range_variables[ i ] ) then
                
                if variables = range_variables[ i ] then
                    
                    bound_variable := i;
                    
                    break;
                    
                fi;
                
            else
                
                bound_variable := Position( range_variables[ i ], variables );
                
                if bound_variable <> fail then
                    
                    bound_variable := [ i, bound_variable ];
                    
                    break;
                    
                else
                    
                    Unbind( bound_variable );
                    
                fi;
                
            fi;
            
        od;
        
        if not IsBound( bound_variable ) then
            
            variables := Concatenation( "variable ", variables, " was not recognized" );
            
        fi;
        
    fi;
    
    return rec( Object := bound_variable, ValueFunction := ValueGlobal( NormalizedWhitespace( predicate ) ), Value := value );
    
end );

InstallGlobalFunction( PARSE_THEOREM_FROM_LATEX,
                       
  function( theorem_string )
    local variable_part, source_part, range_part, range_value, range_command,
          range_predicate, range_variables, position, i, current_source_rec, source_part_split,
          sources_list, int_conversion, theorem_record, result_function_variables, to_be_removed,
          source_part_copy;
    
    source_part := PositionSublist( theorem_string, "~|~" );
    
    if source_part = fail then
        
        Error( "no ~|~ found" );
        
    fi;
    
    range_part := PositionSublist( theorem_string, "vdash" );
    
    if range_part = fail then
        
        Error( "no \vdash found" );
        
    fi;
    
    theorem_string := SPLIT_STRING_MULTIPLE( theorem_string, "~|~" );
    
    theorem_string[ 2 ] := SPLIT_STRING_MULTIPLE( theorem_string[ 2 ], "\vdash" );
    
    variable_part := NormalizedWhitespace( theorem_string[ 1 ] );
    
    source_part := NormalizedWhitespace( theorem_string[ 2 ][ 1 ] );
    
    range_part := NormalizedWhitespace( theorem_string[ 2 ][ 2 ] );
    
    ##Sanitize variables
    
    variable_part := SplitString( variable_part, "," );
    
    variable_part := List( variable_part, i -> SplitString( i, ":" ) );
    
    variable_part := List( variable_part, i -> List( i, j -> NormalizedWhitespace( j ) ) );
    
    ## split source part
    
    source_part_copy := ShallowCopy( source_part );
    
    RemoveCharacters( source_part_copy, " \n\t\r" );
    
    if source_part_copy = "()" then
        
        source_part := [ ];
        
    else
        
        source_part := SplitString( source_part, "," );
        
    fi;
    
    ## find function, and therefore return variables
    ## check range first
    
    theorem_record := FIND_PART_WHICH_CONTAINS_FUNCTION( range_part );
    
    sources_list := [ ];
    
    if theorem_record <> fail then
        ## Range contains the function
        
        theorem_record!.Range := theorem_record!.TheoremPart;
        
        Unbind( theorem_record!.TheoremPart );
        
        result_function_variables := theorem_record!.Variables;
        
        Unbind( theorem_record!.Variables );
        
    else
        
        theorem_record := rec( );
        
    fi;
    
    to_be_removed := [ ];
    
    for i in source_part do
        
        current_source_rec := FIND_PART_WHICH_CONTAINS_FUNCTION( i );
        
        if current_source_rec <> fail then
            
            result_function_variables := current_source_rec!.Variables;
            
            theorem_record!.Function := current_source_rec!.Function;
            
            Add( sources_list, current_source_rec!.TheoremPart );
            
            Add( to_be_removed, i );
            
        fi;
        
    od;
    
    for i in to_be_removed do
        
        Remove( source_part, Position( source_part, i ) );
        
    od;
    
    if not IsBound( theorem_record!.Function ) then
        
        Error( "no function found. This is the wrong parser" );
        
    fi;
    
    if not IsBound( theorem_record!.Range ) then
        
        theorem_record!.Range := FIND_PREDICATE_VARIABLES( range_part, result_function_variables );
        
    fi;
    
    for i in source_part do
        
        Add( sources_list, FIND_PREDICATE_VARIABLES( i, result_function_variables ) );
        
    od;
    
    for i in [ 1 .. Length( result_function_variables ) ] do
        
        if not IsString( result_function_variables[ i ] ) then
            
            continue;
            
        fi;
        
        int_conversion := Int( result_function_variables[ i ] );
        
        if int_conversion = fail then
            
            continue;
            
        fi;
        
        Add( sources_list, rec( Type := "testdirect", Object := i, Value := int_conversion ) );
        
    od;
    
    theorem_record!.Source := sources_list;
    
    return theorem_record;
    
end );

BindGlobal( "RETURN_STRING_BETWEEN_SUBSTRINGS",
            
  function( string, substring_begin, substring_end )
    local substring, rest_of_string, position_begin, position_end;
    
    position_begin := PositionSublist( string, substring_begin );
    
    position_end := PositionSublist( string, substring_end );
    
    if position_begin = fail or position_end = fail then
        
        return fail;
        
    fi;
    
    substring := string{[ position_begin + Length( substring_begin ) .. position_end - 1 ]};
    
    rest_of_string := string{[ position_end + Length( substring_end ) .. Length( string ) ]};
    
    return [ substring, rest_of_string ];
    
end );

BindGlobal( "REMOVE_CHARACTERS_FROM_LATEX",
            
  function( string )
    local i;
    
    for i in [ "&", "\\", "big", "$" ] do
        
        string := Concatenation( SPLIT_STRING_MULTIPLE( string, i ) );
        
    od;
    
    return string;
    
end );

InstallGlobalFunction( "READ_THEOREM_FILE",
                       
  function( filename )
    local stream, file, line, substring, theorem_list, without_align;
    
    if not IsExistingFile( filename ) then
        
        Error( "no file found" );
        
    fi;
    
    stream := IO_File( filename, "r" );
    
    line := IO_ReadLine( stream );
    
    file := "";
    
    while line <> "" do
        
        file := Concatenation( file, line );
        
        line := IO_ReadLine( stream );
        
    od;
    
    IO_Close( stream );
    
    NormalizeWhitespace( file );
    
    file := REMOVE_CHARACTERS_FROM_LATEX( file );
    
    theorem_list := [ ];
    
    while true do
        
        substring := RETURN_STRING_BETWEEN_SUBSTRINGS( file, "begin{sequent}", "end{sequent}" );
        
        if substring = fail then
            
            break;
            
        fi;
        
        file := substring[ 2 ];
        
        without_align := RETURN_STRING_BETWEEN_SUBSTRINGS( substring[ 1 ], "begin{align*}", "end{align*}" );
        
        if without_align = fail then
            
            without_align := substring[ 1 ];
            
        else
            
            without_align := without_align[ 1 ];
            
        fi;
        
        Add( theorem_list, PARSE_THEOREM_FROM_LATEX( without_align ) );
        
    od;
    
    return theorem_list;
    
end );

## PARSE_THEOREM_FROM_LATEX( "A:\Obj ~|~ \IsZero( A ) \vdash \IsProjective( A )" );

