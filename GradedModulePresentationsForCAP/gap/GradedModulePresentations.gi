#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

##
InstallMethod( GradedLeftPresentations,
               [ IsHomalgGradedRing ],
               
  function( ring )
    local category, to_be_finalized;
    
    category := CreateCapCategory( Concatenation( "The category of graded left f.p. modules over ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    category!.underlying_presentation_category := LeftPresentations( ring );
    
    category!.left := true;
    
    SetIsAbelianCategory( category, true );
    
    SetIsAbelianCategoryWithEnoughProjectives( category, true );

    ENHANCE_GRADED_RING_WITH_RANDOM_FUNCTIONS( ring );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
      SetIsStrictMonoidalCategory( category, true );
    
    fi;
    
    ADD_GRADED_FUNCTIONS_FOR_LEFT_PRESENTATION( category );
    
    AddCategoryToFamily( category, "ModuleCategory" );
    
    
    ## TODO: avoid code duplication (see RightPresentations)
#     AddTheoremFileToCategory( category,
#       Filename(
#         DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
#         "PropositionsForGeneralModuleCategories.tex" )
#     );
#     
#     AddPredicateImplicationFileToCategory( category,
#       Filename(
#         DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
#         "PredicateImplicationsForGeneralModuleCategories.tex" )
#      );
#     
#     AddEvalRuleFileToCategory( category,
#       Filename(
#         DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
#         "RelationsForGeneralModuleCategories.tex" )
#     );
    
    to_be_finalized := ValueOption( "FinalizeCategory" );
   
    if to_be_finalized = false then
      
       return category;
    
    else
    
       Finalize( category );
      
    fi;
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( GradedRightPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category, to_be_finalized;
    
    category := CreateCapCategory( Concatenation( "The category of graded right f.p. modules over ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    category!.underlying_presentation_category := RightPresentations( ring );
    
    category!.left := false;
    
    SetIsAbelianCategory( category, true );
    
    SetIsAbelianCategoryWithEnoughProjectives( category, true );
    
    ENHANCE_GRADED_RING_WITH_RANDOM_FUNCTIONS( ring );
  
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
      SetIsStrictMonoidalCategory( category, true );
    
    fi;
    
    ADD_GRADED_FUNCTIONS_FOR_RIGHT_PRESENTATION( category );
    
    AddCategoryToFamily( category, "ModuleCategory" );
    
#     ## TODO: avoid code duplication (see LeftPresentations)
#     AddTheoremFileToCategory( category,
#       Filename(
#         DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
#         "PropositionsForGeneralModuleCategories.tex" )
#     );
#     
#     AddPredicateImplicationFileToCategory( category,
#       Filename(
#         DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
#         "PredicateImplicationsForGeneralModuleCategories.tex" )
#      );
#     
#     AddEvalRuleFileToCategory( category,
#       Filename(
#         DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
#         "RelationsForGeneralModuleCategories.tex" )
#     );
    
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
InstallGlobalFunction( ADD_GRADED_FUNCTIONS_FOR_LEFT_PRESENTATION,
                       
  function( category )

    ADD_GRADED_KERNEL_LEFT( category );
    
    if CanCompute( category!.underlying_presentation_category, "Lift" ) then
    
        ADD_GRADED_LIFT( category );
    
    fi;
    
    if CanCompute( category!.underlying_presentation_category, "Colift" ) then
    
        ADD_GRADED_COLIFT( category );
    
    fi;

    ADD_GRADED_PRECOMPOSE( category );
    
    ADD_GRADED_ADDITION_FOR_MORPHISMS( category );
    
    ADD_GRADED_ADDITIVE_INVERSE_FOR_MORPHISMS( category );
    
    ADD_GRADED_ZERO_MORPHISM( category );
    
    ADD_GRADED_EQUAL_FOR_MORPHISMS( category );
    
    ADD_GRADED_COKERNEL( category );
    
    ADD_GRADED_DIRECT_SUM( category );
    
    ADD_GRADED_ZERO_OBJECT( category );
    
    ADD_GRADED_IDENTITY( category );
    
    ADD_GRADED_EQUAL_FOR_OBJECTS( category );
    
    ADD_GRADED_IS_WELL_DEFINED_FOR_OBJECTS_LEFT( category );
    
    ADD_GRADED_IS_WELL_DEFINED_FOR_MORPHISM_LEFT( category );
    
    ADD_GRADED_IS_IDENTICAL_FOR_MORPHISMS( category );
    
    ADD_GRADED_EPIMORPHISM_FROM_SOME_PROJECTIVE_OBJECT( category );

    ADD_GRADED_LIFT_ALONG_MONOMORPHISM( category );

    ADD_GRADED_COLIFT_ALONG_EPIMORPHISM( category );

    if IsBound( category!.ring_for_representation_category!.random_graded_element_func ) and
         IsBound( category!.ring_for_representation_category!.random_matrix_between_free_left_presentations_func ) and
           IsBound( category!.ring_for_representation_category!.random_matrix_for_left_presentation_func ) then

             ADD_GRADED_RANDOM_OBJECT_LEFT( category );

             ADD_GRADED_RANDOM_MORPHISM_WITH_FIXED_SOURCE_LEFT( category );

             ADD_GRADED_RANDOM_MORPHISM_WITH_FIXED_RANGE_LEFT( category );

    fi;
    
    if HasIsCommutative( category!.ring_for_representation_category ) and IsCommutative( category!.ring_for_representation_category ) then
      
      ADD_GRADED_TENSOR_PRODUCT_ON_OBJECTS( category );
      
      ADD_GRADED_TENSOR_PRODUCT_ON_MORPHISMS( category );
      
      ADD_GRADED_TENSOR_UNIT( category );
      
      ADD_GRADED_INTERNAL_HOM_ON_OBJECTS_LEFT( category );
      
      ADD_GRADED_INTERNAL_HOM_ON_MORPHISMS_LEFT( category );
#       
#       ADD_GRADED_BRAIDING_LEFT( category );
#       
#       ADD_GRADED_EVALUATION_MORPHISM_LEFT( category );
#       
#       ADD_GRADED_COEVALUATION_MORPHISM_LEFT( category );
      
    fi;
    
end );

##
InstallGlobalFunction( ADD_GRADED_FUNCTIONS_FOR_RIGHT_PRESENTATION,
                       
  function( category )
    
    ADD_GRADED_KERNEL_RIGHT( category );
    
    if CanCompute( category!.underlying_presentation_category, "Lift" ) then
    
        ADD_GRADED_LIFT( category );
    
    fi;
    
    if CanCompute( category!.underlying_presentation_category, "Colift" ) then
    
        ADD_GRADED_COLIFT( category );
    
    fi;
    
    ADD_GRADED_PRECOMPOSE( category );
    
    ADD_GRADED_ADDITION_FOR_MORPHISMS( category );
    
    ADD_GRADED_ADDITIVE_INVERSE_FOR_MORPHISMS( category );
    
    ADD_GRADED_ZERO_MORPHISM( category );
    
    ADD_GRADED_EQUAL_FOR_MORPHISMS( category );
    
    ADD_GRADED_COKERNEL( category );
    
    ADD_GRADED_DIRECT_SUM( category );
    
    ADD_GRADED_ZERO_OBJECT( category );
    
    ADD_GRADED_IDENTITY( category );
    
    ADD_GRADED_EQUAL_FOR_OBJECTS( category );
    
    ADD_GRADED_IS_WELL_DEFINED_FOR_OBJECTS_RIGHT( category );
    
    ADD_GRADED_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT( category );
    
    ADD_GRADED_IS_IDENTICAL_FOR_MORPHISMS( category );
    
    ADD_GRADED_EPIMORPHISM_FROM_SOME_PROJECTIVE_OBJECT( category );

    ADD_GRADED_LIFT_ALONG_MONOMORPHISM( category );

    ADD_GRADED_COLIFT_ALONG_EPIMORPHISM( category );
    
    if IsBound( category!.ring_for_representation_category!.random_graded_element_func ) and
         IsBound( category!.ring_for_representation_category!.random_matrix_between_free_left_presentations_func ) and
           IsBound( category!.ring_for_representation_category!.random_matrix_for_left_presentation_func ) then

            ADD_GRADED_RANDOM_OBJECT_RIGHT( category );

            ADD_GRADED_RANDOM_MORPHISM_WITH_FIXED_SOURCE_RIGHT( category );

            ADD_GRADED_RANDOM_MORPHISM_WITH_FIXED_RANGE_RIGHT( category );

    fi;

    if HasIsCommutative( category!.ring_for_representation_category ) and IsCommutative( category!.ring_for_representation_category ) then
      
      ADD_GRADED_TENSOR_PRODUCT_ON_OBJECTS( category );
      
      ADD_GRADED_TENSOR_PRODUCT_ON_MORPHISMS( category );
      
      ADD_GRADED_TENSOR_UNIT( category );
      
#       ADD_GRADED_INTERNAL_HOM_ON_OBJECTS_RIGHT( category );
#       
#       ADD_GRADED_INTERNAL_HOM_ON_MORPHISMS_RIGHT( category );
#       
#       ADD_GRADED_BRAIDING_RIGHT( category );
#       
#       ADD_GRADED_EVALUATION_MORPHISM_RIGHT( category );
#       
#       ADD_GRADED_COEVALUATION_MORPHISM_RIGHT( category );
      
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_CHECK_DEGREES_FOR_IS_WELL_DEFINED_FOR_OBJECTS",

  function( relation_degrees, relation_entries, generator_degrees )
    local i, j, starting_element, test_element;
    
    for i in [ 1 .. Length( relation_degrees ) ] do
          if Length( relation_degrees[ i ] ) = 0 then
              continue;
          fi;
          starting_element := 1;
          while IsZero( relation_entries[ i ][ starting_element ] ) and starting_element < Length( relation_degrees[ i ] ) do
            starting_element := starting_element + 1;
          od;
          
          if starting_element = Length( relation_degrees[ i ] ) and IsZero( relation_entries[ i ][ starting_element ] ) then
            continue;
          fi;

          test_element := relation_degrees[ i ][ starting_element ] + generator_degrees[ starting_element ];
          for j in [ starting_element + 1 .. Length( relation_degrees[ i ] ) ] do
              if not IsZero( relation_entries[ i ][ j ] ) and  relation_degrees[ i ][ j ] + generator_degrees[ j ] <> test_element then
                  return false;
              fi;
          od;
    od;
    
    return true;
    
end );

##
InstallGlobalFunction( ADD_GRADED_IS_WELL_DEFINED_FOR_OBJECTS_LEFT,
                       
  function( category )
    
    AddIsWellDefinedForObjects( category,
      
      function( object )
        local relation_degrees, generator_degrees, relation_entries;
        
        if not IsHomalgMatrix( UnderlyingMatrix( object ) ) or not IsHomalgRing( UnderlyingHomalgRing( object ) ) then
            return false;
        fi;
        
        relation_degrees := DegreesOfEntries( UnderlyingMatrix( object ) );
        relation_entries := EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( object ) );
        generator_degrees := GeneratorDegrees( object );
        
        return CAP_INTERNAL_CHECK_DEGREES_FOR_IS_WELL_DEFINED_FOR_OBJECTS( relation_degrees, relation_entries, generator_degrees );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_IS_WELL_DEFINED_FOR_OBJECTS_RIGHT,
                       
  function( category )
    
    AddIsWellDefinedForObjects( category,
      
      function( object )
        local relation_degrees, generator_degrees, relation_entries;
        
        if not IsWellDefined( UnderlyingPresentationObject( object ) ) then
            return false;
        fi;
        
        relation_degrees := TransposedMat( DegreesOfEntries( UnderlyingMatrix( object ) ) );
        relation_entries := TransposedMat( EntriesOfHomalgMatrixAsListList( UnderlyingMatrix( object ) ) );
        generator_degrees := GeneratorDegrees( object );
        
        return CAP_INTERNAL_CHECK_DEGREES_FOR_IS_WELL_DEFINED_FOR_OBJECTS( relation_degrees, relation_entries, generator_degrees );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_IS_WELL_DEFINED_FOR_MORPHISM_LEFT,
                       
  function( category )
    
    AddIsWellDefinedForMorphisms( category,
      
      function( morphism )
        local matrix, matrix_entries, matrix_entries_degrees, required_degrees;
        
        if not IsWellDefined( UnderlyingPresentationMorphism( morphism ) ) then
            return false;
        fi;
        
        matrix := UnderlyingMatrix( UnderlyingPresentationMorphism( morphism ) );
        
        matrix_entries := Flat( EntriesOfHomalgMatrixAsListList( matrix ) );
        
        matrix_entries_degrees := Flat( DegreesOfEntries( matrix ) );
        
        required_degrees := Flat( List( GeneratorDegrees( Source( morphism ) ), i -> 
                                    List( GeneratorDegrees( Range( morphism ) ), j -> i - j ) ) );
                                    
        return ForAll( [ 1 .. Length( matrix_entries ) ], 
                    i -> IsZero( matrix_entries[ i ] ) or ( matrix_entries_degrees[ i ] = required_degrees[ i ] ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT,

function( category )
    AddIsWellDefinedForMorphisms( category,
      function( morphism )
        local matrix, matrix_entries, matrix_entries_degrees, required_degrees;
        
        if not IsWellDefined( UnderlyingPresentationMorphism( morphism ) ) then
            return false;
        fi;
        
        matrix := UnderlyingMatrix( UnderlyingPresentationMorphism( morphism ) );
        
        matrix_entries := Flat( EntriesOfHomalgMatrixAsListList( matrix ) );
        
        matrix_entries_degrees := Flat( DegreesOfEntries( matrix ) );
        
        required_degrees := Flat( List( GeneratorDegrees( Range( morphism ) ), i -> 
                                    List( GeneratorDegrees( Source( morphism ) ), j -> j - i ) ) );
                                    
        return ForAll( [ 1 .. Length( matrix_entries ) ], 
                    i -> IsZero( matrix_entries[ i ] ) or ( matrix_entries_degrees[ i ] = required_degrees[ i ] ) );
    end );
end );

##
InstallGlobalFunction( ADD_GRADED_IS_IDENTICAL_FOR_MORPHISMS,
                              
  function( category )
    
    AddIsEqualForMorphisms( category,
    
      function( morphism_1, morphism_2 )
        
        return UnderlyingMatrix( morphism_1 ) = UnderlyingMatrix( morphism_2 );
        
    end );
    
    AddIsEqualForCacheForObjects( category, IsIdenticalObj );
    
    AddIsEqualForCacheForMorphisms( category, IsIdenticalObj );
    
end );

##
InstallGlobalFunction( ADD_GRADED_EQUAL_FOR_OBJECTS,
                       
  function( category )
    
    AddIsEqualForObjects( category,
                   
      function( object1, object2 )
        
        if UnderlyingMatrix( object1 ) = UnderlyingMatrix( object2 ) then
            return GeneratorDegrees( object1 ) = GeneratorDegrees( object2 );
        fi;
        return false;
        
    end );
    
end );

InstallGlobalFunction( ADD_GRADED_KERNEL_LEFT,
                       
  function( category )
    
    AddKernelEmbedding( category,
      
      function( morphism )
        local underlying_embedding, kernel_object, range_degrees, new_degrees;
        
        underlying_embedding := KernelEmbedding( UnderlyingPresentationMorphism( morphism ) );
        
        kernel_object := Source( underlying_embedding );
        
        new_degrees := NonTrivialDegreePerRow( UnderlyingMatrix( underlying_embedding ), GeneratorDegrees( Source( morphism ) ) );
        
        kernel_object := AsGradedLeftPresentation( kernel_object, new_degrees );
        
        return GradedPresentationMorphism( kernel_object, underlying_embedding, Source( morphism ) );
        
    end );
    
    AddKernelEmbeddingWithGivenKernelObject( category,
      
      function( morphism, kernel )
        local underlying_embedding;
        
        underlying_embedding := KernelEmbedding( UnderlyingPresentationMorphism( morphism ) );
        
        return GradedPresentationMorphism( kernel, underlying_embedding, Source( morphism ) );
        
    end );
    
    AddKernelLift( category,
    
      function( morphism, tau )
      local underlying_lift;
        
      underlying_lift := KernelLift( UnderlyingPresentationMorphism( morphism ), UnderlyingPresentationMorphism( tau ) );
        
      return GradedPresentationMorphism( Source( tau ), underlying_lift, KernelObject( morphism ) );
        
    end );

    
end );

##
InstallGlobalFunction( ADD_GRADED_KERNEL_RIGHT,
                       
  function( category )
    
    AddKernelEmbedding( category,
      
      function( morphism )
        local underlying_embedding, kernel_object, new_degrees, range_degrees;
        
        underlying_embedding := KernelEmbedding( UnderlyingPresentationMorphism( morphism ) );
        
        kernel_object := Source( underlying_embedding );
        
        new_degrees := NonTrivialDegreePerColumn( UnderlyingMatrix( underlying_embedding ), GeneratorDegrees( Source( morphism ) ) );
        
        kernel_object := AsGradedRightPresentation( kernel_object, new_degrees );
        
        return GradedPresentationMorphism( kernel_object, underlying_embedding, Source( morphism ) );
        
    end );
    
    AddKernelEmbeddingWithGivenKernelObject( category,
      
      function( morphism, kernel )
        local underlying_embedding;
        
        underlying_embedding := KernelEmbedding( UnderlyingPresentationMorphism( morphism ) );
        
        return GradedPresentationMorphism( kernel, underlying_embedding, Source( morphism ) );
        
    end );
    
    AddKernelLift( category,
    
    function( morphism, tau )
        local underlying_lift;
        
      underlying_lift := KernelLift( UnderlyingPresentationMorphism( morphism ), UnderlyingPresentationMorphism( tau ) );
        
      return GradedPresentationMorphism( Source( tau ), underlying_lift, KernelObject( morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_LIFT,
                       
  function( category )
    
    AddLift( category,
      
      function( alpha, beta )
        local lift;
        
        lift := Lift( UnderlyingPresentationMorphism( alpha ), UnderlyingPresentationMorphism( beta ) );
        
        if lift = fail then
            return fail;
        fi;
        
        return GradedPresentationMorphism( Source( alpha ), lift, Source( beta ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_COLIFT,
                       
  function( category )
    
    AddColift( category,
      
      function( alpha, beta )
        local colift;
        
        colift := Colift( UnderlyingPresentationMorphism( alpha ), UnderlyingPresentationMorphism( beta ) );
        
        if colift = fail then
            return fail;
        fi;
        
        return GradedPresentationMorphism( Range( alpha ), colift, Range( beta ) );
        
    end );
    
end );

InstallGlobalFunction( ADD_GRADED_EPIMORPHISM_FROM_SOME_PROJECTIVE_OBJECT, 
    
  function( category )
    
    AddEpimorphismFromSomeProjectiveObject( category, CoverByProjective );
    
end );

##
InstallGlobalFunction( ADD_GRADED_PRECOMPOSE,
                       
  function( category )
    
    AddPreCompose( category,
      
      function( left_morphism, right_morphism )
        
        return GradedPresentationMorphism( Source( left_morphism ),
                                           PreCompose( UnderlyingPresentationMorphism( left_morphism ),
                                                       UnderlyingPresentationMorphism( right_morphism ) ),
                                           Range( right_morphism ) );
      
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_ADDITION_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditionForMorphisms( category,
                             
      function( morphism_1, morphism_2 )
        
        return GradedPresentationMorphism( Source( morphism_1 ), UnderlyingPresentationMorphism( morphism_1 ) 
                                                               + UnderlyingPresentationMorphism( morphism_2 ), Range( morphism_1 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_ADDITIVE_INVERSE_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditiveInverseForMorphisms( category,
                                    
      function( morphism_1 )
        
        return GradedPresentationMorphism( Source( morphism_1 ), - UnderlyingPresentationMorphism( morphism_1 ), Range( morphism_1 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_ZERO_MORPHISM,
                       
  function( category )
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local morphism;
        
        morphism := ZeroMorphism( UnderlyingPresentationObject( source ), UnderlyingPresentationObject( range ) );
        
        return GradedPresentationMorphism( source, morphism, range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_EQUAL_FOR_MORPHISMS,
                       
  function( category )
    
    AddIsCongruentForMorphisms( category,
                            
      function( morphism_1, morphism_2 )
        
        return IsCongruentForMorphisms( UnderlyingPresentationMorphism( morphism_1 ), UnderlyingPresentationMorphism( morphism_2 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_COKERNEL,
                       
  function( category )
    local homalg_ring, object_constructor;
    
    homalg_ring := category!.ring_for_representation_category;
    
    if category!.left = true then
        object_constructor := AsGradedLeftPresentation;
    else
        object_constructor := AsGradedRightPresentation;
    fi;
    
#     AddCokernelProjection( category,
#                      
#       function( morphism )
#         local result, range_morphism, new_range;
#         
#         result := CokernelProjection( UnderlyingPresentationMorphism( morphism ) );
#         
#         range_morphism := Range( morphism );
#         
#         new_range := object_constructor( Range( result ), GeneratorDegrees( range_morphism ) );
#         
#         return GradedPresentationMorphism( range_morphism, result, new_range );
#         
#     end );
    
    AddCokernelObject( category,
                      
      function( object )
        local result;
        
        result := CokernelObject( UnderlyingPresentationMorphism( object ) );
        
        return object_constructor( result, GeneratorDegrees( Range( object ) ) );
        
    end );
    
    AddCokernelProjectionWithGivenCokernelObject( category,
                     
      function( morphism, cokernel_object )
        local projection;
        
        projection := CokernelProjectionWithGivenCokernelObject( UnderlyingPresentationMorphism( morphism ),
                                                                 UnderlyingPresentationObject( cokernel_object ) );
        
        return GradedPresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        local lift;
        
        lift := CokernelColiftWithGivenCokernelObject( UnderlyingPresentationMorphism( morphism ),
                                                       UnderlyingPresentationMorphism( test_morphism ),
                                                       UnderlyingPresentationObject( cokernel_object ) );
        
        return GradedPresentationMorphism( cokernel_object, lift, Range( test_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_DIRECT_SUM,
                       
  function( category )
    local homalg_ring, object_constructor;
    
    if category!.left = true then
        object_constructor := AsGradedLeftPresentation;
    else
        object_constructor := AsGradedRightPresentation;
    fi;
    
    AddDirectSum( category,
                  
      function( product_object )
        local objects, degrees;
        
        objects := DirectSum( List( product_object, UnderlyingPresentationObject ) );
        
        degrees := Concatenation( List( product_object, GeneratorDegrees ) );
        
        return object_constructor( objects, degrees );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
                                                 
      function( product_object, component_number, direct_sum_object )
        local underlying_objects, underlying_direct_sum, projection;
        
        underlying_objects := List( product_object, UnderlyingPresentationObject );
        
        underlying_direct_sum := UnderlyingPresentationObject( direct_sum_object );
        
        projection := ProjectionInFactorOfDirectSumWithGivenDirectSum( underlying_objects, component_number, underlying_direct_sum );
        
        return GradedPresentationMorphism( direct_sum_object, projection, product_object[ component_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
                                                                 
      function( diagram, product_morphism, direct_sum )
        local underlying_diagram, underlying_product_morphism, underlying_direct_sum, universal_morphism;
        
        underlying_diagram := List( diagram, UnderlyingPresentationObject );
        
        underlying_product_morphism := List( product_morphism, UnderlyingPresentationMorphism );
        
        underlying_direct_sum := UnderlyingPresentationObject( direct_sum );
        
        universal_morphism := UniversalMorphismIntoDirectSumWithGivenDirectSum( underlying_diagram,
                                                                                underlying_product_morphism,
                                                                                underlying_direct_sum );
        
        return GradedPresentationMorphism( Source( product_morphism[ 1 ] ), universal_morphism, direct_sum );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
                                              
      function( product_object, component_number, direct_sum_object )
        local underlying_objects, underlying_direct_sum, injection;
        
        underlying_objects := List( product_object, UnderlyingPresentationObject );
        
        underlying_direct_sum := UnderlyingPresentationObject( direct_sum_object );
        
        injection := InjectionOfCofactorOfDirectSumWithGivenDirectSum( underlying_objects, component_number, underlying_direct_sum );
        
        return GradedPresentationMorphism( product_object[ component_number ], injection, direct_sum_object );
        
    end );
    
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
                                                         
      function( diagram, product_morphism, direct_sum )
        local underlying_diagram, underlying_product_morphism, underlying_direct_sum, universal_morphism;
        
        underlying_diagram := List( diagram, UnderlyingPresentationObject );
        
        underlying_product_morphism := List( product_morphism, UnderlyingPresentationMorphism );
        
        underlying_direct_sum := UnderlyingPresentationObject( direct_sum );
        
        universal_morphism := UniversalMorphismFromDirectSumWithGivenDirectSum( underlying_diagram,
                                                                                underlying_product_morphism,
                                                                                underlying_direct_sum );
        
        return GradedPresentationMorphism( direct_sum, universal_morphism, Range( product_morphism[ 1 ] ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_ZERO_OBJECT,
                       
  function( category )
    local underlying_presentation_category, object_constructor;
    
    underlying_presentation_category := category!.underlying_presentation_category;
    
    if category!.left = true then
        object_constructor := AsGradedLeftPresentation;
    else
        object_constructor := AsGradedRightPresentation;
    fi;
    
    AddZeroObject( category,
                   
      function( )
        local zero_object;
        
        zero_object := ZeroObject( underlying_presentation_category );
        
        return object_constructor( zero_object );
        
    end );
    
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
                                                                   
      function( object, terminal_object )
        local morphism;
        
        morphism := UniversalMorphismIntoZeroObjectWithGivenZeroObject( UnderlyingPresentationObject( object ),
                                                                        UnderlyingPresentationObject( terminal_object ) );
        
        return GradedPresentationMorphism( object, morphism, terminal_object );
        
    end );
    
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
                                                                 
      function( object, initial_object )
        local morphism;
        
        morphism := UniversalMorphismFromZeroObjectWithGivenZeroObject( UnderlyingPresentationObject( object ),
                                                                        UnderlyingPresentationObject( initial_object ) );
        
        return GradedPresentationMorphism( initial_object, morphism, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_IDENTITY,
                       
  function( category )
    
    AddIdentityMorphism( category,
                         
      function( object )
        local morphism;
        
        morphism := IdentityMorphism( UnderlyingPresentationObject( object ) );
        
        return GradedPresentationMorphism( object, morphism, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_LIFT_ALONG_MONOMORPHISM,

  function( category )

    AddLiftAlongMonomorphism( category,

      function( iota, tau )
        local lift;

        lift := LiftAlongMonomorphism( UnderlyingPresentationMorphism( iota ), UnderlyingPresentationMorphism( tau ) );

        if lift = fail then
            return fail;
        fi;

        lift := GradedPresentationMorphism( Source( tau ), lift, Source( iota ) );

        if not IsWellDefined( lift ) then
          Error( "An output of the LiftAlongMonomorphism is not well-defined!" );
        fi;

        return lift;
    end );

end );

##
InstallGlobalFunction( ADD_GRADED_COLIFT_ALONG_EPIMORPHISM,

  function( category )

    AddColiftAlongEpimorphism( category,

      function( epsilon, tau )
        local colift;

        colift := ColiftAlongEpimorphism( UnderlyingPresentationMorphism( epsilon ), UnderlyingPresentationMorphism( tau ) );

        if colift = fail then
            return fail;
        fi;

        colift := GradedPresentationMorphism( Range( epsilon ), colift, Range( tau ) );

        if not IsWellDefined( colift ) then
          Error( "An output of the ColiftAlongEpimorphism is not well-defined!" );
        fi;

        return colift;
    end );

end );

##
## Interpretation of n: the matrix of the created random object has at most n rows and n cols.
##
InstallGlobalFunction( ADD_GRADED_RANDOM_OBJECT_LEFT,

  function( category )

    AddRandomObject( category,

      function( C, n )
        local homalg_ring, nr_rows, nr_cols, mat;

        homalg_ring := category!.ring_for_representation_category;

        nr_rows := Random( [ 1 .. n ] );

        nr_cols := Random( [ 1 .. n ] );

        mat := homalg_ring!.random_matrix_for_left_presentation_func( nr_rows, nr_cols );

        return AsGradedLeftPresentation( mat[ 1 ], mat[ 3 ] );

      end );

end );

##
## The number of relations of the range of the created morphism is n.
##
InstallGlobalFunction( ADD_GRADED_RANDOM_MORPHISM_WITH_FIXED_SOURCE_LEFT,

  function( category )
    local homalg_ring, Deg;

    homalg_ring := category!.ring_for_representation_category;
 
    Deg := homalg_ring!.random_degrees;

    AddRandomMorphismWithFixedSource( category,

      function( M, n )
        local m, mat, degrees_of_range, degrees_mat, y, m_y, D, syz, u, x, degrees_syz, non_trivial_degrees, positions, U, i;

        if IsZero( M ) then

          u := homalg_ring!.random_matrix_for_left_presentation_func( n, n );

          U := AsGradedLeftPresentation( u[ 1 ], u[ 3 ] );

          return ZeroMorphism( M, U );

        fi;

        m := UnderlyingMatrix( M );

        if NrRows( m ) = 0 then

          degrees_of_range := List( [ 1 .. n ], i -> Random( GeneratorDegrees( M ) ) - Random( Deg ) );

          x := homalg_ring!.random_matrix_between_free_left_presentations_func( GeneratorDegrees( M ), degrees_of_range );

          u := homalg_ring!.random_matrix_between_free_left_presentations_func( List( degrees_of_range, d -> d + Random( Deg ) ), degrees_of_range );

          U := AsGradedLeftPresentation( u, degrees_of_range );

          return GradedPresentationMorphism( M, x, U );

        fi;

        mat := UnionOfColumns( List( [ 1 .. Int( n /NrCols( m ) ) + 1 ], j -> m ) );

        mat := CertainColumns( mat, [ 1 .. n ] );

        degrees_mat := DegreesOfEntries( mat );

        y := List( degrees_mat, l -> List( l, d -> homalg_ring!.random_graded_element_func( d ) ) );

        y := HomalgMatrix( y, homalg_ring );

        m_y := UnionOfColumns( m, y );

        D := Concatenation( List( [ 1 .. Int( NrCols( m_y ) / NrCols( m ) ) + 1 ], j -> GeneratorDegrees( M ) ) );

        D := D{ [ 1 .. NrCols( m_y ) ] };

        syz := SyzygiesOfColumns( m_y );

        if NrCols( syz ) <> 0 then

            u := [ 1 .. Random( [ 1 .. NrCols( syz ) ] ) ];

            syz := CertainColumns( syz, u );

        fi;

        x := CertainRows( syz, [ 1 .. NrCols( m ) ] );

        u := CertainRows( syz, [ NrCols( m ) + 1 .. NrRows( syz ) ] );

        degrees_syz := DegreesOfEntries( syz );

        non_trivial_degrees := NonTrivialDegreePerColumn( syz );

        positions := List( [ 1 .. NrCols( syz ) ], 
            i -> Position( TransposedMat( degrees_syz )[ i ], non_trivial_degrees[ i ] ) );

        if fail in positions then

            for i in [ 1 .. NrCols( syz ) ] do
                if positions[ i ] = fail then
                  positions[ i ] := 1;
                fi;
            od;

        fi;

        degrees_of_range :=
            List( [ 1 .. NrCols( syz ) ],
            i -> D[ positions[ i ] ] - degrees_syz[ positions[ i ] ][ i ] );

        U := AsGradedLeftPresentation( u, degrees_of_range );

        return GradedPresentationMorphism( M, x, U );

      end );

end );

##
## The number of generators of the source of the created morphism is n.
##
InstallGlobalFunction( ADD_GRADED_RANDOM_MORPHISM_WITH_FIXED_RANGE_LEFT,

  function( category )
    local homalg_ring, Deg;

    homalg_ring := category!.ring_for_representation_category;

    Deg := homalg_ring!.random_degrees;

    AddRandomMorphismWithFixedRange( category,

      function( U, n )
        local u, mat, degrees_of_range, x, degrees_mat, x_u, syz, m, y, degrees_x_u, non_trivial_degrees, positions, degrees_of_source, M, i;

        if IsZero( U ) then

          m := homalg_ring!.random_matrix_for_left_presentation_func( n, n );

          M := AsGradedLeftPresentation( m[ 1 ], m[ 3 ] );

          return ZeroMorphism( M, U );

        fi;

        u := UnderlyingMatrix( U );

        if NrRows( u ) = 0 then

          degrees_of_source := List( [ 1 .. n ], i -> Random( GeneratorDegrees( U ) ) + Random( Deg ) );

          x := homalg_ring!.random_matrix_between_free_left_presentations_func( degrees_of_source, GeneratorDegrees( U ) );

          M := GradedFreeLeftPresentation( n, homalg_ring, degrees_of_source );

          return GradedPresentationMorphism( M, x, U );

        fi;

        mat := UnionOfRows( List( [ 1 .. Int( n /NrRows( u ) ) + 1 ], j -> u ) );

        mat := CertainRows( mat, [ 1 .. n ] );


        degrees_mat := DegreesOfEntries( mat );

        x := List( degrees_mat, l -> List( l, d -> homalg_ring!.random_graded_element_func( d ) ) );

        x := HomalgMatrix( x, homalg_ring );

        x_u := UnionOfRows( x, u );

        syz := SyzygiesOfRows( x_u );

        if NrRows( syz ) <> 0 then

          u := [ 1 .. Random( [ 1 .. NrRows( syz ) ] ) ];

          syz := CertainRows( syz, u );

        fi;

        m := CertainColumns( syz, [ 1 .. NrRows( x ) ] );

        y := CertainColumns( syz, [ NrRows( x ) + 1 .. NrCols( syz ) ] );

        degrees_x_u := DegreesOfEntries( x_u );

        non_trivial_degrees := NonTrivialDegreePerRow( x_u );

        positions := List( [ 1 .. NrRows( x_u ) ],
            i -> Position( degrees_x_u[ i ], non_trivial_degrees[ i ] ) );

        if fail in positions then

            for i in [ 1 .. NrRows( x_u ) ] do
                if positions[ i ] = fail then
                  positions[ i ] := 1;
                fi;
            od;

        fi;

        degrees_of_source := List( [ 1 .. NrRows( x ) ],
                    i -> GeneratorDegrees( U )[ positions[ i ] ] + degrees_x_u[ i ][ positions[ i ] ] );

        M := AsGradedLeftPresentation( m, degrees_of_source );

        return GradedPresentationMorphism( M, x, U );

      end );

end );

## 
InstallGlobalFunction( ADD_GRADED_RANDOM_OBJECT_RIGHT,

  function( category )

    AddRandomObject( category,

      function( C, n )
        local homalg_ring, graded_left_presentations, M;

        homalg_ring := category!.ring_for_representation_category;

        graded_left_presentations := GradedLeftPresentations( homalg_ring );

        M := RandomObject( graded_left_presentations, n );

        return AsGradedRightPresentation(
                    Involution( UnderlyingMatrix( M ) ),
                    GeneratorDegrees( M )
                    );
    end );

end );

##
InstallGlobalFunction( ADD_GRADED_RANDOM_MORPHISM_WITH_FIXED_SOURCE_RIGHT,

  function( category )
    local homalg_ring;

    homalg_ring := category!.ring_for_representation_category;

    AddRandomMorphismWithFixedSource( category,

      function( M, n )
        local M1, f;

        M1 := AsGradedLeftPresentation(
              Involution( UnderlyingMatrix( M ) ),
              GeneratorDegrees( M )
              );

        f := RandomMorphismWithFixedSource( M1, n );

        return
        GradedPresentationMorphism(

            AsGradedRightPresentation(
                Involution( UnderlyingMatrix( Source( f ) ) ),
                GeneratorDegrees( Source( f ) )
                                     ),

            Involution( UnderlyingMatrix( f ) ),

            AsGradedRightPresentation(
                Involution( UnderlyingMatrix( Range( f ) ) ),
                GeneratorDegrees( Range( f ) )
                                     ) );
    end );

end );

##
InstallGlobalFunction( ADD_GRADED_RANDOM_MORPHISM_WITH_FIXED_RANGE_RIGHT,

  function( category )
    local homalg_ring;

    homalg_ring := category!.ring_for_representation_category;

    AddRandomMorphismWithFixedRange( category,

      function( N, n )
        local N1, f;

        N1 := AsGradedLeftPresentation(
              Involution( UnderlyingMatrix( N ) ),
              GeneratorDegrees( N )
              );

        f := RandomMorphismWithFixedRange( N1, n );

        return
        GradedPresentationMorphism(

            AsGradedRightPresentation(
                Involution( UnderlyingMatrix( Source( f ) ) ),
                GeneratorDegrees( Source( f ) )
                                     ),

            Involution( UnderlyingMatrix( f ) ),

            AsGradedRightPresentation(
                Involution( UnderlyingMatrix( Range( f ) ) ),
                GeneratorDegrees( Range( f ) )
                                     ) );

     end );

end );

##
InstallGlobalFunction( ADD_GRADED_TENSOR_PRODUCT_ON_OBJECTS,
                      
  function( category )
    local object_constructor;
    
    if category!.left = true then
        object_constructor := AsGradedLeftPresentation;
    else
        object_constructor := AsGradedRightPresentation;
    fi;
    
    AddTensorProductOnObjects( category,
      
      function( object_1, object_2 )
        local new_object, degrees_1, degrees_2, new_degrees, i, j;
        
        new_object := TensorProductOnObjects( UnderlyingPresentationObject( object_1 ),
                                              UnderlyingPresentationObject( object_2 ) );
        
        degrees_1 := GeneratorDegrees( object_1 );
        degrees_2 := GeneratorDegrees( object_2 );
        
        new_degrees := [ ];
        
        for i in [ 1 .. Length( degrees_1 ) ] do
            for j in [ 1 .. Length( degrees_2 ) ] do
                Add( new_degrees, degrees_1[ i ] + degrees_2[ j ] );
            od;
        od;
        
        return object_constructor( new_object, new_degrees );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_TENSOR_PRODUCT_ON_MORPHISMS,
                      
  function( category )
    
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        local new_morphism;
        
        new_morphism := TensorProductOnMorphismsWithGivenTensorProducts( UnderlyingPresentationObject( new_source ),
                                                                         UnderlyingPresentationMorphism( morphism_1 ),
                                                                         UnderlyingPresentationMorphism( morphism_2 ),
                                                                         UnderlyingPresentationObject( new_range ) );
        
        return GradedPresentationMorphism( new_source, new_morphism, new_range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_TENSOR_UNIT,
                      
  function( category )
    local homalg_ring, underlying_presentation_category, object_constructor;
    
    homalg_ring := category!.ring_for_representation_category;
    underlying_presentation_category := category!.underlying_presentation_category;
    
    if category!.left = true then
        object_constructor := AsGradedLeftPresentation;
    else
        object_constructor := AsGradedRightPresentation;
    fi;
    
    AddTensorUnit( category,
      
      function( )
        local unit, new_degrees;
        
        unit := TensorUnit( underlying_presentation_category );
        
        return object_constructor( unit );
        
    end );
    
end );

## TODO: Graded internal hom
# ##
InstallGlobalFunction( ADD_GRADED_INTERNAL_HOM_ON_OBJECTS_LEFT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnObjects( category,
      
      function( object_1, object_2 )
        
        return Source( INTERNAL_GRADED_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_1, object_2 ) );
    
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_INTERNAL_HOM_ON_OBJECTS_RIGHT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnObjects( category,
      
      function( object_1, object_2 )
        
        return Source( INTERNAL_GRADED_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_1, object_2 ) );
    
    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_INTERNAL_HOM_ON_MORPHISMS_LEFT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnMorphismsWithGivenInternalHoms( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        local internal_hom_embedding_source, internal_hom_embedding_range, morphism_between_tensor_products;
        
        internal_hom_embedding_source := 
          INTERNAL_GRADED_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( Range( morphism_1 ), Source( morphism_2 ) );
        
        internal_hom_embedding_range :=
          INTERNAL_GRADED_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( Source( morphism_1 ), Range( morphism_2 ) );
        
        morphism_between_tensor_products := 
          GradedPresentationMorphism(
            Range( internal_hom_embedding_source ),
            KroneckerMat( Involution( UnderlyingMatrix( morphism_1 ) ), UnderlyingMatrix( morphism_2 ) ),
            Range( internal_hom_embedding_range )
          );
        
        return LiftAlongMonomorphism( internal_hom_embedding_range,
                                 PreCompose( internal_hom_embedding_source, morphism_between_tensor_products ) );
        
    end );

end );

##
InstallGlobalFunction( ADD_GRADED_INTERNAL_HOM_ON_MORPHISMS_RIGHT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnMorphismsWithGivenInternalHoms( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        local internal_hom_embedding_source, internal_hom_embedding_range, morphism_between_tensor_products;
        
        internal_hom_embedding_source := 
          INTERNAL_GRADED_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( Range( morphism_1 ), Source( morphism_2 ) );
        
        internal_hom_embedding_range :=
          INTERNAL_GRADED_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( Source( morphism_1 ), Range( morphism_2 ) );
        
        morphism_between_tensor_products := 
          GradedPresentationMorphism(
            Range( internal_hom_embedding_source ),
            KroneckerMat( Involution( UnderlyingMatrix( morphism_1 ) ), UnderlyingMatrix( morphism_2 ) ),
            Range( internal_hom_embedding_range )
          );
        
        return LiftAlongMonomorphism( internal_hom_embedding_range,
                                 PreCompose( internal_hom_embedding_source, morphism_between_tensor_products ) );
        
    end );

end );

##
InstallGlobalFunction( ENHANCE_GRADED_RING_WITH_RANDOM_FUNCTIONS,
    function( S )
      local indeterminates, degrees_of_indeterminates, random_graded_element_func, random_matrix_between_free_left_presentations_func, 
      random_matrix_for_left_presentation_func, R, D;

      indeterminates := Indeterminates( S );

      degrees_of_indeterminates := List( indeterminates, Degree );

      random_graded_element_func :=

        function( degree )
          local mat, p, coeffs, r, l1, l2, A, B, D, d, dD, ID, P, G, M;

          # To use the command RandomMatrixBetweenGradedFreeLeftModules, all degrees of the indeterminates should be contained in {0,1} or {0,-1}.
          if Rank( DegreeGroup( S ) ) = 1 and 
          ( IsSubset( Set( [ 0, 1 ] ), Set( List( degrees_of_indeterminates, HomalgElementToInteger ) ) ) or
            IsSubset( Set( [ 0, -1 ] ), Set( List( degrees_of_indeterminates, HomalgElementToInteger ) ) ) ) then

            mat := RandomMatrixBetweenGradedFreeLeftModules( [ degree ], [ 0 ], S );

            p := MatElm( mat, 1, 1 );

            if IsZero( p ) then

              return p;

            fi;

            p := EvalRingElement( p );

            coeffs := Coefficients( p );

            r := Random( [ 1, 1, Minimum( 2, NrRows( coeffs ) ) ] );

            l1 := EntriesOfHomalgMatrix( coeffs ){ [ 1 .. r ] };

            l2 := coeffs!.monomials{ [ 1 .. r ] };

            return ( l1*l2 )/S;

          elif IsPackageMarkedForLoading( "NConvex", "2019.02.02" ) or 
                ( IsPackageMarkedForLoading( "Convex", "2017.09.02" ) and IsPackageMarkedForLoading( "PolymakeInterface", "2018.09.25" ) ) then

            A := DegreeGroup( S );

            B := HomalgRing( A );

            D := List( degrees_of_indeterminates, UnderlyingMorphism );

            D := List( D, d -> MatrixOfMap( d ) );

            D := Involution( UnionOfRows( D ) );

            d := Involution( MatrixOfMap( UnderlyingMorphism( degree ) ) );

            dD := UnionOfColumns( -d, D );

            dD := UnionOfRows( dD, -dD );

            # We need a positive integral solution to system of inequalities dD, hence we add extra inequalities (ID).
            ID := UnionOfColumns( HomalgZeroMatrix( NrCols( D ), 1, B ), HomalgIdentityMatrix( NrCols( D ), B ) );

            # Now all we need is an integral solution to the following system of inequalities.
            D := UnionOfRows( dD, ID );

            D := EntriesOfHomalgMatrixAsListList( D );

            D := List( D, d -> List( d, e -> HomalgElementToInteger( e ) ) );

            P := ValueGlobal( "PolyhedronByInequalities" )( D );

            G := ValueGlobal( "LatticePointsGenerators" )( P );

            if G[ 1 ] = [  ] then

              return Zero( S );

            else

              if G[ 2 ] <> [  ] or G[ 3 ] <> [  ] then

                  M := List( [ 1 .. Random( [ 1, 2, 3 ] ) ], 
                       i -> Random( G[ 1 ] ) + Random( [ Zero( B ), One( B ) ] ) * Random( Concatenation( G[ 2 ], G[ 3 ], -G[ 3 ] ) ) );

              else

                  M := List( [ 1 .. Random( [ 1, 2, 3 ] ) ], i -> Random( G[ 1 ] ) );

              fi;

              P := List( M, m -> Product( List( [ 1 .. Length( indeterminates ) ], i -> indeterminates[ i ] ^ m[ i ] ) ) );

              return Sum( List( P, p -> Random( [ -10 .. 10 ] ) * One( S ) * p ) );

            fi;

          fi;

        end;

      random_matrix_between_free_left_presentations_func :=

        function( degrees_1, degrees_2 )
          local mat;

          mat := List( degrees_1,

                        i -> List( degrees_2,
                        j -> S!.random_graded_element_func( i - j ) )
                        );

          return HomalgMatrix( mat, S );
          
        end;

      random_matrix_for_left_presentation_func :=

        function( m, n )
          local D, L, K;

          D := S!.random_degrees;

          L := List( [ 1 .. m ], i -> Random( D ) );

          K := List( [ 1 .. n ], i -> Random( D ) );

          if m * n = 0 then

              return [ HomalgZeroMatrix( m, n, S ), L, K ];

          else

              return [ S!.random_matrix_between_free_left_presentations_func( L, K ), L, K ];

          fi;

        end;

      R := UnderlyingNonGradedRing( S );

      if HasIndeterminatesOfPolynomialRing( R ) or
         HasIndeterminatesOfExteriorRing( R ) or
         ( IsHomalgResidueClassRingRep( R ) and
           ( HasIndeterminatesOfPolynomialRing( AmbientRing( R ) ) or HasIndeterminatesOfExteriorRing(  AmbientRing( R ) ) ) ) then

          if  ( Rank( DegreeGroup( S ) ) = 1 and
                ( IsSubset( Set( [ 0, 1 ] ), Set( List( degrees_of_indeterminates, HomalgElementToInteger ) ) ) or
                    IsSubset( Set( [ 0, -1 ] ), Set( List( degrees_of_indeterminates, HomalgElementToInteger ) ) ) ) )
              or
              IsPackageMarkedForLoading( "NConvex", "2019.02.02" )
              or
              ( IsPackageMarkedForLoading( "Convex", "2017.09.02" ) and IsPackageMarkedForLoading( "PolymakeInterface", "2018.09.25" ) ) then

                  D := Set( List( Indeterminates( S ), Degree ) );

                  D := ShallowCopy( Combinations( Concatenation( D, D ) ) );

                  Remove( D, 1 );

                  S!.random_degrees := List( D, Sum );

                  S!.random_graded_element_func := random_graded_element_func;

                  S!.random_matrix_between_free_left_presentations_func := random_matrix_between_free_left_presentations_func;

                  S!.random_matrix_for_left_presentation_func := random_matrix_for_left_presentation_func;

          fi;

      fi;

end );


# 
# ##
# InstallGlobalFunction( ADD_GRADED_BRAIDING_LEFT,
#                       
#   function( category )
#     
#     AddBraidingWithGivenTensorProducts( category,
#       
#       function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
#         local homalg_ring, permutation_matrix, rank_1, rank_2, rank;
#         
#         homalg_ring := UnderlyingHomalgRing( object_1 );
#         
#         rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
#         
#         rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
#         
#         rank := NrColumns( UnderlyingMatrix( object_1_tensored_object_2 ) );
#         
#         permutation_matrix := PermutationMat( 
#                                 PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) ),
#                                 rank 
#                               );
#         
#         return PresentationMorphism( object_1_tensored_object_2,
#                                      HomalgMatrix( permutation_matrix, rank, rank, homalg_ring ),
#                                      object_2_tensored_object_1 );
#         
#     end );
#     
# end );
# 
# ##
# InstallGlobalFunction( ADD_GRADED_BRAIDING_RIGHT,
#                       
#   function( category )
#     
#     AddBraidingWithGivenTensorProducts( category,
#       
#       function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
#         local homalg_ring, permutation_matrix, rank_1, rank_2, rank;
#         
#         homalg_ring := UnderlyingHomalgRing( object_1 );
#         
#         rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
#         
#         rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
#         
#         rank := NrRows( UnderlyingMatrix( object_1_tensored_object_2 ) );
#         
#         permutation_matrix := PermutationMat( 
#                                 PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) ),
#                                 rank 
#                               );
#         
#         return PresentationMorphism( object_1_tensored_object_2,
#                                      Involution( HomalgMatrix( permutation_matrix, rank, rank, homalg_ring ) ), ## transposed of the left case
#                                      object_2_tensored_object_1 );
#         
#     end );
#     
# end );
# 
# ##
# InstallGlobalFunction( ADD_GRADED_EVALUATION_MORPHISM_LEFT,
#   
#   function( category )
#     local homalg_ring;
#     
#     homalg_ring := category!.ring_for_representation_category;
#     
#     AddEvaluationMorphismWithGivenSource( category,
#       
#       function( object_1, object_2, internal_hom_tensored_object_1 )
#         local internal_hom_embedding, rank_1, morphism, free_module,
#               column, zero_column, i, matrix, rank_2, lifted_evaluation;
#         
#         internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_1, object_2 );
#         
#         rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
#         
#         free_module := FreeLeftPresentation( rank_1, homalg_ring );
#         
#         morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_2 ) );
#         
#         morphism := TensorProductOnMorphisms( morphism, IdentityMorphism( object_1 ) );
#         
#         ## Computation of F^{\vee} \otimes F \rightarrow 1
#         column := [ ];
#         
#         zero_column := List( [ 1 .. rank_1 ], i -> 0 );
#         
#         for i in [ 1 .. rank_1 - 1 ] do
#           
#           Add( column, 1 );
#           
#           Append( column, zero_column );
#           
#         od;
#         
#         if rank_1 > 0 then 
#           
#           Add( column, 1 );
#           
#         fi;
#         
#         matrix := HomalgMatrix( column, rank_1 * rank_1, 1, homalg_ring );
#         
#         rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
#         
#         matrix := KroneckerMat( HomalgIdentityMatrix( rank_2, homalg_ring ), matrix );
#         
#         lifted_evaluation := PresentationMorphism( Range( morphism ), matrix, object_2 );
#         
#         return PreCompose( morphism, lifted_evaluation );
#         
#     end );
#     
# end );
# 
# ##
# InstallGlobalFunction( ADD_GRADED_EVALUATION_MORPHISM_RIGHT,
#   
#   function( category )
#     local homalg_ring;
#     
#     homalg_ring := category!.ring_for_representation_category;
#     
#     AddEvaluationMorphismWithGivenSource( category,
#       
#       function( object_1, object_2, internal_hom_tensored_object_1 )
#         local internal_hom_embedding, rank_1, morphism, free_module,
#               row, zero_row, i, matrix, rank_2, lifted_evaluation;
#         
#         internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_1, object_2 );
#         
#         rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
#         
#         free_module := FreeRightPresentation( rank_1, homalg_ring );
#         
#         morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_2 ) );
#         
#         morphism := TensorProductOnMorphisms( morphism, IdentityMorphism( object_1 ) );
#         
#         ## Construction of F^{\vee} \otimes F \rightarrow 1
#         row := [ ];
#         
#         zero_row := List( [ 1 .. rank_1 ], i -> 0 );
#         
#         for i in [ 1 .. rank_1 - 1 ] do
#           
#           Add( row, 1 );
#           
#           Append( row, zero_row );
#           
#         od;
#         
#         if rank_1 > 0 then 
#           
#           Add( row, 1 );
#           
#         fi;
#         
#         matrix := HomalgMatrix( row, 1, rank_1 * rank_1, homalg_ring );
#         
#         rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
#         
#         matrix := KroneckerMat( HomalgIdentityMatrix( rank_2, homalg_ring ), matrix );
#         
#         lifted_evaluation := PresentationMorphism( Range( morphism ), matrix, object_2 );
#         
#         return PreCompose( morphism, lifted_evaluation );
#         
#     end );
#     
# end );
# 
# ##
# InstallGlobalFunction( ADD_GRADED_COEVALUATION_MORPHISM_LEFT,
#   
#   function( category )
#     local homalg_ring;
#     
#     homalg_ring := category!.ring_for_representation_category;
#     
#     AddCoevaluationMorphismWithGivenRange( category,
#       
#       function( object_1, object_2, internal_hom )
#         local object_1_tensored_object_2, internal_hom_embedding, rank_2, free_module, morphism,
#               row, zero_row, i, matrix, rank_1, lifted_coevaluation;
#         
#         object_1_tensored_object_2 := TensorProductOnObjects( object_1, object_2 );
#         
#         internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_2, object_1_tensored_object_2 );
#         
#         rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
#         
#         free_module := FreeLeftPresentation( rank_2, homalg_ring );
#         
#         morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_1_tensored_object_2 ) );
#         
#         ## Construction of 1 \rightarrow F \otimes F^{\vee}
#         
#         row := [ ];
#         
#         zero_row := List( [ 1 .. rank_2 ], i -> 0 );
#         
#         for i in [ 1 .. rank_2 - 1 ] do
#           
#           Add( row, 1 );
#           
#           Append( row, zero_row );
#           
#         od;
#         
#         if rank_2 > 0 then 
#           
#           Add( row, 1 );
#           
#         fi;
#         
#         matrix := HomalgMatrix( row, 1, rank_2 * rank_2, homalg_ring );
#         
#         rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
#         
#         matrix := KroneckerMat( HomalgIdentityMatrix( rank_1, homalg_ring ), matrix );
#         
#         lifted_coevaluation := PresentationMorphism( object_1, matrix, Range( morphism ) );
#         
#         return LiftAlongMonomorphism( morphism, lifted_coevaluation );
#         
#     end );
#     
# end );
# 
# ##
# InstallGlobalFunction( ADD_GRADED_COEVALUATION_MORPHISM_RIGHT,
#   
#   function( category )
#     local homalg_ring;
#     
#     homalg_ring := category!.ring_for_representation_category;
#     
#     AddCoevaluationMorphismWithGivenRange( category,
#       
#       function( object_1, object_2, internal_hom )
#         local object_1_tensored_object_2, internal_hom_embedding, rank_2, free_module, morphism,
#               column, zero_column, i, matrix, rank_1, lifted_coevaluation;
#         
#         object_1_tensored_object_2 := TensorProductOnObjects( object_1, object_2 );
#         
#         internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_2, object_1_tensored_object_2 );
#         
#         rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
#         
#         free_module := FreeRightPresentation( rank_2, homalg_ring );
#         
#         morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_1_tensored_object_2 ) );
#         
#         ## Construction of 1 \rightarrow F \otimes F^{\vee}
#         
#         column := [ ];
#         
#         zero_column := List( [ 1 .. rank_2 ], i -> 0 );
#         
#         for i in [ 1 .. rank_2 - 1 ] do
#           
#           Add( column, 1 );
#           
#           Append( column, zero_column );
#           
#         od;
#         
#         if rank_2 > 0 then 
#           
#           Add( column, 1 );
#           
#         fi;
#         
#         matrix := HomalgMatrix( column, rank_2 * rank_2, 1, homalg_ring );
#         
#         rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
#         
#         matrix := KroneckerMat( HomalgIdentityMatrix( rank_1, homalg_ring ), matrix );
#         
#         lifted_coevaluation := PresentationMorphism( object_1, matrix, Range( morphism ) );
#         
#         return LiftAlongMonomorphism( morphism, lifted_coevaluation );
#         
#     end );
#     
# end );

