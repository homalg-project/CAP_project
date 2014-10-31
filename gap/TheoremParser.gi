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

InstallGlobalFunction( PARSE_THEOREM_FROM_LATEX,
                       
  function( theorem_string )
    local variable_part, source_part, range_part, range_value, range_command,
          range_predicate, range_variables, position;
    
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
    
    variable_part := List( variable_part, i -> REMOVE_PART_AFTER_FIRST_SUBSTRING( i, ":" ) );
    
    ##Find range part
    
    range_value := SplitString( range_part, "=" );
    
    if Length( range_value ) = 2 then
        
        range_part := NormalizedWhitespace( range_value[ 1 ] );
        
        range_value := CONVERT_STRING_TO_BOOL_OR_INT( range_value[ 2 ] );
        
    elif Length( range_value ) = 1 then
        
        range_value := true;
        
    else
        
        Error( "wrong range format, too many =" );
        
    fi;
    
    range_part := SplitString( range_part, "(" );
    
    range_predicate := range_part[ 1 ];
    
    if Length( range_part ) = 2 then
        
        range_variables := range_part[ 2 ];
        
        range_command := "IMPLICATION";
        
    elif Length( range_part ) = 3 then
        
        range_command := range_part[ 2 ];
        
        range_variables := range_part[ 3 ];
        
    else
        
        Error( "wrong range format" );
        
    fi;
    
    ##Sanitize range variables
    
    position := PositionSublist( range_variables, ")" );
    
    if position = fail then
        
        Error( "some ) should have been found" );
        
    fi;
    
    range_variables := range_variables{[ 1 .. position - 1 ]};
    
    range_variables := SANITIZE_ARGUMENT_LIST( range_variables );
    
    
    
    return [ variable_part, source_part, range_part, range_value ];
    
end );

## PARSE_THEOREM_FROM_LATEX( "A:\Obj ~|~ \IsZero( A ) \vdash \IsProjective( A )" );

