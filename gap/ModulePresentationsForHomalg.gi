#############################################################################
##
##                                       ModulePresentationsForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

##
InstallMethod( LeftPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    category := CreateHomalgCategory( Concatenation( "Category of left presentations of ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    ADD_FUNCTIONS_FOR_LEFT_PRESENTATION( category );
    
    return category;
    
end );

##
InstallMethod( RightPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    category := CreateHomalgCategory( Concatenation( "Category of right presentations of ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION( category );
    
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
    
end );

##
InstallGlobalFunction( ADD_KERNEL_LEFT,
                       
  function( category )
    
    AddKernelEmb( category,
      
      function( morphism )
        local kernel, embedding;
        
        embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        kernel := SyzygiesOfRows( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        kernel := AsLeftPresentation( kernel );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
    AddMonoAsKernelLift( category,
                         
      function( monomorphism, test_morphism )
        local lift;
        
        lift := RightDivide( UnderlyingMatrix( test_morphism ), UnderlyingMatrix( monomorphism ), UnderlyingMatrix( Range( monomorphism ) ) );
        
        if lift = false then
            return false;
        fi;
        
        return PresentationMorphism( Source( test_morphism ), lift, Source( monomorphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_KERNEL_RIGHT,
                       
  function( category )
    
    AddKernelEmb( category,
      
      function( morphism )
        local kernel, embedding;
        
        embedding := SyzygiesOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        kernel := SyzygiesOfColumns( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        kernel := AsRightPresentation( kernel );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
    AddMonoAsKernelLift( category,
                         
      function( monomorphism, test_morphism )
        local lift;
        
        lift := LeftDivide( UnderlyingMatrix( monomorphism ), UnderlyingMatrix( test_morphism ), UnderlyingMatrix( Range( monomorphism ) ) );
        
        if lift = false then
            return false;
        fi;
        
        return PresentationMorphism( Source( test_morphism ), lift, Source( monomorphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_PRECOMPOSE_LEFT,
                       
  function( category )
    
    AddPreCompose( category,
                   
      function( left_morphism, right_morphism )
        
        return PresentationMorphism( Source( left_morphism ), UnderlyingMatrix( left_morphism ) * UnderlyingMatrix( right_morphism ), Range( right_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_PRECOMPOSE_RIGHT,
                       
  function( category )
    
    AddPreCompose( category,
                   
      function( left_morphism, right_morphism )
        
        return PresentationMorphism( Source( left_morphism ), UnderlyingMatrix( right_morphism ) * UnderlyingMatrix( left_morphism ), Range( right_morphism ) );
        
    end );
    
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
    
    AddIsZeroForMorphisms( category,
                           
      function( morphism )
        
        return IsZero( UnderlyingMatrix( morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_MORPHISM_LEFT,
                       
  function( category )
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local matrix;
        
        matrix := HomalgZeroMatrix( NrColumns( UnderlyingMatrix( source ) ), NrColumns( UnderlyingMatrix( range ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( source, matrix, range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_MORPHISM_RIGHT,
                       
  function( category )
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local matrix;
        
        matrix := HomalgZeroMatrix( NrRows( UnderlyingMatrix( range ) ), NrRows( UnderlyingMatrix( source ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( source, matrix, range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_MORPHISMS_LEFT,
                       
  function( category )
    
    AddEqualityOfMorphisms( category,
                            
      function( morphism_1, morphism_2 )
        local result_of_divide;
        
        result_of_divide := DecideZeroRows( UnderlyingMatrix( morphism_1 ) - UnderlyingMatrix( morphism_2 ), UnderlyingMatrix( Range( morphism_1 ) ) );
        
        return IsZero( result_of_divide );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_MORPHISMS_RIGHT,
                       
  function( category )
    
    AddEqualityOfMorphisms( category,
                            
      function( morphism_1, morphism_2 )
        local result_of_divide;
        
        result_of_divide := DecideZeroColumns( UnderlyingMatrix( morphism_1 ) - UnderlyingMatrix( morphism_2 ), UnderlyingMatrix( Range( morphism_1 ) ) );
        
        return IsZero( result_of_divide );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COKERNEL_LEFT,
                       
  function( category )
    
    AddCokernelProj( category,
                     
      function( morphism )
        local cokernel_object, projection;
        
        cokernel_object := UnionOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        cokernel_object := AsLeftPresentation( cokernel_object );
        
        projection := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( Range( morphism ) ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddEpiAsCokernelColift( category,
                            
      function( epimorphism, test_morphism )
        local lift;
        
        lift := LeftDivide( UnderlyingMatrix( epimorphism ), UnderlyingMatrix( test_morphism ), UnderlyingMatrix( Range( test_morphism ) ) );
        
        if lift = false then
            return false;
        fi;
        
        return PresentationMorphism( Range( epimorphism ), lift, Range( test_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COKERNEL_RIGHT,
                       
  function( category )
    
    AddCokernelProj( category,
                     
      function( morphism )
        local cokernel_object, projection;
        
        cokernel_object := UnionOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        cokernel_object := AsRightPresentation( cokernel_object );
        
        projection := HomalgIdentityMatrix( NrRows( UnderlyingMatrix( Range( morphism ) ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddEpiAsCokernelColift( category,
                            
      function( epimorphism, test_morphism )
        local lift;
        
        lift := RightDivide( UnderlyingMatrix( test_morphism ), UnderlyingMatrix( epimorphism ), UnderlyingMatrix( Range( test_morphism ) ) );
        
        if lift = false then
            return false;
        fi;
        
        return PresentationMorphism( Range( epimorphism ), lift, Range( test_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_DIRECT_SUM_LEFT,
                       
  function( category )
    
    AddDirectSum( category,
                  
      function( product_object )
        local objects, direct_sum;
        
        objects := Components( product_object );
        
        objects := List( objects, UnderlyingMatrix );
        
        direct_sum := DiagMat( objects );
        
        return AsLeftPresentation( direct_sum );
        
    end );
    
    AddProjectionInFactorWithGivenDirectProduct( category,
                                                 
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, projection, projection_matrix, i;
        
        objects := Components( product_object );
        
        object_column_dimension := List( objects, i -> NrColumns( UnderlyingMatrix( i ) ) );
        
        projection := List( object_column_dimension, i -> HomalgZeroMatrix( i, i, category!.ring_for_representation_category ) );
        
        projection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], category!.ring_for_representation_category );
        
        projection_matrix := projection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            projection_matrix := UnionOfRows( projection_matrix, projection[ i ] );
            
        od;
        
        return PresentationMorphism( direct_sum_object, projection_matrix, objects[ component_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( category,
                                                                 
      function( product_morphism, direct_sum )
        local components, number_of_components, map_into_product, i;
        
        components := Components( product_morphism );
        
        number_of_components := Length( components );
        
        map_into_product := UnderlyingMatrix( components[ 1 ] );
        
        for i in [ 2 .. number_of_components ] do
            
            map_into_product := UnionOfColumns( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( Source( components[ 1 ] ), map_into_product, direct_sum );
        
    end );
    
    AddInjectionOfCofactorWithGivenCoproduct( category,
                                              
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, projection, projection_matrix, i;
        
        objects := Components( product_object );
        
        object_column_dimension := List( objects, i -> NrColumns( UnderlyingMatrix( i ) ) );
        
        projection := List( object_column_dimension, i -> HomalgZeroMatrix( i, i, category!.ring_for_representation_category ) );
        
        projection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], category!.ring_for_representation_category );
        
        projection_matrix := projection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            projection_matrix := UnionOfColumns( projection_matrix, projection[ i ] );
            
        od;
        
        return PresentationMorphism( objects[ component_number ], projection_matrix, product_object );
        
    end );
    
    AddUniversalMorphismFromCoproductWithGivenCoproduct( category,
                                                         
      function( product_morphism, direct_sum )
        local components, number_of_components, map_into_product, i;
        
        components := Components( product_morphism );
        
        number_of_components := Length( components );
        
        map_into_product := UnderlyingMatrix( components[ 1 ] );
        
        for i in [ 2 .. number_of_components ] do
            
            map_into_product := UnionOfRows( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( direct_sum, map_into_product, Range( components[ 1 ] ) );
        
    end );
    
end );
