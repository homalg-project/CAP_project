# SPDX-License-Identifier: GPL-2.0-or-later
# ToricSheaves: Toric sheaves as Serre quotients
#
# Implementations
#

BindGlobal( "CAP_INTERNAL_degree_zero_monomials",
  function( degree_matrix, kernel_of_degree_matrix, localized_variables )
    local kernel_of_degree_matrix_transposed, 
          inequalities_list, inequalities_polytope, generating_set, rows,
          generating_set_hilbert, generating_set_linear, monomial_transformation, current_part;
    
    kernel_of_degree_matrix_transposed := Involution( kernel_of_degree_matrix );
    
    inequalities_list := EntriesOfHomalgMatrixAsListList( kernel_of_degree_matrix_transposed );
    
    rows := [ 1 .. Length( inequalities_list ) ];
    
    rows := Filtered( rows, i -> not i in localized_variables );
    
    inequalities_list := List( rows, i -> inequalities_list[ i ] );
    
    inequalities_list := List( inequalities_list, i -> Concatenation( [ 0 ], i ) );
    
    inequalities_polytope := PolyhedronByInequalities( inequalities_list );
    
    generating_set := LatticePointsGenerators( inequalities_polytope );
    
    generating_set_hilbert := List( generating_set[ 2 ], g -> Concatenation( [ 0 ], g ) );
    
    generating_set_linear := List( generating_set[ 3 ], g -> Concatenation( [ 0 ], g ) );
    
    monomial_transformation := EntriesOfHomalgMatrixAsListList( kernel_of_degree_matrix );
        
    for current_part in [ generating_set_hilbert, generating_set_linear ] do
    
        Apply( current_part, i -> i{[ 2 .. Length( i ) ]} );
        Apply( current_part, i -> i * monomial_transformation );
        
    od;
    
    generating_set := Concatenation( generating_set_hilbert, generating_set_linear, - generating_set_linear );
    
    return generating_set;
    
end );

BindGlobal( "CAP_INTERNAL_construct_quotient_ring",
  function( generating_monomials, k )
    local monomials, relations, indet_string, ring, indeterminates, i, j, left_side, right_side;
    
    monomials := generating_monomials;
    
    if monomials <> [ ] then
        relations := 4ti2Interface_groebner_matrix( monomials );
    else
        relations := [ ];
    fi;
    
    indet_string := List( [ 1 .. Length( monomials ) ], i -> Concatenation( "t", String( i ) ) );
    
    indet_string := JoinStringsWithSeparator( indet_string, "," );
    
    ring := k * indet_string;
    
    if relations <> [ ] then
        
        indeterminates := Indeterminates( ring );
        
        for i in [ 1 .. Length( relations ) ] do
            
            left_side := indeterminates[ 1 ]^0;
            right_side := indeterminates[ 1 ]^0;
            
            for j in [ 1 .. Length( indeterminates ) ] do
                
                if relations[ i ][ j ] > 0 then
                    left_side := left_side*indeterminates[ j ]^relations[ i ][ j ];
                elif relations[ i ][ j ] < 0 then
                    right_side := right_side*indeterminates[ j ]^( - relations[ i ][ j ] );
                fi;
                
            od;
            
            relations[ i ] := left_side - right_side;
            
        od;
        
        return ring/relations;
        
    fi;
    
    return ring;
    
end );


BindGlobal( "CAP_INTERNAL_degree_basis",
  function( degree_matrix, kernel_of_degree_matrix, localized_variables, degree )
    local degree_matrix_list, translation_vector, kernel_of_degree_matrix_transposed,
          inequalities_list, rows, inequalities_polytope, generating_set, monomial_transformation;
    
    degree_matrix_list := EntriesOfHomalgMatrixAsListList( degree_matrix );
    
    translation_vector := SolutionIntMat( degree_matrix_list, degree );
    
    kernel_of_degree_matrix_transposed := Involution( kernel_of_degree_matrix );
    
    inequalities_list := EntriesOfHomalgMatrixAsListList( kernel_of_degree_matrix_transposed );
    
    rows := [ 1 .. Length( inequalities_list ) ];
    
    rows := Filtered( rows, i -> not i in localized_variables );
    
    inequalities_list := List( rows, i -> Concatenation( [ translation_vector[ i ] ], inequalities_list[ i ] ) );

    inequalities_polytope := PolyhedronByInequalities( inequalities_list );
    
    generating_set := LatticePointsGenerators( inequalities_polytope );
    
    generating_set := List( generating_set[ 1 ], g -> Concatenation( [ 1 ], g ) );
    
    monomial_transformation := EntriesOfHomalgMatrixAsListList( kernel_of_degree_matrix );
    
    Apply( generating_set, i -> i{[ 2 .. Length( i ) ]} );
    Apply( generating_set, i -> i * monomial_transformation );
    Apply( generating_set, i -> i + translation_vector );
    
    return generating_set;
    
end );

