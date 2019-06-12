#############################################################################
##
## FreydCategoriesForCAP package
##
## Copyright 2019, Martin Bies,       ULB Brussels
##
## Chapter Category of graded columns
##
#############################################################################


#############################################################
##
## Constructor for category of graded columns
##
#############################################################

InstallMethod( CategoryOfGradedColumns,
               [ IsHomalgGradedRing ],
  function( homalg_graded_ring )
    local category, to_be_finalized;
    
      # create category
      category := CreateCapCategory( Concatenation( "Category of graded columns over ", RingName( homalg_graded_ring ) ) );
      
      SetFilterObj( category, IsCategoryOfGradedColumns );
      
      AddObjectRepresentation( category, IsGradedColumnRep );
      
      AddMorphismRepresentation( category, IsGradedColumnMorphismRep );
      
      SetUnderlyingGradedRing( category, homalg_graded_ring );
      
      # here we can switch internal checks in constructor on or of - true means they are performed and false means they are not
      category!.constructor_checks_wished := true;

      # set its properties
      SetIsAdditiveCategory( category, true );
      if HasIsCommutative( UnderlyingNonGradedRing( homalg_graded_ring ) )
         and IsCommutative( UnderlyingNonGradedRing( homalg_graded_ring ) ) then
        SetIsStrictMonoidalCategory( category, true );
        SetIsRigidSymmetricClosedMonoidalCategory( category, true );
      fi;
    
      # install its functionality
      INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_GRADED_COLUMNS( category, category!.constructor_checks_wished );
      
      CapCategorySwitchLogicOff( category );
      
      to_be_finalized := ValueOption( "FinalizeCategory" );
      
      if to_be_finalized = false then
        
        return category;
      
      fi;
      
      # finalise it
      Finalize( category );
      
      # and return the completed category
      return category;
    
end );

