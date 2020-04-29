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
    
    return CategoryOfToricSheaves( graded_ring, irrelevant_ideal_generators, false );
    
end );

InstallMethod( CategoryOfToricSheaves,
               [ IsHomalgGradedRing, IsList, IsBool ],
               
  function( graded_ring, irrelevant_ideal_generators, comes_from_smooth_variety )
    local degree_matrix_list, degree_matrix, degree_matrix_as_list_list, test_function, functor_list, presentation_category, serre_quotient_category;
    
    degree_matrix_list := WeightsOfIndeterminates( graded_ring );
    
    degree_matrix_list := List( degree_matrix_list, i -> MatrixOfMap( UnderlyingMorphism( i ) ) );
    
    if degree_matrix_list = [ ] then
        Error( "ring has no indeterminates" );
    fi;
    
    degree_matrix := UnionOfRows( degree_matrix_list );
    
    degree_matrix_as_list_list := EntriesOfHomalgMatrixAsListList( degree_matrix );
    
    presentation_category := GradedLeftPresentations( graded_ring );
    
    if IsFree( DegreeGroup( graded_ring ) ) and Rank( DegreeGroup( graded_ring ) ) = 1 and ForAll( degree_matrix_as_list_list, i -> ForAll( i, j -> j >= 0 ) ) and comes_from_smooth_variety then
        
        test_function := module -> IsZero( HilbertPolynomial( UnderlyingMatrixOverNonGradedRing( UnderlyingMatrix( module ) ) ) );
        
    else
        
        functor_list := List( irrelevant_ideal_generators,
                              i -> DegreeZeroPartFunctor( presentation_category, i ) );
        
        test_function := function( module )
            local module_matrix, source_degrees, range_degrees, current_module, current_generator, matrix_list, functor, current_section_module,
                  degree_positions;
            
            ## Quick and dirty test :)
            module_matrix := UnderlyingMatrix( module );
            degree_positions := PositionOfFirstNonZeroEntryPerColumn( module_matrix );
            ## FIX THIS PART!!
            if ForAny( degree_positions, i -> i = 0 ) then
                ## Modules with free parts never sheafify to zero
                return false;
            fi;
            
            for functor in functor_list do
                current_section_module := ApplyFunctor( functor, module );
                if not IsZeroForObjects( current_section_module ) = true then
                    return false;
                fi;
            od;
            return true;
            
        end;
        
    fi;
    
    
    serre_quotient_category := SerreQuotientCategoryByThreeArrows( presentation_category, test_function, Concatenation( "Toric sheaves over ", RingName( graded_ring ) ) );
    
    return serre_quotient_category;
    
end );
