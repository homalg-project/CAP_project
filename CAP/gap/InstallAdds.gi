# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
BindGlobal( "CAP_INTERNAL_DISPLAY_ERROR_FOR_FUNCTION_OF_CATEGORY",
  
  function( function_name, category, message )
    
    Error( Concatenation( "in function \033[1m", function_name,
        "\033[0m\n       of category \033[1m",
        Name( category ), ":\033[0m\n\033[1m       ", message, "\033[0m\n" ) );
    
end );

InstallMethod( AddCapOperation,
               [ IsString, IsCapCategory, IsFunction, IsInt ],
               
 FunctionWithNamedArguments(
  [
    [ "IsDerivation", false ],
    [ "IsFinalDerivation", false ],
    [ "IsPrecompiledDerivation", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, function_name, category, func_to_install, weight )
    local record, category_name, is_derivation, is_final_derivation, is_precompiled_derivation, type, replaced_filter_list,
        input_human_readable_identifier_getter, input_sanity_check_functions, data_type, output_human_readable_identifier_getter,
        output_data_type, output_sanity_check_function, filter_string;
    
    record := CAP_INTERNAL_METHOD_NAME_RECORD.(function_name);
    
    if IsFinalized( category ) then
        Error( "cannot add methods anymore, category is finalized" );
    fi;
    
    category_name := Name( category );
    
    is_derivation := CAP_NAMED_ARGUMENTS.IsDerivation;
    
    is_final_derivation := CAP_NAMED_ARGUMENTS.IsFinalDerivation;
    
    is_precompiled_derivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation;
    
    if Length( Positions( [ is_derivation, is_final_derivation, is_precompiled_derivation ], true ) ) > 1 then
        
        Error( "at most one of the options `IsDerivation`, `IsFinalDerivation` and `IsPrecompiledDerivation` may be set" );
        
    fi;
    
    if weight = -1 then
        weight := 100;
    fi;
    
    if is_derivation then
        
        type := "ordinary_derivation";
        
    elif is_final_derivation then
        
        type := "final_derivation";
        
    elif is_precompiled_derivation then
        
        type := "precompiled_derivation";
        
    else
        
        type := "primitive_installation";
        
    fi;
    
    # Display a warning in various cases when overwriting existing functions
    if IsBound( category!.operations.(function_name) ) then
        
        # If there already is a faster method: do nothing but display a warning because this should not happen.
        if weight > category!.operations.(function_name).weight then
            
            Print( "WARNING: Ignoring a function added for ", function_name, " with weight ", weight, " to \"", category_name, "\" because there already is a function installed with weight ", category!.operations.(function_name).weight, "." );
            
            if type = "precompiled_derivation" then
                
                Print( " Probably you have to rerun the precompilation to adjust the weights in the precompiled code." );
                
            fi;
            
            Print( "\n" );
            
            return;
            
        fi;
        
        if category!.operations.( function_name ).type = "primitive_installation" then
            
            # Display a warning when overwriting primitive operations with derivations.
            if type <> "primitive_installation" then
                
                Print( "WARNING: Overwriting a function for ", function_name, " primitively added to \"", category_name, "\" with a derivation." );
                
                if type = "precompiled_derivation" then
                    
                    Print( " Probably you have to rerun the precompilation to adjust the weights in the precompiled code." );
                    
                fi;
                
                Print( "\n" );
                
            fi;
            
        else
            
            Print( "WARNING: A function for ", function_name, " of type ", category!.operations.( function_name ).type, " is unexpectedly overwritten by a function of type ", type, "." );
            
            if category!.operations.( function_name ).type = "precompiled_derivation" then
                
                Print( " Probably you have to rerun the precompilation to adjust the weights in the precompiled code." );
                
            fi;
            
            Print( "\n" );
            
        fi;
        
    fi;
    
    category!.operations.(function_name) := rec(
        type := type,
        weight := weight,
        func := func_to_install,
    );
    
    if not IsBound( category!.added_functions.( function_name ) ) then
        
        category!.added_functions.( function_name ) := [ ];
        
    fi;
    
    Add( category!.added_functions.( function_name ), func_to_install );
    
    # if a function for which a cached precompiled function exists is overwritten, drop the cached precompiled function
    if IsBound( category!.cached_precompiled_functions.( function_name ) ) then
        
        Unbind( category!.cached_precompiled_functions.( function_name ) );
        
    fi;
    
    replaced_filter_list := CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS( record.filter_list, category );
    
    ## Nr arguments sanity check
    if NumberArgumentsFunction( func_to_install ) >= 0 and NumberArgumentsFunction( func_to_install ) <> Length( replaced_filter_list ) then
        
        Error( "While adding a function for ", function_name, ": given function has ", NumberArgumentsFunction( func_to_install ), " arguments but should have ", Length( replaced_filter_list ) );
        
    fi;
    
    # prepare input sanity check
    input_human_readable_identifier_getter := { i, function_name, category_name } -> Concatenation( "the ", String( i ), ". argument of the function \033[1m", function_name, "\033[0m of the category named \033[1m", category_name, "\033[0m" );
    
    input_sanity_check_functions := [ ];
    
    for filter_string in record.filter_list do
        
        if not IsBound( category!.input_sanity_check_functions.(filter_string) ) then
            
            data_type := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( filter_string, category );
            
            if data_type <> fail then
                
                category!.input_sanity_check_functions.(filter_string) := CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( data_type, input_human_readable_identifier_getter );
                
            else
                
                category!.input_sanity_check_functions.(filter_string) := ReturnTrue;
                
            fi;
            
        fi;
        
        Add( input_sanity_check_functions, category!.input_sanity_check_functions.(filter_string) );
        
    od;
    
    # prepare output sanity check
    output_human_readable_identifier_getter := { function_name, category_name } -> Concatenation( "the result of the function \033[1m", function_name, "\033[0m of the category named \033[1m", category_name, "\033[0m" );
    output_data_type := CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( record.return_type, category );
    
    if output_data_type <> fail then
        
        output_sanity_check_function := CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( output_data_type, output_human_readable_identifier_getter );
        
    else
        
        output_sanity_check_function := ReturnTrue;
        
    fi;
    
    if not IsBound( category!.timing_statistics.( function_name ) ) then
        
        category!.timing_statistics.( function_name ) := [ ];
        
    fi;
    
    # set name for debugging purposes
    if NameFunction( func_to_install ) in [ "unknown", "_EVALSTRINGTMP" ] then
        
        if is_derivation then
            
            SetNameFunction( func_to_install, Concatenation( "Derivation (first added to ", category_name, ") of ", function_name ) );
            
        elif is_final_derivation then
            
            SetNameFunction( func_to_install, Concatenation( "Final derivation (first added to ", category_name, ") of ", function_name ) );
            
        elif is_precompiled_derivation then
            
            SetNameFunction( func_to_install, Concatenation( "Precompiled derivation added to ", category_name, " for ", function_name ) );
            
        else
            
            SetNameFunction( func_to_install, Concatenation( "Function added to ", category_name, " for ", function_name ) );
            
        fi;
        
    fi;
    
    if not category!.overhead then
        
        InstallOtherMethod( record.operation,
                            replaced_filter_list,
                            
            function( arg )
                
                return CallFuncList( func_to_install, arg );
                
        end );
        
    else
        
        InstallMethodWithCache( record.operation,
                                replaced_filter_list,
                                
          function( arg )
            local redirect_return, pre_func_return, collect_timing_statistics, start_time, result, end_time, i;
            
            if IsBound( record.redirect_function ) then
                redirect_return := CallFuncList( record.redirect_function, arg );
                if redirect_return[ 1 ] = true then
                    if category!.predicate_logic then
                        INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{[ 2 .. Length( arg ) ]}, redirect_return[ 2 ], category );
                    fi;
                    return redirect_return[ 2 ];
                fi;
            fi;
            
            if category!.input_sanity_check_level > 0 then
                for i in [ 1 .. Length( input_sanity_check_functions ) ] do
                    input_sanity_check_functions[ i ]( arg[ i ], i, function_name, category_name );
                od;
                
                if IsBound( record.pre_function ) then
                    pre_func_return := CallFuncList( record.pre_function, arg );
                    if pre_func_return[ 1 ] = false then
                        CAP_INTERNAL_DISPLAY_ERROR_FOR_FUNCTION_OF_CATEGORY( record.function_name, category, pre_func_return[ 2 ] );
                    fi;
                fi;
                
                if category!.input_sanity_check_level > 1 and IsBound( record.pre_function_full ) then
                    pre_func_return := CallFuncList( record.pre_function_full, arg );
                    if pre_func_return[ 1 ] = false then
                        CAP_INTERNAL_DISPLAY_ERROR_FOR_FUNCTION_OF_CATEGORY( record.function_name, category, pre_func_return[ 2 ] );
                    fi;
                fi;
                
            fi;
            
            collect_timing_statistics := category!.timing_statistics_enabled and not is_derivation and not is_final_derivation;
            
            if collect_timing_statistics then
                
                start_time := Runtime( );
                
            fi;
            
            result := CallFuncList( func_to_install, arg );
            
            if collect_timing_statistics then
                
                end_time := Runtime( );
                
                Add( category!.timing_statistics.( function_name ), end_time - start_time );
                
            fi;
            
            if not is_derivation and not is_final_derivation then
                if category!.add_primitive_output then
                    record.add_value_to_category_function( category, result );
                elif category!.output_sanity_check_level > 0 then
                    output_sanity_check_function( result, function_name, category_name );
                fi;
            fi;
            
            if category!.predicate_logic then
                INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{[ 2 .. Length( arg ) ]}, result, category );
            fi;
            
            if IsBound( record.post_function ) then
                
                CallFuncList( record.post_function, Concatenation( arg, [ result ] ) );
                
            fi;
            
            return result;
            
        end : InstallMethod := InstallOtherMethod, Cache := GET_METHOD_CACHE( category, function_name, Length( replaced_filter_list ) ) );
        
    fi;
    
    # return void for Julia
    return;
    
end ) );

