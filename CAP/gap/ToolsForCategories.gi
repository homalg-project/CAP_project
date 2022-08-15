# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
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

InstallGlobalFunction( CAP_INTERNAL_REPLACE_STRING_WITH_FILTER,
  
  function( filter_or_string, args... )
    local category;
    
    if Length( args ) > 1 then
        Error( "CAP_INTERNAL_REPLACE_STRING_WITH_FILTER must be called with at most two arguments" );
    elif Length( args ) = 1 then
        category := args[1];
    else
        category := false;
    fi;
    
    if IsFilter( filter_or_string ) then
        return filter_or_string;
    elif IsString( filter_or_string ) then
        if filter_or_string = "category" then
            if category <> false then
                return CategoryFilter( category ) and IsCapCategory;
            else
                return IsCapCategory;
            fi;
        elif filter_or_string = "cell" then
            if category <> false then
                return CellFilter( category ) and IsCapCategoryCell;
            else
                return IsCapCategoryCell;
            fi;
        elif filter_or_string = "object" then
            if category <> false then
                return ObjectFilter( category ) and IsCapCategoryObject;
            else
                return IsCapCategoryObject;
            fi;
        elif filter_or_string = "morphism" then
            if category <> false then
                return MorphismFilter( category ) and IsCapCategoryMorphism;
            else
                return IsCapCategoryMorphism;
            fi;
        elif filter_or_string = "twocell" then
            if category <> false then
                return TwoCellFilter( category ) and IsCapCategoryTwoCell;
            else
                return IsCapCategoryTwoCell;
            fi;
        elif filter_or_string = "object_in_range_category_of_homomorphism_structure" then
            
            if category <> false and not HasRangeCategoryOfHomomorphismStructure( category ) then
                
                Display( Concatenation( "WARNING: You are calling an Add function for a CAP operation for \"", Name( category ), "\" which is part of a homomorphism structure but the category has no RangeCategoryOfHomomorphismStructure (yet)" ) );
                
            fi;
            
            if category <> false and HasRangeCategoryOfHomomorphismStructure( category ) then
                # FIXME: We would like to include the object filter of the range category here, but this does not allow to change the range category later on:
                # When changing the range category, primitive operations are correctly installed using the new range category,
                # but derivations which have already been triggered will not be re-installed and thus still use the old range category.
                #return ObjectFilter( RangeCategoryOfHomomorphismStructure( category ) ) and IsCapCategoryObject;
                return IsCapCategoryObject;
            else
                return IsCapCategoryObject;
            fi;
        elif filter_or_string = "morphism_in_range_category_of_homomorphism_structure" then
            
            if category <> false and not HasRangeCategoryOfHomomorphismStructure( category ) then
                
                Display( Concatenation( "WARNING: You are calling an Add function for a CAP operation for \"", Name( category ), "\" which is part of a homomorphism structure but the category has no RangeCategoryOfHomomorphismStructure (yet)" ) );
                
            fi;
            
            if category <> false and HasRangeCategoryOfHomomorphismStructure( category ) then
                # FIXME: see above
                #return MorphismFilter( RangeCategoryOfHomomorphismStructure( category ) ) and IsCapCategoryMorphism;
                return IsCapCategoryMorphism;
            else
                return IsCapCategoryMorphism;
            fi;
        elif filter_or_string = "other_category" then
            return IsCapCategory;
        elif filter_or_string = "other_cell" then
            return IsCapCategoryCell;
        elif filter_or_string = "other_object" then
            return IsCapCategoryObject;
        elif filter_or_string = "other_morphism" then
            return IsCapCategoryMorphism;
        elif filter_or_string = "other_twocell" then
            return IsCapCategoryTwoCell;
        elif filter_or_string = "list_of_objects" then
            return IsList;
        elif filter_or_string = "list_of_morphisms" then
            return IsList;
        elif filter_or_string = "list_of_twocells" then
            return IsList;
        elif filter_or_string = "nonneg_integer_or_infinity" then
            return IsCyclotomic;
        else
            Error( "filter type ", filter_or_string, " is not recognized, see the documentation for allowed values" );
        fi;
        
    else
        
        Error( "the first argument must be a string or filter" );
        
    fi;
    
end );

