#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
##  Chapter Tool methods
##
#############################################################################

############################################
##
#! @Section Tools to simplify the code
##
############################################

InstallMethod( DeduceMapFromMatrixAndRangeLeft,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedLeftModulesObject ],
  function( matrix, range_object )
    local homalg_graded_ring, source_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_rows,
         degrees_of_source_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( range_object ) ) then
      
        return Error( "The matrix must be defined over the same ring that the range_object was defined over. \n" );
      
      elif IsZero( matrix ) and NrRows( matrix ) <> 0 then
      
        return Error( "The source_object cannot be determined uniquely! \n" );
       
      fi;
      
      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );
      
      # check if the mapping_matrix is zero
      if IsZero( matrix ) then
        
          # if so, then (since NrRows = NrColumns = 0 by initial check) the source is the zero module
          source_object := CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the mapping_matrix is not zero, thus let us compute the source object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( range_object ) ) ] do
          
            for k in [ 1 .. DegreeList( range_object )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( range_object )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the kernel matrix
          degrees_of_matrix_rows := NonTrivialDegreePerRow( matrix );

          # initialise the degree list of the kernel_object
          degrees_of_source_object := List( [ 1 .. Length( degrees_of_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_matrix_rows ) ] do
        
            degrees_of_source_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_matrix_rows[ j ], 1 ];
          
          od;
        
          # and compute the kernel object
          source_object := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_source_object, homalg_graded_ring );

        fi;
                               
        # and return the mapping
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object, matrix, range_object );

end );


InstallMethod( DeduceMapFromMatrixAndSourceLeft,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedLeftModulesObject ],
  function( matrix, source_object )
    local homalg_graded_ring, range_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_columns,
         degrees_of_range_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( source_object ) ) then
      
        return Error( "The matrix must be defined over the same ring that the range_object was defined over. \n" );

      elif IsZero( matrix ) and NrColumns( matrix ) <> 0 then
      
        return Error( "The range_object cannot be determined uniquely! \n" );
       
      fi;
      
      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );
      
      # check if the mapping_matrix is zero
      if IsZero( matrix ) then
        
          # if so, then (since NrRows = NrColumns = 0 by initial check) the range is the zero module
          range_object := CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the mapping_matrix is not zero, thus let us compute the range object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( source_object ) ) ] do
          
            for k in [ 1 .. DegreeList( source_object )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( source_object )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the kernel matrix
          degrees_of_matrix_columns := NonTrivialDegreePerColumn( matrix );

          # initialise the degree list of the kernel_object
          degrees_of_range_object := List( [ 1 .. Length( degrees_of_matrix_columns ) ] );

          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_matrix_columns ) ] do

            degrees_of_range_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 - degrees_of_matrix_columns[ j ], 1 ];

          od;

          # and compute the kernel object
          range_object := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_range_object, homalg_graded_ring );

        fi;

        # and return the mapping
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object, matrix, range_object );

end );


InstallMethod( DeduceMapFromMatrixAndRangeRight,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( matrix, range_object )
    local homalg_graded_ring, source_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_columns,
         degrees_of_source_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( range_object ) ) then
      
        return Error( "The matrix must be defined over the same ring that the range_object was defined over. \n" );

      elif IsZero( matrix ) and NrColumns( matrix ) <> 0 then
      
        return Error( "The source_object cannot be determined uniquely! \n" );
       
      fi;
      
      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );

      # check if the cokernel matrix is zero
      if IsZero( matrix ) then

          # if so, then (since NrRows = NrColumns = 0 by initial check) the source is the zero module
          source_object := CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );

      else

          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( range_object ) ) ] do
          
            for k in [ 1 .. DegreeList( range_object )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( range_object )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_matrix_columns := NonTrivialDegreePerColumn( matrix );

          # initialise the degree list of the kernel_object
          degrees_of_source_object := List( [ 1 .. Length( degrees_of_matrix_columns ) ] );

          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_matrix_columns ) ] do
        
            degrees_of_source_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_matrix_columns[ j ], 1 ];
          
          od;
        
          # construct the kernel_object
          source_object := CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_source_object, homalg_graded_ring );

        fi;

        # and return the kernel embedding
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object, matrix, range_object );

