#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
## Chapter Category of projective graded left modules
##
#############################################################################


#############################################################
##
## Constructor for category of projective graded left-modules
##
#############################################################

InstallMethod( CAPCategoryOfProjectiveGradedLeftModules,
               [ IsHomalgGradedRing ],
               
  function( homalg_graded_ring )
    local category;
    
      # construct the category
      category := CreateCapCategory( Concatenation( "CAP category of projective graded left modules over "
                                                                                          , RingName( homalg_graded_ring ) ) );
      category!.homalg_graded_ring_for_category_of_projective_graded_left_modules := homalg_graded_ring;

      # set its properties
      SetIsAdditiveCategory( category, true );
      SetIsStrictMonoidalCategory( category, true );
      SetIsRigidSymmetricClosedMonoidalCategory( category, true );    
    
      # install its functionality
      INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_LEFT_MODULES( category ); 
    
      # add theorem file
      AddTheoremFileToCategory( category,
        Filename(
        DirectoriesPackageLibrary( "CAPCategoryOfProjectiveGradedModules", "LogicLeft" ),
        "Propositions.tex" )
      );
    
      # add predicate-implication file
      AddPredicateImplicationFileToCategory( category,
        Filename(
        DirectoriesPackageLibrary( "CAPCategoryOfProjectiveGradedModules", "LogicLeft" ),      
        "PredicateImplications.tex" )
      );
    
      # add relations file
      AddEvalRuleFileToCategory( category,
        Filename(
        DirectoriesPackageLibrary( "CAPCategoryOfProjectiveGradedModules", "LogicLeft" ),
        "Relations.tex" )
      );
    
      # finalise the category
      Finalize( category );
    
      # and return it
      return category;

end );


