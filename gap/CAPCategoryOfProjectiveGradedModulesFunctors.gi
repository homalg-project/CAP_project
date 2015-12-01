

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
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ],
  function( projective_module, cone_h_list )

    return Source( EmbeddingOfTruncationOfProjectiveGradedModule( projective_module, cone_h_list ) );
    
end );

# Embedding of truncation of projective graded module into the original module
InstallMethod( EmbeddingOfTruncationOfProjectiveGradedModule,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ],
  function( projective_module, cone_h_list )
    local rank, i, j, degree_list, expanded_degree_list, new_degree_list, embedding_matrix, row, truncated_module, 
         graded_ring;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) ) then
    
      return Error( "Currently truncations are only supported for freely-graded rings. \n" );
    
    fi;
    
    # next make a basic check to see if cone_h_list could be valid
    # note that we do not check the entries to lie in the degree_group!
    rank := Rank( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) );
    for i in [ 1 .. Length( cone_h_list ) ] do
    
      if Length( cone_h_list[ i ] ) <> rank then
      
        return Error( "The cone is not contained in the degree_group of the graded ring. \n" );
        
      fi;
    
    od;
    
    # we now expand the degree_list of the projective module
    degree_list := DegreeList( projective_module );
    expanded_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      for j in [ 1 .. degree_list[ i ][ 2 ] ] do
        Add( expanded_degree_list, degree_list[ i ][ 1 ] );
      od;
    od;
    
    # now compute the embedding matrix and the degrees of the truncated module
    new_degree_list := [];
    embedding_matrix := [];
    for i in [ 1 .. Length( expanded_degree_list ) ] do
      
      # if the degree lies in the cone, then add this degree layer to the degree_list of the truncated module
      if PointContainedInCone( cone_h_list, UnderlyingListOfRingElements( expanded_degree_list[ i ] ) ) then

        Add( new_degree_list, [ expanded_degree_list[ i ], 1 ] );
        row := List( [ 1 .. Rank( projective_module ) ], x -> 0 );
        row[ i ] := 1;
        Add( embedding_matrix, row );
      
      fi;
    
    od;

    # if the new_dgree_list is empty, the truncated module is the zero_module and the embedding is the zero_morphism
    if Length( new_degree_list ) = 0 then
    
      return ZeroMorphism( ZeroObject( CapCategory( projective_module ) ), projective_module );
    
    else
        
      # install the truncated module (and transpose the embedding_matrix for right_modules)
      if IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then
    
        truncated_module := CAPCategoryOfProjectiveGradedLeftModulesObject( new_degree_list,
                                                                          UnderlyingHomalgGradedRing( projective_module ) 
                                                                         );

      else
      
        embedding_matrix := TransposedMat( embedding_matrix );
        truncated_module := CAPCategoryOfProjectiveGradedRightModulesObject( new_degree_list,
                                                                           UnderlyingHomalgGradedRing( projective_module ) 
                                                                          );

      fi;
    
      # and return the corresponding embedding    
      graded_ring := UnderlyingHomalgGradedRing( projective_module );
      return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( truncated_module, 
                                                                    HomalgMatrix( embedding_matrix, graded_ring ),
                                                                    projective_module 
                                                                   );

    fi;
    
end );


