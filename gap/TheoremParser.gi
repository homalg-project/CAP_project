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
    local variable_part, source_part, range_part;
    
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
    
    
    
    return [ variable_part, source_part, range_part ];
    
end );

## PARSE_THEOREM_FROM_LATEX( "A:\Obj ~|~ \IsZero( A ) \vdash \IsProjective( A )" );

