#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
## Chapter Functors for the category of projective graded left modules
##
#############################################################################


##############################################
##
## Section Basic functionality for truncations
##
##############################################

# Truncation of projective graded modules
InstallMethod( TruncationOfProjectiveGradedModule,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsSemigroupGeneratorList ],
  function( projective_module, semigroup_generator_list )
    local conversion, rank, degree_list, new_degree_list, i;

    # check if we are given the semigroup of a cone
    conversion := TurnIntoConeHPresentationList( semigroup_generator_list );
    if conversion <> fail then
      return TruncationOfProjectiveGradedModule( projective_module, conversion );
    fi;

    # next make a basic check to see if cone_h_list could be valid
    rank := Rank( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) );
    if Length( UnderlyingList( semigroup_generator_list )[ 1 ] ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # now identify the degree_list of the module in question
    degree_list := DegreeList( projective_module );

    # now compute the embedding matrix and the degrees of the truncated module
    new_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do

      # if the degree lies in the cone, then add this degree layer to the degree_list of the truncated module
      if PointContainedInSemigroup( semigroup_generator_list, UnderlyingListOfRingElements( degree_list[ i ][ 1 ] ) ) then
        Add( new_degree_list, degree_list[ i ] );
      fi;

    od;

    # and finally return the object
    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then
      return CAPCategoryOfProjectiveGradedLeftModulesObject( new_degree_list, UnderlyingHomalgGradedRing( projective_module ) );
    else
      return CAPCategoryOfProjectiveGradedRightModulesObject( new_degree_list, UnderlyingHomalgGradedRing( projective_module ) );
    fi;

end );

# Truncation of projective graded modules
InstallMethod( TruncationOfProjectiveGradedModule,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsConeHPresentationList ],
  function( projective_module, cone_hpresentation_list )
    local rank, degree_list, new_degree_list, i;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next make a basic check to see if cone_h_list could be valid
    rank := Rank( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) );
    if Length( UnderlyingList( cone_hpresentation_list )[ 1 ] ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # now identify the degree_list of the module in question
    degree_list := DegreeList( projective_module );

    # now compute the embedding matrix and the degrees of the truncated module
    new_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do

      # if the degree lies in the cone, then add this degree layer to the degree_list of the truncated module
      if PointContainedInCone( cone_hpresentation_list, UnderlyingListOfRingElements( degree_list[ i ][ 1 ] ) ) then
        Add( new_degree_list, degree_list[ i ] );
      fi;

    od;

    # and finally return the object
    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then
      return CAPCategoryOfProjectiveGradedLeftModulesObject( new_degree_list, UnderlyingHomalgGradedRing( projective_module ) );
    else
      return CAPCategoryOfProjectiveGradedRightModulesObject( new_degree_list, UnderlyingHomalgGradedRing( projective_module ) );
    fi;

end );

