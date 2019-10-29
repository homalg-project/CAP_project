#############################################################################
##
## GradedModulePresentationsbyFreyd
##
## Copyright 2019,  Martin Bies,       ULB Brussels
##
## Tools for the category of graded module presentations by use of Freyd categories
##
#############################################################################


###############################################
##
#! @Section The Frobenius-power
##
###############################################

##
InstallGlobalFunction( FROBENIUS_POEWR_OF_MATRIX,
  function( matrix, power )
    local new_mapping_matrix, i, j;

    # check the input
    if not IsHomalgMatrix( matrix ) then

      Error( "The first argument must be a homalg matrix" );
      return;

    elif not IsInt( power ) then

      Error( "The power must be a non-negative integer" );
      return;

    elif power < 0 then

      Error( "The power must be a non-negative integer" );
      return;

    fi;

    # now compute the Frobenius power
    new_mapping_matrix := EntriesOfHomalgMatrixAsListList( matrix );
    for i in [ 1 .. Length( new_mapping_matrix ) ] do
      for j in [ 1 .. Length( new_mapping_matrix[ i ] ) ] do
        new_mapping_matrix[ i ][ j ] := new_mapping_matrix[ i ][ j ]^power;
      od;
    od;

    # and return the result
    return HomalgMatrix( new_mapping_matrix, HomalgRing( matrix ) );

end );

##
InstallMethod( FrobeniusPowerOfFPGradedModule,
               "Frobenius powers of graded module presentations",
               [ IsFpGradedLeftOrRightModulesObject, IsInt ],
  function( module_presentation, power )
    local left, mor, range, matrix, new_mapping_matrix, i, j, alpha;

    if power < 0 then

      Error( "The power must be non-negative" );
      return;

    elif power = 1 then

      return module_presentation;

    else

      # determine if we are dealing with left or right modules
      left :=  IsGradedRowMorphism( RelationMorphism( module_presentation ) );

      # compute map into best projctive approximation
      mor := MorphismIntoBestProjectiveApproximation( module_presentation );

      # compute Frobenius power of the matrix which presents this morphism
      matrix := UnderlyingHomalgMatrix( MorphismDatum( mor ) );
      new_mapping_matrix := FROBENIUS_POEWR_OF_MATRIX( matrix, power );

      # Compute the kernel embedding of the morphism induced by new_mapping matrix
      # and interpret this kernel embedding as object in the Freyd category
      # Finally, return exactly this object.

      # compute morphism datum alpha of this object
      range := Range( MorphismDatum( mor ) );
      if left then
        alpha := WeakKernelEmbedding( DeduceMapFromMatrixAndRangeForGradedRows( new_mapping_matrix, range ) );
      else
        alpha := WeakKernelEmbedding( DeduceMapFromMatrixAndRangeForGradedCols( new_mapping_matrix, range ) );
      fi;

      # return the corresponding object
      return FreydCategoryObject( alpha );

    fi;

end );
