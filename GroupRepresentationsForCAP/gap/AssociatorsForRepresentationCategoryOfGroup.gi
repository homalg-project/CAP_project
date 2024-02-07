# SPDX-License-Identifier: GPL-2.0-or-later
# GroupRepresentationsForCAP: Skeletal category of group representations for CAP
#
# Implementations
#
InstallValue( ASSOCIATORS_Setup, rec(
    
    ZZ := HomalgRingOfIntegers(),
    
    e := X( Rationals ),
    
    database_keys := [ ],
    
    initialize_group_data_log_list := [ ],
    
    skeletalfunctortensordata_log_list := [ ],
    
    associator_data := [ ],
    
    InfoLevelForAssociatorComputations := 0
    
  )
);

###################################
##
## Computing associators
##
###################################

##
InstallMethod( InitializeGroupDataDixon,
               [ IsGroup ],
               
  function( group )
      
      return InitializeGroupDataDixon( group, false );
      
end );

##
InstallMethod( InitializeGroupDataDixon,
               [ IsGroup, IsBool ],
               
  function( group, use_group_string_as_id )
      
      return InitializeGroupData( group, AffordAllIrreducibleRepresentationsDixon( group ), use_group_string_as_id );
      
end );

##
InstallMethod( InitializeGroupData,
               [ IsGroup ],
               
  function( group )
      
      return InitializeGroupData( group, false );
      
end );

##
InstallMethod( InitializeGroupData,
               [ IsGroup, IsBool ],
               
  function( group, use_group_string_as_id )
      
      return InitializeGroupData( group, AffordAllIrreducibleRepresentations( group ), use_group_string_as_id );
      
end );

##
InstallMethod( InitializeGroupData,
               [ IsGroup, IsList, IsBool ],
               
  function( group, representation_list, use_group_string_as_id )
    local default_field, conductor, representation, entry, degree_of_representation, vector_space,
          generator, gap_matrix, homalg_matrix, CAP_representation_list, ZZ, size, i, gen1, gen2,
          log_string, group_string_for_creation, log_list, reps_as_string, group_generators,
          list_of_characters, field, vector_space_object_list;
    
    log_list := [ ];
    
    SetName( ASSOCIATORS_Setup.e, "e" );
    
    size := Size( group );
    
    group_generators := GeneratorsOfGroup( group );
    
    # try to find two generators
    
    if Size( group_generators ) > 2 then
        
        for i in [ 1 .. 10 ] do
            
            gen1 := Random( group );
            
            gen2 := Random( group );
            
            if size = Size( Group( [ gen1, gen2 ] ) ) then
                
                group_generators := [ gen1, gen2 ];
                
                if ASSOCIATORS_Setup.InfoLevelForAssociatorComputations > 0 then
                    
                    Print( "Found 2 generators for the group using random elements\n" );
                    
                fi;
                
                break;
                
            fi;
            
        od;
        
    fi;
    
    Add( log_list, group_generators );
    
    Add( log_list, Size( group_generators ) );
    
    list_of_characters := Irr( group ); ## WARNING: this has to be the same order as the representations in representation_list
    
    Add( log_list, list_of_characters );
    
    default_field := DefaultFieldForListOfRepresentations( representation_list );
    
    conductor := Conductor( default_field );
    
    if conductor = 1 then
        
        field := HomalgFieldOfRationalsInDefaultCAS();
        
    else
        
        field := HomalgCyclotomicFieldInMAGMA( conductor, "e" );
        
    fi;
    
    vector_space_object_list := 
      List( list_of_characters, chi -> VectorSpaceObject( Degree( chi ), field ) );
    
    CAP_representation_list := [ ];
    
    ZZ := ASSOCIATORS_Setup.ZZ;
    
    ## This for-loop
    ## creates a list of CAP matrices over the correct field
    ## from the list of representations
    for representation in representation_list do
        
        entry := [ ];
        
        degree_of_representation := DimensionOfMatrixGroup( Range( representation ) );
        
        vector_space := VectorSpaceObject( degree_of_representation, field );
        
        for generator in group_generators do
          
          gap_matrix := generator^representation;
          
          if conductor > 1 then
              
              gap_matrix := RewriteMatrixInCyclotomicGenerator( gap_matrix, conductor );
              
              gap_matrix := field * HomalgMatrix( gap_matrix, ZZ );
              
          fi;
          
          homalg_matrix :=
                HomalgMatrix( gap_matrix, degree_of_representation, degree_of_representation, field );
          
          Add( entry, VectorSpaceMorphism( vector_space, homalg_matrix, vector_space ) );
          
        od;
        
        Add( CAP_representation_list, entry );
        
    od;
    
    Add( log_list, CAP_representation_list );
    
    Add( log_list, List( CAP_representation_list, images -> List( images, image -> Inverse( image ) ) ) );
    
    Add( log_list, vector_space_object_list );
    
    if use_group_string_as_id then
        
        group_string_for_creation := String( group );
        
    else
        
        group_string_for_creation := String( IdGroup( group ) );
        
        RemoveCharacters( group_string_for_creation, "\[\]\ " );
        
    fi;
    
    ASSOCIATORS_Setup.database_keys := [
        
        group_string_for_creation,
        conductor,
        PositionProperty( list_of_characters, IsOne )
        
    ];
    
    ASSOCIATORS_Setup.initialize_group_data_log_list := log_list;
    
    reps_as_string :=
      String( List( log_list[4], rep -> List( rep, mor -> HomalgMatrixAsString( UnderlyingMatrix( mor ) ) ) ) );
    
    RemoveCharacters( reps_as_string, " " );
    
    ASSOCIATORS_Setup.initialize_group_data_log_list_as_string := Concatenation(
      "[", String( List( log_list[1], elem -> String( elem ) ) ), ",\n",
      "\"", String( log_list[3] ), "\"", ",\n",
      reps_as_string, ",\n",
      String( List( log_list[6], space -> Dimension( space ) ) ), "]" );
    
    return log_list;
    
end );