# Embedding of truncation of projective graded module into the original module
InstallMethod( EmbeddingOfTruncationOfProjectiveGradedModule,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsSemigroupGeneratorList ],
  function( projective_module, semigroup_generator_list )
    local conversion, rank, degree_list, new_degree_list, embedding_matrix, counter, i, j, row, graded_ring, truncated_module;

    # check if the input is the semigroup of a cone and if so, hand the computation over to that method
    conversion := TurnIntoConeHPresentationList( semigroup_generator_list );
    if not conversion = fail then

      return EmbeddingOfTruncationOfProjectiveGradedModule( projective_module, conversion );

    fi;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if semigroup_generator_list is valid
    rank := Rank( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) );
    if Length( UnderlyingList( semigroup_generator_list )[ 1 ] ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # now compute the embedding matrix and the degrees of the truncated module
    degree_list := DegreeList( projective_module );
    new_degree_list := [];
    embedding_matrix := [];
    counter := 0;
    for i in [ 1 .. Length( degree_list ) ] do

      # if the degree lies in the cone, then add this degree layer to the degree_list of the truncated module
      if PointContainedInSemigroup( semigroup_generator_list, 
                                                    UnderlyingListOfRingElements( degree_list[ i ][ 1 ] ) ) then

        # add this degree to the new_degree_list
        Add( new_degree_list, degree_list[ i ] );

        # now add rows to the embedding matrix
        for j in [ 1 .. degree_list[ i ][ 2 ] ] do

          row := List( [ 1 .. Rank( projective_module ) ], x -> 0 );
          row[ counter + j ] := 1;
          Add( embedding_matrix, row );

        od;

      fi;

      # increase the counter
      counter := counter + degree_list[ i ][ 2 ];

    od;

    # if the new_dgree_list is empty, the truncated module is the zero_module and the embedding is the zero_morphism
    if Length( new_degree_list ) = 0 then

      return ZeroMorphism( ZeroObject( CapCategory( projective_module ) ), projective_module );

    fi;

    # install the truncated module (and transpose the embedding_matrix for right_modules)
    graded_ring := UnderlyingHomalgGradedRing( projective_module );
    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then

      truncated_module := CAPCategoryOfProjectiveGradedLeftModulesObject( new_degree_list, graded_ring );

    else

      embedding_matrix := TransposedMat( embedding_matrix );
      truncated_module := CAPCategoryOfProjectiveGradedRightModulesObject( new_degree_list, graded_ring );

    fi;

    # and return the corresponding embedding    
    return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( truncated_module, 
                                                                    HomalgMatrix( embedding_matrix, graded_ring ),
                                                                    projective_module 
                                                                   );

end );

# Embedding of truncation of projective graded module into the original module
InstallMethod( EmbeddingOfTruncationOfProjectiveGradedModule,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsConeHPresentationList ],
  function( projective_module, cone_hpresentation_list )
    local conversion, rank, degree_list, new_degree_list, embedding_matrix, counter, i, j, row, graded_ring, truncated_module;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if cone_hpresentation_list is valid
    rank := Rank( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) );
    if Length( UnderlyingList( cone_hpresentation_list )[ 1 ] ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # now compute the embedding matrix and the degrees of the truncated module
    degree_list := DegreeList( projective_module );
    new_degree_list := [];
    embedding_matrix := [];
    counter := 0;
    for i in [ 1 .. Length( degree_list ) ] do

      # if the degree lies in the cone, then add this degree layer to the degree_list of the truncated module
      if PointContainedInCone( cone_hpresentation_list, UnderlyingListOfRingElements( degree_list[ i ][ 1 ] ) ) then

        # add this degree to the new_degree_list
        Add( new_degree_list, degree_list[ i ] );

        # now add rows to the embedding matrix
        for j in [ 1 .. degree_list[ i ][ 2 ] ] do

          row := List( [ 1 .. Rank( projective_module ) ], x -> 0 );
          row[ counter + j ] := 1;
          Add( embedding_matrix, row );

        od;

      fi;

      # increase the counter
      counter := counter + degree_list[ i ][ 2 ];

    od;

    # if the new_dgree_list is empty, the truncated module is the zero_module and the embedding is the zero_morphism
    if Length( new_degree_list ) = 0 then

      return ZeroMorphism( ZeroObject( CapCategory( projective_module ) ), projective_module );

    fi;

    # install the truncated module (and transpose the embedding_matrix for right_modules)
    graded_ring := UnderlyingHomalgGradedRing( projective_module );
    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then

      truncated_module := CAPCategoryOfProjectiveGradedLeftModulesObject( new_degree_list, graded_ring );

    else

      embedding_matrix := TransposedMat( embedding_matrix );
      truncated_module := CAPCategoryOfProjectiveGradedRightModulesObject( new_degree_list, graded_ring );

    fi;

    # and return the corresponding embedding    
    return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( truncated_module, 
                                                                    HomalgMatrix( embedding_matrix, graded_ring ),
                                                                    projective_module 
                                                                   );

end );

