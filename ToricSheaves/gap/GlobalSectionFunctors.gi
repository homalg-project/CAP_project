# SPDX-License-Identifier: GPL-2.0-or-later
# ToricSheaves: Toric sheaves as Serre quotients
#
# Implementations
#

InstallMethod( DegreeZeroPartFunctor,
               [ IsCapCategory, IsList ],
               
  function( graded_module_category, localized_vars )
    local ring, k, degree_matrix_list, degree_matrix, degree_matrix_as_list_list, module_map, kernel_of_degree_map, localized_degree_zero_ring,
          range_category, functor, object_function, morphism_function, i;
    
    ring := graded_module_category!.ring_for_representation_category;
    
    k := UnderlyingNonGradedRing( CoefficientsRing( ring ) );
    
    #Make the degrees fixed once and for all
    ByASmallerPresentation( DegreeGroup( ring ) );
    
    degree_matrix_list := WeightsOfIndeterminates( ring );
    
    degree_matrix_list := List( degree_matrix_list, i -> MatrixOfMap( UnderlyingMorphism( i ) ) );
    
    if degree_matrix_list = [ ] then
        Error( "ring has no indeterminates" );
    fi;
    
    degree_matrix := UnionOfRows( degree_matrix_list );
    
    degree_matrix_as_list_list := EntriesOfHomalgMatrixAsListList( degree_matrix );
    
    module_map := HomalgMap( degree_matrix, "free", DegreeGroup( ring ) );
    
    kernel_of_degree_map := MatrixOfMap( KernelEmb( module_map ) );

    localized_degree_zero_ring := CAP_INTERNAL_degree_zero_ring_and_generators( degree_matrix, kernel_of_degree_map, localized_vars, k );
    
    range_category := LeftPresentations( localized_degree_zero_ring[ 2 ] );
    
    functor := CapFunctor( Concatenation( "Degree zero functor localized by ", String( localized_vars ) ), graded_module_category, range_category );
    
    object_function := function( module )
        local range_degrees, module_matrix, non_trivial_degrees, degree_positions, source_degrees, new_module, i;
        
        range_degrees := GeneratorDegrees( module );
        
        if Length( range_degrees ) = 0 then
            return FreeLeftPresentation( localized_degree_zero_ring[ 2 ], 0 );
        fi;
        
        module_matrix := UnderlyingMatrix( module );
        
        non_trivial_degrees := NonTrivialDegreePerRow( module_matrix );
        degree_positions := PositionOfFirstNonZeroEntryPerRow( module_matrix );
        
        source_degrees := [ ];
        
        for i in [ 1 .. Length( degree_positions ) ] do
            if i = -1 then
                Error( "something went wrong" );
            fi;
            
            if degree_positions[ i ] = 0 then
                source_degrees[ i ] := range_degrees[ 1 ];
            else
                source_degrees[ i ] := range_degrees[ degree_positions[ i ] ] + non_trivial_degrees[ i ];
            fi;
            
        od;
        
        range_degrees := List( range_degrees, i -> EntriesOfHomalgMatrixAsListList( MatrixOfMap( UnderlyingMorphism( i ) ) )[ 1 ] );
        
        source_degrees := List( source_degrees, i -> EntriesOfHomalgMatrixAsListList( MatrixOfMap( UnderlyingMorphism( i ) ) )[ 1 ] );
        
        new_module := CAP_INTERNAL_degree_zero_module( source_degrees, module_matrix, range_degrees, degree_matrix, kernel_of_degree_map, localized_vars,
                                                       localized_degree_zero_ring[ 1 ], localized_degree_zero_ring[ 2 ] );
        
        return new_module;
        
    end;
    
    AddObjectFunction( functor, object_function );
    
    morphism_function := function( new_source, morphism, new_range )
        local matrix, matrix_as_list_list, new_range_deleted, new_source_deleted, i, new_matrix;
        
        matrix := UnderlyingMatrix( morphism );
        
        matrix_as_list_list := EntriesOfHomalgMatrixAsListList( matrix );
        
        new_source_deleted := new_source!.deleted_free_parts;
        new_range_deleted := new_range!.deleted_free_parts;
        
        for i in Reversed( new_source_deleted ) do
            Remove( matrix_as_list_list, i );
        od;
        matrix_as_list_list := TransposedMatMutable( matrix_as_list_list );
        for i in Reversed( new_range_deleted ) do
            Remove( matrix_as_list_list, i );
        od;
        matrix_as_list_list := TransposedMatMutable( matrix_as_list_list );
        
        new_matrix := CAP_INTERNAL_new_matrix_mapping_by_generator_lists( new_source!.degree_part_generator_monomials,
                                                                          new_range!.degree_part_generator_monomials,
                                                                          matrix_as_list_list, localized_degree_zero_ring[ 1 ], localized_degree_zero_ring[ 2 ] );
        
        return PresentationMorphism( new_source, new_matrix, new_range );
        
    end;
    
    AddMorphismFunction( functor, morphism_function );
    
    return functor;
    
end );