####################################################################
##
## Basic operations for category of graded columns
##
####################################################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_GRADED_COLUMNS,
  function( category, checks )
    local underlying_graded_ring;
    
    underlying_graded_ring := UnderlyingGradedRing( category );
    
    
    ######################################################################
    #
    # @Section Methods to check if objects and morphisms are well-defined
    #
    ######################################################################

    # @Description
    # Checks if the given object is well-defined.
    # @Returns true or false
    # @Arguments object    
    AddIsWellDefinedForObjects( category,
      function( object )
        local i, A, power;
      
        # the zero object must be represented by the empty list
        if Rank( object ) = 0 then
         
          return DegreeList( object ) = [ ];
        
        else
        
          # identify the degree group
          A := DegreeGroup( UnderlyingHomalgGradedRing( object ) );
        
          # initialse a power counter that is to be compared to the rank of the object
          power := 0;
          
          # let us check that all degrees lie in the DegreeGroup and that rank is correctly summed
          for i in [ 1 .. Length( DegreeList( object ) ) ] do
          
            if not IsHomalgModuleElement( DegreeList( object )[ i ][ 1 ] ) then
            
              # the degrees are not saves as homalg module elements, so return false
              return false;
            
            elif not IsIdenticalObj( SuperObject( DegreeList( object )[ i ][ 1 ] ), A ) then
            
              # the degrees are not homalg_module_elements in the degree group of the homalg ring underlying the object
              # so return false
              return false;
            
            fi;
          
            # add the power
            power := power + DegreeList( object )[ i ][ 2 ];
            
          od;
        
          # now compare power to the rank of the object
          if not power = Rank( object ) then
          
            # the rank somehow got corrupted, therefore return false
            return false;
          
          fi;
        
        fi;
        
        # all tests have been passed, so return true
        return true;
        
    end );

    # @Description
    # Checks if the given morphism is well-defined.
    # @Returns true or false
    # @Arguments morphism
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local source, range, morphism_matrix, morphism_matrix_entries, func, degrees_of_entries_matrix, degree_group, 
             source_degrees, range_degrees, buffer_row, dummy_range_degrees, i, j;
        
        # extract source and range
        source := Source( morphism );
        range := Range( morphism );
        
        # next check that the underlying homalg_graded_rings are identical
        if not ( IsIdenticalObj( UnderlyingHomalgGradedRing( source ), UnderlyingHomalgGradedRing( morphism ) ) and
                        IsIdenticalObj( UnderlyingHomalgGradedRing( morphism ), UnderlyingHomalgGradedRing( range ) ) ) then
        
          return false;
        
        fi;
        
        # extract the mapping matrix
        morphism_matrix := UnderlyingHomalgMatrix( morphism );
        
        # then check if the dimensions of the matrix fit with the ranks of the source and range modules
        if not ( Rank( source ) = NrColumns( morphism_matrix )
                 and NrRows( morphism_matrix ) = Rank( range ) ) then
          
          return false;
        
        fi;
        
        # check if the mapping is non-trivial, for otherwise we are done already
        if ( Rank( source ) = 0 or Rank( range ) = 0 ) then
        
          return true;
        
        fi;
        
        # if the matrix does not have homogeneous degrees, the morphism is not well-defined
        if not IsMatrixOverGradedRingWithHomogeneousEntries( morphism_matrix ) then

          return false;

        fi;

        # now extract the degrees of the entries of the morphism_matrix
        degrees_of_entries_matrix := DegreesOfEntries( morphism_matrix );

        # turn the degrees of the source into a column vector (that is how I think about right-modules)
        source_degrees := [];
        for i in [ 1 .. Length( DegreeList( source ) ) ] do
        
          source_degrees := Concatenation( source_degrees,
                            ListWithIdenticalEntries( DegreeList( source )[ i ][ 2 ], DegreeList( source )[ i ][ 1 ] ) );
        
        od;

        # turn the range-degrees into a column vector, that we will compare with the ranges dictated by the mapping matrix
        range_degrees := [];
        for i in [ 1 .. Length( DegreeList( range ) ) ] do
        
          range_degrees := Concatenation( range_degrees,
                           ListWithIdenticalEntries( DegreeList( range )[ i ][ 2 ], DegreeList( range )[ i ][ 1 ] ) );
        
        od;

        # compute the dummy_range_degrees whilst checking at the same time that the mapping is well-defined
        # the only question left after this test is if the range of the well-defined map is really the range
        # specified for the mapping
        morphism_matrix_entries := EntriesOfHomalgMatrixAsListList( morphism_matrix );
        dummy_range_degrees := List( [ 1 .. Rank( range ) ] );
        for i in [ 1 .. Rank( range ) ] do
        
          # initialise the i-th buffer row
          buffer_row := List( [ 1 .. Rank( source ) ] );

          # compute its entries
          for j in [ 1 .. Rank( source ) ] do
        
            if morphism_matrix_entries[ i ][ j ] = Zero( HomalgRing( morphism_matrix ) ) then
        
              buffer_row[ j ] := range_degrees[ i ];

            else
        
              buffer_row[ j ] := source_degrees[ j ] + degrees_of_entries_matrix[ i ][ j ];
        
            fi;
        
          od;

          # check that the degrees in buffer_row are all the same, for if not the mapping is not well-defined
          if Length( DuplicateFreeList( buffer_row ) ) > 1 then
        
            return false;
        
          fi;
        
          # otherwise add this common degree to the dummy_range_degrees
          dummy_range_degrees[ i ] := buffer_row[ 1 ];
        
        od;
        
        # and now perform the final check
        if not ( range_degrees = dummy_range_degrees ) then
        
          return false;
        
        fi;
        
        # all tests have been passed, so return true
        return true;
        
    end );



    ######################################################################
    #
    # @Section Implement the elementary operations for categories
    #
    ######################################################################

    # @Description
    # This method checks if two rows are equal. We consider them equal if they have equal degree lists.
    # @Returns true or false
    # @Arguments object1, object2
    AddIsEqualForObjects( category,
      function( object1, object2 )
      local deg_list1, deg_list2;
      
        return DegreeList( object1 ) = DegreeList( object2 );

    end );

    # @Description
    # This method checks if the sources and ranges of the two morphisms are equal (by means of the method above).
    # Finally we compare the mapping matrices. If all three match, then two morphisms are considered equal.
    # Note that a mapping matrix alone does not fix a map of graded modules, because it does not fix the degrees of
    # source and range (take e.g. the 0-matrix)!
    # @Returns true or false
    # @Arguments morphism1, morphism2
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )

        return UnderlyingHomalgMatrix( morphism_1 ) = UnderlyingHomalgMatrix( morphism_2 );

    end );
    
    # @Description
    # This composes two mappings - straight forward.
    # @Returns a morphism
    # @Arguments morphism1, morphism2
    AddPreCompose( category,

      function( morphism_1, morphism_2 )
        local composition;

        composition := UnderlyingHomalgMatrix( morphism_2 ) * UnderlyingHomalgMatrix( morphism_1 );

        return GradedRowOrColumnMorphism( Source( morphism_1 ),
                                          composition,
                                          Range( morphism_2 ),
                                          checks
                                          );

    end );

    # @Description
    # This method installs the identity morphism of <A>object</A> by using the identity matrix.
    # @Returns a morphism
    # @Arguments object
    AddIdentityMorphism( category,
      
      function( object )
        
        return GradedRowOrColumnMorphism( object,
                                          HomalgIdentityMatrix( Rank( object ), underlying_graded_ring ),
                                          object,
                                          checks
                                          );
        
    end );
    


    ######################################################################
    #
    # @Section Enrich the category with an additive structure
    #
    ######################################################################
            
    # @Description
    # This method adds the two morphisms <A>morphism1</A> and <A>morphism2</A> by using the addition of the mapping
    # matrices.
    # @Returns a morphism
    # @Arguments morphism1, morphism2
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return GradedRowOrColumnMorphism( Source( morphism_1 ),
                                          UnderlyingHomalgMatrix( morphism_1 ) + UnderlyingHomalgMatrix( morphism_2 ),
                                          Range( morphism_2 ),
                                          checks
                                          );
    end );

    # @Description
    # This method installs the additive inverse of a <A>morphism</A> by using the additive inverse of the underlying
    # mapping matrix.
    # @Returns a morphism
    # @Arguments morphism
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return GradedRowOrColumnMorphism( Source( morphism ),
                                          MinusOne( UnderlyingHomalgGradedRing( morphism ) ) * UnderlyingHomalgMatrix( morphism ),
                                          Range( morphism ),
                                          checks
                                          );
    end );

    # @Description
    # Decides if a morphism is the zero morphism. To this end we check if the underlying matrix is the zero matrix.
    # @Returns true or false
    # @Arguments morphism
    AddIsZeroForMorphisms( category,
      function( morphism )
        
        return IsZero( UnderlyingHomalgMatrix( morphism ) );
        
    end );
    
    # @Description
    # Given an <A>object</A> this method checks if the object is the zero object (which is defined below). To this end it
    # suffices to check that the rank of <A>object</A> is zero.
    # @Returns a morphism
    # @Arguments source_object, range_object
    AddIsZeroForObjects( category,
      function( object )
      
        return Rank( object ) = 0;
      
      end );
    
    # @Description
    # Given a <A>source</A> and a <A>range</A> object, this method constructs the zero morphism between these two objects.
    # To this end the zero matrix of appropriate dimensions is used.
    # @Returns a morphism
    # @Arguments source, range
    AddZeroMorphism( category,
      function( source, range )
        
        return GradedRowOrColumnMorphism( source,
                                          HomalgZeroMatrix( Rank( range ), Rank( source ), underlying_graded_ring ),
                                          range,
                                          checks
                                          );
    end );

    # @Description
    # This method installs the zero object of this Proj-category. Internally it is represented by the 
    # empty degree_list.
    # @Returns an object
    # @Arguments 
    AddZeroObject( category,
      function( )
        
        return GradedColumn( [ ],
                             underlying_graded_ring,
                             checks
                              );
    end );
    
    # @Description
    # This method installs the (unique) zero morphism from the object <A>object</A> to the zero object. The latter has to be 
    # given to this method for convenience. More convenient methods are derived from the CAP-kernel afterwards.
    # @Returns a morphism
    # @Arguments object, zero_object
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( object, zero_object )
        local morphism;
        
        morphism := GradedRowOrColumnMorphism( object,
                                               HomalgZeroMatrix( 0, Rank( object ), underlying_graded_ring ),
                                               zero_object,
                                               checks
                                              );
        return morphism;
        
    end );
    
    # @Description
    # This method installs the (unique) zero morphism to the object <A>object</A> from the zero object. The latter has to be 
    # given to this method for convenience. More convenient methods are derived from the CAP-kernel afterwards.
    # @Returns a morphism
    # @Arguments object, zero_object
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( object, zero_object )
        local morphism;
        
        morphism := GradedRowOrColumnMorphism( zero_object,
                                               HomalgZeroMatrix( Rank( object ), 0, underlying_graded_ring ),
                                               object,
                                               checks
                                              );
        return morphism;
        
    end );
    
    # @Description
    # This method installs the direct sum of the list of objects <A>object_list</A>. We construct this direct sum object
    # by concatenation of the individual degree lists.
    # @Returns an object
    # @Arguments object_list
    AddDirectSum( category,
      function( object_list )
      local degree_list_list, degree_list_of_direct_sum_object;
      
      # then the degree_list of the direct sum object
      degree_list_list := List( object_list, x -> DegreeList( x ) );
      degree_list_of_direct_sum_object := Concatenation( degree_list_list );
      
      # and then return the corresponding object
      return GradedColumn( degree_list_of_direct_sum_object,
                           underlying_graded_ring,
                           checks
                          );
      
    end );
    
    # @Description
    # This methods adds the projection morphism from the direct sum object <A>direct_sum_object</A> formed from a list of 
    # objects <A>object_list</A> to its <A>projection_number</A>-th factor.
    # @Returns a morphism
    # @Arguments object_list, projection_number, direct_sum_object
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, projection_number, direct_sum_object )
        local rank_pre, rank_post, rank_factor, number_of_objects, projection_in_factor;
        
        # and the number of objects that were 'added'
        number_of_objects := Length( object_list );
        
        # collect necessary data to construct the mapping matrix
        rank_pre := Sum( object_list{ [ 1 .. projection_number - 1 ] }, c -> Rank( c ) );
        rank_post := Sum( object_list{ [ projection_number + 1 .. number_of_objects ] }, c -> Rank( c ) );
        rank_factor := Rank( object_list[ projection_number ] );
        
        # construct the mapping as homalg matrix
        projection_in_factor := HomalgZeroMatrix( rank_factor, rank_pre, underlying_graded_ring );
        projection_in_factor := Iterated( [ projection_in_factor,
                                            HomalgIdentityMatrix( rank_factor, underlying_graded_ring ) ],
                                           UnionOfColumns );
        projection_in_factor := Iterated( [ projection_in_factor,
                                            HomalgZeroMatrix( rank_factor, rank_post, underlying_graded_ring ) ],
                                           UnionOfColumns );
        
        # and return the corresonding morphism
        return GradedRowOrColumnMorphism( direct_sum_object,
                                          projection_in_factor,
                                          object_list[ projection_number ],
                                          checks 
                                          );
        
    end );

    # @Description
    # This method requires a list of objects <A>diagram</A> = (S_1,...,S_n), a list of morphisms <A>sink<A> (T -> S_i) 
    # and the direct sum object <A>direct_sum</A> $= \oplus S_i$. From this the universal morphism $T \to S$ is computed.
    # @Returns a morphism
    # @Arguments diagram, sink, direct_sum
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local underlying_matrix_of_universal_morphism, morphism;
        
        # construct the homalg matrix to represent the universal morphism
        underlying_matrix_of_universal_morphism := UnderlyingHomalgMatrix( sink[ 1 ] );
        
        for morphism in sink{ [ 2 .. Length( sink ) ] } do
          
          underlying_matrix_of_universal_morphism := 
            Iterated( [ underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) ],
                      UnionOfRows );
        
        od;
        
        # and then construct from it the corresponding morphism
        return GradedRowOrColumnMorphism( Source( sink[ 1 ] ),
                                                                        underlying_matrix_of_universal_morphism, 
                                                                        direct_sum,
                                                                        checks
                                                                       );
    end );

    # @Description
    # This method adds the injection morphism from the <A>injection_number<A>-th cofactor of the direct sum 
    # <A>coproduct_object</A> formed from the list of objects <A>object_list</A>.
    # @Returns a morphism
    # @Arguments object_list, injection_number, coproduct_object
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, injection_number, coproduct )
        local rank_pre, rank_post, rank_cofactor, number_of_objects, injection_of_cofactor;
        
        # and the number of objects
        number_of_objects := Length( object_list );

        # now collect the data needed to construct the injection matrix
        rank_pre := Sum( object_list{ [ 1 .. injection_number - 1 ] }, c -> Rank( c ) );
        rank_post := Sum( object_list{ [ injection_number + 1 .. number_of_objects ] }, c -> Rank( c ) );
        rank_cofactor := Rank( object_list[ injection_number ] );
        
        # now construct the mapping matrix
        injection_of_cofactor := HomalgZeroMatrix( rank_pre, rank_cofactor, underlying_graded_ring );
        injection_of_cofactor := Iterated( [ injection_of_cofactor, 
                                             HomalgIdentityMatrix( rank_cofactor, underlying_graded_ring ) ],
                                            UnionOfRows );
        injection_of_cofactor := Iterated( [ injection_of_cofactor,
                                             HomalgZeroMatrix( rank_post, rank_cofactor, underlying_graded_ring ) ],
                                            UnionOfRows );
        
        # and construct the associated morphism
        return GradedRowOrColumnMorphism( object_list[ injection_number ],
                                          injection_of_cofactor,
                                          coproduct,
                                          checks
                                          );
        
    end );

    # @Description
    # This method requires a list of objects <A>diagram</A> = (S_1,...,S_n), a list of morphisms <A>sink<A> (S_i -> T) 
    # and the direct sum object <A>coproduct</A> $= \oplus S_i$. From this the universal morphism $S \to T$ is computed.
    # @Returns a morphism
    # @Arguments diagram, sink, coproduct
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, coproduct )
        local underlying_matrix_of_universal_morphism, morphism;
        
        underlying_matrix_of_universal_morphism := UnderlyingHomalgMatrix( sink[1] );
        
        for morphism in sink{ [ 2 .. Length( sink ) ] } do
          
          underlying_matrix_of_universal_morphism := 
            Iterated( [ underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) ],
                      UnionOfColumns );
          
        od;
        
        return GradedRowOrColumnMorphism( coproduct,
                                          underlying_matrix_of_universal_morphism,
                                          Range( sink[ 1 ] ),
                                          checks
                                        );
        
    end );

    
    
    ######################################################################
    #
    # @Section Add lift and colift
    #
    ######################################################################

    # @Description
    # This method requires a morphism <A>morphism1</A> $a \to c$ and a morphism <A>morphism2</A> $b \to c$. The result of 
    # Lift( morphism1, morphism2 ) is then the lift morphism $a \to b$.
    # @Returns a morphism
    # @Arguments morphism1, morphism2
    AddLift( category,
      function( morphism1, morphism2 )
        local left_divide, required_degrees, lift;

        # try to find a lift
        left_divide := LeftDivide( UnderlyingHomalgMatrix( morphism2 ), UnderlyingHomalgMatrix( morphism1 ) );

        # check if this failed
        if left_divide = fail then
          
          return fail;
          
        fi;

        # identify the homogeneous part of this matrix
        required_degrees := List( UnzipDegreeList( Source( morphism2 ) ),
                                i -> List( UnzipDegreeList( Source( morphism1 ) ), j -> i - j ) );
        lift := HomogeneousPartOfMatrix( left_divide, required_degrees );
        
        # and construct the lift
        return GradedRowOrColumnMorphism( Source( morphism1 ),
                                          lift,
                                          Source( morphism2 ),
                                          checks
                                          );
        
    end );    

    # @Description
    # This method requires a morphism <A>morphism1</A> $a \to c$ and a morphism <A>morphism2</A> $a \to b$. The result of 
    # Colift( morphism1, morphism2 ) is then the colift morphism $c \to b$.
    # @Returns a morphism
    # @Arguments morphism1, morphism2
    AddColift( category,
      function( morphism1, morphism2 )
        local right_divide, required_degrees, colift;
        
        # try to find a matrix that performs the colift
        right_divide := RightDivide( UnderlyingHomalgMatrix( morphism2 ), UnderlyingHomalgMatrix( morphism1 ) );

        # check if this worked
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        required_degrees := List( UnzipDegreeList( Range( morphism2 ) ),
                                i -> List( UnzipDegreeList( Range( morphism1 ) ), j -> i - j ) );
        colift := HomogeneousPartOfMatrix( right_divide, required_degrees );
                                
        # if it did work, return the corresponding morphism
        return GradedRowOrColumnMorphism( Range( morphism1 ),
                                                 colift,
                                                 Range( morphism2 ),
                                                 checks
                                                 );
        
    end );



    ######################################################################
    #
    # @Section Add weak kernels and cokernels
    #
    ######################################################################

    # @Description
    # This method computes the weak kernel embedding of a morphism <A>morphism</A>.
    # @Returns a morphism
    # @Arguments morphism    
    AddWeakKernelEmbedding( category,
      function( morphism )
        local kernel_matrix;
             
        # then compute the syzygies of rows, which form the 'kernel matrix'
        kernel_matrix := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );

        # deduce the kernel_embedding from this
        return DeduceMapFromMatrixAndRangeForGradedCols( kernel_matrix, Source( morphism ) );

    end );

    # @Description
    # This method computes the weak cokernel projection of a morphism <A>morphism</A>.
    # @Returns a morphism
    # @Arguments morphism
    AddWeakCokernelProjection( category,
      function( morphism )
        local cokernel_matrix;
             
        # then compute the syzygies of rows, which form the 'kernel matrix'
        cokernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );

        # deduce the cokernel projection from this
        return DeduceMapFromMatrixAndSourceForGradedCols( cokernel_matrix, Range( morphism ) );

    end );



    ################################################################################################################
    #
    # @Section Add (Weak) Fibre product
    #
    ################################################################################################################
    
    ##
    AddProjectionInFirstFactorOfWeakBiFiberProduct( category,
      function( alpha, beta )
        local morphism_list, projection_number, projection_matrix;
        
        morphism_list := [ alpha, beta ];
        
        projection_number := 1;
        
        projection_matrix := CAP_INTERNAL_WEAK_FIBER_PRODUCT_GRADED_COLUMNS( morphism_list, projection_number );
        
        # and from this deduce the projection map
        return DeduceMapFromMatrixAndRangeForGradedCols( projection_matrix, Source( morphism_list[ projection_number ] ) );
        
    end );
    
    ##
    AddProjectionInSecondFactorOfWeakBiFiberProduct( category,
      function( alpha, beta )
        local morphism_list, projection_number, projection_matrix;
        
        morphism_list := [ alpha, beta ];
        
        projection_number := 2;
        
        projection_matrix := CAP_INTERNAL_WEAK_FIBER_PRODUCT_GRADED_COLUMNS( morphism_list, projection_number );
        
        # and from this deduce the projection map
        return DeduceMapFromMatrixAndRangeForGradedCols( projection_matrix, Source( morphism_list[ projection_number ] ) );
        
    end );
    
    ################################################################################################################
    #
    # @Section Add (Weak) Pushout
    #
    ################################################################################################################
    
    ##
    AddInjectionOfFirstCofactorOfWeakBiPushout( category,
      function( alpha, beta )
        local morphism_list, injection_number, embedding_matrix;
        
        morphism_list := [ alpha, beta ];
        
        injection_number := 1;
        
        embedding_matrix := CAP_INTERNAL_WEAK_PUSHOUT_GRADED_COLUMNS( morphism_list, injection_number );
        
        return DeduceMapFromMatrixAndSourceForGradedCols( embedding_matrix, Range( morphism_list[ injection_number ] ) );
        
    end );
    
    ##
    AddInjectionOfSecondCofactorOfWeakBiPushout( category,
      function( alpha, beta )
        local morphism_list, injection_number, embedding_matrix;
        
        morphism_list := [ alpha, beta ];
        
        injection_number := 2;
        
        embedding_matrix := CAP_INTERNAL_WEAK_PUSHOUT_GRADED_COLUMNS( morphism_list, injection_number );
        
        return DeduceMapFromMatrixAndSourceForGradedCols( embedding_matrix, Range( morphism_list[ injection_number ] ) );
        
    end );
    
    ######################################################################
    #
    # @Section Add BiasedWeakFibreProduct
    #
    ######################################################################

    # @Description
    # This method implements the projection of the biased weak fiber product onto the source of the 
    # first morphism. By this we mean the following:
    # Given morphisms m1: A to B and m2: C to B, we consider the diagram:
    # P ---d--> C
    # |         |
    # g        m2
    # |         |
    # v         v
    # A --m1--> B
    # We are interested in constructing a morphism g such that there exists a morphism d: P to C such that
    # the above diagram commutes. However, we do not provide an algorithm to compute d.
    # This morphism g must be universal in the sense that given another morphism tau: T -> A such that there 
    # exists a morphism T -> C which makes the corresponding square commute, there exists a morphism
    # u: T -> P such that g \circ u = tau. Note that u is not unique in this setup!
    AddProjectionOfBiasedWeakFiberProduct( category,
      function( morphism_1, morphism_2 )
        local homalg_matrix, weak_cokernel_object;
        
        homalg_matrix := ReducedSyzygiesOfColumns( UnderlyingHomalgMatrix( morphism_1 ),
                                                   UnderlyingHomalgMatrix( morphism_2 ) );
        
        return DeduceMapFromMatrixAndRangeForGradedCols( homalg_matrix, Source( morphism_1 ) );
        
    end );

    # @Description
    # This method implements the injection from the range of the first morphism into the biased weak pushout.
    # By this we mean the following:
    # Given morphisms m1: C to A and m2: C to B, we consider the diagram:
    # B ---d--> P
    # ^         ^
    # |         |
    # m2        g
    # |         |
    # C --m1--> A
    # We are interested in constructing a morphism g such that there exists a morphism d: B to P such that
    # the above diagram commutes. However, we do not provide an algorithm to compute d.
    # This morphism g must be universal in the sense that given another morphism tau: A -> T such that there
    # exists a morphism B -> T which makes the corresponding square commute, there exists a morphism
    # u: P -> T such that u \circ g = tau. Note that u is not unique in this setup!
    ##
    AddInjectionOfBiasedWeakPushout( category,
        function( morphism_1, morphism_2 )
        local homalg_matrix, weak_cokernel_object;

        homalg_matrix := ReducedSyzygiesOfRows( UnderlyingHomalgMatrix( morphism_1 ),
                                                UnderlyingHomalgMatrix( morphism_2 ) );

        return DeduceMapFromMatrixAndSourceForGradedCols( homalg_matrix, Range( morphism_1 ) );

    end );

    # Monoidal structure can be defined if the underlying ring of graded columns is commutative
    # In the non-commutative case, such a monoidal structure cannot be expected in general.
    if HasIsCommutative( UnderlyingNonGradedRing( UnderlyingGradedRing( category ) ) )
       and IsCommutative( UnderlyingNonGradedRing( UnderlyingGradedRing( category ) ) ) then

    ######################################################################
    #
    # @Section Add Basic Monoidal Structure
    #
    ######################################################################

    # @Description
    # This method computes the tensor product of the two columns <A>object1</A> and <A>object2</A>
    # @Returns an object
    # @Arguments object1, object2
    AddTensorProductOnObjects( category,
      function( object1, object2 )
        local degree_list1, degree_list2, degree_list1_extended, degree_list_tensor_object, i, j, buffer_list;

        # check if one of the objects is the zero object
        if IsZero( object1 ) or IsZero( object2 ) then
          return ZeroObject( CapCategory( object1 ) );
        fi;

        # next extract the two degree_lists
        degree_list1 := DegreeList( object1 );
        degree_list2 := DegreeList( object2 );

        # check if object1 is of rank 1 (this includes the tensor unit)
        if Rank( object1 ) = 1 then
          degree_list_tensor_object := List( degree_list2, x -> [ x[ 1 ] + degree_list1[ 1 ][ 1 ], x[ 2 ] ] );
          return GradedColumn( degree_list_tensor_object,
                               UnderlyingHomalgGradedRing( object1 ),
                               checks
                             );
        fi;

        # check if object2 is of rank 1 (this includes the tensor unit)
        if Rank( object2 ) = 1 then
          degree_list_tensor_object := List( degree_list1, x -> [ x[ 1 ] + degree_list2[ 1 ][ 1 ], x[ 2 ] ] );
          return GradedColumn( degree_list_tensor_object,
                               UnderlyingHomalgGradedRing( object1 ),
                               checks
                             );
        fi;

        # now compute the degree_list of the tensor product of object1 and object2
        degree_list_tensor_object := [];
        for i in [ 1 .. Length( degree_list1 ) ] do

          buffer_list := List( degree_list2, x -> [ degree_list1[ i ][ 1 ] + x[ 1 ], x[ 2 ] ] );
          for j in [ 1 .. degree_list1[ i ][ 2 ] ] do
            Append( degree_list_tensor_object, buffer_list );
          od;

        od;

        # now construct a new object in this category
        return GradedColumn( degree_list_tensor_object,
                             UnderlyingHomalgGradedRing( object1 ),
                             checks
                           );

    end );

    # @Description
    # This method computes the tensor product of the two maps of graded columns <A>morphism1</A> and <A>morphism2</A>.
    # @Returns a morphism
    # @Arguments source = Source( morphism1 ) \otimes Source( morphism2 ), morphism1, morphism2, 
    #            range = Range( morphism1 ) \otimes Range( morphism2 )
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      function( source, morphism1, morphism2, range )
                
        return GradedRowOrColumnMorphism( source,
                                       KroneckerMat( UnderlyingHomalgMatrix( morphism1 ), UnderlyingHomalgMatrix( morphism2 ) ),
                                       range,
                                       checks
                                      );

    end );

    # @Description
    # This method computes the tensor unit in the category of graded columns. This is the module
    # of degree 0 and rank 1.
    # @Returns an object
    # @Arguments     
    AddTensorUnit( category,
      function( )
        
        return GradedColumn( [ [ TheZeroElement( DegreeGroup( underlying_graded_ring ) ) , 1 ] ],
                             underlying_graded_ring,
                             checks
                           );
        
    end );



    ######################################################################
    #
    # @Section Add Symmetric Monoidal Structure 
    # (i.e. braiding and the inverse is given by B_a,b^{-1} = B_{b,a}
    #
    ######################################################################

    # @Description
    # This method computes the braiding morphism object1_tensored_object2 to object2_tensored_object1
    # @Returns a morphism
    # @Arguments object1_tensored_object2, object1, object2, object2_tensored_object1
    AddBraidingWithGivenTensorProducts( category,
      function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local rank_1, rank_2, rank, permutation_matrix;
        
        rank_1 := Rank( object_1 );
        rank_2 := Rank( object_2 );
        rank := Rank( object_1_tensored_object_2 );
        
        # compute the mapping matrix
        permutation_matrix := PermutationMat( 
                         PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) ),
                                rank 
                              );
        permutation_matrix := Involution( HomalgMatrix( permutation_matrix, rank, rank, underlying_graded_ring ) );
        
        # and return the corresponding morphism
        return GradedRowOrColumnMorphism( object_1_tensored_object_2,
                                                                        permutation_matrix,
                                                                        object_2_tensored_object_1,
                                                                        checks
                                                                       );
    
    end );



    ######################################################################
    #
    # @Section Add Rigid, Symmetric Closed Monoidal Structure
    #
    ######################################################################
    
    # @Description
    # This method computes the dual of a graded column <A>object</A> (c.f. dual of vector spaces).
    # Note that this dualisation is used to compute the internal homs via 
    # Hom( object1, object2 ) = Dual( object1 ) \otimes object2.
    # @Returns an object
    # @Arguments object
    AddDualOnObjects( category,
      function( object )
        local degree_list_dual_object;
                
        # the dual is given by taking the inverse of all degrees but leaving the multiplicities unchanged
        degree_list_dual_object := List( DegreeList( object ),
                                         k -> [ MinusOne( HomalgRing( SuperObject( k[ 1 ] ) ) ) * k[ 1 ], k[ 2 ] ] );
        
        # and return the corresponding object
        return GradedColumn( degree_list_dual_object,
                             UnderlyingHomalgGradedRing( object ),
                             checks
                            );
        
    end );

    # @Description
    # This method computes the dual of a morphism of graded columns (c.f. dual of vector space morphism).
    # @Returns a morphism
    # @Arguments source, morphism, range
    AddDualOnMorphismsWithGivenDuals( category,
      function( source, morphism, range )
    
      # simply transpose the mapping matrix and return the result
      return GradedRowOrColumnMorphism( source,
                                        Involution( UnderlyingHomalgMatrix( morphism ) ),
                                        range,
                                        checks
                                        );
    end );

    # @Description
    # This method computes the evaluation morphism for a graded column <A>object</A>. This is it computes a
    # morphism <A>Dual(object)</A> \otimes <A>object</A> to the tensor unit.
    # @Returns a morphism
    # @Arguments tensor_object = Dual( object) \otimes object, object, unit
    AddEvaluationForDualWithGivenTensorProduct( category,
      function( tensor_object, object, unit )
        local rank, column, zero_column, i;

        # collect and initialise the necessary information
        rank := Rank( object );
        column := [ ];        
        zero_column := List( [ 1 .. rank ], i -> 0 );

        # produce the mapping column
        for i in [ 1 .. rank - 1 ] do
          
          Add( column, 1 );
          Append( column, zero_column );
          
        od;

        if rank > 0 then

          Add( column, 1 );
          
        fi;
        
        # return the evaluation morphism
        return GradedRowOrColumnMorphism( tensor_object,
                                          HomalgMatrix( column, 1, Rank( tensor_object), underlying_graded_ring ),
                                          unit,
                                          checks
                                          );
        
    end );

    # @Description
    # This method computes the coevaluation morphism for a graded column <A>object</A>. This is it computes a
    # morphism tensor unit to <A>Dual(object)</A> \otimes <A>object</A>.
    # @Returns a morphism
    # @Arguments unit, object, tensor_object = Object \otimes Dual( object )
    AddCoevaluationForDualWithGivenTensorProduct( category,
      function( unit, object, tensor_object )
        local rank, column, zero_column, i;
        
        # collect and initialise the necessary information
        rank := Rank( object );
        column := [ ];        
        zero_column := List( [ 1 .. rank ], i -> 0 );

        # produce the mapping column
        for i in [ 1 .. rank - 1 ] do
          
          Add( column, 1 );
          Append( column, zero_column );
          
        od;

        if rank > 0 then

          Add( column, 1 );
          
        fi;
        
        # return the evaluation morphism
        return GradedRowOrColumnMorphism( unit,
                                          HomalgMatrix( column, Rank( tensor_object), 1, underlying_graded_ring ),
                                          tensor_object,
                                          checks 
                                          );

    end );

    # @Description
    # Given an <A>object</A>, this method computes the morphism to the bidual, i.e. the morphism
    # <A>object</A> to <A>Dual(Dual(object))</A>. In the category at hand this is just the identity morphism.
    # @Returns a morphism
    # @Arguments object, bidual_object = Dual(Dual(object))
    AddMorphismToBidualWithGivenBidual( category,
      function( object, bidual_object )
      
        return GradedRowOrColumnMorphism( object,
                                          HomalgIdentityMatrix( Rank( object ), underlying_graded_ring ),
                                          bidual_object,
                                          checks
                                        );

    end );

    fi;