InstallGlobalFunction( CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS,
  
  function( list, args... )
      local category;
      
      if Length( args ) > 1 then
          Error( "CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS must be called with at most two arguments" );
      elif Length( args ) = 1 then
          category := args[1];
      else
          category := false;
      fi;
      
      return List( list, l -> CAP_INTERNAL_REPLACE_STRING_WITH_FILTER( l, category ) );
      
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
    
    if IsOperation( func ) then
        
        func_as_string := NameFunction( func );
        
    else
        
        func_as_string := "";
        
        func_stream := OutputTextString( func_as_string, false );
        
        SetPrintFormattingStatus( func_stream, false );
        
        PrintTo( func_stream, func );
        
        CloseStream( func_stream );
        
    fi;
    
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
                if list_position = fail then
                    Error( "unable to find ", current_output[ 2 ], " in input_list" );
                fi;
                list_position := function_input[ list_position ];
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
    
    for name in Set( Filtered( Concatenation( CAP_INTERNAL_CATEGORICAL_PROPERTIES_LIST ), x -> x <> fail ) ) do
      
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

InstallGlobalFunction( InstallDeprecatedAlias,
  
  function( alias_name, function_name, deprecation_date )
    
    BindGlobal( alias_name, function ( args... )
      local result;
        
        Print(
          Concatenation(
          "WARNING: ", alias_name, " is deprecated and will not be supported after ", deprecation_date, ". Please use ", function_name, " instead.\n"
          )
        );
        
        result := CallFuncListWrap( ValueGlobal( function_name ), args );
        
        if not IsEmpty( result ) then
            
            return result[1];
            
        fi;
        
    end );
    
end );

##
InstallGlobalFunction( "IsSpecializationOfFilter", function ( filter1, filter2 )
    
    filter1 := CAP_INTERNAL_REPLACE_STRING_WITH_FILTER( filter1 );
    filter2 := CAP_INTERNAL_REPLACE_STRING_WITH_FILTER( filter2 );
    
    return IS_SUBSET_FLAGS( WITH_IMPS_FLAGS( FLAGS_FILTER( filter2 ) ), WITH_IMPS_FLAGS( FLAGS_FILTER( filter1 ) ) );
    
end );

##
InstallGlobalFunction( "IsSpecializationOfFilterList", function ( filter_list1, filter_list2 )
    
    if filter_list1 = "any" then
        
        return true;
        
    elif filter_list2 = "any" then
        
        return false;
        
    fi;
    
    return Length( filter_list1 ) = Length( filter_list2 ) and ForAll( [ 1 .. Length( filter_list1 ) ], i -> IsSpecializationOfFilter( filter_list1[i], filter_list2[i] ) );
    
end );

##
InstallGlobalFunction( InstallMethodForCompilerForCAP,
  
  function( args... )
    local operation, method, filters;
    
    # let InstallMethod do the type checking
    CallFuncList( InstallMethod, args );
    
    operation := First( args );
    method := Last( args );
    
    if IsList( args[Length( args ) - 1] ) then
        
        filters := args[Length( args ) - 1];
        
    elif IsList( args[Length( args ) - 2] ) then
        
        filters := args[Length( args ) - 2];
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "this should never happen" );
        
    fi;
    
    CapJitAddKnownMethod( operation, filters, method );
    
end );

##
InstallGlobalFunction( InstallOtherMethodForCompilerForCAP,
  
  function( args... )
    local operation, method, filters;
    
    # let InstallOtherMethod do the type checking
    CallFuncList( InstallOtherMethod, args );
    
    operation := First( args );
    method := Last( args );
    
    if IsList( args[Length( args ) - 1] ) then
        
        filters := args[Length( args ) - 1];
        
    elif IsList( args[Length( args ) - 2] ) then
        
        filters := args[Length( args ) - 2];
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "this should never happen" );
        
    fi;
    
    CapJitAddKnownMethod( operation, filters, method );
    
end );

##
BindGlobal( "CAP_JIT_INTERNAL_KNOWN_METHODS", rec( ) );

InstallGlobalFunction( CapJitAddKnownMethod,
  
  function( operation, filters, method )
    local operation_name, wrapper_operation_name, known_methods;
    
    if not IsOperation( operation ) or not IsList( filters ) or not IsFunction( method ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "usage: CapJitAddKnownMethod( <operation>, <list of filters>, <method> )" );
        
    fi;
    
    if IsEmpty( filters ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "there must be at least one filter" );
        
    fi;
    
    if not IsSpecializationOfFilter( IsCapCategory, filters[1] ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the first filter must imply IsCapCategory" );
        
    fi;
    
    operation_name := NameFunction( operation );
    
    if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name) ) and Length( filters ) = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( operation_name, " is already installed as a CAP operation with the same number of arguments" );
        
    fi;
    
    # check if we deal with a KeyDependentOperation
    if EndsWith( operation_name, "Op" ) then
        
        wrapper_operation_name := operation_name{[ 1 .. Length( operation_name ) - 2 ]};
        
        if IsBoundGlobal( wrapper_operation_name ) and ValueGlobal( wrapper_operation_name ) in WRAPPER_OPERATIONS then
            
            operation_name := wrapper_operation_name;
            
        fi;
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name) ) then
        
        CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name) := [ ];
        
    fi;
    
    known_methods := CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name);
    
    if ForAny( known_methods, m -> Length( m.filters ) = Length( filters ) and ( IsSpecializationOfFilter( m.filters[1], filters[1] ) or IsSpecializationOfFilter( filters[1], m.filters[1] ) ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "there is already a method known for ", operation_name, " with a category filter which implies the current category filter or is impled by it" );
        
    fi;
    
    Add( known_methods, rec( filters := filters, method := method ) );
    
end );

##
BindGlobal( "CAP_JIT_INTERNAL_TYPE_SIGNATURES", rec( ) );

