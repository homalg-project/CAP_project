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
               [ IsFunction, IsDenseList, IsDenseList, IsDenseList ],
               
  function( name, can, cannot, func_list )
    local final_derivation;
    
    final_derivation := rec( );
    
    final_derivation.weight := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Weight", 1 );
    final_derivation.description := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Description", "" );
    final_derivation.category_filter := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryFilter", IsCapCategory );
    final_derivation.option_function := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryOptionFunction", ReturnTrue );
    
    final_derivation.name := name;
    final_derivation.can_compute := can;
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
            
            ## Add method
            add_name := ValueGlobal( Concatenation( [ "Add", NameFunction( current_final_derivation.name ) ] ) );
            
            add_name( category, current_final_derivation.function_list, weight );
            
            current_final_derivation.option_function( category );
            
        od;
        
        ## Remove all already installed entries
        derivation_list := derivation_list{ Difference( [ 1 .. Length( derivation_list ) ], current_installs ) };
        
    od;
    
    return true;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_WITH_GIVEN_FINAL_DERIVATIONS",
  
  function( )
    local recnames, current_recname, universal_object, clean_name, add_function, with_given_position;
    
    recnames := RecNames( CAP_INTERNAL_METHOD_NAME_RECORD );
    
    add_function := function( name_with_given, universal_object, name_without_with_given )
        
        AddFinalDerivation( name_with_given,
                            [ [ name_without_with_given, 1 ], [ universal_object, 0 ] ],
                            [ name_with_given ],
                            function( arg ) return CallFuncList( name_without_with_given, arg{[ 1 .. Length( arg ) - 1 ]} ); end :
                            CategoryOptionFunction := function( category ) category!.redirects.( NameFunction( name_without_with_given ) ) := false; end );
                            
    end;
    
    for current_recname in recnames do
        
        ## Note that the clean name will be the function_name, not the install_name
        
        with_given_position := PositionSublist( current_recname, "WithGiven" );
        
        if with_given_position = fail then continue; fi;
        
        clean_name := current_recname{[ 1 .. with_given_position - 1 ]};
        
        universal_object := current_recname{[ with_given_position + 9 .. Length( current_recname ) ]};
        
        add_function( ValueGlobal( current_recname ), ValueGlobal( universal_object ), ValueGlobal( clean_name ) );
        
    od;
    
end );

CAP_INTERNAL_CREATE_WITH_GIVEN_FINAL_DERIVATIONS();
