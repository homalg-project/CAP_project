#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################


InstallGlobalFunction( CapInternalInstallAdd,
  
  function( record )
    local function_name, install_name, add_name, can_compute_name, pre_function,
          redirect_function, post_function, filter_list, well_defined_todo, caching,
          cache_name, nr_arguments, argument_list;
    
    function_name := record.function_name;
    
    if not IsBound( record.installation_name ) then
        
        install_name := function_name;
        
    else
        
        install_name := record.installation_name;
        
    fi;
    
    add_name := Concatenation( "Add", function_name );
    
    can_compute_name := Concatenation( "CanCompute", function_name );
    
    if IsBound( record.pre_function ) then
        pre_function := record.pre_function;
    else
        pre_function := function( arg ) return [ true ]; end;
    fi;
    
    if IsBound( record.redirect_function ) then
        redirect_function := record.redirect_function;
    else
        redirect_function := function( arg ) return [ false ]; end;
    fi;
    
    if IsBound( record.post_function ) then
        post_function := record.post_function;
    else
        post_function := ReturnTrue;
    fi;
    
    filter_list := record.filter_list;
    
    if IsBound( record.well_defined_todo ) then
        well_defined_todo := record.well_defined_todo;
    else
        well_defined_todo := true;
    fi;
    
    if IsBound( record.cache_name ) then
        caching := true;
        cache_name := record.cache_name;
        nr_arguments := Length( filter_list );
    else
        caching := false;
    fi;
    
    if IsBound( record.argument_list ) then
        argument_list := record.argument_list;
    else
        argument_list := [ 1 .. Length( filter_list ) ];
    fi;
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsFunction ],
                   
      function( category, func )
        
        ValueGlobal( add_name )( category, [ [ func, [ ] ] ], 100 );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsFunction, IsInt ],
                   
      function( category, func, weight )
        
        ValueGlobal( add_name )( category, [ [ func, [ ] ] ], weight );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsList, IsInt ],
      
      function( category, method_list, weight )
        local install_func, replaced_filter_list, install_method, popper, i, set_primitive;
        
        set_primitive := ValueOption( "SetPrimitive" );
        if set_primitive <> false then
            set_primitive := true;
        fi;
        
        replaced_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( filter_list, category );
        
        Setter( ValueGlobal( can_compute_name ) )( category, true );
        
        if well_defined_todo = true and caching = true then
            install_method := InstallMethodWithToDoForIsWellDefined;
            PushOptions( rec( InstallMethod := InstallMethodWithCache,
                              Cache := GET_METHOD_CACHE( category, cache_name, nr_arguments ) ) );
            popper := true;
        elif well_defined_todo = false and caching = true then
            install_method := InstallMethodWithCache;
            PushOptions( rec( Cache := GET_METHOD_CACHE( category, cache_name, nr_arguments )  ) );
            popper := true;
        elif well_defined_todo = true and caching = false then
            install_method := InstallMethodWithToDoForIsWellDefined;
            popper := false;
        else
            install_method := InstallMethod;
            popper := false;
        fi;
        
        install_func := function( func_to_install, filter_list )
          local new_filter_list;
            
            new_filter_list := CAP_INTERNAL_MERGE_FILTER_LISTS( replaced_filter_list, filter_list );
            
            install_method( ValueGlobal( install_name ),
                            new_filter_list,
                            
              function( arg )
                local pre_func_return, redirect_return, result, post_func_arguments;
                
                redirect_return := CallFuncList( redirect_function, arg );
                if redirect_return[ 1 ] = true then
                    return redirect_return[ 2 ];
                fi;
                
                pre_func_return := CallFuncList( pre_function, arg );
                if pre_func_return[ 1 ] = false then
                    Error( pre_func_return[ 2 ] );
                fi;
                
                result := CallFuncList( func_to_install, arg{ argument_list } );
                
                ## Fixme: Maybe create a different add/simply check if it is a bool
                ##        Such stuff will ultimately slow down the methods :(
                if IsCapCategoryCell( result ) then
                    Add( category, result );
                fi;
                
                Add( arg, result );
                CallFuncList( post_function, arg );
                
                return result;
            end );
            
        end;
        
        for i in method_list do
            install_func( i[ 1 ], i[ 2 ] );
        od;
        
        ## The following commands do NOT commute.
        if popper then
            PopOptions();
        fi;
        
        if set_primitive then
            AddPrimitiveOperation( category!.derivations_weight_list, function_name, weight );
        fi;
        
    end );
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_REDIRECTION",
  
  function( with_given_name, object_name, has_arguments, with_given_arguments )
    local return_func, has_name, has_function, object_function, with_given_name_function;
    
    has_name := Concatenation( "Has", object_name );
    
    has_function := ValueGlobal( has_name );
    
    object_function := ValueGlobal( object_name );
    
    with_given_name_function := ValueGlobal( with_given_name );
    
    return function( arg )
        local has_arg_list, has_return;
        
        has_arg_list := arg{ has_arguments };
        
        has_return := CallFuncList( has_function, has_arg_list );
        
        if has_return = false then
            
            return [ false ];
            
        fi;
        
        return [ true, CallFuncList( with_given_name_function, Concatenation( arg{ with_given_arguments }, [ CallFuncList( object_function, has_arg_list ) ] ) ) ];
        
    end;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_POST_FUNCTION",
  
  function( source_range_object, object_function_name, object_function_argument_list, object_call_name )
    local object_getter, set_object, was_created_filter, diagram_name, setter_function;
    
    if source_range_object = "Source" then
        object_getter := Source;
        set_object := true;
    elif source_range_object = "Range" then
        object_getter := Range;
        set_object := true;
    else
        object_getter := IdFunc;
        set_object := false;
    fi;
    
    was_created_filter := ValueGlobal( Concatenation( "WasCreatedAs", object_call_name ) );
    diagram_name := Concatenation( object_call_name, "Diagram" );
    setter_function := ValueGlobal( Concatenation( "Set", object_function_name ) );
    
    return function( arg )
        local result, object;
        
        result := arg[ Length( arg ) ];
        Remove( arg );
        object := object_getter( result );
        
        if set_object then
            CallFuncList( setter_function, Concatenation( arg{ object_function_argument_list }, [ object ] ) );
        fi;
        
        ## Those two commands are not commutative
        AddToGenesis( object, diagram_name, arg[ 1 ] );
        SetFilterObj( object, was_created_filter );
        
    end;
    
