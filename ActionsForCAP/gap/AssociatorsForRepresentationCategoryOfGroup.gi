#############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#############################################################################

InstallValue( ASSOCIATORS_Setup, rec(
    
    ZZ := HomalgRingOfIntegers(),
    
    e := X( Rationals ),
    
    temp_file_name := "TEMP_LOG_FILE_ASSOCIATORS.g",
    
    log_string := "",
    
  )
);

###################################
##
## Computing associators
##
###################################

InstallMethod( SkeletalFunctorTensorData,
               [ ],
               
  function( )
      local l;
      
      if not IsBound( ASSOCIATORS_Setup.group ) then
          
          Error( "Initialize group data first via the command: InitializeGroupData( group )" );
          
          return;
          
      fi;
      
      l := [ 1 .. Size( ASSOCIATORS_Setup.GAP_representation_list ) ];
      
      return SkeletalFunctorTensorData( [ l, l, l ], ASSOCIATORS_Setup.initialize_group_data_log_list );
      
end );

# Input: A list of representations of G
# Output: For every triple A,B,C of representations,
# the subspace of Hom( C, A \otimes B ) consisting of G equivariant maps
# as a k-vector space.
InstallMethod( SkeletalFunctorTensorData,
               [ IsList, IsList ],
               
  function( indices, initialize_group_data_log_list )
    local CAP_representation_list, rep1, gen, rep2, tensor_product_on_objects, tensor_product_on_morphisms,
          indices_using_braiding, indices_not_using_braiding, CAP_representation_list_inverses, text,
          nr_generators, mor_list, result_list, rep3, Gmorphisms, i, j, k, obj, id, kernel_embeddings,
          degree1, degree2, degree3, rep1_vector_space_object, rep2_vector_space_object, rep3_vector_space_object,
          character1, character2, character3, scalar_product, elements_of_internal_hom, results_with_fixed_i_and_j, decomposition_morphism,
          identity_morphism, results_with_fixed_i, rep3_inverse, nr_characters, braiding, vector_space_object_list,
          embedding_of_k_component, skeletal_braiding_in_kvec, transformation_matrix, decomposition_morphism_inverse,
          square_matrix_size, matrix_string, composition_with_braiding, composition_with_braiding_inverse, list_of_characters;
    
    nr_generators := initialize_group_data_log_list[2];
    
    list_of_characters := initialize_group_data_log_list[3];
    
    CAP_representation_list := initialize_group_data_log_list[4];
    
    CAP_representation_list_inverses := initialize_group_data_log_list[5];
    
    vector_space_object_list := initialize_group_data_log_list[6];
    
    result_list := [];
    
    text := "ASSOCIATORS_Setup.tensor_data := [ \n";
    Append( ASSOCIATORS_Setup.log_string, text );
    AppendTo( ASSOCIATORS_Setup.temp_file_name, text );
    
    for i in indices[1] do
      
      text := "[ \n";
      Append( ASSOCIATORS_Setup.log_string, text );
      AppendTo( ASSOCIATORS_Setup.temp_file_name, text );
      
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
                 composition_with_braiding_inverse, [ i, j ] ] );
          
          text := "[ \n";
              
              Append( text,
                Concatenation(
                  VectorSpaceMorphismAsStringCommand( composition_with_braiding ),
                  ",\n",
                  VectorSpaceMorphismAsStringCommand( composition_with_braiding_inverse ),
                  ", \n[ ", String( i ), ", ", String(j), " ]\n], \n"
                )
              );
           
           Append( ASSOCIATORS_Setup.log_string, text );
           AppendTo( ASSOCIATORS_Setup.temp_file_name, text );
           
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
              
              Add( results_with_fixed_i, [ identity_morphism, identity_morphism, [ i, j ] ] );
              
              text := "[ \n";
              
              Append( text,
                Concatenation(
                  VectorSpaceMorphismAsStringCommand( identity_morphism ),
                  ",\n",
                  VectorSpaceMorphismAsStringCommand( identity_morphism ),
                  ", \n[ ", String( i ), ", ", String(j), " ]\n], \n"
                )
              );
              
              Append( ASSOCIATORS_Setup.log_string, text );
              AppendTo( ASSOCIATORS_Setup.temp_file_name, text );
              
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
          
          embedding_of_k_component := InternalHomToTensorProductAdjunctionMapTemp( rep3_vector_space_object, tensor_product_on_objects, elements_of_internal_hom );
          
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
            
            Add( results_with_fixed_i, [ decomposition_morphism, decomposition_morphism_inverse, [ i, j ] ] );
            
            text := "[ \n";
            
            Append( text,
              Concatenation(
                VectorSpaceMorphismAsStringCommand( decomposition_morphism ),
                ",\n",
                VectorSpaceMorphismAsStringCommand( decomposition_morphism_inverse ),
                ", \n[ ", String( i ), ", ", String(j), " ]\n], \n"
              )
            );
            
            Append( ASSOCIATORS_Setup.log_string, text );
            AppendTo( ASSOCIATORS_Setup.temp_file_name, text );
            
        fi;
        
        Print( Concatenation( "Finished: (", String( i ), ",", String( j ), ")\n" ) );
        
      od;
      
      Add( result_list, results_with_fixed_i );
      
      text := "],\n";
      Append( ASSOCIATORS_Setup.log_string, text );
      AppendTo( ASSOCIATORS_Setup.temp_file_name, text );
      
    od;
    
    text := "];\n";
    Append( ASSOCIATORS_Setup.log_string, text );
    AppendTo( ASSOCIATORS_Setup.temp_file_name, text );
    
    ASSOCIATORS_Setup.tensor_data := result_list;
    
    return result_list;
    
