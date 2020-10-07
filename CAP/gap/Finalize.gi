# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallValue( CAP_INTERNAL_FINAL_DERIVATION_LIST,
              rec( final_derivation_list := [ ] ) );

BindGlobal( "CAP_INTERNAL_FINAL_DERIVATION_SANITY_CHECK",
  
  function( derivation )
    
    local possible_names, all_operations_names, function_object, function_string,
          string_stream, i, all_operations;
    
    possible_names := derivation!.can_compute;
    
    possible_names := List( possible_names, i -> NameFunction( i[ 1 ] ) );
    
    all_operations := Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    for function_object in derivation!.function_list do
        
        function_object := function_object[ 1 ];
        
        function_string := "";
        
        string_stream := OutputTextString( function_string, false );
        
        SetPrintFormattingStatus( string_stream, false );
        
        PrintTo( string_stream, function_object );
        
        CloseStream( string_stream );
        
        RemoveCharacters( function_string, "()[];," );
        
        NormalizeWhitespace( function_string );
        
        function_string := SplitString( function_string, " " );
        
        for i in function_string do
            
            if i in all_operations and not i in possible_names then
                Error( Concatenation( "final derivation with description\n", derivation.description, "\n uses ", i, ",\n which is not part of its condition" ) );
            fi;
            
        od;
        
    od;
    
end );


InstallGlobalFunction( AddFinalDerivation,
               
  function( name, can, cannot, func_list, additional_functions... )
    local final_derivation, loop_multiplier, collected_list, current_implementation, current_list,
          operations_in_graph, used_ops_with_multiples, preconditions_complete, i, current_additional_func, function_called_before_installation;

    if IsFunction( func_list ) then
        func_list := [ [ func_list, [] ] ];
    fi;

    final_derivation := rec( );
    
    final_derivation.weight := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Weight", 1 );
    final_derivation.description := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Description", "" );
    final_derivation.category_filter := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryFilter", IsCapCategory );
    loop_multiplier := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "WeightLoopMultiple", 2 );
    preconditions_complete := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "ConditionsListComplete", false );
    function_called_before_installation := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "FunctionCalledBeforeInstallation", false );
    
    for i in [ 1 .. Length( additional_functions ) ] do
        if IsFunction( additional_functions[ i ][ 2 ] ) then
            additional_functions[ i ][ 2 ] := [ [ additional_functions[ i ][ 2 ], [ ] ] ];
        fi;
    od;
    final_derivation.additional_functions := additional_functions;

    ## get used ops
    operations_in_graph := Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    collected_list := [ ];
    
    ## Find symbols in main function
    if preconditions_complete = false then
        for current_implementation in func_list do
            
            current_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( current_implementation[ 1 ], operations_in_graph, loop_multiplier, CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS );
            current_list := List( current_list, i -> [ ValueGlobal( i[ 1 ] ), i[2] ]);
            collected_list := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( collected_list, current_list );
            
        od;
    fi;
    final_derivation.weights := collected_list;
    used_ops_with_multiples := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( collected_list, can );
    final_derivation.can_compute := used_ops_with_multiples;

    ## Find symbols in additional function
    for current_additional_func in final_derivation.additional_functions do
        collected_list := [];
        for current_implementation in current_additional_func[ 2 ] do
            current_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( current_implementation[ 1 ], operations_in_graph, loop_multiplier, CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS );
            current_list := List( current_list, i -> [ ValueGlobal( i[ 1 ] ), i[2] ]);
            collected_list := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( collected_list, current_list );
        od;
        current_additional_func[ 3 ] := collected_list;
    od;
    
    final_derivation.name := name;
    final_derivation.cannot_compute := cannot;
    final_derivation.function_list := func_list;
    final_derivation.function_called_before_installation := function_called_before_installation;
    
    CAP_INTERNAL_FINAL_DERIVATION_SANITY_CHECK( final_derivation );
    
    Add( CAP_INTERNAL_FINAL_DERIVATION_LIST.final_derivation_list, final_derivation );
    
end );

InstallMethod( Finalize,
               [ IsCapCategory ],
  
  IsFinalized );

InstallMethod( IsFinalized,
               [ IsCapCategory ],
               
  function( category )
    local current_final_derivation, derivation_list, i, n, weight_list, weight, add_name, current_installs, current_tester_func, current_additional_func;
    
    derivation_list := ShallowCopy( CAP_INTERNAL_FINAL_DERIVATION_LIST.final_derivation_list );
    
    if not category!.is_computable then
        
        derivation_list := Filtered( derivation_list, der -> not NameFunction( der!.name ) = "IsCongruentForMorphisms" );
        
    fi;
    
    weight_list := category!.derivations_weight_list;
    
    while true do
        
        Saturate( weight_list );
        
        current_installs := [ ];
        
        for i in [ 1 .. Length( derivation_list ) ] do
            
            current_final_derivation := derivation_list[ i ];
            
            if ForAll( current_final_derivation.can_compute, j -> CurrentOperationWeight( weight_list, NameFunction( j[ 1 ] ) ) < infinity ) and
              ForAll( current_final_derivation.cannot_compute, j -> CurrentOperationWeight( weight_list, NameFunction( j ) ) = infinity ) then
                
                current_tester_func := current_final_derivation.category_filter;

                if IsFilter( current_tester_func ) then
                    
                    if Tester( current_tester_func )( category ) and current_tester_func( category ) then
                        Add( current_installs, i );
                    fi;
                    
                elif IsFunction( current_tester_func ) and current_tester_func( category ) then ## in particular: not a filter
                    Add( current_installs, i );
                fi;
            
            fi;
            
        od;
        
        if current_installs = [ ] then
            break;
        fi;
        
        for i in current_installs do
            current_final_derivation := derivation_list[ i ];
            
            ## calculate weight
            weight := current_final_derivation.weight + Sum( List( current_final_derivation.weights, j -> CurrentOperationWeight( weight_list, NameFunction( j[ 1 ] ) ) * j[ 2 ] ) );
            
            Info( DerivationInfo, 1, Concatenation( "install(",
                                          String( weight ),
                                          ") ",
                                          NameFunction( current_final_derivation.name ),
                                          ": ",
                                          current_final_derivation.description, "\n" ) );
            
            ## call function before adding the method
            
            if current_final_derivation.function_called_before_installation <> false then
                
                current_final_derivation.function_called_before_installation( category );
                
            fi;
            
            ## Add method
            add_name := ValueGlobal( Concatenation( [ "Add", NameFunction( current_final_derivation.name ) ] ) );
            
            add_name( category, current_final_derivation.function_list, weight : IsFinalDerivation := true );

            for current_additional_func in current_final_derivation.additional_functions do
                weight := current_final_derivation.weight + Sum( List( current_additional_func[ 3 ], j -> CurrentOperationWeight( weight_list, NameFunction( j[ 1 ] ) ) * j[ 2 ] ) );
                add_name := ValueGlobal( Concatenation( [ "Add", NameFunction( current_additional_func[ 1 ] ) ] ) );
                add_name( category, current_additional_func[ 2 ], weight : IsFinalDerivation := true );
            od;
            
        od;
        
        ## Remove all already installed entries
        derivation_list := derivation_list{ Difference( [ 1 .. Length( derivation_list ) ], current_installs ) };
        
    od;
    
    return true;
    
end );
