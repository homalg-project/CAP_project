#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

InstallGlobalFunction( InstallMethodWithToDoForIsWellDefined,
                       
  function( arg )
    local orig_func, new_func, name, install_func;
    
    orig_func := arg[ Length( arg ) ];
    
    name := NameFunction( arg[ 1 ] );
    
    new_func := function( arg )
        local val, entry, i, filtered_arg, list_args;
        
        ## ToDo: This can be improved
        filtered_arg := Filtered( arg, IsCapCategoryCell );
        
        list_args := Flat( Filtered( arg, IsList ) );
        
        list_args := Filtered( list_args, IsCapCategoryCell );
        
        filtered_arg := Concatenation( filtered_arg, list_args );
        
        val := CallFuncList( orig_func, arg );
        
        entry := ToDoListEntry( List( filtered_arg, i -> [ i, "IsWellDefined", true ] ), val, "IsWellDefined", true );
        
        SetDescriptionOfImplication( entry, Concatenation( "Well defined propagation from ", name ) );
        
        AddToToDoList( entry );
        
        for i in filtered_arg do
            
            entry := ToDoListEntry( [ [ i, "IsWellDefined", false ] ], val, "IsWellDefined", false );
            
            SetDescriptionOfImplication( entry, Concatenation( "Well defined propagation from ", name ) );
            
            AddToToDoList( entry );
            
        od;
        
        return val;
        
    end;
    
    arg[ Length( arg ) ] := new_func;
    
    install_func := ValueOption( "InstallMethod" );
    
    if install_func = fail then
        
        install_func := InstallMethod;
        
    fi;
    
    CallFuncList( install_func, arg : InstallMethod := InstallMethod, InstallSet := InstallSetWithToDoForIsWellDefined );
    
end );

##
InstallGlobalFunction( "ToDoForIsWellDefinedWrapper",
  
  function( orig_func )
    local new_func;
    
    new_func := function( arg )
        local val, entry, i, filtered_arg, list_args;
        
        ## ToDo: This can be improved
        filtered_arg := Filtered( arg, IsCapCategoryCell );
        
        list_args := Flat( Filtered( arg, IsList ) );
        
        list_args := Filtered( list_args, IsCapCategoryCell );
        
        filtered_arg := Concatenation( filtered_arg, list_args );
        
        val := CallFuncList( orig_func, arg );
        
        entry := ToDoListEntry( List( filtered_arg, i -> [ i, "IsWellDefined", true ] ), val, "IsWellDefined", true );
        
        SetDescriptionOfImplication( entry, "Well defined propagation" );
        
        AddToToDoList( entry );
        
        for i in filtered_arg do
            
            entry := ToDoListEntry( [ [ i, "IsWellDefined", false ] ], val, "IsWellDefined", false );
            
            SetDescriptionOfImplication( entry, "Well defined propagation" );
            
            AddToToDoList( entry );
            
        od;
        
        return val;
        
    end;
    
    return new_func;
    
end );

##
InstallMethod( InstallSetWithToDoForIsWellDefined,
               [ IsCachingObject, IsString, IsList ],
               
  function( cache, name, filter )
    local set_name, install_func;
    
    set_name := Concatenation( "Set", name );
    
    if not IsBoundGlobal( set_name ) then
        
        DeclareOperation( set_name, Concatenation( filter, [ IsObject ] ) );
        
    fi;
    
    InstallOtherMethod( ValueGlobal( set_name ),
                        Concatenation( filter, [ IsObject ] ),
                        
      function( arg )
        local cache_return, cache_key, entry, i, filtered_cache_key, list_cache_key;
        
        cache_key := arg{[ 1 .. Length( arg ) - 1 ]};
        
        filtered_cache_key := Filtered( cache_key, IsCapCategoryCell );
        
        list_cache_key := Flat( Filtered( cache_key, IsList ) );
        
        list_cache_key := Filtered( list_cache_key, IsCapCategoryCell );
        
        filtered_cache_key := Concatenation( filtered_cache_key, list_cache_key );
        
        cache_return := CacheValue( cache, cache_key );
        
        if cache_return = [ ] then
            
            CallFuncList( SetCacheValue, [ cache, cache_key, arg[ Length( arg ) ] ] );
            
            entry := ToDoListEntry( List( filtered_cache_key, i -> [ i, "IsWellDefined", true ] ), arg[ Length( arg ) ], "IsWellDefined", true );
            
            SetDescriptionOfImplication( entry, Concatenation( "Well defined propagation from ", name ) );
            
            AddToToDoList( entry );
            
            for i in filtered_cache_key do
                
                entry := ToDoListEntry( [ [ i, "IsWellDefined", false ] ], arg[ Length( arg ) ], "IsWellDefined", false );
                
                SetDescriptionOfImplication( entry, Concatenation( "Well defined propagation from ", name ) );
                
                AddToToDoList( entry );
                
            od;
        
        fi;
        
    end );
    
end );

