#############################################################################
##
##                                               ToricSheaves package
##
##  Copyright 2016, Sebastian Gutsche, Universität Siegen
##                  Sebastian Posur,   Universität Siegen
##
#############################################################################

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
    
    inequalities_polytope := POLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES( inequalities_list );
    
    generating_set := POLYMAKE_LATTICE_POINTS_GENERATORS( inequalities_polytope );
    
    generating_set_hilbert := generating_set[ 2 ];
    
    generating_set_linear := generating_set[ 3 ];
    
    monomial_transformation := EntriesOfHomalgMatrixAsListList( kernel_of_degree_matrix );
        
    for current_part in [ generating_set_hilbert, generating_set_linear ] do
    
        Apply( current_part, i -> i{[ 2 .. Length( i ) ]} );
        Apply( current_part, i -> i * monomial_transformation );
        
    od;
    
    generating_set := Concatenation( generating_set_hilbert, generating_set_linear, - generating_set_linear );
    
    return generating_set;
    
end );

BindGlobal( "CAP_INTERNAL_construct_quotient_ring",
  function( generating_monomials )
    local monomials, relations, indet_string, ring, indeterminates;
    
    monomials := generating_monomials;
    
    if monomials <> [ ] then
        relations := 4ti2Interface_groebner_matrix( monomials );
    else
        relations := [ ];
    fi;
    
    indet_string := List( [ 1 .. Length( monomials ) ], i -> Concatenation( "t", String( i ) ) );
    
    indet_string := JoinStringsWithSeparator( indet_string, "," );
    
    ring := HomalgFieldOfRationalsInSingular()*indet_string;
    
    if relations <> [ ] then
        
        indeterminates := Indeterminates( ring );
        
        relations := List( relations, i -> Product( [ 1 .. Length( i ) ], j -> indeterminates[ j ]^i[ j ] ) );
        
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
    
    inequalities_polytope := POLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES( inequalities_list );
    
    generating_set := POLYMAKE_LATTICE_POINTS_GENERATORS( inequalities_polytope );
    
    generating_set := generating_set[ 1 ];
    
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
          transposed_degree_zero_generating_set, positive_orthant_inequalities, positive_orthant_inequalities_rhs;
    
    homogeneous_cone_basis := List( degree_zero_generating_set, i -> Concatenation( [ 0 ], i ) );
    
    relation_point_matrix := List( [ 1 .. Length( degree_basis_elements ) ], i -> List( [ 1 .. Length( degree_basis_elements ) ], j -> fail ) );
    
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
            
            polytope_i := POLYMAKE_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS( Concatenation( homogeneous_cone_basis, [ Concatenation( [ 1 ], degree_basis_elements[ i ] ) ] ) );
            polytope_j := POLYMAKE_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS( Concatenation( homogeneous_cone_basis, [ Concatenation( [ 1 ], degree_basis_elements[ j ] ) ] ) );
            
            intersection_polytope := POLYMAKE_INTERSECTION_OF_POLYTOPES( polytope_i, polytope_j );
            
            intersection_lattice_points_generators := POLYMAKE_LATTICE_POINTS_GENERATORS( intersection_polytope )[ 1 ];
            
            if Length( intersection_lattice_points_generators ) > 1 then
                Error( "something went wrong: Too many lattice points in intersection" );
            fi;
            
            if intersection_lattice_points_generators = [ ] then
                continue;
            fi;
            
            relation_point_matrix[ i ][ j ] := intersection_lattice_points_generators[ 1 ];
            relation_point_matrix[ i ][ j ] := relation_point_matrix[ i ][ j ]{[ 2 .. Length( relation_point_matrix[ i ][ j ] ) ]};
            
            monomial_solution := 4ti2Interface_zsolve_equalities_and_inequalities(
                                     transposed_degree_zero_generating_set, relation_point_matrix[ i ][ j ] - degree_basis_elements[ j ],
                                     positive_orthant_inequalities, positive_orthant_inequalities_rhs );
            
            relation_point_matrix[ j ][ i ] := monomial_solution[ 1 ][ 1 ];
            
            monomial_solution := 4ti2Interface_zsolve_equalities_and_inequalities( 
                                     transposed_degree_zero_generating_set, relation_point_matrix[ i ][ j ] - degree_basis_elements[ i ], 
                                     positive_orthant_inequalities, positive_orthant_inequalities_rhs );
            
            relation_point_matrix[ i ][ j ] := monomial_solution[ 1 ][ 1 ];
            
        od;
    od;
    
    return relation_point_matrix;
    
end );

