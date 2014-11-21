#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

BindGlobal( "STRING_REPRESENTS_INTEGER",
            
  i -> ForAll( i, j -> j in "0123456789" )
  
);

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

BindGlobal( "SPLIT_THEOREM",
            
  function( theorem_string )
    local return_rec;
    
    return_rec := rec( );
    
    theorem_string := SplitString( theorem_string, "|" );
    
    if Length( theorem_string ) <> 2 then
        
        return "no unique | found";
        
    fi;
    
    return_rec!.context := theorem_string[ 1 ];
    
    theorem_string := SPLIT_STRING_MULTIPLE( theorem_string[ 2 ], "vdash" );
    
    if Length( theorem_string ) <> 2 then
        
        return "no unique vdash found";
        
    fi;
    
    return_rec!.source := theorem_string[ 1 ];
    
    return_rec!.range := theorem_string[ 2 ];
    
    return return_rec;
    
end );

BindGlobal( "SPLIT_KOMMAS_NOT_IN_BRACKETS",
            
  function( string )
    local return_list, bracket_count, i, positions;
    
    if Length( string ) = 0 then
        
        return [ ];
        
    fi;
    
    positions := [ 1 ];
    
    bracket_count := 0;
    
    for i in [ 1 .. Length( string ) ] do
        
        if string[ i ] in [ '(', '[' ] then
            
            bracket_count := bracket_count + 1;
            
        elif string[ i ] in [ ')', ']' ] then
            
            bracket_count := bracket_count - 1;
            
        elif bracket_count = 0 and string[ i ] = ',' then
            
            Add( positions, i );
            
        fi;
        
    od;
    
    Add( positions, Length( string ) );
    
    return_list := [ ];
    
    for i in [ 1 .. Length( positions ) - 1 ] do
        
        Add( return_list, string{[ positions[ i ] .. positions[ i + ] ]} );
        
    od;
    
    return return_list;
    
end );

BindGlobal( "COMMAND_AND_ARGUMENTS",
            
  function( command_string )
    local command, arguments, first_pos, i;
    
    i := PositionSublist( command_string, "(" );
    
    if i = fail then
        
        return fail;
        
    fi;
    
    command := command_string{[ 1 .. i - 1 ]};
    
    first_pos := i;
    
    while PositionSublist( command_string, ")", i ) <> fail do
        
        i := PositionSublist( command_string, ")", i );
        
    od;
    
    arguments := command_string{[ first_pos + 1 .. i ]};
    
    return rec( command := command, arguments := arguments );
    
end );

BindGlobal( "FIND_LISTING",
            
  function( string )
    
    NormalizeWhitespace( string );
    
    if string[ 1 ] = '[' and string[ Length( string ) ] = ']' then
        
        return SPLIT_KOMMAS_NOT_IN_BRACKETS( string{[ 2 .. Length( string ) - 1 ]} );
        
    fi;
    
    return fail;
    
end );

