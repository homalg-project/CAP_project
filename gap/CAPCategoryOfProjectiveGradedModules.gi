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

InstallMethod( CAPCategoryOfProjectiveGradedModules,
               [ IsHomalgGradedRing ],
               
  function( homalg_graded_ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "CAP category of projective, graded modules over "
                                                                                          , RingName( homalg_graded_ring ) ) );
    
    category!.homalg_graded_ring_for_category_of_projective_graded_modules := homalg_graded_ring;
    
    SetIsAdditiveCategory( category, true );
     
    INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_MODULES( category ); 
    
    ## TODO: Logic for CAPCategoryOfProjectiveGradedModules
    
    #AddPredicateImplicationFileToCategory( category,
    #  Filename(
    #    DirectoriesPackageLibrary( "LinearAlgebraForCAP", "LogicForMatrixCategory" ),
    #    "PredicateImplicationsForMatrixCategory.tex" )
    #);
     
    Finalize( category );
    
    return category;
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_CAP_CATEGORY_OF_PROJECTIVE_GRADED_MODULES,

  function( category )
    
    ## Equality Basic Operations for Objects and Morphisms
    ## Equality Basic Operations for Objects and Morphisms

    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
      
        return DegreeList( object_1 ) = DegreeList( object_2 );
      
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return UnderlyingHomalgMatrix( morphism_1 ) = UnderlyingHomalgMatrix( morphism_2 );
        
    end );
    
    ## Basic Operations for a Category
    ## Basic Operations for a Category
    
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( object );
        
        return CAPCategoryOfProjectiveGradedModulesMorphism( object, 
                                                          HomalgIdentityMatrix( Rank( object ), homalg_graded_ring ), object );
        
    end );
    
    ##
    AddPreCompose( category,

      function( morphism_1, morphism_2 )
        local composition;

        composition := UnderlyingHomalgMatrix( morphism_1 ) * UnderlyingHomalgMatrix( morphism_2 );

        return CAPCategoryOfProjectiveGradedModulesMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );

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
        
        return CAPCategoryOfProjectiveGradedModulesMorphism( Source( morphism_1 ),
                                                    UnderlyingHomalgMatrix( morphism_1 ) + UnderlyingHomalgMatrix( morphism_2 ),
                                                    Range( morphism_2 ) 
                                                    );
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return CAPCategoryOfProjectiveGradedModulesMorphism( Source( morphism ),
                                                             (-1) * UnderlyingHomalgMatrix( morphism ),
                                                             Range( morphism )
                                                             );
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( source );
        
        return CAPCategoryOfProjectiveGradedModulesMorphism( source,
                                           HomalgZeroMatrix( RankOfObject( source ), RankOfObject( range ), homalg_graded_ring ),
                                           range
                                          );
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return CAPCategoryOfProjectiveGradedModulesObject( 
                                         [ [ Zero( DegreeGroup( category!.homalg_graded_ring_for_projective_category ) ), 0 ] ], 
                                         category!.homalg_graded_ring_for_category_of_projective_graded_modules
                                         );
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := CAPCategoryOfProjectiveGradedModulesMorphism( sink, 
                                                HomalgZeroMatrix( RankOfObject( sink ), 0, homalg_graded_ring ), 
                                                zero_object 
                                               );
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := CAPCategoryOfProjectiveGradedModulesMorphism( zero_object, 
                                                              HomalgZeroMatrix( 0, RankOfObject( source ), homalg_graded_ring ), 
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
      return CAPCategoryOfProjectiveGradedModulesObject( degree_list_of_direct_sum_object, homalg_graded_ring ); 
      
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
        return CAPCategoryOfProjectiveGradedModulesMorphism( direct_sum_object, projection_in_factor, 
                                                                                             object_list[ projection_number ] );
        
    end );

    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local underlying_matrix_of_universal_morphism, morphism;
        
        # construct the homalg matrix to represent the universal morphism
        underlying_matrix_of_universal_morphism := UnderlyingHomalgMatrix( sink[1] );
        
        for morphism in sink{ [ 2 .. Length( sink ) ] } do
          
          underlying_matrix_of_universal_morphism := 
            UnionOfColumns( underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) );
          
        od;
        
        # and then construct from it the corresponding morphism
        return CAPCategoryOfProjectiveGradedModulesMorphism( Source( sink[ 1 ] ), 
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
        return CAPCategoryOfProjectiveGradedModulesMorphism( object_list[ injection_number ], 
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
        
        return CAPCategoryOfProjectiveGradedModulesMorphism( coproduct, underlying_matrix_of_universal_morphism, 
                                                                                                             Range( sink[1] ) );
        
    end );

    ## Weak kernels (added as kernels)
    ## Weak kernels (added as kernels)

    ##
    AddKernelObject( category,
      function( morphism )
        local homalg_graded_ring, kernel_matrix, degrees_of_kernel_matrix_rows, i, degrees_of_kernel_object, counter, counter2;
        
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        kernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );
        
        # compute the degrees of the rows of the kernel matrix
        degrees_of_kernel_matrix_rows := NonTrivialDegreePerRow( kernel_matrix );

        # initialise the degree list of the kernel_object
        degrees_of_kernel_object := List( [ 1 .. Length( degrees_of_kernel_matrix_rows ) ] );
        
        # and now compute the degrees of the kernel_object
        counter := 1;
        counter2 := 1;
        for i in [ 1 .. Length( degrees_of_kernel_matrix_rows ) ] do
        
          degrees_of_kernel_object[ i ] := [ DegreeList( Source( morphism ) )[ counter ][ 1 ]
                                                                                      + degrees_of_kernel_matrix_rows[ i ], 1 ];
        
          counter2 := counter2 + 1;
          if counter2 > DegreeList( Source( morphism ) )[ counter ][ 2 ] then
          
            counter2 := 1;
            counter := counter + 1;
          
          fi;
        
        od;
                       
        # and construct this object
        return CAPCategoryOfProjectiveGradedModulesObject( degrees_of_kernel_object, homalg_graded_ring );
        
    end );

    ##
    AddKernelEmbedding( category,
      function( morphism )
        local homalg_graded_ring, kernel_matrix, degrees_of_kernel_matrix_rows, i, degrees_of_kernel_object, counter, counter2,
             kernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        kernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );
        
        # compute the degrees of the rows of the kernel matrix
        degrees_of_kernel_matrix_rows := NonTrivialDegreePerRow( kernel_matrix );

        # initialise the degree list of the kernel_object
        degrees_of_kernel_object := List( [ 1 .. Length( degrees_of_kernel_matrix_rows ) ] );
        
        # and now compute the degrees of the kernel_object
        counter := 1;
        counter2 := 1;
        for i in [ 1 .. Length( degrees_of_kernel_matrix_rows ) ] do
        
          degrees_of_kernel_object[ i ] := [ DegreeList( Source( morphism ) )[ counter ][ 1 ]
                                                                                      + degrees_of_kernel_matrix_rows[ i ], 1 ];
        
          counter2 := counter2 + 1;
          if counter2 > DegreeList( Source( morphism ) )[ counter ][ 2 ] then
          
            counter2 := 1;
            counter := counter + 1;
          
          fi;
        
        od;
                       
        # and construct this object
        kernel_object := CAPCategoryOfProjectiveGradedModulesObject( degrees_of_kernel_object, homalg_graded_ring );
               
        # and return the kernel embedding
        return CAPCategoryOfProjectiveGradedModulesMorphism( kernel_object, kernel_matrix, Source( morphism ) );
    end );

    ##
    AddKernelEmbeddingWithGivenKernelObject( category,
      function( morphism, kernel )
        local kernel_matrix;
        
        kernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );
        
        return CAPCategoryOfProjectiveGradedModulesMorphism( kernel, kernel_matrix, Source( morphism ) );
        
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
        return CAPCategoryOfProjectiveGradedModulesMorphism( Source( test_morphism ),
                                    right_divide,
                                    Source( monomorphism ) );
        
    end );
    
    ## Weak cokernels (added as cokernels)
    ## Weak cokernels (added as cokernels)

    ##
    AddCokernelObject( category,
      function( morphism )
        local homalg_graded_ring, cokernel_matrix, degrees_of_cokernel_matrix_columns, i, degrees_of_cokernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        cokernel_matrix := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );
        
        # compute the degrees of the rows of the kernel matrix
        degrees_of_cokernel_matrix_columns := NonTrivialDegreePerColumn( cokernel_matrix );

        # initialise the degree list of the kernel_object
        degrees_of_cokernel_object := List( [ 1 .. Length( degrees_of_cokernel_matrix_columns ) ] );
        
        # and now compute the degrees of the kernel_object
        for i in [ 1 .. Length( degrees_of_cokernel_matrix_columns ) ] do
        
          degrees_of_cokernel_object[ i ] := [ DegreeList( Source( morphism ) )[ 1 ][ 1 ]
                                                                                 - degrees_of_cokernel_matrix_columns[ i ], 1 ];
          
        od;
        
        # and return the cokernel object
        return CAPCategoryOfProjectiveGradedModulesObject( degrees_of_cokernel_object, homalg_graded_ring );
               
    end );
          
    ##
    AddCokernelProjection( category,
      function( morphism )
        local homalg_graded_ring, cokernel_matrix, degrees_of_cokernel_matrix_columns, i, degrees_of_cokernel_object, 
             cokernel_object;
             
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # then compute the syzygies of rows, which form the 'kernel matrix'
        cokernel_matrix := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );
        
        # compute the degrees of the rows of the kernel matrix
        degrees_of_cokernel_matrix_columns := NonTrivialDegreePerColumn( cokernel_matrix );

        # initialise the degree list of the kernel_object
        degrees_of_cokernel_object := List( [ 1 .. Length( degrees_of_cokernel_matrix_columns ) ] );
        
        # and now compute the degrees of the kernel_object
        for i in [ 1 .. Length( degrees_of_cokernel_matrix_columns ) ] do
        
          degrees_of_cokernel_object[ i ] := [ DegreeList( Source( morphism ) )[ 1 ][ 1 ]
                                                                                 - degrees_of_cokernel_matrix_columns[ i ], 1 ];
          
        od;
        
        # and return the cokernel object
        cokernel_object := CAPCategoryOfProjectiveGradedModulesObject( degrees_of_cokernel_object, homalg_graded_ring );

        # and return the cokernel projection
        return CAPCategoryOfProjectiveGradedModulesMorphism( Range( morphism ), cokernel_matrix, cokernel_object );
    
    end );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( category,
      function( morphism, cokernel )
        local cokernel_proj;
        
        cokernel_proj := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );
        
        return CAPCategoryOfProjectiveGradedModulesMorphism( Range( morphism ), cokernel_proj, cokernel );
        
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
        return CAPCategoryOfProjectiveGradedModulesMorphism( Range( epimorphism ),
                                                             left_divide,
                                                             Range( test_morphism ) );
        
    end );
    
end );