# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Implementations
#

##
InstallMethod( LeftPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    # Since `FreydCategoriesForCAP` is not deposited, we cannot simply return `LeftPresentations_as_FreydCategory_CategoryOfRows( ring )`
    # but have to construct the category manually.
    
    category := CreateCapCategoryWithDataTypes(
                        Concatenation( "Category of left presentations of ", RingName( ring ) ),
                        IsCategoryOfLeftPresentations,
                        IsLeftPresentation,
                        IsLeftPresentationMorphism,
                        IsCapCategoryTwoCell,
                        fail,
                        fail,
                        fail );
    
    category!.ring_for_representation_category := ring;
    
    SetUnderlyingRing( category, ring );
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
        ],
    );
    
    SetIsAbelianCategory( category, true );
    
    SetIsAbelianCategoryWithEnoughProjectives( category, true );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
      
      SetIsAdditiveMonoidalCategory( category, true );
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
      SetRangeCategoryOfHomomorphismStructure( category, category );
      SetIsEquippedWithHomomorphismStructure( category, true );
      
      SetIsLinearCategoryOverCommutativeRing( category, true );
      
      SetCommutativeRingOfLinearCategory( category, ring );
      
    fi;
    
    if ValueOption( "no_precompiled_code" ) = true then
        
        if IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2021.11-01" ) then
            
            return LeftPresentations_as_FreydCategory_CategoryOfRows( ring );
            
        else
            
            Error( "To get a version of `LeftPresentations` without precompiled code, the package `FreydCategoriesForCAP` is required." );
            
        fi;
        
    else
        
        if HasIsFieldForHomalg( ring ) and IsFieldForHomalg( ring ) then
            
            ADD_FUNCTIONS_FOR_LeftPresentations_as_FreydCategory_CategoryOfRows_Field_precompiled( category );
            
        elif HasIsCommutative( ring ) and IsCommutative( ring ) then
            
            ADD_FUNCTIONS_FOR_LeftPresentations_as_FreydCategory_CategoryOfRows_CommutativeRing_precompiled( category );
            
        else
            
            ADD_FUNCTIONS_FOR_LeftPresentations_as_FreydCategory_CategoryOfRows_ArbitraryRing_precompiled( category );
            
        fi;
        
    fi;
    
    ADD_FUNCTIONS_FOR_LEFT_PRESENTATION( category );
    
    #= comment for Julia
    ## TODO: avoid code duplication (see RightPresentations)
    AddTheoremFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    # =#
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( RightPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    # Since `FreydCategoriesForCAP` is not deposited, we cannot simply return `RightPresentations_as_FreydCategory_CategoryOfColumns( ring )`
    # but have to construct the category manually.
    
    category := CreateCapCategoryWithDataTypes(
                        Concatenation( "Category of right presentations of ", RingName( ring ) ),
                        IsCategoryOfRightPresentations,
                        IsRightPresentation,
                        IsRightPresentationMorphism,
                        IsCapCategoryTwoCell,
                        fail,
                        fail,
                        fail );
    
    category!.ring_for_representation_category := ring;
    
    SetUnderlyingRing( category, ring );
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
        ],
    );
    
    SetIsAbelianCategory( category, true );
    
    SetIsAbelianCategoryWithEnoughProjectives( category, true );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
      
      SetIsAdditiveMonoidalCategory( category, true );
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
      SetRangeCategoryOfHomomorphismStructure( category, category );
      SetIsEquippedWithHomomorphismStructure( category, true );
      
      SetIsLinearCategoryOverCommutativeRing( category, true );
      
      SetCommutativeRingOfLinearCategory( category, ring );
      
    fi;
    
    if ValueOption( "no_precompiled_code" ) = true then
        
        if IsPackageMarkedForLoading( "FreydCategoriesForCAP", ">= 2021.11-01" ) then
            
            return RightPresentations_as_FreydCategory_CategoryOfColumns( ring );
            
        else
            
            Error( "To get a version of `RightPresentations` without precompiled code, the package `FreydCategoriesForCAP` is required." );
            
        fi;
        
    else
        
        if HasIsFieldForHomalg( ring ) and IsFieldForHomalg( ring ) then
            
            ADD_FUNCTIONS_FOR_RightPresentations_as_FreydCategory_CategoryOfColumns_Field_precompiled( category );
            
        elif HasIsCommutative( ring ) and IsCommutative( ring ) then
            
            ADD_FUNCTIONS_FOR_RightPresentations_as_FreydCategory_CategoryOfColumns_CommutativeRing_precompiled( category );
            
        else
            
            ADD_FUNCTIONS_FOR_RightPresentations_as_FreydCategory_CategoryOfColumns_ArbitraryRing_precompiled( category );
            
        fi;
        
    fi;
    
    ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION( category );
    
    #= comment for Julia
    ## TODO: avoid code duplication (see LeftPresentations)
    AddTheoremFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    # =#
    
    Finalize( category );
    
    return category;
    