##
InstallMethod( InstallSetWithToDoForIsWellDefined,
               [ IsInt, IsString, IsList ],
               
  function( cache_number, name, filter )
    local set_name;
    
    set_name := Concatenation( "Set", name );
    
    if not IsBoundGlobal( set_name ) then
        
        DeclareOperation( set_name, Concatenation( filter, [ IsObject ] ) );
        
    fi;
    
    InstallOtherMethod( ValueGlobal( set_name ),
                        Concatenation( filter, [ IsObject ] ),
                        
      function( arg )
        local cache, cache_key, cache_return, entry, i, filtered_cache_key, list_cache_key;
        
        cache := CachingObject( arg[ cache_number ], name, Length( arg ) - 1 );
        
        cache_key := arg{[ 1 .. Length( arg ) - 1 ]};
        
        filtered_cache_key := Filtered( cache_key, IsCapCategoryCell );
        
        list_cache_key := Flat( Filtered( cache_key, IsList ) );
        
        list_cache_key := Filtered( list_cache_key, IsCapCategoryCell );
        
        filtered_cache_key := Concatenation( filtered_cache_key, list_cache_key );
        
        cache_return := CacheValue( cache, cache_key );
        
        if cache_return = [ ] then
            
            CallFuncList( SetCacheValue, [ cache, cache_key, arg[ Length( arg ) ] ] );
            
            entry := ToDoListEntry( List( filtered_cache_key, i -> [ i, "IsWellDefined", true ] ), arg[ Length( arg ) ], "IsWellDefined", true );
            
            SetDescriptionOfImplication( entry, Concatenation( "Well defined propagation from ", name ) );
            
            AddToToDoList( entry );
            
            for i in filtered_cache_key do
                
                entry := ToDoListEntry( [ [ i, "IsWellDefined", false ] ], arg[ Length( arg ) ], "IsWellDefined", false );
                
                SetDescriptionOfImplication( entry, Concatenation( "Well defined propagation from ", name ) );
                
                AddToToDoList( entry );
                
            od;
            
        fi;
        
    end );
    
end );

##
InstallMethod( InstallSetWithToDoForIsWellDefined,
               [ IsBool, IsString, IsList ],
               
  function( cache, name, filter )
    local has_name, set_name;
    
    set_name := Concatenation( "Set", name );
    
    if not IsBoundGlobal( set_name ) then
        
        DeclareOperation( set_name,
                          Concatenation( filter, [ IsObject ] ) );
        
    fi;
    
    InstallOtherMethod( ValueGlobal( set_name ),
                        Concatenation( filter, [ IsObject ] ),
                        
      function( arg )
        
        return;
        
    end );
    
end );

##
InstallGlobalFunction( DeclareAttributeWithToDoForIsWellDefined,
                       
  function( arg )
    local name;
    
    name := arg[ 1 ];
    
    CallFuncList( DeclareAttribute, arg );
    
    name := Concatenation( "Set", name );
    
    InstallMethod( ValueGlobal( name ),
                   [ arg[ 2 ], IsObject ],
                   10000, #FIXME: Method rank
                   
      function( obj, value )
        local entry;
        
        # If you set something wrong, it is your fault.
        # FIXME: Is this a good idea?
        entry := ToDoListEntryWithContraposition( obj, "IsWellDefined", true, value, "IsWellDefined", true );
        
        SetDescriptionOfImplication( entry, "Propagation of IsWellDefined" );
        
        AddToToDoList( entry );
        
        TryNextMethod();
        
    end );
    
end );

##########################################
##
## Family property
##
##########################################

