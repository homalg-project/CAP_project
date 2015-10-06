#############################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

####################################
##
## Constructors
##
####################################

InstallMethod( CAPCategoryOfProjectiveGradedLeftModules,
               [ IsHomalgGradedRing ],
               
  function( homalg_graded_ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "CAP category of projective graded left modules over "
                                                                                          , RingName( homalg_graded_ring ) ) );
    
    category!.homalg_graded_ring_for_category_of_projective_graded_left_modules := homalg_graded_ring;
    
    SetIsAdditiveCategory( category, true );
     
    INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_LEFT_MODULES( category ); 
    
    ## TODO: Logic for CAPCategoryOfProjectiveGradedModules
    
    #AddPredicateImplicationFileToCategory( category,
    #  Filename(
    #    DirectoriesPackageLibrary( "LinearAlgebraForCAP", "LogicForMatrixCategory" ),
    #    "PredicateImplicationsForMatrixCategory.tex" )
    #);
     
    Finalize( category );
    
    return category;
    
end );

InstallMethod( CAPCategoryOfProjectiveGradedRightModules,
               [ IsHomalgGradedRing ],
               
  function( homalg_graded_ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "CAP category of projective graded right modules over "
                                                                                          , RingName( homalg_graded_ring ) ) );
    
    category!.homalg_graded_ring_for_category_of_projective_graded_right_modules := homalg_graded_ring;
    
    SetIsAdditiveCategory( category, true );
     
    INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_RIGHT_MODULES( category ); 
    
    ## TODO: Logic for CAPCategoryOfProjectiveGradedModules
    
    #AddPredicateImplicationFileToCategory( category,
    #  Filename(
    #    DirectoriesPackageLibrary( "LinearAlgebraForCAP", "LogicForMatrixCategory" ),
    #    "PredicateImplicationsForMatrixCategory.tex" )
    #);
     
    Finalize( category );
    
    return category;
    
end );

