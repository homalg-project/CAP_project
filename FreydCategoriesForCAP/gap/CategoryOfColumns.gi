#############################################################################
##
## FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
## Copyright 2019, Martin Bies, Université libre Bruxelles
##
#############################################################################

####################################
##
## Constructors
##
####################################

##
InstallMethod( CategoryOfColumns,
               [ IsHomalgRing ],
               
  function( homalg_ring )
    local overhead_option, category, to_be_finalized;
    
    overhead_option := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "overhead", true );
    
    category := CreateCapCategory( Concatenation( "Columns( ", RingName( homalg_ring )," )" ) : overhead := overhead_option );
    
    SetFilterObj( category, IsCategoryOfColumns );
    
    SetIsAdditiveCategory( category, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( category, true );
    
    SetIsStrictMonoidalCategory( category, true );
    
    SetUnderlyingRing( category, homalg_ring );
    
    if HasIsCommutative( homalg_ring ) and IsCommutative( homalg_ring ) then
      
      SetIsLinearCategoryOverCommutativeRing( category, true );
      
      SetCommutativeRingOfLinearCategory( category, homalg_ring );
      
    fi;
    
    AddObjectRepresentation( category, IsCategoryOfColumnsObject );
    
    AddMorphismRepresentation( category, IsCategoryOfColumnsMorphism and HasUnderlyingMatrix );
    
    INSTALL_FUNCTIONS_FOR_CATEGORY_OF_COLUMNS( category );
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
      
    if to_be_finalized = false then
      
      return category;
    
    fi;
    
    Finalize( category );
    
    return category;
    
end );

##
InstallOtherMethod( CategoryOfColumnsObject,
                    [ IsInt, IsCategoryOfColumns ],
               
  function( rank, category )
    
    return CategoryOfColumnsObject( category, rank );
    
end );

##
InstallMethod( CategoryOfColumnsObjectOp,
               [ IsCategoryOfColumns, IsInt ],
               
  function( category, rank )
    local category_of_columns_object;
    
    if rank < 0 then
      
      return Error( "first argument must be a non-negative integer" );
      
    fi;
    
    category_of_columns_object := rec( );
    
    ObjectifyObjectForCAPWithAttributes( category_of_columns_object, 
                                         category,
                                         RankOfObject, rank
    );
    
    return category_of_columns_object;
    
end );

##
InstallMethod( AsCategoryOfColumnsMorphism,
               [ IsHomalgMatrix, IsCategoryOfColumns ],
               
  function( homalg_matrix, category )
    local source, range;
    
    source := CategoryOfColumnsObject( NrColumns( homalg_matrix ), category );
    
    range := CategoryOfColumnsObject( NrRows( homalg_matrix ), category );
    
    return CategoryOfColumnsMorphism( source, homalg_matrix, range );
    
end );

##
InstallMethod( CategoryOfColumnsMorphism,
               [ IsCategoryOfColumnsObject, IsHomalgMatrix, IsCategoryOfColumnsObject ],
               
  function( source, homalg_matrix, range )
    local category_of_columns_morphism, homalg_ring, category;
    
    category := CapCategory( source );
    
    if not IsIdenticalObj( category, CapCategory( range ) ) then
      
      return Error( "source and range are not defined over identical categories" );
      
    fi;
    
    homalg_ring := HomalgRing( homalg_matrix );
    
    if not IsIdenticalObj( homalg_ring, UnderlyingRing( category ) ) then
      
      return Error( "the matrix is defined over a different ring than the objects" );
      
    fi;
    
    if NrColumns( homalg_matrix ) <> RankOfObject( source ) then
      
      return Error( "the number of columns has to be equal to the rank of the source" );
      
    fi;
    
    if NrRows( homalg_matrix ) <> RankOfObject( range ) then
      
      return Error( "the number of rows has to be equal to the rank of the range" );
      
    fi;
    
    category_of_columns_morphism := rec( );
    
    ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( category_of_columns_morphism, category,
                                           source,
                                           range,
                                           UnderlyingMatrix, homalg_matrix
    );
    
    return category_of_columns_morphism;
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple,
               [ IsCategoryOfColumnsMorphism ],
               
  function( alpha )
    
    ## [ S, U, V, UI, VI ];
    ## U M V = S
    return SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( alpha ) );
    
end );

