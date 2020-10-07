# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallValue( CAP_INTERNAL_CATEGORY_PROPERTY_RANK_AND_STRING, rec( ) );

BindGlobal( "__CAP_INTERNAL_RANK_CATEGORY_FROM_METHOD_RECORD",
  function( )
    local list_of_names, i, current, caps_positions, name_list, j, return_list, entries, added;
    
    list_of_names := ShallowCopy( RecNames( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD ) );
    
    Remove( list_of_names, Position( list_of_names, "EveryCategory" ) );
    
    name_list := [ ];
    
    for i in list_of_names do
        
        current := ShallowCopy( i );
        
        current := current{[ 3 .. Length( current ) ]};
        
        if EndsWith( current, "Category" ) then
            current := current{[ 1 .. Length( current ) - 8 ]};
        fi;
        
        caps_positions := Filtered( [ 1 .. Length( current ) ], j -> current[ j ] in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
        
        if 1 in caps_positions then
            Remove( caps_positions, Position( caps_positions, 1 ) );
        fi;
        
        current := LowercaseString( current );
        
        for j in Reversed( caps_positions ) do
            current := Concatenation( current{[ 1 .. j - 1 ]}, " ", current{[ j .. Length( current ) ]} );
        od;
        
        Add( name_list, [ i, current ] );
        
    od;
    
    return_list := [ ];
    
    for i in name_list do
        
        entries := CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( i [ 1 ] );
        
        added := false;
        
        for j in return_list do
            
            if ForAll( j, k -> IsSubset( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( k[ 1 ] ), entries )
                            or IsSubset( entries, CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( k[ 1 ] ) ) ) then
                
                Add( j, i );
                added := true;
                break;
                
            fi;
            
        od;
        
        if not added then
            
            Add( return_list, [ i ] );
            
        fi;
        
    od;
    
    for i in return_list do
        Sort( i, function( j, k ) return IsSubset( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( j[ 1 ] ), CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.( k[ 1 ] ) ); end );
    od;
    
    # Some cosmetics for the lists:
    # Write Abel with a capital, its the man ;).
    # Change the order so that the list with Abelian is at the end.
    
    for i in return_list do
        for j in i do
            j[ 2 ] := ReplacedString( j[ 2 ], "abelian", "Abelian" );
        od;
    od;
    
    for i in [ 1 .. Length( return_list ) ] do
        if ForAny( return_list[ i ], j -> j[2] = "Abelian" ) then
            return_list := Concatenation( return_list{[ 1 .. i - 1 ]}, return_list{[ i + 1 .. Length( return_list ) ]}, [ return_list[ i ] ] );
        fi;
    od;
    
    return return_list;
    
end );

CAP_INTERNAL_CATEGORY_PROPERTY_RANK_AND_STRING.sorted_list := __CAP_INTERNAL_RANK_CATEGORY_FROM_METHOD_RECORD();

InstallGlobalFunction( InfoStringOfInstalledOperationsOfCategory,
  
  function( category )
    local prim_operations, derived_operations, adjectives, current_stack, current_property, current_adjective, string;
    
    if not IsCapCategory( category ) then
        Error( "first argument must be a category" );
        return;
    fi;
    
    prim_operations := ListPrimitivelyInstalledOperationsOfCategory( category );
    derived_operations := ListInstalledOperationsOfCategory( category );
    
    prim_operations := Length( prim_operations );
    derived_operations := Length( derived_operations );
    
    adjectives := [ ];
    
    for current_stack in __CAP_INTERNAL_RANK_CATEGORY_FROM_METHOD_RECORD() do
        for current_property in current_stack do
            if Length( CheckConstructivenessOfCategory( category, current_property[ 1 ] ) ) = 0 then
                Add( adjectives, current_property[ 1 ] );
                break;
            fi;
        od;
    od;
    
    string := ShallowCopy( String( prim_operations ) );
    Append( string, " primitive operations were used to derive " );
    Append( string, String( derived_operations ) );
    Append( string, " operations for this category which" );
    for current_adjective in adjectives do
        Append( string, "\n* " );
        Append( string, current_adjective );
    od;
    
    return string;
    
end );

InstallGlobalFunction( InfoOfInstalledOperationsOfCategory,
  
  function( category )

    Display( InfoStringOfInstalledOperationsOfCategory( category ) );
    
end );
