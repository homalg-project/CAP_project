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

        Error( "The matrix must be defined over the same ring that the range_object was defined over" );
        return;

      elif not Rank( range_object ) = NrColumns( matrix ) then

        Error( "The rank of the range object and the number of columns of the desired mapping matrix do not match ");
        return;

      elif NrRows( matrix ) <> 0 and NrColumns( matrix) = 0 then

        Error( "The source_object cannot be determined uniquely" );
        return;

      elif NrRows( matrix ) <> 0 and NrColumns( matrix) <> 0 and Length( ZeroRows( matrix ) ) <> 0 then

        Error( "The source_object cannot be determined uniquely" );
        return;

      fi;

      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );

      # check if the source is the zero object
      if NrRows( matrix ) = 0 then

        # if so, then the source is the zero module
        return ZeroMorphism( ZeroObject( CapCategory( range_object ) ), range_object );

      else

        # source and range are non-trivial and the mapping matrix has no zero rows, therefore the following is wel-defined
        non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( matrix );

        # expand the degree_list of the range_object
        expanded_degree_list := [];
        for j in [ 1 .. Length( DegreeList( range_object ) ) ] do

          for k in [ 1 .. DegreeList( range_object )[ j ][ 2 ] ] do

            Add( expanded_degree_list, DegreeList( range_object )[ j ][ 1 ] );

          od;

        od;

        # compute the degrees of the rows of the mapping_matrix
        degrees_of_matrix_rows := NonTrivialDegreePerRow( matrix );

        # initialise the degree list of the source_object
        degrees_of_source_object := List( [ 1 .. Length( degrees_of_matrix_rows ) ] );

        # and now compute the degrees of the source_object
        for j in [ 1 .. Length( degrees_of_matrix_rows ) ] do

          degrees_of_source_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_matrix_rows[ j ], 1 ];

        od;

        # and compute the source object
        source_object := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_source_object, 
                                                                         homalg_graded_ring,
                                                                         CapCategory( range_object )!.constructor_checks_wished 
                                                                        );

        # and return the mapping
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object,
                                                                        matrix,
                                                                        range_object,
                                                                        CapCategory( range_object )!.constructor_checks_wished
                                                                       );

      fi;

end );

InstallMethod( DeduceMapFromMatrixAndSourceLeft,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedLeftModulesObject ],
  function( matrix, source_object )
    local homalg_graded_ring, range_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_columns,
         degrees_of_range_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( source_object ) ) then

        Error( "The matrix must be defined over the same ring that the source_object was defined over" );
        return;

      elif not Rank( source_object ) = NrRows( matrix ) then

        Error( "The rank of the source object and the number of rows of the desired mapping matrix do not match ");
        return;

      elif NrRows( matrix ) = 0 and NrColumns( matrix) <> 0 then

        Error( "The range_object cannot be determined uniquely" );
        return;

      elif NrRows( matrix ) <> 0 and NrColumns( matrix) <> 0 and Length( ZeroColumns( matrix ) ) <> 0 then

        Error( "The range_object cannot be determined uniquely" );
        return;

      fi;

      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );

      # check if the range is the zero object
      if NrColumns( matrix ) = 0 then

        # if so, then the range is the zero module
        return ZeroMorphism( source_object, ZeroObject( CapCategory( source_object ) ) );

      else

        # the source and range and non-trivial and the mapping_matrix has no zero columns
        non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( matrix );

        # expand the degree_list of the range of the morphism
        expanded_degree_list := [];
        for j in [ 1 .. Length( DegreeList( source_object ) ) ] do

          for k in [ 1 .. DegreeList( source_object )[ j ][ 2 ] ] do

            Add( expanded_degree_list, DegreeList( source_object )[ j ][ 1 ] );

          od;

        od;

        # compute the degrees of the columns of the mapping_matrix
        degrees_of_matrix_columns := NonTrivialDegreePerColumn( matrix );

        # initialise the degree list of the range_object
        degrees_of_range_object := List( [ 1 .. Length( degrees_of_matrix_columns ) ] );

        # and now compute the degrees of the range_object
        for j in [ 1 .. Length( degrees_of_matrix_columns ) ] do

          degrees_of_range_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 - degrees_of_matrix_columns[ j ], 1 ];

        od;

        # and compute the range object
        range_object := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_range_object,
                                                                        homalg_graded_ring,
                                                                        CapCategory( source_object )!.constructor_checks_wished
                                                                       );

        # and return the mapping
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object,
                                                                        matrix,
                                                                        range_object,
                                                                        CapCategory( source_object )!.constructor_checks_wished 
                                                                       );

      fi;

end );