InstallGlobalFunction( DeclareFamilyProperty,
                       
  function( arg )
    local name, filter, family, cell_type, reinstall;
    
    if Length( arg ) < 2 or Length( arg ) > 4 then
        
        Error( "usage DeclareFamilyProperty( name, filter[, family, type of cell ] )" );
        
    fi;
    
    name := arg[ 1 ];
    
    filter := arg[ 2 ];
    
    if not IsBound( arg[ 3 ] ) then
        
        family := "general";
        
    elif IsBound( arg[ 3 ] ) and LowercaseString( arg[ 3 ] ) in [ "cell", "object", "morphism", "twocell" ] then
        
        arg[ 4 ] := arg[ 3 ];
        
        family := "general";
        
    else
        
        family := LowercaseString( arg[ 3 ] );
        
    fi;
    
    if Length( arg ) > 3 then
        
        cell_type := LowercaseString( arg[ 4 ] );
        
    else
        
        cell_type := "cell";
        
    fi;
    
    if not cell_type in [ "object", "morphism", "twocell", "cell" ] then
        
        Error( "cell must be object, morphism, twocell, or cell" );
        
    fi;
    
    if not IsBound( CATEGORIES_FAMILY_PROPERTIES.( family ) ) then
        
        CATEGORIES_FAMILY_PROPERTIES.( family ) := rec( );
        
    fi;
    
    if not IsBound( CATEGORIES_FAMILY_PROPERTIES.( family ).( cell_type ) ) then
        
        CATEGORIES_FAMILY_PROPERTIES.( family ).( cell_type ) := [ ];
        
    fi;
    
    reinstall := ValueOption( "reinstall" );
    
    if reinstall <> false then
        
        reinstall := true;
        
    fi;
    
    Add( CATEGORIES_FAMILY_PROPERTIES.( family ).( cell_type ), [ name, reinstall ] );
    
    DeclareProperty( name, filter );
    
end );

#####################################
##
## Install add
##
#####################################

InstallGlobalFunction( CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS,
  
  function( list, category )
      local i, current_entry,  current_filter, j;
      list := ShallowCopy( list );
      
      for i in [ 1 .. Length( list ) ] do
          current_entry := list[ i ];
          
          if IsFilter( current_entry ) then
              continue;
          
          elif IsString( current_entry ) then
              current_entry := LowercaseString( current_entry );
              if current_entry = "category" then
                  list[ i ] := CategoryFilter( category ) and IsCapCategory;
              elif current_entry = "cell" then
                  list[ i ] := CellFilter( category ) and IsCapCategoryCell;
              elif current_entry = "object" then
                  list[ i ] := ObjectFilter( category ) and IsCapCategoryObject;
              elif current_entry = "morphism" then
                  list[ i ] := MorphismFilter( category ) and IsCapCategoryMorphism;
              elif current_entry = "twocell" then
                  list[ i ] := TwoCellFilter( category ) and IsCapCategoryTwoCell;
              elif current_entry = "other_category" then
                  list[ i ] := IsCapCategory;
              elif current_entry = "other_cell" then
                  list[ i ] := IsCapCategoryCell;
              elif current_entry = "other_object" then
                  list[ i ] := IsCapCategoryObject;
              elif current_entry = "other_morphism" then
                  list[ i ] := IsCapCategoryMorphism;
              elif current_entry = "other_twocell" then
                  list[ i ] := IsCapCategoryTwoCell;
              else
                  Error( "filter type is not recognized, must be object, morphism, or twocell" );
              fi;
              
          elif IsList( current_entry ) then
              current_entry := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( current_entry, category );
              current_filter := current_entry[ 1 ];
              for j in current_entry{[ 2 .. Length( current_entry ) ]} do
                  current_filter := current_filter and j;
              od;
              list[ i ] := current_filter;
          fi;
          
      od;
      
      return list;
end );

InstallGlobalFunction( "CAP_INTERNAL_MERGE_FILTER_LISTS",
  
  function( filter_list, additional_filters )
    local i;
    filter_list := ShallowCopy( filter_list );
    
    if not Length( filter_list ) >= Length( additional_filters ) then
        Error( "too many additional filters" );
    fi;
    
    for i in [ 1 .. Length( filter_list ) ] do
        if IsBound( additional_filters[ i ] ) then
            filter_list[ i ] := filter_list[ i ] and additional_filters[ i ];
        fi;
    od;
    
    return filter_list;
end );


InstallGlobalFunction( CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT,
    
  function( option_name, default )
    local value;
    
    value := ValueOption( option_name );
    
    if value = fail then
        return default;
    fi;
    
    return value;
end );

##
BindGlobal( "CAP_INTERNAL_MAKE_LOOP_SYMBOL_LOOK_LIKE_LOOP",
  
  function( function_string, loop_symbol )
    local current_position, current_scan_position, bracket_count;
    
    current_position := PositionSublist( function_string, loop_symbol );
    
    while current_position <> fail do
        
        current_scan_position := current_position + Length( loop_symbol ) + 1;
        
        bracket_count := 1;
        
        while bracket_count <> 0 do
            
            if function_string[ current_scan_position ] = '(' then
                
                bracket_count := bracket_count + 1;
                
            elif function_string[ current_scan_position ] = ')' then
                
                bracket_count := bracket_count - 1;
                
            fi;
            
            current_scan_position := current_scan_position + 1;
            
        od;
        
        function_string := Concatenation( function_string{[ 1 .. current_scan_position - 1 ]}, " od ", function_string{[ current_scan_position .. Length( function_string ) ]} );
        
        current_position := PositionSublist( function_string, loop_symbol, current_position + 1 );
        
    od;
    
    return function_string;
    
end );

