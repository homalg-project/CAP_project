# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

# read precompiled categories
ReadPackage( "FreydCategoriesForCAP", "gap/precompiled_categories/CategoryOfRows_as_AdditiveClosure_RingAsCategory_Field_precompiled.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/precompiled_categories/CategoryOfRows_as_AdditiveClosure_RingAsCategory_CommutativeRing_precompiled.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/precompiled_categories/CategoryOfRows_as_AdditiveClosure_RingAsCategory_HomalgExteriorRingOverField_precompiled.gi" );
ReadPackage( "FreydCategoriesForCAP", "gap/precompiled_categories/CategoryOfRows_as_AdditiveClosure_RingAsCategory_ArbitraryRing_precompiled.gi" );

####################################
##
## Constructors
##
####################################

##
InstallMethod( CategoryOfRows,
               [ IsHomalgRing ],
               
  function( homalg_ring )
    local cat;
    
    cat := CategoryOfRows_as_AdditiveClosure_RingAsCategory( homalg_ring : FinalizeCategory := false );
    
    # this cache replaces the KeyDependentOperation caching when using ObjectConstructor directly instead of CategoryOfRowsObject
    SetCachingToWeak( cat, "ObjectConstructor" );
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
        if HasIsFieldForHomalg( homalg_ring ) and IsFieldForHomalg( homalg_ring ) then
            
            ADD_FUNCTIONS_FOR_CategoryOfRows_as_AdditiveClosure_RingAsCategory_Field_precompiled( cat );
            
        elif HasIsCommutative( homalg_ring ) and IsCommutative( homalg_ring ) then
            
            ADD_FUNCTIONS_FOR_CategoryOfRows_as_AdditiveClosure_RingAsCategory_CommutativeRing_precompiled( cat );
            
        elif HasIsExteriorRing( homalg_ring ) and IsExteriorRing( homalg_ring ) and IsField( BaseRing( homalg_ring ) ) then
            
            ADD_FUNCTIONS_FOR_CategoryOfRows_as_AdditiveClosure_RingAsCategory_HomalgExteriorRingOverField_precompiled( cat );
            
        else
            
            ADD_FUNCTIONS_FOR_CategoryOfRows_as_AdditiveClosure_RingAsCategory_ArbitraryRing_precompiled( cat );
            
        fi;
        
    fi;
    
    # the folowing properties are not (yet) handled by AdditiveClosure
    if HasIsCommutative( homalg_ring ) and IsCommutative( homalg_ring ) then
        
        SetIsStrictMonoidalCategory( cat, true );
        
        SetIsRigidSymmetricClosedMonoidalCategory( cat, true );
        
        SetIsRigidSymmetricCoclosedMonoidalCategory( cat, true );
        
    fi;
    
    INSTALL_FUNCTIONS_FOR_CATEGORY_OF_ROWS( cat );
    
    Finalize( cat );
    
    return cat;
    
end );

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
    
    if not IsInt( rank ) or rank < 0 then
        
        Error( "the object datum must be a non-negative integer" );
        
    fi;
    
    return CreateCapCategoryObjectWithAttributes( category,
                                                  RankOfObject, rank );
    
end );

##
InstallMethod( AsCategoryOfRowsMorphism,
               [ IsHomalgMatrix, IsCategoryOfRows ],
               
  function( homalg_matrix, category )
    
    return AsCategoryOfRowsMorphism( category, homalg_matrix );
    
end );