##
InstallMethod( SkeletalFunctorTensorData,
               [ ],
               
  function( )
      local l;
      
      if not IsBound( ASSOCIATORS_Setup.initialize_group_data_log_list ) then
          
          Error( "Initialize group data first via the command: InitializeGroupData( group )" );
          
          return;
          
      fi;
      
      return SkeletalFunctorTensorData( ASSOCIATORS_Setup.initialize_group_data_log_list );
      
end );

# Input: A list of representations of G
# Output: For every triple A,B,C of representations,
# the subspace of Hom( C, A \otimes B ) consisting of G equivariant maps
# as a k-vector space.
InstallMethod( SkeletalFunctorTensorData,
               [ IsList ],
               
  function( initialize_group_data_log_list )
    local l, indices, CAP_representation_list, rep1, gen, rep2, tensor_product_on_objects, tensor_product_on_morphisms,
          indices_using_braiding, indices_not_using_braiding, CAP_representation_list_inverses,
          nr_generators, mor_list, result_list, rep3, Gmorphisms, i, j, k, obj, id, kernel_embeddings,
          degree1, degree2, degree3, rep1_vector_space_object, rep2_vector_space_object, rep3_vector_space_object,
          character1, character2, character3, scalar_product, elements_of_internal_hom, results_with_fixed_i_and_j, decomposition_morphism,
          identity_morphism, results_with_fixed_i, rep3_inverse, nr_characters, braiding, vector_space_object_list,
          embedding_of_k_component, skeletal_braiding_in_kvec, transformation_matrix, decomposition_morphism_inverse,
          square_matrix_size, matrix_string, composition_with_braiding, composition_with_braiding_inverse, list_of_characters,
          tensor_data_as_string;
    
    l := [ 1 .. Size( initialize_group_data_log_list[3] ) ];
    
    indices := [ l, l, l ];
    
    nr_generators := initialize_group_data_log_list[2];
    
    list_of_characters := initialize_group_data_log_list[3];
    
    CAP_representation_list := initialize_group_data_log_list[4];
    
    CAP_representation_list_inverses := initialize_group_data_log_list[5];
    
    vector_space_object_list := initialize_group_data_log_list[6];
    
    result_list := [];
    
    for i in indices[1] do
      
      rep1 := CAP_representation_list[i];
      
      character1 := list_of_characters[i];
      
      rep1_vector_space_object := Source( rep1[1] );
      
      degree1 := Dimension( rep1_vector_space_object );
      
      results_with_fixed_i := [ ];
      
      indices_using_braiding := Filtered( indices[2], x -> ( x < i ) );
      
      for j in indices_using_braiding do
          
          rep2 := CAP_representation_list[j];
          
          rep2_vector_space_object := Source( rep2[1] );
          
          composition_with_braiding := 
            PreCompose( result_list[j][i][1], Braiding( rep2_vector_space_object, rep1_vector_space_object ) );
          
          composition_with_braiding_inverse :=
            PreCompose( BraidingInverse( rep2_vector_space_object, rep1_vector_space_object ), result_list[j][i][2] );
          
          Add( results_with_fixed_i,
               [ composition_with_braiding,
                 composition_with_braiding_inverse ] );
          
      od;
      
      indices_not_using_braiding := Filtered( indices[2], x -> ( x >= i ) );
      
      for j in indices_not_using_braiding do
        
        rep2 := CAP_representation_list[j];
        
        character2 := list_of_characters[j];
        
        rep2_vector_space_object := Source( rep2[1] );
        
        degree2 := Dimension( rep2_vector_space_object );
        
        if degree1 > 1 or degree2 > 1 then
            
            tensor_product_on_objects := TensorProductOnObjects( rep1_vector_space_object, rep2_vector_space_object );
            
            tensor_product_on_morphisms := [ ];
            
            for gen in [ 1 .. nr_generators ] do
                
                Add( tensor_product_on_morphisms, TensorProductOnMorphisms( rep1[gen], rep2[gen] ) );
                
            od;
            
            if i = j then
                
                braiding := Braiding( vector_space_object_list[i], vector_space_object_list[i] );
              
            fi;
            
        fi;
        
        results_with_fixed_i_and_j := [ ];
        
        for k in indices[3] do
          
          character3 := list_of_characters[k];
          
          scalar_product := ScalarProduct( character3, character1 * character2 );
          
          if scalar_product = 0 then
              
              continue;
              
          fi;
          
          rep3 := CAP_representation_list[k];
          
          rep3_vector_space_object := Source( rep3[1] );
          
          degree3 := Dimension( rep3_vector_space_object );
          
          ## trivial cases implying that one can choose the identity matrix
          if (degree1 = 1 and degree2 = 1 and scalar_product = 1) or IsOne( character1 ) or IsOne( character2 ) then
              
              identity_morphism := IdentityMorphism( rep3_vector_space_object );
              
              Add( results_with_fixed_i, [ identity_morphism, identity_morphism ] );
              
              break;
              
          fi;
          
          rep3_inverse := CAP_representation_list_inverses[k];
          
          mor_list := [];
          
          obj := InternalHomOnObjects( rep3_vector_space_object, tensor_product_on_objects );
          
          for gen in [ 1 .. nr_generators ] do
            
            ## the action of the generators on Hom( A, B \otimes C ). Note the contravariance in the first component.
            Add( mor_list, InternalHomOnMorphisms( rep3_inverse[gen], tensor_product_on_morphisms[gen] ) );
            
          od;
          
          id := IdentityMorphism( obj );
          
          kernel_embeddings := List( mor_list, mor -> KernelEmbedding( mor - id ) );
          
          Gmorphisms := ProjectionInFactorOfFiberProduct(
                          kernel_embeddings, 1 );
          
          elements_of_internal_hom := PreCompose( Gmorphisms, kernel_embeddings[1] );
          
          if Dimension( Source( elements_of_internal_hom ) ) = 0 then
              
              Error( "There is a bug!" );
              
          fi;
          
          embedding_of_k_component := InternalHomToTensorProductAdjunctMorphismTemp( rep3_vector_space_object, tensor_product_on_objects, elements_of_internal_hom );
          
          ## TODO: make this more efficient by using character theory
          if i = j then
              
              skeletal_braiding_in_kvec :=
                LiftAlongMonomorphism( embedding_of_k_component, PreCompose( embedding_of_k_component, braiding ) );
              
              skeletal_braiding_in_kvec :=
                DecompositionFactorOfMultiplicationWithIdentity( skeletal_braiding_in_kvec, degree3 );
              
              ## side effect: sets IsEndomorphism to true
              IsEndomorphism( skeletal_braiding_in_kvec );
              
              transformation_matrix := DiagonalizationTransformationOfBraiding( skeletal_braiding_in_kvec );
              
              identity_morphism := IdentityMorphism( rep3_vector_space_object );
              
              ## this gives a diagonalization of the embedding compatible with the G-action
              transformation_matrix := TensorProductOnMorphisms( transformation_matrix, identity_morphism );
              
              embedding_of_k_component := PreCompose( transformation_matrix, embedding_of_k_component );
              
          fi;
          
          Add( results_with_fixed_i_and_j, embedding_of_k_component );
          
        od;
        
        if not IsEmpty( results_with_fixed_i_and_j ) then
            
            square_matrix_size := degree1 * degree2;
            
            decomposition_morphism := UniversalMorphismFromDirectSum( results_with_fixed_i_and_j );
            
            decomposition_morphism_inverse := Inverse( decomposition_morphism );
            
            Add( results_with_fixed_i, [ decomposition_morphism, decomposition_morphism_inverse ] );
            
        fi;
        
        if ASSOCIATORS_Setup.InfoLevelForAssociatorComputations > 0 then
            
            Print( Concatenation( "Finished: (", String( i ), ",", String( j ), ")\n" ) );
            
        fi;
        
      od;
      
      Add( result_list, results_with_fixed_i );
      
    od;
    
    ASSOCIATORS_Setup.skeletalfunctortensordata_log_list :=
      [ list_of_characters, result_list, vector_space_object_list ];
    
    tensor_data_as_string :=
      String(
        List( result_list, i ->
          List( i, j-> List( j, mor -> HomalgMatrixAsString( UnderlyingMatrix( mor ) ) ) )
        )
      );
    
    RemoveCharacters( tensor_data_as_string, " " );
    
    ASSOCIATORS_Setup.skeletalfunctortensordata_log_list_as_string := tensor_data_as_string;
    
    return ASSOCIATORS_Setup.skeletalfunctortensordata_log_list;
    
end );