InstallMethod( DeduceMapFromMatrixAndRangeRight,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( matrix, range_object )
    local homalg_graded_ring, source_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_columns,
         degrees_of_source_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( range_object ) ) then

        Error( "The matrix must be defined over the same ring that the range_object was defined over" );
        return;

      elif not Rank( range_object ) = NrRows( matrix ) then

        Error( "The rank of the range object and the number of rows of the desired mapping matrix do not match ");
        return;

      elif NrColumns( matrix ) <> 0 and NrRows( matrix) = 0 then

        Error( "The source_object cannot be determined uniquely" );
        return;

      elif NrRows( matrix ) <> 0 and NrColumns( matrix) <> 0 and Length( ZeroColumns( matrix ) ) <> 0 then

        Error( "The source_object cannot be determined uniquely" );
        return;

      fi;

      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );

      # check if the source is the zero object
      if NrColumns( matrix ) = 0 then

        # if so, then the source is the zero object
        return ZeroMorphism( ZeroObject( CapCategory( range_object ) ), range_object );

      else

        # both source and range are non-trivial and the mapping_matrix has no zero columns
        non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( matrix );

        # expand the degree_list of the range of the morphism
        expanded_degree_list := [];
        for j in [ 1 .. Length( DegreeList( range_object ) ) ] do

          for k in [ 1 .. DegreeList( range_object )[ j ][ 2 ] ] do

            Add( expanded_degree_list, DegreeList( range_object )[ j ][ 1 ] );

          od;

        od;

        # compute the degrees of the rows of the mapping_matrix
        degrees_of_matrix_columns := NonTrivialDegreePerColumn( matrix );

        # initialise the degree list of the source_object
        degrees_of_source_object := List( [ 1 .. Length( degrees_of_matrix_columns ) ] );

        # and now compute the degrees of the source_object
        for j in [ 1 .. Length( degrees_of_matrix_columns ) ] do

          degrees_of_source_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_matrix_columns[ j ], 1 ];

        od;

        # construct the kernel_object
        source_object := CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_source_object,
                                                                          homalg_graded_ring,
                                                                          CapCategory( range_object )!.constructor_checks_wished 
                                                                         );

        # and return the kernel embedding
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object,
                                                                        matrix,
                                                                        range_object,
                                                                        CapCategory( range_object )!.constructor_checks_wished 
                                                                       );

      fi;

end );

InstallMethod( DeduceMapFromMatrixAndSourceRight,
               [ IsHomalgMatrix, IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( matrix, source_object )
    local homalg_graded_ring, range_object, non_zero_entries_index, expanded_degree_list, j, k, degrees_of_matrix_rows,
         degrees_of_range_object;

      # check if the input is valid
      if not IsIdenticalObj( HomalgRing( matrix ), UnderlyingHomalgGradedRing( source_object ) ) then

        Error( "The matrix must be defined over the same ring that the source_object was defined over" );
        return;

      elif not Rank( source_object ) = NrColumns( matrix ) then

        Error( "The rank of the source object and the number of columns of the desired mapping matrix do not match ");
        return;

      elif NrColumns( matrix ) = 0 and NrRows( matrix) <> 0 then

        Error( "The range_object cannot be determined uniquely" );
        return;

      elif NrRows( matrix ) <> 0 and NrColumns( matrix) <> 0 and Length( ZeroRows( matrix ) ) <> 0 then

        Error( "The range_object cannot be determined uniquely" );
        return;

      fi;

      # the input is valid, so continue by setting the homalg_graded_ring
      homalg_graded_ring := HomalgRing( matrix );

      # check if the range is the zero object
      if IsZero( matrix ) then

        # if so, then the range is the zero module
        return ZeroMorphism( source_object, ZeroObject( CapCategory( source_object ) ) );

      else

        # source and range are non-trivial and the mapping_matrix has no zero rows
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
        range_object := CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_range_object,
                                                                         homalg_graded_ring,
                                                                         CapCategory( source_object )!.constructor_checks_wished 
                                                                        );

        # and return the mapping morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source_object,
                                                                        matrix,
                                                                        range_object,
                                                                        CapCategory( source_object )!.constructor_checks_wished 
                                                                       );

      fi;

end );

InstallMethod( UnzipDegreeList,
               [ IsCAPCategoryOfProjectiveGradedLeftModulesObject ],
  function( projective_module )
    local old_degree_list, i, j, new_degree_list;

    old_degree_list := DegreeList( projective_module );
    new_degree_list := [];

    for i in [ 1 .. Length( old_degree_list ) ] do

      new_degree_list := Concatenation( new_degree_list, 
                                        List( [ 1 .. old_degree_list[ i ][ 2 ] ], k -> old_degree_list[ i ][ 1 ] ) );

    od;

    return new_degree_list;

end );

InstallMethod( UnzipDegreeList,
               [ IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( projective_module )
    local old_degree_list, i, j, new_degree_list;

    old_degree_list := DegreeList( projective_module );
    new_degree_list := [];

    for i in [ 1 .. Length( old_degree_list ) ] do

      new_degree_list := Concatenation( new_degree_list, 
                                        List( [ 1 .. old_degree_list[ i ][ 2 ] ], k -> old_degree_list[ i ][ 1 ] ) );

    od;

    return new_degree_list;

end );