end );

######################################
##
## Tech stuff
##
######################################

##############################################
##
## LEFT
##
##############################################

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_LEFT_PRESENTATION,
                       
  function( category )
    
    # special, lazy installation
    ADD_KERNEL_LEFT( category );
    
    # IsWellDefined* should not be compiled
    ADD_IS_WELL_DEFINED_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_MORPHISM_LEFT( category );
    
    if HasIsCommutative( category!.ring_for_representation_category ) and IsCommutative( category!.ring_for_representation_category ) then
      
      # differs from the compiled version
      ADD_LIFT_AND_COLIFT_LEFT( category );
      
      # this tensor structure slightly differs from the tensor structure of FreydCategory
      ADD_ASSOCIATOR_LEFT( category );
      
      ADD_UNITOR( category );
      
      ADD_TENSOR_PRODUCT_ON_OBJECTS_LEFT( category );
      
      ADD_TENSOR_PRODUCT_ON_MORPHISMS( category );
      
      ADD_TENSOR_UNIT_LEFT( category );
      
      ADD_INTERNAL_HOM_ON_OBJECTS_LEFT( category );
      
      ADD_INTERNAL_HOM_ON_MORPHISMS_LEFT( category );
      
      ADD_BRAIDING_LEFT( category );
      
      ADD_EVALUATION_MORPHISM_LEFT( category );
      
      ADD_COEVALUATION_MORPHISM_LEFT( category );
      
    fi;
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION,
                       
  function( category )
    
    ADD_KERNEL_RIGHT( category );
    
    ADD_IS_WELL_DEFINED_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT( category );
    
    if HasIsCommutative( category!.ring_for_representation_category ) and IsCommutative( category!.ring_for_representation_category ) then
      
      ADD_LIFT_AND_COLIFT_RIGHT( category );
      
      ADD_ASSOCIATOR_RIGHT( category );
      
      ADD_UNITOR( category );
      
      ADD_TENSOR_PRODUCT_ON_OBJECTS_RIGHT( category );
      
      ADD_TENSOR_PRODUCT_ON_MORPHISMS( category );
      
      ADD_TENSOR_UNIT_RIGHT( category );
      
      ADD_INTERNAL_HOM_ON_OBJECTS_RIGHT( category );
      
      ADD_INTERNAL_HOM_ON_MORPHISMS_RIGHT( category );
      
      ADD_BRAIDING_RIGHT( category );
      
      ADD_EVALUATION_MORPHISM_RIGHT( category );
      
      ADD_COEVALUATION_MORPHISM_RIGHT( category );
      
    fi;
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_OBJECTS,
                       
  function( category )
    
    AddIsWellDefinedForObjects( category,
      
      function( cat, object )
        
        return IsHomalgMatrix( UnderlyingMatrix( object ) ) and IsHomalgRing( UnderlyingHomalgRing( object ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_MORPHISM_LEFT,
                       
  function( category )
    
    AddIsWellDefinedForMorphisms( category,
      
      function( cat, morphism )
        local source_matrix, range_matrix, morphism_matrix;
        
        source_matrix := UnderlyingMatrix( Source( morphism ) );
        
        range_matrix := UnderlyingMatrix( Range( morphism ) );
        
        morphism_matrix := UnderlyingMatrix( morphism );
        
        if not ( NrColumns( source_matrix ) = NrRows( morphism_matrix ) and
                 NrColumns( morphism_matrix ) = NrColumns( range_matrix ) ) then
          
          return false;
          
        fi;
        
        if not IsZero( DecideZeroRows( source_matrix * morphism_matrix, range_matrix ) ) then
          
          return false;
          
        fi;
        
        return true;
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT,
                       
  function( category )
    
    AddIsWellDefinedForMorphisms( category,
      
      function( cat, morphism )
        
        local source_matrix, range_matrix, morphism_matrix;
        
        source_matrix := UnderlyingMatrix( Source( morphism ) );
        
        range_matrix := UnderlyingMatrix( Range( morphism ) );
        
        morphism_matrix := UnderlyingMatrix( morphism );
        
        if not ( NrRows( source_matrix ) = NrColumns( morphism_matrix ) and
                 NrRows( morphism_matrix ) = NrRows( range_matrix ) ) then
          
          return false;
          
        fi;
        
        if not IsZero( DecideZeroColumns( morphism_matrix * source_matrix, range_matrix ) ) then
          
          return false;
          
        fi;
        
        return true;
        
    end );
    
end );

##
InstallGlobalFunction( ADD_KERNEL_LEFT,
                       
  function( category )
    
    AddKernelEmbedding( category,
      
      function( cat, morphism )
        local kernel_mat, embedding;
        
        embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        kernel_mat := SyzygiesOfRows( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        return PresentationMorphism( cat, AsLeftPresentation( cat, kernel_mat ), embedding, Source( morphism ) );
        
    end );
    
    AddKernelEmbeddingWithGivenKernelObject( category,
      
      function( cat, morphism, kernel )
        local embedding;
        
        embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        return PresentationMorphism( cat, kernel, embedding, Source( morphism ) );
        
    end );
    
    AddLiftAlongMonomorphism( category,
      
      function( cat, beta, alpha )
        local lift;
        
        lift := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ), UnderlyingMatrix( Range( beta ) ) );
        
        return PresentationMorphism( cat, Source( alpha ), lift, Source( beta ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_KERNEL_RIGHT,
                       
  function( category )
    
    AddKernelEmbedding( category,
      
      function( cat, morphism )
        local kernel_mat, embedding;
        
        embedding := SyzygiesOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        kernel_mat := SyzygiesOfColumns( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        return PresentationMorphism( cat, AsRightPresentation( cat, kernel_mat ), embedding, Source( morphism ) );
        
    end );
    
    AddKernelEmbeddingWithGivenKernelObject( category,
      
      function( cat, morphism, kernel )
        local embedding;
        
        embedding := SyzygiesOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        return PresentationMorphism( cat, kernel, embedding, Source( morphism ) );
        
    end );
    
    AddLiftAlongMonomorphism( category,
      
        ## TODO: Reference for the conventions for Lift
       function( cat, alpha, beta )
#        function( cat, beta, alpha )
        local lift;
        
        lift := LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ), UnderlyingMatrix( Range( alpha ) ) );
        
        return PresentationMorphism( cat, Source( beta ), lift, Source( alpha ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ASSOCIATOR_LEFT,
                      
  function( category )
    local homalg_ring, associator_func;
    
    homalg_ring := category!.ring_for_representation_category;
    
    associator_func := function( cat, source, A, B, C, range )
        
        return PresentationMorphism( cat,
                  source,
                  HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( source ) ), NrColumns( UnderlyingMatrix( range ) ), homalg_ring ),
                  range
               );
        
    end;
    
    AddAssociatorLeftToRightWithGivenTensorProducts( category,
      associator_func
    );
    
    AddAssociatorRightToLeftWithGivenTensorProducts( category,
      associator_func
    );
    
end );

##
InstallGlobalFunction( ADD_ASSOCIATOR_RIGHT,
                      
  function( category )
    local homalg_ring, associator_func;
    
    homalg_ring := category!.ring_for_representation_category;
    
    associator_func := function( cat, source, A, B, C, range )
        
        return PresentationMorphism( cat,
                  source,
                  HomalgIdentityMatrix( NrRows( UnderlyingMatrix( source ) ), NrRows( UnderlyingMatrix( range ) ), homalg_ring ),
                  range
               );
        
    end;
    
    AddAssociatorLeftToRightWithGivenTensorProducts( category,
      associator_func
    );
    
    AddAssociatorRightToLeftWithGivenTensorProducts( category,
      associator_func
    );
    
end );

##
InstallGlobalFunction( ADD_UNITOR,
                      
  function( category )
    local unitor_func;
    
    unitor_func := function( cat, A, B )
        return IdentityMorphism( A );
    end;
    
    AddLeftUnitorWithGivenTensorProduct( category, unitor_func );
    
    AddRightUnitorWithGivenTensorProduct( category, unitor_func );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_OBJECTS_LEFT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorProductOnObjects( category,
      
      function( cat, object_1, object_2 )
        local identity_1, identity_2, presentation_matrix_1, presentation_matrix_2, presentation_matrix;
        
        presentation_matrix_1 := UnderlyingMatrix( object_1 );
        
        presentation_matrix_2 := UnderlyingMatrix( object_2 );
        
        identity_1 := 
          HomalgIdentityMatrix( NrColumns( presentation_matrix_1 ), homalg_ring );
        
        identity_2 := 
          HomalgIdentityMatrix( NrColumns( presentation_matrix_2 ), homalg_ring );
        
        presentation_matrix := UnionOfRows(
                                 KroneckerMat( identity_1, presentation_matrix_2 ),
                                 KroneckerMat( presentation_matrix_1, identity_2 )
                               );
        
        return AsLeftPresentation( cat, presentation_matrix );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_OBJECTS_RIGHT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorProductOnObjects( category,
      
      function( cat, object_1, object_2 )
        local identity_1, identity_2, presentation_matrix_1, presentation_matrix_2, presentation_matrix;
        
        presentation_matrix_1 := UnderlyingMatrix( object_1 );
        
        presentation_matrix_2 := UnderlyingMatrix( object_2 );
        
        identity_1 := 
          HomalgIdentityMatrix( NrRows( presentation_matrix_1 ), homalg_ring );
        
        identity_2 := 
          HomalgIdentityMatrix( NrRows( presentation_matrix_2 ), homalg_ring );
        
        presentation_matrix := UnionOfColumns(
                                 KroneckerMat( identity_1, presentation_matrix_2 ),
                                 KroneckerMat( presentation_matrix_1, identity_2 )
                               );
        
        return AsRightPresentation( cat, presentation_matrix );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_MORPHISMS,
                      
  function( category )
    
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      
      function( cat, new_source, morphism_1, morphism_2, new_range )
        
        return PresentationMorphism( cat, new_source,
                                     KroneckerMat( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) ),
                                     new_range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_UNIT_LEFT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorUnit( category,
      
      function( cat )
        
        return AsLeftPresentation( cat, HomalgZeroMatrix( 0, 1, homalg_ring ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_UNIT_RIGHT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorUnit( category,
      
      function( cat )
        
        return AsRightPresentation( cat, HomalgZeroMatrix( 1, 0, homalg_ring ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_OBJECTS_LEFT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnObjects( category,
      
      function( cat, object_1, object_2 )
        
        return Source( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_1, object_2 ) );
    
    end );
    
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_OBJECTS_RIGHT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnObjects( category,
      
      function( cat, object_1, object_2 )
        
        return Source( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_1, object_2 ) );
    
    end );
    
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_MORPHISMS_LEFT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnMorphismsWithGivenInternalHoms( category,
      
      function( cat, new_source, morphism_1, morphism_2, new_range )
        local internal_hom_embedding_source, internal_hom_embedding_range, morphism_between_tensor_products;
        
        internal_hom_embedding_source := 
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( Range( morphism_1 ), Source( morphism_2 ) );
        
        internal_hom_embedding_range :=
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( Source( morphism_1 ), Range( morphism_2 ) );
        
        morphism_between_tensor_products := 
          PresentationMorphism( cat,
            Range( internal_hom_embedding_source ),
            KroneckerMat( TransposedMatrix( UnderlyingMatrix( morphism_1 ) ), UnderlyingMatrix( morphism_2 ) ),
            Range( internal_hom_embedding_range )
          );
        
        return LiftAlongMonomorphism( internal_hom_embedding_range,
                                 PreCompose( internal_hom_embedding_source, morphism_between_tensor_products ) );
        
    end );

end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_MORPHISMS_RIGHT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnMorphismsWithGivenInternalHoms( category,
      
      function( cat, new_source, morphism_1, morphism_2, new_range )
        local internal_hom_embedding_source, internal_hom_embedding_range, morphism_between_tensor_products;
        
        internal_hom_embedding_source := 
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( Range( morphism_1 ), Source( morphism_2 ) );
        
        internal_hom_embedding_range :=
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( Source( morphism_1 ), Range( morphism_2 ) );
        
        morphism_between_tensor_products := 
          PresentationMorphism( cat,
            Range( internal_hom_embedding_source ),
            KroneckerMat( TransposedMatrix( UnderlyingMatrix( morphism_1 ) ), UnderlyingMatrix( morphism_2 ) ),
            Range( internal_hom_embedding_range )
          );
        
        return LiftAlongMonomorphism( internal_hom_embedding_range,
                                 PreCompose( internal_hom_embedding_source, morphism_between_tensor_products ) );
        
    end );

end );

##
InstallGlobalFunction( ADD_BRAIDING_LEFT,
                      
  function( category )
    
    AddBraidingWithGivenTensorProducts( category,
      
      function( cat, object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local homalg_ring, rank_1, rank_2, rank, permutation_matrix;
        
        homalg_ring := UnderlyingHomalgRing( object_1 );
        
        rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
        
        rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
        
        rank := NrColumns( UnderlyingMatrix( object_1_tensored_object_2 ) );
        
        permutation_matrix := CertainRows( HomalgIdentityMatrix( rank, homalg_ring ),
                                      List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) );
        
        return PresentationMorphism( cat, object_1_tensored_object_2,
                                     permutation_matrix,
                                     object_2_tensored_object_1 );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_BRAIDING_RIGHT,
                      
  function( category )
    
    AddBraidingWithGivenTensorProducts( category,
      
      function( cat, object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local homalg_ring, rank_1, rank_2, rank, permutation_matrix;
        
        homalg_ring := UnderlyingHomalgRing( object_1 );
        
        rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
        
        rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
        
        rank := NrRows( UnderlyingMatrix( object_1_tensored_object_2 ) );
        
        permutation_matrix := CertainColumns( HomalgIdentityMatrix( rank, homalg_ring ),
                                      List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) );
        
        return PresentationMorphism( cat, object_1_tensored_object_2,
                                     permutation_matrix,
                                     object_2_tensored_object_1 );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EVALUATION_MORPHISM_LEFT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddClosedMonoidalLeftEvaluationMorphismWithGivenSource( category,
      
      function( cat, object_1, object_2, internal_hom_tensored_object_1 )
        local internal_hom_embedding, rank_1, morphism, free_module,
              column, zero_column, i, matrix, rank_2, lifted_evaluation;
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_1, object_2 );
        
        rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
        
        free_module := FreeLeftPresentation( cat, rank_1 );
        
        morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_2 ) );
        
        morphism := TensorProductOnMorphisms( morphism, IdentityMorphism( object_1 ) );
        
        ## Computation of F^{\vee} \otimes F \rightarrow 1
        column := [ ];
        
        zero_column := List( [ 1 .. rank_1 ], i -> 0 );
        
        for i in [ 1 .. rank_1 - 1 ] do
          
          Add( column, 1 );
          
          Append( column, zero_column );
          
        od;
        
        if rank_1 > 0 then
          
          Add( column, 1 );
          
        fi;
        
        matrix := HomalgMatrix( column, rank_1 * rank_1, 1, homalg_ring );
        
        rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
        
        matrix := KroneckerMat( HomalgIdentityMatrix( rank_2, homalg_ring ), matrix );
        
        lifted_evaluation := PresentationMorphism( cat, Range( morphism ), matrix, object_2 );
        
        return PreCompose( morphism, lifted_evaluation );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EVALUATION_MORPHISM_RIGHT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddClosedMonoidalLeftEvaluationMorphismWithGivenSource( category,
      
      function( cat, object_1, object_2, internal_hom_tensored_object_1 )
        local internal_hom_embedding, rank_1, morphism, free_module,
              row, zero_row, i, matrix, rank_2, lifted_evaluation;
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_1, object_2 );
        
        rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
        
        free_module := FreeRightPresentation( cat, rank_1 );
        
        morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_2 ) );
        
        morphism := TensorProductOnMorphisms( morphism, IdentityMorphism( object_1 ) );
        
        ## Construction of F^{\vee} \otimes F \rightarrow 1
        row := [ ];
        
        zero_row := List( [ 1 .. rank_1 ], i -> 0 );
        
        for i in [ 1 .. rank_1 - 1 ] do
          
          Add( row, 1 );
          
          Append( row, zero_row );
          
        od;
        
        if rank_1 > 0 then
          
          Add( row, 1 );
          
        fi;
        
        matrix := HomalgMatrix( row, 1, rank_1 * rank_1, homalg_ring );
        
        rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
        
        matrix := KroneckerMat( HomalgIdentityMatrix( rank_2, homalg_ring ), matrix );
        
        lifted_evaluation := PresentationMorphism( cat, Range( morphism ), matrix, object_2 );
        
        return PreCompose( morphism, lifted_evaluation );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COEVALUATION_MORPHISM_LEFT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddClosedMonoidalLeftCoevaluationMorphismWithGivenRange( category,
      
      function( cat, object_2, object_1, internal_hom )
        local object_1_tensored_object_2, internal_hom_embedding, rank_2, free_module, morphism,
              row, zero_row, i, matrix, rank_1, lifted_coevaluation;
        
        object_1_tensored_object_2 := TensorProductOnObjects( object_1, object_2 );
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_2, object_1_tensored_object_2 );
        
        rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
        
        free_module := FreeLeftPresentation( cat, rank_2 );
        
        morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_1_tensored_object_2 ) );
        
        ## Construction of 1 \rightarrow F \otimes F^{\vee}
        
        row := [ ];
        
        zero_row := List( [ 1 .. rank_2 ], i -> 0 );
        
        for i in [ 1 .. rank_2 - 1 ] do
          
          Add( row, 1 );
          
          Append( row, zero_row );
          
        od;
        
        if rank_2 > 0 then
          
          Add( row, 1 );
          
        fi;
        
        matrix := HomalgMatrix( row, 1, rank_2 * rank_2, homalg_ring );
        
        rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
        
        matrix := KroneckerMat( HomalgIdentityMatrix( rank_1, homalg_ring ), matrix );
        
        lifted_coevaluation := PresentationMorphism( cat, object_1, matrix, Range( morphism ) );
        
        return LiftAlongMonomorphism( morphism, lifted_coevaluation );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COEVALUATION_MORPHISM_RIGHT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddClosedMonoidalLeftCoevaluationMorphismWithGivenRange( category,
      
      function( cat, object_2, object_1, internal_hom )
        local object_1_tensored_object_2, internal_hom_embedding, rank_2, free_module, morphism,
              column, zero_column, i, matrix, rank_1, lifted_coevaluation;
        
        object_1_tensored_object_2 := TensorProductOnObjects( object_1, object_2 );
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_2, object_1_tensored_object_2 );
        
        rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
        
        free_module := FreeRightPresentation( cat, rank_2 );
        
        morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_1_tensored_object_2 ) );
        
        ## Construction of 1 \rightarrow F \otimes F^{\vee}
        
        column := [ ];
        
        zero_column := List( [ 1 .. rank_2 ], i -> 0 );
        
        for i in [ 1 .. rank_2 - 1 ] do
          
          Add( column, 1 );
          
          Append( column, zero_column );
          
        od;
        
        if rank_2 > 0 then
          
          Add( column, 1 );
          
        fi;
        
        matrix := HomalgMatrix( column, rank_2 * rank_2, 1, homalg_ring );
        
        rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
        
        matrix := KroneckerMat( HomalgIdentityMatrix( rank_1, homalg_ring ), matrix );
        
        lifted_coevaluation := PresentationMorphism( cat, object_1, matrix, Range( morphism ) );
        
        return LiftAlongMonomorphism( morphism, lifted_coevaluation );
        
    end );
    
end );

InstallGlobalFunction( ADD_LIFT_AND_COLIFT_LEFT,

  function( category )
  local homalg_ring, lift_via_compiled_linear_system_func, colift_via_compiled_linear_system_func;

  homalg_ring := category!.ring_for_representation_category;
  
  lift_via_compiled_linear_system_func := function( morphism_1, morphism_2 )
    local P, N, M, A, B, B_tr_I, N_tr_I, zero_1, mat1, mat2, I_P, zero_2, M_tr_I, mat, vec_A, vec_zero, vec, v, s;
    #                 rxs
    #                P
    #                |
    #         sxv    | sxn
    #        X      (A)   morphism_1
    #                |
    #                V
    #    uxv    vxn   mxn
    #   M ----(B)--> N
    #
    #     morphism_2
    #
    # We need to solve the system
    #     X*B + Y*N = A
    #     P*X + Z*M = 0
    # the function is supposed to return X as a ( well defined ) morphism from P to M.
    
    P := UnderlyingMatrix( Source( morphism_1 ) );
    
    M := UnderlyingMatrix( Source( morphism_2 ) );
    
    v := NrColumns( M );
    
    s := NrColumns( P );
    
    N := UnderlyingMatrix( Range(  morphism_1 ) );
    
    A := UnderlyingMatrix( morphism_1 );
    
    B := UnderlyingMatrix( morphism_2 );
    
    B_tr_I := KroneckerMat( TransposedMatrix( B ), HomalgIdentityMatrix( NrColumns( P ), homalg_ring ) );
    
    N_tr_I := KroneckerMat( TransposedMatrix( N ), HomalgIdentityMatrix( NrColumns( P ) ,homalg_ring ) );
    
    zero_1  := HomalgZeroMatrix( NrRows( A ) * NrColumns( A ), NrRows( P ) * NrRows( M ), homalg_ring );
    
    mat1 := UnionOfColumns( B_tr_I, N_tr_I, zero_1 );
    
    I_P := KroneckerMat( HomalgIdentityMatrix( NrColumns( M ) ,homalg_ring ), P );
    
    zero_2 := HomalgZeroMatrix( NrRows( P ) * NrColumns( M ), NrRows( A ) * NrRows( N ), homalg_ring );
    
    M_tr_I := KroneckerMat( TransposedMatrix( M ), HomalgIdentityMatrix( NrRows( P ), homalg_ring ) );
    
    mat2 := UnionOfColumns( I_P, zero_2, M_tr_I );
    
    mat := UnionOfRows( mat1, mat2 );
    
    vec_A := ConvertMatrixToColumn( A );
    
    vec_zero := HomalgZeroMatrix( NrRows( P ) * NrColumns( M ), NrColumns( vec_A ), homalg_ring );
    
    vec := UnionOfRows( vec_A, vec_zero );
    
    return [ mat, vec ];
    
  end;
  
  AddLift( category, function( cat, morphism_1, morphism_2 )
    local P, M, v, s, sol, XX;
    
    P := UnderlyingMatrix( Source( morphism_1 ) );
    
    M := UnderlyingMatrix( Source( morphism_2 ) );
    
    v := NrColumns( M );
    
    s := NrColumns( P );
    
    sol := CallFuncList( LeftDivide, lift_via_compiled_linear_system_func( morphism_1, morphism_2 ) );
    
    XX := ConvertColumnToMatrix( CertainRows( sol, [ 1 .. s * v ] ), s, v );
    
    return PresentationMorphism( cat, Source( morphism_1 ), XX, Source( morphism_2 ) );
    
  end );
  
  AddIsLiftable( category, function( cat, morphism_1, morphism_2 )
    
    return IsZero( CallFuncList( DecideZeroColumns, Reversed( lift_via_compiled_linear_system_func( morphism_1, morphism_2 ) ) ) );
    
  end );
  
  colift_via_compiled_linear_system_func := function( morphism_1, morphism_2 )
    local N, M, A, B, I, B_over_M, mat1, mat2, mat, zero_mat, A_over_zero, vec, v, s;
    #                 rxs
    #                I
    #                ꓥ
    #         vxs    | nxs
    #        X      (A)     morphism_2
    #                |
    #                |
    #    uxv    nxv   mxn
    #   M <----(B)-- N
    #
    #     morphism_1
    #
    # We need to solve the system
    #     B*X + Y*I = A
    #     M*X + Z*I = 0
    # the function is supposed to return X as a ( well defined ) morphism from M to I.
    
    I := UnderlyingMatrix( Range( morphism_2 ) );
    
    M := UnderlyingMatrix( Range( morphism_1 ) );
    
    v := NrColumns( M );
    
    s := NrColumns( I );
    
    N := UnderlyingMatrix( Source( morphism_1 ) );
    
    B := UnderlyingMatrix( morphism_1 );
    
    A := UnderlyingMatrix( morphism_2 );
    
    B_over_M := UnionOfRows( B, M );
    
    mat1 := KroneckerMat( HomalgIdentityMatrix( NrColumns( I ), homalg_ring ), B_over_M );
    
    mat2 := KroneckerMat( TransposedMatrix( I ), HomalgIdentityMatrix( NrRows( B ) + NrRows( M ), homalg_ring ) );
    
    mat := UnionOfColumns( mat1, mat2 );
    
    zero_mat := HomalgZeroMatrix( NrRows( M ), NrColumns( I ), homalg_ring );
    
    A_over_zero := UnionOfRows( A, zero_mat );
    
    vec := ConvertMatrixToColumn( A_over_zero );
    
    return [ mat, vec ];
    
  end;
  
  AddColift( category, function( cat, morphism_1, morphism_2 )
    local I, M, v, s, sol, XX;
    
    I := UnderlyingMatrix( Range( morphism_2 ) );
    
    M := UnderlyingMatrix( Range( morphism_1 ) );
    
    v := NrColumns( M );
    
    s := NrColumns( I );
    
    sol := CallFuncList( LeftDivide, colift_via_compiled_linear_system_func( morphism_1, morphism_2 ) );
    
    XX := ConvertColumnToMatrix( CertainRows( sol, [ 1 .. v * s ] ), v, s );
    
    return PresentationMorphism( cat, Range( morphism_1 ), XX, Range( morphism_2 ) );
    
  end, 1000 );
  
  AddIsColiftable( category, function( cat, morphism_1, morphism_2 )
    
    return IsZero( CallFuncList( DecideZeroColumns, Reversed( colift_via_compiled_linear_system_func( morphism_1, morphism_2 ) ) ) );
    
  end, 1000 );
  
end );

##
InstallGlobalFunction( ADD_LIFT_AND_COLIFT_RIGHT,

  function( category )
  local homalg_ring, lift_via_compiled_linear_system_func, colift_via_compiled_linear_system_func;
  
  homalg_ring := category!.ring_for_representation_category;
  
  lift_via_compiled_linear_system_func := function( morphism_1, morphism_2 )
    local Pt, Nt, Mt, At, Bt, B_tr_I, N_tr_I, zero_1,
          mat1, mat2, I_P, zero_2, M_tr_I, mat, vec_A, vec_zero, vec, v, s;
    #                 rxs
    #                P
    #                |
    #         uxr    | mxr
    #        X      (A)
    #                |
    #                V
    #    uxv    mxu   mxn
    #   M ----(B)--> N
    #
    #
    #   We need to solve the system
    #       B*X = A mod N
    #       X*P + M*Y = 0
    #   I.e., looking for X, Y, Z such that
    #       B*X + N*Y = A
    #       X*P + M*Z = 0
    #   which is equivalent to
    #       XX*B^t + YY*N^t = A^t
    #       P^t*XX + ZZ*M^t = 0
    #   which can be solved exactly as Lift in left presentations case.
    #   The function is supposed to return X = XX^t as a ( well defined ) morphism from P to M.
    
    Pt := TransposedMatrix( UnderlyingMatrix( Source( morphism_1 ) ) );
    Mt := TransposedMatrix( UnderlyingMatrix( Source( morphism_2 ) ) );
    
    v := NrColumns( Mt );
    
    s := NrColumns( Pt );
    
    Nt := TransposedMatrix( UnderlyingMatrix( Range(  morphism_1 ) ) );
    
    At := TransposedMatrix( UnderlyingMatrix( morphism_1 ) );
    
    Bt := TransposedMatrix( UnderlyingMatrix( morphism_2 ) );
    
    B_tr_I := KroneckerMat( TransposedMatrix( Bt ), HomalgIdentityMatrix( NrColumns( Pt ), homalg_ring ) );
    
    N_tr_I := KroneckerMat( TransposedMatrix( Nt ), HomalgIdentityMatrix( NrColumns( Pt ), homalg_ring ) );
    
    zero_1  := HomalgZeroMatrix( NrRows( At ) * NrColumns( At ), NrRows( Pt ) * NrRows( Mt ), homalg_ring );
    
    mat1 := UnionOfColumns( B_tr_I, N_tr_I, zero_1 );
    
    I_P := KroneckerMat( HomalgIdentityMatrix( NrColumns( Mt ), homalg_ring ), Pt );
    
    zero_2 := HomalgZeroMatrix( NrRows( Pt ) * NrColumns( Mt ), NrRows( At ) * NrRows( Nt ), homalg_ring );
    
    M_tr_I := KroneckerMat( TransposedMatrix( Mt ), HomalgIdentityMatrix( NrRows( Pt ), homalg_ring ) );
    
    mat2 := UnionOfColumns( I_P, zero_2, M_tr_I );
    
    mat := UnionOfRows( mat1, mat2 );
    
    vec_A := ConvertMatrixToColumn( At );
    
    vec_zero := HomalgZeroMatrix( NrRows( Pt ) * NrColumns( Mt ), NrColumns( vec_A ), homalg_ring );
    
    vec := UnionOfRows( vec_A, vec_zero );
    
    return [ mat, vec ];
    
  end;
  
  AddLift( category, function( cat, morphism_1, morphism_2 )
    local Pt, Mt, v, s, sol, XX_tr;
    
    Pt := TransposedMatrix( UnderlyingMatrix( Source( morphism_1 ) ) );
    Mt := TransposedMatrix( UnderlyingMatrix( Source( morphism_2 ) ) );
    
    v := NrColumns( Mt );
    
    s := NrColumns( Pt );
    
    sol := CallFuncList( LeftDivide, lift_via_compiled_linear_system_func( morphism_1, morphism_2 ) );
    
    XX_tr := ConvertColumnToMatrix( CertainRows( sol, [ 1 .. s * v ] ), s, v );
    
    return PresentationMorphism( cat, Source( morphism_1 ), TransposedMatrix( XX_tr ), Source( morphism_2 ) );
    
  end );
  
  AddIsLiftable( category, function( cat, morphism_1, morphism_2 )
    
    return IsZero( CallFuncList( DecideZeroColumns, Reversed( lift_via_compiled_linear_system_func( morphism_1, morphism_2 ) ) ) );
    
  end );
  
  colift_via_compiled_linear_system_func := function( morphism_1, morphism_2 )
    local Nt, Mt, At, Bt, It, B_over_M, mat1, mat2, mat, zero_mat, A_over_zero, vec, v, s;
    
    It := TransposedMatrix( UnderlyingMatrix( Range( morphism_2 ) ) );
    
    Mt := TransposedMatrix( UnderlyingMatrix( Range( morphism_1 ) ) );
    
    v := NrColumns( Mt );
    
    s := NrColumns( It );
    
    Nt := TransposedMatrix( UnderlyingMatrix( Source( morphism_1 ) ) );
    
    Bt := TransposedMatrix( UnderlyingMatrix( morphism_1 ) );
    
    At := TransposedMatrix( UnderlyingMatrix( morphism_2 ) );
    
    B_over_M := UnionOfRows( Bt, Mt );
    
    mat1 := KroneckerMat( HomalgIdentityMatrix( NrColumns( It ), homalg_ring ), B_over_M );
    
    mat2 := KroneckerMat( TransposedMatrix( It ), HomalgIdentityMatrix( NrRows( Bt ) + NrRows( Mt ), homalg_ring ) );
    
    mat := UnionOfColumns( mat1, mat2 );
    
    zero_mat := HomalgZeroMatrix( NrRows( Mt ), NrColumns( It ), homalg_ring );
    
    A_over_zero := UnionOfRows( At, zero_mat );
    
    vec := ConvertMatrixToColumn( A_over_zero );
    
    return [ mat, vec ];
    
  end;
  
  AddColift( category, function( cat, morphism_1, morphism_2 )
    local It, Mt, v, s, sol, XX_tr;
    
    It := TransposedMatrix( UnderlyingMatrix( Range( morphism_2 ) ) );
    
    Mt := TransposedMatrix( UnderlyingMatrix( Range( morphism_1 ) ) );
    
    v := NrColumns( Mt );
    
    s := NrColumns( It );
    
    sol := CallFuncList( LeftDivide, colift_via_compiled_linear_system_func( morphism_1, morphism_2 ) );
    
    XX_tr := ConvertColumnToMatrix( CertainRows( sol, [ 1 .. v * s ] ), v, s );
    
    return PresentationMorphism( cat, Range( morphism_1 ), TransposedMatrix( XX_tr ), Range( morphism_2 ) );
    
  end, 1000 );
  
  AddIsColiftable( category, function( cat, morphism_1, morphism_2 )
    
    return IsZero( CallFuncList( DecideZeroColumns, Reversed( colift_via_compiled_linear_system_func( morphism_1, morphism_2 ) ) ) );
    
  end, 1000 );
  
end );