end );

##
InstallMethod( AssociatorDataFromSkeletalFunctorTensorData,
               [ IsInt, IsInt, IsInt ],
               
  function( a, b, c )
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
    
    list_of_characters := ASSOCIATORS_Setup.list_of_characters;
    
    nr_characters := Size( list_of_characters );
    
    character_a := list_of_characters[a];
    
    character_b := list_of_characters[b];
    
    character_c := list_of_characters[c];
    
    tensor_data := ASSOCIATORS_Setup.tensor_data;
    
    vector_space_object_list := ASSOCIATORS_Setup.vector_space_object_list;
    
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
    
    return AssociatorForSufficientlyManyTriples( false );
    
end );

##
InstallMethod( AssociatorForSufficientlyManyTriples,
               [ IsBool ],
               
  function( for_all_triples )
    local list_of_characters, nr_characters, index_list, i,
          a, b, c, sub_list_a, sub_list_b, data_abc, data_acb, log_list, result_list, log_string;
    
    log_string := "";
    
    result_list := [ ];
    
    list_of_characters := ASSOCIATORS_Setup.list_of_characters;
    
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
                
                data_abc := AssociatorDataFromSkeletalFunctorTensorData( a, b, c );
                
                result_list[a][b][c] := data_abc;
                
                log_list[a][b][c] := WriteDataFromSkeletalFunctorTensorDataAsStringList( data_abc );
                
                Print( Concatenation( "Finished: (", String( a ), ",", String( b ), ",", String( c ), ")\n" ) );
                
                ## in this case, one additional associator is needed in order to
                ## obtain the others using the braiding
                if a <> b and b <> c and c <> a then
                    
                    data_acb := AssociatorDataFromSkeletalFunctorTensorData( a, c, b );
                    
                    result_list[a][c][b] := data_acb;
                    
                    log_list[a][c][b] := WriteDataFromSkeletalFunctorTensorDataAsStringList( data_acb );
                    
                    Print( Concatenation( "Finished: (", String( a ), ",", String( c ), ",", String( b ), ")\n" ) );
                    
                fi;
                
            od;
            
        od;
        
    od;
    
    log_string := String( log_list );
    
#     RemoveCharacters( log_string, "\"" );
    
    Append( ASSOCIATORS_Setup.associator_log_string, 
      Concatenation( "ASSOCIATORS_Setup.associator_data := ", log_string, ";" ) );
    
    ASSOCIATORS_Setup.associator_stringlist := log_string;
    
    ASSOCIATORS_Setup.associator_data := result_list;
    
    return result_list;
    
end );

