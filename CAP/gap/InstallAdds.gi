#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

BindGlobal( "CAP_INTERNAL_CREATE_OTHER_PAIR_FUNC",
  
  function( record )
    local object_name, op_name, with_given_name;
    
    op_name := record.with_given_without_given_name_pair[ 1 ];
    with_given_name := record.with_given_without_given_name_pair[ 2 ];
    
    if record.is_with_given = false then
        
        return function( arg ) return CallFuncList( ValueGlobal( op_name ), arg{[ 1 .. Length( arg ) - 1 ]} ); end;
        
    else
        
        object_name := with_given_name{[ PositionSublist( with_given_name, "WithGiven" ) + 9 .. Length( with_given_name ) ]};
        
        return function( arg )
                    return CallFuncList( ValueGlobal( with_given_name ),
                                         Concatenation( arg, [ CallFuncList( ValueGlobal( object_name ), [ arg[ 1 ] ] ) ] ) ); end;
        
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_ADD_MORPHISM_OR_FAIL",
  
  function( category, morphism_or_fail )
    
    if morphism_or_fail = fail then
        return;
    fi;
    
    AddMorphism( category, morphism_or_fail );
    
end );

InstallGlobalFunction( CapInternalInstallAdd,
  
  function( record )
    local function_name, install_name, add_name, pre_function,
          redirect_function, post_function, filter_list, caching,
          cache_name, nr_arguments, argument_list, add_function;
    
    function_name := record.function_name;
    
    if not IsBound( record.installation_name ) then
        
        install_name := function_name;
        
    else
        
        install_name := record.installation_name;
        
    fi;
    
    add_name := Concatenation( "Add", function_name );
    
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
    
    if record.return_type = "object" then
        add_function := AddObject;
    elif record.return_type = "morphism" then
        add_function := AddMorphism;
    elif record.return_type = "twocell" then
        add_function := AddTwoCell;
    elif record.return_type = "morphism_or_fail" then
        add_function := CAP_INTERNAL_ADD_MORPHISM_OR_FAIL;
    else
        add_function := ReturnTrue;
    fi;
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsFunction ],
                   
      function( category, func )
        
        ValueGlobal( add_name )( category, func, -1 );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsFunction, IsInt ],
                   
      function( category, func, weight )
        
        ValueGlobal( add_name )( category, [ [ func, [ ] ] ], weight );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsList ],
                   
      function( category, func )
        
        ValueGlobal( add_name )( category, func, -1 );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsList, IsInt ],
      
      function( category, method_list, weight )
        local install_func, replaced_filter_list, install_method, popper, i, set_primitive, install_remaining_pair, is_derivation,
              install_pair_func, pair_name, pair_func, is_pair_func, pair_func_push, number_of_proposed_arguments, current_function_number,
              current_function_argument_number;
        
        if HasIsFinalized( category ) and IsFinalized( category ) then
            Error( "cannot add methods anymore, category is finalized" );
        fi;
        
        ## If there already is a faster method, do nothing!
        if weight > CurrentOperationWeight( category!.derivations_weight_list, function_name ) then
            return;
        fi;
        
        set_primitive := ValueOption( "SetPrimitive" );
        if set_primitive <> false then
            set_primitive := true;
        fi;
        
        is_derivation := ValueOption( "IsDerivation" );
        if is_derivation <> true then
            is_derivation := false;
        fi;
        
        is_pair_func := ValueOption( "IsPairFunc" );
        if is_pair_func <> true then
            is_pair_func := false;
        fi;
        
        pair_func_push := false;
        if is_pair_func then
            PushOptions( rec( IsPairFunc := false ) );
            pair_func_push := true;
        fi;
        
        if weight = -1 then
            weight := 100;
        fi;
        
        install_pair_func := false;
        
        if not is_derivation and record.with_given_without_given_name_pair <> fail then
            if record.is_with_given = false then
                pair_name := record.with_given_without_given_name_pair[ 2 ];
            else
                pair_name := record.with_given_without_given_name_pair[ 1 ];
            fi;
            
            if CurrentOperationWeight( category!.derivations_weight_list, pair_name ) > weight then
                install_pair_func := true;
                pair_func := CAP_INTERNAL_CREATE_OTHER_PAIR_FUNC( record );
                category!.redirects.( record.with_given_without_given_name_pair[ 1 ] ) := false;
            elif not is_pair_func then
                category!.redirects.( record.with_given_without_given_name_pair[ 1 ] ) := true;
            fi;
            
        fi;
        
        replaced_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( filter_list, category );
        
        if caching = true then
            install_method := InstallMethodWithCache;
            PushOptions( rec( Cache := GET_METHOD_CACHE( category, cache_name, nr_arguments )  ) );
            popper := true;
        else
            install_method := InstallMethod;
            popper := false;
        fi;
        
        ## Nr arguments sanity check
        
        number_of_proposed_arguments := Length( argument_list );
        
        for current_function_number in [ 1 .. Length( method_list ) ] do
            
            current_function_argument_number := NumberArgumentsFunction( method_list[ current_function_number ][ 1 ] );
            
            if current_function_argument_number = -1 then
                continue;
            fi;
            
            if current_function_argument_number <> number_of_proposed_arguments then
                Error( "In ", add_name, ": given function ", String( current_function_number ), " has ", String( current_function_argument_number ),
                       " arguments but should have ", String( number_of_proposed_arguments ) );
            fi;
            
        od;
        
        install_func := function( func_to_install, filter_list )
          local new_filter_list;
            
            new_filter_list := CAP_INTERNAL_MERGE_FILTER_LISTS( replaced_filter_list, filter_list );
            
            install_method( ValueGlobal( install_name ),
                            new_filter_list,
                            
              function( arg )
                local redirect_flag, pre_func_return, redirect_return, result, post_func_arguments;
                
                if not IsBound( category!.redirects.( function_name ) ) or category!.redirects.( function_name ) <> false then
                    redirect_return := CallFuncList( redirect_function, Concatenation( [ category ], arg ) );
                    if redirect_return[ 1 ] = true then
                        if category!.predicate_logic then
                            INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{ argument_list }, redirect_return[ 2 ], category );
                        fi;
                        return redirect_return[ 2 ];
                    fi;
                fi;
                
                if category!.prefunction_check then
                    
                    pre_func_return := CallFuncList( pre_function, arg );
                    if pre_func_return[ 1 ] = false then
                        Error( Concatenation( "in function \033[1m", record.function_name, 
                            "\033[0m\n       of category \033[1m",
                            Name( category ), ":\033[0m\n\033[1m       ", pre_func_return[ 2 ], "\033[0m\n" ) );
                    fi;
                    
                fi;
                
                result := CallFuncList( func_to_install, arg{ argument_list } );
                
                if category!.predicate_logic then
                    INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{ argument_list }, result, category );
                fi;
                
                ## Those three commands do not commute
                add_function( category, result );
                Add( arg, result );
                CallFuncList( post_function, Concatenation( [ category ], arg ) );
                
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
        
        if pair_func_push then
            PopOptions();
        fi;
        
        if set_primitive then
            AddPrimitiveOperation( category!.derivations_weight_list, function_name, weight );
            
            if not is_pair_func and not ValueOption( "IsFinalDerivation" ) = true then
                category!.primitive_operations.( function_name ) := true;
            fi;
            
            if install_pair_func = true then
                PushOptions( rec( IsPairFunc := true ) );
                CallFuncList( ValueGlobal( Concatenation( "Add", pair_name ) ),[ category, [ [ pair_func, [ ] ] ], weight ] );
                PopOptions();
            fi;
            
        fi;
        
        
        
    end );
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_REDIRECTION",
  
  function( with_given_name, object_name, has_arguments, with_given_arguments, cache_name )
    local return_func, has_name, has_function, object_function, with_given_name_function, is_attribute, attribute_tester;
    
    object_function := ValueGlobal( object_name );
    
    with_given_name_function := ValueGlobal( with_given_name );
    
    is_attribute := Tester( object_function ) <> false;
    
    if not is_attribute then
        
        return function( arg )
            local has_arg_list, has_return, category, cache;
            
            category := arg[ 1 ];
            
            arg := arg{[ 2 .. Length( arg ) ]};
            
            has_arg_list := arg{ has_arguments };
            
            cache := GET_METHOD_CACHE( category, cache_name, Length( has_arguments ) );
            
            has_return := CallFuncList( CacheValue,  [ cache, has_arg_list ] );
            
            if has_return = [ ] then
                
                return [ false ];
                
            fi;
            
            return [ true, CallFuncList( with_given_name_function, Concatenation( arg{ with_given_arguments }, [ has_return[ 1 ] ] ) ) ];
            
        end;
        
    else
        
        attribute_tester := Tester( object_function );
        
        return function( arg )
            local has_arg_list, has_return, category, cache;
            
            category := arg[ 1 ];
            
            arg := arg{[ 2 .. Length( arg ) ]};
            
            has_arg_list := arg{ has_arguments };
            
            if not attribute_tester( has_arg_list ) then
                
                cache := GET_METHOD_CACHE( category, cache_name, Length( has_arguments ) );
                
                has_return := CallFuncList( CacheValue,  [ cache, has_arg_list ] );
                
                if has_return = [ ] then
                    
                    return [ false ];
                    
                fi;
                
            else
                
                has_return := CallFuncList( object_function, has_arg_list );
                
            fi;
            
            return [ true, CallFuncList( with_given_name_function, Concatenation( arg{ with_given_arguments }, [ has_return[ 1 ] ] ) ) ];
            
        end;
        
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_POST_FUNCTION",
  
  function( source_range_object, object_function_name, object_function_argument_list, object_call_name, object_cache_name )
    local object_getter, set_object, was_created_filter, diagram_name, setter_function, is_attribute, cache_key_length;
    
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
    setter_function := Setter( ValueGlobal( object_function_name ) );
    is_attribute := setter_function <> false;
    cache_key_length := Length( object_function_argument_list );
    
    if not is_attribute then
    
        return function( arg )
            local result, object, category;
            
            category := arg[ 1 ];
            
            arg := arg{[ 2 .. Length( arg ) ]};
            
            result := arg[ Length( arg ) ];
            Remove( arg );
            object := object_getter( result );
            
            if set_object then
                  SET_VALUE_OF_CATEGORY_CACHE( category, object_cache_name, cache_key_length, arg{ object_function_argument_list }, object );
            fi;
            
            ## Those two commands are not commutative
            AddToGenesis( object, diagram_name, arg[ 1 ] );
            SetFilterObj( object, was_created_filter );
            
        end;
        
    else
        
        return function( arg )
            local result, object, category;
            
            category := arg[ 1 ];
            
            arg := arg{[ 2 .. Length( arg ) ]};
            
            result := arg[ Length( arg ) ];
            Remove( arg );
            object := object_getter( result );
            
            if set_object then
                SET_VALUE_OF_CATEGORY_CACHE( category, object_cache_name, cache_key_length, arg{ object_function_argument_list }, object );
                CallFuncList( setter_function, Concatenation( arg{ object_function_argument_list }, [ object ] ) );
            fi;
            
            ## Those two commands are not commutative
            AddToGenesis( object, diagram_name, arg[ 1 ] );
            SetFilterObj( object, was_created_filter );
            
        end;
        
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_NEW_FUNC_WITH_ONE_MORE_ARGUMENT_WITH_RETURN",
  
  function( func )
    
    return function( arg ) return CallFuncList( func, arg{[ 2 .. Length( arg ) ]} ); end;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_NEW_FUNC_WITH_ONE_MORE_ARGUMENT_WITHOUT_RETURN",
  
  function( func )
    
    return function( arg ) CallFuncList( func, arg{[ 2 .. Length( arg ) ]} ); end;
    