# Projection onto truncation of projective graded module
InstallMethod( ProjectionOntoTruncationOfProjectiveGradedModule,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsSemigroupGeneratorList ],
  function( projective_module, semigroup_generator_list )
    local conversion, rank, degree_list, new_degree_list, projection_matrix, counter, i, j, row, graded_ring, truncated_module;

    # check if the input is the semigroup of a cone and if so, hand the computation over to that method
    conversion := TurnIntoConeHPresentationList( semigroup_generator_list );
    if not conversion = fail then

      return ProjectionOntoTruncationOfProjectiveGradedModule( projective_module, conversion );

    fi;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if semigroup_generator_list is valid
    rank := Rank( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) );
    if Length( UnderlyingList( semigroup_generator_list )[ 1 ] ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # now compute the embedding matrix and the degrees of the truncated module
    degree_list := DegreeList( projective_module );
    new_degree_list := [];
    projection_matrix := [];
    counter := 0;
    for i in [ 1 .. Length( degree_list ) ] do

      # if the degree lies in the cone, then add this degree layer to the degree_list of the truncated module
      if PointContainedInSemigroup( semigroup_generator_list, 
                                                    UnderlyingListOfRingElements( degree_list[ i ][ 1 ] ) ) then

        # add this degree to the new_degree_list
        Add( new_degree_list, degree_list[ i ] );

        # now add rows to the embedding matrix
        for j in [ 1 .. degree_list[ i ][ 2 ] ] do

          row := List( [ 1 .. Rank( projective_module ) ], x -> 0 );
          row[ counter + j ] := 1;
          Add( projection_matrix, row );

        od;

      fi;

      # increase the counter
      counter := counter + degree_list[ i ][ 2 ];

    od;

    # if the new_dgree_list is empty, the truncated module is the zero_module and the embedding is the zero_morphism
    if Length( new_degree_list ) = 0 then

      return ZeroMorphism( projective_module, ZeroObject( CapCategory( projective_module ) ) );

    fi;

    # install the truncated module (and transpose the embedding_matrix for right_modules)
    graded_ring := UnderlyingHomalgGradedRing( projective_module );
    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then

      projection_matrix := TransposedMat( projection_matrix );
      truncated_module := CAPCategoryOfProjectiveGradedLeftModulesObject( new_degree_list, graded_ring );

    else

      truncated_module := CAPCategoryOfProjectiveGradedRightModulesObject( new_degree_list, graded_ring );

    fi;

    # and return the corresponding embedding    
    return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( projective_module,
                                                                    HomalgMatrix( projection_matrix, graded_ring ),
                                                                    truncated_module
                                                                   );

end );

# Projection onto truncation of projective graded module
InstallMethod( ProjectionOntoTruncationOfProjectiveGradedModule,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsConeHPresentationList ],
  function( projective_module, cone_hpresentation_list )
    local conversion, rank, degree_list, new_degree_list, projection_matrix, counter, i, j, row, graded_ring, truncated_module;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if semigroup_generator_list is valid
    rank := Rank( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) );
    if Length( UnderlyingList( cone_hpresentation_list )[ 1 ] ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # now compute the embedding matrix and the degrees of the truncated module
    degree_list := DegreeList( projective_module );
    new_degree_list := [];
    projection_matrix := [];
    counter := 0;
    for i in [ 1 .. Length( degree_list ) ] do

      # if the degree lies in the cone, then add this degree layer to the degree_list of the truncated module
      if PointContainedInCone( cone_hpresentation_list, UnderlyingListOfRingElements( degree_list[ i ][ 1 ] ) ) then

        # add this degree to the new_degree_list
        Add( new_degree_list, degree_list[ i ] );

        # now add rows to the embedding matrix
        for j in [ 1 .. degree_list[ i ][ 2 ] ] do

          row := List( [ 1 .. Rank( projective_module ) ], x -> 0 );
          row[ counter + j ] := 1;
          Add( projection_matrix, row );

        od;

      fi;

      # increase the counter
      counter := counter + degree_list[ i ][ 2 ];

    od;

    # if the new_dgree_list is empty, the truncated module is the zero_module and the embedding is the zero_morphism
    if Length( new_degree_list ) = 0 then

      return ZeroMorphism( projective_module, ZeroObject( CapCategory( projective_module ) ) );

    fi;

    # install the truncated module (and transpose the embedding_matrix for right_modules)
    graded_ring := UnderlyingHomalgGradedRing( projective_module );
    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then

      projection_matrix := TransposedMat( projection_matrix );
      truncated_module := CAPCategoryOfProjectiveGradedLeftModulesObject( new_degree_list, graded_ring );

    else

      truncated_module := CAPCategoryOfProjectiveGradedRightModulesObject( new_degree_list, graded_ring );

    fi;

    # and return the corresponding embedding    
    return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( projective_module,
                                                                    HomalgMatrix( projection_matrix, graded_ring ),
                                                                    truncated_module
                                                                   );

end );