##
InstallMethod( AssociatorDataFromSkeletalFunctorTensorData,
               [ IsInt, IsInt, IsInt, IsList ],
               
  function( a, b, c, skeletalfunctortensordata_log_list )
    local character_a, character_b, character_c, character_ab, character_bc,
          degree_a, degree_b, degree_c,
          tensor_data, list_of_characters, nr_characters, scalar_product,
          vector_space_object_list,
          morphism_1, morphism_2, morphism_3, morphism_4, morphism_5, morphism_6,
          morphism_list, object_list, i,
          associator_in_kvec,
          homalg_matrix, chi, rows_for_submatrix, cols_for_submatrix, total_dim, character_ic, weighted_scalar_products,
          position_of_first_chi_vector, k_block_dimension, character_ai, associator_component, result_list,
          scalar_product_i_ab, degree_chi, scalar_product_chi_ic, rows, scalar_product_i_bc, scalar_product_chi_ai, cols;
    
    list_of_characters := skeletalfunctortensordata_log_list[1];
    
    nr_characters := Size( list_of_characters );
    
    character_a := list_of_characters[a];
    
    character_b := list_of_characters[b];
    
    character_c := list_of_characters[c];
    
    tensor_data := skeletalfunctortensordata_log_list[2];
    
    vector_space_object_list := skeletalfunctortensordata_log_list[3];
    
    character_ab := character_a * character_b;
    
    character_bc := character_b * character_c;
    
    ## computation of morphism_1
    morphism_list := [ ];
    
    for i in [ 1 .. nr_characters ] do
        
        scalar_product := ScalarProduct( list_of_characters[i], character_ab );
        
        if scalar_product > 0 then
            
            Add( morphism_list,
                 DirectSumFunctorial( List( [ 1 .. scalar_product ], j -> tensor_data[i][c][1] ) )
            );
            
        fi;
        
    od;
    
    morphism_1 := DirectSumFunctorial( morphism_list );
    
    morphism_2 := TensorProductOnMorphisms( tensor_data[a][b][1], IdentityMorphism( vector_space_object_list[c] ) );
    
    morphism_3 := TensorProductOnMorphisms( IdentityMorphism( vector_space_object_list[a] ), tensor_data[b][c][2] );
    
    ## computation of morphism_4
    object_list := [ ];
    
    for i in [ 1 .. nr_characters ] do
        
        scalar_product := ScalarProduct( list_of_characters[i], character_bc );
        
        if scalar_product > 0 then
            
            Add( object_list,
                 DirectSum( List( [ 1 .. scalar_product ], j -> vector_space_object_list[i] ) )
            );
            
        fi;
        
    od;
    
    morphism_4 := LeftDistributivityExpanding( vector_space_object_list[a], object_list );
    
    ## computation of morphism_5
    morphism_list := [ ];
    
    for i in [ 1 .. nr_characters ] do
        
        scalar_product := ScalarProduct( list_of_characters[i], character_bc );
        
        if scalar_product > 0 then
            
            Add( morphism_list,
                 LeftDistributivityExpanding( vector_space_object_list[a], 
                                              List( [ 1 .. scalar_product ], j -> vector_space_object_list[i] )
                                            )
            );
            
        fi;
        
    od;
    
    morphism_5 := DirectSumFunctorial( morphism_list );
    
    ## computation of morphism_6
    morphism_list := [ ];
    
    for i in [ 1 .. nr_characters ] do
        
        scalar_product := ScalarProduct( list_of_characters[i], character_bc );
        
        if scalar_product > 0 then
            
            Add( morphism_list,
                 DirectSumFunctorial( List( [ 1 .. scalar_product ], j -> tensor_data[a][i][2] ) )
            );
            
        fi;
        
    od;
    
    morphism_6 := DirectSumFunctorial( morphism_list );
    
    associator_in_kvec := PreCompose( [ morphism_1, morphism_2, morphism_3, morphism_4, morphism_5, morphism_6 ] );
    
    ## read off from associator_in_kvec the entries corresponding to the actual associators in the skeleton
    homalg_matrix := UnderlyingMatrix( associator_in_kvec );
    
    result_list := [ ];
    
    for chi in [ 1 .. nr_characters ] do
        
        ## rows for submatrix
        total_dim := 0;
        
        rows_for_submatrix := [ ];
        
        degree_chi := Degree( list_of_characters[chi] );
        
        for i in [ 1 .. nr_characters ] do
            
            character_ic := list_of_characters[i] * list_of_characters[c];
            
            weighted_scalar_products := 
              List( [ 1 .. nr_characters ], k -> 
                    Degree( list_of_characters[k] ) * ScalarProduct( list_of_characters[k], character_ic ) );
            
            position_of_first_chi_vector := Sum( weighted_scalar_products{ [ 1 .. chi-1 ] } ) + 1;
            
            k_block_dimension := Sum( weighted_scalar_products );
            
            scalar_product_i_ab := ScalarProduct( list_of_characters[i], character_ab );
            
            scalar_product_chi_ic := ScalarProduct( list_of_characters[chi], character_ic );
            
            if ScalarProduct( list_of_characters[chi], character_ic ) > 0 then
                
                rows :=
                  List( [ 1 .. scalar_product_i_ab ], j1 ->
                    List( [ 1 .. scalar_product_chi_ic ], j2 ->
                      total_dim + position_of_first_chi_vector + (j2-1)*degree_chi + (j1-1)*k_block_dimension )
                      );
                
                rows := Flat( rows );
                
                Sort( rows );
                
                Append( rows_for_submatrix, rows );
               
            fi;
            
            total_dim := total_dim + scalar_product_i_ab * k_block_dimension;
            
        od;
        
        ## columns for submatrix
        total_dim := 0;
        
        cols_for_submatrix := [ ];
        
        for i in [ 1 .. nr_characters ] do
            
            character_ai := list_of_characters[a] * list_of_characters[i];
            
            weighted_scalar_products := 
              List( [ 1 .. nr_characters ], k -> 
                    Degree( list_of_characters[k] ) * ScalarProduct( list_of_characters[k], character_ai ) );
            
            position_of_first_chi_vector := Sum( weighted_scalar_products{ [ 1 .. chi-1 ] } ) + 1;
            
            k_block_dimension := Sum( weighted_scalar_products );
            
            scalar_product_i_bc := ScalarProduct( list_of_characters[i], character_bc );
            
            scalar_product_chi_ai := ScalarProduct( list_of_characters[chi], character_ai );
            
            if ScalarProduct( list_of_characters[chi], character_ai ) > 0 then
                
                cols :=
                  List( [ 1 .. scalar_product_i_bc ], j1 ->
                    List( [ 1 .. scalar_product_chi_ai ], j2 ->
                      total_dim + position_of_first_chi_vector + (j2-1)*degree_chi + (j1-1)*k_block_dimension )
                      );
                
                cols := Flat( cols );
                
                Sort( cols );
                
                Append( cols_for_submatrix, cols );
                
            fi;
            
            total_dim := total_dim + scalar_product_i_bc * k_block_dimension;
            
        od;
        
        if not Size( cols_for_submatrix ) = Size( rows_for_submatrix ) then
            
            Error( "There is a bug in the sorting of indices" );
            
        fi;
        
        if not IsEmpty( cols_for_submatrix ) then
            
            associator_component := CertainRows( CertainColumns( homalg_matrix, cols_for_submatrix ), rows_for_submatrix );
            
        else
            
            associator_component := [ ];
            
        fi;
        
        Add( result_list, associator_component );
        
    od;
    
    return result_list;
    
end );