####################################################################
##
## Basic operations for category of projective, graded, left modules
##
####################################################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_LEFT_MODULES,

  function( category )
    
    ## Equality Basic Operations for Objects and Morphisms
    ## Equality Basic Operations for Objects and Morphisms

    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
      
        return DegreeList( object_1 ) = DegreeList( object_2 );
      
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        # note that a matrix over a graded ring does not uniquely fix the grading of source and range
        # to check equality of morphisms we therefore compare also the sources and ranges
        # note that it is necessary to compare both the sources and ranges because
        # S ----( 0 ) ----> S( d ) is a valid mapping for every d in DegreeGroup!
        return ( UnderlyingHomalgMatrix( morphism_1 ) = UnderlyingHomalgMatrix( morphism_2 ) ) 
              and IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) )
              and IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
        
    end );
    
    ## Basic Operations for a Category
    ## Basic Operations for a Category
    
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( object );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( object, 
                                                          HomalgIdentityMatrix( Rank( object ), homalg_graded_ring ), object );
        
    end );
    
    ##
    AddPreCompose( category,

      function( morphism_1, morphism_2 )
        local composition;

        composition := UnderlyingHomalgMatrix( morphism_1 ) * UnderlyingHomalgMatrix( morphism_2 );

        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );

    end );
    
    # Add hard checks to verify that an object/morphism belongs to this category
    # Add hard checks to verify that an object/morphism belongs to this category    
        
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
    
    AddIsWellDefinedForMorphisms( category,

          function( morphism )
        local source, range, morphism_matrix, morphism_matrix_entries, func, degrees_of_entries_matrix, degree_group, 
             source_degrees, range_degrees, buffer_col, dummy_range_degrees, i, j;
             
        
        # extract source and range
        source := Source( morphism );        
        range := Range( morphism );
        
        # then verify that both range and source are well-defined objects in this category
        if ( not IsWellDefinedForObjects( source ) ) or ( not IsWellDefinedForObjects( range ) ) then
        
          # source or range is corrupted, so return false
          return false;
        
        fi;

        # next check that the underlying homalg_graded_rings are identical
        if not ( IsIdenticalObj( UnderlyingHomalgGradedRing( source ), UnderlyingHomalgGradedRing( morphism ) ) and
                        IsIdenticalObj( UnderlyingHomalgGradedRing( morphism ), UnderlyingHomalgGradedRing( range ) ) ) then
        
          return false;
        
        fi;
        
        # and that source and range are defined in the same category
        if not IsIdenticalObj( CapCategory( source ), CapCategory( range ) ) then
        
          return false;
        
        fi;
        
        # check if the mapping is non-trivial, for otherwise we are done already
        if ( Rank( source ) = 0 or Rank( range ) = 0 ) then
        
          return true;
        
        else
        
          # extract the mapping matrix        
          morphism_matrix := UnderlyingHomalgMatrix( morphism );
          morphism_matrix_entries := EntriesOfHomalgMatrixAsListList( morphism_matrix );

          # then check if the dimensions of the matrix fit with the ranks of the source and range modules
          if not ( Rank( source ) = NrRows( morphism_matrix )
                   and NrColumns( morphism_matrix ) = Rank( range ) ) then
          
            return false;
          
          fi;
          
          # subsequently compute the degrees of all entries in the morphism_matrix
          # I use the DegreeOfEntriesFunction of the underlying graded ring
          # in particular I hope that this function raises and error if one of the entries is not homogeneous
          func := DegreesOfEntriesFunction( UnderlyingHomalgGradedRing( source ) );
          degrees_of_entries_matrix := func( morphism_matrix );
        
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
            
    ## Basic Operations for an Additive Category
    ## Basic Operations for an Additive Category

    ##
    AddIsZeroForObjects( category,
      function( object )
      
        return Rank( object ) = 0;
      
      end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( morphism )
        
        return IsZero( UnderlyingHomalgMatrix( morphism ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism_1 ),
                                                    UnderlyingHomalgMatrix( morphism_1 ) + UnderlyingHomalgMatrix( morphism_2 ),
                                                    Range( morphism_2 ) 
                                                    );
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism ),
                                     MinusOne( UnderlyingHomalgGradedRing( morphism ) ) * UnderlyingHomalgMatrix( morphism ),
                                     Range( morphism )
                                     );
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( source );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source,
                                           HomalgZeroMatrix( Rank( source ), Rank( range ), homalg_graded_ring ),
                                           range
                                          );
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return CAPCategoryOfProjectiveGradedLeftModulesObject( 
                                          [ ], category!.homalg_graded_ring_for_category_of_projective_graded_left_modules );
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( sink, 
                                                                       HomalgZeroMatrix( Rank( sink ), 0, homalg_graded_ring ), 
                                                                       zero_object
                                                                      );
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( zero_object, 
                                                                      HomalgZeroMatrix( 0, Rank( source ), homalg_graded_ring ), 
                                                                      source
                                                                     );
        return morphism;
        
    end );

    ##
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
    
    ##
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

    ##
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

    ##
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

    ##
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

    ## Weak kernels (added as kernels)
    ## Weak kernels (added as kernels)

    ##
    AddKernelObject( category,
      function( morphism )
        local homalg_graded_ring, kernel_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_kernel_matrix_rows, degrees_of_kernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        kernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );

        # check if the cokernel matrix is zero
        if IsZero( kernel_matrix ) then
        
          # if so, the kernel object is the zero module
          return CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the kernel matrix is not zero, thus let us compute the kernel object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( kernel_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Source( morphism ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Source( morphism ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Source( morphism ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_kernel_matrix_rows := NonTrivialDegreePerRow( kernel_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_kernel_object := List( [ 1 .. Length( degrees_of_kernel_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_kernel_matrix_rows ) ] do
        
            degrees_of_kernel_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_kernel_matrix_rows[ j ], 1 ];
          
          od;
        
          # and finally return the kernel object
          return CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_kernel_object, homalg_graded_ring );

        fi;
        
    end );

    ##
    AddKernelEmbedding( category,
      function( morphism )
        local homalg_graded_ring, kernel_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_kernel_matrix_rows, degrees_of_kernel_object, kernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        kernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );

        # check if the cokernel matrix is zero
        if IsZero( kernel_matrix ) then
        
          # if so, the kernel object is the zero module
          kernel_object := CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the kernel matrix is not zero, thus let us compute the kernel object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( kernel_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Source( morphism ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Source( morphism ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Source( morphism ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_kernel_matrix_rows := NonTrivialDegreePerRow( kernel_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_kernel_object := List( [ 1 .. Length( degrees_of_kernel_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_kernel_matrix_rows ) ] do
        
            degrees_of_kernel_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_kernel_matrix_rows[ j ], 1 ];
          
          od;
        
          # and finally return the kernel object
          kernel_object := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_kernel_object, homalg_graded_ring );

        fi;
                               
        # and return the kernel embedding
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( kernel_object, kernel_matrix, Source( morphism ) );
    end );

    ##
    AddKernelEmbeddingWithGivenKernelObject( category,
      function( morphism, kernel )
        local kernel_matrix;
        
        kernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( kernel, kernel_matrix, Source( morphism ) );
        
    end );
    
    ##
    AddLiftAlongMonomorphism( category,
      function( monomorphism, test_morphism )
        local right_divide;
        
        # try to find a lift
        right_divide := RightDivide( UnderlyingHomalgMatrix( test_morphism ), UnderlyingHomalgMatrix( monomorphism ) );

        # check if this failed
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        # and if not, then construct the lift-morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( test_morphism ),
                                                                        right_divide,
                                                                        Source( monomorphism ) );
        
    end );
    
    ## Weak cokernels (added as cokernels)
    ## Weak cokernels (added as cokernels)

    ##
    AddCokernelObject( category,
      function( morphism )
        local homalg_graded_ring, cokernel_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_cokernel_matrix_columns, degrees_of_cokernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        cokernel_matrix := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );

        # check if the cokernel matrix is zero
        if IsZero( cokernel_matrix ) then
        
          # if so, the cokernel object is the zero module
          return CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the cokernel matrix is not zero, thus let us compute the cokernel object...
          
          # figure out the (first) non-zero entries per row of the cokernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( cokernel_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Range( morphism ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Range( morphism ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Range( morphism ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_cokernel_matrix_columns := NonTrivialDegreePerColumn( cokernel_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_cokernel_object := List( [ 1 .. Length( degrees_of_cokernel_matrix_columns ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_cokernel_matrix_columns ) ] do
        
            degrees_of_cokernel_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 - degrees_of_cokernel_matrix_columns[ j ], 1 ];
          
          od;
        
          # and finally return the cokernel object
          return CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_cokernel_object, homalg_graded_ring );

        fi;
        
    end );
          
    ##
    AddCokernelProjection( category,
      function( morphism )
        local homalg_graded_ring, cokernel_matrix, cokernel_object, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_cokernel_matrix_columns, degrees_of_cokernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        cokernel_matrix := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );

        # check if the cokernel matrix is zero
        if IsZero( cokernel_matrix ) then
        
          # if so, the cokernel object is the zero module
          cokernel_object := CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
          
        else
        
          # the cokernel matrix is not zero, thus let us compute the cokernel object...
          
          # figure out the (first) non-zero entries per row of the cokernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( cokernel_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Range( morphism ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Range( morphism ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Range( morphism ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_cokernel_matrix_columns := NonTrivialDegreePerColumn( cokernel_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_cokernel_object := List( [ 1 .. Length( degrees_of_cokernel_matrix_columns ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_cokernel_matrix_columns ) ] do
        
            degrees_of_cokernel_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 - degrees_of_cokernel_matrix_columns[ j ], 1 ];
          
          od;
        
          # and finally return the cokernel object
          cokernel_object := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_cokernel_object, homalg_graded_ring );

        fi;

        # and return the mapping morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism ), cokernel_matrix, cokernel_object );        
        
    end );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( category,
      function( morphism, cokernel )
        local cokernel_proj;
        
        cokernel_proj := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism ), cokernel_proj, cokernel );
        
    end );

    ##
    AddColiftAlongEpimorphism( category,
      function( epimorphism, test_morphism )
        local left_divide;
        
        # try to find a matrix that performs the colift
        left_divide := LeftDivide( UnderlyingHomalgMatrix( epimorphism ), UnderlyingHomalgMatrix( test_morphism ) );

        # check if this worked
        if left_divide = fail then
          
          return fail;
          
        fi;
        
        # if it did work, return the corresponding morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( epimorphism ),
                                                                        left_divide,
                                                                        Range( test_morphism ) 
                                                                       );
        
    end );

    ## Lift
    ## Lift
    # the lift of morphism2 along morphism1, i.e. morphism1: K -> M, morphism2: L -> M, then lift( 1,2 ): L -> K    
    AddLift( category,
      function( morphism1, morphism2 )
        local right_divide;
        
        # try to find a lift
        right_divide := RightDivide( UnderlyingHomalgMatrix( morphism2 ), UnderlyingHomalgMatrix( morphism1 ) );

        # check if this failed
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        # and if not, then construct the lift-morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism2 ),
                                                                        right_divide,
                                                                        Source( morphism1 ) );
        
    end );
    
    ## Colift
    ## Colift
    # the colift of morphism2 along morphism1, i.e. morphism1: N -> C, morphism2: N -> L, then colift( 1,2 ): C -> L
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

    # weak fibreproduct
    # weak fibreproduct
    AddFiberProduct( category,             
      function( morphism_list )
        local homalg_graded_ring, matrix1, matrix2, projection1_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_projection1_matrix_rows, degrees_of_fibreproduct_object;
        
        # we only define the fiber product for two morphisms, otherwise raise an error
        if Length( morphism_list ) <> 2 then
        
          Error( "Fiber product only accepts a list with precisely two morphisms as input. \n" );
          return fail;
        
        fi;

        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism_list[ 1 ] );
        
        # and the mapping matrices of these two morphisms
        matrix1 := UnderlyingHomalgMatrix( morphism_list[ 1 ] );
        matrix2 := UnderlyingHomalgMatrix( morphism_list[ 2 ] );
        
        # now compute the relative version of syzygies of rows
        projection1_matrix := SyzygiesOfRows( matrix1, matrix2 );
        
        # this means that we have the following diagram:
        #                     
        #   Source( 2 ) --- morphism2 ----- > Range( 2 ) = Range( 1 )
        #                                                ^
        #                                                |
        #                                                |
        #                                            morphism1
        #                                                |
        #                                                |
        #                                            Source( 1 )
        #                                                |
        #                                                |
        #                                        projection1_matrix
        #                                                |
        #                                                |
        #                                         fibreproduct( 1, 2 )
        
        # now interpret projection1 as the mapping matrix of a map of projective graded left modules with range the 
        # source of morphism1
        # -> so essentially repeat the kernel algorithm
        
        # check if the projection matrix is zero
        if IsZero( projection1_matrix ) then
        
          # if so, the fibreproduct object is the zero module
          return CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # projection1_matrix is not zero, thus let us compute the non-trivial fibreproduct_object...
          
          # figure out the (first) non-zero entries per row of projection1_matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( projection1_matrix );
          
          # expand the degree_list of the source of morphism1
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Source( morphism_list[ 1 ] ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Source( morphism_list[ 1 ] ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Source( morphism_list[ 1 ] ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_projection1_matrix_rows := NonTrivialDegreePerRow( projection1_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_fibreproduct_object := List( [ 1 .. Length( degrees_of_projection1_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_projection1_matrix_rows ) ] do
        
            degrees_of_fibreproduct_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                              + degrees_of_projection1_matrix_rows[ j ], 1 ];
          
          od;
          
          # and finally return the fiberproduct object
          return CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_fibreproduct_object, homalg_graded_ring );

        fi;        
    
    end );

    AddProjectionInFactorOfFiberProductWithGivenFiberProduct( category,
      function( morphism_list, projection_number, fibre_product_object )

        local homalg_graded_ring, matrix1, matrix2, projection1_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_projection1_matrix_rows, degrees_of_fibreproduct_object, fibreproduct_object_dummy;
        
        # we only define the fiber product for two morphisms, otherwise raise an error
        if Length( morphism_list ) <> 2 then
        
          Error( "Fiber product only accepts a list with precisely two morphisms as input. \n" );
          return fail;
        
        fi;

        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism_list[ 1 ] );
        
        # and the mapping matrices of these two morphisms
        matrix1 := UnderlyingHomalgMatrix( morphism_list[ 1 ] );
        matrix2 := UnderlyingHomalgMatrix( morphism_list[ 2 ] );
        
        # now compute the relative version of syzygies of rows
        projection1_matrix := SyzygiesOfRows( matrix1, matrix2 );
        
        # this means that we have the following diagram:
        #                     
        #   Source( 2 ) --- morphism2 ----- > Range( 2 ) = Range( 1 )
        #                                                ^
        #                                                |
        #                                                |
        #                                            morphism1
        #                                                |
        #                                                |
        #                                            Source( 1 )
        #                                                |
        #                                                |
        #                                        projection1_matrix
        #                                                |
        #                                                |
        #                                         fibreproduct( 1, 2 )
        
        # now interpret projection1 as the mapping matrix of a map of projective graded left modules with range the 
        # source of morphism1
        # -> so essentially repeat the kernel algorithm
        
        # check if the projection matrix is zero
        if IsZero( projection1_matrix ) then
        
          # if so, the fibreproduct object is the zero module
          fibreproduct_object_dummy := CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # projection1_matrix is not zero, thus let us compute the non-trivial fibreproduct_object...
          
          # figure out the (first) non-zero entries per row of projection1_matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( projection1_matrix );
          
          # expand the degree_list of the source of morphism1
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Source( morphism_list[ 1 ] ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Source( morphism_list[ 1 ] ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Source( morphism_list[ 1 ] ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_projection1_matrix_rows := NonTrivialDegreePerRow( projection1_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_fibreproduct_object := List( [ 1 .. Length( degrees_of_projection1_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_projection1_matrix_rows ) ] do
        
            degrees_of_fibreproduct_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                              + degrees_of_projection1_matrix_rows[ j ], 1 ];
          
          od;
          
          # and finally return the fiberproduct object
          fibreproduct_object_dummy := CAPCategoryOfProjectiveGradedLeftModulesObject( 
                                                                        degrees_of_fibreproduct_object, homalg_graded_ring );

        fi;
        
        # now make a new check on the validity of the input
        if not IsEqualForObjects( fibreproduct_object_dummy, fibre_product_object ) then
        
          Error( "The entered fibreproduct object is not equal to the interally computed fibreproduct object. \n" );
          return fail;
        
        fi;
        
        # next check if the projection number if valid
        if projection_number < 0 or projection_number > 2 then
        
          Error( "The projection number is only allowed to be either 1 or 2!. \n" );
        
        fi;
        
        # else the input is ok and we can product the output
        if projection_number = 1 then
        
          return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( fibre_product_object, 
                                                                          projection1_matrix,
                                                                          Source( morphism_list[ 1 ] )
                                                                          );
        
        else

          # have to compute the lift
          return Lift( morphism_list[ 2 ], 
                       PreCompose ( CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( fibre_product_object, 
                                                                                             projection1_matrix,
                                                                                             Source( morphism_list[ 1 ] )
                                                                                            ) 
                                    , morphism_list[ 1 ] )
                      );
        
        fi;
    
    end );

    # weak pushout
    # weak pushout    
    AddPushout( category,            
      function( morphism_list )
        local homalg_graded_ring, matrix1, matrix2, embedding1_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_embedding1_matrix_columns, degrees_of_pushout_object;
        
        # we only define the pushout for two morphisms, otherwise raise an error
        if Length( morphism_list ) <> 2 then
        
          Error( "Pushout only accepts a list with precisely two morphisms as input. \n" );
          return fail;
        
        fi;

        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism_list[ 1 ] );
        
        # and the mapping matrices of these two morphisms
        matrix1 := UnderlyingHomalgMatrix( morphism_list[ 1 ] );
        matrix2 := UnderlyingHomalgMatrix( morphism_list[ 2 ] );
        
        # now compute the relative version of syzygies of rows
        embedding1_matrix := SyzygiesOfColumns( matrix1, matrix2 );
        
        # this means that we have the following diagram:
        #                     
        #   Range( 2 ) <--- morphism2 -----  Source( 2 ) = Source( 1 )
        #                                                |
        #                                                |
        #                                                |
        #                                            morphism1
        #                                                |
        #                                                v
        #                                            Range( 1 )
        #                                                |
        #                                                |
        #                                        embedding1_matrix
        #                                                |
        #                                                v
        #                                           pushout( 1, 2 )
        
        # now interpret embedding1 as the mapping matrix of a map of projective graded left modules with source the 
        # range of morphism1
        # -> so essentially repeat the cokernel algorithm

        # check if the cokernel matrix is zero
        if IsZero( embedding1_matrix ) then
        
          # if so, the pushout_object is the zero module
          return CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
          
        else
        
          # the cokernel matrix is not zero, thus let us compute the cokernel object...
          
          # figure out the (first) non-zero entries per row of the cokernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( embedding1_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Range( morphism_list[ 1 ] ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Range( morphism_list[ 1 ] ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Range( morphism_list[ 1 ] ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_embedding1_matrix_columns := NonTrivialDegreePerColumn( embedding1_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_pushout_object := List( [ 1 .. Length( degrees_of_embedding1_matrix_columns ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_embedding1_matrix_columns ) ] do
        
            degrees_of_pushout_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                            - degrees_of_embedding1_matrix_columns[ j ], 1 ];
          
          od;
          
          # and finally return the cokernel object
          return CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_pushout_object, homalg_graded_ring );

        fi;

    end );

    AddInjectionOfCofactorOfPushoutWithGivenPushout( category,
      function( morphism_list, injection_number, pushout_object )
        local homalg_graded_ring, matrix1, matrix2, embedding1_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_embedding1_matrix_columns, degrees_of_pushout_object, pushout_object_dummy;
        
        # we only define the pushout for two morphisms, otherwise raise an error
        if Length( morphism_list ) <> 2 then
        
          Error( "Pushout only accepts a list with precisely two morphisms as input. \n" );
          return fail;
        
        fi;

        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism_list[ 1 ] );
        
        # and the mapping matrices of these two morphisms
        matrix1 := UnderlyingHomalgMatrix( morphism_list[ 1 ] );
        matrix2 := UnderlyingHomalgMatrix( morphism_list[ 2 ] );
        
        # now compute the relative version of syzygies of rows
        embedding1_matrix := SyzygiesOfColumns( matrix1, matrix2 );
        
        # this means that we have the following diagram:
        #                     
        #   Range( 2 ) <--- morphism2 -----  Source( 2 ) = Source( 1 )
        #                                                |
        #                                                |
        #                                                |
        #                                            morphism1
        #                                                |
        #                                                v
        #                                            Range( 1 )
        #                                                |
        #                                                |
        #                                        embedding1_matrix
        #                                                |
        #                                                v
        #                                           pushout( 1, 2 )
        
        # now interpret embedding1 as the mapping matrix of a map of projective graded left modules with source the 
        # range of morphism1
        # -> so essentially repeat the cokernel algorithm

        # check if the cokernel matrix is zero
        if IsZero( embedding1_matrix ) then
        
          # if so, the pushout_object is the zero module
          pushout_object_dummy := CAPCategoryOfProjectiveGradedLeftModulesObject( [ ], homalg_graded_ring );
          
        else
        
          # the cokernel matrix is not zero, thus let us compute the cokernel object...
          
          # figure out the (first) non-zero entries per row of the cokernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( embedding1_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Range( morphism_list[ 1 ] ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Range( morphism_list[ 1 ] ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Range( morphism_list[ 1 ] ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_embedding1_matrix_columns := NonTrivialDegreePerColumn( embedding1_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_pushout_object := List( [ 1 .. Length( degrees_of_embedding1_matrix_columns ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_embedding1_matrix_columns ) ] do
        
            degrees_of_pushout_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                            - degrees_of_embedding1_matrix_columns[ j ], 1 ];
          
          od;
          
          # and finally return the cokernel object
          pushout_object_dummy := CAPCategoryOfProjectiveGradedLeftModulesObject( degrees_of_pushout_object, homalg_graded_ring );

        fi;

        
        # now make a new check on the validity of the input
        if not IsEqualForObjects( pushout_object_dummy, pushout_object ) then
        
          Error( "The entered pushout object is not equal to the interally computed pushout object. \n" );
          return fail;
        
        fi;
        
        # next check if the projection number if valid
        if injection_number < 0 or injection_number > 2 then
        
          Error( "The injection number is only allowed to be either 1 or 2!. \n" );
        
        fi;
        
        # else the input is ok and we can product the output
        if injection_number = 1 then
        
          return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism_list[ 1 ] ),
                                                                          embedding1_matrix,
                                                                          pushout_object
                                                                          );
        
        else

          # have to compute the colift
          return Colift( morphism_list[ 2 ], 
                       PreCompose( morphism_list[ 1 ],                       
                                   CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism_list[ 1 ] ),
                                                                                            embedding1_matrix,
                                                                                            pushout_object
                                                                                           )
                                  )
                      );
        
        fi;        
        
    end );
    
    
