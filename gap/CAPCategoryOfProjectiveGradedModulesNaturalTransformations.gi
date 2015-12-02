#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
##  Chapter Natural transformations
##
#############################################################################


####################################################################################
##
## Section Natural transformation from truncation functor to identity functor
##
####################################################################################

# a function that computes the natural isomorphism 1 => StandardModule for both
# left and right presentations
InstallGlobalFunction( NaturalTransformationFromTruncationToIdentityForProjectiveGradedModules,

  function( graded_ring, cone_h_list, left )
    local rank, i, category, truncation_functor, natural_transformation;

    # check if the degree_group of the underlying homalg_graded_ring is free
    if not IsFree( DegreeGroup( graded_ring ) ) then
    
      Error( "Currently truncations are only supported for freely-graded rings" );
      return;
    
    fi;
    
    # next check if the cone_h_list is valid
    rank := Rank( DegreeGroup( graded_ring ) );
    for i in [ 1 .. Length( cone_h_list ) ] do
    
      if Length( cone_h_list[ i ] ) <> rank then
      
        Error( "The cone is not contained in the degree_group of the graded ring" );
        return;

      fi;
    
    od;
    
    # now construct the category and the respective truncation_functor    
    if left = true then
      category := CAPCategoryOfProjectiveGradedLeftModules( graded_ring );
      truncation_functor := TruncationFunctorForProjectiveGradedLeftModules( graded_ring, cone_h_list );
    else
      category := CAPCategoryOfProjectiveGradedRightModules( graded_ring );
      truncation_functor := TruncationFunctorForProjectiveGradedRightModules( graded_ring, cone_h_list );
    fi;
    
    # initialise the natural_transformation
    natural_transformation := NaturalTransformation( 
                                     Concatenation( "Natural transformation from ", Name( truncation_functor ), " to id" ),
                                     truncation_functor,
                                     IdentityMorphism( AsCatObject( category ) )
                                     );
    
    # add component of natural_transformation over object
    AddNaturalTransformationFunction( natural_transformation,                                          
      function( truncated_object, object, identical_object )

        return EmbeddingOfTruncationOfProjectiveGradedModule( object, cone_h_list );

    end );

    # and finally return this transformation
    return natural_transformation;

end );

# natural isomorphism 1 => Standard module for left presentations
InstallMethod( NaturalTransformationFromTruncationToIdentityForProjectiveGradedLeftModules,
               [ IsHomalgGradedRing, IsList ],
  function( graded_ring, cone_h_list )

    return NaturalTransformationFromTruncationToIdentityForProjectiveGradedModules( graded_ring, cone_h_list, true );

end );

# natural isomorphism 1 => Standard module for right presentations
InstallMethod( NaturalTransformationFromTruncationToIdentityForProjectiveGradedRightModules,
               [ IsHomalgGradedRing, IsList ],
  function( graded_ring, cone_h_list )

    return NaturalTransformationFromTruncationToIdentityForProjectiveGradedModules( graded_ring, cone_h_list, false );

end );