BindGlobal( "CAP_INTERNAL_degree_part_relations",
  function( degree_zero_generating_set, degree_basis_elements )
    local homogeneous_cone_basis, relation_point_matrix,
          polytope_i, polytope_j, intersection_polytope, intersection_lattice_points_generators, i, j, monomial_solution,
          transposed_degree_zero_generating_set, positive_orthant_inequalities, positive_orthant_inequalities_rhs, current_vector,
          current_intersected_point, homogeneous_points_i, homogeneous_points_j;
    
    homogeneous_cone_basis := List( degree_zero_generating_set, i -> Concatenation( [ 0 ], i ) );
    
    relation_point_matrix := [ ];
    
    if degree_zero_generating_set = [ ] then
        return relation_point_matrix;
    fi;
    
    transposed_degree_zero_generating_set := TransposedMat( degree_zero_generating_set );
    positive_orthant_inequalities := IdentityMat( Length( degree_zero_generating_set[ 1 ] ) );
    positive_orthant_inequalities_rhs := ListWithIdenticalEntries( Length( degree_zero_generating_set[ 1 ] ), 0 );
    
    for i in [ 1 .. Length( degree_basis_elements ) ] do
        for j in [ i + 1 .. Length( degree_basis_elements ) ] do
            
            if homogeneous_cone_basis = [ ] then
                continue;
            fi;
            
            homogeneous_points_i := Concatenation( homogeneous_cone_basis, [ Concatenation( [ 1 ], degree_basis_elements[ i ] ) ] );
            homogeneous_points_j := Concatenation( homogeneous_cone_basis, [ Concatenation( [ 1 ], degree_basis_elements[ j ] ) ] );

            if not ForAll( homogeneous_points_i, P -> P[1] = 1 ) then
              Error( "the first entry is supposed to be 1" );
            fi;

            if not ForAll( homogeneous_points_j, P -> P[1] = 1 ) then
              Error( "the first entry is supposed to be 1" );
            fi;

            Perform( homogeneous_points_i, P -> Remove( P, 1 ) );
            Perform( homogeneous_points_j, P -> Remove( P, 1 ) );

            polytope_i := Polytope( homogeneous_points_i );
            polytope_j := Polytope( homogeneous_points_j );
            
            intersection_polytope := IntersectionOfPolytopes( polytope_i, polytope_j );
            
            intersection_lattice_points_generators := LatticePointsGenerators( intersection_polytope )[ 1 ];
            
#             if Length( intersection_lattice_points_generators ) > 1 then
#                 Error( "something went wrong: Too many lattice points in intersection" );
#             fi;
            
            if intersection_lattice_points_generators = [ ] then
                continue;
            fi;
            
            for current_intersected_point in intersection_lattice_points_generators do
                
                current_vector := ListWithIdenticalEntries( Length( degree_basis_elements ), 0 );
                
                current_intersected_point := current_intersected_point{[ 2 .. Length( current_intersected_point ) ]};
                
                monomial_solution := 4ti2Interface_zsolve_equalities_and_inequalities(
                                        transposed_degree_zero_generating_set, current_intersected_point - degree_basis_elements[ j ],
                                        positive_orthant_inequalities, positive_orthant_inequalities_rhs );
                
                current_vector[ i ] := monomial_solution[ 1 ][ 1 ];
                
                monomial_solution := 4ti2Interface_zsolve_equalities_and_inequalities( 
                                        transposed_degree_zero_generating_set, current_intersected_point - degree_basis_elements[ i ], 
                                        positive_orthant_inequalities, positive_orthant_inequalities_rhs );
                
                current_vector[ j ] := monomial_solution[ 1 ][ 1 ];
                
                Add( relation_point_matrix, current_vector );
                
            od;
        od;
    od;
    
    return relation_point_matrix;
    
end );

