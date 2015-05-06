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
               [ IsFunction, IsDenseList, IsDenseList, IsDenseList ],
               
  function( name, can, cannot, func_list )
    local final_derivation;
    
    final_derivation := rec( );
    
    final_derivation.weight := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Weight", 1 );
    final_derivation.description := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "Description", "" );
    final_derivation.category_filter := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "CategoryFilter", IsCapCategory );
    
    final_derivation.name := name;
    final_derivation.can_compute := can;
    final_derivation.cannot_compute := cannot;
    final_derivation.function_list := func_list;
    
    Add( CAP_INTERNAL_FINAL_DERIVATION_LIST.final_derivation_list, final_derivation );
    
end );

InstallMethod( Finalize,
               [ IsCapCategory ],
               
  function( category )
    local current_final_derivation, derivation_list, i, n, weight_list, weight, add_name;
    
    ## Set filters for AbCategory etc to false if not true.
    
    i := 1;
    
    derivation_list := ShallowCopy( CAP_INTERNAL_FINAL_DERIVATION_LIST.final_derivation_list );
    
    n := Length( derivation_list );
    
    weight_list := category!.derivations_weight_list;
    
    while i <= n do
        
        current_final_derivation := derivation_list[ i ];
        
        if ForAll( current_final_derivation.can_compute, j -> CurrentOperationWeight( weight_list, j[ 1 ] ) < infinity ) and
           ForAll( current_final_derivation.cannot_compute, j -> CurrentOperationWeight( weight_list, j ) = infinity ) then
            
            ## calculate weight
            weight := current_final_derivation.weight + Sum( List( current_final_derivation.can_compute, j -> CurrentOperationWeight( weight_list, j[ 1 ] ) * j[ 2 ] ) );
            
            ## Add method
            add_name := ValueGlobal( Concatenation( [ "Add", NameFunction( current_final_derivation.name ) ] ) );
            
            add_name( category, current_final_derivation.function_list, weight );
            
            ## Remove entry
            Remove( derivation_list, i );
            i := 1;
            n := n - 1;
        else
            i := i + 1;
        fi;
        
    od;
    
    return true;
    
end );

