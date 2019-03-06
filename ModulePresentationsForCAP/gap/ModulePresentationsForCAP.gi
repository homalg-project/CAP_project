#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

##
InstallMethod( LeftPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category, to_be_finalized;
    
    category := CreateCapCategory( Concatenation( "Category of left presentations of ", RingName( ring ) ) );
    
    DisableAddForCategoricalOperations( category );
    
    AddObjectRepresentation( category, IsLeftPresentation );
    
    AddMorphismRepresentation( category, IsLeftPresentationMorphism );
    
    category!.ring_for_representation_category := ring;
    
    SetIsAbelianCategory( category, true );

    SetIsAbelianCategoryWithEnoughProjectives( category, true );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
    fi;
    
    ADD_FUNCTIONS_FOR_LEFT_PRESENTATION( category );
    
    AddCategoryToFamily( category, "ModuleCategory" );
    
    
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
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
   
    if to_be_finalized = false then
      
       return category;
    
    else
    
       Finalize( category );
      
    fi;
    
    return category;
    
end );

# LeftPresentations( R: FinalizeCategory := false );

##
InstallMethod( RightPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category, to_be_finalized;
    
    category := CreateCapCategory( Concatenation( "Category of right presentations of ", RingName( ring ) ) );
    
    AddObjectRepresentation( category, IsRightPresentation );
    
    AddMorphismRepresentation( category, IsRightPresentationMorphism );
    
    category!.ring_for_representation_category := ring;
    
    SetIsAbelianCategory( category, true );
    
    SetIsAbelianCategoryWithEnoughProjectives( category, true );

    if HasIsCommutative( ring ) and IsCommutative( ring ) then
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
    fi;
    
    ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION( category );
    
    AddCategoryToFamily( category, "ModuleCategory" );
    
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
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
   
    if to_be_finalized = false then
      
       return category;
    
    else
    
       Finalize( category );
      
    fi;
    
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
    
    ADD_KERNEL_LEFT( category );
    
    ADD_PRECOMPOSE_LEFT( category );
    
    ADD_ADDITION_FOR_MORPHISMS( category );
    
    ADD_ADDITIVE_INVERSE_FOR_MORPHISMS( category );
    
    ADD_IS_ZERO_FOR_MORPHISMS( category );
    
    ADD_ZERO_MORPHISM_LEFT( category );
    
    ADD_EQUAL_FOR_MORPHISMS_LEFT( category );
    
    ADD_COKERNEL_LEFT( category );
    
    ADD_DIRECT_SUM_LEFT( category );
    
    ADD_ZERO_OBJECT_LEFT( category );
    
    ADD_IDENTITY_LEFT( category );
    
    ADD_EQUAL_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_MORPHISM_LEFT( category );
    
    ADD_IS_IDENTICAL_FOR_MORPHISMS( category );
    
    ADD_EPIMORPHISM_FROM_SOME_PROJECTIVE_OBJECT( category );
    
    if HasIsCommutative( category!.ring_for_representation_category ) and IsCommutative( category!.ring_for_representation_category ) then
      
      ADD_LIFT_AND_COLIFT_LEFT( category );
      
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
    
    ADD_PRECOMPOSE_RIGHT( category );
    
    ADD_ADDITION_FOR_MORPHISMS( category );
    
    ADD_ADDITIVE_INVERSE_FOR_MORPHISMS( category );
    
    ADD_IS_ZERO_FOR_MORPHISMS( category );
    
    ADD_ZERO_MORPHISM_RIGHT( category );
    
    ADD_EQUAL_FOR_MORPHISMS_RIGHT( category );
    
    ADD_COKERNEL_RIGHT( category );
    
    ADD_DIRECT_SUM_RIGHT( category );
    
    ADD_ZERO_OBJECT_RIGHT( category );
    
    ADD_IDENTITY_RIGHT( category );
    
    ADD_EQUAL_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT( category );
    
    ADD_IS_IDENTICAL_FOR_MORPHISMS( category );
    
    ADD_EPIMORPHISM_FROM_SOME_PROJECTIVE_OBJECT( category );
    
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
      
      function( object )
        
        return IsHomalgMatrix( UnderlyingMatrix( object ) ) and IsHomalgRing( UnderlyingHomalgRing( object ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_MORPHISM_LEFT,
                       
  function( category )
    
    AddIsWellDefinedForMorphisms( category,
      
      function( morphism )
        local source_matrix, range_matrix, morphism_matrix;
        
        source_matrix := UnderlyingMatrix( Source( morphism ) );
        
        range_matrix := UnderlyingMatrix( Range( morphism ) );
        
        morphism_matrix := UnderlyingMatrix( morphism );
        
        if not ( NrColumns( source_matrix ) = NrRows( morphism_matrix )
                 and NrColumns( morphism_matrix ) = NrColumns( range_matrix ) ) then
          
          return false;
          
        fi;
        
        if RightDivide( source_matrix * morphism_matrix, range_matrix ) = fail then
          
          return false;
          
        fi;
        
        return true;
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT,
                       
  function( category )
    
    AddIsWellDefinedForMorphisms( category,
      
      function( morphism )
        
        local source_matrix, range_matrix, morphism_matrix;
        
        source_matrix := UnderlyingMatrix( Source( morphism ) );
        
        range_matrix := UnderlyingMatrix( Range( morphism ) );
        
        morphism_matrix := UnderlyingMatrix( morphism );
        
        if not ( NrRows( source_matrix ) = NrColumns( morphism_matrix )
                 and NrRows( morphism_matrix ) = NrRows( range_matrix ) ) then
          
          return false;
          
        fi;
        
        if LeftDivide( range_matrix, morphism_matrix * source_matrix ) = fail then
          
          return false;
          
        fi;
        
        return true;
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_IDENTICAL_FOR_MORPHISMS,
                              
  function( category )
    
    AddIsEqualForMorphisms( category,
    
      function( morphism_1, morphism_2 )
        
        return UnderlyingMatrix( morphism_1 ) = UnderlyingMatrix( morphism_2 );
        
    end );
    
    AddIsEqualForCacheForObjects( category, IsIdenticalObj );
    
    AddIsEqualForCacheForMorphisms( category, IsIdenticalObj );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_OBJECTS,
                       
  function( category )
    
    AddIsEqualForObjects( category,
                   
      function( object1, object2 )
        
        return UnderlyingMatrix( object1 ) = UnderlyingMatrix( object2 );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_KERNEL_LEFT,
                       
  function( category )
    
    AddKernelEmbedding( category,
      
      function( morphism )
        local kernel, embedding, source_matrix;
        
        embedding := ReducedSyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        source_matrix := BasisOfRows( UnderlyingMatrix( Source( morphism ) ) );
        
        embedding := DecideZeroRows( embedding, source_matrix );
        
        embedding := CertainRows( embedding, NonZeroRows( embedding ) );
        
        kernel := LazySyzygiesOfRows( embedding, source_matrix );
        
        kernel := AsLeftPresentation( kernel );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
#  TODO: Can we profit from such a function?
#     
#     AddKernelEmbeddingWithGivenKernelObject( category,
#       
#       function( morphism, kernel )
#         local embedding;
#         
#         embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
#         
#         return PresentationMorphism( kernel, embedding, Source( morphism ) );
#         
#     end );
    
    AddLiftAlongMonomorphism( category,
      
      function( beta, alpha )
        local lift;
        
        lift := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ), UnderlyingMatrix( Range( beta ) ) );
        
        if lift = fail then
            return fail;
        fi;
        
        return PresentationMorphism( Source( alpha ), lift, Source( beta ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_KERNEL_RIGHT,
                       
  function( category )
    
    AddKernelEmbedding( category,
      
      function( morphism )
        local kernel, embedding, source_matrix;
        
        embedding := ReducedSyzygiesOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        source_matrix := BasisOfColumns( UnderlyingMatrix( Source( morphism ) ) );
        
        embedding := DecideZeroColumns( embedding, source_matrix );
        
        embedding := CertainColumns( embedding, NonZeroColumns( embedding ) );
        
        kernel := LazySyzygiesOfColumns( embedding, source_matrix );
        
        kernel := AsRightPresentation( kernel );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
#  TODO: Can we profit from such a function?
#     
#     AddKernelEmbeddingWithGivenKernelObject( category,
#       
#       function( morphism, kernel )
#         local embedding;
#         
#         embedding := SyzygiesOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
#         
#         return PresentationMorphism( kernel, embedding, Source( morphism ) );
#         
#     end );
    
    AddLiftAlongMonomorphism( category,
      
        ## TODO: Reference for the conventions for Lift
       function( alpha, beta )
#        function( beta, alpha )
        local lift;
        
        lift := LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ), UnderlyingMatrix( Range( alpha ) ) );
        
        if lift = fail then
            return fail;
        fi;
        
        return PresentationMorphism( Source( beta ), lift, Source( alpha ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_PRECOMPOSE_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddPreCompose( category,
                   
      [ 
        [ function( left_morphism, right_morphism )
            
            return PresentationMorphism( Source( left_morphism ), UnderlyingMatrix( left_morphism ) * UnderlyingMatrix( right_morphism ), Range( right_morphism ) );
            
          end, [ , ] ],
        
        [ function( left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ , IsIdenticalToIdentityMorphism ] ],
        
        [ function( identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsIdenticalToIdentityMorphism, ] ],
        
        [ function( left_morphism, zero_morphism )
            
            return PresentationMorphism( Source( left_morphism ),
                                         HomalgZeroMatrix( NrRows( UnderlyingMatrix( left_morphism ) ), NrColumns( UnderlyingMatrix( zero_morphism ) ), homalg_ring ),
                                         Range( zero_morphism ) );
          
          end, [ , IsIdenticalToZeroMorphism ] ],
        
        [ function( zero_morphism, right_morphism )
            
            return PresentationMorphism( Source( zero_morphism ),
                                         HomalgZeroMatrix( NrRows( UnderlyingMatrix( zero_morphism ) ), NrColumns( UnderlyingMatrix( right_morphism ) ), homalg_ring ),
                                         Range( right_morphism ) );
          
          end, [ IsIdenticalToZeroMorphism, ] ],
      ]
      
    );
    
end );

##
InstallGlobalFunction( ADD_PRECOMPOSE_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddPreCompose( category,
      
      [ 
        
        [ function( left_morphism, right_morphism )
          
          return PresentationMorphism( Source( left_morphism ), UnderlyingMatrix( right_morphism ) * UnderlyingMatrix( left_morphism ), Range( right_morphism ) );
          
          end, [ , ] ],
        
        [ function( left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ , IsIdenticalToIdentityMorphism ] ],
        
        [ function( identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsIdenticalToIdentityMorphism, ] ],
        
        
        [ function( left_morphism, zero_morphism )
            
            return PresentationMorphism( Source( left_morphism ),
                                         HomalgZeroMatrix( NrRows( UnderlyingMatrix( zero_morphism ) ), NrColumns( UnderlyingMatrix( left_morphism ) ), homalg_ring ),
                                         Range( zero_morphism ) );
          
          end, [ , IsIdenticalToZeroMorphism ] ],
        
        [ function( zero_morphism, right_morphism )
            
            return PresentationMorphism( Source( zero_morphism ),
                                         HomalgZeroMatrix( NrRows( UnderlyingMatrix( right_morphism ) ), NrColumns( UnderlyingMatrix( zero_morphism ) ), homalg_ring ),
                                         Range( right_morphism ) );
          
          end, [ IsIdenticalToZeroMorphism, ] ],
      ]
      
    );
    
end );

##
InstallGlobalFunction( ADD_ADDITION_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditionForMorphisms( category,
                             
      function( morphism_1, morphism_2 )
        
        return PresentationMorphism( Source( morphism_1 ), UnderlyingMatrix( morphism_1 ) + UnderlyingMatrix( morphism_2 ), Range( morphism_1 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ADDITIVE_INVERSE_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditiveInverseForMorphisms( category,
                                    
      function( morphism_1 )
        
        return PresentationMorphism( Source( morphism_1 ), - UnderlyingMatrix( morphism_1 ), Range( morphism_1 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_ZERO_FOR_MORPHISMS,
                       
  function( category )
    ## FIXME: Use DecideZeroRows here (and DecideZeroColumns for the case of right modules)
#     AddIsZeroForMorphisms( category,
#                            
#       function( morphism )
#         
#         return IsZero( UnderlyingMatrix( morphism ) );
#         
#     end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_MORPHISM_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local matrix;
        
        matrix := HomalgZeroMatrix( NrColumns( UnderlyingMatrix( source ) ), NrColumns( UnderlyingMatrix( range ) ), homalg_ring );
        
        return PresentationMorphism( source, matrix, range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_MORPHISM_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local matrix;
        
        matrix := HomalgZeroMatrix( NrRows( UnderlyingMatrix( range ) ), NrRows( UnderlyingMatrix( source ) ), homalg_ring );
        
        return PresentationMorphism( source, matrix, range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_MORPHISMS_LEFT,
                       
  function( category )
    
    AddIsCongruentForMorphisms( category,
                            
      function( morphism_1, morphism_2 )
        local result_of_divide;
        
        result_of_divide := DecideZeroRows( UnderlyingMatrix( morphism_1 ) - UnderlyingMatrix( morphism_2 ), UnderlyingMatrix( Range( morphism_1 ) ) );
        
        return IsZero( result_of_divide );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_MORPHISMS_RIGHT,
                       
  function( category )
    
    AddIsCongruentForMorphisms( category,
                            
      function( morphism_1, morphism_2 )
        local result_of_divide;
        
        result_of_divide := DecideZeroColumns( UnderlyingMatrix( morphism_1 ) - UnderlyingMatrix( morphism_2 ), UnderlyingMatrix( Range( morphism_1 ) ) );
        
        return IsZero( result_of_divide );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COKERNEL_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddCokernelProjection( category,
                     
      function( morphism )
        local cokernel_object, projection;
        
        cokernel_object := UnionOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        cokernel_object := AsLeftPresentation( cokernel_object );
        
        projection := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( Range( morphism ) ) ), homalg_ring );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        return PresentationMorphism( cokernel_object, UnderlyingMatrix( test_morphism ), Range( test_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COKERNEL_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddCokernelProjection( category,
                     
      function( morphism )
        local cokernel_object, projection;
        
        cokernel_object := UnionOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        cokernel_object := AsRightPresentation( cokernel_object );
        
        projection := HomalgIdentityMatrix( NrRows( UnderlyingMatrix( Range( morphism ) ) ), homalg_ring );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        return PresentationMorphism( cokernel_object, UnderlyingMatrix( test_morphism ), Range( test_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_DIRECT_SUM_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddDirectSum( category,
                  
      function( product_object )
        local objects, direct_sum;
        
        objects := product_object;
        
        objects := List( objects, UnderlyingMatrix );
        
        direct_sum := DiagMat( objects );
        
        return AsLeftPresentation( direct_sum );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
                                                 
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_factor, projection, projection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrColumns( UnderlyingMatrix( i ) ) );
        
        dimension_of_factor := object_column_dimension[ component_number ];
        
        projection := List( object_column_dimension, i -> 
                            HomalgZeroMatrix( i, dimension_of_factor, homalg_ring ) );
        
        projection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], homalg_ring );
        
        projection_matrix := projection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            projection_matrix := UnionOfRows( projection_matrix, projection[ i ] );
            
        od;
        
        return PresentationMorphism( direct_sum_object, projection_matrix, objects[ component_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
                                                                 
      function( diagram, product_morphism, direct_sum )
        local components, number_of_components, map_into_product, i;
        
        components := product_morphism;
        
        number_of_components := Length( components );
        
        map_into_product := UnderlyingMatrix( components[ 1 ] );
        
        for i in [ 2 .. number_of_components ] do
            
            map_into_product := UnionOfColumns( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( Source( components[ 1 ] ), map_into_product, direct_sum );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
                                              
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_cofactor, injection, injection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrColumns( UnderlyingMatrix( i ) ) );
        
        dimension_of_cofactor := object_column_dimension[ component_number ];
        
        injection := List( object_column_dimension, i -> HomalgZeroMatrix( dimension_of_cofactor, i, homalg_ring ) );
        
        injection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], homalg_ring );
        
        injection_matrix := injection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            injection_matrix := UnionOfColumns( injection_matrix, injection[ i ] );
            
        od;
        
        return PresentationMorphism( objects[ component_number ], injection_matrix, direct_sum_object );
        
    end );
    
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
                                                         
      function( diagram, product_morphism, direct_sum )
        local components, number_of_components, map_into_product, i;
        
        components := product_morphism;
        
        number_of_components := Length( components );
        
        map_into_product := UnderlyingMatrix( components[ 1 ] );
        
        for i in [ 2 .. number_of_components ] do
            
            map_into_product := UnionOfRows( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( direct_sum, map_into_product, Range( components[ 1 ] ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_DIRECT_SUM_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddDirectSum( category,
                  
      function( product_object )
        local objects, direct_sum;
        
        objects := product_object;
        
        objects := List( objects, UnderlyingMatrix );
        
        direct_sum := DiagMat( objects );
        
        return AsRightPresentation( direct_sum );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
                                                 
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_factor, projection, projection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrRows( UnderlyingMatrix( i ) ) );
        
        dimension_of_factor := object_column_dimension[ component_number ];
        
        projection := List( object_column_dimension, i -> HomalgZeroMatrix( dimension_of_factor, i, homalg_ring ) );
        
        projection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], homalg_ring );
        
        projection_matrix := projection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            projection_matrix := UnionOfColumns( projection_matrix, projection[ i ] );
            
        od;
        
        return PresentationMorphism( direct_sum_object, projection_matrix, objects[ component_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
                                                                 
      function( diagram, product_morphism, direct_sum )
        local components, number_of_components, map_into_product, i;
        
        components := product_morphism;
        
        number_of_components := Length( components );
        
        map_into_product := UnderlyingMatrix( components[ 1 ] );
        
        for i in [ 2 .. number_of_components ] do
            
            map_into_product := UnionOfRows( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( Source( components[ 1 ] ), map_into_product, direct_sum );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
                                              
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_cofactor, injection, injection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrRows( UnderlyingMatrix( i ) ) );
        
        dimension_of_cofactor := object_column_dimension[ component_number ];
        
        injection := List( object_column_dimension, i -> HomalgZeroMatrix( i, dimension_of_cofactor, homalg_ring ) );
        
        injection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], homalg_ring );
        
        injection_matrix := injection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            injection_matrix := UnionOfRows( injection_matrix, injection[ i ] );
            
        od;
        
        return PresentationMorphism( objects[ component_number ], injection_matrix, direct_sum_object );
        
    end );
    
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
                                                         
      function( diagram, product_morphism, direct_sum )
        local components, number_of_components, map_into_product, i;
        
        components := product_morphism;
        
        number_of_components := Length( components );
        
        map_into_product := UnderlyingMatrix( components[ 1 ] );
        
        for i in [ 2 .. number_of_components ] do
            
            map_into_product := UnionOfColumns( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( direct_sum, map_into_product, Range( components[ 1 ] ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_OBJECT_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddZeroObject( category,
                   
      function( )
        local matrix;
        
        matrix := HomalgZeroMatrix( 0, 0, homalg_ring );
        
        return AsLeftPresentation( matrix );
        
    end );
    
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
                                                                   
      function( object, terminal_object )
        local nr_columns, morphism;
        
        nr_columns := NrColumns( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( nr_columns, 0, homalg_ring );
        
        return PresentationMorphism( object, morphism, terminal_object );
        
    end );
    
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
                                                                 
      function( object, initial_object )
        local nr_columns, morphism;
        
        nr_columns := NrColumns( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( 0, nr_columns, homalg_ring );
        
        return PresentationMorphism( initial_object, morphism, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_OBJECT_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddZeroObject( category,
                   
      function( )
        local matrix;
        
        matrix := HomalgZeroMatrix( 0, 0, homalg_ring );
        
        return AsRightPresentation( matrix );
        
    end );
    
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
                                                                   
      function( object, terminal_object )
        local nr_rows, morphism;
        
        nr_rows := NrRows( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( 0, nr_rows, homalg_ring );
        
        return PresentationMorphism( object, morphism, terminal_object );
        
    end );
    
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
                                                                 
      function( object, initial_object )
        local nr_rows, morphism;
        
        nr_rows := NrRows( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( nr_rows, 0, homalg_ring );
        
        return PresentationMorphism( initial_object, morphism, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IDENTITY_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddIdentityMorphism( category,
                         
      function( object )
        local matrix;
        
        matrix := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( object ) ), homalg_ring );
        
        return PresentationMorphism( object, matrix, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IDENTITY_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddIdentityMorphism( category,
                         
      function( object )
        local matrix;
        
        matrix := HomalgIdentityMatrix( NrRows( UnderlyingMatrix( object ) ), homalg_ring );
        
        return PresentationMorphism( object, matrix, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ASSOCIATOR_LEFT,
                      
  function( category )
    local homalg_ring, associator_func;
    
    homalg_ring := category!.ring_for_representation_category;
    
    associator_func := function( source, A, B, C, range )
        
        return PresentationMorphism(
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
    
    associator_func := function( source, A, B, C, range )
        
        return PresentationMorphism(
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
    
    unitor_func := function( A, B )
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
      
      function( object_1, object_2 )
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
        
        return AsLeftPresentation( presentation_matrix );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_OBJECTS_RIGHT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorProductOnObjects( category,
      
      function( object_1, object_2 )
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
        
        return AsRightPresentation( presentation_matrix );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_MORPHISMS,
                      
  function( category )
    
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        
        return PresentationMorphism( new_source, 
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
      
      function( )
        
        return AsLeftPresentation( HomalgZeroMatrix( 0, 1, homalg_ring ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_UNIT_RIGHT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorUnit( category,
      
      function( )
        
        return AsRightPresentation( HomalgZeroMatrix( 1, 0, homalg_ring ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_OBJECTS_LEFT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnObjects( category,
      
      function( object_1, object_2 )
        
        return Source( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_1, object_2 ) );
    
    end );
    
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_OBJECTS_RIGHT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnObjects( category,
      
      function( object_1, object_2 )
        
        return Source( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_1, object_2 ) );
    
    end );
    
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_MORPHISMS_LEFT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnMorphismsWithGivenInternalHoms( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        local internal_hom_embedding_source, internal_hom_embedding_range, morphism_between_tensor_products;
        
        internal_hom_embedding_source := 
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( Range( morphism_1 ), Source( morphism_2 ) );
        
        internal_hom_embedding_range :=
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( Source( morphism_1 ), Range( morphism_2 ) );
        
        morphism_between_tensor_products := 
          PresentationMorphism(
            Range( internal_hom_embedding_source ),
            KroneckerMat( Involution( UnderlyingMatrix( morphism_1 ) ), UnderlyingMatrix( morphism_2 ) ),
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
      
      function( new_source, morphism_1, morphism_2, new_range )
        local internal_hom_embedding_source, internal_hom_embedding_range, morphism_between_tensor_products;
        
        internal_hom_embedding_source := 
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( Range( morphism_1 ), Source( morphism_2 ) );
        
        internal_hom_embedding_range :=
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( Source( morphism_1 ), Range( morphism_2 ) );
        
        morphism_between_tensor_products := 
          PresentationMorphism(
            Range( internal_hom_embedding_source ),
            KroneckerMat( Involution( UnderlyingMatrix( morphism_1 ) ), UnderlyingMatrix( morphism_2 ) ),
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
      
      function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local homalg_ring, permutation_matrix, rank_1, rank_2, rank;
        
        homalg_ring := UnderlyingHomalgRing( object_1 );
        
        rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
        
        rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
        
        rank := NrColumns( UnderlyingMatrix( object_1_tensored_object_2 ) );
        
        permutation_matrix := PermutationMat( 
                                PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) ),
                                rank 
                              );
        
        return PresentationMorphism( object_1_tensored_object_2,
                                     HomalgMatrix( permutation_matrix, rank, rank, homalg_ring ),
                                     object_2_tensored_object_1 );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_BRAIDING_RIGHT,
                      
  function( category )
    
    AddBraidingWithGivenTensorProducts( category,
      
      function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local homalg_ring, permutation_matrix, rank_1, rank_2, rank;
        
        homalg_ring := UnderlyingHomalgRing( object_1 );
        
        rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
        
        rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
        
        rank := NrRows( UnderlyingMatrix( object_1_tensored_object_2 ) );
        
        permutation_matrix := PermutationMat( 
                                PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) ),
                                rank 
                              );
        
        return PresentationMorphism( object_1_tensored_object_2,
                                     Involution( HomalgMatrix( permutation_matrix, rank, rank, homalg_ring ) ), ## transposed of the left case
                                     object_2_tensored_object_1 );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EVALUATION_MORPHISM_LEFT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddEvaluationMorphismWithGivenSource( category,
      
      function( object_1, object_2, internal_hom_tensored_object_1 )
        local internal_hom_embedding, rank_1, morphism, free_module,
              column, zero_column, i, matrix, rank_2, lifted_evaluation;
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_1, object_2 );
        
        rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
        
        free_module := FreeLeftPresentation( rank_1, homalg_ring );
        
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
        
        lifted_evaluation := PresentationMorphism( Range( morphism ), matrix, object_2 );
        
        return PreCompose( morphism, lifted_evaluation );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EVALUATION_MORPHISM_RIGHT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddEvaluationMorphismWithGivenSource( category,
      
      function( object_1, object_2, internal_hom_tensored_object_1 )
        local internal_hom_embedding, rank_1, morphism, free_module,
              row, zero_row, i, matrix, rank_2, lifted_evaluation;
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_1, object_2 );
        
        rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
        
        free_module := FreeRightPresentation( rank_1, homalg_ring );
        
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
        
        lifted_evaluation := PresentationMorphism( Range( morphism ), matrix, object_2 );
        
        return PreCompose( morphism, lifted_evaluation );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COEVALUATION_MORPHISM_LEFT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddCoevaluationMorphismWithGivenRange( category,
      
      function( object_1, object_2, internal_hom )
        local object_1_tensored_object_2, internal_hom_embedding, rank_2, free_module, morphism,
              row, zero_row, i, matrix, rank_1, lifted_coevaluation;
        
        object_1_tensored_object_2 := TensorProductOnObjects( object_1, object_2 );
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_2, object_1_tensored_object_2 );
        
        rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
        
        free_module := FreeLeftPresentation( rank_2, homalg_ring );
        
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
        
        lifted_coevaluation := PresentationMorphism( object_1, matrix, Range( morphism ) );
        
        return LiftAlongMonomorphism( morphism, lifted_coevaluation );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COEVALUATION_MORPHISM_RIGHT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddCoevaluationMorphismWithGivenRange( category,
      
      function( object_1, object_2, internal_hom )
        local object_1_tensored_object_2, internal_hom_embedding, rank_2, free_module, morphism,
              column, zero_column, i, matrix, rank_1, lifted_coevaluation;
        
        object_1_tensored_object_2 := TensorProductOnObjects( object_1, object_2 );
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_2, object_1_tensored_object_2 );
        
        rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
        
        free_module := FreeRightPresentation( rank_2, homalg_ring );
        
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
        
        lifted_coevaluation := PresentationMorphism( object_1, matrix, Range( morphism ) );
        
        return LiftAlongMonomorphism( morphism, lifted_coevaluation );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EPIMORPHISM_FROM_SOME_PROJECTIVE_OBJECT, 
    function( category )
    
    AddEpimorphismFromSomeProjectiveObject( category, CoverByFreeModule );
    
end );

InstallGlobalFunction( ADD_LIFT_AND_COLIFT_LEFT, 

  function( category )
  local homalg_ring;

  homalg_ring := category!.ring_for_representation_category;
  
  AddLift( category, 
    
    function( morphism_1, morphism_2 )
    local P, N, M, A, B, B_tr_I, N_tr_I, zero_1, mat1, mat2, I_P, zero_2, M_tr_I, mat, vec_A, vec_zero, vec, sol, v, s, XX;
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
    
    # NrColumns( N ) = 0 implies coker(N)=0 and  s = 0 implies coker(P)=0, hence morphism_1 is zero, and the zero morphism can always be lifted. 
    if NrColumns( N ) = 0 or s = 0 then 
        return ZeroMorphism( Source( morphism_1 ), Source( morphism_2 ) ); 
    fi;
    
    # if NrColumns(M)=0 then M is zero, hence lift exists iff morphism_1 is zero.
    if NrColumns( M ) = 0 and IsZeroForMorphisms( morphism_1 ) then 
        return ZeroMorphism( Source( morphism_1 ), Source( morphism_2 ) );
    fi;
    A := UnderlyingMatrix( morphism_1 );
    
    B := UnderlyingMatrix( morphism_2 );
    
    B_tr_I := KroneckerMat( Involution( B ), HomalgIdentityMatrix( NrColumns( P ), homalg_ring ) );
    
    N_tr_I := KroneckerMat( Involution( N ), HomalgIdentityMatrix( NrColumns( P ) ,homalg_ring ) );
    
    zero_1  := HomalgZeroMatrix( NrRows( A )*NrColumns( A ), NrRows( P )*NrRows( M ), homalg_ring );
    
    mat1 := UnionOfColumns( UnionOfColumns( B_tr_I, N_tr_I ), zero_1 );
    
    I_P := KroneckerMat( HomalgIdentityMatrix( NrColumns( M ) ,homalg_ring ), P );
    
    zero_2 := HomalgZeroMatrix( NrRows( P )*NrColumns( M ), NrRows( A )*NrRows( N ), homalg_ring );
    
    M_tr_I := KroneckerMat( Involution( M ), HomalgIdentityMatrix( NrRows( P ) ,homalg_ring ) );
    
    mat2 := UnionOfColumns( UnionOfColumns( I_P, zero_2 ), M_tr_I );
    
    mat := UnionOfRows( mat1, mat2 );
    
    if NrColumns( A ) <= 1 then
       
       vec_A := A;
       
    else
       
       vec_A := Iterated( List( [ 1 .. NrColumns( A ) ], i-> CertainColumns( A, [ i ] ) ), UnionOfRows ); 
       
    fi;
    
    vec_zero := HomalgZeroMatrix( NrRows( P )*NrColumns( M ), 1, homalg_ring );
    
    vec := UnionOfRows( vec_A, vec_zero );
    
    sol := LeftDivide( mat, vec );
    
    if sol = fail then 
    
       return fail;
       
    else
       
       if v <= 1 then
          XX := CertainRows( sol, [ 1.. s ] );
       else
          XX := Iterated( List( [ 1 .. v ], i-> CertainRows( sol, [ (i-1)*s+1.. i*s ] ) ), UnionOfColumns );
       fi;
       
       return PresentationMorphism( Source( morphism_1 ), XX, Source( morphism_2 ) );
       
    fi;
    
    end );
  
  AddColift( category, 
    
    function( morphism_1, morphism_2 )
    local N, M, A, B, I, B_over_M, mat1, mat2, mat, zero_mat, A_over_zero, vec, sol, v, s, XX;
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
    
    # NrColumns( N ) = 0 implies coker(N)=0 and  s = 0 implies coker(I)=0, hence morphism_2 is zero, and the zero morphism can always be colifted.
    if NrColumns( N ) = 0 or s = 0 then 
        return ZeroMorphism( Range( morphism_1 ), Range( morphism_2 ) );
    fi;

    # if NrColumns(M)=0 then M is zero, hence colift exists iff morphism_2 is zero.
    if NrColumns( M ) = 0 and IsZeroForMorphisms( morphism_2 ) then 
        return ZeroMorphism( Range( morphism_1 ), Range( morphism_2 ) );
    fi;

    B := UnderlyingMatrix( morphism_1 );
    
    A := UnderlyingMatrix( morphism_2 );
    
    B_over_M := UnionOfRows( B, M );
    
    mat1 := KroneckerMat( HomalgIdentityMatrix( NrColumns( I ), homalg_ring ), B_over_M );
    
    mat2 := KroneckerMat( Involution( I ), HomalgIdentityMatrix( NrRows( B ) + NrRows( M ), homalg_ring ) );
    
    mat := UnionOfColumns( mat1, mat2 );
    
    zero_mat := HomalgZeroMatrix( NrRows( M ), NrColumns( I ), homalg_ring );
    
    A_over_zero := UnionOfRows( A, zero_mat );
    
    if NrColumns( A ) <= 1 then 
        vec := A_over_zero;
    else
        vec := Iterated( List( [ 1 .. NrColumns( A ) ], i-> CertainColumns( A_over_zero, [ i ] ) ), UnionOfRows );
    fi;

    sol := LeftDivide( mat, vec );
    
    if sol = fail then 
    
       return fail;
       
    else 
    
       v := NrColumns( M );
       
       s := NrColumns( I );
       
       if s <= 1 then 
          XX := CertainRows( sol, [ 1.. v ] );
       else
          XX := Iterated( List( [ 1 .. s ], i-> CertainRows( sol, [ (i-1)*v+1.. i*v ] ) ), UnionOfColumns );
       fi;
       
       return PresentationMorphism( Range( morphism_1 ), XX, Range( morphism_2 ) );
       
    fi;
    
    end, 1000 );
 
end );

##
InstallGlobalFunction( ADD_LIFT_AND_COLIFT_RIGHT, 

  function( category )
  local homalg_ring;
  
  homalg_ring := category!.ring_for_representation_category;
  
  AddLift( category, 
    
    function( morphism_1, morphism_2 )
    local Pt, Nt, Mt, At, Bt, B_tr_I, N_tr_I, zero_1, 
          mat1, mat2, I_P, zero_2, M_tr_I, mat, vec_A, vec_zero, vec, sol, v, s, XX;
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
    
    Pt := Involution( UnderlyingMatrix( Source( morphism_1 ) ) );
    Mt := Involution( UnderlyingMatrix( Source( morphism_2 ) ) );
    
    v := NrColumns( Mt );
    
    s := NrColumns( Pt );
    
    Nt := Involution( UnderlyingMatrix( Range(  morphism_1 ) ) );
    
    if NrRows( Nt ) = 0 or s = 0 then 
        return ZeroMorphism( Source( morphism_1 ), Source( morphism_2 ) ); 
    fi;

    if NrRows( Mt ) = 0 and IsZeroForMorphisms( morphism_1 ) then
        return ZeroMorphism( Source( morphism_1 ), Source( morphism_2 ) );
    fi;

    At := Involution( UnderlyingMatrix( morphism_1 ) );
    
    Bt := Involution( UnderlyingMatrix( morphism_2 ) );
    
    B_tr_I := KroneckerMat( Involution( Bt ), HomalgIdentityMatrix( NrColumns( Pt ), homalg_ring ) );
    
    N_tr_I := KroneckerMat( Involution( Nt ), HomalgIdentityMatrix( NrColumns( Pt ) ,homalg_ring ) );
    
    zero_1  := HomalgZeroMatrix( NrRows( At )*NrColumns( At ), NrRows( Pt )*NrRows( Mt ), homalg_ring );
    
    mat1 := UnionOfColumns( UnionOfColumns( B_tr_I, N_tr_I ), zero_1 );
    
    I_P := KroneckerMat( HomalgIdentityMatrix( NrColumns( Mt ) ,homalg_ring ), Pt );
    
    zero_2 := HomalgZeroMatrix( NrRows( Pt )*NrColumns( Mt ), NrRows( At )*NrRows( Nt ), homalg_ring );
    
    M_tr_I := KroneckerMat( Involution( Mt ), HomalgIdentityMatrix( NrRows( Pt ) ,homalg_ring ) );
    
    mat2 := UnionOfColumns( UnionOfColumns( I_P, zero_2 ), M_tr_I );
    
    mat := UnionOfRows( mat1, mat2 );
    
    if NrColumns( At ) <= 1 then
       
       vec_A := At;
       
    else
       
       vec_A := Iterated( List( [ 1 .. NrColumns( At ) ], i-> CertainColumns( At, [ i ] ) ), UnionOfRows ); 
       
    fi;
    
    vec_zero := HomalgZeroMatrix( NrRows( Pt )*NrColumns( Mt ), 1, homalg_ring );
    
    vec := UnionOfRows( vec_A, vec_zero );
    
    sol := LeftDivide( mat, vec );
    
    if sol = fail then 
    
       return fail;
       
    else 
       
       if v <= 1 then
          XX := Involution( CertainRows( sol, [ 1.. s ] ) );
       else
          XX := Involution( Iterated( List( [ 1 .. v ], i-> CertainRows( sol, [ (i-1)*s+1.. i*s ] ) ), UnionOfColumns ) );
       fi;
       
       return PresentationMorphism( Source( morphism_1 ), XX, Source( morphism_2 ) );
       
    fi;
    
end );

  AddColift( category, 
    
    function( morphism_1, morphism_2 )
    local Nt, Mt, At, Bt, It, B_over_M, mat1, mat2, mat, zero_mat, A_over_zero, vec, sol, v, s, XX;
    
    It := Involution( UnderlyingMatrix( Range( morphism_2 ) ) );
    
    Mt := Involution( UnderlyingMatrix( Range( morphism_1 ) ) );
    
    v := NrColumns( Mt );
       
    s := NrColumns( It );
        
    Nt := Involution( UnderlyingMatrix( Source( morphism_1 ) ) );
    
    if NrRows( Nt ) = 0 or s = 0 then 
        return ZeroMorphism( Range( morphism_1 ), Range( morphism_2 ) );
    fi;
    
    if NrRows( Mt ) = 0 and IsZeroForMorphisms( morphism_2 ) then 
        return ZeroMorphism( Range( morphism_1 ), Range( morphism_2 ) );
    fi;

    Bt := Involution( UnderlyingMatrix( morphism_1 ) );
    
    At := Involution( UnderlyingMatrix( morphism_2 ) );
    
    B_over_M := UnionOfRows( Bt, Mt );
    
    mat1 := KroneckerMat( HomalgIdentityMatrix( NrColumns( It ), homalg_ring ), B_over_M );
    
    mat2 := KroneckerMat( Involution( It ), HomalgIdentityMatrix( NrRows( Bt ) + NrRows( Mt ), homalg_ring ) );
    
    mat := UnionOfColumns( mat1, mat2 );
    
    zero_mat := HomalgZeroMatrix( NrRows( Mt ), NrColumns( It ), homalg_ring );
    
    A_over_zero := UnionOfRows( At, zero_mat );
    
    if NrColumns( At ) <= 1 then 
        vec := A_over_zero;
    else
        vec := Iterated( List( [ 1 .. NrColumns( At ) ], i-> CertainColumns( A_over_zero, [ i ] ) ), UnionOfRows );
    fi;

    sol := LeftDivide( mat, vec );
    
    if sol = fail then 
    
       return fail;
       
    else 
    
       v := NrColumns( Mt );
       
       s := NrColumns( It );
       
       if s <= 1 then 
          XX := Involution( CertainRows( sol, [ 1.. v ] ) );
       else
          XX := Involution( Iterated( List( [ 1 .. s ], i-> CertainRows( sol, [ (i-1)*v+1.. i*v ] ) ), UnionOfColumns ) );
       fi;
       
       return PresentationMorphism( Range( morphism_1 ), XX, Range( morphism_2 ) );
       
    fi;
    
    end, 1000 );

end );