# Embedding of truncation of projective graded module into the original module
InstallMethod( EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject,
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ],
  function( projective_module, truncated_projective_module )
    local degree_list, truncated_degree_list, embedding_matrix, counter, counter2, iterator, i, j, row, graded_ring;

    # check for valid input
    if not IsIdenticalObj( CapCategory( projective_module ), CapCategory( truncated_projective_module ) ) then

      Error( "The modules have to be defined over the same category" );
      return;

    elif not IsFree( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # extract the degree_lists
    degree_list := DegreeList( projective_module );
    truncated_degree_list := List( [ 1 .. Length( DegreeList( truncated_projective_module ) ) ],
                                   k -> ShallowCopy( DegreeList( truncated_projective_module )[ k ] ) );

    # if the new_dgree_list is empty, the truncated module is the zero_module and the embedding is the zero_morphism
    if Length( truncated_degree_list ) = 0 then

      return ZeroMorphism( ZeroObject( CapCategory( projective_module ) ), projective_module );

    fi;

    # given that the truncated_module is not the trivial module, we compute the non-trivial embedding matrix
    embedding_matrix := [];
    counter := 0;
    counter2 := 1;
    i := 1;
    iterator := true;
    while iterator do

      # if the degree belongs to the truncated module
      if degree_list[ i ] = truncated_degree_list[ counter2 ] then

        # now add rows to the embedding matrix
        for j in [ 1 .. degree_list[ i ][ 2 ] ] do

          row := List( [ 1 .. Rank( projective_module ) ], x -> 0 );
          row[ counter + j ] := 1;
          Add( embedding_matrix, row );

        od;

        # adjust counter2 or truncated_degree_list accordingly
        if degree_list[ i ][ 2 ] = truncated_degree_list[ counter2 ][ 2 ] then
          counter2 := counter2 + 1;
        elif degree_list[ i ][ 2 ] < truncated_degree_list[ counter2 ][ 2 ] then
          truncated_degree_list[ counter2 ][ 2 ] := truncated_degree_list[ counter2 ][ 2 ] - degree_list[ i ][ 2 ];
        else
          Error( "Something went wrong" );
          return;
        fi;

        # if counter2 exceeds the length of truncated_degree_list, then the computation of the embedding_matrix is completed
        if counter2 > Length( truncated_degree_list ) then
          iterator := false;
        fi;

      fi;

      # increase the counter
      counter := counter + degree_list[ i ][ 2 ];

      # increase i
      i := i + 1;

      # if i exteeds the length of degree_list, then the computation of the embedding_matrix is completed
      if i > Length( degree_list ) then
        iterator := false;
      fi;

    od;

    # transpose the embedding_matrix if necessary
    if not IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then

      embedding_matrix := TransposedMat( embedding_matrix );

    fi;

    # and return the embedding
    graded_ring := UnderlyingHomalgGradedRing( projective_module );
    return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( truncated_projective_module, 
                                                                    HomalgMatrix( embedding_matrix, graded_ring ),
                                                                    projective_module 
                                                                   );

end );

