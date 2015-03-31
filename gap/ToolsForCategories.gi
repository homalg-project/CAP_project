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

##
InstallGlobalFunction( AddSpecialMethod,
                       
  function( input_rec )
    local current_filter, i;
    
    ## Sanitize input data
    if not IsBound( input_rec!.Category ) then
        
        Error( "component Category must be given" );
        
    elif IsString( input_rec!.Category ) then
        
        input_rec!.Category := CreateCapCategory( input_rec!.Category );
        
    elif not IsCapCategory( input_rec!.Category ) then
        
        Error( "component Category must be a string or a homalg category" );
        
    fi;
    
    if not IsBound( input_rec!.Name ) then
        
        Error( "component name must be an Attribute/Operation or a string" );
        
    fi;
    
    if IsString( input_rec!.Name ) then
        
        if not IsBound( input_rec!.CacheName ) then
            
            input_rec!.CacheName := input_rec!.Name;
            
        fi;
        
        input_rec!.Name := ValueGlobal( input_rec!.Name );
        
    fi;
    
    if not IsBound( input_rec!.CacheName ) then
        
        input_rec!.CacheName := NameFunction( input_rec!.Name );
        
    fi;
    
    if not IsBound( input_rec!.Filter ) and not IsList( input_rec!.Filter ) then
        
        Error( "component Filter must be a list of tuples" );
        
    fi;
    
    for i in [ 1 .. Length( input_rec!.Filter ) ] do
        
        current_filter := input_rec!.Filter[ i ];
        
        if LowercaseString( current_filter[ 1 ] ) = "object" then
            
            input_rec!.Filter[ i ] := current_filter[ 2 ] and IsCapCategoryObject and ObjectFilter( input_rec!.Category );
            
        elif LowercaseString( current_filter[ 1 ] ) = "morphism" then
            
            input_rec!.Filter[ i ] := current_filter[ 2 ] and IsCapCategoryMorphism and MorphismFilter( input_rec!.Category );
            
        elif LowercaseString( current_filter[ 1 ] ) = "twocell" then
            
            input_rec!.Filter[ i ] := current_filter[ 2 ] and IsCapCategoryTwoCell and TwoCellFilter( input_rec!.Category );
            
        elif LowercaseString( current_filter[ 1 ] ) = "other" then
            
            input_rec!.Filter[ i ] := current_filter[ 2 ];
            
        else
            
            Error( "type of filter must be Object/Morphism/TwoCell/Other" );
            
        fi;
        
    od;
    
    if not IsFunction( input_rec!.Function ) then
        
        Error( "component Function must be a function" );
        
    fi;
    
    if input_rec!.CacheName <> fail then
        
        InstallMethodWithToDoForIsWellDefined( input_rec!.Name,
                                               input_rec!.Filter,
                                               
            input_rec!.Function : InstallMethod := InstallMethodWithCache, Cache := GET_METHOD_CACHE( input_rec!.category, input_rec!.CacheName, Length( input_rec!.Filter ) ) );
        
    else
        
        InstallMethodWithToDoForIsWellDefined( input_rec!.Name,
                                               input_rec!.Filter,
                                               
            input_rec!.Function );
        
    fi;
    
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

##########################################
##
## List methods
##
##########################################

##
InstallGlobalFunction( ListCanComputesOfCategory,
  
  function( object )
    local can_compute, cannot_compute, i;
    
    if not IsCapCategory( object ) and not IsCapCategoryCell( object ) then
        
        Print( "This is not a CAP category or a CAP category cell\n" );
        
        return;
        
    fi;
    
    can_compute := [ ];
    
    cannot_compute := [ ];
    
    for i in CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForAllCategories do
        
        if PositionSublist( i, "WithGiven" ) <> fail then
            
            continue;
            
        fi;
        
        if Tester( ValueGlobal( i ) )( object ) then
            
            Add( can_compute, i );
            
        else
            
            Add( cannot_compute, i );
            
        fi;
        
    od;
    
    Print( "Can do the following basic methods at the moment:\n" );
    
    for i in can_compute do
        Print( "* ", i{[ 11 .. Length( i )]}, "\n" );
    od;
    
    Print( "\nThe following is still missing:\n" );
    
    for i in cannot_compute do
        Print( "* ", i{[ 11 .. Length( i )]}, "\n" );
    od;
    
    Print( "\nPlease use PossibleDerivationsOfMethod( <category>, <name> ) do get\n",
           "information about how to add the missing methods\n" );
    
end );

##
InstallGlobalFunction( PossibleDerivationsOfMethod,
  
  function( category, string )
    local triangle, i, j, possible_implications, current_source, category_property, can_compute_string;
    
    if IsCapCategory( string ) and IsString( category ) then
        
        triangle := string;
        
        string := category;
        
        category := triangle;
        
    fi;
    
    if not IsString( string ) or not IsCapCategory( category ) then
        
        Error( "Usage is <category>,<string>\n" );
        
        return;
        
    fi;
    
    if not IsBoundGlobal( string ) then
        
        Error( Concatenation( string, " is not bound globally." ) );
        
        return;
        
    fi;
    
    can_compute_string := Concatenation( "CanCompute", string );
    
    if Tester( ValueGlobal( can_compute_string ) )( category ) and ValueGlobal( can_compute_string )( category ) then
        
        Print( Name( category ), " can already compute ", string, ".\n\n" );
        
    fi;
    
    possible_implications := Filtered( CAP_INTERNAL_METHOD_IMPLICATION_LIST, i -> ForAny( i[ 1 ], j -> j = string ) );
    
    for i in possible_implications do
        
        current_source := ShallowCopy( i[ 2 ] );
        
        ## Find category implications
        
        category_property := false;
        
        for j in current_source do
            
            if j in CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.MathematicalPropertiesOfCategories then
                
                category_property := j;
                
                Remove( current_source, Position( current_source, category_property ) );
                
                break;
                
            fi;
            
        od;
        
        if category_property = false 
           or ( Tester( ValueGlobal( category_property ) )( category ) and ValueGlobal( category_property )( category ) ) then
            
            Print( "The method ", string, " can be derived by implementing\n" );
            
        elif Tester( ValueGlobal( category_property ) )( category ) = false then
            
            Print( "If ", Name( category ), " would be ", category_property, " then ", string, " could be derived by implementing\n" );
            
        else
            
            continue;
            
        fi;
        
        for j in current_source do
            
            Print( "* ", j );
            
            if Tester( ValueGlobal( Concatenation( "CanCompute", j ) ) )( category ) then
                
                Print( " (already installed)\n" );
                
            else
                
                Print( "\n" );
                
            fi;
            
        od;
        
        Print( "\n" );
        
    od;
    
    if Length( possible_implications ) = 0 then
        
        Print( "No derived methods found.\n\n" );
        
    fi;
    
    if IsBoundGlobal( Concatenation( "Add", string ) ) then
        
        Print( "It is possible to Add this method directly using Add", string, ".\n\n" );
        
    fi;
    
end );