BindGlobal( "CAP_INTERNAL_REPLACE_ADDITIONAL_SYMBOL_APPEARANCE",
  
  function( appearance_list, replacement_record )
    local remove_list, new_appearances, current_appearance_nr,
          current_appearance, current_replacement, i;

    remove_list := [];
    new_appearances := [];

    for current_appearance_nr in [ 1 .. Length( appearance_list ) ] do
        
        current_appearance := appearance_list[ current_appearance_nr ];
        
        if IsBound( replacement_record.(current_appearance[ 1 ]) ) then
            Add( remove_list, current_appearance_nr );
            for current_replacement in replacement_record.(current_appearance[ 1 ]) do
                Add( new_appearances, [ current_replacement[ 1 ], current_replacement[ 2 ] * current_appearance[ 2 ] ] );
            od;
        fi;

    od;

    for i in Reversed( remove_list ) do
        Remove( appearance_list, i );
    od;

    return Concatenation( appearance_list, new_appearances );

end );

BindGlobal( "CAP_INTERNAL_VALUE_GLOBAL_OR_VALUE",
  function( val )
    if IsString( val ) then
        return ValueGlobal( val );
    fi;
    return val;
end );

##
InstallGlobalFunction( "CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION",
  
  function( func, symbol_list, loop_multiple, replacement_record )
    local func_as_string, func_stream, i, func_as_list, loop_power, symbol_appearance_rec, current_symbol;
    
    func_as_string := "";
    
    func_stream := OutputTextString( func_as_string, false );
    
    PrintTo( func_stream, func );
    
    CloseStream( func_stream );
    
    ## Make List, Perform, Apply look like loops
    ## Beginning space is important here, to avoid scanning things like CallFuncList
    for i in [ " List(", " Perform(", " Apply(" ] do
        
        func_as_string := CAP_INTERNAL_MAKE_LOOP_SYMBOL_LOOK_LIKE_LOOP( func_as_string, i );
        
    od;
    
    RemoveCharacters( func_as_string, "()[];," );
    
    NormalizeWhitespace( func_as_string );
    
    func_as_list := SplitString( func_as_string, " " );
    
    loop_power := 0;
    
    symbol_appearance_rec := rec( );
    
    symbol_list := Concatenation( symbol_list, RecNames( replacement_record ) );
    
    for current_symbol in func_as_list do
        
        if current_symbol in symbol_list then
            
            if not IsBound( symbol_appearance_rec.( current_symbol ) ) then
                symbol_appearance_rec.( current_symbol ) := 0;
            fi;
            
            symbol_appearance_rec.( current_symbol ) := symbol_appearance_rec.( current_symbol ) + loop_multiple^loop_power;
            
        elif current_symbol in [ "for", "while", "List", "Perform", "Apply" ] then
            loop_power := loop_power + 1;
            
        elif current_symbol = "od" then
            
            loop_power := loop_power - 1;
            
        fi;
        
    od;
    
    symbol_appearance_rec := List( RecNames( symbol_appearance_rec ), i -> [ i, symbol_appearance_rec.(i) ] );
    symbol_appearance_rec := CAP_INTERNAL_REPLACE_ADDITIONAL_SYMBOL_APPEARANCE( symbol_appearance_rec, replacement_record );
    return symbol_appearance_rec;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_MERGE_PRECONDITIONS_LIST,
  
  function( list1, list2 )
    local i, j, append;
    
    for i in list1 do
        
        append := true;
        
        for j in [ 1 .. Length( list2 ) ] do
            
            if list2[ j ][ 1 ] = i[ 1 ] then
                list2[ j ][ 2 ] := Maximum( list2[ j ][ 2 ], i[ 2 ] );
                append := false;
                break;
            fi;
        od;
        
        if append then
            Add( list2, i );
        fi;
        
    od;
    
    return list2;
    
end );

