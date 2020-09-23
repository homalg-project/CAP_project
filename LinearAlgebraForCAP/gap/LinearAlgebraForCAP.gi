#############################################################################
##
##                                LinearAlgebraForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## Constructors
##
####################################

InstallMethod( MatrixCategory,
               [ IsFieldForHomalg ],
               
  function( homalg_field )
    local category, to_be_finalized;
    
    category := CreateCapCategory( Concatenation( "Category of matrices over ", RingName( homalg_field ) ) );
    
    SetFilterObj( category, IsMatrixCategory );
    
    AddObjectRepresentation( category, IsVectorSpaceObject );
    
    AddMorphismRepresentation( category, IsVectorSpaceMorphism and HasUnderlyingFieldForHomalg and HasUnderlyingMatrix );
    
    category!.field_for_matrix_category := homalg_field;
    
    SetUnderlyingRing( category, homalg_field );
    
    SetIsSkeletalCategory( category, true );
    
    SetIsAbelianCategory( category, true );
    
    SetIsAbelianCategoryWithEnoughProjectives( category, true );
    
    SetIsAbelianCategoryWithEnoughInjectives( category, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( category, true );
    
    SetIsStrictMonoidalCategory( category, true );
    
    SetIsLinearCategoryOverCommutativeRing( category, true );
    
    SetCommutativeRingOfLinearCategory( category, homalg_field );
    
    SetRangeCategoryOfHomomorphismStructure( category, category );
    
    INSTALL_FUNCTIONS_FOR_MATRIX_CATEGORY( category );
    
    ## TODO: Logic for MatrixCategory
    AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "LinearAlgebraForCAP", "LogicForMatrixCategory" ),
        "PredicateImplicationsForMatrixCategory.tex" )
    );
     
    to_be_finalized := ValueOption( "FinalizeCategory" );
   
    if to_be_finalized = false then
      
       return category;
    
    else
    
       Finalize( category );
      
    fi;
    
    return category;
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_MATRIX_CATEGORY,
  
  function( category )
    local homalg_field;
    
    homalg_field := category!.field_for_matrix_category;
    
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

        elif not IsIdenticalObj( UnderlyingFieldForHomalg( object ), category!.field_for_matrix_category ) then

          return false;

        elif Dimension( object ) < 0 then

          return false;

        fi;

        # all tests passed, so is well-defined
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

        elif not IsIdenticalObj( UnderlyingFieldForHomalg( Source( morphism ) ),
                                 category!.field_for_matrix_category ) then

          return false;

        elif not IsIdenticalObj( UnderlyingFieldForHomalg( morphism ),
                                 category!.field_for_matrix_category ) then

          return false;

        elif not IsIdenticalObj( UnderlyingFieldForHomalg( Range( morphism ) ),
                                 category!.field_for_matrix_category ) then

          return false;

        elif NrRows( UnderlyingMatrix( morphism ) ) <> Dimension( Source( morphism ) ) then

          return false;

        elif NrColumns( UnderlyingMatrix( morphism ) ) <> Dimension( Range( morphism ) ) then

          return false;

        fi;

        # all tests passed, so is well-defined
        return true;

    end );
      
    ## Equality Basic Operations for Objects and Morphisms
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
      
        return Dimension( object_1 ) = Dimension( object_2 );
      
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
        
        return VectorSpaceMorphism( object, HomalgIdentityMatrix( Dimension( object ), homalg_field ), object );
        
    end );
    
    ##
    AddPreCompose( category,
      
      [ 
        [ function( morphism_1, morphism_2 )
            local composition;
            
            composition := UnderlyingMatrix( morphism_1 ) * UnderlyingMatrix( morphism_2 );
            
            return VectorSpaceMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );
            
          end, [ , ] ],
        
        [ function( left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ , IsIdenticalToIdentityMorphism ] ],
        
        [ function( identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsIdenticalToIdentityMorphism, ] ],
        
        [ function( left_morphism, zero_morphism )
            
            return VectorSpaceMorphism( Source( left_morphism ),
                                        HomalgZeroMatrix( NrRows( UnderlyingMatrix( left_morphism ) ), NrColumns( UnderlyingMatrix( zero_morphism ) ), homalg_field ),
                                        Range( zero_morphism ) );
          
          end, [ , IsZeroForMorphisms ] ],
        
        [ function( zero_morphism, right_morphism )
            
            return VectorSpaceMorphism( Source( zero_morphism ),
                                        HomalgZeroMatrix( NrRows( UnderlyingMatrix( zero_morphism ) ), NrColumns( UnderlyingMatrix( right_morphism ) ), homalg_field ),
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
        
        return VectorSpaceMorphism( Source( morphism_1 ),
                                    UnderlyingMatrix( morphism_1 ) + UnderlyingMatrix( morphism_2 ),
                                    Range( morphism_2 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return VectorSpaceMorphism( Source( morphism ),
                                    (-1) * UnderlyingMatrix( morphism ),
                                    Range( morphism ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        
        return VectorSpaceMorphism( source,
                                    HomalgZeroMatrix( Dimension( source ), Dimension( range ), homalg_field ),
                                    range );
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return VectorSpaceObject( 0, homalg_field );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local morphism;
        
        morphism := VectorSpaceMorphism( sink, HomalgZeroMatrix( Dimension( sink ), 0, homalg_field ), zero_object );
        
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local morphism;
        
        morphism := VectorSpaceMorphism( zero_object, HomalgZeroMatrix( 0, Dimension( source ), homalg_field ), source );
        
        return morphism;
        
    end );
    
    ##
    AddDirectSum( category,
      function( object_list )
      local dimension;
      
      dimension := Sum( List( object_list, object -> Dimension( object ) ) );
      
      return VectorSpaceObject( dimension, homalg_field );
      
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( direct_sum_source, diagram, direct_sum_range )
        
        return VectorSpaceMorphism( direct_sum_source,
                                    DiagMat( List( diagram, mor -> UnderlyingMatrix( mor ) ) ), 
                                    direct_sum_range );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, projection_number, direct_sum_object )
        local dim_pre, dim_post, dim_factor, number_of_objects, projection_in_factor;
        
        number_of_objects := Length( object_list );
        
        dim_pre := Sum( object_list{ [ 1 .. projection_number - 1 ] }, c -> Dimension( c ) );
        
        dim_post := Sum( object_list{ [ projection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) );
        
        dim_factor := Dimension( object_list[ projection_number ] );
        
        projection_in_factor := UnionOfRows( HomalgZeroMatrix( dim_pre, dim_factor, homalg_field ),
                                             HomalgIdentityMatrix( dim_factor, homalg_field ),
                                             HomalgZeroMatrix( dim_post, dim_factor, homalg_field )
                                           );
        
        return VectorSpaceMorphism( direct_sum_object, projection_in_factor, object_list[ projection_number ] );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local underlying_matrix_of_universal_morphism;
        
        underlying_matrix_of_universal_morphism := UnionOfColumns( List( sink, s -> UnderlyingMatrix( s ) ) );

        return VectorSpaceMorphism( Source( sink[1] ), underlying_matrix_of_universal_morphism, direct_sum );
      
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, injection_number, coproduct )
        local dim_pre, dim_post, dim_cofactor, number_of_objects, injection_of_cofactor;
        
        number_of_objects := Length( object_list );
        
        dim_pre := Sum( object_list{ [ 1 .. injection_number - 1 ] }, c -> Dimension( c ) );
        
        dim_post := Sum( object_list{ [ injection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) );
        
        dim_cofactor := Dimension( object_list[ injection_number ] );
        
        injection_of_cofactor := UnionOfColumns( HomalgZeroMatrix( dim_cofactor, dim_pre ,homalg_field ),
                                                 HomalgIdentityMatrix( dim_cofactor, homalg_field ),
                                                 HomalgZeroMatrix( dim_cofactor, dim_post, homalg_field )
                                               );
        
        return VectorSpaceMorphism( object_list[ injection_number ], injection_of_cofactor, coproduct );

    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, coproduct )
        local underlying_matrix_of_universal_morphism;
        
        underlying_matrix_of_universal_morphism := UnionOfRows( List( sink, s -> UnderlyingMatrix( s ) ) );
        
        return VectorSpaceMorphism( coproduct, underlying_matrix_of_universal_morphism, Range( sink[1] ) );
        
    end );
    
    ##
    AddComponentOfMorphismIntoDirectSum( category,
      function( morphism, summands, nr )
        local start, stop;
        
        start := Sum( List( summands{[ 1 .. nr-1 ]}, Dimension ) ) + 1;
        
        stop := (start - 1) + Dimension( summands[nr] );
        
        return VectorSpaceMorphism( Source( morphism ),
                                    CertainColumns( UnderlyingMatrix( morphism ), [ start .. stop ] ),
                                    summands[ nr ] );
        
    end );
    
    ##
    AddComponentOfMorphismFromDirectSum( category,
      function( morphism, summands, nr )
        local start, stop;
        
        start := Sum( List( summands{[ 1 .. nr-1 ]}, Dimension ) ) + 1;
        
        stop := (start - 1) + Dimension( summands[nr] );
        
        return VectorSpaceMorphism( summands[nr],
                                    CertainRows( UnderlyingMatrix( morphism ), [ start .. stop ] ),
                                    Range( morphism ) );
        
    end );
    
    ##
    AddMorphismBetweenDirectSums( category,
      function( S, morphism_matrix, T )
        local underlying_matrix;
        
        if morphism_matrix = [ ] or morphism_matrix[1] = [ ] then
            return ZeroMorphism( S, T );
        fi;
        
        underlying_matrix := List( morphism_matrix, row -> List( row, UnderlyingMatrix ) );
        
        underlying_matrix := List( underlying_matrix, row -> UnionOfColumns( row ) );
        
        return VectorSpaceMorphism( S, UnionOfRows( underlying_matrix ), T );
        
    end );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
      function( ring_element, morphism )
        
        return VectorSpaceMorphism( Source( morphism ),
                                    ring_element * UnderlyingMatrix( morphism ),
                                    Range( morphism ) );
        
    end );
    
    ## Basic Operations for an Abelian category
    ##
    AddKernelObject( category,
      function( morphism )
        local homalg_matrix;
        
        homalg_matrix := UnderlyingMatrix( morphism );
        
        return VectorSpaceObject( NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ), homalg_field );
        
    end );
    
    ##
    AddKernelEmbedding( category,
      function( morphism )
        local kernel_emb, kernel_object;
        
        kernel_emb := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
        
        kernel_object := VectorSpaceObject( NrRows( kernel_emb ), homalg_field );
        
        return VectorSpaceMorphism( kernel_object, kernel_emb, Source( morphism ) );
        
    end );
    
    ##
    AddLift( category,
      function( alpha, beta )
        local right_divide;
        
        right_divide := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        return VectorSpaceMorphism( Source( alpha ),
                                    right_divide,
                                    Source( beta ) );
        
    end );
    
    ##
    AddCokernelObject( category,
      function( morphism )
        local homalg_matrix;
        
        homalg_matrix := UnderlyingMatrix( morphism );
        
        return VectorSpaceObject( NrColumns( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ), homalg_field );
        
    end );
    
    ##
    AddCokernelProjection( category,
      function( morphism )
        local cokernel_proj, cokernel_obj;
        
        cokernel_proj := SyzygiesOfColumns( UnderlyingMatrix( morphism ) );
        
        cokernel_obj := VectorSpaceObject( NrColumns( cokernel_proj ), homalg_field );
        
        return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel_obj );
        
    end );
    
    ##
    AddColift( category,
      function( alpha, beta )
        local left_divide;
        
        left_divide := LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        if left_divide = fail then
          
          return fail;
          
        fi;
        
        return VectorSpaceMorphism( Range( alpha ),
                                    left_divide,
                                    Range( beta ) );
        
    end );
    
    ## Basic Operation Properties
    ##
    AddIsZeroForObjects( category,
      function( object )
      
        return Dimension( object ) = 0;
      
      end );
    
    ##
    AddIsMonomorphism( category,
      function( morphism )
      
        return RowRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Source( morphism ) );
      
    end );
    
    ##
    AddIsEpimorphism( category,
      function( morphism )
        
        return ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Range( morphism ) );
        
    end );
    
    ##
    AddIsIsomorphism( category,
      function( morphism )
        
        return Dimension( Range( morphism ) ) = Dimension( Source( morphism ) )
               and ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Range( morphism ) );
        
    end );
    
    ## Basic Operations for Monoidal Categories
    ##
    AddTensorProductOnObjects( category,
      [ 
        [ function( object_1, object_2 )
            
            return VectorSpaceObject( Dimension( object_1 ) * Dimension( object_2 ), homalg_field );
            
          end,
          
          [ ] ],
        
        [ function( object_1, object_2 )
            
            return object_1;
            
          end,
          
          [ IsZeroForObjects, ] ],
         
        [ function( object_1, object_2 )
            
            return object_2;
            
          end,
          
          [ , IsZeroForObjects ] ]
      ]
    
    );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        
        return VectorSpaceMorphism( new_source,
                                    KroneckerMat( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) ),
                                    new_range );
        
    end );
    
    ##
    AddTensorUnit( category,
      
      function( )
        
        return VectorSpaceObject( 1, homalg_field );
        
    end );
    
    ##
    AddBraidingWithGivenTensorProducts( category,
      function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local permutation_matrix, dim, dim_1, dim_2;
        
        dim_1 := Dimension( object_1 );
        
        dim_2 := Dimension( object_2 );
        
        dim := Dimension( object_1_tensored_object_2 );
        
        permutation_matrix := PermutationMat( 
                                PermList( List( [ 1 .. dim ], i -> ( RemInt( i - 1, dim_2 ) * dim_1 + QuoInt( i - 1, dim_2 ) + 1 ) ) ),
                                dim 
                              );
        
        return VectorSpaceMorphism( object_1_tensored_object_2,
                                    HomalgMatrix( permutation_matrix, dim, dim, homalg_field ),
                                    object_2_tensored_object_1
                                  );
        
    end );
    
    ##
    AddDualOnObjects( category, space -> space );
    
    ##
    AddDualOnMorphismsWithGivenDuals( category,
      function( dual_source, morphism, dual_range )
        
        return VectorSpaceMorphism( dual_source,
                                    TransposedMatrix( UnderlyingMatrix( morphism ) ),
                                    dual_range );
        
    end );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( category,
      function( tensor_object, object, unit )
        local dimension, column, zero_column, i;
        
        dimension := Dimension( object );
        
        column := [ ];
        
        zero_column := List( [ 1 .. dimension ], i -> 0 );
        
        for i in [ 1 .. dimension - 1 ] do
          
          Add( column, 1 );
          
          Append( column, zero_column );
          
        od;
        
        if dimension > 0 then 
          
          Add( column, 1 );
          
        fi;
        
        return VectorSpaceMorphism( tensor_object,
                                    HomalgMatrix( column, Dimension( tensor_object ), 1, homalg_field ),
                                    unit );
        
    end );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( category,
      
      function( unit, object, tensor_object )
        local dimension, row, zero_row, i;
        
        dimension := Dimension( object );
        
        row := [ ];
        
        zero_row := List( [ 1 .. dimension ], i -> 0 );
        
        for i in [ 1 .. dimension - 1 ] do
          
          Add( row, 1 );
          
          Append( row, zero_row );
          
        od;
        
        if dimension > 0 then 
          
          Add( row, 1 );
          
        fi;
        
        return VectorSpaceMorphism( unit,
                                    HomalgMatrix( row, 1, Dimension( tensor_object ), homalg_field ),
                                    tensor_object );
        
    end );
    
    ##
    AddMorphismToBidualWithGivenBidual( category,
      function( object, bidual_of_object )
        
        return VectorSpaceMorphism( object,
                                    HomalgIdentityMatrix( Dimension( object ), homalg_field ),
                                    bidual_of_object
                                  );
        
    end );
    
    ## Homomorphism structure
    
    ##
    AddHomomorphismStructureOnObjects( category,
      function( object_1, object_2 )
        
        return VectorSpaceObject( Dimension( object_1 ) * Dimension( object_2 ), homalg_field );
        
    end );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
      function( hom_source, alpha, beta, hom_range )
        
        return VectorSpaceMorphism( 
          hom_source,
          KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha ) ), UnderlyingMatrix( beta ) ),
          hom_range
        );
        
    end );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( category,
      function( )
        
        return VectorSpaceObject( 1, homalg_field );
      
    end );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
      function( alpha )
        local matrix, new_matrix;
        
        matrix := UnderlyingMatrix( alpha );
        
        new_matrix := ConvertMatrixToRow( matrix );
        
        return VectorSpaceMorphism(
          VectorSpaceObject( 1, homalg_field ),
          new_matrix,
          VectorSpaceObject( NrColumns( new_matrix ), homalg_field )
        );
        
    end );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
      function( source, range, alpha )
        local matrix, m, n, new_matrix;
        
        matrix := UnderlyingMatrix( alpha );
        
        m := Dimension( source );
        
        n := Dimension( range );
        
        new_matrix := ConvertRowToMatrix( matrix, m, n );
        
        return VectorSpaceMorphism(
          source,
          new_matrix,
          range
        );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand( category,
      function( alpha )
        
        return MorphismFromZeroObject( CokernelObject( alpha ) );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( category,
      function( alpha )
        
        return CokernelProjection( alpha );
        
    end );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( category,
      function( alpha )
        local cok;
        
        cok := CokernelProjection( alpha );
        
        return Lift(
                IdentityMorphism( Range( cok ) ),
                cok
        );
        
    end );
    
    ## enough projectives & injectives
    
    ##
    AddSomeProjectiveObject( category, IdFunc );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( category, IdentityMorphism );
    
    ##
    AddIsProjective( category, ReturnTrue );
    
    ##
    AddSomeInjectiveObject( category, IdFunc );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( category, IdentityMorphism );
    
    ##
    AddIsInjective( category, ReturnTrue );
   
    ##
    AddBasisOfExternalHom( category,
      function( S, T )
        local s, t, identity, matrices;
        
        s := Dimension( S );
        
        t := Dimension( T );
        
        identity := HomalgIdentityMatrix( s * t, UnderlyingFieldForHomalg( S ) );
        
        matrices := List( [ 1 .. s * t ], i -> ConvertRowToMatrix( CertainRows( identity, [ i ] ), s, t ) );
        
        return List( matrices, mat -> VectorSpaceMorphism( S, mat, T ) );
        
    end );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( category,
      function( morphism, L )
        
        return EntriesOfHomalgMatrix( UnderlyingMatrix( morphism ) );
        
    end );

end );




