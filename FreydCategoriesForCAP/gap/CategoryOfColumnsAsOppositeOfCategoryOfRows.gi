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
InstallMethod( CategoryOfColumnsAsOppositeOfCategoryOfRows,
               [ IsHomalgRing ],
               
  function( homalg_ring )
    local category_of_rows, op, to_be_finalized;
    
    category_of_rows := CategoryOfRows( homalg_ring : FinalizeCategory := true );
    
    op := Opposite( category_of_rows, Concatenation( "Columns( ", RingName( homalg_ring )," )" ) : FinalizeCategory := false );
    
    ##
    AddObjectConstructor( op, function( cat, underlying_object )
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                    RankOfObject, RankOfObject( underlying_object ) );
        
    end );
    
    ##
    AddObjectDatum( op, function( cat, obj )
      local category_of_rows;
        
        category_of_rows := Opposite( cat );
        
        return CategoryOfRowsObject( category_of_rows, RankOfObject( obj ) );
        
    end );
    
    ##
    AddMorphismConstructor( op, function( cat, source, underlying_morphism, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat,
                source,
                range,
                UnderlyingMatrix, UnderlyingMatrix( underlying_morphism ) );
        
    end );
    
    ##
    AddMorphismDatum( op, function( cat, mor )
      local category_of_rows, matrix_morphism;
        
        category_of_rows := Opposite( cat );
        
        return CategoryOfRowsMorphism( category_of_rows,
            CategoryOfRowsObject( category_of_rows, RankOfObject( Range( mor ) ) ),
            UnderlyingMatrix( mor ),
            CategoryOfRowsObject( category_of_rows, RankOfObject( Source( mor ) ) )
        );
        
    end );
    
    op!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
        ],
        source_and_range_attributes_from_morphism_attribute := rec(
            object_attribute_name := "RankOfObject",
            morphism_attribute_name := "UnderlyingMatrix",
            source_attribute_getter_name := "NrColumns",
            range_attribute_getter_name := "NrRows",
        ),
    );
    
    SetFilterObj( op, IsCategoryOfColumns );
    
    if HasHasInvariantBasisProperty( homalg_ring ) and HasInvariantBasisProperty( homalg_ring ) then
        SetIsSkeletalCategory( op, true );
    fi;
    
    SetIsAdditiveCategory( op, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( op, true );
    
    SetIsStrictMonoidalCategory( op, true );
    
    SetUnderlyingRing( op, homalg_ring );
    
    if HasIsCommutative( homalg_ring ) and IsCommutative( homalg_ring ) then
      
      SetIsLinearCategoryOverCommutativeRing( op, true );
      
      SetCommutativeRingOfLinearCategory( op, homalg_ring );
      
    fi;
    
    if HasIsFieldForHomalg( homalg_ring ) and IsFieldForHomalg( homalg_ring ) then
        
        AddObjectRepresentation( op, IsCategoryOfColumnsObject and HasIsProjective and IsProjective );
        
        SetIsAbelianCategory( op, true );
        
    else
        
        AddObjectRepresentation( op, IsCategoryOfColumnsObject );
        
    fi;
    
    AddMorphismRepresentation( op, IsCategoryOfColumnsMorphism and HasUnderlyingMatrix );
    
    INSTALL_FUNCTIONS_FOR_CATEGORY_OF_COLUMNS_AS_OPPOSITE_OF_CATEGORY_OF_ROWS( op );
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
    
    if to_be_finalized = false then
        
        return op;
        
    fi;
    
    Finalize( op );
    
    return op;
    
end );

####################################
##
## Basic operations
##
####################################


InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_CATEGORY_OF_COLUMNS_AS_OPPOSITE_OF_CATEGORY_OF_ROWS,
  
  function( category )
    local ring, is_defined_over_field;
    
    ring := UnderlyingRing( category );
    
    is_defined_over_field := HasIsFieldForHomalg( ring ) and IsFieldForHomalg( ring );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        ##
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( cat, r, alpha )
            
            return CategoryOfColumnsMorphism( cat, Source( alpha ), r * UnderlyingMatrix( alpha ), Range( alpha ) );
            
        end );
        
        ## Operations related to homomorphism structure
        
        SetRangeCategoryOfHomomorphismStructure( category, category );
        
        ##
        AddHomomorphismStructureOnObjects( category,
          function( cat, object_1, object_2 )
            
            return CategoryOfColumnsObject( cat, RankOfObject( object_1 ) * RankOfObject( object_2 ) );
            
        end );
        
        ##
        AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
          function( cat, source, alpha, beta, range )
            
            return CategoryOfColumnsMorphism( cat, source,
                                           KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha ) ), UnderlyingMatrix( beta ) ),
                                           range );
            
        end );
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category,
          function( cat )
            
            return CategoryOfColumnsObject( cat, 1 );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( cat, alpha )
            local underlying_matrix;
            
            underlying_matrix := UnderlyingMatrix( alpha );
            
            underlying_matrix := ConvertMatrixToColumn( underlying_matrix );
            
            return CategoryOfColumnsMorphism( cat,
                     DistinguishedObjectOfHomomorphismStructure( cat ),
                     underlying_matrix,
                     HomomorphismStructureOnObjects( Source( alpha ), Range( alpha ) )
                   );
            
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( cat, A, B, morphism )
            local nr_rows, nr_columns, underlying_matrix;
            
            nr_columns := RankOfObject( A );
            
            nr_rows := RankOfObject( B );
            
            underlying_matrix := UnderlyingMatrix( morphism );
            
            underlying_matrix := ConvertColumnToMatrix( underlying_matrix, nr_rows, nr_columns );
            
            return CategoryOfColumnsMorphism( cat, A, underlying_matrix, B );
            
        end );
        
    fi;
    
    ## Operations related to tensor structure
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        ##
        AddTensorProductOnObjects( category,
          function( cat, a, b )
            
            return CategoryOfColumnsObject( cat, RankOfObject( a ) * RankOfObject( b ) );
            
        end );
        
        ##
        AddTensorProductOnMorphismsWithGivenTensorProducts( category,
          function( cat, s, alpha, beta, r )
            
            return CategoryOfColumnsMorphism( cat, s,
              KroneckerMat( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ),
            r );
            
        end );
        
        AddTensorUnit( category,
          function( cat )
            
            return CategoryOfColumnsObject( cat, 1 );
            
        end );
        
        ##
        AddBraidingWithGivenTensorProducts( category,
          function( cat, object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
          local permutation_matrix, rank, rank_1, rank_2;
          
          rank_1 := RankOfObject( object_1 );
          
          rank_2 := RankOfObject( object_2 );
          
          rank := RankOfObject( object_1_tensored_object_2 );
          
          ## mind the inversion of the permutation, since we work with columns
          permutation_matrix := PermutationMat(
                                  PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) )^(-1),
                                  rank
                                );
          
          return CategoryOfColumnsMorphism( cat, object_1_tensored_object_2,
                                            HomalgMatrix( permutation_matrix, rank, rank, ring ),
                                            object_2_tensored_object_1
                                          );
          
        end );
        
        ##
        AddDualOnObjects( category, { cat, obj } -> obj );
        
        ##
        AddDualOnMorphismsWithGivenDuals( category,
          function( cat, dual_source, morphism, dual_range )
            
            return CategoryOfColumnsMorphism( cat, dual_source,
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
            
            return CategoryOfColumnsMorphism( cat, tensor_object,
                                              UnionOfColumns( List( [ 1 .. rank ], i -> CertainRows( id, [i] ) ) ),
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
            
            return CategoryOfColumnsMorphism( cat, unit,
                                              UnionOfRows( List( [ 1 .. rank ], i -> CertainColumns( id, [i] ) ) ),
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
          CategoryOfColumnsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[1],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputRange( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Range( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[4],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputRange( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Range( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[2],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoToInputSource( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[3],
            Source( alpha )
          );
        
    end );
    
    ##
    AddSimplifySourceAndRange_IsoFromInputSource( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceAndRangeTuple( alpha )[5],
            Source( alpha )
          );
        
    end );
    
    ## only Source
    ##
    AddSimplifySource( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceTuple( alpha )[1],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifySource_IsoToInputObject( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceTuple( alpha )[2],
            Source( alpha )
          );
        
    end );
    
    ##
    AddSimplifySource_IsoFromInputObject( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationSourceTuple( alpha )[3],
            Source( alpha )
          );
        
    end );
    
    ## only Range
    ##
    AddSimplifyRange( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Source( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationRangeTuple( alpha )[1],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifyRange_IsoToInputObject( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Range( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationRangeTuple( alpha )[3],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSimplifyRange_IsoFromInputObject( category,
      function( cat, alpha, i )
        
        return
          CategoryOfColumnsMorphism( cat,
            Range( alpha ),
            CATEGORY_OF_COLUMNS_SimplificationRangeTuple( alpha )[2],
            Range( alpha )
          );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand( category,
      function( cat, alpha )
        
        return AsCategoryOfColumnsMorphism( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha )[1], category );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( category,
      function( cat, alpha )
        
        return AsCategoryOfColumnsMorphism( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha )[2], category );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( category,
      function( cat, alpha )
        
        return AsCategoryOfColumnsMorphism( CATEGORY_OF_COLUMNS_ReductionBySplitEpiSummandTuple( alpha )[3], category );
        
    end );
    
end );