# Embedding of truncation of projective graded module into the original module
InstallMethod( ProjectionOntoTruncationOfProjectiveGradedModuleWithGivenTruncationObject,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject,
                 IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject ],
  function( projective_module, truncated_projective_module )
    local degree_list, truncated_degree_list, projection_matrix, counter, counter2, iterator, i, j, row, graded_ring;

    # check for valid input
    if not IsIdenticalObj( CapCategory( projective_module ), CapCategory( truncated_projective_module ) ) then

      Error( "The modules have to be defined over the same category" );
      return;

    elif not IsFree( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # extract the degree_lists
    degree_list := DegreeList( projective_module );
    truncated_degree_list := List( [ 1 .. Length( DegreeList( truncated_projective_module ) ) ],
                                   k -> ShallowCopy( DegreeList( truncated_projective_module )[ k ] ) );

    # if the new_dgree_list is empty, the truncated module is the zero_module and the embedding is the zero_morphism
    if Length( truncated_degree_list ) = 0 then

      return ZeroMorphism( projective_module, ZeroObject( CapCategory( projective_module ) ) );

    fi;

    # given that the truncated_module is not the trivial module, we compute the non-trivial embedding matrix
    projection_matrix := [];
    counter := 0;
    counter2 := 1;
    i := 1;
    iterator := true;
    while iterator do

      # if the degree belongs to the truncated module...
      if degree_list[ i ][ 1 ] = truncated_degree_list[ counter2 ][ 1 ] then

        # now add rows to the projection matrix
        for j in [ 1 .. degree_list[ i ][ 2 ] ] do

          row := List( [ 1 .. Rank( projective_module ) ], x -> 0 );
          row[ counter + j ] := 1;
          Add( projection_matrix, row );

        od;

        # adjust counter2 or truncated_degree_list accordingly
        if degree_list[ i ][ 2 ] = truncated_degree_list[ counter2 ][ 2 ] then
          counter2 := counter2 + 1;
        elif degree_list[ i ][ 2 ] < truncated_degree_list[ counter2 ][ 2 ] then
          truncated_degree_list[ counter2 ][ 2 ] := truncated_degree_list[ counter2 ][ 2 ] - degree_list[ i ][ 2 ];
        else
          Error( "Something went wrong" );
          return;
        fi;

        # if counter2 exceeds the length of truncated_degree_list, then the computation of the embedding_matrix is completed
        if counter2 > Length( truncated_degree_list ) then
          iterator := false;
        fi;

      fi;

      # increase the counter
      counter := counter + degree_list[ i ][ 2 ];

      # increase i
      i := i + 1;

      # if i exteeds the length of degree_list, then the computation of the embedding_matrix is completed
      if i > Length( degree_list ) then
        iterator := false;
      fi;

    od;

    # transpose the embedding_matrix if necessary
    if IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then

      projection_matrix := TransposedMat( projection_matrix );

    fi;

    # and return the projection
    graded_ring := UnderlyingHomalgGradedRing( projective_module );
    return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( projective_module, 
                                                                    HomalgMatrix( projection_matrix, graded_ring ),
                                                                    truncated_projective_module
                                                                   );

end );

#################################################
##
#! @Section The truncation functor
##
#################################################

## FIXME: Make use of the additional arguments in functors.

# this function computes the trunction functor for both left and right presentations
InstallGlobalFunction( TruncationFunctorForProjectiveGradedModulesToSemigroups,
  function( graded_ring, semigroup_generator_list, left )
    local rank, i, category, functor;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( graded_ring ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if the cone_h_list is valid
    rank := Rank( DegreeGroup( graded_ring ) );
    if Length( UnderlyingList( semigroup_generator_list )[ 1 ] ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # first compute the category under consideration
    if left = true then
      category := CAPCategoryOfProjectiveGradedLeftModules( graded_ring );
    else
      category := CAPCategoryOfProjectiveGradedRightModules( graded_ring );
    fi;

    functor := CapFunctor( 
                      Concatenation( "Truncation functor for ", Name( category ), " to the semigroup generated by ", 
                                     String( UnderlyingList( semigroup_generator_list ) ) ), 
                      category,
                      category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return TruncationOfProjectiveGradedModule( object, semigroup_generator_list );

      end );

    # now define the functor operation on the morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return PreCompose( [
               EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject( Source( morphism ), new_source ),
               morphism,
               ProjectionOntoTruncationOfProjectiveGradedModuleWithGivenTruncationObject( Range( morphism ), new_range )
                           ] );

      end );

    # finally return the functor
    return functor;

end );


