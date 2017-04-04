#############################################################################
##
##                                       ModulesOverLocalRingsForCAP
##
##  Copyright 2017, Sebastian Posur, University of Siegen
##
#############################################################################

#############################
##
## Gaussian elimination
##
#############################

InstallMethod( REFIndicesForMatricesOverIntegralDomain,
               [ IsHomalgMatrix ],
               
  function( matrix )
    local entries, nr_cols, nr_rows, c, r, result_list, p, a, rows_to_check, pivot;
    
    entries := EntriesOfHomalgMatrixAsListList( matrix );
    
    nr_cols := NrColumns( matrix );
    
    nr_rows := NrRows( matrix );
    
    rows_to_check := [ 1 .. nr_rows ];
    
    result_list := [];
    
    for c in [ 1 .. nr_cols ] do
        
        pivot := 0;
        
        for r in rows_to_check do
            
            if not IsZero( entries[r][c] ) then
                
                pivot := r;
                
                p := entries[r][c];
                
                break;
                
            fi;
            
        od;
        
        if pivot > 0 then
            
            Add( result_list, c );
            
            for r in Filtered( rows_to_check, i -> i > pivot ) do
                
                a := entries[r][c];
                
                if not IsZero( a ) then
                    
                    entries[r] := p * entries[r] - a * entries[pivot];
                    
                fi;
                
            od;
            
            Remove( rows_to_check, PositionProperty( rows_to_check, i -> i = pivot ) );
            
        fi;
        
    od;
    
    return result_list;
    
end );