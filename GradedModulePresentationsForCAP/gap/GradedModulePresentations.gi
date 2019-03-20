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

    if HasIsCommutative( ring ) and IsCommutative( ring ) then
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
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
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
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
    
        ADD_GRADED_LIFT( category, "left" );
    
    fi;
    
    if CanCompute( category!.underlying_presentation_category, "Colift" ) then
    
        ADD_GRADED_COLIFT( category, "left" );
    
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
    
    if HasIsCommutative( category!.ring_for_representation_category ) and IsCommutative( category!.ring_for_representation_category ) then
      
      ADD_GRADED_UNITOR( category );
      
      ADD_GRADED_ASSOCIATOR_LEFT( category );
      
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
    
        ADD_GRADED_LIFT( category, "right" );
    
    fi;
    
    if CanCompute( category!.underlying_presentation_category, "Colift" ) then
    
        ADD_GRADED_COLIFT( category, "right" );
    
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
    
    if HasIsCommutative( category!.ring_for_representation_category ) and IsCommutative( category!.ring_for_representation_category ) then
      
      ADD_GRADED_UNITOR( category );
      
      ADD_GRADED_ASSOCIATOR_RIGHT( category );
      
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
                       
  function( category, left_or_right )
    
    AddLift( category,
      
      function( alpha, beta )
        local lift, required_degrees;
        
        lift := Lift( UnderlyingPresentationMorphism( alpha ), UnderlyingPresentationMorphism( beta ) );
        
        if lift = fail then
        
            return fail;
        
        fi;
        
        if left_or_right = "left" then

          required_degrees := List( GeneratorDegrees( Source( alpha ) ),
                                i -> List( GeneratorDegrees( Source( beta ) ), j -> i - j ) );
        else

          required_degrees := List( GeneratorDegrees( Source( beta ) ),
                                i -> List( GeneratorDegrees( Source( alpha ) ), j -> j - i ) );
        fi;

        lift := HomogeneousPartOfMatrix( UnderlyingMatrix( lift ), required_degrees );

        return GradedPresentationMorphism( Source( alpha ), lift, Source( beta ) );

    end );
    
end );

##
InstallGlobalFunction( ADD_GRADED_COLIFT,
                       
  function( category, left_or_right )
    
    AddColift( category,
      
      function( alpha, beta )
        local colift, required_degrees;
        
        colift := Colift( UnderlyingPresentationMorphism( alpha ), UnderlyingPresentationMorphism( beta ) );
        
        if colift = fail then
        
          return fail;
        
        fi;
        
        if left_or_right = "left" then

          required_degrees := List( GeneratorDegrees( Range( alpha ) ),
                                i -> List( GeneratorDegrees( Range( beta ) ), j -> i - j ) );
        else

          required_degrees := List( GeneratorDegrees( Range( beta ) ),
                                i -> List( GeneratorDegrees( Range( alpha ) ), j -> j - i ) );
        fi;

        colift := HomogeneousPartOfMatrix( UnderlyingMatrix( colift ), required_degrees );

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
        
        return GradedPresentationMorphism( Source( tau ), lift, Source( iota ) );

    end );

end );

##
InstallGlobalFunction( ADD_GRADED_COLIFT_ALONG_EPIMORPHISM,

  function( category )

    AddColiftAlongEpimorphism( category,

      function( epsilon, tau )
        local colift;

        colift := ColiftAlongEpimorphism( UnderlyingPresentationMorphism( epsilon ), UnderlyingPresentationMorphism( tau ) );

        return GradedPresentationMorphism( Range( epsilon ), colift, Range( tau ) );

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
InstallGlobalFunction( ADD_GRADED_UNITOR,
                      
  function( category )
    local unitor_func;
    
    unitor_func := function( A, B )
        return IdentityMorphism( A );
    end;
    
    AddLeftUnitorWithGivenTensorProduct( category, unitor_func );
    
    AddRightUnitorWithGivenTensorProduct( category, unitor_func );
    
end );

##
InstallGlobalFunction( ADD_GRADED_ASSOCIATOR_LEFT,
                      
  function( category )
    local homalg_ring, associator_func;
    
    homalg_ring := category!.ring_for_representation_category;
    
    associator_func := function( source, A, B, C, range )
        
        return GradedPresentationMorphism(
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
InstallGlobalFunction( ADD_GRADED_ASSOCIATOR_RIGHT,
                      
  function( category )
    local homalg_ring, associator_func;
    
    homalg_ring := category!.ring_for_representation_category;
    
    associator_func := function( source, A, B, C, range )
        
        return GradedPresentationMorphism(
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