##
InstallMethod( AssociatorForSufficientlyManyTriples,
               [  ],
               
  function( )
    
    return AssociatorForSufficientlyManyTriples( ASSOCIATORS_Setup.skeletalfunctortensordata_log_list, false );
    
end );

##
InstallMethod( AssociatorForSufficientlyManyTriples,
               [ IsList, IsBool ],
               
  function( skeletalfunctortensordata_log_list, for_all_triples )
    local list_of_characters, nr_characters, index_list, i,
          a, b, c, sub_list_a, sub_list_b, data_abc, data_acb, log_list, result_list, log_string;
    
    ASSOCIATORS_Setup.database_keys[5] := for_all_triples;
    
    log_string := "";
    
    result_list := [ ];
    
    list_of_characters := skeletalfunctortensordata_log_list[1];
    
    nr_characters := Size( list_of_characters );
    
    index_list := [ 1 .. nr_characters ];
    
    i := PositionProperty( list_of_characters, IsOne );
    
    Remove( index_list, i );
    
    ## Initialize result_list
    for a in index_list do
        
        result_list[a] := [ ];
        
        for b in index_list do
            
            result_list[a][b] := [ ];
            
        od;
        
    od;
    
    log_list := result_list;
    
    for a in index_list do
        
        if not for_all_triples then
            
            sub_list_a := Filtered( index_list, j -> j >= a );
            
        else
            
            sub_list_a := index_list;
            
        fi;
            
        for b in sub_list_a do
            
            if not for_all_triples then
                
                sub_list_b := Filtered( index_list, j -> j >= b );
                
            else
                
                sub_list_b := index_list;
                
            fi;
            
            for c in sub_list_b do
                
                data_abc := AssociatorDataFromSkeletalFunctorTensorData( a, b, c, skeletalfunctortensordata_log_list );
                
                result_list[a][b][c] := data_abc;
                
                log_list[a][b][c] := DataFromSkeletalFunctorTensorDataAsStringList( data_abc );
                
                if ASSOCIATORS_Setup.InfoLevelForAssociatorComputations > 0 then
                    
                    Print( Concatenation( "Finished: (", String( a ), ",", String( b ), ",", String( c ), ")\n" ) );
                    
                fi;
                
                ## in this case, one additional associator is needed in order to
                ## obtain the others using the braiding
                if a <> b and b <> c and c <> a then
                    
                    data_acb := AssociatorDataFromSkeletalFunctorTensorData( a, c, b, skeletalfunctortensordata_log_list );
                    
                    result_list[a][c][b] := data_acb;
                    
                    log_list[a][c][b] := DataFromSkeletalFunctorTensorDataAsStringList( data_acb );
                    
                    if ASSOCIATORS_Setup.InfoLevelForAssociatorComputations > 0 then
                        
                        Print( Concatenation( "Finished: (", String( a ), ",", String( c ), ",", String( b ), ")\n" ) );
                        
                    fi;
                    
                fi;
                
            od;
            
        od;
        
    od;
    
    log_string := String( log_list );
    
    ASSOCIATORS_Setup.associator_stringlist := log_string;
    
    return result_list;
    
end );

