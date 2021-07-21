# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( CategoryOfRows,
               [ IsHomalgRing ],
               
  function( homalg_ring )
    local overhead_option, category, to_be_finalized;
    
    overhead_option := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "overhead", true );
    
    category := CreateCapCategory( Concatenation( "Rows( ", RingName( homalg_ring )," )" ) : overhead := overhead_option );
    
    category!.category_as_first_argument := true;
    
    category!.supports_empty_limits := true;
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
        ],
        source_and_range_attributes_from_morphism_attribute := rec(
            object_attribute_name := "RankOfObject",
            morphism_attribute_name := "UnderlyingMatrix",
            source_attribute_getter_name := "NrRows",
            range_attribute_getter_name := "NrColumns",
        ),
    );
    
    SetFilterObj( category, IsCategoryOfRows );
    
    if HasHasInvariantBasisProperty( homalg_ring ) and HasInvariantBasisProperty( homalg_ring ) then
        SetIsSkeletalCategory( category, true );
    fi;
    
    SetIsAdditiveCategory( category, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( category, true );
    
    SetIsStrictMonoidalCategory( category, true );
    
    SetUnderlyingRing( category, homalg_ring );
    
    if HasIsCommutative( homalg_ring ) and IsCommutative( homalg_ring ) then
      
      SetIsLinearCategoryOverCommutativeRing( category, true );
      
      SetCommutativeRingOfLinearCategory( category, homalg_ring );
      
    fi;
    
    if HasIsFieldForHomalg( homalg_ring ) and IsFieldForHomalg( homalg_ring ) then
        
        AddObjectRepresentation( category, IsCategoryOfRowsObject and HasIsProjective and IsProjective );
        
        SetIsAbelianCategory( category, true );
        
    else
        
        AddObjectRepresentation( category, IsCategoryOfRowsObject );
        
    fi;
    
    AddMorphismRepresentation( category, IsCategoryOfRowsMorphism and HasUnderlyingMatrix );
    
    INSTALL_FUNCTIONS_FOR_CATEGORY_OF_ROWS( category );
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
      
    if to_be_finalized = false then
      
      return category;
    
    fi;
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( CategoryOfRowsAttr,
               [ IsHomalgRing ],
               
  homalg_ring -> CategoryOfRows( homalg_ring )
);

##
InstallOtherMethod( CategoryOfRowsObject,
                    [ IsInt, IsCategoryOfRows ],
               
  function( rank, category )
    
    return CategoryOfRowsObject( category, rank );
    
end );

##
InstallMethodForCompilerForCAP( CategoryOfRowsObjectOp,
                                [ IsCategoryOfRows, IsInt ],
               
  function( category, rank )
    
    return ObjectConstructor( category, rank );
    
end );

##
InstallMethod( AsCategoryOfRowsMorphism,
               [ IsHomalgMatrix, IsCategoryOfRows ],
               
  function( homalg_matrix, category )
    local source, range;
    
    source := CategoryOfRowsObject( category, NrRows( homalg_matrix ) );
    
    range := CategoryOfRowsObject( category, NrColumns( homalg_matrix ) );
    
    return CategoryOfRowsMorphism( source, homalg_matrix, range );
    
end );

##
InstallMethod( CategoryOfRowsMorphism,
               [ IsCategoryOfRowsObject, IsHomalgMatrix, IsCategoryOfRowsObject ],
               
  function( source, homalg_matrix, range )
    
    return CategoryOfRowsMorphism( CapCategory( source ), source, homalg_matrix, range );
    
end );

##
InstallOtherMethodForCompilerForCAP( CategoryOfRowsMorphism,
                                     [ IsCategoryOfRows, IsCategoryOfRowsObject, IsHomalgMatrix, IsCategoryOfRowsObject ],
                                     
  function( cat, source, homalg_matrix, range )
    
    return MorphismConstructor( cat, source, homalg_matrix, range );
    
end );

##
InstallMethod( StandardRowMorphismOp,
               [ IsCategoryOfRowsObject, IsInt ],
               
  function( object, n )
    local category, rank;
    
    rank := RankOfObject( object );
    
    if not n in [ 1 .. rank ] then
      
      return fail;
      
    fi;
    
    category := CapCategory( object );
    
    return CategoryOfRowsMorphism(
      CategoryOfRowsObject( category, 1 ),
      CertainRows( HomalgIdentityMatrix( rank, UnderlyingRing( category ) ), [ n ] ),
      object
    );
    
end );

####################################
##
## Attributes
##
####################################

## "1 round of ByASmallerPresentation"
##
InstallMethod( CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple,
               [ IsCategoryOfRowsMorphism ],
               
  function( alpha )
    local M, rows, R, T, TI, U, UI, S;
    
    M := UnderlyingMatrix( alpha );
    
    rows := CapCategory( alpha );
    
    R := UnderlyingRing( rows );
    
    ## homalg's recipe:
    ## 1) OnLessGenerators
    ## 2) if no improvement in terms of number of generators, then:
    ##  2.1) BasisOfModule
    ##  2.2) OnLessGenerators
    
    T := HomalgVoidMatrix( R );
    
    TI := HomalgVoidMatrix( R );
    
    S := SimplerEquivalentMatrix( M, T, TI, "", "" );
    
    if NrColumns( S ) = RankOfObject( Range( alpha ) ) then
      
      S := BasisOfRowModule( S );
      
      U := HomalgVoidMatrix( R );
    
      UI := HomalgVoidMatrix( R );
      
      S := SimplerEquivalentMatrix( S, U, UI, "", "" );
      
      T := T * U;
      
      TI := UI * TI;
      
    fi;
    
    ## add the following line to homalg's recipe in order to minimize the number of relations
    S := ReducedBasisOfRowModule( S );
    
    return [ S, T, TI ];
    
end );

##
InstallMethod( CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple,
               [ IsCategoryOfRowsMorphism ],
               
  function( alpha )
    
    ## [ S, U, V, UI, VI ];
    ## U M V = S
    return SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( alpha ) );
    
end );