BindGlobal( "CAP_INTERNAL_hom_part_relations",
  function( module_generators, relation_matrix, new_base_ring )
    local relation_matrix_vectors, i, j, current_vector, ring_indets;
    
    relation_matrix_vectors := [ ];
    ring_indets := Indeterminates( new_base_ring );
    
    for i in [ 1 .. Length( relation_matrix ) ] do
        
        current_vector := ListWithIdenticalEntries( Length( relation_matrix ), 0 );
        
        for j in [ 1 .. Length( relation_matrix[ i ] ) ] do
            
            if relation_matrix[ i ][ j ] = 0 then
                continue;
            fi;
            
            current_vector[ i ] := Product( [ 1 .. Length( ring_indets ) ], k -> ring_indets[ k ]^relation_matrix[ i ][ j ][ k ] );
            current_vector[ j ] := - Product( [ 1 .. Length( ring_indets ) ], k -> ring_indets[ k ]^relation_matrix[ i ][ j ][ k ] );
            
        od;
        
        Append( relation_matrix_vectors, current_vector );
    od;
    
    
    if relation_matrix_vectors = [ ] then
        
        return HomalgZeroMatrix( 0, Length( module_generators ), new_base_ring );
        
    fi;
    
    return HomalgMatrix( relation_matrix_vectors, Length( relation_matrix ), Length( relation_matrix[ 1 ] ), new_base_ring );
    
end );

BindGlobal( "CAP_INTERNAL_get_image_of_generator",
  function( generator, homalg_ring_element )
    local element_exponents;
    
    element_exponents := CommonHomalgTableForSingularTools.PolynomialExponents( UnderlyingNonGradedRingElement( homalg_ring_element ) );
    
    return List( element_exponents, i -> i + generator );
    
end );

BindGlobal( "CAP_INTERNAL_result_of_generator",
  function( generator, element, new_generators, base_ring_generators )
    local image_of_generator, base_ring_generators_transposed, collected_vectors, current_monomial, i, current_solution,
          inequality_matrix_list, inequality_matrix_list_rhs;
    
    image_of_generator := CAP_INTERNAL_get_image_of_generator( generator, element );
    
    collected_vectors := [ ];
    
    if base_ring_generators <> [ ] then
    
        base_ring_generators_transposed := TransposedMat( base_ring_generators );
        
        inequality_matrix_list := IdentityMat( Length( base_ring_generators_transposed[ 1 ] ) );
        inequality_matrix_list_rhs := ListWithIdenticalEntries( Length( base_ring_generators_transposed[ 1 ] ), 0 );
        
        for current_monomial in image_of_generator do
            
            for i in [ 1 .. Length( new_generators ) ] do
                
                ## Unfortunately, there is a bug in 4ti2, not displaying 0 as a solution if
                ## it is the only solution present. We are nevertheless going to prefer this solution.
                
                if ForAll( current_monomial - new_generators[ i ], i -> i = 0 ) then
                    Add( collected_vectors, [ i, 0 ] );
                    break;
                fi;
                
                current_solution := 4ti2Interface_zsolve_equalities_and_inequalities(
                                        base_ring_generators_transposed, current_monomial - new_generators[ i ],
                                        inequality_matrix_list, inequality_matrix_list_rhs );
                
                if current_solution <> [ ] and current_solution[ 1 ] <> [ ] then
                    Add( collected_vectors, [ i, current_solution[ 1 ][ 1 ] ] );
                    break;
                fi;
                
            od;
            
        od;
        
    else
        
        for current_monomial in image_of_generator do
            
            for i in [ 1 .. Length( new_generators ) ] do
                
                if current_monomial = new_generators[ i ] then
                    
                    Add( collected_vectors, [ i, 0 ] );
                    
                fi;
                
            od;
        od;
        
    fi;
    
    return collected_vectors;
    
end );

BindGlobal( "CAP_INTERNAL_block_matrix_to_matrix",
  function( block_matrix )
    local cols, rows, i, j, k, current_row, current_row_lenth, current_row_cols,
          current_single_row, resulting_mat;
    
    rows := Length( block_matrix );
    cols := Length( block_matrix[ 1 ] );
    
    resulting_mat := [ ];
    
    for i in [ 1 .. rows ] do
        current_row := block_matrix[ i ];
        current_row_lenth := Length( current_row );
        current_row_cols := Length( current_row[ 1 ] );
        
        for j in [ 1 .. current_row_cols ] do
            current_single_row := [ ];
            for k in [ 1 .. current_row_lenth ] do
                Append( current_single_row, current_row[ k ][ j ] );
            od;
            Add( resulting_mat, current_single_row );
            
        od;
        
    od;
    
    return resulting_mat;
    
end );