# Projection of a projective graded module onto its truncation
InstallMethod( ProjectionOntoTruncationOfProjectiveGradedModule,
               [ IsCAPCategoryOfProjectiveGradedLeftOrRightModulesObject, IsList ],
  function( projective_module, cone_h_list )
    local rank, i, j, degree_list, expanded_degree_list, new_degree_list, embedding_matrix, projection_matrix,
         row, truncated_module, graded_ring;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) ) then
    
      return Error( "Currently truncations are only supported for freely-graded rings. \n" );
    
    fi;
    
    # next make a basic check to see if cone_h_list could be valid
    # note that we do not check the entries to lie in the degree_group!
    rank := Rank( DegreeGroup( UnderlyingHomalgGradedRing( projective_module ) ) );
    for i in [ 1 .. Length( cone_h_list ) ] do
    
      if Length( cone_h_list[ i ] ) <> rank then
      
        return Error( "The cone is not contained in the degree_group of the graded ring. \n" );
        
      fi;
    
    od;
    
    # we now expand the degree_list of the projective module
    degree_list := DegreeList( projective_module );
    expanded_degree_list := [];
    for i in [ 1 .. Length( degree_list ) ] do
      for j in [ 1 .. degree_list[ i ][ 2 ] ] do
        Add( expanded_degree_list, degree_list[ i ][ 1 ] );
      od;
    od;
    
    # now compute the projection matrix as the transposed of the embedding matrix
    # also compute the degrees of the truncated module at the same time
    new_degree_list := [];
    embedding_matrix := [];
    for i in [ 1 .. Length( expanded_degree_list ) ] do
      
      # if the degree lies in the cone, then add this degree layer to the degree_list of the truncated module
      if PointContainedInCone( cone_h_list, UnderlyingListOfRingElements( expanded_degree_list[ i ] ) ) then

        Add( new_degree_list, [ expanded_degree_list[ i ], 1 ] );
        row := List( [ 1 .. Rank( projective_module ) ], x -> 0 );
        row[ i ] := 1;
        Add( embedding_matrix, row );
      
      fi;
    
    od;

    # it may happen that the embedding_matrix is [] if the truncated module is the zero module
    if Length( new_degree_list ) = 0 then
    
      return ZeroMorphism( projective_module, ZeroObject( CapCategory( projective_module ) ) );
      
    else
    
      # install the truncated module (and transpose the embedding_matrix for right_modules)
      if IsCAPCategoryOfProjectiveGradedLeftModulesObject( projective_module ) then
    
        projection_matrix := TransposedMat( embedding_matrix );
        truncated_module := CAPCategoryOfProjectiveGradedLeftModulesObject( new_degree_list,
                                                                            UnderlyingHomalgGradedRing( projective_module ) 
                                                                           );

      else
      
        projection_matrix := embedding_matrix;
        truncated_module := CAPCategoryOfProjectiveGradedRightModulesObject( new_degree_list,
                                                                             UnderlyingHomalgGradedRing( projective_module ) 
                                                                            );

      fi;
    
      # finally return the embedding
      graded_ring := UnderlyingHomalgGradedRing( projective_module );
      return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( projective_module, 
                                                                      HomalgMatrix( projection_matrix, graded_ring ),
                                                                      truncated_module
                                                                     );

    fi;

end );




#################################################
##
#! @Section The truncation functor
##
#################################################

## FIXME: Make use of the additional arguments in functors.

# this function computes the trunction functor for both left and right presentations
InstallGlobalFunction( TruncationFunctorForProjectiveGradedModules,
  function( graded_ring, cone_h_list, left )
    local rank, i, category, functor;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( graded_ring ) ) then
      
      ## FIXME: Let error messages simply end, no ., no !, no \n
      return Error( "Currently truncations are only supported for freely-graded rings. \n" );
    
    fi;
    
    # next check if the cone_h_list is valid
    rank := Rank( DegreeGroup( graded_ring ) );
    for i in [ 1 .. Length( cone_h_list ) ] do
    
      if Length( cone_h_list[ i ] ) <> rank then
      
        return Error( "The cone is not contained in the degree_group of the graded ring. \n" );
        
      fi;
    
    od;
        
    # first compute the category under consideration
    if left = true then    
      category := CAPCategoryOfProjectiveGradedLeftModules( graded_ring );
    else    
      category := CAPCategoryOfProjectiveGradedRightModules( graded_ring );
    fi;

    # then initialise the functor
    functor := CapFunctor( 
                      Concatenation( "Truncation functor for ", Name( category ), " to the cone ", String( cone_h_list ) ), 
                      category, 
                      category 
                      );
    
    # now define the functor operation on the objects
    AddObjectFunction( functor,
      function( object )
      
          return TruncationOfProjectiveGradedModule( object, cone_h_list );
            
      end );

    # now define the functor operation on the morphisms
    AddMorphismFunction( functor,
      function( new_source, morphism, new_range )

        return Lift( 
                 PreCompose( EmbeddingOfTruncationOfProjectiveGradedModule( Source( morphism ), cone_h_list ), morphism ).          
                 EmbeddingOfTruncationOfProjectiveGradedModule( Range( morphism ), cone_h_list )
               );

      end );
    
    # finally return the functor
    return functor;

end );

# functor to compute the truncation of left-modules
InstallMethod( TruncationFunctorForProjectiveGradedLeftModules,
               [ IsHomalgGradedRing, IsList ],
      function( graded_ring, cone_h_list )
      
        return TruncationFunctorForProjectiveGradedModules( graded_ring, cone_h_list, true );

end );

# functor to compute the truncation of right-modules
InstallMethod( TruncationFunctorForProjectiveGradedRightModules,
               [ IsHomalgGradedRing, IsList ],
      function( graded_ring, cone_h_list )
      
        return TruncationFunctorForProjectiveGradedModules( graded_ring, cone_h_list, false );

end );