##
InstallMethod( CATEGORY_OF_ROWS_SimplificationSourceTuple,
               [ IsCategoryOfRowsMorphism ],
               
  function( alpha )
    
    ## [ S, T, TI ];
    ## T M = S
    return SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( alpha ) );
    
end );

##
InstallMethod( CATEGORY_OF_ROWS_SimplificationRangeTuple,
               [ IsCategoryOfRowsMorphism ],
               
  function( alpha )
    
    ## [ S, T, TI ];
    ## M T = S
    return SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix( UnderlyingMatrix( alpha ) );
    
end );


####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_CATEGORY_OF_ROWS,
  
  function( category )
    local ring, is_defined_over_field;
    
    ring := UnderlyingRing( category );
    
    is_defined_over_field := HasIsFieldForHomalg( ring ) and IsFieldForHomalg( ring );
    
    ## constructors
    ##
    AddObjectConstructor( category,
      function( cat, rank )
        
        if not IsInt( rank ) or rank < 0 then
            
            Error( "the object datum must be a non-negative integer" );
            
        fi;
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                    RankOfObject, rank );
        
    end );
    
    ##
    AddObjectDatum( category,
      function( cat, object )
        
        return RankOfObject( object );
        
    end );
    
    ##
    AddMorphismConstructor( category,
      function( cat, source, homalg_matrix, range )
        
        if not IsHomalgMatrix( homalg_matrix ) then
            
            Error( "the morphism datum must be a homalg matrix" );
            
        fi;
        
        if not IsIdenticalObj( HomalgRing( homalg_matrix ), UnderlyingRing( cat ) ) then
            
            Error( "the matrix is defined over a different ring than the category" );
            
        fi;
        
        if NrRows( homalg_matrix ) <> ObjectDatum( cat, source ) then
            
            Error( "the number of rows has to be equal to the dimension of the source" );
            
        fi;
        
        if NrColumns( homalg_matrix ) <> ObjectDatum( cat, range ) then
            
            Error( "the number of columns has to be equal to the dimension of the range" );
            
        fi;
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat,
                                               source,
                                               range,
                                               UnderlyingMatrix, homalg_matrix
        );
        
    end );
    
    ##
    AddMorphismDatum( category,
      function( cat, morphism )
        
        return UnderlyingMatrix( morphism );
        
    end );
    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( cat, object )
        
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
      function( cat, morphism )
        
        if not IsIdenticalObj( category, CapCategory( Source( morphism ) ) ) then
          
          return false;
          
        elif not IsIdenticalObj( category, CapCategory( morphism ) ) then
          
          return false;
          
        elif not IsIdenticalObj( category, CapCategory( Range( morphism ) ) ) then
          
          return false;
          
        elif NrRows( UnderlyingMatrix( morphism ) ) <> RankOfObject( Source( morphism ) ) then
          
          return false;
          
        elif NrColumns( UnderlyingMatrix( morphism ) ) <> RankOfObject( Range( morphism ) ) then
          
          return false;
          
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( cat, object_1, object_2 )
      
        return RankOfObject( object_1 ) = RankOfObject( object_2 );
      
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return UnderlyingMatrix( morphism_1 ) = UnderlyingMatrix( morphism_2 );
        
    end );
    
    ## Basic Operations for a Category
    ##
    AddIdentityMorphism( category,
      
      function( cat, object )
        
        return CategoryOfRowsMorphism( cat, object, HomalgIdentityMatrix( RankOfObject( object ), ring ), object );
        
    end );
    
    ##
    AddPreCompose( category,
      
      [
        [ function( cat, morphism_1, morphism_2 )
            local composition;
            
            composition := UnderlyingMatrix( morphism_1 ) * UnderlyingMatrix( morphism_2 );
            
            return CategoryOfRowsMorphism( cat, Source( morphism_1 ), composition, Range( morphism_2 ) );
            
          end, [ ] ],
        
        [ function( cat, left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ IsCapCategory, IsCapCategoryMorphism, IsIdenticalToIdentityMorphism ] ],
        
        [ function( cat, identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsCapCategory, IsIdenticalToIdentityMorphism, IsCapCategoryMorphism ] ],
        
        [ function( cat, left_morphism, zero_morphism )
            
            return CategoryOfRowsMorphism( cat, Source( left_morphism ),
                                        HomalgZeroMatrix( NrRows( UnderlyingMatrix( left_morphism ) ),
                                        NrColumns( UnderlyingMatrix( zero_morphism ) ), ring ),
                                        Range( zero_morphism ) );
          
          end, [ IsCapCategory, IsCapCategoryMorphism, IsZeroForMorphisms ] ],
        
        [ function( cat, zero_morphism, right_morphism )
            
            return CategoryOfRowsMorphism( cat, Source( zero_morphism ),
                                           HomalgZeroMatrix( NrRows( UnderlyingMatrix( zero_morphism ) ),
                                           NrColumns( UnderlyingMatrix( right_morphism ) ), ring ),
                                           Range( right_morphism ) );
          
          end, [ IsCapCategory, IsZeroForMorphisms, IsCapCategoryMorphism ] ],
      ]
    
    );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( cat, morphism )
        
        return IsZero( UnderlyingMatrix( morphism ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return CategoryOfRowsMorphism( cat, Source( morphism_1 ),
                                       UnderlyingMatrix( morphism_1 ) + UnderlyingMatrix( morphism_2 ),
                                       Range( morphism_2 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( cat, morphism )
        
        return CategoryOfRowsMorphism( cat, Source( morphism ),
                                       - UnderlyingMatrix( morphism ),
                                       Range( morphism ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, source, range )
        
        return CategoryOfRowsMorphism( cat, source,
                                       HomalgZeroMatrix( RankOfObject( source ), RankOfObject( range ), ring ),
                                       range );
        
    end );
    
    ##
    AddZeroObject( category,
      function( cat )
        
        return CategoryOfRowsObject( cat, 0 );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( cat, sink, zero_object )
        local morphism;
        
        morphism := CategoryOfRowsMorphism( cat, sink, HomalgZeroMatrix( RankOfObject( sink ), 0, ring ), zero_object );
        
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( cat, source, zero_object )
        local morphism;
        
        morphism := CategoryOfRowsMorphism( cat, zero_object, HomalgZeroMatrix( 0, RankOfObject( source ), ring ), source );
        
        return morphism;
        
    end );
    
    ##
    AddDirectSum( category,
      function( cat, object_list )
      local dimension;
      
      dimension := Sum( List( object_list, object -> RankOfObject( object ) ) );
      
      return CategoryOfRowsObject( cat, dimension );
      
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( cat, direct_sum_source, source_diagram, diagram, range_diagram, direct_sum_range )
        
        return CategoryOfRowsMorphism( cat, direct_sum_source,
                                       DiagMat( ring, List( diagram, mor -> UnderlyingMatrix( mor ) ) ),
                                       direct_sum_range );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, sink, direct_sum )
        local underlying_matrix_of_universal_morphism;
        
        underlying_matrix_of_universal_morphism :=
          UnionOfColumns(
            ring,
            RankOfObject( test_object ),
            List( sink, UnderlyingMatrix )
        );
        
        return CategoryOfRowsMorphism( cat, test_object, underlying_matrix_of_universal_morphism, direct_sum );
      
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, sink, coproduct )
        local underlying_matrix_of_universal_morphism;
        
        underlying_matrix_of_universal_morphism :=
          UnionOfRows(
            ring,
            RankOfObject( test_object ),
            List( sink, UnderlyingMatrix )
        );
        
        return CategoryOfRowsMorphism( cat, coproduct, underlying_matrix_of_universal_morphism, test_object );
        
    end );
    
    ##
    AddMorphismBetweenDirectSumsWithGivenDirectSums( category,
      function( cat, source, source_diagram, morphism_matrix, range_diagram, range )
        local underlying_matrix;
        
        underlying_matrix := List( morphism_matrix, row -> List( row, UnderlyingMatrix ) );
        
        underlying_matrix := List( [ 1 .. Length( underlying_matrix ) ], i -> UnionOfColumns( ring, RankOfObject( source_diagram[i] ), underlying_matrix[i] ) );
        
        return CategoryOfRowsMorphism( cat,
          source,
          UnionOfRows( ring, RankOfObject( range ), underlying_matrix ),
          range );
        
    end );
    
    ## Operations important for Freyd categories
    
    AddWeakKernelEmbedding( category,
      function( cat, morphism )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfRows( UnderlyingMatrix( morphism ) );
        
        return CategoryOfRowsMorphism( cat, CategoryOfRowsObject( cat, NrRows( homalg_matrix ) ), homalg_matrix, Source( morphism ) );
        
    end );
    
    AddWeakCokernelProjection( category,
      function( cat, morphism )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfColumns( UnderlyingMatrix( morphism ) );
        
        return CategoryOfRowsMorphism( cat, Range( morphism ), homalg_matrix, CategoryOfRowsObject( cat, NrColumns( homalg_matrix ) ) );
        
    end );
    
    ##
    AddProjectionOfBiasedWeakFiberProduct( category,
      function( cat, morphism_1, morphism_2 )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfRows( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) );
        
        return CategoryOfRowsMorphism( cat, CategoryOfRowsObject( cat, NrRows( homalg_matrix ) ), homalg_matrix, Source( morphism_1 ) );
        
    end );
    
    ##
    AddIsLiftable( category,
      function( cat, alpha, beta )
        
        return IsZero( DecideZeroRows( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
        
    end );
    
    ##
    AddLift( category,
      function( cat, alpha, beta )
        local right_divide;
        
        right_divide := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        return CategoryOfRowsMorphism( cat, Source( alpha ), right_divide, Source( beta ) );
        
    end );
    
    ##
    AddInjectionOfBiasedWeakPushout( category,
        function( cat, morphism_1, morphism_2 )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfColumns( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) );
        
        return CategoryOfRowsMorphism( cat, Range( morphism_1 ), homalg_matrix, CategoryOfRowsObject( cat, NrColumns( homalg_matrix ) ) );
        
    end );
    
    ##
    AddIsColiftable( category,
      function( cat, alpha, beta )
        
        return IsZero( DecideZeroColumns( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
        
    end );
    
    ##
    AddColift( category,
      function( cat, alpha, beta )
        local left_divide;
        
        left_divide := LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        return CategoryOfRowsMorphism( cat, Range( alpha ), left_divide, Range( beta ) );
        
    end );
    
    ## Abelian case
    
    if is_defined_over_field then
      
      ##
      AddBasisOfExternalHom( category,
        function( cat, S, T )
          local s, t, identity, matrices;
          
          s := RankOfObject( S );
          
          t := RankOfObject( T );
          
          identity := HomalgIdentityMatrix( s * t, UnderlyingRing( cat ) );
          
          matrices := List( [ 1 .. s * t ], i -> ConvertRowToMatrix( CertainRows( identity, [ i ] ), s, t ) );
          
          return List( matrices, mat -> CategoryOfRowsMorphism( cat, S, mat, T ) );
          
      end );
      
      ##
      AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( category,
        function( cat, morphism, L )
          
          return EntriesOfHomalgMatrix( UnderlyingMatrix( morphism ) );
          
      end );
      
      ##
      AddKernelObject( category,
        function( cat, morphism )
          local homalg_matrix;
          
          homalg_matrix := UnderlyingMatrix( morphism );
          
          return CategoryOfRowsObject( cat, NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );
          
      end );
      
      ##
      AddKernelEmbedding( category,
        function( cat, morphism )
          local kernel_emb, kernel_object;
          
          kernel_emb := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
          
          kernel_object := CategoryOfRowsObject( cat, NrRows( kernel_emb ) );
          
          return CategoryOfRowsMorphism( cat, kernel_object, kernel_emb, Source( morphism ) );
          
      end );
        
      ##
      AddCokernelObject( category,
        function( cat, morphism )
          local homalg_matrix;
          
          homalg_matrix := UnderlyingMatrix( morphism );
          
          return CategoryOfRowsObject( cat, NrColumns( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );
          
      end );
      
      ##
      AddCokernelProjection( category,
        function( cat, morphism )
          local cokernel_proj, cokernel_obj;
          
          cokernel_proj := SyzygiesOfColumns( UnderlyingMatrix( morphism ) );
          
          cokernel_obj := CategoryOfRowsObject( cat, NrColumns( cokernel_proj ) );
          
          return CategoryOfRowsMorphism( cat, Range( morphism ), cokernel_proj, cokernel_obj );
          
      end );
      
    fi;
    
    ## Basic Operation Properties
    ##
    AddIsZeroForObjects( category,
      function( cat, object )
      
        return RankOfObject( object ) = 0;
      
      end );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        ##
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( cat, r, alpha )
            
            return CategoryOfRowsMorphism( cat, Source( alpha ), r * UnderlyingMatrix( alpha ), Range( alpha ) );
            
        end );
        
        ## Operations related to homomorphism structure
        
        SetRangeCategoryOfHomomorphismStructure( category, category );
        
        ##
        AddHomomorphismStructureOnObjects( category,
          function( cat, object_1, object_2 )
            
            return CategoryOfRowsObject( cat, RankOfObject( object_1 ) * RankOfObject( object_2 ) );
            
        end );
        
        ##
        AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
          function( cat, source, alpha, beta, range )
            
            return CategoryOfRowsMorphism( cat, source,
                                           KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha ) ), UnderlyingMatrix( beta ) ),
                                           range );
            
        end );
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category,
          function( cat )
            
            return CategoryOfRowsObject( cat, 1 );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( cat, alpha )
            local underlying_matrix;
            
            underlying_matrix := UnderlyingMatrix( alpha );
            
            underlying_matrix := ConvertMatrixToRow( underlying_matrix );
            
            return CategoryOfRowsMorphism( cat,
                     DistinguishedObjectOfHomomorphismStructure( cat ),
                     underlying_matrix,
                     HomomorphismStructureOnObjects( Source( alpha ), Range( alpha ) )
                   );
            
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( cat, A, B, morphism )
            local nr_rows, nr_columns, underlying_matrix;
            
            nr_rows := RankOfObject( A );
            
            nr_columns := RankOfObject( B );
            
            underlying_matrix := UnderlyingMatrix( morphism );
            
            underlying_matrix := ConvertRowToMatrix( underlying_matrix, nr_rows, nr_columns );
            
            return CategoryOfRowsMorphism( cat, A, underlying_matrix, B );
            
        end );
        
    fi;
    
    ## Operations related to tensor structure
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        ##
        AddTensorProductOnObjects( category,
          function( cat, a, b )
            
            return CategoryOfRowsObject( cat, RankOfObject( a ) * RankOfObject( b ) );
            
        end );
        
        ##
        AddTensorProductOnMorphismsWithGivenTensorProducts( category,
          function( cat, s, alpha, beta, r )
            
            return CategoryOfRowsMorphism( cat, s,
              KroneckerMat( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ),
            r );
            
        end );
        
        AddTensorUnit( category,
          function( cat )
            
            return CategoryOfRowsObject( cat, 1 );
            
        end );
        
        ##
        AddBraidingWithGivenTensorProducts( category,
          function( cat, object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
          local permutation_matrix, rank, rank_1, rank_2;
          
          rank_1 := RankOfObject( object_1 );
          
          rank_2 := RankOfObject( object_2 );
          
          rank := RankOfObject( object_1_tensored_object_2 );
          
          permutation_matrix := PermutationMat(
                                  PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) ),
                                  rank
                                );
          
          return CategoryOfRowsMorphism( cat, object_1_tensored_object_2,
                                         HomalgMatrix( permutation_matrix, rank, rank, ring ),
                                         object_2_tensored_object_1
                                       );
          
        end );
        
        ##
        AddDualOnObjects( category, { cat, obj } -> obj );
        
        ##
        AddDualOnMorphismsWithGivenDuals( category,
          function( cat, dual_source, morphism, dual_range )
            
            return CategoryOfRowsMorphism( cat, dual_source,
                                           TransposedMatrix( UnderlyingMatrix( morphism ) ),
                                           dual_range );
            
        end );
        
        ##
        AddEvaluationForDualWithGivenTensorProduct( category,
          function( cat, tensor_object, object, unit )
            local rank, id;
            
            rank := RankOfObject( object );
            
            if rank = 0 then
                
                return ZeroMorphism( tensor_object, unit );
                
            fi;
            
            id := HomalgIdentityMatrix( rank, ring );
            
            return CategoryOfRowsMorphism( cat, tensor_object,
                                           UnionOfRows( List( [ 1 .. rank ], i -> CertainColumns( id, [i] ) ) ),
                                           unit );
            
        end );
        
        ##
        AddCoevaluationForDualWithGivenTensorProduct( category,
          
          function( cat, unit, object, tensor_object )
            local rank, id;
            
            rank := RankOfObject( object );
            
            if rank = 0 then
                
                return ZeroMorphism( unit, tensor_object );
                
            fi;
            
            id := HomalgIdentityMatrix( rank, ring );
            
            return CategoryOfRowsMorphism( cat, unit,
                                           UnionOfColumns( List( [ 1 .. rank ], i -> CertainRows( id, [i] ) ) ),
                                           tensor_object );
            
        end );
       
        ##
        AddMorphismToBidualWithGivenBidual( category, { cat, obj, dual } -> IdentityMorphism( obj ) );
        
    fi; ## commutative case
    
    ## Simplifications
    
    ## Source and Range
    ##
    AddSimplifySourceAndRange( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple( alpha )[1],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Range( alpha ),
            CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple( alpha )[5],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Range( alpha ),
            CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple( alpha )[3],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple( alpha )[2],
            Source( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple( alpha )[4],
            Source( alpha )
          );
        
    end );
    
    ## only Source
    ##
    AddSimplifySource( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_ROWS_SimplificationSourceTuple( alpha )[1],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySource_IsoToInputObject( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_ROWS_SimplificationSourceTuple( alpha )[2],
            Source( alpha )
          );
        
    end );
    
    ##
    AddSimplifySource_IsoFromInputObject( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_ROWS_SimplificationSourceTuple( alpha )[3],
            Source( alpha )
          );
        
    end );
    
    ## only Range
    ##
    AddSimplifyRange( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_ROWS_SimplificationRangeTuple( alpha )[1],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifyRange_IsoToInputObject( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Range( alpha ),
            CATEGORY_OF_ROWS_SimplificationRangeTuple( alpha )[3],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifyRange_IsoFromInputObject( category,
      function( cat, alpha, i )
        
        return
          CategoryOfRowsMorphism( cat,
            Range( alpha ),
            CATEGORY_OF_ROWS_SimplificationRangeTuple( alpha )[2],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand( category,
      function( cat, alpha )
        
        return AsCategoryOfRowsMorphism( CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple( alpha )[1], category );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( category,
      function( cat, alpha )
        
        return AsCategoryOfRowsMorphism( CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple( alpha )[2], category );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( category,
      function( cat, alpha )
        
        return AsCategoryOfRowsMorphism( CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple( alpha )[3], category );
        
    end );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsCategoryOfRowsMorphism ],
               
  function( category_of_rows_morphism )
    
    # source
    Print( "Source: \n" );
    Display( Source( category_of_rows_morphism ) );
    
    # mapping matrix
    Print( Concatenation( "\n", "Matrix: \n" ) );
    Display( UnderlyingMatrix( category_of_rows_morphism ) );
    
    # range
    Print( Concatenation( "\n", "Range: \n" ) );
    Display( Range( category_of_rows_morphism ) );
    Print( "\n" );
    
    # general information on morphism
    Display( StringMutable( category_of_rows_morphism ) );
    
end );

##
InstallMethod( String,
              [ IsCategoryOfRowsObject ],
              
  function( category_of_rows_object )
    
    return Concatenation( "A row module over ",
                          RingName( UnderlyingRing( CapCategory( category_of_rows_object ) ) ),
                          " of rank ", String( RankOfObject( category_of_rows_object ) ) );
    
end );
##
InstallMethod( ViewObj,
               [ IsCategoryOfRowsObject ],

  function( category_of_rows_object )

    Print( Concatenation( "<", String( category_of_rows_object ), ">" ) );

end );

##
InstallMethod( Display,
               [ IsCategoryOfRowsObject ],
               
  function( category_of_rows_object )
    
    Display( String( category_of_rows_object ) );
    
end );

##
InstallMethod( LaTeXOutput,
               [ IsCategoryOfRowsObject ],
               
  function( obj )
    
    return Concatenation( LaTeXStringOp( UnderlyingRing( CapCategory( obj ) ) ), "^{1 \\times ", String( RankOfObject( obj ) ), "}" );
    
end );

##
InstallMethod( LaTeXOutput,
               [ IsCategoryOfRowsMorphism ],
               
  function( mor )
    local matrix;
    
    matrix := LaTeXStringOp( UnderlyingMatrix( mor ) );
    
    if ValueOption( "OnlyDatum" ) = true then
        
        return matrix;
        
    fi;
    
    return Concatenation( LaTeXOutput( Source( mor ) ), matrix, LaTeXOutput( Range( mor ) ) );
    
end );


####################################
##
## Convenience
##
####################################

##
InstallMethod( \/,
               [ IsHomalgMatrix, IsCategoryOfRows ],
               AsCategoryOfRowsMorphism
);

##
InstallMethod( \/,
               [ IsInt, IsCategoryOfRows ],
               CategoryOfRowsObject );

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsCategoryOfRowsObject ],
  function( obj )
    
    return RankOfObject( obj );
    
end );

##
InstallMethod( DownOnlyMorphismData,
               [ IsCategoryOfRowsMorphism ],
  function( mor )
    
    return UnderlyingMatrix( mor );
    
end );