BindGlobal( "CAP_INTERNAL_degree_zero_ring_and_generators",
  function( ring_degrees, kernel_of_ring_degrees, localized_variables, k )
    local ring_generators, ring_as_quotient;
    
    ring_generators := CAP_INTERNAL_degree_zero_monomials( ring_degrees, kernel_of_ring_degrees, localized_variables );
    
    ring_as_quotient := CAP_INTERNAL_construct_quotient_ring( ring_generators, k );
    
    return [ ring_generators, ring_as_quotient ];
    
end );

BindGlobal( "CAP_INTERNAL_FIND_POSITION_BY_FUNCTION",
  function( list, func )
    local i;
    
    for i in [ 1 .. Length( list ) ] do
        if func( list[ i ] ) = true then
            return i;
        fi;
    od;
    return fail;
    
end );

BindGlobal( "CAP_INTERNAL_get_module_generators_and_relations",
  function( degree_list, ring_degrees, kernel_of_ring_degrees, localized_variables, ring_generators, new_ring )
    local current_source_part, current_position, current_generators, current_relation_matrix,
          module_generators, modules, empty_gens;
    
    module_generators := [ ];
    modules := [ ];
    empty_gens := [ ];
    
    for current_source_part in [ 1 .. Length( degree_list ) ] do
        current_position := CAP_INTERNAL_FIND_POSITION_BY_FUNCTION( new_ring!.generators_of_hom_parts_from_including_graded_ring,
                                                                    i -> i[ 1 ] = degree_list[ current_source_part ] );
        
        if current_position = fail then
            current_generators := CAP_INTERNAL_degree_basis( ring_degrees, kernel_of_ring_degrees, localized_variables, - degree_list[ current_source_part ] );
        else
            current_generators := new_ring!.generators_of_hom_parts_from_including_graded_ring[ current_position ][ 2 ];
        fi;
        
        if current_generators = [ ] then
            Add( empty_gens, current_source_part );
        else
            Add( module_generators, current_generators );
        fi;
        
        if current_position = fail and current_generators <> [ ] then
            current_relation_matrix := CAP_INTERNAL_degree_part_relations( ring_generators, current_generators );
            current_relation_matrix := CAP_INTERNAL_hom_part_relations( current_generators, current_relation_matrix, new_ring );
            Add( modules, current_relation_matrix );
        elif current_generators = [ ] then
            current_relation_matrix := [ ];
        else
            current_relation_matrix := new_ring!.generators_of_hom_parts_from_including_graded_ring[ current_position ][ 3 ];
            Add( modules, current_relation_matrix );
        fi;
        
        if current_position = fail then
            Add( new_ring!.generators_of_hom_parts_from_including_graded_ring, [ degree_list[ current_source_part ], current_generators, current_relation_matrix ] );
        fi;
        
    od;
    
    return [ module_generators, modules, empty_gens ];
    
end );