InstallGlobalFunction( "SPLIT_SINGLE_PART_RECURSIVE",
                       
  function( single_part )
    local 
    

BindGlobal( "SPLIT_SINGLE_PART",
            
  function( part )
    local return_rec
    
    return_rec := rec( );
    
    part := SplitString( part, ":" );
    
    Perform( part, NormalizedWhitespace );
    
    if Length( part ) = 2 then
        
        return_rec!.bound_variables := part[ 1 ];
        
        part := part[ 2 ];
        
    else
        
        return_rec!.bound_variables := fail;
        
        part := part[ 1 ];
        
    fi;
    
    
    

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
    
    source_part := PositionSublist( theorem_string, "|" );
    
    if source_part = fail then
        
        Error( "no | found" );
        
    fi;
    
    range_part := PositionSublist( theorem_string, "vdash" );
    
    if range_part = fail then
        
        Error( "no \vdash found" );
        
    fi;
    
    theorem_string := SplitString( theorem_string, "|" );
    
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
    
    ## Rebuild Sourcepart, remove brackets
    
    source_part := List( source_part, NormalizedWhitespace );
    
    i := 1;
    
    while i < Length( source_part ) do
        
        if COUNT_SUBSTRING_APPEARANCE( source_part[ i ], "(" ) > COUNT_SUBSTRING_APPEARANCE( source_part[ i ], ")" ) then
            
            source_part[ i ] := Concatenation( source_part[ i ], source_part[ i + 1 ] );
            
            Remove( source_part, [ i + 1 ] );
            
        else
            
            i := i + 1;
            
        fi;
        
    od;
    
    for i in [ 1 .. Length( source_part ) ] do
        
        if source_part[ i ][ 1 ] = '(' then
            
            source_part[ i ] := source_part[ i ]{[ 2 .. Length( source_part[ i ] ) - 1 ]};
            
        fi;
        
    od;
    
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
        
        int_conversion := STRING_REPRESENTS_INTEGER( result_function_variables[ i ] );
        
        if int_conversion = false then
            
            continue;
            
        fi;
        
        Add( sources_list, rec( Type := "testdirect", Object := i, Value := Int( result_function_variables[ i ] ) ) );
        
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
    
    for i in [ "&", "\\", "big", "$", "mathrm", "~" ] do
        
        string := Concatenation( SPLIT_STRING_MULTIPLE( string, i ) );
        
    od;
    
    return string;
    
end );

InstallGlobalFunction( "READ_LOGIC_FILE",
                       
  function( filename, type )
    local stream, file, line, substring, theorem_list, without_align, parser;
    
    if not IsExistingFile( filename ) then
        
        Error( "no file found" );
        
    fi;
    
    if LowercaseString( type ) = "implication" then
        
        parser := PARSE_PREDICATE_IMPLICATION_FROM_LATEX;
        
    elif LowercaseString( type ) = "theorem" then
        
        parser := PARSE_THEOREM_FROM_LATEX;
        
    elif LowercaseString( type ) = "eval_rule" then
        
        parser := PARSE_EVAL_RULE_FROM_LATEX;
        
    else
        
        Error( "wrong parsing type" );
        
    fi;
    
    stream := IO_File( filename, "r" );
    
    line := IO_ReadLine( stream );
    
    file := "";
    
    while line <> "" do
        
        line := REMOVE_PART_AFTER_FIRST_SUBSTRING( line, "%" );
        
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
        
        Add( theorem_list, parser( without_align ) );
        
    od;
    
    return theorem_list;
    
end );

InstallGlobalFunction( READ_THEOREM_FILE,
                       
  function( theorem_file )
    
    return READ_LOGIC_FILE( theorem_file, "theorem" );
    
end );

##############################
##
## True methods
##
##############################

InstallGlobalFunction( "PARSE_PREDICATE_IMPLICATION_FROM_LATEX",
                       
  function( theorem_string )
    local variable_part, source_part, range_part, source_filter, range_filter, i;
    
    variable_part := SplitString( theorem_string, "|" );
    
    source_part := SPLIT_STRING_MULTIPLE( variable_part[ 2 ], "vdash" );
    
    range_part := source_part[ 2 ];
    
    source_part := source_part[ 1 ];
    
    variable_part := variable_part[ 1 ];
    
    variable_part := NormalizedWhitespace( SplitString( variable_part, ":" )[ 2 ] );
    
    source_part := SplitString( source_part, "," );
    
    source_part := List( source_part, i -> NormalizedWhitespace( REMOVE_PART_AFTER_FIRST_SUBSTRING( i, "(" ) ) );
    
    if Length( source_part ) = 0 then
        
        Error( "no source part found" );
        
    fi;
    
    source_filter := ValueGlobal( source_part[ 1 ] );
    
    Remove( source_part, 1 );
    
    for i in source_part do
        
        source_filter := source_filter and ValueGlobal( i );
        
    od;
    
    range_part := NormalizedWhitespace( REMOVE_PART_AFTER_FIRST_SUBSTRING( range_part, "(" ) );
    
    range_part := ValueGlobal( range_part );
    
    return rec( CellType := variable_part, Source := source_filter, Range := range_part );
    
end );

InstallGlobalFunction( READ_PREDICATE_IMPLICATION_FILE,
                       
  function( predicate_file )
    
    return READ_LOGIC_FILE( predicate_file, "implication" );
    
end );

## PARSE_THEOREM_FROM_LATEX( "A:\Obj ~|~ \IsZero( A ) \vdash \IsProjective( A )" );

BindGlobal( "EXTRACT_SINGLE_VARIABLE",
            
  function( list )
    
    if IsList( list ) and Length( list ) = 1 and IsString( list[ 1 ] ) then
        
        return list[ 1 ];
        
    fi;
    
    return list;
    
end );

InstallGlobalFunction( "TOKENIZE_INPUT_JUDGEMENT",
                       
  function( judgement )
    local next_position_komma, next_position_bracket, return_list, current_bracket_nesting, i, new_judgement, j, new_sublist, current_list;
    
    NormalizeWhitespace( judgement );
    
    judgement := SplitString( judgement, "," );
    
    i := 1;
    
    while i <= Length( judgement ) do
        
        current_bracket_nesting := COUNT_SUBSTRING_APPEARANCE( judgement[ i ], "(" ) - COUNT_SUBSTRING_APPEARANCE( judgement[ i ], ")" );
        
        if current_bracket_nesting > 0 then
            
            judgement[ i ] := Concatenation( judgement[ i ], ",", judgement[ i + 1 ] );
            
            Remove( judgement, i + 1 );
            
        else
            
            i := i + 1;
            
        fi;
        
    od;
    
    if Length( judgement ) = 1 then
        
        judgement := judgement[ 1 ];
        
        next_position_bracket := PositionSublist( judgement, "(" );
        
        if next_position_bracket = fail then
            
            return [ judgement ];
            
        fi;
        
        return [ NormalizedWhitespace( judgement{[ 1 .. next_position_bracket - 1 ]} ), TOKENIZE_INPUT_JUDGEMENT( judgement{[ next_position_bracket + 1 .. Length( judgement ) - 1 ]} ) ];
        
    fi;
    
    Apply( judgement, NormalizedWhitespace );
    
    new_judgement := [ ];
    
    current_list := new_judgement;
    
    for i in [ 1 .. Length( judgement ) ] do
        
        if judgement[ i ][ 1 ] = '[' then
            
            Remove( judgement[ i ], 1 );
            
            if judgement[ i ][ Length( judgement[ i ] ) ] = ']' then
                
                Remove( judgement[ i ], Length( judgement[ i ] ) );
                
                Add( current_list, [ EXTRACT_SINGLE_VARIABLE( TOKENIZE_INPUT_JUDGEMENT( judgement[ i ] ) ) ] );
                
            else
                
                current_list := [ ];
                
                Add( current_list, EXTRACT_SINGLE_VARIABLE( TOKENIZE_INPUT_JUDGEMENT( judgement[ i ] ) ) );
                
            fi;
            
        elif judgement[ i ][ Length( judgement[ i ] ) ] = ']' then
            
            Remove( judgement[ i ], Length( judgement[ i ] ) );
            
            Add( current_list, EXTRACT_SINGLE_VARIABLE( TOKENIZE_INPUT_JUDGEMENT( judgement[ i ] ) ) );
            
            Add( new_judgement, current_list );
            
            current_list := new_judgement;
            
        else
            
            Add( current_list, EXTRACT_SINGLE_VARIABLE( TOKENIZE_INPUT_JUDGEMENT( judgement[ i ] ) ));
            
        fi;
        
    od;
    
    return new_judgement;
    
end );

InstallGlobalFunction( SEARCH_FOR_VARIABLE_NAME_APPEARANCE,
            
  function( tree, names )
    local appearance_list, current_result, i, j, name_position, return_list;
    
    ## command_case
    if Length( tree ) = 2 and IsString( tree[ 1 ] ) and Position( names, tree[ 1 ] ) = fail and not STRING_REPRESENTS_INTEGER( tree[ 1 ] ) then
        
        return SEARCH_FOR_VARIABLE_NAME_APPEARANCE( tree[ 2 ], names );
        
    fi;
    
    if IsString( tree ) then
        
        name_position := Position( names, tree );
        
        return_list := List( names, i -> [ ] );
        
        if name_position <> fail then
            
            return_list[ name_position ] := [ [ ] ];
            
        fi;
        
        return return_list;
        
    fi;
    
    if IsList( tree ) and not IsString( tree ) then
        
        return_list := List( names, i -> [ ] );
        
        for i in [ 1 .. Length( tree ) ] do
            
            current_result := SEARCH_FOR_VARIABLE_NAME_APPEARANCE( tree[ i ], names );
            
            for j in [ 1 .. Length( current_result ) ] do
                
                current_result[ j ] := List( current_result[ j ], k -> Concatenation( [ i ], k ) );
                
                return_list[ j ] := Concatenation( current_result[ j ], return_list[ j ] );
                
            od;
            
        od;
        
        return return_list;
        
    fi;
    
    return List( names, i -> [ ] );
    
end );

##
InstallGlobalFunction( REPLACE_VARIABLE,
                       
  function( tree, names, replacements )
    
    if IsString( tree ) and Position( names, tree ) <> fail then
        
        return replacements[ Position( names, tree ) ];
        
    fi;
    
    if IsList( tree ) then
        
        return List( tree, i -> REPLACE_VARIABLE( i, names, replacements ) );
        
    fi;
    
    return tree;
    
end );

InstallGlobalFunction( REPLACE_INTEGER_VARIABLE,
                       
  function( tree )
    local int;

    if IsString( tree ) then
       
       int := STRING_REPRESENTS_INTEGER( tree );
       
       if int = false then
           
           return tree;
           
       else
           
           return Int( tree );
           
       fi;
       
    fi;

    if IsList( tree ) then
       
       return List( tree, REPLACE_INTEGER_VARIABLE );
       
    fi;

    return tree;
    
end );

InstallGlobalFunction( SEARCH_FOR_INT_VARIABLE_APPEARANCE,
            
  function( tree )
    local appearance_list, current_result, i, j, int;
    
    if IsList( tree ) and Length( tree ) = 2 and IsString( tree[ 1 ] ) and IsList( tree[ 2 ] ) and not IsString( tree[ 2 ] ) then
        
        return SEARCH_FOR_INT_VARIABLE_APPEARANCE( tree[ 2 ] );
        
    fi;
    
    if IsList( tree ) then
        
        appearance_list := [ ];
        
        for i in [ 1 .. Length( tree ) ] do
            
            if IsString( tree[ i ] ) then
                
                int := STRING_REPRESENTS_INTEGER( tree[ i ] );
                
                if int <> false then
                    
                    Add( appearance_list, [ [ i ], Int( tree[ i ] ) ] );
                    
                fi;
                
            elif IsList( tree[ i ] ) then
                
                current_result := SEARCH_FOR_INT_VARIABLE_APPEARANCE( tree[ i ] );
                
                for j in current_result do
                    
                    Add( appearance_list, [ Concatenation( [ i ], j[ 1 ] ), j[ 2 ] ] );
                    
                od;
                
            fi;
            
        od;
        
        return appearance_list;
        
    fi;
    
end );

##
InstallGlobalFunction( FIND_COMMAND_POSITIONS,
                       
  function( tree, variable_names )
    local current_command, command_list, i, current_return, j, return_list;
    
    command_list := [ ];
    
    if IsList( tree ) and Length( tree ) = 2 and IsString( tree[ 1 ] ) and IsList( tree[ 2 ] ) and Position( variable_names, tree[ 1 ] ) = fail  then
        
        command_list := [ [ [ ], tree[ 1 ] ] ];
        
        tree := tree[ 2 ];
        
    fi;
    
    if IsList( tree ) then
        
        for i in [ 1 .. Length( tree ) ] do
            
            current_return := FIND_COMMAND_POSITIONS( tree[ i ], variable_names );
            
            for j in current_return do
                
                Add( command_list, [ Concatenation( [ i ], j[ 1 ] ), j[ 2 ] ] );
                
            od;
            
        od;
        
    fi;
    
    return command_list;
    
end );

##
InstallGlobalFunction( PARSE_EVAL_RULE_FROM_LATEX,
                       
  function( rule )
    local variables, source, range, range_left, range_replace, variable_equalities, i, j, variable_position, commands, source_copy,
          variable_names, selected_variable_position, initial_command;
    
    variables := SplitString( rule, "|" );
    
    if Length( variables ) <> 2 then
        
        Error( "no unique | found" );
        
    fi;
    
    variables[ 2 ] := SPLIT_STRING_MULTIPLE( variables[ 2 ], "vdash" );
    
    if Length( variables[ 2 ] ) <> 2 then
        
        Error( "no unique vdash found" );
        
    fi;
    
    source := NormalizedWhitespace( variables[ 2 ][ 1 ] );
    
    source_copy := ShallowCopy( source );
    
    RemoveCharacters( source_copy, " \n\t\r" );
    
    if source_copy = "()" then
        
        source := [ ];
        
    else
        
        source := TOKENIZE_INPUT_JUDGEMENT( source );
        
    fi;
    
    range := variables[ 2 ][ 2 ];
    
    variables := NormalizedWhitespace( variables[ 1 ] );
    
    range := SplitString( range, "=" );
    
    if Length( range ) <> 2 then
        
        Error( "no unique = found" );
        
    fi;
    
    range[ 2 ] := ReplacedString( range[ 2 ], "_{Mor}", "" );
    
    range[ 2 ] := ReplacedString( range[ 2 ], "_{Obj}", "" );
    
    range_left := NormalizedWhitespace( range[ 1 ] );
    
    range_replace := NormalizedWhitespace( range[ 2 ] );
    
    range_replace := NormalizedWhitespace( SplitString( range_replace, ":" )[ 1 ] );
    
    ## Sanitize Variables
    variables := SplitString( variables, "," );
    
    variables := List( variables, i -> SplitString( i, ":" ) );
    
    variables := List( variables, i -> List( i, NormalizedWhitespace ) );
    
    variable_names := List( variables, i -> i[ 1 ] );
    
    range_left := TOKENIZE_INPUT_JUDGEMENT( range_left );
    
    range_replace := TOKENIZE_INPUT_JUDGEMENT( range_replace );
    
    ## Search positions of variables in tree
    
    variable_position := SEARCH_FOR_VARIABLE_NAME_APPEARANCE( range_left, variable_names );
    
    selected_variable_position := List( variable_position, i -> i[ 1 ] );
    
    variable_equalities := [ ];
    
    for i in variable_position do
        
        if Length( i ) > 1 then
            
            for j in [ 2 .. Length( i ) ] do
                
                Add( variable_equalities, [ i[ 1 ], i[ j ] ] );
                
            od;
            
        fi;
        
    od;
    
    variable_equalities := Concatenation( variable_equalities, SEARCH_FOR_INT_VARIABLE_APPEARANCE( range_left ) );
    
    commands := FIND_COMMAND_POSITIONS( range_left, variable_names );
    
    Apply( source, REPLACE_INTEGER_VARIABLE );
    
    range_replace := REPLACE_INTEGER_VARIABLE( range_replace );
    
    Apply( source, j -> REPLACE_VARIABLE( j, variable_names, selected_variable_position ) );
    
    range_replace := REPLACE_VARIABLE( range_replace, variable_names, selected_variable_position );
    
    ## Find initial command
    
    for i in [ 1 .. Length( commands ) ] do
        
        if commands[ i ][ 1 ] = [ ] then
            
            initial_command := commands[ i ][ 2 ];
            
            Remove( commands, i );
            
            break;
            
        fi;
        
    od;
    
    return rec( command := initial_command, commands_to_check := commands, cells_to_check := variable_equalities, part_to_replace := range_replace, part_for_is_well_defined := source );
    
end );

InstallGlobalFunction( READ_EVAL_RULE_FILE,
                       
  function( eval_rule_file )
    
    return READ_LOGIC_FILE( eval_rule_file, "eval_rule" );
    
end );

