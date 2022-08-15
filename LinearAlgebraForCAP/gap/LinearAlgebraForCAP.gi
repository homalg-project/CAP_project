# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#

####################################
##
## Constructors
##
####################################

InstallMethod( MatrixCategory,
               [ IsFieldForHomalg ],
               
  function( homalg_field )
    
    return MATRIX_CATEGORY( homalg_field );
    
end );

InstallGlobalFunction( MATRIX_CATEGORY,
  function( homalg_field )
    local category;
    
    category := CreateCapCategory( Concatenation( "Category of matrices over ", RingName( homalg_field ) ) );
    
    category!.category_as_first_argument := true;
    
    category!.supports_empty_limits := true;
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
        ],
        source_and_range_attributes_from_morphism_attribute := rec(
            object_attribute_name := "Dimension",
            morphism_attribute_name := "UnderlyingMatrix",
            source_attribute_getter_name := "NumberRows",
            range_attribute_getter_name := "NumberColumns",
        ),
        category_filter := IsMatrixCategory,
        object_filter := IsVectorSpaceObject,
        morphism_filter := IsVectorSpaceMorphism,
    );
    
    # this cache replaces the KeyDependentOperation caching when using ObjectConstructor directly instead of MatrixCategoryObject
    SetCachingToWeak( category, "ObjectConstructor" );
    
    SetFilterObj( category, IsMatrixCategory );
    
    AddObjectRepresentation( category, IsVectorSpaceObject and HasDimension and HasIsProjective and IsProjective );
    
    AddMorphismRepresentation( category, IsVectorSpaceMorphism and HasUnderlyingMatrix );
    
    category!.field_for_matrix_category := homalg_field;
    
    SetUnderlyingRing( category, homalg_field );
    
    SetIsSkeletalCategory( category, true );
    
    SetIsAbelianCategory( category, true );
    
    SetIsAbelianCategoryWithEnoughProjectives( category, true );
    
    SetIsAbelianCategoryWithEnoughInjectives( category, true );
    
    SetIsRigidSymmetricClosedMonoidalCategory( category, true );
    
    SetIsRigidSymmetricCoclosedMonoidalCategory( category, true );
    
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
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
        ADD_FUNCTIONS_FOR_MatrixCategoryPrecompiled( category );
        
    fi;
    
    Finalize( category );
    
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
    
    ## constructors
    ##
    AddObjectConstructor( category,
      function( cat, dimension )
        
        if not IsInt( dimension ) or dimension < 0 then
            
            Error( "the object datum must be a non-negative integer" );
            
        fi;
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat,
                                                    Dimension, dimension );
        
    end );
    
    ##
    AddObjectDatum( category,
      function( cat, object )
        
        return Dimension( object );
        
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

        if Dimension( object ) < 0 then

          return false;

        fi;

        # all tests passed, so is well-defined
        return true;

    end );

    ##
    AddIsWellDefinedForMorphisms( category,
      function( cat, morphism )

        if NrRows( UnderlyingMatrix( morphism ) ) <> Dimension( Source( morphism ) ) then

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
      function( cat, object_1, object_2 )
      
        return Dimension( object_1 ) = Dimension( object_2 );
      
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
        
        return VectorSpaceMorphism( cat, object, HomalgIdentityMatrix( Dimension( object ), homalg_field ), object );
        
    end );
    
    ##
    AddPreCompose( category,
      
      [ 
        [ function( cat, morphism_1, morphism_2 )
            local composition;
            
            composition := UnderlyingMatrix( morphism_1 ) * UnderlyingMatrix( morphism_2 );
            
            return VectorSpaceMorphism( cat, Source( morphism_1 ), composition, Range( morphism_2 ) );
            
          end, [ ] ],
        
        [ function( cat, left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ IsCapCategory, IsCapCategoryMorphism, IsEqualToIdentityMorphism ] ],
        
        [ function( cat, identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsCapCategory, IsEqualToIdentityMorphism, IsCapCategoryMorphism ] ],
        
        [ function( cat, left_morphism, zero_morphism )
            
            return VectorSpaceMorphism( cat, Source( left_morphism ),
                                        HomalgZeroMatrix( NrRows( UnderlyingMatrix( left_morphism ) ), NrColumns( UnderlyingMatrix( zero_morphism ) ), homalg_field ),
                                        Range( zero_morphism ) );
          
          end, [ IsCapCategory, IsCapCategoryMorphism, IsZeroForMorphisms ] ],
        
        [ function( cat, zero_morphism, right_morphism )
            
            return VectorSpaceMorphism( cat, Source( zero_morphism ),
                                        HomalgZeroMatrix( NrRows( UnderlyingMatrix( zero_morphism ) ), NrColumns( UnderlyingMatrix( right_morphism ) ), homalg_field ),
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
        
        return VectorSpaceMorphism( cat, Source( morphism_1 ),
                                    UnderlyingMatrix( morphism_1 ) + UnderlyingMatrix( morphism_2 ),
                                    Range( morphism_1 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( cat, morphism )
        
        return VectorSpaceMorphism( cat, Source( morphism ),
                                    (-1) * UnderlyingMatrix( morphism ),
                                    Range( morphism ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, source, range )
        
        return VectorSpaceMorphism( cat, source,
                                    HomalgZeroMatrix( Dimension( source ), Dimension( range ), homalg_field ),
                                    range );
        
    end );
    
    ##
    AddZeroObject( category,
      function( cat )
        
        return MatrixCategoryObject( cat, 0 );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( cat, sink, zero_object )
        local morphism;
        
        morphism := VectorSpaceMorphism( cat, sink, HomalgZeroMatrix( Dimension( sink ), 0, homalg_field ), zero_object );
        
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( cat, source, zero_object )
        local morphism;
        
        morphism := VectorSpaceMorphism( cat, zero_object, HomalgZeroMatrix( 0, Dimension( source ), homalg_field ), source );
        
        return morphism;
        
    end );
    
    ##
    AddDirectSum( category,
      function( cat, object_list )
      local dimension;
      
      dimension := Sum( List( object_list, object -> Dimension( object ) ) );
      
      return MatrixCategoryObject( cat, dimension );
      
    end );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( category,
      function( cat, direct_sum_source, source_diagram, diagram, range_diagram, direct_sum_range )
        
        return VectorSpaceMorphism( cat, direct_sum_source,
                                    DiagMat( homalg_field, List( diagram, mor -> UnderlyingMatrix( mor ) ) ),
                                    direct_sum_range );
        
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( cat, object_list, projection_number, direct_sum_object )
        local dim_pre, dim_post, dim_factor, number_of_objects, projection_in_factor;
        
        number_of_objects := Length( object_list );
        
        dim_pre := Sum( List( object_list{ [ 1 .. projection_number - 1 ] }, c -> Dimension( c ) ) );
        
        dim_post := Sum( List( object_list{ [ projection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) ) );
        
        dim_factor := Dimension( object_list[ projection_number ] );
        
        projection_in_factor := UnionOfRows( HomalgZeroMatrix( dim_pre, dim_factor, homalg_field ),
                                             HomalgIdentityMatrix( dim_factor, homalg_field ),
                                             HomalgZeroMatrix( dim_post, dim_factor, homalg_field )
                                           );
        
        return VectorSpaceMorphism( cat, direct_sum_object, projection_in_factor, object_list[ projection_number ] );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, sink, direct_sum )
        local underlying_matrix_of_universal_morphism;
        
        underlying_matrix_of_universal_morphism := UnionOfColumns( homalg_field, Dimension( test_object ), List( sink, s -> UnderlyingMatrix( s ) ) );

        return VectorSpaceMorphism( cat, test_object, underlying_matrix_of_universal_morphism, direct_sum );
      
    end );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( cat, object_list, injection_number, coproduct )
        local dim_pre, dim_post, dim_cofactor, number_of_objects, injection_of_cofactor;
        
        number_of_objects := Length( object_list );
        
        dim_pre := Sum( List( object_list{ [ 1 .. injection_number - 1 ] }, c -> Dimension( c ) ) );
        
        dim_post := Sum( List( object_list{ [ injection_number + 1 .. number_of_objects ] }, c -> Dimension( c ) ) );
        
        dim_cofactor := Dimension( object_list[ injection_number ] );
        
        injection_of_cofactor := UnionOfColumns( HomalgZeroMatrix( dim_cofactor, dim_pre ,homalg_field ),
                                                 HomalgIdentityMatrix( dim_cofactor, homalg_field ),
                                                 HomalgZeroMatrix( dim_cofactor, dim_post, homalg_field )
                                               );
        
        return VectorSpaceMorphism( cat, object_list[ injection_number ], injection_of_cofactor, coproduct );

    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, sink, coproduct )
        local underlying_matrix_of_universal_morphism;
        
        underlying_matrix_of_universal_morphism := UnionOfRows( homalg_field, Dimension( test_object ), List( sink, s -> UnderlyingMatrix( s ) ) );
        
        return VectorSpaceMorphism( cat, coproduct, underlying_matrix_of_universal_morphism, test_object );
        
    end );
    
    ##
    AddComponentOfMorphismIntoDirectSum( category,
      function( cat, morphism, summands, nr )
        local dimensions, start, stop;
        
        dimensions := List( summands, Dimension );
        
        start := Sum( dimensions{[ 1 .. nr-1 ]} ) + 1;
        
        stop := (start - 1) + dimensions[nr];
        
        return VectorSpaceMorphism( cat, Source( morphism ),
                                    CertainColumns( UnderlyingMatrix( morphism ), [ start .. stop ] ),
                                    summands[ nr ] );
        
    end );
    
    ##
    AddComponentOfMorphismFromDirectSum( category,
      function( cat, morphism, summands, nr )
        local dimensions, start, stop;
        
        dimensions := List( summands, Dimension );
        
        start := Sum( dimensions{[ 1 .. nr-1 ]} ) + 1;
        
        stop := (start - 1) + dimensions[nr];
        
        return VectorSpaceMorphism( cat, summands[nr],
                                    CertainRows( UnderlyingMatrix( morphism ), [ start .. stop ] ),
                                    Range( morphism ) );
        
    end );
    
    ##
    AddMorphismBetweenDirectSumsWithGivenDirectSums( category,
      function( cat, S, diagram_S, morphism_matrix, diagram_T, T )
        local underlying_matrix;
        
        underlying_matrix := List( morphism_matrix, row -> List( row, UnderlyingMatrix ) );
        
        underlying_matrix := ListN( diagram_S, underlying_matrix, { source, row } -> UnionOfColumns( homalg_field, Dimension( source ), row ) );
        
        return VectorSpaceMorphism( cat, S, UnionOfRows( homalg_field, Dimension( T ), underlying_matrix ), T );
        
    end );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
      function( cat, ring_element, morphism )
        
        return VectorSpaceMorphism( cat, Source( morphism ),
                                    ring_element * UnderlyingMatrix( morphism ),
                                    Range( morphism ) );
        
    end );
    
    ## Basic Operations for an Abelian category
    ##
    AddKernelObject( category,
      function( cat, morphism )
        local homalg_matrix;
        
        homalg_matrix := UnderlyingMatrix( morphism );
        
        return MatrixCategoryObject( cat, NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );
        
    end );
    
    ##
    AddKernelEmbedding( category,
      function( cat, morphism )
        local kernel_emb, kernel_object;
        
        kernel_emb := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
        
        kernel_object := MatrixCategoryObject( cat, NrRows( kernel_emb ) );
        
        return VectorSpaceMorphism( cat, kernel_object, kernel_emb, Source( morphism ) );
        
    end );
    
    ##
    AddLift( category,
      function( cat, alpha, beta )
        local right_divide;
        
        right_divide := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        return VectorSpaceMorphism( cat, Source( alpha ),
                                    right_divide,
                                    Source( beta ) );
        
    end );
    
    ##
    AddLiftOrFail( category,
      function( cat, alpha, beta )
        local right_divide;
        
        right_divide := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        return VectorSpaceMorphism( cat, Source( alpha ),
                                    right_divide,
                                    Source( beta ) );
        
    end );
    
    ##
    AddIsLiftable( category,
      function( cat, alpha, beta )
        
        return IsZero( DecideZeroRows( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) ) );
        
    end );
    
    ##
    AddCokernelObject( category,
      function( cat, morphism )
        local homalg_matrix;
        
        homalg_matrix := UnderlyingMatrix( morphism );
        
        return MatrixCategoryObject( cat, NrColumns( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );
        
    end );
    
    ##
    AddCokernelProjection( category,
      function( cat, morphism )
        local cokernel_proj, cokernel_obj;
        
        cokernel_proj := SyzygiesOfColumns( UnderlyingMatrix( morphism ) );
        
        cokernel_obj := MatrixCategoryObject( cat, NrColumns( cokernel_proj ) );
        
        return VectorSpaceMorphism( cat, Range( morphism ), cokernel_proj, cokernel_obj );
        
    end );
    
    ##
    AddColift( category,
      function( cat, alpha, beta )
        local left_divide;
        
        left_divide := LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        return VectorSpaceMorphism( cat, Range( alpha ),
                                    left_divide,
                                    Range( beta ) );
        
    end );
    
    ##
    AddColiftOrFail( category,
      function( cat, alpha, beta )
        local left_divide;
        
        left_divide := LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ) );
        
        if left_divide = fail then
          
          return fail;
          
        fi;
        
        return VectorSpaceMorphism( cat, Range( alpha ),
                                    left_divide,
                                    Range( beta ) );
        
    end );
    
    ##
    AddIsColiftable( category,
      function( cat, alpha, beta )
        
        return IsZero( DecideZeroColumns( UnderlyingMatrix( beta ), UnderlyingMatrix( alpha ) ) );
        
    end );
    
    ## Basic Operation Properties
    ##
    AddIsZeroForObjects( category,
      function( cat, object )
      
        return Dimension( object ) = 0;
      
      end );
    
    ##
    AddIsMonomorphism( category,
      function( cat, morphism )
      
        return RowRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Source( morphism ) );
      
    end );
    
    ##
    AddIsEpimorphism( category,
      function( cat, morphism )
        
        return ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Range( morphism ) );
        
    end );
    
    ##
    AddIsIsomorphism( category,
      function( cat, morphism )
        
        return Dimension( Range( morphism ) ) = Dimension( Source( morphism ) )
               and ColumnRankOfMatrix( UnderlyingMatrix( morphism ) ) = Dimension( Range( morphism ) );
        
    end );
    
    ## Basic Operations for Monoidal Categories
    ##
    AddTensorProductOnObjects( category,
      [ 
        [ function( cat, object_1, object_2 )
            
            return MatrixCategoryObject( cat, Dimension( object_1 ) * Dimension( object_2 ) );
            
          end,
          
          [ ] ],
        
        [ function( cat, object_1, object_2 )
            
            return object_1;
            
          end,
          
          [ IsCapCategory, IsZeroForObjects, IsCapCategoryObject ] ],
         
        [ function( cat, object_1, object_2 )
            
            return object_2;
            
          end,
          
          [ IsCapCategory, IsCapCategoryObject, IsZeroForObjects ] ]
      ]
    
    );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      function( cat, new_source, morphism_1, morphism_2, new_range )
        
        return VectorSpaceMorphism( cat, new_source,
                                    KroneckerMat( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) ),
                                    new_range );
        
    end );
    
    ##
    AddTensorUnit( category,
      function( cat )
        
        return MatrixCategoryObject( cat, 1 );
        
    end );
    
    ##
    AddBraidingWithGivenTensorProducts( category,
      function( cat, object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local permutation_matrix, dim, dim_1, dim_2;
        
        dim_1 := Dimension( object_1 );
        
        dim_2 := Dimension( object_2 );
        
        dim := Dimension( object_1_tensored_object_2 );
        
        permutation_matrix := PermutationMat( 
                                PermList( List( [ 1 .. dim ], i -> ( RemInt( i - 1, dim_2 ) * dim_1 + QuoInt( i - 1, dim_2 ) + 1 ) ) ),
                                dim 
                              );
        
        return VectorSpaceMorphism( cat, object_1_tensored_object_2,
                                    HomalgMatrix( permutation_matrix, dim, dim, homalg_field ),
                                    object_2_tensored_object_1
                                  );
        
    end );

    ## Operations related to the tensor-hom adjunction
    
    ##
    AddDualOnObjects( category, { cat, space } -> space );
    
    ##
    AddDualOnMorphismsWithGivenDuals( category,
      function( cat, dual_source, morphism, dual_range )
        
        return VectorSpaceMorphism( cat, dual_source,
                                    TransposedMatrix( UnderlyingMatrix( morphism ) ),
                                    dual_range );
        
    end );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( category,
      function( cat, tensor_object, object, unit )
        local dimension, id;
        
        dimension := Dimension( object );
        
        id := HomalgIdentityMatrix( dimension, homalg_field );
        
        return VectorSpaceMorphism( cat, tensor_object,
                                    ConvertMatrixToColumn( id ),
                                    unit );
        
    end );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( category,
      function( cat, unit, object, tensor_object )
        local dimension, id;
        
        dimension := Dimension( object );
        
        id := HomalgIdentityMatrix( dimension, homalg_field );
        
        return VectorSpaceMorphism( cat, unit,
                                    ConvertMatrixToRow( id ),
                                    tensor_object );
        
    end );
    
    ##
    AddMorphismToBidualWithGivenBidual( category,
      function( cat, object, bidual_of_object )
        
        return VectorSpaceMorphism( cat, object,
                                    HomalgIdentityMatrix( Dimension( object ), homalg_field ),
                                    bidual_of_object
                                  );
        
    end );

    ## Operations related to the cohom-tensor adjunction

    ##
    AddCoDualOnObjects( category, { cat, obj } -> obj );

    ##
    AddCoDualOnMorphismsWithGivenCoDuals( category,
      function( cat, codual_source, morphism, codual_range )
        
        return VectorSpaceMorphism( cat, codual_source,
                                        TransposedMatrix( UnderlyingMatrix( morphism ) ),
                                        codual_range );
        
    end );
    
    ##
    AddCoclosedEvaluationForCoDualWithGivenTensorProduct( category,
      function( cat, unit, object, tensor_object )
        local rank, id;
        
        rank := Dimension( object );
        
        id := HomalgIdentityMatrix( rank, homalg_field );
        
        return VectorSpaceMorphism( cat, unit,
                                    ConvertMatrixToRow( id ),
                                    tensor_object );
        
    end );
    
    ##
    AddCoclosedCoevaluationForCoDualWithGivenTensorProduct( category,
      function( cat, tensor_object, object, unit )
        local rank, id;
        
        rank := Dimension( object );
        
        id := HomalgIdentityMatrix( rank, homalg_field );
        
        return VectorSpaceMorphism( cat, tensor_object,
                                    ConvertMatrixToColumn( id ),
                                    unit );
        
    end );
    
    ##
    AddMorphismFromCoBidualWithGivenCoBidual( category,
      function( cat, object, cobidual_of_object )
        
        return VectorSpaceMorphism( cat, cobidual_of_object,
                                    HomalgIdentityMatrix( Dimension( object ), homalg_field ),
                                    object );
        
    end );
    
    ## Homomorphism structure
    
    ##
    AddHomomorphismStructureOnObjects( category,
      function( cat, object_1, object_2 )
        
        return MatrixCategoryObject( cat, Dimension( object_1 ) * Dimension( object_2 ) );
        
    end );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
      function( cat, hom_source, alpha, beta, hom_range )
        
        return VectorSpaceMorphism( cat, 
          hom_source,
          KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha ) ), UnderlyingMatrix( beta ) ),
          hom_range
        );
        
    end );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( category,
      function( cat )
        
        return MatrixCategoryObject( cat, 1 );
      
    end );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
      function( cat, alpha )
        local matrix, new_matrix;
        
        matrix := UnderlyingMatrix( alpha );
        
        new_matrix := ConvertMatrixToRow( matrix );
        
        return VectorSpaceMorphism( cat,
          MatrixCategoryObject( cat, 1 ),
          new_matrix,
          MatrixCategoryObject( cat, NrColumns( new_matrix ) )
        );
        
    end );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
      function( cat, source, range, alpha )
        local matrix, m, n, new_matrix;
        
        matrix := UnderlyingMatrix( alpha );
        
        m := Dimension( source );
        
        n := Dimension( range );
        
        new_matrix := ConvertRowToMatrix( matrix, m, n );
        
        return VectorSpaceMorphism( cat,
          source,
          new_matrix,
          range
        );
        
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
    AddBasisOfExternalHom( category,
      function( cat, S, T )
        local s, t, identity, matrices;
        
        s := Dimension( S );
        
        t := Dimension( T );
        
        identity := HomalgIdentityMatrix( s * t, UnderlyingRing( cat ) );
        
        matrices := List( [ 1 .. s * t ], i -> ConvertRowToMatrix( CertainRows( identity, [ i ] ), s, t ) );
        
        return List( matrices, mat -> VectorSpaceMorphism( cat, S, mat, T ) );
        
    end );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( category,
      function( cat, morphism, L )
        
        return EntriesOfHomalgMatrix( UnderlyingMatrix( morphism ) );
        
    end );

end );