##
InstallMethod( ComputeAssociator,
               [ IsGroup, IsBool ],
               
  function( group, for_all_triples )
    
    InitializeGroupData( group );
    
    return ComputeAssociatorAfterInitialization( for_all_triples );
    
end );

##
InstallMethod( ComputeAssociatorDixon,
               [ IsGroup, IsBool ],
               
  function( group, for_all_triples )
    
    InitializeGroupDataDixon( group );
    
    return ComputeAssociatorAfterInitialization( for_all_triples );
    
end );

##
InstallMethod( ComputeAssociatorAfterInitialization,
               [ IsBool ],
               
  function( for_all_triples )
    
    SkeletalFunctorTensorData( );
    
    return AssociatorForSufficientlyManyTriples( for_all_triples );
    
end );

###################################
##
## Technical functions
##
###################################

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
    
    return UniversalMorphismFromDirectSum( kernel_emb_1, kernel_emb_minus_1 );
    
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
InstallMethod( InitializeGroupDataDixon,
               [ IsGroup ],
               
  function( group )
      
      InitializeGroupDataDixon( group, false );
      
end );

##
InstallMethod( InitializeGroupDataDixon,
               [ IsGroup, IsBool ],
               
  function( group, use_group_string_as_id )
      
      InitializeGroupData( group, AffordAllIrreducibleRepresentationsDixon( group ), use_group_string_as_id );
      
end );

##
InstallMethod( InitializeGroupData,
               [ IsGroup ],
               
  function( group )
      
      InitializeGroupData( group, false );
      
end );

##
InstallMethod( InitializeGroupData,
               [ IsGroup, IsBool ],
               
  function( group, use_group_string_as_id )
      
      InitializeGroupData( group, AffordAllIrreducibleRepresentations( group ), use_group_string_as_id );
      
end );