end );

InstallGlobalFunction( CAP_INTERNAL_INSTALL_ALL_ADDS,
    
  function( )
    local recnames, current_recname, current_rec, arg_list, i, with_given_name, with_given_name_length,
          object_name, object_func;
    
    recnames := RecNames( CAP_INTERNAL_METHOD_NAME_RECORD );
    
    for current_recname in recnames do
        
        current_rec := ShallowCopy( CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ) );
        
        if IsBound( current_rec.no_install ) and current_rec.no_install = true then
            
            continue;
            
        fi;
        
        current_rec.function_name := current_recname;
        
        if PositionSublist( current_recname, "WithGiven" ) <> fail or not IsBound( current_rec.universal_type ) then
            
            CapInternalInstallAdd( current_rec );
            
            continue;
            
        fi;
        
        if current_rec.filter_list[ 1 ] = IsList then
            
            arg_list := [ 1, Length( current_rec.filter_list ) ];
            
        else
            
            arg_list := [ 1 ];
            
        fi;
        
        if Length( current_rec.filter_list ) > 1 and
           ForAll( [ 1 .. Length( current_rec.filter_list ) - 1 ], i -> current_rec.filter_list[ i ] = IsInt or current_rec.filter_list[ i ] = IsList ) then
            current_rec.argument_list := [ 1 .. Length( current_rec.filter_list ) - 1 ];
        else
            current_rec.argument_list := [ 1 .. Length( current_rec.filter_list ) ];
        fi;
        
        if IsBound( current_rec.universal_type ) and not IsBound( current_rec.universal_object_position ) then
            
            current_rec.post_function := CAP_INTERNAL_CREATE_POST_FUNCTION( "id", current_rec.installation_name, arg_list, current_recname ); ##Please note that the third argument is not used
            
            CapInternalInstallAdd( current_rec );
            
            continue;
            
        fi;
        
        if IsBound( current_rec.universal_object_position ) then
            
            ## find with given name
            
            with_given_name := Concatenation( current_recname, "WithGiven" );
            
            with_given_name_length := Length( with_given_name );
            
            for i in recnames do
                
                if PositionSublist( i, with_given_name ) <> fail then
                    
                    with_given_name := i;
                    
                    break;
                    
                fi;
                
            od;
            
            if Length( with_given_name ) = with_given_name_length then
                
                Error( Concatenation( "Name not found: ", with_given_name ) );
                
            fi;
            
            object_name := with_given_name{[ with_given_name_length + 1 .. Length( with_given_name ) ]};
            
            object_func := CAP_INTERNAL_METHOD_NAME_RECORD.( object_name ).installation_name;
            
            current_rec.redirect_function := CAP_INTERNAL_CREATE_REDIRECTION( with_given_name, object_func, arg_list, current_rec.argument_list );
            
            current_rec.post_function := CAP_INTERNAL_CREATE_POST_FUNCTION( current_rec.universal_object_position, object_func, arg_list, object_name );
            
            CapInternalInstallAdd( current_rec );
            
            continue;
            
        fi;
        
    od;
    
end );

CAP_INTERNAL_INSTALL_ALL_ADDS();

## special cases
CapInternalInstallAdd( CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_INTO_TERMINAL_OBJECT_RECORD );

CapInternalInstallAdd( CAP_INTERNAL_ADD_UNIVERSAL_MORPHISM_FROM_INITIAL_OBJECT_RECORD );

CapInternalInstallAdd( CAP_INTERNAL_ADD_DIRECT_SUM_RECORD );