##
InstallMethod( ComputeAssociator,
               [ IsGroup, IsBool ],
               
  function( group, use_dixon )
    
    return ComputeAssociator( group, use_dixon, false, true );
    
end );

##
InstallMethod( ComputeAssociator,
               [ IsGroup, IsBool, IsBool ],
               
  function( group, use_dixon, for_all_triples )
    
    return ComputeAssociator( group, use_dixon, for_all_triples, true );
    
end );

##
InstallMethod( ComputeAssociator,
               [ IsGroup, IsBool, IsBool, IsBool ],
               
  function( group, use_dixon, for_all_triples, use_group_string_as_id )
    local log_list;
    
    if use_dixon then
        
        log_list := InitializeGroupDataDixon( group, use_group_string_as_id );
        
    else
        
        log_list := InitializeGroupData( group, use_group_string_as_id );
        
    fi;
    
    log_list := SkeletalFunctorTensorData( log_list );
    
    return AssociatorForSufficientlyManyTriples( log_list, for_all_triples );
    
end );


###################################
##
## Technical functions
##
###################################

##
InstallMethod( SetInfoLevelForAssociatorComputations,
               [ IsInt ],
               
  function( level )
    
    ASSOCIATORS_Setup.InfoLevelForAssociatorComputations := level;
    
end );