InstallGlobalFunction( CAP_INTERNAL_GET_CORRESPONDING_OUTPUT_OBJECTS,
  
  function( translation_list, function_input )
    local input_list, output_list, current_output, return_list, input_position, list_position, i;
    
    if not Length( translation_list ) = 2 then
        Error( "invalid translation list" );
    fi;
    
    output_list := translation_list[ 2 ];
    
    output_list := List( output_list, i -> SplitString( i, "_" ) );
    
    input_list := translation_list[ 1 ];
    
    return_list := [ ];
    
    for i in [ 1 .. Length( output_list ) ] do
        
        current_output := output_list[ i ];
        
        input_position := Position( input_list, current_output[ 1 ] );
        
        if input_position = fail then
            
            return_list[ i ] := fail;
            
            continue;
            
        fi;
        
        if Length( current_output ) = 1 then
            
           return_list[ i ] := function_input[ input_position ];
           
        elif Length( current_output ) = 2 then
            
            if LowercaseString( current_output[ 2 ] ) = "source" then
                return_list[ i ] := Source( function_input[ input_position ] );
            elif LowercaseString( current_output[ 2 ] ) = "range" then
                return_list[ i ] := Range( function_input[ input_position ] );
            elif Position( input_list, current_output[ 2 ] ) <> fail then
                return_list[ i ] := function_input[ input_position ][ function_input[ Position( input_list, current_output[ 2 ] ) ] ];
            else
                Error( "wrong input type" );
            fi;
            
        elif Length( current_output ) = 3 then
            
            if ForAll( current_output[ 2 ], i -> i in "0123456789" ) then
                list_position := Int( current_output[ 2 ] );
            else
                list_position := Position( input_list, current_output[ 2 ] );
            fi;
            
            if list_position = fail then
                Error( "list index variable not found" );
            fi;
            
            if LowercaseString( current_output[ 3 ] ) = "source" then
                return_list[ i ] := Source( function_input[ input_position ][ list_position ] );
            elif LowercaseString( current_output[ 3 ] ) = "range" then
                return_list[ i ] := Range( function_input[ input_position ][ list_position ] );
            else
                Error( "wrong output syntax" );
            fi;
            
        else
            
            Error( "wrong entry length" );
            
        fi;
        
    od;
    
    return return_list;
    
end );

##
InstallGlobalFunction( ListKnownCategoricalProperties,
                      
  function( category )
    local list, name;
    
    if not IsCapCategory( category ) then
      
      Error( "the input is not a category" );
      
    fi;
    
    list := [ ];
    
    for name in Concatenation( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST ) do
      
      if Tester( ValueGlobal( name ) )( category ) and ValueGlobal( name )( category ) then
        
        Add( list, name );
      
      fi;
      
    od;
    
    return list;
    
end );

InstallGlobalFunction( CAP_MergeRecords,
  function( dst, src )
    local key;
    for key in RecNames( src ) do
        if not IsBound( dst.( key ) ) then
            dst.( key ) := src.( key );
        fi;
    od;
end );

InstallGlobalFunction( HelpForCAP,
  
  function()
    local filename, stream, string;
    
    filename := DirectoriesPackageLibrary( "CAP", "" );
    filename := filename[ 1 ];
    filename := Filename( filename, "help_for_CAP.md" );
    
    stream := InputTextFile( filename );
    string := ReadAll( stream );
    CloseStream( stream );
    
    Print( string );
    
end );

InstallGlobalFunction( CachingStatistic,
  
  function( category, arg... )
    local operations, current_cache_name, current_cache;
    
    operations := arg;
    
    if Length( operations ) = 0 then
        operations := RecNames( category!.caches );
    fi;
    
    operations := ShallowCopy( operations );
    Sort( operations );
    
    Print( "Caching statistics for category ", Name( category ), "\n" );
    Print( "===============================================\n" );
    
    for current_cache_name in operations do
        Print( current_cache_name, ": " );
        if not IsBound( category!.caches.(current_cache_name) ) then
            Print( "not installed yet\n" );
            continue;
        fi;
        current_cache := category!.caches.(current_cache_name);
        if IsDisabledCache( current_cache ) then
            Print( "disabled\n" );
            continue;
        fi;
        if IsWeakCache( current_cache ) then
            Print( "weak cache, " );
        elif IsCrispCache( current_cache ) then
            Print( "crisp cache, " );
        fi;
        Print( "hits: ", String( current_cache!.hit_counter ), ", misses: ", String( current_cache!.miss_counter ), ", " );
        Print( String( Length( PositionsProperty( current_cache!.value, ReturnTrue ) ) ), " objects stored\n" );
    od;
    
end );

## Hack for making CAP work with GAP versions smaller than 4.11
## Fixme: Remove this once we are sure we do not want compatibility
## to GAP < 4.11 anymore.
if not IsBound( SuspendMethodReordering ) then
   BindGlobal( "SuspendMethodReordering", function() end );
fi;

if not IsBound( ResumeMethodReordering ) then
   BindGlobal( "ResumeMethodReordering", function() end );
fi;