##
InstallMethod( CATEGORY_OF_COLUMNS_SimplificationSourceTuple,
               [ IsCategoryOfColumnsMorphism ],
               
  function( alpha )
    
    ## [ S, T, TI ];
    ## M T = S
    return SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( alpha ) );
    
end );

##
InstallMethod( CATEGORY_OF_COLUMNS_SimplificationRangeTuple,
               [ IsCategoryOfColumnsMorphism ],
               
  function( alpha )
    
    ## [ S, T, TI ];
    ## T M = S
    return SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( alpha ) );
    
end );



####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_CATEGORY_OF_COLUMNS,
  
  function( category )
    local ring;
    
    ring := UnderlyingRing( category );
    
    ##
    AddIsEqualForCacheForObjects( category,
      IsIdenticalObj );
    
    ##
    AddIsEqualForCacheForMorphisms( category,
      IsIdenticalObj );

    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( object )
        
        if not IsIdenticalObj( category, CapCategory( object ) ) then
          
          return false;
          
        elif RankOfObject( object ) < 0 then
          
          return false;
          
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        
        if not IsIdenticalObj( category, CapCategory( Source( morphism ) ) ) then
          
          return false;
          
        elif not IsIdenticalObj( category, CapCategory( morphism ) ) then
          
          return false;
          
        elif not IsIdenticalObj( category, CapCategory( Range( morphism ) ) ) then
          
          return false;
          
        elif NrColumns( UnderlyingMatrix( morphism ) ) <> RankOfObject( Source( morphism ) ) then
          
          return false;
          
        elif NrRows( UnderlyingMatrix( morphism ) ) <> RankOfObject( Range( morphism ) ) then
          
          return false;
          
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
      
        return RankOfObject( object_1 ) = RankOfObject( object_2 );
      
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return UnderlyingMatrix( morphism_1 ) = UnderlyingMatrix( morphism_2 );
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( object )
        
        return CategoryOfColumnsMorphism( object, HomalgIdentityMatrix( RankOfObject( object ), ring ), object );
        
    end );
    
    ##
    AddPreCompose( category,
      
      [ 
        [ function( morphism_1, morphism_2 )
            local composition;
            
            composition := UnderlyingMatrix( morphism_2 ) * UnderlyingMatrix( morphism_1 );
            
            return CategoryOfColumnsMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );
            
          end, [ , ] ],
        
        [ function( left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ , IsIdenticalToIdentityMorphism ] ],
        
        [ function( identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsIdenticalToIdentityMorphism, ] ],
        
        [ function( left_morphism, zero_morphism )
            
            return CategoryOfColumnsMorphism( Source( left_morphism ),
                                        HomalgZeroMatrix( NrRows( UnderlyingMatrix( zero_morphism ) ),
                                        NrColumns( UnderlyingMatrix( left_morphism ) ), ring ),
                                        Range( zero_morphism ) );
          
          end, [ , IsZeroForMorphisms ] ],
        
        [ function( zero_morphism, right_morphism )
            
            return CategoryOfColumnsMorphism( Source( zero_morphism ),
                                           HomalgZeroMatrix( NrRows( UnderlyingMatrix( right_morphism ) ), 
                                           NrColumns( UnderlyingMatrix( zero_morphism ) ), ring ),
                                           Range( right_morphism ) );
          
          end, [ IsZeroForMorphisms, ] ],
      ]
    
    );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( morphism )
        
        return IsZero( UnderlyingMatrix( morphism ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return CategoryOfColumnsMorphism( Source( morphism_1 ),
                                       UnderlyingMatrix( morphism_1 ) + UnderlyingMatrix( morphism_2 ),
                                       Range( morphism_2 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return CategoryOfColumnsMorphism( Source( morphism ),
                                       MinusOne( ring ) * UnderlyingMatrix( morphism ),
                                       Range( morphism ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        
        return CategoryOfColumnsMorphism( source,
                                       HomalgZeroMatrix( RankOfObject( range ), RankOfObject( source ), ring ),
                                       range );
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return CategoryOfColumnsObject( 0, category );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local morphism;

        morphism := CategoryOfColumnsMorphism( sink, HomalgZeroMatrix( 0, RankOfObject( sink ), ring ), zero_object );
        
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local morphism;

        morphism := CategoryOfColumnsMorphism( zero_object, HomalgZeroMatrix( RankOfObject( source ), 0, ring ), source );
        
        return morphism;
        
    end );
    
    ##
    AddDirectSum( category,
      function( object_list )
      local dimension;
      
      dimension := Sum( List( object_list, object -> RankOfObject( object ) ) );
      
      return CategoryOfColumnsObject( dimension, category );
      
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( direct_sum_source, diagram, direct_sum_range )
        
        return CategoryOfColumnsMorphism( direct_sum_source,
                                       DiagMat( List( diagram, mor -> UnderlyingMatrix( mor ) ) ), 
                                       direct_sum_range );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, projection_number, direct_sum_object )
        local rank_pre, rank_post, rank_factor, number_of_objects, projection_in_factor;
        
        number_of_objects := Length( object_list );
        
        rank_pre := Sum( object_list{ [ 1 .. projection_number - 1 ] }, c -> RankOfObject( c ) );
        
        rank_post := Sum( object_list{ [ projection_number + 1 .. number_of_objects ] }, c -> RankOfObject( c ) );
        
        rank_factor := RankOfObject( object_list[ projection_number ] );
        
        projection_in_factor := HomalgZeroMatrix( rank_factor, rank_pre, ring );

        projection_in_factor := UnionOfColumns( projection_in_factor,
                                                HomalgIdentityMatrix( rank_factor, ring ) );

        projection_in_factor := UnionOfColumns( projection_in_factor,
                                                HomalgZeroMatrix( rank_factor, rank_post, ring ) );

        return CategoryOfColumnsMorphism( direct_sum_object, projection_in_factor, object_list[ projection_number ] );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local underlying_matrix_of_universal_morphism;
        
        underlying_matrix_of_universal_morphism :=
          UnionOfRows(
            List( sink, UnderlyingMatrix )
        );
        
        return CategoryOfColumnsMorphism( Source( sink[1] ), underlying_matrix_of_universal_morphism, direct_sum );
      
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, injection_number, coproduct )
        local rank_pre, rank_post, rank_cofactor, number_of_objects, injection_of_cofactor;
        
        number_of_objects := Length( object_list );
        
        rank_pre := Sum( object_list{ [ 1 .. injection_number - 1 ] }, c -> RankOfObject( c ) );
        
        rank_post := Sum( object_list{ [ injection_number + 1 .. number_of_objects ] }, c -> RankOfObject( c ) );
        
        rank_cofactor := RankOfObject( object_list[ injection_number ] );

        # now construct the mapping matrix
        injection_of_cofactor := HomalgZeroMatrix( rank_pre, rank_cofactor, ring );

        injection_of_cofactor := UnionOfRows( injection_of_cofactor,
                                              HomalgIdentityMatrix( rank_cofactor, ring ) );
        
        injection_of_cofactor := UnionOfRows( injection_of_cofactor,
                                              HomalgZeroMatrix( rank_post, rank_cofactor, ring ) );
        
        return CategoryOfColumnsMorphism( object_list[ injection_number ], injection_of_cofactor, coproduct );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, coproduct )
        local underlying_matrix_of_universal_morphism;
        
        underlying_matrix_of_universal_morphism :=
          UnionOfColumns(
            List( sink, UnderlyingMatrix )
        );
        
        return CategoryOfColumnsMorphism( coproduct, underlying_matrix_of_universal_morphism, Range( sink[1] ) );
        
    end );
    
    ## Operations important for Freyd categories
    
    AddWeakKernelEmbedding( category,
      function( morphism )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfColumns( UnderlyingMatrix( morphism ) );
        
        return CategoryOfColumnsMorphism( CategoryOfColumnsObject( NrColumns( homalg_matrix ), category ), homalg_matrix, Source( morphism ) );
        
    end );
    
    AddWeakCokernelProjection( category,
      function( morphism )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfRows( UnderlyingMatrix( morphism ) );
        
        return CategoryOfColumnsMorphism( Range( morphism ), homalg_matrix, CategoryOfColumnsObject( NrRows( homalg_matrix ), category ) );
        
    end );
    
    ##
    AddProjectionOfBiasedWeakFiberProduct( category,
      function( morphism_1, morphism_2 )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfColumns( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) );
        
        return CategoryOfColumnsMorphism( CategoryOfColumnsObject( NrColumns( homalg_matrix ), category ), homalg_matrix, Source( morphism_1 ) );
        
    end );
    
    ##
    AddIsLiftable( category,
      function( alpha, beta )
        
        return IsZero( DecideZeroColumns( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
        
    end );
    
    ##
    AddLift( category,
      function( alpha, beta )
        local left_divide;
        
        left_divide := LeftDivide( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) );
        
        if left_divide = fail then
          
          return fail;
          
        fi;
        
        return CategoryOfColumnsMorphism( Source( alpha ), left_divide, Source( beta ) );
        
    end );
    
    ##
    AddInjectionOfBiasedWeakPushout( category,
        function( morphism_1, morphism_2 )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfRows( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) );
        
        return CategoryOfColumnsMorphism( Range( morphism_1 ), homalg_matrix, CategoryOfColumnsObject( NrRows( homalg_matrix ), category ) );
        
    end );
    
    ##
    AddIsColiftable( category,
      function( alpha, beta )
        
        return IsZero( DecideZeroRows( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
        
    end );
    
    ##
    AddColift( category,
      function( alpha, beta )
        local right_divide;
        
        right_divide := RightDivide( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) );
        
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        return CategoryOfColumnsMorphism( Range( alpha ), right_divide, Range( beta ) );
        
    end );
    
    ## Basic Operation Properties
    ##
    AddIsZeroForObjects( category,
      function( object )
      
        return RankOfObject( object ) = 0;
      
      end );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        ##
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( r, alpha )
            
            return CategoryOfColumnsMorphism( Source( alpha ), r * UnderlyingMatrix( alpha ), Range( alpha ) );
            
        end );
        
        ## Operations related to homomorphism structure
        
        SetRangeCategoryOfHomomorphismStructure( category, category );
        
        ##
        AddHomomorphismStructureOnObjects( category,
          function( object_1, object_2 )
            
            return CategoryOfColumnsObject( RankOfObject( object_1 ) * RankOfObject( object_2 ), category );
            
        end );
        
        ##
        AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
          function( source, alpha, beta, range )
            
            return CategoryOfColumnsMorphism( source,
                                           KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha ) ), UnderlyingMatrix( beta ) ),
                                           range );
            
        end );
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category,
          function( )
            
            return CategoryOfColumnsObject( 1, category );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( category,
          function( alpha )
            local underlying_matrix, nr_columns;
            
            underlying_matrix := UnderlyingMatrix( alpha );
            
            nr_columns := NrColumns( underlying_matrix );
            
            if ( nr_columns = 0 ) or ( NrRows( underlying_matrix ) = 0 ) then
                
                return UniversalMorphismIntoZeroObject( DistinguishedObjectOfHomomorphismStructure( category ) );
                
            elif nr_columns > 1 then
                
                underlying_matrix := Iterated( List( [ 1 .. nr_columns ], i -> CertainColumns( underlying_matrix, [ i ] ) ), UnionOfRows );
                
            fi;
            
            return CategoryOfColumnsMorphism(
                     DistinguishedObjectOfHomomorphismStructure( category ),
                     underlying_matrix,
                     HomomorphismStructureOnObjects( Source( alpha ), Range( alpha ) )
                   );
            
        end );
        
        ##
        AddInterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( A, B, morphism )
            local nr_rows, nr_columns, underlying_matrix;
            
            nr_columns := RankOfObject( A );
            
            nr_rows := RankOfObject( B );
            
            if nr_rows = 0 or nr_columns = 0 then
                
                return ZeroMorphism( A, B );
                
            fi;
            
            underlying_matrix := UnderlyingMatrix( morphism );

            underlying_matrix := Iterated( List( [ 1 .. nr_columns ], i -> CertainRows( underlying_matrix, [ ((i - 1) * nr_rows + 1) .. i * nr_rows ] ) ), UnionOfColumns );
            
            return CategoryOfColumnsMorphism( A, underlying_matrix, B );
            
        end );
        
    fi;
    
    
    ## Operations related to tensor structure
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        ##
        AddTensorProductOnObjects( category,
          function( a, b )
            
            return CategoryOfColumnsObject( category, RankOfObject( a ) * RankOfObject( b ) );
            
        end );
        
        ##
        AddTensorProductOnMorphismsWithGivenTensorProducts( category,
          function( s, alpha, beta, r)
            
            return CategoryOfColumnsMorphism( s,
              KroneckerMat( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ),
            r );
            
        end );
        
        AddTensorUnit( category,
          function()
            
            return CategoryOfColumnsObject( category, 1 );
            
        end );
        
        ##
        AddBraidingWithGivenTensorProducts( category,
          function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
          local permutation_matrix, rank, rank_1, rank_2;
          
          rank_1 := RankOfObject( object_1 );
          
          rank_2 := RankOfObject( object_2 );
          
          rank := RankOfObject( object_1_tensored_object_2 );
          
          ## mind the inversion of the permutation, since we work with columns
          permutation_matrix := PermutationMat(
                                  PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) )^(-1),
                                  rank
                                );
          
          return CategoryOfColumnsMorphism( object_1_tensored_object_2,
                                            HomalgMatrix( permutation_matrix, rank, rank, ring ),
                                            object_2_tensored_object_1
                                          );
          
        end );
        
        ##
        AddDualOnObjects( category, IdFunc );
        
        ##
        AddDualOnMorphismsWithGivenDuals( category,
          function( dual_source, morphism, dual_range )
            
            return CategoryOfColumnsMorphism( dual_source,
                                              TransposedMatrix( UnderlyingMatrix( morphism ) ),
                                              dual_range );
            
        end );
        
        ##
        AddEvaluationForDualWithGivenTensorProduct( category,
          function( tensor_object, object, unit )
            local rank, id;
            
            rank := RankOfObject( object );
            
            id := HomalgIdentityMatrix( rank, ring );
            
            return CategoryOfColumnsMorphism( tensor_object,
                                              UnionOfColumns( List( [ 1 .. rank ], i -> CertainRows( id, [i] ) ) ),
                                              unit );
            
        end );
        
        ##
        AddCoevaluationForDualWithGivenTensorProduct( category,
          
          function( unit, object, tensor_object )
            local rank, id;
            
            rank := RankOfObject( object );
            
            id := HomalgIdentityMatrix( rank, ring );
            
            return CategoryOfColumnsMorphism( unit,
                                              UnionOfRows( List( [ 1 .. rank ], i -> CertainColumns( id, [i] ) ) ),
                                              tensor_object );
            
        end );
       
        ##
        AddMorphismToBidualWithGivenBidual( category, {obj, dual} -> IdentityMorphism( obj ) );
        
    fi;
    
    
    ## Simplifications
    
    ## Source and Range
    ##
    AddSimplifySourceAndRange( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[1],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Range( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[4],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Range( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[2],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[3],
            Source( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[5],
            Source( alpha )
          );
        
    end );
    
    ## only Source
    ##
    AddSimplifySource( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceTuple( alpha )[1],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySource_IsoToInputObject( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceTuple( alpha )[2],
            Source( alpha )
          );
        
    end );
    
    ##
    AddSimplifySource_IsoFromInputObject( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceTuple( alpha )[3],
            Source( alpha )
          );
        
    end );
    
    ## only Range
    ##
    AddSimplifyRange( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationRangeTuple( alpha )[1],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifyRange_IsoToInputObject( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Range( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationRangeTuple( alpha )[3],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifyRange_IsoFromInputObject( category,
      function( alpha, i )
        
        return
          CategoryOfColumnsMorphism(
            Range( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationRangeTuple( alpha )[2],
            Range( alpha )
          );
        
    end );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsCategoryOfColumnsMorphism ],
               
  function( category_of_columns_morphism )
    
    # source
    Print( "Source: \n" );
    Display( Source( category_of_columns_morphism ) );
    
    # mapping matrix
    Print( Concatenation( "\n\n", "Matrix: \n" ) );
    Display( UnderlyingMatrix( category_of_columns_morphism ) );
    
    # range
    Print( Concatenation( "\n", "Range: \n" ) );
    Display( Range( category_of_columns_morphism ) );
    Print( "\n\n" );
    
    # general information on morphism
    Print( StringMutable( category_of_columns_morphism ) );
    
end );

##
InstallMethod( String,
              [ IsCategoryOfColumnsObject ],
              
  function( category_of_columns_object )
    
    return Concatenation( "A column module over ",
                          RingName( UnderlyingRing( CapCategory( category_of_columns_object ) ) ),
                          " of rank ", String( RankOfObject( category_of_columns_object ) ) );
    
end );
##
InstallMethod( ViewObj,
               [ IsCategoryOfColumnsObject ],

  function( category_of_columns_object )

    Print( Concatenation( "<", String( category_of_columns_object ), ">" ) );

end );

##
InstallMethod( Display,
               [ IsCategoryOfColumnsObject ],
               
  function( category_of_columns_object )
    
    Print( String( category_of_columns_object ) );
    
end );