##
InstallMethod( DefinedOverCyclotomicField,
               [ IsInt, IsGroupHomomorphism ],
               
  function( root_of_unity, representation )
    local cyclotomic_field, images, number;
    
    cyclotomic_field := CyclotomicField( root_of_unity );
    
    images := MappingGeneratorsImages( representation )[2];
    
    images := Flat( images );
    
    for number in images do
        
        if not number in cyclotomic_field then
            
            return false;
            
        fi;
        
    od;
    
    return true;
    
end );

##
InstallMethod( GroupReperesentationByImages,
               [ IsGroup, IsList ],
               
  function( group, images_of_generators )
    local generators, range;
    
    generators := GeneratorsOfGroup( group );
    
    range := Group( images_of_generators );
    
    return GroupHomomorphismByImages( group, range, generators, images_of_generators );
    
end );

##
InstallMethod( DiagonalizationTransformationOfBraiding,
               [ IsVectorSpaceMorphism and IsEndomorphism ],
               
  function( endomorphism )
    local identity_morphism, kernel_emb_1, kernel_emb_minus_1;
    
    identity_morphism := IdentityMorphism( Source( endomorphism ) );
    
    kernel_emb_1 := KernelEmbedding( endomorphism - identity_morphism );
    
    kernel_emb_minus_1 := KernelEmbedding( endomorphism + identity_morphism );
    
    return UniversalMorphismFromDirectSum( [ kernel_emb_1, kernel_emb_minus_1 ] );
    
end );

##
InstallMethod( AffordAllIrreducibleRepresentationsDixon,
               [ IsGroup ],
               
  function( group )
    local irr;
    
    irr := Irr( group );
    
    return List( irr, chi -> IrreducibleRepresentationsDixon( group, chi ) );
    
end );

##
InstallMethod( AffordAllIrreducibleRepresentations,
               [ IsGroup ],
               
  function( group )
    local irr;
    
    irr := Irr( group );
    
    return List( irr, chi -> IrreducibleAffordingRepresentation( chi ) );
    
end );

##
InstallMethod( DefaultFieldForListOfRepresentations,
              [ IsList ],
              
  function( representation_list )
    local image_list, representation;
    
    image_list := [ ];
    
    for representation in representation_list do
        
        Append( image_list, MappingGeneratorsImages( representation )[2] );
        
    od;
    
    return CyclotomicField( Flat( image_list ) );
    
end );

## Note: the use of CoeffsCyc produces identites like 1 = -(E(3)^2 + E(3)),
## which is not desirable 
InstallMethod( RewriteMatrixInCyclotomicGenerator,
               [ IsMatrix, IsInt ],
               
  function( matrix, conductor )
    local e;
    
    e := ASSOCIATORS_Setup.e;
    
    return List( matrix, r -> List( r,
                   function( entry )
                     local coeffs;
                     coeffs := CoeffsCyc( entry, conductor );
                     return Sum( [ 1 .. conductor ], i -> coeffs[i] * e^(i - 1) );
                   end ) );
    
end );

##
InstallMethod( InternalHomToTensorProductAdjunctMorphismTemp,
               [ IsVectorSpaceObject, IsVectorSpaceObject, IsVectorSpaceMorphism ],
               
  function( b, c, g )
      local a, field, entries, homalg_matrix;
      
      a := Source( g );
      
      field := UnderlyingFieldForHomalg( g );
      
      entries := EntriesOfHomalgMatrix( UnderlyingMatrix( g ) );
      
      homalg_matrix := HomalgMatrix( entries, Dimension( a ) * Dimension( b ) , Dimension( c ), field );
      
      return VectorSpaceMorphism( TensorProductOnObjects( a, b ), homalg_matrix, c );
      
end );

##
InstallMethod( CreateEndomorphismFromString,
               [ IsVectorSpaceObject, IsString ],
               
  function( object, string )
    local dimension, field, homalg_matrix;
    
    dimension := Dimension( object );
    
    field := UnderlyingFieldForHomalg( object );
    
    homalg_matrix := HomalgMatrix( Concatenation( "[", string, "]" ), dimension, dimension, field );
    
    return VectorSpaceMorphism( object, homalg_matrix, object );
    
end );

##
InstallMethod( AsVectorSpaceMorphism,
               [ IsHomalgMatrix ],
               
  function( homalg_matrix )
    local field;
    
    field := HomalgRing( homalg_matrix );
    
    return VectorSpaceMorphism(
             VectorSpaceObject( NrRows( homalg_matrix ), field ),
             homalg_matrix,
             VectorSpaceObject( NrColumns( homalg_matrix ), field )
           );
    
end );

##
InstallMethod( DecompositionFactorOfMultiplicationWithIdentity,
               [ IsVectorSpaceMorphism, IsInt ],
               
  function( morphism, identity_size )
    local homalg_matrix, nr, entry_list;
    
    homalg_matrix := UnderlyingMatrix( morphism );
    
    nr := Dimension( Source( morphism ) ) / identity_size;
    
    entry_list := List( [ 0 .. nr - 1 ], i -> 1 + i*identity_size );
    
    homalg_matrix := CertainRows( CertainColumns( homalg_matrix, entry_list ), entry_list );
    
    return AsVectorSpaceMorphism( homalg_matrix );
    
end );