end );

##
InstallGlobalFunction( CAP_INTERNAL_WEAK_FIBER_PRODUCT_GRADED_COLUMNS,
  function( morphism_list, projection_number )
    local mapping_matrix, matrix_list, projection_matrix, j;
    
    if Length( morphism_list ) = 1 then
      
      return KernelEmbedding( morphism_list[ 1 ] );
      
    fi;
    
    # extract the mapping matrix of the morphism[ projection_number ]
    mapping_matrix := UnderlyingHomalgMatrix( morphism_list[ projection_number ] );
    
    # construct list of mapping matrices of all maps in morphism_list but the one that we wish to compute the
    # projection morphism of
    matrix_list := List( morphism_list, x -> UnderlyingHomalgMatrix( x ) );
    Remove( matrix_list, projection_number );
    
    # now iterate the syzygies computation
    projection_matrix := SyzygiesOfColumns( mapping_matrix, matrix_list[ 1 ] );
    for j in [ 2 .. Length( matrix_list ) ] do
      
      projection_matrix := projection_matrix * SyzygiesOfColumns( mapping_matrix *
                                                                        projection_matrix, matrix_list[ j ] );
      
    od;
    
    return projection_matrix;
    
end );

##
InstallGlobalFunction( CAP_INTERNAL_WEAK_PUSHOUT_GRADED_COLUMNS,
  function( morphism_list, injection_number )
    local mapping_matrix, matrix_list, embedding_matrix, j;
    
    if Length( morphism_list ) = 1 then
      
      return KernelEmbedding( morphism_list[ 1 ] );
      
    fi;
    
    # extract the mapping matrix of the morphism[ injection_number ]
    mapping_matrix := UnderlyingHomalgMatrix( morphism_list[ injection_number ] );
    
    # construct list of mapping matrices of all maps in morphism_list but the one that we wish to compute the
    # projection morphism of
    matrix_list := List( morphism_list, x -> UnderlyingHomalgMatrix( x ) );
    Remove( matrix_list, injection_number );
    
    # now iterate the syzygies computation
    embedding_matrix := SyzygiesOfRows( mapping_matrix, matrix_list[ 1 ] );
    for j in [ 2 .. Length( matrix_list ) ] do
      
      embedding_matrix := SyzygiesOfRows( embedding_matrix * mapping_matrix, matrix_list[ j ] ) * embedding_matrix;
      
    od;
    
    return embedding_matrix;
    
end );
