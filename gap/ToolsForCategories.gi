#############################################################################
##
##                                               CategoriesForHomalg package
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
        local val, entry, i, filtered_arg;
        
        ## ToDo: This can be improved
        filtered_arg := Filtered( arg, IsHomalgCategoryCell );
        
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
        local cache_return, cache_key, entry, i, filtered_cache_key;
        
        cache_key := arg{[ 1 .. Length( arg ) - 1 ]};
        
        filtered_cache_key := Filtered( cache_key, IsHomalgCategoryCell );
        
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
        local cache, cache_key, cache_return, entry, i, filtered_cache_key;
        
        cache := CachingObject( arg[ cache_number ], name, Length( arg ) - 1 );
        
        cache_key := arg{[ 1 .. Length( arg ) - 1 ]};
        
        filtered_cache_key := Filtered( cache_key, IsHomalgCategoryCell );
        
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
        entry := ToDoListEntryForEqualAttributes( obj, "IsWellDefined", value, "IsWellDefined" );
        
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
        
        input_rec!.Category := CreateHomalgCategory( input_rec!.Category );
        
    elif not IsHomalgCategory( input_rec!.Category ) then
        
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
            
            input_rec!.Filter[ i ] := current_filter[ 2 ] and IsHomalgCategoryObject and ObjectFilter( input_rec!.Category );
            
        elif LowercaseString( current_filter[ 1 ] ) = "morphism" then
            
            input_rec!.Filter[ i ] := current_filter[ 2 ] and IsHomalgCategoryMorphism and MorphismFilter( input_rec!.Category );
            
        elif LowercaseString( current_filter[ 1 ] ) = "twocell" then
            
            input_rec!.Filter[ i ] := current_filter[ 2 ] and IsHomalgCategoryTwoCell and TwoCellFilter( input_rec!.Category );
            
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