BindGlobal( "CAP_INTERNAL_construct_ring_relation_matrix",
  function( new_base_ring, relation_matrix )
    local ring_indets, i, j;
    
    ring_indets := Indeterminates( new_base_ring );
    
    for i in [ 1 .. Length( relation_matrix ) ] do
        for j in [ 1 .. Length( relation_matrix[ 1 ] ) ] do
            if relation_matrix[ i ][ j ] = 0 then
                continue;
            fi;
            relation_matrix[ i ][ j ] := Product( [ 1 .. Length( ring_indets ) ], k -> ring_indets[ k ]^relation_matrix[ i ][ j ][ k ] );
            if i > j then
                relation_matrix[ i ][ j ] := - relation_matrix[ i ][ j ];
            fi;
        od;
    od;
    
    return HomalgMatrix( relation_matrix, new_base_ring );
    
end );

BindGlobal( "CAP_INTERNAL_hom_part_relations",
  function( relation_matrix, new_base_ring )
    local relation_matrix_vectors, i, j, current_vector, ring_indets;
    
    relation_matrix_vectors := [ ];
    ring_indets := Indeterminates( new_base_ring );
    
    for i in [ 1 .. Length( relation_matrix ) ] do
        for j in [ i + 1 .. Length( relation_matrix ) ] do
            
            if relation_matrix[ i ][ j ] = fail then
                continue;
            fi;

            current_vector := ListWithIdenticalEntries( Length( relation_matrix ), 0 );
            
            current_vector[ i ] := Product( [ 1 .. Length( ring_indets ) ], k -> ring_indets[ k ]^relation_matrix[ i ][ j ][ k ] );
            current_vector[ j ] := - Product( [ 1 .. Length( ring_indets ) ], k -> ring_indets[ k ]^relation_matrix[ i ][ j ][ k ] );
            
            Append( relation_matrix_vectors, current_vector );
            
        od;
    od;
    
    
    if relation_matrix_vectors = [ ] then
        
        return HomalgZeroMatrix( 0, Length( relation_matrix ), new_base_ring );
        
    fi;
    
    return HomalgMatrix( relation_matrix_vectors, Length( relation_matrix_vectors ), Length( relation_matrix ), new_base_ring );
    
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

BindGlobal( "CAP_INTERNAL_compute_degree_zero_part",
  function( source_degrees, matrix, range_degrees, ring_degrees, kernel_of_ring_degrees, localized_variables )
    local degree_zero_part_of_ring, source_module_generators, range_module_generators, homalg_matrix_as_list_list,
          i, j, k, l, polynomial_coeffs, empty_sources, empty_ranges, new_base_ring, current_relation_matrix,
          base_ring_indets, source_modules, source_module, range_modules, range_module, matrix_prototype,
          current_source_generator_map, matrix_mapping;
    
    degree_zero_part_of_ring := CAP_INTERNAL_degree_zero_monomials( ring_degrees, kernel_of_ring_degrees, localized_variables );
    
    source_module_generators := List( source_degrees, i -> CAP_INTERNAL_degree_basis( ring_degrees, kernel_of_ring_degrees, localized_variables, i ) );
    
    range_module_generators := List( range_degrees, i -> CAP_INTERNAL_degree_basis( ring_degrees, kernel_of_ring_degrees, localized_variables, i ) );
    
    homalg_matrix_as_list_list := EntriesOfHomalgMatrixAsListList( matrix );
    
    empty_sources := Filtered( [ 1 .. Length( source_module_generators ) ], i -> source_module_generators[ i ] = [ ] );
    
    empty_ranges := Filtered( [ 1 .. Length( range_module_generators ) ], i -> range_module_generators[ i ] = [ ] );
    
    for i in Reversed( empty_sources ) do
        
        Remove( source_module_generators, i );
        
        Remove( homalg_matrix_as_list_list, i );
        
    od;
    
    homalg_matrix_as_list_list := TransposedMatMutable( homalg_matrix_as_list_list );
    
    for i in Reversed( empty_ranges ) do
        
        Remove( range_module_generators, i );
        
        Remove( homalg_matrix_as_list_list, i );
        
    od;
    
    homalg_matrix_as_list_list := TransposedMatMutable( homalg_matrix_as_list_list );
    
    new_base_ring := CAP_INTERNAL_construct_quotient_ring( degree_zero_part_of_ring );
    
    if range_module_generators = [ ] then
        
        return ZeroMorphism( FreeLeftPresentation( 0, new_base_ring ) );
        
    fi;
    
    for i in [ 1 .. NrRows( matrix ) ] do
        for j in [ 1 .. NrColumns( matrix ) ] do
            homalg_matrix_as_list_list[ i ][ j ] := List( source_module_generators[ i ],
                                                              k -> CAP_INTERNAL_result_of_generator( k, homalg_matrix_as_list_list[ i ][ j ],
                                                                                        range_module_generators[ j ], degree_zero_part_of_ring ) );
        od;
    od;
    
    ## compute ring
    
    base_ring_indets := Indeterminates( new_base_ring );
    
    ## construct modules
    
    source_modules := [ ];
    
    for i in [ 1 .. Length( source_module_generators ) ] do
        
        current_relation_matrix := CAP_INTERNAL_degree_part_relations( degree_zero_part_of_ring, source_module_generators[ i ] );
        
        current_relation_matrix := CAP_INTERNAL_hom_part_relations( current_relation_matrix, new_base_ring );
        
        source_modules[ i ] := current_relation_matrix;
        
    od;
    
    range_modules := [ ];
    
    for i in [ 1 .. Length( range_module_generators ) ] do
        
        current_relation_matrix := CAP_INTERNAL_degree_part_relations( degree_zero_part_of_ring, range_module_generators[ i ] );
        
        current_relation_matrix := CAP_INTERNAL_hom_part_relations( current_relation_matrix, new_base_ring );
        
        range_modules[ i ] := current_relation_matrix;
        
    od;
    
    ## reconstruct matrix
    
    polynomial_coeffs := EntriesOfHomalgMatrixAsListList( matrix );
    
    polynomial_coeffs := List( polynomial_coeffs, i -> List( i, j -> SplitString( CommonHomalgTableForSingularTools.PolynomialCoefficients( UnderlyingNonGradedRingElement( j ) ), "," ) ) );
    
    for i in [ 1 .. NrRows( matrix ) ] do
        for j in [ 1 .. NrColumns( matrix ) ] do
            
            matrix_prototype := List( [ 1 .. Length( source_module_generators[ i ] ) ], x -> List( [ 1 .. Length( range_module_generators[ j ] ) ], y -> [ ] ) );
            
            for k in [ 1 .. Length( homalg_matrix_as_list_list[ i ][ j ] ) ] do
                current_source_generator_map := homalg_matrix_as_list_list[ i ][ j ][ k ];
                
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
            
            for k in [ 1 .. Length( source_module_generators[ i ] ) ] do
                for l in [ 1 .. Length( range_module_generators[ j ] ) ] do
                    if matrix_prototype[ k ][ l ] = [ ] then
                        matrix_prototype[ k ][ l ] := String( 0 );
                    else
                        matrix_prototype[ k ][ l ] := JoinStringsWithSeparator( matrix_prototype[ k ][ l ], "*" );
                    fi;
                od;
            od;
            
            homalg_matrix_as_list_list[ i ][ j ] := matrix_prototype;
            
        od;
    od;
    
    matrix_mapping := CAP_INTERNAL_block_matrix_to_matrix( homalg_matrix_as_list_list );
    
    matrix_mapping := HomalgMatrix( matrix_mapping, new_base_ring );
    
    source_module := DirectSum( List( source_modules, AsLeftPresentation ) );
    
    range_module := DirectSum( List( range_modules, AsLeftPresentation ) );
    
    return PresentationMorphism( source_module, matrix_mapping, range_module );
    
end );
