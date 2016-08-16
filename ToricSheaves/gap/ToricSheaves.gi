#############################################################################
##
##                                               ToricSheaves package
##
##  Copyright 2016, Sebastian Gutsche, Universität Siegen
##                  Sebastian Posur,   Universität Siegen
##
#############################################################################

InstallMethod( CategoryOfToricSheaves,
               [ IsHomalgGradedRing, IsList ],
               
  function( graded_ring, irrelevant_ideal_generators )
    local degree_matrix_list, degree_matrix, i, degree_matrix_as_list_list, test_function,
          presentation_category, serre_quotient_category, module_map, kernel_of_degree_map,
          degree_positions, non_trivial_degrees;
    
    degree_matrix_list := WeightsOfIndeterminates( graded_ring );
    
    degree_matrix_list := List( degree_matrix_list, i -> MatrixOfMap( UnderlyingMorphism( i ) ) );
    
    if degree_matrix_list = [ ] then
        Error( "ring has no indeterminates" );
    fi;
    
    degree_matrix := degree_matrix_list[ 1 ];
    
    for i in [ 2 .. Length( degree_matrix_list ) ] do
        degree_matrix := UnionOfRows( degree_matrix, degree_matrix_list[ i ] );
    od;
    
    degree_matrix_as_list_list := EntriesOfHomalgMatrixAsListList( degree_matrix );
    
    if IsFree( DegreeGroup( graded_ring ) ) and ForAll( degree_matrix_as_list_list, i -> ForAll( i, j -> j >= 0 ) ) then
        
        test_function := module -> IsZero( HilbertPolynomial( UnderlyingMatrixOverNonGradedRing( UnderlyingMatrix( module ) ) ) );
        
    else
        
        module_map := HomalgMap( degree_matrix, "free", DegreeGroup( graded_ring ) );
        
        kernel_of_degree_map := MatrixOfMap( KernelEmb( module_map ) );
        
        test_function := function( module )
            local module_matrix, source_degrees, range_degrees, current_module, current_generator, matrix_list;
            
            range_degrees := GeneratorDegrees( module );
            
            module_matrix := UnderlyingMatrix( module );
            
            degree_positions := PositionOfFirstNonZeroEntryPerColumn( module_matrix );
            
            ## FIX THIS PART!!
            if ForAny( degree_positions, i -> i = 0 ) then
                ## Modules with free parts never sheafify to zero
                return false;
            fi;
            
            non_trivial_degrees := NonTrivialDegreePerRow( module_matrix );
            degree_positions := PositionOfFirstNonZeroEntryPerRow( module_matrix );
            
            source_degrees := [ ];
            
            for i in [ 1 .. Length( degree_positions ) ] do
                if i = -1 then
                    Error( "something went wrong" );
                fi;
                
                source_degrees[ i ] := range_degrees[ degree_positions[ i ] ] + non_trivial_degrees[ i ];
                
            od;
            
            range_degrees := List( range_degrees, i -> EntriesOfHomalgMatrixAsListList( MatrixOfMap( UnderlyingMorphism( i ) ) )[ 1 ] );
            
            source_degrees := List( source_degrees, i -> EntriesOfHomalgMatrixAsListList( MatrixOfMap( UnderlyingMorphism( i ) ) )[ 1 ] );
            
            for current_generator in irrelevant_ideal_generators do
                
                current_module := CAP_INTERNAL_compute_degree_zero_part( source_degrees, module_matrix, range_degrees,
                                                                        degree_matrix, kernel_of_degree_map, current_generator );
                
                if not IsEpimorphism( current_module ) then
                    return false;
                fi;
                
            od;
            
            return true;
            
        end;
        
    fi;
    
    presentation_category := GradedLeftPresentations( graded_ring );
    
    serre_quotient_category := SerreQuotientCategoryByThreeArrows( presentation_category, test_function, Concatenation( "Toric sheaves over ", RingName( graded_ring ) ) );
    
    return serre_quotient_category;
    
end );