##
InstallOtherMethodForCompilerForCAP( AsCategoryOfRowsMorphism,
               [ IsCategoryOfRows, IsHomalgMatrix ],
               
  function( category, homalg_matrix )
    local source, range;
    
    source := CategoryOfRowsObject( category, NrRows( homalg_matrix ) );
    
    range := CategoryOfRowsObject( category, NrColumns( homalg_matrix ) );
    
    return CategoryOfRowsMorphism( category, source, homalg_matrix, range );
    
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
    
    if not IsHomalgMatrix( homalg_matrix ) then
        
        Error( "the morphism datum must be a homalg matrix" );
        
    fi;
    
    if not IsIdenticalObj( HomalgRing( homalg_matrix ), UnderlyingRing( cat ) ) then
        
        Error( "the matrix is defined over a different ring than the category" );
        
    fi;
    
    if NrRows( homalg_matrix ) <> RankOfObject( source ) then
        
        Error( "the number of rows has to be equal to the rank of the source" );
        
    fi;
    
    if NrColumns( homalg_matrix ) <> RankOfObject( range ) then
        
        Error( "the number of columns has to be equal to the rank of the range" );
        
    fi;
    
    return CreateCapCategoryMorphismWithAttributes( cat,
                                                    source,
                                                    range,
                                                    UnderlyingMatrix, homalg_matrix );
    
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

####################################
##
## Global functions
##
####################################

##
InstallGlobalFunction( CATEGORY_OF_ROWS_SimplificationSourceAndRangeTuple,
  
  function( alpha )
    #% CAP_JIT_RESOLVE_FUNCTION
    
    ## [ S, U, V, UI, VI ];
    ## U M V = S
    return SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices( UnderlyingMatrix( alpha ) );
    
end );

##
InstallGlobalFunction( CATEGORY_OF_ROWS_SimplificationSourceTuple,
  
  function( alpha )
    #% CAP_JIT_RESOLVE_FUNCTION
    
    ## [ S, T, TI ];
    ## T M = S
    return SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix( UnderlyingMatrix( alpha ) );
    
end );

##
InstallGlobalFunction( CATEGORY_OF_ROWS_SimplificationRangeTuple,
  
  function( alpha )
    #% CAP_JIT_RESOLVE_FUNCTION
    
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
    
    ## Well-defined for objects and morphisms
    ##
    AddIsWellDefinedForObjects( category,
      function( cat, object )
        
        if not IsInt( RankOfObject( object ) ) then
            
            return false;
            
        elif not (RankOfObject( object ) >= 0) then
            
            return false;
            
        fi;
        
        # all tests passed, so it is well-defined
        return true;
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( cat, morphism )
        
        if not IsHomalgMatrix( UnderlyingMatrix( morphism ) ) then
            
            return false;
            
        elif not (NrRows( UnderlyingMatrix( morphism ) ) = RankOfObject( Source( morphism ) )) then
            
            return false;
            
        elif not (NrColumns( UnderlyingMatrix( morphism ) ) = RankOfObject( Range( morphism ) )) then
            
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
    AddIsEqualForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return UnderlyingMatrix( morphism_1 ) = UnderlyingMatrix( morphism_2 );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( cat, morphism_1, morphism_2 )
        
        return UnderlyingMatrix( morphism_1 ) = UnderlyingMatrix( morphism_2 );
        
    end );
    
    ##
    AddAdditiveGenerators( category,
      function( cat )
        
        return [ CategoryOfRowsObject( cat, BigInt( 1 ) ) ];
        
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
            
          end, [ IsCapCategory, IsCapCategoryMorphism, IsEqualToIdentityMorphism ] ],
        
        [ function( cat, identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsCapCategory, IsEqualToIdentityMorphism, IsCapCategoryMorphism ] ],
        
        [ function( cat, left_morphism, zero_morphism )
            
            return CategoryOfRowsMorphism( cat, Source( left_morphism ),
                                        HomalgZeroMatrix( RankOfObject( Source( left_morphism ) ),
                                        RankOfObject( Range( zero_morphism ) ), ring ),
                                        Range( zero_morphism ) );
          
          end, [ IsCapCategory, IsCapCategoryMorphism, IsZeroForMorphisms ] ],
        
        [ function( cat, zero_morphism, right_morphism )
            
            return CategoryOfRowsMorphism( cat, Source( zero_morphism ),
                                           HomalgZeroMatrix( RankOfObject( Source( zero_morphism ) ),
                                           RankOfObject( Range( right_morphism ) ), ring ),
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
                                       Range( morphism_1 ) );
        
    end );
    
    ##
    AddSumOfMorphisms( category,
      function( cat, source, morphisms, range )
        
        return CategoryOfRowsMorphism( cat, source,
                                       Sum(
                                            List( morphisms, UnderlyingMatrix ),
                                            HomalgZeroMatrix( RankOfObject( source ), RankOfObject( range ), ring )
                                       ),
                                       range );
        
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
      local rank;
      
      rank := Sum( List( object_list, object -> RankOfObject( object ) ) );
      
      return CategoryOfRowsObject( cat, rank );
      
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( cat, direct_sum_source, source_diagram, diagram, range_diagram, direct_sum_range )
        
        return CategoryOfRowsMorphism( cat, direct_sum_source,
                                       DiagMat( ring, List( diagram, mor -> UnderlyingMatrix( mor ) ) ),
                                       direct_sum_range );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( cat, object_list, projection_number, direct_sum_object )
        local dim_pre, dim_post, dim_factor, number_of_objects, projection_in_factor;
        
        number_of_objects := Length( object_list );
        
        dim_pre := Sum( List( object_list{ [ 1 .. projection_number - 1 ] }, c -> RankOfObject( c ) ) );
        
        dim_post := Sum( List( object_list{ [ projection_number + 1 .. number_of_objects ] }, c -> RankOfObject( c ) ) );
        
        dim_factor := RankOfObject( object_list[ projection_number ] );
        
        projection_in_factor := UnionOfRows( HomalgZeroMatrix( dim_pre, dim_factor, ring ),
                                             HomalgIdentityMatrix( dim_factor, ring ),
                                             HomalgZeroMatrix( dim_post, dim_factor, ring )
                                           );
        
        return CategoryOfRowsMorphism( cat, direct_sum_object, projection_in_factor, object_list[ projection_number ] );
        
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
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( cat, object_list, injection_number, coproduct )
        local dim_pre, dim_post, dim_cofactor, number_of_objects, injection_of_cofactor;
        
        number_of_objects := Length( object_list );
        
        dim_pre := Sum( List( object_list{ [ 1 .. injection_number - 1 ] }, c -> RankOfObject( c ) ) );
        
        dim_post := Sum( List( object_list{ [ injection_number + 1 .. number_of_objects ] }, c -> RankOfObject( c ) ) );
        
        dim_cofactor := RankOfObject( object_list[ injection_number ] );
        
        injection_of_cofactor := UnionOfColumns( HomalgZeroMatrix( dim_cofactor, dim_pre ,ring ),
                                                 HomalgIdentityMatrix( dim_cofactor, ring ),
                                                 HomalgZeroMatrix( dim_cofactor, dim_post, ring )
                                               );
        
        return CategoryOfRowsMorphism( cat, object_list[ injection_number ], injection_of_cofactor, coproduct );

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
    AddComponentOfMorphismIntoDirectSum( category,
      function( cat, morphism, summands, nr )
        local ranks, offset, start, stop;
        
        ranks := List( summands, RankOfObject );
        
        offset := Sum( ranks{[ 1 .. nr - 1 ]} );
        
        start := offset + 1;
        stop := offset + ranks[nr];
        
        return CategoryOfRowsMorphism( cat, Source( morphism ),
                                       CertainColumns( UnderlyingMatrix( morphism ), [ start .. stop ] ),
                                       summands[nr] );
        
    end );
    
    ##
    AddComponentOfMorphismFromDirectSum( category,
      function( cat, morphism, summands, nr )
        local ranks, offset, start, stop;
        
        ranks := List( summands, RankOfObject );
        
        offset := Sum( ranks{[ 1 .. nr - 1 ]} );
        
        start := offset + 1;
        stop := offset + ranks[nr];
        
        return CategoryOfRowsMorphism( cat, summands[nr],
                                       CertainRows( UnderlyingMatrix( morphism ), [ start .. stop ] ),
                                       Range( morphism ) );
        
    end );
    
    ## Operations important for Freyd categories
    
    AddWeakKernelEmbedding( category,
      function( cat, morphism )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfRows( UnderlyingMatrix( morphism ) );
        
        return CategoryOfRowsMorphism( cat, CategoryOfRowsObject( cat, NrRows( homalg_matrix ) ), homalg_matrix, Source( morphism ) ); # taking NrRows could be avoided by using a WithGiven version
        
    end );
    
    AddWeakCokernelProjection( category,
      function( cat, morphism )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfColumns( UnderlyingMatrix( morphism ) );
        
        return CategoryOfRowsMorphism( cat, Range( morphism ), homalg_matrix, CategoryOfRowsObject( cat, NrColumns( homalg_matrix ) ) ); # taking NrColumns could be avoided by using a WithGiven version
        
    end );
    
    ##
    AddProjectionOfBiasedWeakFiberProduct( category,
      function( cat, morphism_1, morphism_2 )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfRows( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) );
        
        return CategoryOfRowsMorphism( cat, CategoryOfRowsObject( cat, NrRows( homalg_matrix ) ), homalg_matrix, Source( morphism_1 ) ); # taking NrRows could be avoided by using a WithGiven version
        
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
        
        right_divide := SafeRightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        return CategoryOfRowsMorphism( cat, Source( alpha ), right_divide, Source( beta ) );
        
    end );
    
    ##
    AddLiftAlongMonomorphism( category,
      function( cat, iota, tau )
        local right_divide;
        
        right_divide := UniqueRightDivide( UnderlyingMatrix( tau ), UnderlyingMatrix( iota ) );
        
        return CategoryOfRowsMorphism( cat, Source( tau ), right_divide, Source( iota ) );
        
    end );
    
    ##
    AddInjectionOfBiasedWeakPushout( category,
        function( cat, morphism_1, morphism_2 )
        local homalg_matrix;
        
        homalg_matrix := ReducedSyzygiesOfColumns( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) );
        
        return CategoryOfRowsMorphism( cat, Range( morphism_1 ), homalg_matrix, CategoryOfRowsObject( cat, NrColumns( homalg_matrix ) ) ); # taking NrColumns could be avoided by using a WithGiven version
        
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
        
        left_divide := SafeLeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        return CategoryOfRowsMorphism( cat, Range( alpha ), left_divide, Range( beta ) );
        
    end );
    
    ##
    AddColiftAlongEpimorphism( category,
      function( cat, epsilon, tau )
        local left_divide;
        
        left_divide := UniqueLeftDivide( UnderlyingMatrix( epsilon ), UnderlyingMatrix( tau ) );
        
        return CategoryOfRowsMorphism( cat, Range( epsilon ), left_divide, Range( tau ) );
        
    end );
    
    ## Abelian case
    
    if is_defined_over_field then
      
      ## enough projectives & injectives
      
      ##
      AddSomeProjectiveObject( category, { cat, obj } -> obj );
      
      ##
      AddEpimorphismFromSomeProjectiveObject( category, { cat, obj } -> IdentityMorphism( cat, obj ) );
      
      ##
      AddIsProjective( category, { cat, obj } -> true );
      
      ##
      AddSomeInjectiveObject( category, { cat, obj } -> obj );
      
      ##
      AddMonomorphismIntoSomeInjectiveObject( category, { cat, obj } -> IdentityMorphism( cat, obj ) );
      
      ##
      AddIsInjective( category, { cat, obj } -> true );
      
      ##
      AddKernelObject( category,
        function( cat, morphism )
          
          return CategoryOfRowsObject( cat, RankOfObject( Source( morphism ) ) - RowRankOfMatrix( UnderlyingMatrix( morphism ) ) );
          
      end );
      
      ##
      AddKernelEmbedding( category,
        function( cat, morphism )
          local kernel_emb, kernel_object;
          
          kernel_emb := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
          
          kernel_object := CategoryOfRowsObject( cat, NrRows( kernel_emb ) ); # taking NrRows could be avoided by using a WithGiven version
          
          return CategoryOfRowsMorphism( cat, kernel_object, kernel_emb, Source( morphism ) );
          
      end );
        
      ##
      AddCokernelObject( category,
        function( cat, morphism )
          
          return CategoryOfRowsObject( cat, RankOfObject( Range( morphism ) ) - RowRankOfMatrix( UnderlyingMatrix( morphism ) ) );
          
      end );
      
      ##
      AddCokernelProjection( category,
        function( cat, morphism )
          local cokernel_proj, cokernel_obj;
          
          cokernel_proj := SyzygiesOfColumns( UnderlyingMatrix( morphism ) );
          
          cokernel_obj := CategoryOfRowsObject( cat, NrColumns( cokernel_proj ) ); # taking NrColumns could be avoided by using a WithGiven version
          
          return CategoryOfRowsMorphism( cat, Range( morphism ), cokernel_proj, cokernel_obj );
          
      end );
      
      ##
      AddImageObject( category,
        function( cat, morphism )
          
          return CategoryOfRowsObject( cat, RowRankOfMatrix( UnderlyingMatrix( morphism ) ) );
          
      end );
      
      ##
      AddImageEmbeddingWithGivenImageObject( category,
        function( cat, morphism, image_object )
          local image_emb;
          
          image_emb := BasisOfRows( UnderlyingMatrix( morphism ) );
          
          return CategoryOfRowsMorphism( cat, image_object, image_emb, Range( morphism ) );
          
      end );
        
      ##
      AddCoimageObject( category,
        function( cat, morphism )
          
          return CategoryOfRowsObject( cat, ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) );
          
      end );
      
      ##
      AddCoimageProjectionWithGivenCoimageObject( category,
        function( cat, morphism, coimage_object )
          local coimage_prj;
          
          coimage_prj := BasisOfColumns( UnderlyingMatrix( morphism ) );
          
          return CategoryOfRowsMorphism( cat, Source( morphism ), coimage_prj, coimage_object );
          
      end );
        
      ##
      AddSomeReductionBySplitEpiSummand( category,
        function( cat, alpha )
          
          return MorphismFromZeroObject( cat, CokernelObject( cat, alpha ) );
          
      end );
      
      ##
      AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( category,
        function( cat, alpha )
          
          return CokernelProjection( cat, alpha );
          
      end );
      
      ##
      AddSomeReductionBySplitEpiSummand_MorphismToInputRange( category,
        function( cat, alpha )
          local cok;
          
          cok := CokernelProjection( cat, alpha );
          
          return Lift( cat,
                  IdentityMorphism( cat, Range( cok ) ),
                  cok
          );
          
      end );
      
    else
      
      ##
      AddSomeReductionBySplitEpiSummand( category,
        function( cat, alpha )
          
          return AsCategoryOfRowsMorphism( cat, CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple( alpha )[1] );
          
      end );
      
      ##
      AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( category,
        function( cat, alpha )
          
          return AsCategoryOfRowsMorphism( cat, CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple( alpha )[2] );
          
      end );
      
      ##
      AddSomeReductionBySplitEpiSummand_MorphismToInputRange( category,
        function( cat, alpha )
          
          return AsCategoryOfRowsMorphism( cat, CATEGORY_OF_ROWS_ReductionBySplitEpiSummandTuple( alpha )[3] );
          
      end );
      
    fi;
    
    ## Basic Operation Properties
    ##
    AddIsZeroForObjects( category,
      function( cat, object )
      
        return RankOfObject( object ) = 0;
      
      end );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        Assert( 0, IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( category ) );
        
        Assert( 0, IsIdenticalObj( CommutativeRingOfLinearCategory( category ), ring ) );
        
        ##
        # MultiplyWithElementOfCommutativeRingForMorphisms cannot be typed yet, so it cannot be precompiled yet
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( cat, r, alpha )
            
            return CategoryOfRowsMorphism( cat, Source( alpha ), r * UnderlyingMatrix( alpha ), Range( alpha ) );
            
        end );
        
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
        AddCoefficientsOfMorphism( category,
          function( cat, morphism )
            
            return EntriesOfHomalgMatrix( UnderlyingMatrix( morphism ) );
            
        end );
        
    fi;
    
    if HasIsExteriorRing( ring ) and IsExteriorRing( ring ) and IsField( BaseRing( ring ) ) then
        
        Assert( 0, IsLinearCategoryOverCommutativeRing( category ) );
        
        Assert( 0, IsIdenticalObj( CommutativeRingOfLinearCategory( category ), BaseRing( ring ) ) );
        
        ##
        # MultiplyWithElementOfCommutativeRingForMorphisms cannot be typed yet, so it cannot be precompiled yet
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( cat, r, alpha )
            
            return CategoryOfRowsMorphism( cat, Source( alpha ), (r / ring) * UnderlyingMatrix( alpha ), Range( alpha ) );
            
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
            
            return CategoryOfRowsObject( cat, BigInt( 1 ) );
            
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
                                         HomalgMatrixListList( permutation_matrix, rank, rank, ring ),
                                         object_2_tensored_object_1
                                       );
          
        end );

        ## Operations related to the tensor-hom adjunction
        
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
            
            id := HomalgIdentityMatrix( rank, ring );
            
            return CategoryOfRowsMorphism( cat, tensor_object,
                                           ConvertMatrixToColumn( id ),
                                           unit );
            
        end );
        
        ##
        AddCoevaluationForDualWithGivenTensorProduct( category,
          function( cat, unit, object, tensor_object )
            local rank, id;
            
            rank := RankOfObject( object );
            
            id := HomalgIdentityMatrix( rank, ring );
            
            return CategoryOfRowsMorphism( cat, unit,
                                           ConvertMatrixToRow( id ),
                                           tensor_object );
            
        end );
       
        ##
        AddMorphismToBidualWithGivenBidual( category, { cat, obj, dual } -> IdentityMorphism( cat, obj ) );

        ## Operations related to the cohom-tensor adjunction

        ##
        AddCoDualOnObjects( category, { cat, obj } -> obj );

        ##
        AddCoDualOnMorphismsWithGivenCoDuals( category,
          function( cat, codual_source, morphism, codual_range )
            
            return CategoryOfRowsMorphism( cat, codual_source,
                                           TransposedMatrix( UnderlyingMatrix( morphism ) ),
                                           codual_range );
            
        end );
        
        ##
        AddCoclosedEvaluationForCoDualWithGivenTensorProduct( category,
          function( cat, unit, object, tensor_object )
            local rank, id;
            
            rank := RankOfObject( object );
            
            id := HomalgIdentityMatrix( rank, ring );
            
            return CategoryOfRowsMorphism( cat, unit,
                                           ConvertMatrixToRow( id ),
                                           tensor_object);
            
        end );
        
        ##
        AddCoclosedCoevaluationForCoDualWithGivenTensorProduct( category,
          function( cat, tensor_object, object, unit )
            local rank, id;
            
            rank := RankOfObject( object );
            
            id := HomalgIdentityMatrix( rank, ring );
            
            return CategoryOfRowsMorphism( cat, tensor_object,
                                           ConvertMatrixToColumn( id ),
                                           unit );
            
        end );
       
        ##
        AddMorphismFromCoBidualWithGivenCoBidual( category, { cat, obj, codual } -> IdentityMorphism( cat, obj ) );
        
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
    ## Random Methods
    ##
    AddRandomObjectByList( category,
      function ( category, L )
        
        if IsEmpty( L ) or ForAny( L, IsNegInt ) then
          Error( "the list passed to 'RandomObjectByList' in ", Name( category ), " must be a non-empty list of non-negative integers!\n" );
        fi;
        
        return CategoryOfRowsObject( category, Random( L ) );
        
    end );
    
    ##
    AddRandomObjectByInteger( category,
      function ( category, n )
        
        if IsNegInt( n ) then
          Error( "the integer passed to 'RandomObjectByInteger' in ", Name( category ), " must be a non-negative integer!\n" );
        fi;
        
        return RandomObjectByList( category, [ 0 .. n ] );
        
    end );
    
    ##
    AddRandomMorphismWithFixedSourceAndRangeByList( category,
      function ( category, S, R, L )
        local ring, s, r, mat;
        
        ring := UnderlyingRing( category );
        
        if not ForAll( L, c -> ForAny( [ IsInt, IsHomalgRingElement ], is -> is( c ) ) ) then
          Error( "the list passed to 'RandomMorphismWithFixedSourceAndRangeByList' in ", Name( category ), " must be a list of integers or elements in the underlying ring!\n" );
        fi;
        
        s := RankOfObject( S );
        r := RankOfObject( R );
        
        mat := Sum( L, c -> c * RandomMatrix( s, r, ring ), HomalgZeroMatrix( s, r, ring ) );
        
        return CategoryOfRowsMorphism( category, S, mat, R );
        
    end );
    
    ##
    AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
      function ( category, S, R, n )
        
        return RandomMorphismWithFixedSourceAndRangeByList( category, S, R, [ 1 ] );
        
    end );
    