##
InstallMethod( HomalgMatrixAsString,
               [ IsHomalgMatrix ],
               
  function( homalg_matrix )
    local string;
    
    string := String( EntriesOfHomalgMatrix( homalg_matrix ) );
    
    RemoveCharacters( string, "[]" );
    
    return string;
    
end );

##
InstallMethod( DataFromSkeletalFunctorTensorDataAsStringList, 
               [ IsList ],
               
  function( associator_data )
    local result_list, i, string;
    
    result_list := [ ];
    
    for i in [ 1 .. Size( associator_data ) ] do
        
        if IsHomalgMatrix( associator_data[i] ) then
            
            result_list[i] := HomalgMatrixAsString( associator_data[i] );
            
        fi;
        
    od;
    
    return result_list;
    
end );

###################################
##
## Read, Write, and Display
##
###################################

##
InstallMethod( WriteAssociatorDataToFile,
               [ IsString ],
               
  function( filename )
    local stream;
    
    ASSOCIATORS_Setup.database_keys[4] := filename;
    
    RemoveCharacters( ASSOCIATORS_Setup.associator_stringlist, " " );
    
    stream := OutputTextFile( filename, false );
    
    SetPrintFormattingStatus( stream, false );
    
    PrintTo( stream, Concatenation( ASSOCIATORS_Setup.associator_stringlist, "\n" ) );
    
    CloseStream( stream );
    
end );

##
InstallMethod( WriteDatabaseKeysToFile, 
               [ IsString ],
               
  function( filename )
    local stream;
    
    stream := OutputTextFile( filename, false );
    
    SetPrintFormattingStatus( stream, false );
    
    PrintTo( stream, Concatenation( String( ASSOCIATORS_Setup.database_keys ), "\n" ) );
    
    CloseStream( stream );
    
end );

##
InstallMethod( WriteRepresentationsDataToFile,
               [ IsString ],
               
  function( filename )
    local stream;
    
    stream := OutputTextFile( filename, false );
    
    SetPrintFormattingStatus( stream, false );
    
    PrintTo( stream, Concatenation( ASSOCIATORS_Setup.initialize_group_data_log_list_as_string, "\n" ) );
    
    CloseStream( stream );
    
end );

##
InstallMethod( WriteSkeletalFunctorDataToFile,
               [ IsString ],
               
  function( filename )
    local stream;
    
    stream := OutputTextFile( filename, false );
    
    SetPrintFormattingStatus( stream, false );
    
    PrintTo( stream, Concatenation( ASSOCIATORS_Setup.skeletalfunctortensordata_log_list_as_string, "\n" ) );
    
    CloseStream( stream );
    
end );

##
InstallMethod( WriteAssociatorComputationToFiles,
               [ IsString ],
               
  function( group_shortcut )
    local databasekeys_filename, representations_filename, skeletalfunctor_filename, associator_filename;
    
    databasekeys_filename := Concatenation( group_shortcut, "Key.g" );
    
    representations_filename := Concatenation( group_shortcut, "Reps.g" );
    
    skeletalfunctor_filename := Concatenation( group_shortcut, "Dec.g" ); #for tensor decompositions
    
    if ASSOCIATORS_Setup.database_keys[5] then
        
        associator_filename := Concatenation( group_shortcut, "Ass" );
        
    else
        
        associator_filename := Concatenation( group_shortcut, "AssD" ); #D for dense, i.e., not all triples are computed
        
    fi;
    
    associator_filename := Concatenation( associator_filename, ".g" );
    
    WriteRepresentationsDataToFile( representations_filename );
    
    WriteSkeletalFunctorDataToFile( skeletalfunctor_filename );
    
    WriteAssociatorDataToFile( associator_filename );
    
    ## WriteDatabaseKeysToFile has to be called after WriteAssociatorDataToFile, since WriteAssociatorDataToFile determines 
    ## the filename enlisted in the key
    WriteDatabaseKeysToFile( databasekeys_filename );
    
end );

##
InstallMethod( ReadDatabaseKeys,
               [ IsString ],
               
  function( databasekeys_filename )
    local stream, command, database_keys, group, comma_pos, conductor, field, category;
    
    stream := InputTextFile( databasekeys_filename );
    
    command := ReadAll( stream );
    
    database_keys := EvalString( command );
    
    group := database_keys[1];
    
    if group[1] in "123456789" then
        
        comma_pos := PositionProperty( group, j -> j = ',' );
        
        group := SmallGroup( Int( group{ [ 1 .. comma_pos - 1 ] } ), Int( group{ [ comma_pos + 1 .. Size( group ) ] } ) );
        
    else
        
        group := EvalString( group );
        
    fi;
    
    conductor := database_keys[2];
    
    if conductor = 1 then
        
        field := HomalgFieldOfRationalsInDefaultCAS();
        
    else
        
        field := HomalgCyclotomicFieldInMAGMA( conductor, "e" );
        
    fi;
    
    category := MatrixCategory( field );
    
    return [ group, conductor, database_keys[3], field, category ];
    
end );