# all methods for projective graded left modules implemented...    
end );




####################################################################
##
## Basic operations for category of projective, graded, right modules
##
####################################################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_RIGHT_MODULES,

  function( category )
    
    ## Equality Basic Operations for Objects and Morphisms
    ## Equality Basic Operations for Objects and Morphisms

    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
      
        return DegreeList( object_1 ) = DegreeList( object_2 );
      
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        # note that a matrix over a graded ring does not uniquely fix the grading of source and range
        # to check equality of morphisms we therefore compare also the sources and ranges
        # note that it is necessary to compare both the sources and ranges because
        # S ----( 0 ) ----> S( d ) is a valid mapping for every d in DegreeGroup!
        return ( UnderlyingHomalgMatrix( morphism_1 ) = UnderlyingHomalgMatrix( morphism_2 ) ) 
              and IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) )
              and IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );

    end );
    
    ## Basic Operations for a Category
    ## Basic Operations for a Category
    
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( object );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( object, 
                                                          HomalgIdentityMatrix( Rank( object ), homalg_graded_ring ), object );
        
    end );
    
    ##
    AddPreCompose( category,

      function( morphism_1, morphism_2 )
        local composition;

        composition := UnderlyingHomalgMatrix( morphism_2 ) * UnderlyingHomalgMatrix( morphism_1 );

        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );

    end );


    # Add hard checks to verify that an object/morphism belongs to this category
    # Add hard checks to verify that an object/morphism belongs to this category    
        
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
    
    AddIsWellDefinedForMorphisms( category,
      
      function( morphism )
        local source, range, morphism_matrix, morphism_matrix_entries, func, degrees_of_entries_matrix, degree_group, 
             source_degrees, range_degrees, buffer_row, dummy_range_degrees, i, j;
             
        
        # extract source and range
        source := Source( morphism );        
        range := Range( morphism );
        
        # then verify that both range and source are well-defined objects in this category
        if ( not IsWellDefinedForObjects( source ) ) or ( not IsWellDefinedForObjects( range ) ) then
        
          # source or range is corrupted, so return false
          return false;
        
        fi;

        # next check that the underlying homalg_graded_rings are identical
        if not ( IsIdenticalObj( UnderlyingHomalgGradedRing( source ), UnderlyingHomalgGradedRing( morphism ) ) and
                        IsIdenticalObj( UnderlyingHomalgGradedRing( morphism ), UnderlyingHomalgGradedRing( range ) ) ) then
        
          return false;
        
        fi;
        
        # and that source and range are defined in the same category
        if not IsIdenticalObj( CapCategory( source ), CapCategory( range ) ) then
        
          return false;
        
        fi;
        
        # check if the mapping is non-trivial, for otherwise we are done already
        if ( Rank( source ) = 0 or Rank( range ) = 0 ) then
        
          return true;
        
        else
        
          # extract the mapping matrix        
          morphism_matrix := UnderlyingHomalgMatrix( morphism );
          morphism_matrix_entries := EntriesOfHomalgMatrixAsListList( morphism_matrix );

          # then check if the dimensions of the matrix fit with the ranks of the source and range modules
          if not ( Rank( source ) = NrColumns( morphism_matrix )
                   and NrRows( morphism_matrix ) = Rank( range ) ) then
          
            return false;
          
          fi;
                    
          # subsequently compute the degrees of all entries in the morphism_matrix
          # I use the DegreeOfEntriesFunction of the underlying graded ring
          # in particular I hope that this function raises and error if one of the entries is not homogeneous
          func := DegreesOfEntriesFunction( UnderlyingHomalgGradedRing( source ) );
          degrees_of_entries_matrix := func( morphism_matrix );
        
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
          dummy_range_degrees := List( [ 1 .. Rank( range ) ] );
          for i in [ 1 .. Rank( range ) ] do
          
            # initialise the i-th buffer row
            buffer_row := List( [ 1 .. Rank( source ) ] );

            # compute its entries
            for j in [ 1 .. Rank( source ) ] do
                        
              if morphism_matrix_entries[ i ][ j ] = Zero( HomalgRing( morphism_matrix ) ) then
              
                buffer_row[ j ] := range_degrees[ i ];

              else
              
                buffer_row[ j ] := source_degrees[ j ] - degrees_of_entries_matrix[ i ][ j ];
                
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
        
        fi;
        
    end ); 
    
    ## Basic Operations for an Additive Category
    ## Basic Operations for an Additive Category

    ##
    AddIsZeroForObjects( category,
      function( object )
      
        return Rank( object ) = 0;
      
      end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( morphism )
        
        return IsZero( UnderlyingHomalgMatrix( morphism ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism_1 ),
                                                    UnderlyingHomalgMatrix( morphism_1 ) + UnderlyingHomalgMatrix( morphism_2 ),
                                                    Range( morphism_2 ) 
                                                    );
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism ),
                                                                        (-1) * UnderlyingHomalgMatrix( morphism ),
                                                                        Range( morphism )
                                                                       );
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( source );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( source,
                                                          HomalgZeroMatrix( Rank( range ), Rank( source ), homalg_graded_ring ),
                                                          range
                                                         );
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return CAPCategoryOfProjectiveGradedRightModulesObject( 
                                         [ ], category!.homalg_graded_ring_for_category_of_projective_graded_right_modules );
    end );    
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( sink, 
                                                                        HomalgZeroMatrix( 0, Rank( sink ), homalg_graded_ring ), 
                                                                        zero_object 
                                                                        );
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( zero_object, 
                                                                      HomalgZeroMatrix( Rank( source ), 0, homalg_graded_ring ), 
                                                                      source
                                                                     );
        return morphism;
        
    end );

    ##
    AddDirectSum( category,
      function( object_list )
      local homalg_graded_ring, degree_list_list, degree_list_of_direct_sum_object;
      
      # first extract the underlying graded ring
      homalg_graded_ring := UnderlyingHomalgGradedRing( object_list[ 1 ] );

      # then the degree_list of the direct sum object
      degree_list_list := List( object_list, x -> DegreeList( x ) );
      degree_list_of_direct_sum_object := Concatenation( degree_list_list );
      
      # and then return the corresponding object
      return CAPCategoryOfProjectiveGradedRightModulesObject( degree_list_of_direct_sum_object, homalg_graded_ring ); 
      
    end );
    
    ##
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
        projection_in_factor := HomalgZeroMatrix( rank_factor, rank_pre, homalg_graded_ring );
        projection_in_factor := UnionOfColumns( projection_in_factor, 
                                             HomalgIdentityMatrix( rank_factor, homalg_graded_ring ) );
        projection_in_factor := UnionOfColumns( projection_in_factor, 
                                             HomalgZeroMatrix( rank_factor, rank_post, homalg_graded_ring ) );        
                
        # and return the corresonding morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( direct_sum_object, projection_in_factor, 
                                                                                             object_list[ projection_number ] );
        
    end );

    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local underlying_matrix_of_universal_morphism, morphism;
        
        # construct the homalg matrix to represent the universal morphism
        underlying_matrix_of_universal_morphism := UnderlyingHomalgMatrix( sink[ 1 ] );
        
        for morphism in sink{ [ 2 .. Length( sink ) ] } do
          
          underlying_matrix_of_universal_morphism := 
            UnionOfRows( underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) );
          
        od;
        
        # and then construct from it the corresponding morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( sink[ 1 ] ), 
                                                                          underlying_matrix_of_universal_morphism, direct_sum );      
    end );

    ##
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
        injection_of_cofactor := HomalgZeroMatrix( rank_pre, rank_cofactor, homalg_graded_ring );
        injection_of_cofactor := UnionOfRows( injection_of_cofactor, 
                                                 HomalgIdentityMatrix( rank_cofactor, homalg_graded_ring ) );        
        injection_of_cofactor := UnionOfRows( injection_of_cofactor,
                                                 HomalgZeroMatrix( rank_post, rank_cofactor, homalg_graded_ring ) );
                
        # and construct the associated morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( object_list[ injection_number ], 
                                                                                             injection_of_cofactor, coproduct );
        
    end );

    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, coproduct )
        local underlying_matrix_of_universal_morphism, morphism;
        
        underlying_matrix_of_universal_morphism := UnderlyingHomalgMatrix( sink[1] );
        
        for morphism in sink{ [ 2 .. Length( sink ) ] } do
          
          underlying_matrix_of_universal_morphism := 
            UnionOfColumns( underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) );
          
        od;
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( coproduct, underlying_matrix_of_universal_morphism,
                                                                                                            Range( sink[ 1 ] ) );
        
    end );

    ## Weak kernels (added as kernels)
    ## Weak kernels (added as kernels)

    ##
    AddKernelObject( category,
      function( morphism )
        local homalg_graded_ring, kernel_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_kernel_matrix_columns, degrees_of_kernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        kernel_matrix := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );

        # check if the cokernel matrix is zero
        if IsZero( kernel_matrix ) then
        
          # if so, the kernel object is the zero module
          return CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the kernel matrix is not zero, thus let us compute the kernel object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( kernel_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Source( morphism ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Source( morphism ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Source( morphism ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_kernel_matrix_columns := NonTrivialDegreePerColumn( kernel_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_kernel_object := List( [ 1 .. Length( degrees_of_kernel_matrix_columns ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_kernel_matrix_columns ) ] do
        
            degrees_of_kernel_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_kernel_matrix_columns[ j ], 1 ];
          
          od;
        
          # and finally return the kernel object
          return CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_kernel_object, homalg_graded_ring );

        fi;
        
    end );
    
    AddKernelEmbedding( category,
      function( morphism )
        local homalg_graded_ring, kernel_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_kernel_matrix_columns, degrees_of_kernel_object, kernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        kernel_matrix := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );

        # check if the cokernel matrix is zero
        if IsZero( kernel_matrix ) then

          # construct the kernel_object
          kernel_object := CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the kernel matrix is not zero, thus let us compute the kernel object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( kernel_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Source( morphism ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Source( morphism ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Source( morphism ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_kernel_matrix_columns := NonTrivialDegreePerColumn( kernel_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_kernel_object := List( [ 1 .. Length( degrees_of_kernel_matrix_columns ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_kernel_matrix_columns ) ] do
        
            degrees_of_kernel_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 + degrees_of_kernel_matrix_columns[ j ], 1 ];
          
          od;
        
          # construct the kernel_object
          kernel_object := CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_kernel_object, homalg_graded_ring );

        fi;

        # and return the kernel embedding
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( kernel_object, kernel_matrix, Source( morphism ) );        
        
    end );
        
    ##
    AddKernelEmbeddingWithGivenKernelObject( category,
      function( morphism, kernel )
        local kernel_matrix;
        
        kernel_matrix := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( kernel, kernel_matrix, Source( morphism ) );
        
    end );
    
    ##
    AddLiftAlongMonomorphism( category,
      function( monomorphism, test_morphism )
        local left_divide;
        
        # try to find a lift
        left_divide := LeftDivide( UnderlyingHomalgMatrix( test_morphism ), UnderlyingHomalgMatrix( monomorphism ) );

        # check if this failed
        if left_divide = fail then
          
          return fail;
          
        fi;
        
        # and if not, then construct the lift-morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( test_morphism ),
                                                                        left_divide,
                                                                        Source( monomorphism ) );
        
    end );
    
    ## Weak cokernels (added as cokernels)
    ## Weak cokernels (added as cokernels)

    ##
    
    AddCokernelObject( category,
      function( morphism )
        local homalg_graded_ring, cokernel_matrix, cokernel_object, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_cokernel_matrix_rows, degrees_of_cokernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        cokernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );

        # check if the cokernel matrix is zero
        if IsZero( cokernel_matrix ) then
        
          # if so, the cokernel object is the zero module
          return CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
          
        else
        
          # the cokernel matrix is not zero, thus let us compute the cokernel object...
          
          # figure out the (first) non-zero entries per row of the cokernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( cokernel_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Range( morphism ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Range( morphism ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Range( morphism ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_cokernel_matrix_rows := NonTrivialDegreePerRow( cokernel_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_cokernel_object := List( [ 1 .. Length( degrees_of_cokernel_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_cokernel_matrix_rows ) ] do
        
            degrees_of_cokernel_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 - degrees_of_cokernel_matrix_rows[ j ], 1 ];
          
          od;
        
          # and finally return the cokernel object
          return CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_cokernel_object, homalg_graded_ring );

        fi;

    end );
    
    AddCokernelProjection( category,
      function( morphism )
        local homalg_graded_ring, cokernel_matrix, cokernel_object, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_cokernel_matrix_rows, degrees_of_cokernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        cokernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );

        # check if the cokernel matrix is zero
        if IsZero( cokernel_matrix ) then
        
          # if so, the cokernel object is the zero module
          cokernel_object := CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
          
        else
        
          # the cokernel matrix is not zero, thus let us compute the cokernel object...
          
          # figure out the (first) non-zero entries per row of the cokernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( cokernel_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Range( morphism ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Range( morphism ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Range( morphism ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_cokernel_matrix_rows := NonTrivialDegreePerRow( cokernel_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_cokernel_object := List( [ 1 .. Length( degrees_of_cokernel_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_cokernel_matrix_rows ) ] do
        
            degrees_of_cokernel_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                                 - degrees_of_cokernel_matrix_rows[ j ], 1 ];
          
          od;
        
          # and finally return the cokernel object
          cokernel_object := CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_cokernel_object, homalg_graded_ring );

        fi;

        # and return the mapping morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism ), cokernel_matrix, cokernel_object );        
        
    end );    
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( category,
      function( morphism, cokernel )
        local cokernel_proj;
        
        cokernel_proj := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );
        
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism ), cokernel_proj, cokernel );
        
    end );

    ##
    AddColiftAlongEpimorphism( category,
      function( epimorphism, test_morphism )
        local right_divide;
        
        # try to find a matrix that performs the colift
        right_divide := RightDivide( UnderlyingHomalgMatrix( epimorphism ), UnderlyingHomalgMatrix( test_morphism ) );

        # check if this worked
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        # if it did work, return the corresponding morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( epimorphism ),
                                                                        right_divide,
                                                                        Range( test_morphism ) );
        
    end );
    
    ## Lift
    ## Lift
    # the lift of morphism2 along morphism1, i.e. morphism1: K -> M, morphism2: L -> M, then lift( 1,2 ): L -> K        
    AddLift( category,
      function( morphism1, morphism2 )
        local left_divide;
        
        # try to find a lift
        left_divide := LeftDivide( UnderlyingHomalgMatrix( morphism2 ), UnderlyingHomalgMatrix( morphism1 ) );

        # check if this failed
        if left_divide = fail then
          
          return fail;
          
        fi;
        
        # and if not, then construct the lift-morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Source( morphism2 ),
                                                                        left_divide,
                                                                        Source( morphism1 ) );
        
    end );    
    
    ## Colift
    ## Colift
    # the colift of morphism2 along morphism1, i.e. morphism1: N -> C, morphism2: N -> L, then colift( 1,2 ): C -> L
    AddColift( category,
      function( morphism1, morphism2 )
        local right_divide;
        
        # try to find a matrix that performs the colift
        right_divide := RightDivide( UnderlyingHomalgMatrix( morphism1 ), UnderlyingHomalgMatrix( morphism2 ) );

        # check if this worked
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        # if it did work, return the corresponding morphism
        return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism1 ),
                                                                        right_divide,
                                                                        Range( morphism2 ) );
        
    end );

    # weak fibreproduct
    # weak fibreproduct
    AddFiberProduct( category,             
      function( morphism_list )
        local homalg_graded_ring, matrix1, matrix2, projection1_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_projection1_matrix_columns, degrees_of_fibreproduct_object;
        
        # we only define the fiber product for two morphisms, otherwise raise an error
        if Length( morphism_list ) <> 2 then
        
          Error( "Fiber product only accepts a list with precisely two morphisms as input. \n" );
          return fail;
        
        fi;

        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism_list[ 1 ] );
        
        # and the mapping matrices of these two morphisms
        matrix1 := UnderlyingHomalgMatrix( morphism_list[ 1 ] );
        matrix2 := UnderlyingHomalgMatrix( morphism_list[ 2 ] );
        
        # now compute the relative version of syzygies of rows
        projection1_matrix := SyzygiesOfColumns( matrix1, matrix2 );
        
        # this means that we have the following diagram:
        #                     
        #   Source( 2 ) --- morphism2 ----- > Range( 2 ) = Range( 1 )
        #                                                ^
        #                                                |
        #                                                |
        #                                            morphism1
        #                                                |
        #                                                |
        #                                            Source( 1 )
        #                                                |
        #                                                |
        #                                        projection1_matrix
        #                                                |
        #                                                |
        #                                         fibreproduct( 1, 2 )
        
        # now interpret projection1 as the mapping matrix of a map of projective graded left modules with range the 
        # source of morphism1
        # -> so essentially repeat the kernel algorithm
        
        # check if the cokernel matrix is zero
        if IsZero( projection1_matrix ) then
        
          # if so, the kernel object is the zero module
          return CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the kernel matrix is not zero, thus let us compute the kernel object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( projection1_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Source( morphism_list[ 1 ] ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Source( morphism_list[ 1 ] ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Source( morphism_list[ 1 ] ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_projection1_matrix_columns := NonTrivialDegreePerColumn( projection1_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_fibreproduct_object := List( [ 1 .. Length( degrees_of_projection1_matrix_columns ) ] );
          
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_projection1_matrix_columns ) ] do
        
            degrees_of_fibreproduct_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                           + degrees_of_projection1_matrix_columns[ j ], 1 ];
          
          od;
          
          # and finally return the cokernel object
          return CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_fibreproduct_object, homalg_graded_ring );

        fi;

    end );

    AddProjectionInFactorOfFiberProductWithGivenFiberProduct( category,
      function( morphism_list, projection_number, fibre_product_object )

        local homalg_graded_ring, matrix1, matrix2, projection1_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_projection1_matrix_columns, degrees_of_fibreproduct_object, fibreproduct_object_dummy;
        
        # we only define the fiber product for two morphisms, otherwise raise an error
        if Length( morphism_list ) <> 2 then
        
          Error( "Fiber product only accepts a list with precisely two morphisms as input. \n" );
          return fail;
        
        fi;

        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism_list[ 1 ] );
        
        # and the mapping matrices of these two morphisms
        matrix1 := UnderlyingHomalgMatrix( morphism_list[ 1 ] );
        matrix2 := UnderlyingHomalgMatrix( morphism_list[ 2 ] );
        
        # now compute the relative version of syzygies of rows
        projection1_matrix := SyzygiesOfColumns( matrix1, matrix2 );
        
        # this means that we have the following diagram:
        #                     
        #   Source( 2 ) --- morphism2 ----- > Range( 2 ) = Range( 1 )
        #                                                ^
        #                                                |
        #                                                |
        #                                            morphism1
        #                                                |
        #                                                |
        #                                            Source( 1 )
        #                                                |
        #                                                |
        #                                        projection1_matrix
        #                                                |
        #                                                |
        #                                         fibreproduct( 1, 2 )
        
        # now interpret projection1 as the mapping matrix of a map of projective graded left modules with range the 
        # source of morphism1
        # -> so essentially repeat the kernel algorithm
        
        # check if the cokernel matrix is zero
        if IsZero( projection1_matrix ) then
        
          # if so, the kernel object is the zero module
          fibreproduct_object_dummy := CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
        
        else
        
          # the kernel matrix is not zero, thus let us compute the kernel object...
          
          # figure out the (first) non-zero entries per row of the kernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerColumn( projection1_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Source( morphism_list[ 1 ] ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Source( morphism_list[ 1 ] ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Source( morphism_list[ 1 ] ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_projection1_matrix_columns := NonTrivialDegreePerColumn( projection1_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_fibreproduct_object := List( [ 1 .. Length( degrees_of_projection1_matrix_columns ) ] );
          
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_projection1_matrix_columns ) ] do
        
            degrees_of_fibreproduct_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                           + degrees_of_projection1_matrix_columns[ j ], 1 ];
          
          od;
          
          # and finally construct the fibreproduct object
          fibreproduct_object_dummy :=  CAPCategoryOfProjectiveGradedRightModulesObject( 
                                                                        degrees_of_fibreproduct_object, homalg_graded_ring );

        fi;
        
        # now make a new check on the validity of the input
        if not IsEqualForObjects( fibreproduct_object_dummy, fibre_product_object ) then
        
          Error( "The entered fibreproduct object is not equal to the interally computed fibreproduct object. \n" );
          return fail;
        
        fi;
        
        # next check if the projection number if valid
        if projection_number < 0 or projection_number > 2 then
        
          Error( "The projection number is only allowed to be either 1 or 2!. \n" );
        
        fi;
        
        # else the input is ok and we can product the output
        if projection_number = 1 then
        
          return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( fibre_product_object, 
                                                                          projection1_matrix,
                                                                          Source( morphism_list[ 1 ] )
                                                                          );
        
        else

          # have to compute the lift
          return Lift( morphism_list[ 2 ], 
                       PreCompose ( CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( fibre_product_object, 
                                                                                             projection1_matrix,
                                                                                             Source( morphism_list[ 1 ] )
                                                                                            ) 
                                    , morphism_list[ 1 ] )
                      );
        
        fi;
    
    end );


    
    
    
    # weak pushout
    # weak pushout    
    AddPushout( category,            
      function( morphism_list )
        local homalg_graded_ring, matrix1, matrix2, embedding1_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_embedding1_matrix_rows, degrees_of_pushout_object;
        
        # we only define the pushout for two morphisms, otherwise raise an error
        if Length( morphism_list ) <> 2 then
        
          Error( "Pushout only accepts a list with precisely two morphisms as input. \n" );
          return fail;
        
        fi;

        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism_list[ 1 ] );
        
        # and the mapping matrices of these two morphisms
        matrix1 := UnderlyingHomalgMatrix( morphism_list[ 1 ] );
        matrix2 := UnderlyingHomalgMatrix( morphism_list[ 2 ] );
        
        # now compute the relative version of syzygies of rows
        embedding1_matrix := SyzygiesOfRows( matrix1, matrix2 );

        # this means that we have the following diagram:
        #                     
        #   Range( 2 ) <--- morphism2 -----  Source( 2 ) = Source( 1 )
        #                                                |
        #                                                |
        #                                                |
        #                                            morphism1
        #                                                |
        #                                                v
        #                                            Range( 1 )
        #                                                |
        #                                                |
        #                                        embedding1_matrix
        #                                                |
        #                                                v
        #                                           pushout( 1, 2 )
        
        # now interpret embedding1 as the mapping matrix of a map of projective graded left modules with source the 
        # range of morphism1
        # -> so essentially repeat the cokernel algorithm

        # check if the cokernel matrix is zero
        if IsZero( embedding1_matrix ) then
        
          # if so, the cokernel object is the zero module
          return CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
          
        else
        
          # the cokernel matrix is not zero, thus let us compute the cokernel object...
          
          # figure out the (first) non-zero entries per row of the cokernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( embedding1_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Range( morphism_list[ 1 ] ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Range( morphism_list[ 1 ] ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Range( morphism_list[ 1 ] ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_embedding1_matrix_rows := NonTrivialDegreePerRow( embedding1_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_pushout_object := List( [ 1 .. Length( degrees_of_embedding1_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_embedding1_matrix_rows ) ] do
        
            degrees_of_pushout_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                               - degrees_of_embedding1_matrix_rows[ j ], 1 ];
          
          od;
        
          # and finally return the cokernel object
          return CAPCategoryOfProjectiveGradedRightModulesObject( degrees_of_pushout_object, homalg_graded_ring );

        fi;
        
    end );

    AddInjectionOfCofactorOfPushoutWithGivenPushout( category,
      function( morphism_list, injection_number, pushout_object )
        local homalg_graded_ring, matrix1, matrix2, embedding1_matrix, non_zero_entries_index, expanded_degree_list, j, k,
             degrees_of_embedding1_matrix_rows, degrees_of_pushout_object, pushout_object_dummy;

        # we only define the pushout for two morphisms, otherwise raise an error
        if Length( morphism_list ) <> 2 then
        
          Error( "Pushout only accepts a list with precisely two morphisms as input. \n" );
          return fail;
        
        fi;

        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism_list[ 1 ] );
        
        # and the mapping matrices of these two morphisms
        matrix1 := UnderlyingHomalgMatrix( morphism_list[ 1 ] );
        matrix2 := UnderlyingHomalgMatrix( morphism_list[ 2 ] );
        
        # now compute the relative version of syzygies of rows
        embedding1_matrix := SyzygiesOfRows( matrix1, matrix2 );

        # this means that we have the following diagram:
        #                     
        #   Range( 2 ) <--- morphism2 -----  Source( 2 ) = Source( 1 )
        #                                                |
        #                                                |
        #                                                |
        #                                            morphism1
        #                                                |
        #                                                v
        #                                            Range( 1 )
        #                                                |
        #                                                |
        #                                        embedding1_matrix
        #                                                |
        #                                                v
        #                                           pushout( 1, 2 )
        
        # now interpret embedding1 as the mapping matrix of a map of projective graded left modules with source the 
        # range of morphism1
        # -> so essentially repeat the cokernel algorithm

        # check if the cokernel matrix is zero
        if IsZero( embedding1_matrix ) then
        
          # if so, the cokernel object is the zero module
          pushout_object_dummy := CAPCategoryOfProjectiveGradedRightModulesObject( [ ], homalg_graded_ring );
          
        else
        
          # the cokernel matrix is not zero, thus let us compute the cokernel object...
          
          # figure out the (first) non-zero entries per row of the cokernel matrix
          non_zero_entries_index := PositionOfFirstNonZeroEntryPerRow( embedding1_matrix );
          
          # expand the degree_list of the range of the morphism
          expanded_degree_list := [];
          for j in [ 1 .. Length( DegreeList( Range( morphism_list[ 1 ] ) ) ) ] do
          
            for k in [ 1 .. DegreeList( Range( morphism_list[ 1 ] ) )[ j ][ 2 ] ] do
            
              Add( expanded_degree_list, DegreeList( Range( morphism_list[ 1 ] ) )[ j ][ 1 ] );
            
            od;
          
          od;
          
          # compute the degrees of the rows of the cokernel matrix
          degrees_of_embedding1_matrix_rows := NonTrivialDegreePerRow( embedding1_matrix );
        
          # initialise the degree list of the kernel_object
          degrees_of_pushout_object := List( [ 1 .. Length( degrees_of_embedding1_matrix_rows ) ] );
        
          # and now compute the degrees of the kernel_object
          for j in [ 1 .. Length( degrees_of_embedding1_matrix_rows ) ] do
        
            degrees_of_pushout_object[ j ] := [ expanded_degree_list[ non_zero_entries_index[ j ] ]
                                                                               - degrees_of_embedding1_matrix_rows[ j ], 1 ];
          
          od;
        
          # and finally return the cokernel object
          pushout_object_dummy := CAPCategoryOfProjectiveGradedRightModulesObject( 
                                                                             degrees_of_pushout_object, homalg_graded_ring );

        fi;             
             
        # now make a new check on the validity of the input
        if not IsEqualForObjects( pushout_object_dummy, pushout_object ) then
        
          Error( "The entered pushout object is not equal to the interally computed pushout object. \n" );
          return fail;
        
        fi;
        
        # next check if the projection number if valid
        if injection_number < 0 or injection_number > 2 then
        
          Error( "The injection number is only allowed to be either 1 or 2!. \n" );
        
        fi;
        
        # else the input is ok and we can product the output
        if injection_number = 1 then
        
          return CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism_list[ 1 ] ),
                                                                          embedding1_matrix,
                                                                          pushout_object
                                                                          );
        
        else

          # have to compute the colift
          return Colift( morphism_list[ 2 ], 
                       PreCompose( morphism_list[ 1 ],
                                    CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( Range( morphism_list[ 1 ] ),
                                                                                             embedding1_matrix,
                                                                                             pushout_object
                                                                                            )
                                  )
                      );
        
        fi;        
        
    end );
        
end );