####################################################################
##
## Basic operations for category of projective, graded, left modules
##
####################################################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_LEFT_MODULES,

  function( category )

  
  
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
          
          # otherwise we are not looking at the zero object, so let us check that all degrees lie in the DegreeClass and that
          # rank is correctly summed
          for i in [ 1 .. Length( DegreeList( object ) ) ] do
          
            if not IsHomalgModuleElement( DegreeList( object )[ i ][ 1 ] ) then
            
              # the degrees are not saves as homalg module elements, so return false
              return false;
            
            elif not IsIdenticalObj( SuperObject( DegreeList( object )[ i ][ 1 ] ), A ) then
            
              # the degrees are not homalg_module_elements in the degree class of the homalg ring underlying the object
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
             source_degrees, range_degrees, buffer_col, dummy_range_degrees, i, j;

        # extract source and range
        source := Source( morphism );        
        range := Range( morphism );

        # next check that the underlying homalg_graded_rings are identical
        if not ( IsIdenticalObj( UnderlyingHomalgGradedRing( source ), UnderlyingHomalgGradedRing( morphism ) ) and
                        IsIdenticalObj( UnderlyingHomalgGradedRing( morphism ), UnderlyingHomalgGradedRing( range ) ) ) then

          return false;

        fi;

        # and that source and range are defined in the same category
        if not IsIdenticalObj( CapCategory( source ), CapCategory( range ) ) then

          return false;

        fi;

        # extract the mapping matrix        
        morphism_matrix := UnderlyingHomalgMatrix( morphism );

        # then check if the dimensions of the matrix fit with the ranks of the source and range modules
        if not ( Rank( source ) = NrRows( morphism_matrix )
                 and NrColumns( morphism_matrix ) = Rank( range ) ) then

          return false;

        fi;

        # check if the mapping is non-trivial, for otherwise we are done already
        if ( Rank( source ) = 0 or Rank( range ) = 0 ) then

          return true;

        else

          # extract the degrees of the entries of the morphism_matrix

          # I use the DegreeOfEntries of the underlying graded ring
          # in particular I hope that this function raises and error if one of the entries is not homogeneous
          degrees_of_entries_matrix := DegreesOfEntries( morphism_matrix );

          # turn the degrees of the source into a column vector (that is how I think about right-modules)
          source_degrees := [];
          for i in [ 1 .. Length( DegreeList( source ) ) ] do

            for j in [ 1 .. DegreeList( source )[ i ][ 2 ] ] do

              Add( source_degrees, DegreeList( source )[ i ][ 1 ] );

            od;

          od;

          # turn the range-degrees into a column vector, that we will compare with the ranges dictated by the mapping matrix
          range_degrees := [];
          for i in [ 1 .. Length( DegreeList( range ) ) ] do

            for j in [ 1 .. DegreeList( range )[ i ][ 2 ] ] do

              Add( range_degrees, DegreeList( range )[ i ][ 1 ] );

            od;

          od;

          # compute the dummy_range_degrees whilst checking at the same time that the mapping is well-defined
          # the only question left after this test is if the range of the well-defined map is really the range
          # specified for the mapping
          morphism_matrix_entries := EntriesOfHomalgMatrixAsListList( morphism_matrix );
          dummy_range_degrees := List( [ 1 .. Rank( range ) ] );
          for i in [ 1 .. Rank( range ) ] do
          
            # initialise the i-th buffer row
            buffer_col := List( [ 1 .. Rank( source ) ] );

            # compute its entries
            for j in [ 1 .. Rank( source ) ] do
                        
              if morphism_matrix_entries[ j ][ i ] = Zero( HomalgRing( morphism_matrix ) ) then
              
                buffer_col[ j ] := range_degrees[ i ];

              else
              
                buffer_col[ j ] := source_degrees[ j ] - degrees_of_entries_matrix[ j ][ i ];
                
              fi;
            
            od;

            # check that the degrees in buffer_row are all the same, for if not the mapping is not well-defined
            if Length( DuplicateFreeList( buffer_col ) ) > 1 then
            
              return false;
              
            fi;
            
            # otherwise add this common degree to the dummy_range_degrees
            dummy_range_degrees[ i ] := buffer_col[ 1 ];
          
          od;
                  
          # and now perform the final check
          if not ( range_degrees = dummy_range_degrees ) then
          
            return false;
        
          fi;
          
          # all tests have been passed, so return true
          return true;
        
        fi;
        
    end );



    ######################################################################
    #
    # @Section Implement the elementary operations for categories
    #
    ######################################################################
    
    # @Description
    # This method checks if two projective modules are equal. We consider them equal if they are isomorphic.
    # @Returns true or false
    # @Arguments object1, object2
    AddIsEqualForObjects( category,
      function( object1, object2 )
        local deg_list1, deg_list2, i, j, new_deg_list1, new_deg_list2, comparer, counter;
      
        # step1: simplify the two degree_lists
        deg_list1 := List( [ 1 .. Length( DegreeList( object1 ) ) ] );
        for i in [ 1 .. Length( deg_list1 ) ] do
          deg_list1[ i ] := ShallowCopy( DegreeList( object1 )[ i ] );
        od;
        deg_list2 := List( [ 1 .. Length( DegreeList( object2 ) ) ] );
        for i in [ 1 .. Length( deg_list2 ) ] do
          deg_list2[ i ] := ShallowCopy( DegreeList( object2 )[ i ] );
        od;

        new_deg_list1 := [];
        new_deg_list2 := [];
        
        for i in [ 1 .. Length( deg_list1 ) ] do
        
          if deg_list1[ i ][ 2 ] <> -1 then
        
            comparer := deg_list1[ i ][ 1 ];
            counter := deg_list1[ i ][ 2 ];
        
            for j in [ i+1 .. Length( deg_list1 ) ] do
          
              if deg_list1[ j ][ 1 ] = comparer then
            
                counter := counter + deg_list1[ j ][ 2 ];
                deg_list1[ j ][ 2 ] := -1;
                
              fi;
          
            od;
            
            Add( new_deg_list1, [ comparer, counter ] );
        
          fi;
        
        od;
        
        for i in [ 1 .. Length( deg_list2 ) ] do
        
          if deg_list2[ i ][ 2 ] <> -1 then
        
            comparer := deg_list2[ i ][ 1 ];
            counter := deg_list2[ i ][ 2 ];
        
            for j in [ i+1 .. Length( deg_list2 ) ] do
          
              if deg_list2[ j ][ 1 ] = comparer then
            
                counter := counter + deg_list2[ j ][ 2 ];
                deg_list2[ j ][ 2 ] := -1;
                
              fi;
          
            od;
            
            Add( new_deg_list2, [ comparer, counter ] );
        
          fi;
        
        od;
        
        # step2: compare the degree_list (modulo potential permutations)
        if Length( new_deg_list1 ) <> Length( new_deg_list2 ) then
          return false;
        fi;
        
        for i in [ 1 .. Length( new_deg_list1 ) ] do
        
          # try to find a match for entry i of new_deg_list1 in new_deg_list2
          j := 1;
          while not ( ( new_deg_list1[ i ][ 1 ] = new_deg_list2[ j ][ 1 ] ) and 
                      ( new_deg_list1[ i ][ 2 ] = new_deg_list2[ j ][ 2 ] ) ) do
                          
             j := j + 1;
             
             if j > Length( new_deg_list2 ) then
               return false;
             fi;
             
          od;
          
          # and, if we find such an entry, remove it
          Remove( new_deg_list2, j );
        
        od;
        
        # and finally return if the two degree_lists encode isomorphic projective modules
        return Length( new_deg_list2 ) = 0;
      
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

      function( morphism1, morphism2 )
        local composition;

        composition := UnderlyingHomalgMatrix( morphism1 ) * UnderlyingHomalgMatrix( morphism2 );

        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism1 ), 
                                                                        composition, 
                                                                        Range( morphism2 ) );

    end );

    # @Description
    # This method installs the identity morphism of <A>object</A> by using the identity matrix.
    # @Returns a morphism
    # @Arguments object
    AddIdentityMorphism( category,
      
      function( object )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( object );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( object, 
                                                          HomalgIdentityMatrix( Rank( object ), homalg_graded_ring ), 
                                                          object );
        
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
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism_1 ),
                                                    UnderlyingHomalgMatrix( morphism_1 ) + UnderlyingHomalgMatrix( morphism_2 ),
                                                    Range( morphism_2 ) 
                                                    );
    end );

    # @Description
    # This method installs the additive inverse of a <A>morphism</A> by using the additive inverse of the underlying
    # mapping matrix.
    # @Returns a morphism
    # @Arguments morphism
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism ),
                                     MinusOne( UnderlyingHomalgGradedRing( morphism ) ) * UnderlyingHomalgMatrix( morphism ),
                                     Range( morphism )
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
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( source );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source,
                                           HomalgZeroMatrix( Rank( source ), Rank( range ), homalg_graded_ring ),
                                           range
                                          );
    end );

    # @Description
    # This method installs the zero object of this Proj-category. Internally it is represented by the 
    # empty degree_list.
    # @Returns an object
    # @Arguments 
    AddZeroObject( category,
      function( )
        
        return CAPCategoryOfProjectiveGradedLeftModulesObject( 
                                          [ ], category!.homalg_graded_ring_for_category_of_projective_graded_left_modules );
    end );

    # @Description
    # This method installs the (unique) zero morphism from the object <A>object</A> to the zero object. The latter has to be 
    # given to this method for convenience. More convenient methods are derived from the CAP-kernel afterwards.
    # @Returns a morphism
    # @Arguments object, zero_object
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( object, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( object, 
                                                                    HomalgZeroMatrix( Rank( object ), 0, homalg_graded_ring ), 
                                                                    zero_object
                                                                    );
        return morphism;
        
    end );

    # @Description
    # This method installs the (unique) zero morphism to the object <A>object</A> from the zero object. The latter has to be 
    # given to this method for convenience. More convenient methods are derived from the CAP-kernel afterwards.
    # @Returns a morphism
    # @Arguments zero_object, object
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( zero_object, object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( zero_object, 
                                                                    HomalgZeroMatrix( 0, Rank( object ), homalg_graded_ring ), 
                                                                    object
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
      local homalg_graded_ring, degree_list_list, degree_list_of_direct_sum_object;
      
      # first extract the underlying graded ring
      homalg_graded_ring := UnderlyingHomalgGradedRing( object_list[ 1 ] );

      # then the degree_list of the direct sum object
      degree_list_list := List( object_list, x -> DegreeList( x ) );
      degree_list_of_direct_sum_object := Concatenation( degree_list_list );
      
      # and then return the corresponding object
      return CAPCategoryOfProjectiveGradedLeftModulesObject( degree_list_of_direct_sum_object, homalg_graded_ring ); 
      
    end );
    
    # @Description
    # This methods adds the projection morphism from the direct sum object <A>direct_sum_object</A> formed from a list of 
    # objects <A>object_list</A> to its <A>projection_number</A>-th factor.
    # @Returns a morphism
    # @Arguments object_list, projection_number, direct_sum_object   
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, projection_number, direct_sum_object )
        local homalg_graded_ring, rank_pre, rank_post, rank_factor, number_of_objects, projection_in_factor;
        
        # extract the underlying graded ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( direct_sum_object );
        
        # and the number of objects that were 'added'
        number_of_objects := Length( object_list );
        
        # collect necessary data to construct the mapping matrix
        rank_pre := Sum( object_list{ [ 1 .. projection_number - 1 ] }, c -> Rank( c ) );
        rank_post := Sum( object_list{ [ projection_number + 1 .. number_of_objects ] }, c -> Rank( c ) );        
        rank_factor := Rank( object_list[ projection_number ] );
        
        # construct the mapping as homalg matrix
        projection_in_factor := HomalgZeroMatrix( rank_pre, rank_factor, homalg_graded_ring );        
        projection_in_factor := UnionOfRows( projection_in_factor, 
                                             HomalgIdentityMatrix( rank_factor, homalg_graded_ring ) );
        projection_in_factor := UnionOfRows( projection_in_factor, 
                                             HomalgZeroMatrix( rank_post, rank_factor, homalg_graded_ring ) );
        
        # and return the corresonding morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( direct_sum_object, projection_in_factor, 
                                                                                             object_list[ projection_number ] );
        
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
            UnionOfColumns( underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) );
          
        od;
        
        # and then construct from it the corresponding morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( sink[ 1 ] ), 
                                                                          underlying_matrix_of_universal_morphism, direct_sum );      
    end );

    # @Description
    # This method adds the injection morphism from the <A>injection_number<A>-th cofactor of the direct sum 
    # <A>coproduct_object</A> formed from the list of objects <A>object_list</A>.
    # @Returns a morphism
    # @Arguments object_list, injection_number, coproduct_object   
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, injection_number, coproduct )
        local homalg_graded_ring, rank_pre, rank_post, rank_cofactor, number_of_objects, injection_of_cofactor;
        
        # extract the underlying graded ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( coproduct );
        
        # and the number of objects
        number_of_objects := Length( object_list );

        # now collect the data needed to construct the injection matrix
        rank_pre := Sum( object_list{ [ 1 .. injection_number - 1 ] }, c -> Rank( c ) );        
        rank_post := Sum( object_list{ [ injection_number + 1 .. number_of_objects ] }, c -> Rank( c ) );        
        rank_cofactor := Rank( object_list[ injection_number ] );
        
        # now construct the mapping matrix
        injection_of_cofactor := HomalgZeroMatrix( rank_cofactor, rank_pre ,homalg_graded_ring );        
        injection_of_cofactor := UnionOfColumns( injection_of_cofactor,
                                             HomalgIdentityMatrix( rank_cofactor, homalg_graded_ring ) );        
        injection_of_cofactor := UnionOfColumns( injection_of_cofactor,
                                             HomalgZeroMatrix( rank_cofactor, rank_post, homalg_graded_ring ) );
        
        # and construct the associated morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( object_list[ injection_number ], 
                                                                                             injection_of_cofactor, coproduct );
        
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
            UnionOfRows( underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) );
          
        od;
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( coproduct, underlying_matrix_of_universal_morphism, 
                                                                                                           Range( sink[1] ) );
        
    end );



    ######################################################################
    #
    # @Section Add weak lift and colift
    #
    ######################################################################

    # @Description
    # This method requires a morphism <A>morphism1</A> $a \to c$ and a morphism <A>morphism2</A> $b \to c$. The result of 
    # Lift( morphism1, morphism2 ) is then the weak lift morphism $a \to b$.
    # @Returns a morphism
    # @Arguments morphism1, morphism2
    AddLift( category,
      function( morphism1, morphism2 )
        local right_divide;
        
        # try to find a lift
        right_divide := RightDivide( UnderlyingHomalgMatrix( morphism1 ), UnderlyingHomalgMatrix( morphism2 ) );

        # check if this failed
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        # and if not, then construct the lift-morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism1 ),
                                                                        right_divide,
                                                                        Source( morphism2 ) );
        
    end );
    
    # @Description
    # This method requires a morphism <A>morphism1</A> $a \to c$ and a morphism <A>morphism2</A> $a \to b$. The result of 
    # Colift( morphism1, morphism2 ) is then the weak colift morphism $c \to b$.
    # @Returns a morphism
    # @Arguments morphism1, morphism2
    AddColift( category,
      function( morphism1, morphism2 )
        local left_divide;

        # try to find a matrix that performs the colift
        left_divide := LeftDivide( UnderlyingHomalgMatrix( morphism1 ), UnderlyingHomalgMatrix( morphism2 ) );

        # check if this worked
        if left_divide = fail then

          return fail;

        fi;

        # if it did work, return the corresponding morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism1 ),
                                                                        left_divide,
                                                                        Range( morphism2 )
                                                                       );

    end );



    ######################################################################
    #
    # @Section Add Abelian structure
    #
    ######################################################################

    # @Description
    # This method computes the (weak) kernel embedding of a morphism <A>morphism</A>.
    # @Returns a morphism
    # @Arguments morphism
    AddKernelEmbedding( category,
      function( morphism )
        local kernel_matrix;

        # then compute the syzygies of rows, which form the 'kernel matrix'
        kernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );

        # and from this deduce the mapping
        return DeduceMapFromMatrixAndRangeLeft( kernel_matrix, Source( morphism ) );

    end );

    # @Description
    # This method computes the (weak) cokernel projection of a morphism <A>morphism</A>.
    # @Returns a morphism
    # @Arguments morphism
    AddCokernelProjection( category,
      function( morphism )
        local cokernel_matrix;
             
        # then compute the syzygies of rows, which form the 'kernel matrix'
        cokernel_matrix := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );

        # and from this deduce the mapping
        return DeduceMapFromMatrixAndSourceLeft( cokernel_matrix, Range( morphism ) );

    end );



    ################################################################################################################
    #
    # @Section Add (Weak) Fibre product 
    # For the fibre product of two objects we have a faster algorithm that uses SyzygiesOfRows( matrix1, matrix2 ).
    # In case the fibre product of more than two morphisms is to be computed, we essentially derive it nevertheless.
    #
    ################################################################################################################

    # @Description
    # This method computes the (weak) fibre product of a list of morphisms <A>morphism_list</A>
    # @Returns an object
    # @Arguments morphism_list
    AddFiberProduct( category,
      function( morphism_list )

        if Length( morphism_list ) = 0 then
          return ZeroObject( category );
        else
          return Source( ProjectionInFactorOfFiberProduct( morphism_list, 1 ) );
        fi;

    end );

    # @Description
    # This method computes the projection morphism from the (weak) fibre product 
    # of a list of morphisms <A>morphism_list</A> into its <A>projection_number</A>-th factor
    # @Returns a morphism
    # @Arguments morphism_list, projection_number
    AddProjectionInFactorOfFiberProduct( category,
      function( morphism_list, projection_number )
        local mapping_matrix, matrix_list, projection_matrix, j;

        if Length( morphism_list ) = 0 then

          Error( "Only for fibre products of non-empty morphism lists, projections onto the factors can be computed" );
          return;

        elif Length( morphism_list ) = 1 then

          return KernelEmbedding( morphism_list[ 1 ] );

        else

          # extract the mapping matrix of the morphism[ projection_number ]
          mapping_matrix := UnderlyingHomalgMatrix( morphism_list[ projection_number ] );

          # construct list of mapping matrices of all maps in morphism_list but the one that we wish to compute the
          # projection morphism of
          matrix_list := List( morphism_list, x -> UnderlyingHomalgMatrix( x ) );
          Remove( matrix_list, projection_number );

          # now iterate the syzygies computation
          projection_matrix := SyzygiesOfRows( mapping_matrix, matrix_list[ 1 ] );
          for j in [ 2 .. Length( matrix_list ) ] do

            projection_matrix := SyzygiesOfRows( projection_matrix * mapping_matrix, matrix_list[ j ] ) 
                                                                                            * projection_matrix;

          od;

          # and from this deduce the projection map
          return DeduceMapFromMatrixAndRangeLeft( projection_matrix, Source( morphism_list[ projection_number ] ) );

        fi;

    end );

    # @Description
    # This method computes the projection morphism from the (weak) fibre product
    # of a list of morphisms <A>morphism_list</A> into its <A>projection_number</A>-th factor. This methods assumes that
    # the fibre product object is given as input.
    # @Returns a morphism
    # @Arguments morphism_list, projection_number
    AddProjectionInFactorOfFiberProductWithGivenFiberProduct( category,
      function( morphism_list, projection_number, fibre_product_object )
        local mapping_matrix, matrix_list, projection_matrix, j;

        if Length( morphism_list ) = 0 then

          Error( "Only for fibre products of non-empty morphism lists, projections onto the factors can be computed" );
          return;

        elif Length( morphism_list ) = 1 then

          return KernelEmbedding( morphism_list[ 1 ] );

        else

          # extract the mapping matrix of the morphism[ projection_number ]
          mapping_matrix := UnderlyingHomalgMatrix( morphism_list[ projection_number ] );

          # construct list of mapping matrices of all maps in morphism_list but the one that we wish to compute the
          # projection morphism of
          matrix_list := List( morphism_list, x -> UnderlyingHomalgMatrix( x ) );
          Remove( matrix_list, projection_number );

          # now iterate the syzygies computation
          projection_matrix := SyzygiesOfRows( mapping_matrix, matrix_list[ 1 ] );
          for j in [ 2 .. Length( matrix_list ) ] do

            projection_matrix := SyzygiesOfRows( projection_matrix * mapping_matrix, matrix_list[ j ] ) * projection_matrix;

          od;

          # and from this construct the projection map
          return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( fibre_product_object, 
                                                                          projection_matrix, 
                                                                          Source( morphism_list[ projection_number ] ) 
                                                                         );

        fi;

    end );



    ################################################################################################################
    #
    # @Section Add (Weak) Pushout
    # For the pushout product of two objects we have a faster algorithm that uses SyzygiesOfColumns( matrix1, matrix2 ).
    # In case the pushout of more than two morphisms is to be computed, we essentially derive it nevertheless.
    #
    ################################################################################################################

    # @Description
    # This method computes the (weak) pushout of a list of morphisms <A>morphism_list</A>
    # @Returns an object
    # @Arguments morphism_list
    AddPushout( category,
      function( morphism_list )

        if Length( morphism_list ) = 0 then
          return ZeroObject( category );
        else
          return Range( InjectionOfCofactorOfPushout( morphism_list, 1 ) );
        fi;

    end );

    # @Description
    # This method computes the injection of the <A>injection_number</A>-th cofactor of a (weak) pushout 
    # of a list of morphisms <A>morphism_list</A>
    # @Returns a morphism
    # @Arguments morphism_list, injection_number
    AddInjectionOfCofactorOfPushout( category,
      function( morphism_list, injection_number )
        local mapping_matrix, embedding_matrix, matrix_list, j;

        if Length( morphism_list ) = 0 then

          Error( "Only for pushouts of non-empty morphism lists, injections of the factors can be computed" );
          return;

        elif Length( morphism_list ) = 1 then

          return KernelEmbedding( morphism_list[ 1 ] );

        else

          # extract the mapping matrix of the morphism[ projection_number ]
          mapping_matrix := UnderlyingHomalgMatrix( morphism_list[ injection_number ] );

          # construct list of mapping matrices of all maps in morphism_list but the one that we wish to compute the
          # projection morphism of
          matrix_list := List( morphism_list, x -> UnderlyingHomalgMatrix( x ) );
          Remove( matrix_list, injection_number );

          # now iterate the syzygies computation
          embedding_matrix := SyzygiesOfColumns( mapping_matrix, matrix_list[ 1 ] );
          for j in [ 2 .. Length( matrix_list ) ] do

            embedding_matrix := embedding_matrix * SyzygiesOfColumns( mapping_matrix * embedding_matrix, matrix_list[ j ] );

          od;

          # from this decude the injection
          return DeduceMapFromMatrixAndSourceLeft( embedding_matrix, Range( morphism_list[ injection_number ] ) );

        fi;

    end );

    # @Description
    # This method computes the injection of the <A>injection_number</A>-th cofactor of a (weak) pushout 
    # of a list of morphisms <A>morphism_list</A>. This method assumes the pushout object as given input.
    # @Returns a morphism
    # @Arguments morphism_list, injection_number
    AddInjectionOfCofactorOfPushoutWithGivenPushout( category,
      function( morphism_list, injection_number, pushout_object )
        local mapping_matrix, embedding_matrix, matrix_list, j;

        if Length( morphism_list ) = 0 then

          Error( "Only for pushouts of non-empty morphism lists, injections of the factors can be computed" );
          return;

        elif Length( morphism_list ) = 1 then

          return KernelEmbedding( morphism_list[ 1 ] );

        else

          # extract the mapping matrix of the morphism[ projection_number ]
          mapping_matrix := UnderlyingHomalgMatrix( morphism_list[ injection_number ] );

          # construct list of mapping matrices of all maps in morphism_list but the one that we wish to compute the
          # projection morphism of
          matrix_list := List( morphism_list, x -> UnderlyingHomalgMatrix( x ) );
          Remove( matrix_list, injection_number );

          # now iterate the syzygies computation
          embedding_matrix := SyzygiesOfColumns( mapping_matrix, matrix_list[ 1 ] );
          for j in [ 2 .. Length( matrix_list ) ] do

            embedding_matrix := embedding_matrix * SyzygiesOfColumns( mapping_matrix * embedding_matrix, matrix_list[ j ] );

          od;

          # from this construct the injection
          return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism_list[ injection_number ] ),
                                                                          embedding_matrix,
                                                                          pushout_object
                                                                         );

        fi;

    end );



    ######################################################################
    #
    # @Section Add Basic Monoidal Structure
    #
    ######################################################################
    
    # @Description
    # This method computes the tensor product of the two projective modules <A>object1</A> and <A>object2</A>
    # @Returns an object
    # @Arguments object1, object2
    AddTensorProductOnObjects( category,
      function( object1, object2 )
        local degree_list1, degree_list2, degree_list1_extended, degree_list_tensor_object, i, j;
        
        # first extract the degree_list of object1 and object2
        degree_list1 := DegreeList( object1 );
        degree_list2 := DegreeList( object2 );
        
        # now expand degree_list1 (this is to make sure that the tensor product on objects is defined such that the 
        # tensor product on morphisms is transmitted by the KroneckerProduct of the mapping matrices)
        degree_list1_extended := [];
        for i in [ 1 .. Length( degree_list1 ) ] do
        
          for j in [ 1 .. degree_list1[ i ][ 2 ] ] do
          
            Add( degree_list1_extended, [ degree_list1[ i ][ 1 ], 1 ] );
          
          od;
        
        od;
        
        # now compute the degree_list of the tensor product of object1 and object2
        degree_list_tensor_object := [];
        for i in [ 1 .. Length( degree_list1_extended ) ] do
        
          for j in [ 1 .. Length( degree_list2 ) ] do
          
            Add( degree_list_tensor_object, [ degree_list1_extended[ i ][ 1 ] + degree_list2[ j ][ 1 ], 
                                              degree_list1_extended[ i ][ 2 ] * degree_list2[ j ][ 2 ] ] );
          
          od;
        
        od;
        
        # now construct a new object in this category
        return CAPCategoryOfProjectiveGradedLeftModulesObject( degree_list_tensor_object, UnderlyingHomalgGradedRing( object1 ) );
       
    end );

    # @Description
    # This method computes the tensor product of the two maps of projective modules <A>morphism1</A> and <A>morphism2</A>.
    # @Returns a morphism
    # @Arguments source = Source( morphism1 ) \otimes Source( morphism2 ), morphism1, morphism2, 
    #            range = Range( morphism1 ) \otimes Range( morphism2 )
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      function( source, morphism1, morphism2, range )
                
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source, 
                                              KroneckerMat( UnderlyingHomalgMatrix( morphism1 ), UnderlyingHomalgMatrix( morphism2 ) ),
                                              range );
                                              
    end );

    # @Description
    # This method computes the tensor unit in the category of projective graded left modules. This is the module
    # of degree 0 and rank 1.
    # @Returns an object
    # @Arguments 
    AddTensorUnit( category,
      function( )
        local homalg_ring;
        
        homalg_ring := category!.homalg_graded_ring_for_category_of_projective_graded_left_modules;
        return CAPCategoryOfProjectiveGradedLeftModulesObject( [ [ TheZeroElement( DegreeGroup( homalg_ring ) ) , 1 ] ], 
                                                                                                               homalg_ring );

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
        local homalg_ring, rank_1, rank_2, rank, permutation_matrix;
        
        # gather necessary information
        homalg_ring := UnderlyingHomalgGradedRing( object_1 );
        rank_1 := Rank( object_1 );
        rank_2 := Rank( object_2 );
        rank := Rank( object_1_tensored_object_2 );
        
        # compute the mapping matrix
        permutation_matrix := PermutationMat( 
                         PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) ),
                                rank 
                              );
        permutation_matrix := HomalgMatrix( permutation_matrix, rank, rank, homalg_ring );
        
        # and return the corresponding morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( object_1_tensored_object_2,
                                                                        permutation_matrix,
                                                                        object_2_tensored_object_1 );        
    
    end );

    
    
    ######################################################################
    #
    # @Section Add Rigid, Symmetric Closed Monoidal Structure
    #
    ######################################################################
    
    # @Description
    # This method computes the dual of a projective, graded left-module <A>object</A> (c.f. dual of vector spaces).
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
        return CAPCategoryOfProjectiveGradedLeftModulesObject( degree_list_dual_object, UnderlyingHomalgGradedRing( object ) );
        
    end );

    # @Description
    # This method computes the dual of a morphism of projective, graded left-modules (c.f. dual of vector space morphism).
    # @Returns a morphism
    # @Arguments source, morphism, range
    AddDualOnMorphismsWithGivenDuals( category,
      function( source, morphism, range )
    
      # simply transpose the mapping matrix and return the result
      return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source, Involution( UnderlyingHomalgMatrix( morphism ) ), range );
    end );

    # @Description
    # This method computes the evaluation morphism for a projective graded left-module <A>object</A>. This is it computes a
    # morphism <A>Dual(object)</A> \otimes <A>object</A> to the tensor unit.
    # @Returns a morphism
    # @Arguments tensor_object = Dual( object) \otimes object, object, unit
    AddEvaluationForDualWithGivenTensorProduct( category,
      function( tensor_object, object, unit )
        local rank, column, zero_column, i, homalg_ring;
        
        # collect and initialise the necessary information
        rank := Rank( object );
        homalg_ring := UnderlyingHomalgGradedRing( object );
        column := [ ];        
        zero_column := List( [ 1 .. rank ], i -> 0 );
        
        # produce the mapping column (only necessary if rank > 0, otherwise column := [] will do)
        if rank > 0 then
        
          for i in [ 1 .. rank - 1 ] do
          
            Add( column, 1 );
            Append( column, zero_column );
          
          od;        
          Add( column, 1 );
          column := TransposedMat( [ column ] );
          
        fi;
        
        # return the evaluation morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
                                                        tensor_object,
                                                        HomalgMatrix( column, homalg_ring ),
                                                        unit );
        
    end );

    # @Description
    # This method computes the coevaluation morphism for a projective graded left-module <A>object</A>. This is it computes a
    # morphism tensor unit to <A>Dual(object)</A> \otimes <A>object</A>.
    # @Returns a morphism
    # @Arguments unit, object, tensor_object = Object \otimes Dual( object )
    AddCoevaluationForDualWithGivenTensorProduct( category,
      function( unit, object, tensor_object )
        local rank, column, zero_column, i, homalg_ring;

        # collect and initialise the necessary information
        rank := Rank( object );
        homalg_ring := UnderlyingHomalgGradedRing( object );
        column := [ ];        
        zero_column := List( [ 1 .. rank ], i -> 0 );
        
        # produce the mapping column (only necessary if rank > 0, otherwise column := [] will do)
        if rank > 0 then
        
          for i in [ 1 .. rank - 1 ] do
          
            Add( column, 1 );
            Append( column, zero_column );
          
          od;        
          Add( column, 1 );
          column := [ column ];
          
        fi;
        
        # return the evaluation morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism(
                                                        unit,
                                                        HomalgMatrix( column, homalg_ring ),
                                                        tensor_object );
        
    end );

    # @Description
    # Given an <A>object</A>, this method computes the morphism to the bidual, i.e. the morphism
    # <A>object</A> to <A>Dual(Dual(object))</A>. In the category at hand this is just the identity morphism.
    # @Returns a morphism
    # @Arguments object, bidual_object = Dual(Dual(object))
    AddMorphismToBidualWithGivenBidual( category,
      function( object, bidual_object )
      
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism(
                                                object,
                                                HomalgIdentityMatrix( Rank( object ), UnderlyingHomalgGradedRing( object ) ),
                                                bidual_object );

    end );    
    
end );