end );

##
## use ExternalHom & CoefficientsOfMorphism to derive Hom-Structure
##
AddFinalDerivationBundle( "Using BasisOfExternalHom and CoefficientsOfMorphism to equip k-linear categories with a Hom-Structure over the category of k-rows",
                    [
                      [ BasisOfExternalHom, 1 ],
                      [ CoefficientsOfMorphism, 2 ],
                      [ LinearCombinationOfMorphisms, 1 ],
                      [ PreComposeList, 2 ]
                    ],
                    [
                      HomomorphismStructureOnObjects,
                      HomomorphismStructureOnMorphismsWithGivenObjects,
                      DistinguishedObjectOfHomomorphismStructure,
                      InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects,
                      InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
                    ],
[
  DistinguishedObjectOfHomomorphismStructure,
  [ ],
  function ( cat )
    
    return CategoryOfRowsObject( RangeCategoryOfHomomorphismStructure( cat ), BigInt( 1 ) );
    
  end
],
[
  HomomorphismStructureOnObjects,
  [
    [ BasisOfExternalHom, 1 ],
  ],
  function ( cat, a, b )
    
    return CategoryOfRowsObject( RangeCategoryOfHomomorphismStructure( cat ), Length( BasisOfExternalHom( cat, a, b ) ) );
    
  end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  [
    [ BasisOfExternalHom, 1 ],
    [ CoefficientsOfMorphism, 2 ],
    [ PreComposeList, 2 ],
  ],
    
    #            α
    #      a --------> a'     hom_source := H(a',b) -------> hom_range := H(a,b')
    #      |           |
    #  αℓβ |           | ℓ
    #      |           |
    #      v           v
    #      b' <------- b
    #            β
    
  function ( cat, hom_source, alpha, beta, hom_range )
    local basis, m;
    
    basis := BasisOfExternalHom( cat, Range( alpha ), Source( beta ) );
    
    basis := List( basis, ell -> CoefficientsOfMorphism( cat, PreComposeList( cat, Source( alpha ), [ alpha, ell, beta ], Range( beta ) ) ) );
    
    m := HomalgMatrixListList( basis, RankOfObject( hom_source ), RankOfObject( hom_range ), CommutativeRingOfLinearCategory( cat ) );
    
    return CategoryOfRowsMorphism( RangeCategoryOfHomomorphismStructure( cat ), hom_source, m, hom_range );
    
  end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects,
  [
    [ CoefficientsOfMorphism, 1 ],
  ],
  function ( cat, distinguished_object, alpha, r )
    local m;
    
    m := HomalgRowVector( CoefficientsOfMorphism( cat, alpha ), RankOfObject( r ), CommutativeRingOfLinearCategory( cat ) );
    
    return CategoryOfRowsMorphism( RangeCategoryOfHomomorphismStructure( cat ), distinguished_object, m, r );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  [
    [ BasisOfExternalHom, 1 ],
    [ LinearCombinationOfMorphisms, 1 ],
  ],
  function ( cat, a, b, iota )
    local coeffs, basis;
    
    coeffs := EntriesOfHomalgRowVector( UnderlyingMatrix( iota ) );
    
    basis := BasisOfExternalHom( cat, a, b );
    
    return LinearCombinationOfMorphisms( cat, a, coeffs, basis, b );
    
  end
] :
  CategoryFilter :=
    function ( cat )
      
      if not IsCategoryOfRows( cat ) and
         (HasIsEquippedWithHomomorphismStructure and IsEquippedWithHomomorphismStructure)( cat ) and
         HasRangeCategoryOfHomomorphismStructure( cat ) and
         IsCategoryOfRows( RangeCategoryOfHomomorphismStructure( cat ) ) and
         HasIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( cat ) and IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( cat ) and
         HasCommutativeRingOfLinearCategory( cat ) and IsHomalgRing( CommutativeRingOfLinearCategory( cat ) ) then
          
          return true;
        
      fi;
      
      return false;
  end
);

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
InstallMethod( ViewString,
               [ IsCategoryOfRowsObject ],

  function( category_of_rows_object )

    return Concatenation( "<", String( category_of_rows_object ), ">" );

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
    
    return Concatenation( LaTeXOutput( UnderlyingRing( CapCategory( obj ) ) ), "^{1 \\times ", String( RankOfObject( obj ) ), "}" );
    
end );

##
InstallMethod( LaTeXOutput,
               [ IsCategoryOfRowsMorphism ],
               
  function( mor )
    local matrix;
    
    matrix := LaTeXOutput( UnderlyingMatrix( mor ) );
    
    if ValueOption( "OnlyDatum" ) = true then
       
       return Concatenation(
        """{\color{blue}{""",
        matrix,
        """}}"""
      );
      
    else
      
      return Concatenation(
        LaTeXOutput( Source( mor ) ),
        """{\color{blue}{\xrightarrow{""",
        matrix,
        """}}}""",
        LaTeXOutput( Range( mor ) )
      );
      
    fi;
    
end );


####################################
##
## Convenience
##
####################################

##
InstallOtherMethod( \/,
               [ IsHomalgMatrix, IsCategoryOfRows ],
               AsCategoryOfRowsMorphism
);

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