##
InstallMethod( InitializeGroupData,
               [ IsGroup, IsList, IsBool ],
               
  function( group, representation_list, use_group_string_as_id )
    local default_field, conductor, representation, entry, degree_of_representation, vector_space,
          generator, gap_matrix, homalg_matrix, CAP_representation_list, ZZ, size, i, gen1, gen2,
          log_string, group_string_for_creation, log_list, reps_as_string;
    
    log_list := [ ];
    
    log_string := 
      Concatenation( "# This file contains GAP readable input representing the decomposition data for the group: ", String( group ), "\n",
                     "#Please enter the definition of this group here: \n",
                     "group := \n" );
    
    Append( log_string,
      "LoadPackage( \"RingsForHomalg\" );\nRead( \"../Associators.gd\" );\nRead( \"../Associators.gi\" );\n" );
    
    SetName( ASSOCIATORS_Setup.e, "e" );
    
    ASSOCIATORS_Setup.group := group;
    
    size := Size( group );
    
    ASSOCIATORS_Setup.group_generators := GeneratorsOfGroup( group );
    
    # try to find two generators
    
    if Size( ASSOCIATORS_Setup.group_generators ) > 2 then
        
        for i in [ 1 .. 10 ] do
            
            gen1 := Random( group );
            
            gen2 := Random( group );
            
            if size = Size( Group( [ gen1, gen2 ] ) ) then
                
                ASSOCIATORS_Setup.group_generators := [ gen1, gen2 ];
                
                Print( "Found 2 generators for the group using random elements\n" );
                
                break;
                
            fi;
            
        od;
        
    fi;
    
    Add( log_list, ASSOCIATORS_Setup.group_generators );
    
    Add( log_list, Size( ASSOCIATORS_Setup.group_generators ) );
    
    ASSOCIATORS_Setup.GAP_representation_list := representation_list;
    
    ASSOCIATORS_Setup.list_of_characters := Irr( group ); ## WARNING: this has to be the same order as the representations in representation_list
    
    Add( log_list, ASSOCIATORS_Setup.list_of_characters );
    
    Append( log_string, "ASSOCIATORS_Setup.list_of_characters := Irr( group );\n" );
    
    default_field := DefaultFieldForListOfRepresentations( representation_list );
    
    conductor := Conductor( default_field );
    
    ASSOCIATORS_Setup.conductor := conductor;
    
    if conductor = 1 then
        
        ASSOCIATORS_Setup.field := HomalgFieldOfRationalsInDefaultCAS();
        
        Append( log_string, "field := HomalgFieldOfRationalsInDefaultCAS();\n" );
        
    else
        
        ASSOCIATORS_Setup.field := HomalgCyclotomicFieldInMAGMA( conductor, "e" );
        
        Append( log_string,
          Concatenation( "field := HomalgCyclotomicFieldInMAGMA( ", String( conductor ), ", \"e\" );\n",
                         "e := HomalgRingElement( \"e\", field );\n" )
        );
        
    fi;
    
    ASSOCIATORS_Setup.category := MatrixCategory( ASSOCIATORS_Setup.field );
    
    Append( log_string, "ASSOCIATORS_Setup.category := MatrixCategory( field );\n" );
    
    ASSOCIATORS_Setup.vector_space_object_list := 
      List( ASSOCIATORS_Setup.list_of_characters, chi -> VectorSpaceObject( Degree( chi ), ASSOCIATORS_Setup.field ) );
    
    Append( log_string,
      "ASSOCIATORS_Setup.vector_space_object_list := List( ASSOCIATORS_Setup.list_of_characters, chi -> VectorSpaceObject( Degree( chi ), field ) );\n" );
    
    CAP_representation_list := [ ];
    
    ZZ := ASSOCIATORS_Setup.ZZ;
    
    ## This for-loop
    ## creates a list of CAP matrices over the correct field
    ## from the list of representations
    for representation in representation_list do
        
        entry := [ ];
        
        degree_of_representation := DimensionOfMatrixGroup( Range( representation ) );
        
        vector_space := VectorSpaceObject( degree_of_representation, ASSOCIATORS_Setup.field );
        
        for generator in ASSOCIATORS_Setup.group_generators do
          
          gap_matrix := generator^representation;
          
          if conductor > 1 then
              
              gap_matrix := RewriteMatrixInCyclotomicGenerator( gap_matrix, conductor );
              
              gap_matrix := ASSOCIATORS_Setup.field * HomalgMatrix( gap_matrix, ZZ );
              
          fi;
          
          homalg_matrix :=
                HomalgMatrix( gap_matrix, degree_of_representation, degree_of_representation, ASSOCIATORS_Setup.field );
          
          Add( entry, VectorSpaceMorphism( vector_space, homalg_matrix, vector_space ) );
          
        od;
        
        Add( CAP_representation_list, entry );
        
    od;
    
    ASSOCIATORS_Setup.CAP_representation_list := CAP_representation_list;
    
    Add( log_list, ASSOCIATORS_Setup.CAP_representation_list );
    
    ASSOCIATORS_Setup.CAP_representation_list_inverses :=
      List( CAP_representation_list, images -> List( images, image -> Inverse( image ) ) );
    
    Add( log_list, ASSOCIATORS_Setup.CAP_representation_list_inverses );
    
    Add( log_list, ASSOCIATORS_Setup.vector_space_object_list );
    
    ASSOCIATORS_Setup.log_string := log_string;
    
    ASSOCIATORS_Setup.associator_log_string := ShallowCopy( log_string );
    
    if use_group_string_as_id then
        
        group_string_for_creation := String( group );
        
    else
        
        group_string_for_creation := String( IdGroup( group ) );
        
        RemoveCharacters( group_string_for_creation, "\[\]\ " );
        
    fi;
    
    ASSOCIATORS_Setup.database_keys := [
        
        group_string_for_creation,
        conductor,
        PositionProperty( ASSOCIATORS_Setup.list_of_characters, IsOne )
        
    ];
    
    ASSOCIATORS_Setup.initialize_group_data_log_list := log_list;
    
    reps_as_string :=
      String( List( log_list[4], rep -> List( rep, mor -> HomalgMatrixAsString( UnderlyingMatrix( mor ) ) ) ) );
    
    RemoveCharacters( reps_as_string, " " );
    
    ASSOCIATORS_Setup.initialize_group_data_log_list_as_string := Concatenation(
      "[", String( List( log_list[1], elem -> String( elem ) ) ), ",\n",
      String( log_list[3] ), ",\n",
      reps_as_string, ",\n",
      String( List( log_list[6], space -> Dimension( space ) ) ), "]" );
    
    AppendTo( ASSOCIATORS_Setup.temp_file_name, log_string );
    
end );