end );


InstallMethod( DeduceMapFromMatrixAndSourceRight,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( matrix, source_object )
    local homalg_graded_ring, range_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_rows,
         degrees_of_range_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( source_object ) ) then
      
        return Error( "The matrix must be defined over the same ring that the range_object was defined over. \n" );

      elif IsZero( matrix ) and NrRows( matrix ) <> 0 then
      
        return Error( "The range_object cannot be determined uniquely! \n" );
       
      fi;
      
      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );
                  
      # check if the cokernel matrix is zero
      if IsZero( matrix ) then

        # if so, then (since NrRows = NrColumns = 0 by initial check) the range is the zero module
        range_object := CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );

      else

        # the matrix is not zero, thus let us compute the range object...
          
        # figure out the (first) non-zero entries per row of the cokernel matrix
        non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( matrix );
          
        # expand the degree_list of the range of the morphism
        expanded_degree_list := [];
        for j in [ 1 .. Length( DegreeList( source_object ) ) ] do
          
          for k in [ 1 .. DegreeList( source_object )[ j ][ 2 ] ] do
            
            Add( expanded_degree_list, DegreeList( source_object )[ j ][ 1 ] );
            
          od;
          
        od;
          
        # compute the degrees of the rows of the cokernel matrix
        degrees_of_matrix_rows := NonTrivialDegreePerRow( matrix );
        
        # initialise the degree list of the cokernel_object
        degrees_of_range_object := List( [ 1 .. Length( degrees_of_matrix_rows ) ] );
        
        # and now compute the degrees of the cokernel_object
        for j in [ 1 .. Length( degrees_of_matrix_rows ) ] do
        
          degrees_of_range_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 - degrees_of_matrix_rows[ j ], 1 ];
          
        od;
        
        # and from them the cokernel object
        range_object := CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_range_object, homalg_graded_ring );

      fi;

      # and return the mapping morphism
      return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object, matrix, range_object );        
        
end );




#########################################
##
## Check if a point is contained in cone
##
#########################################

# check if a point satisfies hyperplane constraints for a cone, thereby determining if the point lies in the cone
#InstallMethod( PointContainedInCone,
#               " for a cone given by H-constraints, a list specifying a point ",
#               [ IsList, IsList ],
#  function( cone, point )
#    local i, constraint;

    # check if the point satisfies the hyperplane constraints or not
#    for i in [ 1..Length( cone ) ] do

      # compute constraint
#      constraint := Sum( List( [ 1..Length( cone[ i ] ) ], x -> cone[ i ][ x ] * point[ x ] ) );

      # if non-negative, the point satisfies this constraint
#      if constraint < 0 then
#	return false;
#      fi;
#
#    od;

    # return the result
#    return true;

#end );

# check if a point lies in a subsemigroup
InstallMethod( PointContainedInSubsemigroup,
               " for a subsemigroup given by a list of generators and a list specifying a point ",
               [ IsList, IsList ],
  function( subsemigroup_generators, point )
    local res;

    # subsemigroup_generators = [ gen1, gens2, ..., genN ]
    # to use this for 4ti2Interface, we need to transpose it, so that the generators are written in the columns
    
    # use 4ti2 to check if point is contained in the subsemigroup
    res := 4ti2Interface_zsolve_equalities_and_inequalities_in_positive_orthant( 
                                                            TransposedMat( subsemigroup_generators ), point, [], [] );
    
    # the first entry of the returned list, expresses the point in terms of the generators (if such a solution exists)
    # so the first entry has length 0 precisely if the point is NOT contained in the subsemigroup
    if Length( res[ 1 ] ) = 0 then
      return false;
    else
      return true;
    fi;

end );