##
InstallMethod( ReadRepresentationsData,
               [ IsString, IsString ],
               
  function( databasekeys_filename, representations_filename )
    local stream, command, database_keys, representation_list, group, conductor, log_list, field, category, comma_pos;
    
    log_list := [ ];
    
    database_keys := ReadDatabaseKeys( databasekeys_filename );
    
    group := database_keys[1];
    
    conductor := database_keys[2];
    
    field := database_keys[4];
    
    category := database_keys[5];
    
    log_list[3] := Irr( group );
    
    stream := InputTextFile( representations_filename );
    
    command := ReadAll( stream );
    
    representation_list := EvalString( command );
    
    log_list[2] := Size( representation_list[1] );
    
    if not String( log_list[3] ) = representation_list[2] then
        
        Error( "the irreducible characters could not be correctly reproduced" );
        
    fi;
    
    log_list[6] :=
      List( representation_list[4], dim -> VectorSpaceObject( dim, field ) );
    
    log_list[4] :=
      List( [ 1 .. Size( representation_list[3] ) ], n ->
        List( [ 1 .. log_list[2] ], i ->
          CreateEndomorphismFromString( log_list[6][n], representation_list[3][n][i] )
        )
      );
    
    log_list[5] :=
      List( log_list[4], rep -> List( rep, Inverse ) );
    
    return log_list;
    
end );

##
InstallMethod( ReadSkeletalFunctorData,
               [ IsString, IsString ],
               
  function( databasekeys_filename, skeletalfunctor_filename )
    local log_list, database_keys, stream, command, representation_list, tensor_data, field;
    
    log_list := [ ];
    
    database_keys := ReadDatabaseKeys( databasekeys_filename );
    
    field := database_keys[4];
    
    log_list[1] := Irr( database_keys[1] );
    
    log_list[3] :=
      List( log_list[1], char -> VectorSpaceObject( Degree( char ), field ) );
    
    stream := InputTextFile( skeletalfunctor_filename );
    
    command := ReadAll( stream );
    
    tensor_data := EvalString( command );
    
    log_list[2] :=
      List( [ 1 .. Size( tensor_data ) ], i ->
        List( [ 1 .. Size( tensor_data[i] ) ], j ->
          List( tensor_data[i][j], mor -> CreateEndomorphismFromString( TensorProductOnObjects( log_list[3][i], log_list[3][j] ), mor ) )
        )
      );
    
    return log_list;
    
end );

##
InstallMethod( DisplayInitializedGroupData,
               [ ],
               
  function( )
    local log_list, group, i, j, conductor;
    
    log_list := ASSOCIATORS_Setup.initialize_group_data_log_list;
    
    group := UnderlyingGroup( UnderlyingCharacterTable( log_list[3][1] ) );
    
    conductor := ASSOCIATORS_Setup.database_keys[2];
    
    Print( "-Representations of:\n  " );
    
    Display( group );
    
    if conductor = 1 then
        
        Print( "-Defined over the rationals\n" );
        
    else
        
        Print( Concatenation( "-Defined over Q[e], where e is a primtive\n ", String( conductor ), "-th root of unity\n" ) );
        
    fi;
    
    Print( "-Given by images of the following generators:\n  " );
    
    Display( log_list[1] );
    
    Print( "-Affording the irreducible characters:\n  " );
    
    Display( CharacterTable( group ) );
    
    Print( "\n" );
    
    Print( "----------------\n" );
    
    for i in [ 1 .. Size( log_list[3] ) ] do
        
        Print( Concatenation( "Representation affording character X.", String( i ), ":\n" ) );
        
        for j in [ 1 .. Size( log_list[1] ) ] do
            
            Print( log_list[1][j] );
            
            Print( "->\n" );
            
            Display( UnderlyingMatrix( log_list[4][i][j] ) );
            
            Print( "\n" );
            
        od;
        
    od;
    
end );

##
InstallMethod( DisplaySkeletalFunctorTensorData,
               [ ],
               
  function(  )
    local log_list, irr, size, i, j, decomposition_as_string, prod, scalar_product, chi;
    
    log_list := ASSOCIATORS_Setup.skeletalfunctortensordata_log_list;
    
    irr := log_list[1];
    
    size := Size( log_list[2] );
    
    for i in [ 1 .. size ] do
        
        for j in [ 1 .. size ] do
            
            prod := irr[i] * irr[j];
            
            decomposition_as_string := "";
            
            for chi in [ 1 .. Size( irr ) ] do
                
                scalar_product := ScalarProduct( irr[chi], prod );
                
                if scalar_product > 0 then
                    
                    decomposition_as_string :=
                      Concatenation( 
                        decomposition_as_string,
                        String( scalar_product ), "*(X.", String( chi ), ") + "
                    );
                    
                fi;
                
            od;
            
            decomposition_as_string := decomposition_as_string{ [ 1 .. Size( decomposition_as_string ) - 3 ] };
            
            Print( "----------------\n" );
            
            Print( "\n" );
            
            Print( Concatenation( decomposition_as_string, " -> (X.", String( i ), ")*(X.", String( j ), "):\n" ) );
            
            Print( "\n" );
            
            Display( UnderlyingMatrix( log_list[2][i][j][1] ) );
            
            Print( "\n" );
            
        od;
        
    od;
    
end );