InstallGlobalFunction( CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD,
    
  function( record )
    local recnames, current_rec, function_name, filter_list, CAP_operation, replaced_filter_list, get_convenience_function, current_recname;
    
    recnames := RecNames( record );
    
    AddOperationsToDerivationGraph( CAP_INTERNAL_DERIVATION_GRAPH, recnames );
    
    for current_recname in recnames do
        
        current_rec := record.( current_recname );
        
        if not IsBound( current_rec.function_name ) then
            
            Error( "the record has no entry `function_name`, probably you forgot to call CAP_INTERNAL_ENHANCE_NAME_RECORD" );
            
        fi;
        
        ## keep track of it in method name rec
        CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ) := current_rec;
        
        function_name := current_recname;
        filter_list := current_rec.filter_list;
        CAP_operation := current_rec.operation;
        
        # declare operation with category as first argument and install convenience method
        if current_rec.install_convenience_without_category then
            
            replaced_filter_list := CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS( filter_list );
            
            if filter_list[2] in [ "object", "morphism", "twocell" ] then
                
                get_convenience_function := oper -> { arg } -> CallFuncListAtRuntime( oper, Concatenation( [ CapCategory( arg[1] ) ], arg ) );
                
            elif filter_list[2] = "list_of_objects" or filter_list[2] = "list_of_morphisms" then
                
                get_convenience_function := oper -> { arg } -> CallFuncListAtRuntime( oper, Concatenation( [ CapCategory( arg[1][1] ) ], arg ) );
                
            elif filter_list[3] in [ "object", "morphism", "twocell" ] then
                
                get_convenience_function := oper -> { arg } -> CallFuncListAtRuntime( oper, Concatenation( [ CapCategory( arg[2] ) ], arg ) );
                
            elif filter_list[4] = "list_of_objects" or filter_list[4] = "list_of_morphisms" then
                
                get_convenience_function := oper -> { arg } -> CallFuncListAtRuntime( oper, Concatenation( [ CapCategory( arg[3][1] ) ], arg ) );
                
            else
                
                Error( Concatenation( "please add a way to derive the category from the arguments of ", function_name ) );
                
            fi;
            
            InstallMethod( CAP_operation, replaced_filter_list{[ 2 .. Length( replaced_filter_list ) ]}, get_convenience_function( CAP_operation ) );
            
        fi;
        
        # convenience for Julia lists
        #= comment for Julia
        if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
            
            if "list_of_objects" in filter_list or "list_of_morphisms" in filter_list or "list_of_twocells" in filter_list then
                
                replaced_filter_list := CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS_FOR_JULIA( filter_list );
                
                Assert( 0, ValueGlobal( "IsJuliaObject" ) in replaced_filter_list );
                
                InstallOtherMethod( CAP_operation,
                        replaced_filter_list,
                        EvalString( ReplacedStringViaRecord( "function( arg ) return CallFuncList( CAP_operation, List( arg, function( ar ) if ValueGlobal( \"IsJuliaObject\" )( ar ) then return ValueGlobal( \"ConvertJuliaToGAP\" )( ar ); fi; return ar; end ) ); end", rec( CAP_operation := function_name ) ) ) );
                
                Assert( 0, current_rec.install_convenience_without_category );
                
                InstallOtherMethod( CAP_operation,
                        replaced_filter_list{[ 2 .. Length( replaced_filter_list ) ]},
                        EvalString( ReplacedStringViaRecord( "function( arg ) return CallFuncList( CAP_operation, List( arg, function( ar ) if ValueGlobal( \"IsJuliaObject\" )( ar ) then return ValueGlobal( \"ConvertJuliaToGAP\" )( ar ); fi; return ar; end ) ); end", rec( CAP_operation := function_name ) ) ) );
                
            fi;
            
        fi;
        # =#
        
    od;
    
end );