InstallGlobalFunction( "CapJitAddTypeSignature", function ( name, input_filters, output_data_type )
    
    if IsCategory( ValueGlobal( name ) ) and Length( input_filters ) = 1 then
        
        Error( "adding type signatures for GAP categories applied to a single argument is not supported" );
        
    fi;
    
    if input_filters <> "any" then
        
        if not IsList( input_filters ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<input_filters> must be a list or the string \"any\"" );
            
        fi;
        
        if not ForAll( input_filters, filter -> IsFilter( filter ) ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<input_filters> must be a list of filters or the string \"any\"" );
            
        fi;
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name) ) then
        
        CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name) := [ ];
        
    fi;
    
    if ForAny( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name), signature -> IsSpecializationOfFilterList( signature[1], input_filters ) or IsSpecializationOfFilterList( input_filters, signature[1] ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "there already exists a signature for ", name, " with filters implying the current filters or being implied by them" );
        
    fi;
    
    if not ForAny( [ IsFilter, IsRecord, IsFunction ], f -> f( output_data_type ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<output_data_type> must be a filter, a record, or a function" );
        
    fi;
    
    if IsFilter( output_data_type ) then
        
        output_data_type := rec( filter := output_data_type );
        
    fi;
    
    Add( CAP_JIT_INTERNAL_TYPE_SIGNATURES.(name), [ input_filters, output_data_type ] );
    
end );

##
BindGlobal( "CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED", rec( ) );

InstallGlobalFunction( "CapJitAddTypeSignatureDeferred", function ( package_name, name, input_filters, output_data_type )
    
    if input_filters <> "any" then
        
        if not IsList( input_filters ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<input_filters> must be a list or the string \"any\"" );
            
        fi;
        
        if not ForAll( input_filters, filter -> IsString( filter ) ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "<input_filters> must be a list of strings or the string \"any\"" );
            
        fi;
        
    fi;
    
    if not IsString( output_data_type ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<output_data_type> must be a string" );
        
    fi;
    
    if not IsBound( CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED.(package_name) ) then
        
        CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED.(package_name) := [ ];
        
    fi;
    
    Add( CAP_JIT_INTERNAL_TYPE_SIGNATURES_DEFERRED.(package_name), [ name, input_filters, output_data_type ] );
    
end );

##
InstallGlobalFunction( CapJitDataTypeOfCategory, function ( cat )
  local type;
    
    if not IsBound( cat!.compiler_hints ) or not IsBound( cat!.compiler_hints.category_filter ) then
        
        Print( "WARNING: The category with name \"", Name( cat ), "\" has no component `cat!.compiler_hints.category_filter`. Using `IsCapCategory` instead.\n" );
        
        type := rec(
            filter := IsCapCategory,
            category := cat,
        );
        
    else
        
        type := rec(
            filter := cat!.compiler_hints.category_filter,
            category := cat,
        );
        
    fi;
    
    if not IsSpecializationOfFilter( IsCapCategory, type.filter ) then
        
        Print( "WARNING: filter ", type.filter, " does not imply `IsCapCategory`. This will probably cause errors.\n" );
        
    fi;
    
    return type;
    
end );

##
InstallGlobalFunction( CapJitDataTypeOfObjectOfCategory, function ( cat )
  local type;
    
    if not IsBound( cat!.compiler_hints ) or not IsBound( cat!.compiler_hints.object_filter ) then
        
        Print( "WARNING: The category with name \"", Name( cat ), "\" has no component `cat!.compiler_hints.object_filter`. Using the object representation instead.\n" );
        
        if not IsBound( cat!.object_representation ) then
            
            Print( "WARNING: The category with name \"", Name( cat ), "\" has no component `cat!.object_representation`. Using `IsCapCategoryObject` instead.\n" );
            
            type := rec(
                filter := IsCapCategoryObject,
                category := cat,
            );
            
        else
            
            type := rec(
                filter := cat!.object_representation,
                category := cat,
            );
            
        fi;
        
    else
        
        type := rec(
            filter := cat!.compiler_hints.object_filter,
            category := cat,
        );
        
    fi;
    
    if not IsSpecializationOfFilter( IsCapCategoryObject, type.filter ) then
        
        Print( "WARNING: filter ", type.filter, " does not imply `IsCapCategoryObject`. This will probably cause errors.\n" );
        
    fi;
    
    return type;
    
end );

##
InstallGlobalFunction( CapJitDataTypeOfMorphismOfCategory, function ( cat )
  local type;
    
    if not IsBound( cat!.compiler_hints ) or not IsBound( cat!.compiler_hints.morphism_filter ) then
        
        Print( "WARNING: The category with name \"", Name( cat ), "\" has no component `cat!.compiler_hints.morphism_filter`. Using the morphism representation instead.\n" );
        
        if not IsBound( cat!.morphism_representation ) then
            
            Print( "WARNING: The category with name \"", Name( cat ), "\" has no component `cat!.morphism_representation`. Using `IsCapCategoryMorphism` instead.\n" );
            
            type := rec(
                filter := IsCapCategoryMorphism,
                category := cat,
            );
            
        else
            
            type := rec(
                filter := cat!.morphism_representation,
                category := cat,
            );
            
        fi;
        
    else
        
        type := rec(
            filter := cat!.compiler_hints.morphism_filter,
            category := cat,
        );
        
    fi;
    
    if not IsSpecializationOfFilter( IsCapCategoryMorphism, type.filter ) then
        
        Print( "WARNING: filter ", type.filter, " does not imply `IsCapCategoryMorphism`. This will probably cause errors.\n" );
        
    fi;
    
    return type;
    
end );

##
InstallGlobalFunction( CapFixpoint, function ( predicate, func, initial_value )
  local x, y;
    
    y := initial_value;
    
    repeat
        x := y;
        y := func( x );
    until predicate( x, y );
    
    return y;
    
end );

##
InstallGlobalFunction( TransitivelyNeededOtherPackages, function ( package_name )
  local collected_dependencies, package_info, dep, p;
    
    collected_dependencies := [ package_name ];
    
    for dep in collected_dependencies do
        
        package_info := First( PackageInfo( dep ) );
        
        if package_info = fail then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( dep, " is not the name of an available package" );
            
        fi;
        
        for p in package_info.Dependencies.NeededOtherPackages do
            
            if not p[1] in collected_dependencies then
                
                Add( collected_dependencies, p[1] );
                
            fi;
            
        od;
        
    od;
    
    return collected_dependencies;
    
end );

##
InstallMethod( SafePosition,
               [ IsList, IsObject ],
               
  function( list, obj )
    local pos;
    
    pos := Position( list, obj );
    
    Assert( 0, pos <> fail );
    
    return pos;
    
end );

##
InstallGlobalFunction( NTuple, function ( n, args... )
    
    Assert( 0, Length( args ) = n );
    
    return args;
    
end );

##
InstallGlobalFunction( Pair, function ( first, second )
    #% CAP_JIT_RESOLVE_FUNCTION
    
    return NTuple( 2, first, second );
    
end );

##
InstallGlobalFunction( Triple, function ( first, second, third )
    #% CAP_JIT_RESOLVE_FUNCTION
    
    return NTuple( 3, first, second, third );
    
end );

##
InstallGlobalFunction( HandlePrecompiledTowers, function ( category, underlying_category, constructor_name )
  local precompiled_towers, remaining_constructors_in_tower, precompiled_functions_adder, info;
    
    if not IsBound( underlying_category!.compiler_hints ) or not IsBound( underlying_category!.compiler_hints.precompiled_towers ) then
        
        return;
        
    fi;
    
    if not IsList( underlying_category!.compiler_hints.precompiled_towers ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "`underlying_category!.compiler_hints.precompiled_towers` must be a list" );
        
    fi;
    
    precompiled_towers := [ ];
    
    for info in underlying_category!.compiler_hints.precompiled_towers do
        
        if not (IsRecord( info ) and IsBound( info.remaining_constructors_in_tower ) and IsBound( info.precompiled_functions_adder )) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "the entries of `underlying_category!.compiler_hints.precompiled_towers` must be records with components `remaining_constructors_in_tower` and `precompiled_functions_adder`" );
            
        fi;
        
        remaining_constructors_in_tower := info.remaining_constructors_in_tower;
        precompiled_functions_adder := info.precompiled_functions_adder;
        
        if not IsList( remaining_constructors_in_tower ) or IsEmpty( remaining_constructors_in_tower ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "`remaining_constructors_in_tower` must be a non-empty list" );
            
        fi;
        
        if not IsFunction( precompiled_functions_adder ) or NumberArgumentsFunction( precompiled_functions_adder ) <> 1 then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "`precompiled_functions_adder` must be a function accepting a single argument" );
            
        fi;
        
        if remaining_constructors_in_tower[1] = constructor_name then
            
            if Length( remaining_constructors_in_tower ) = 1 then
                
                if ValueOption( "no_precompiled_code" ) <> true then
                    
                    # add precompiled functions
                    CallFuncList( precompiled_functions_adder, [ category ] );
                    
                fi;
                
            else
                
                # pass information on to the next level
                Add( precompiled_towers, rec(
                    remaining_constructors_in_tower := remaining_constructors_in_tower{[ 2 .. Length( remaining_constructors_in_tower ) ]},
                    precompiled_functions_adder := precompiled_functions_adder,
                ) );
                
            fi;
            
        fi;
        
    od;
    
    if not IsEmpty( precompiled_towers ) then
        
        if not IsBound( category!.compiler_hints ) then
            
            category!.compiler_hints := rec( );
            
        fi;
        
        if not IsBound( category!.compiler_hints.precompiled_towers ) then
            
            category!.compiler_hints.precompiled_towers := [ ];
            
        fi;
        
        category!.compiler_hints.precompiled_towers := Concatenation( category!.compiler_hints.precompiled_towers, precompiled_towers );
        
    fi;
    
end );