# this function computes the trunction functor for both left and right presentations
InstallGlobalFunction( TruncationFunctorForProjectiveGradedModulesToCones,
  function( graded_ring, cone_hpresentation_list, left )
    local conversion, rank, i, category, functor;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( graded_ring ) ) then

      Error( "Currently truncations are only supported for freely-graded rings" );
      return;

    fi;

    # next check if the cone_h_list is valid
    rank := Rank( DegreeGroup( graded_ring ) );
    if Length( UnderlyingList( cone_hpresentation_list )[ 1 ] ) <> rank then

      Error( "The semigroup is not contained in the degree_group of the graded ring" );
      return;

    fi;

    # first compute the category under consideration
    if left = true then    
      category := CAPCategoryOfProjectiveGradedLeftModules( graded_ring );
    else
      category := CAPCategoryOfProjectiveGradedRightModules( graded_ring );
    fi;

    functor := CapFunctor( 
                      Concatenation( "Truncation functor for ", Name( category ), 
                                     " to the cone given by the h-constraints ", 
                                     String( UnderlyingList( cone_hpresentation_list ) ) ), 
                      category,
                      category
                      );

    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )

        return TruncationOfProjectiveGradedModule( object, cone_hpresentation_list );

      end );

    # now define the functor operation on the morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return PreCompose( [
               EmbeddingOfTruncationOfProjectiveGradedModuleWithGivenTruncationObject( Source( morphism ), new_source ),
               morphism,
               ProjectionOntoTruncationOfProjectiveGradedModuleWithGivenTruncationObject( Range( morphism ), new_range )
                           ] );

      end );

    # finally return the functor
    return functor;

end );

# functor to compute the truncation of left-modules
InstallMethod( TruncationFunctorForProjectiveGradedLeftModules,
               [ IsHomalgGradedRing, IsSemigroupGeneratorList ],
      function( graded_ring, semigroup_generator_list )
        local conversion;

        # check if the given semigroup is the semigroup of a cone, and if so simplify matters by computing the
        # corresponding functor
       conversion := TurnIntoConeHPresentationList( semigroup_generator_list );

       if conversion = fail then

          return TruncationFunctorForProjectiveGradedModulesToSemigroups( graded_ring, 
                                                                          semigroup_generator_list, 
                                                                          true 
                                                                         );

       else

          return TruncationFunctorForProjectiveGradedModulesToCones( graded_ring, 
                                                                     conversion, 
                                                                     true 
                                                                    );

       fi;

end );

# functor to compute the truncation of left-modules
InstallMethod( TruncationFunctorForProjectiveGradedLeftModules,
               [ IsHomalgGradedRing, IsConeHPresentationList ],
      function( graded_ring, cone_hpresentation_list )

        return TruncationFunctorForProjectiveGradedModulesToCones( graded_ring, 
                                                                   cone_hpresentation_list, 
                                                                   true 
                                                                  );

end );

# functor to compute the truncation of right-modules
InstallMethod( TruncationFunctorForProjectiveGradedRightModules,
               [ IsHomalgGradedRing, IsSemigroupGeneratorList ],
      function( graded_ring, semigroup_generator_list )
        local conversion;

        # check if the given semigroup is the semigroup of a cone, and if so simplify matters by computing the
        # corresponding functor
       conversion := TurnIntoConeHPresentationList( semigroup_generator_list );

       if conversion = fail then

          return TruncationFunctorForProjectiveGradedModulesToSemigroups( graded_ring, 
                                                                          semigroup_generator_list, 
                                                                          false 
                                                                         );

       else

          return TruncationFunctorForProjectiveGradedModulesToCones( graded_ring, 
                                                                     conversion, 
                                                                     false 
                                                                    );

       fi;

end );

# functor to compute the truncation of right-modules
InstallMethod( TruncationFunctorForProjectiveGradedRightModules,
               [ IsHomalgGradedRing, IsConeHPresentationList ],
      function( graded_ring, cone_hpresentation_list )
      
        return TruncationFunctorForProjectiveGradedModulesToCones( graded_ring, 
                                                                   cone_hpresentation_list, 
                                                                   false 
                                                                  );

end );