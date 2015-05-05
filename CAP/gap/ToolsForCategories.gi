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
        
        if cache_return = SuPeRfail then
            
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
        
        if cache_return = SuPeRfail then
            
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

#
InstallValue( CAP_INTERNAL_METHOD_IMPLICATION_LIST, [ ] );

BindGlobal( "CAP_INTERNAL_REMOVE_CAN_COMPUTE_STRING",
  
  function( string )
    
    if PositionSublist( string, "CanCompute" ) <> fail then
        
        return string{[ 11 .. Length( string ) ]};
        
    fi;
    
    return string;
    
end );

InstallGlobalFunction( InstallTrueMethodAndStoreImplication,
  
  function( range, source )
    local names_source, names_range, i, remove_can_compute;
    
    InstallTrueMethod( range, source );
    
    names_range := NamesFilter( range );
    
    names_range := Filtered( names_range, i -> PositionSublist( i, "Tester(" ) = fail );
    
    Apply( names_range, CAP_INTERNAL_REMOVE_CAN_COMPUTE_STRING );
    
    names_source := NamesFilter( source );
    
    names_source := Filtered( names_source, i -> PositionSublist( i, "Tester(" ) = fail );
    
    Apply( names_source, CAP_INTERNAL_REMOVE_CAN_COMPUTE_STRING );
    
    Add( CAP_INTERNAL_METHOD_IMPLICATION_LIST, [ names_range, names_source ] );
    
end );

#####################################
##
## Install add
##
#####################################

# InstallAdd( 
# 
#   rec(
#   function_name := "KernelEmb"
#   install_name := "KernelEmb",
#   filter_list := [ "morphism" ],
#   cache_name := "KernelEmb",
#   pre_function := func,
#   redirect_function := func,
#   post_function := func,
#   well_defined_todo := false
#    ),
    
    ## redirect function bauen

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