##
InstallMethod( InternalHomToTensorProductAdjunctionMapTemp,
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
InstallMethod( DisplaySkeletalFunctorTensorData, 
               [ IsList ],
               
  function( data )
    local size, i, j;
    
    size := Size( data );
    
    for i in [ 1 .. size ] do
      
      for j in [ 1 .. size ] do
        
        Display( data[i][j][1] );
        
        Print( "\n" );
        
      od;
      
    od;
    
end );

##
InstallMethod( EntryOfHomalgMatrix,
               [ IsHomalgMatrix, IsInt, IsInt ],
               
  function( homalg_matrix, i, j )
      
      return EntriesOfHomalgMatrix( CertainColumns( CertainRows( homalg_matrix, [ i ] ), [ j ] ) )[1];
      
end );

##
InstallMethod( WriteSkeletalFunctorDataLogToFile,
               [ IsString ],
               
   function( filename )
       
       PrintTo( filename, ASSOCIATORS_Setup.log_string );
       
end );

##
InstallMethod( WriteAssociatorLogToFile,
               [ IsString ],
               
   function( filename )
       
       PrintTo( filename, ASSOCIATORS_Setup.associator_log_string );
       
end );

##
InstallMethod( WriteAssociatorAsStringlistToFile,
               [ IsString ],
               
   function( filename )
       
       RemoveCharacters( ASSOCIATORS_Setup.associator_stringlist, " " );
       
       PrintTo( filename, ASSOCIATORS_Setup.associator_stringlist );
       
end );

##
InstallMethod( WriteDatabaseKeysToFile, 
               [ IsString ],
               
    function( filename )
        
        PrintTo( filename, ASSOCIATORS_Setup.database_keys );
        
end );

##
InstallMethod( WriteRepresentationsDataToFile,
               [ IsString ],
               
    function( filename )
        
        PrintTo( filename, ASSOCIATORS_Setup.initialize_group_data_log_list_as_string );
        
end );

##
InstallMethod( HomalgMatrixAsStringCommand,
               [ IsList ],
               
  function( list )
    
    if list = [ ] then
        
        return "";
        
    fi;
    
    return List( list, element -> HomalgMatrixAsStringCommand( element ) );
    
end );

##
InstallMethod( HomalgMatrixAsStringCommand,
               [ IsHomalgMatrix ],
               
  function( homalg_matrix )
    local text, matrix_string;
    
    text := "";
    
    Append( text, "HomalgMatrix( " );
    
    matrix_string := String( EntriesOfHomalgMatrix( homalg_matrix ) );
    
    Append( text,
      Concatenation( matrix_string, ", ", String( NrRows( homalg_matrix ) ), ", ", String( NrColumns( homalg_matrix ) ), ", field )" )
    );
    
    return text;
    
end );

##
InstallMethod( VectorSpaceMorphismAsStringCommand,
               [ IsVectorSpaceMorphism ],
               
  function( morphism )
    local text, homalg_matrix, matrix_string;
    
    homalg_matrix := UnderlyingMatrix( morphism );
    
    text := "";
    
    Append( text, Concatenation( "AsVectorSpaceMorphism( ", HomalgMatrixAsStringCommand( homalg_matrix ), " )" ) );
    
    return text;
    
    ## This code only works for Singular:
#     text := "";
#     
#     ## sets stream.lines of the matrix
#     Display( homalg_matrix );
#     
#     Append( text, "HomalgMatrix( " );
#     
#     matrix_string := Eval( homalg_matrix )!.stream.lines;
#     
#     RemoveCharacters( matrix_string, "\n" );
#     
#     Append( text, Concatenation( "\"[", matrix_string, "];\" " ) );
#     
#     Append( text, Concatenation( ", ", String( Dimension( Source( morphism ) ) ), ", ", String( Dimension( Range( morphism ) ) ), ", field )" ) );
#     
#     return text;
    
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
InstallMethod( WriteDataFromSkeletalFunctorTensorDataAsStringList, 
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