BindGlobal( "CAP_INTERNAL_new_matrix_mapping_by_generator_lists",
  function( source_generator_list_list, range_generator_list_list, homalg_matrix_as_list_list, ring_generators, new_ring )
    local mapped_matrix, polynomial_coeffs, i, j, matrix_prototype, k, current_source_generator_map, l, matrix_mapping, base_ring_indets;
    
    base_ring_indets := Indeterminates( new_ring );
    
    mapped_matrix := List( source_generator_list_list, i -> ListWithIdenticalEntries( Length( range_generator_list_list ), 0 ) );
    
    for i in [ 1 .. Length( source_generator_list_list ) ] do
        for j in [ 1 .. Length( range_generator_list_list ) ] do
            mapped_matrix[ i ][ j ] := List( source_generator_list_list[ i ],
                                                              k -> CAP_INTERNAL_result_of_generator( k, homalg_matrix_as_list_list[ i ][ j ],
                                                                                        range_generator_list_list[ j ], ring_generators ) );
        od;
    od;
    
    polynomial_coeffs := List( homalg_matrix_as_list_list, i -> List( i, j -> SplitString( CommonHomalgTableForSingularTools.PolynomialCoefficients( UnderlyingNonGradedRingElement( j ) ), "," ) ) );
    
    for i in [ 1 .. Length( source_generator_list_list ) ] do
        for j in [ 1 .. Length( range_generator_list_list ) ] do
            
            matrix_prototype := List( [ 1 .. Length( source_generator_list_list[ i ] ) ], x -> List( [ 1 .. Length( range_generator_list_list[ j ] ) ], y -> [ ] ) );
            
            for k in [ 1 .. Length( mapped_matrix[ i ][ j ] ) ] do
                current_source_generator_map := mapped_matrix[ i ][ j ][ k ];
                
                for l in [ 1 .. Length( current_source_generator_map ) ] do
                    
                    Add( matrix_prototype[ k ][ current_source_generator_map[ l ][ 1 ] ], polynomial_coeffs[ i ][ j ][ l ] );
                    
                    if( current_source_generator_map[ l ][ 2 ] = 0 ) then
                        Add( matrix_prototype[ k ][ current_source_generator_map[ l ][ 1 ] ], String( 1 ) );
                    else
                        Add( matrix_prototype[ k ][ current_source_generator_map[ l ][ 1 ] ], 
                            String( Product( [ 1 .. Length( base_ring_indets ) ], x -> base_ring_indets[ x ]^current_source_generator_map[ l ][ 2 ][ x ] ) ) );
                    fi;
                    
                od;
                
            od;
            
            for k in [ 1 .. Length( source_generator_list_list[ i ] ) ] do
                for l in [ 1 .. Length( range_generator_list_list[ j ] ) ] do
                    if matrix_prototype[ k ][ l ] = [ ] then
                        matrix_prototype[ k ][ l ] := String( 0 );
                    else
                        matrix_prototype[ k ][ l ] := JoinStringsWithSeparator( matrix_prototype[ k ][ l ], "*" );
                    fi;
                od;
            od;
            
            mapped_matrix[ i ][ j ] := matrix_prototype;
            
        od;
    od;
    
    matrix_mapping := CAP_INTERNAL_block_matrix_to_matrix( mapped_matrix );
    
    matrix_mapping := HomalgMatrix( matrix_mapping, new_ring );
    
    return matrix_mapping;
    
end );

BindGlobal( "CAP_INTERNAL_degree_zero_module",
  function( source_degrees, matrix, range_degrees, ring_degrees, kernel_of_ring_degrees, localized_variables, ring_generators, new_ring )
    local ring_relations, source_data, range_data, homalg_matrix_as_list_list, i, new_matrix, source_module, range_module, new_object;
    
    if not IsBound( new_ring!.generators_of_hom_parts_from_including_graded_ring ) then
        new_ring!.generators_of_hom_parts_from_including_graded_ring := [ ];
    fi;
    
    source_data := CAP_INTERNAL_get_module_generators_and_relations( source_degrees, ring_degrees, kernel_of_ring_degrees, localized_variables, ring_generators, new_ring );
    range_data := CAP_INTERNAL_get_module_generators_and_relations( range_degrees, ring_degrees, kernel_of_ring_degrees, localized_variables, ring_generators, new_ring );
    
    if range_data[ 1 ] = [ ] then
        FreeLeftPresentation( 0, new_ring );
    fi;
    
    homalg_matrix_as_list_list := EntriesOfHomalgMatrixAsListList( matrix );
    
    for i in Reversed( source_data[ 3 ] ) do
        Remove( homalg_matrix_as_list_list, i );
    od;
    homalg_matrix_as_list_list := TransposedMatMutable( homalg_matrix_as_list_list );
    for i in Reversed( range_data[ 3 ] ) do
        Remove( homalg_matrix_as_list_list, i );
    od;
    homalg_matrix_as_list_list := TransposedMatMutable( homalg_matrix_as_list_list );
    
    new_matrix := CAP_INTERNAL_new_matrix_mapping_by_generator_lists( source_data[ 1 ], range_data[ 1 ], homalg_matrix_as_list_list, ring_generators, new_ring );
    
    source_module := DirectSum( List( source_data[ 2 ], AsLeftPresentation ) );
    
    range_module := DirectSum( List( range_data[ 2 ], AsLeftPresentation ) );
    
    new_object := CokernelObject( PresentationMorphism( source_module, new_matrix, range_module ) );
    
    new_object!.degree_part_generator_monomials := range_data[ 1 ];
    new_object!.deleted_free_parts := range_data[ 3 ];
    
    return new_object;
    
end );