end );

InstallGlobalFunction( CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD,
    
  function( record )
    local recnames, current_recname, current_rec, arg_list, i, with_given_name, with_given_name_length,
          object_name, object_func;
    
    recnames := RecNames( record );
    
    AddOperationsToDerivationGraph( CAP_INTERNAL_DERIVATION_GRAPH, recnames );
    
    for current_recname in recnames do
        
        current_rec := record.( current_recname );
        
        ## keep track of it in method name rec
        CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ) := current_rec;
        
        if IsBound( current_rec.no_install ) and current_rec.no_install = true then
            
            continue;
            
        fi;
        
        if not IsBound( current_rec.cache_name ) then current_rec.cache_name := current_recname; fi;
        
        if IsBound( current_rec.redirect_function ) then
            
            current_rec.redirect_function := CAP_INTERNAL_CREATE_NEW_FUNC_WITH_ONE_MORE_ARGUMENT_WITH_RETURN( current_rec.redirect_function );
            
        fi;
        
        if IsBound( current_rec.post_function ) then
            
            current_rec.post_function := CAP_INTERNAL_CREATE_NEW_FUNC_WITH_ONE_MORE_ARGUMENT_WITHOUT_RETURN( current_rec.post_function );
            
        fi;
        
        current_rec.function_name := current_recname;
        
        current_rec!.with_given_without_given_name_pair := fail;
        
        if current_rec.filter_list[ 1 ] = IsList then
            
            arg_list := [ 1, Length( current_rec.filter_list ) ];
            
        else
            
            arg_list := [ 1 ];
            
        fi;
        
        current_rec!.universal_object_arg_list := arg_list;
        
        if current_rec!.is_with_given then
            
            current_rec!.with_given_without_given_name_pair := [ current_recname{[ 1 .. PositionSublist( current_recname, "WithGiven" ) - 1 ]}, current_recname ];
            
            current_rec!.universal_object :=
              current_recname{[ PositionSublist( current_recname, "WithGiven" ) + 9 .. Length( current_recname ) ]};
            
            CapInternalInstallAdd( current_rec );
            
            continue;
            
        elif not IsBound( current_rec.universal_type ) then
            
            CapInternalInstallAdd( current_rec );
            
            continue;
            
        fi;
        
        
        if not IsBound( current_rec.argument_list ) then
            if Length( current_rec.filter_list ) > 1 and
              ForAll( [ 1 .. Length( current_rec.filter_list ) - 1 ], i -> current_rec.filter_list[ i ] = IsInt or current_rec.filter_list[ i ] = IsList ) then
                current_rec.argument_list := [ 1 .. Length( current_rec.filter_list ) - 1 ];
            else
                current_rec.argument_list := [ 1 .. Length( current_rec.filter_list ) ];
            fi;
        fi;
        
        if IsBound( current_rec.universal_type ) and not IsBound( current_rec.universal_object_position ) then
            
            if not IsBound( current_rec.post_function ) then
                current_rec.post_function := CAP_INTERNAL_CREATE_POST_FUNCTION( "id", current_rec.installation_name, arg_list, current_recname, "irrelevant" ); ##Please note that the third argument is not used
            fi;
            
            CapInternalInstallAdd( current_rec );
            
            continue;
            
        fi;
        
        if IsBound( current_rec.universal_object_position ) then
            
            ## find with given name
            
            ## FIXME: If the redirect function is already bound, then this part is superfluous
            
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
            
            current_rec!.with_given_without_given_name_pair := [ current_recname, with_given_name ];
            
            object_name := with_given_name{[ with_given_name_length + 1 .. Length( with_given_name ) ]};
            
            object_func := record.( object_name ).installation_name;
            
            if not IsBound( current_rec.redirect_function ) then
              current_rec.redirect_function := CAP_INTERNAL_CREATE_REDIRECTION( with_given_name, object_func, arg_list, current_rec.argument_list, object_func );
            fi;
            
            if not IsBound( current_rec.post_function ) then
                current_rec.post_function := CAP_INTERNAL_CREATE_POST_FUNCTION( current_rec.universal_object_position, object_func, arg_list, object_name, object_func );
            fi;
            
            CapInternalInstallAdd( current_rec );
            
            continue;
            
        fi;
        
    od;
    
end );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CAP_INTERNAL_METHOD_NAME_RECORD );

## These methods overwrite the automatically generated methods.
## The users do not have to give the category as an argument
## to their functions, but within derivations, the category has
## to be an argument (see any derivation of ZeroObject in DerivedMethods.gi)
##
InstallMethod( AddZeroObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddZeroObject( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
InstallMethod( AddInitialObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddInitialObject( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
InstallMethod( AddTerminalObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddTerminalObject( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );
