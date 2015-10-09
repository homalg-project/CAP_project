#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

InstallValue( CAP_INTERNAL_FINAL_DERIVATION_LIST,
              rec( final_derivation_list := [ ] ) );

InstallMethod( AddFinalDerivation,
               [ IsFunction, IsDenseList, IsDenseList, IsFunction ],
               
  function( name, can, cannot, func )
    
    AddFinalDerivation( name, can, cannot, [ [ func, [ ] ] ] );
    
end );

InstallMethod( AddFinalDerivation,
               [ IsFunction, IsDenseList, IsFunction ],
               
  function( name, cannot, func )
    
    AddFinalDerivation( name, [ ], cannot, [ [ func, [ ] ] ] );
    
end );

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

InstallMethod( AddFinalDerivation,
               [ IsFunction, IsDenseList, IsDenseList ],
               
  function( name, cannot, func_list )
    
    AddFinalDerivation( name, [ ], cannot, func_list );
    
end );

InstallMethod( AddFinalDerivation,
               [ IsFunction, IsDenseList, IsDenseList, IsDenseList ],
               
  function( name, can, cannot, func_list )
    local final_derivation, loop_multiplier, collected_list, current_implementation, current_list,
          operations_in_graph, used_ops_with_multiples;
    
    final_derivation := rec( );
    
    final_derivation.weight := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Weight", 1 );
    final_derivation.description := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Description", "" );
    final_derivation.category_filter := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryFilter", IsCapCategory );
    final_derivation.option_function := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryOptionFunction", ReturnTrue );
    loop_multiplier := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "WeightLoopMultiple", 2 );
    
    ## get used ops
    operations_in_graph := Operations( CAP_INTERNAL_DERIVATION_GRAPH );
    
    collected_list := [ ];
    
    for current_implementation in func_list do
        
        current_list := CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION( current_implementation[ 1 ], operations_in_graph, loop_multiplier );
        current_list := List( current_list, i -> [ ValueGlobal( i[ 1 ] ), i[ 2 ] ] );
        current_list := Concatenation( current_list, CAP_INTERNAL_FIND_APPEARANCE_OF_SYMBOL_IN_FUNCTION_FOR_MONOIDAL_CATEGORIES( current_implementation[ 1 ], loop_multiplier ) );
        collected_list := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( collected_list, current_list );
        
    od;
    
    used_ops_with_multiples := CAP_INTERNAL_MERGE_PRECONDITIONS_LIST( collected_list, can );
    
    final_derivation.name := name;
    final_derivation.can_compute := used_ops_with_multiples;
    final_derivation.cannot_compute := cannot;
    final_derivation.function_list := func_list;
    
    CAP_INTERNAL_FINAL_DERIVATION_SANITY_CHECK( final_derivation );
    
    Add( CAP_INTERNAL_FINAL_DERIVATION_LIST.final_derivation_list, final_derivation );
    
end );

InstallMethod( Finalize,
               [ IsCapCategory ],
  
  IsFinalized );

InstallMethod( IsFinalized,
               [ IsCapCategory ],
               
  function( category )
    local current_final_derivation, derivation_list, i, n, weight_list, weight, add_name, current_installs;
    
    ## Set filters for AbCategory etc to false if not true.
    
#     for i in CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.MathematicalPropertiesOfCategories do
#         
#         i := ValueGlobal( i );
#         
#         if not Tester( i )( category ) then
#             
#             Setter( i )( category, false );
#             
#         fi;
#         
#     od;
    
    derivation_list := ShallowCopy( CAP_INTERNAL_FINAL_DERIVATION_LIST.final_derivation_list );
    
    weight_list := category!.derivations_weight_list;
    
    while true do
        
        current_installs := [ ];
        
        for i in [ 1 .. Length( derivation_list ) ] do
            
            current_final_derivation := derivation_list[ i ];
            
            if ForAll( current_final_derivation.can_compute, j -> CurrentOperationWeight( weight_list, NameFunction( j[ 1 ] ) ) < infinity ) and
              ForAll( current_final_derivation.cannot_compute, j -> CurrentOperationWeight( weight_list, NameFunction( j ) ) = infinity ) then
                
                Add( current_installs, i );
                
            fi;
            
        od;
        
        if current_installs = [ ] then
            break;
        fi;
        
        for i in current_installs do
            current_final_derivation := derivation_list[ i ];
            
            ## calculate weight
            weight := current_final_derivation.weight + Sum( List( current_final_derivation.can_compute, j -> CurrentOperationWeight( weight_list, NameFunction( j[ 1 ] ) ) * j[ 2 ] ) );
            
            Info( DerivationInfo, 1, Concatenation( "install(",
                                          String( weight ),
                                          ") ",
                                          NameFunction( current_final_derivation.name ),
                                          ": ",
                                          current_final_derivation.description, "\n" ) );
            
            ## Add method
            add_name := ValueGlobal( Concatenation( [ "Add", NameFunction( current_final_derivation.name ) ] ) );
            
            add_name( category, current_final_derivation.function_list, weight : IsFinalDerivation := true );
            
            current_final_derivation.option_function( category );
            
        od;
        
        ## Remove all already installed entries
        derivation_list := derivation_list{ Difference( [ 1 .. Length( derivation_list ) ], current_installs ) };
        
    od;
    
    return true;
    
end );
