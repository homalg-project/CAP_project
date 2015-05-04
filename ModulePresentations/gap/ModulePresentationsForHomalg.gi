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
    
    category := CreateCapCategory( Concatenation( "Category of left presentations of ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    SetIsAbelianCategory( category, true );
    
    ADD_FUNCTIONS_FOR_LEFT_PRESENTATION( category );
    
    AddCategoryToFamily( category, "ModuleCategory" );
    
    
    ## TODO: avoid code duplication (see RightPresentations)
    AddTheoremFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForHomalg", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForHomalg", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForHomalg", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    
    return category;
    
end );

##
InstallMethod( RightPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "Category of right presentations of ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION( category );
    
    SetIsAbelianCategory( category, true );
    
    AddCategoryToFamily( category, "ModuleCategory" );
    
    ## TODO: avoid code duplication (see LeftPresentations)
    AddTheoremFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForHomalg", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForHomalg", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForHomalg", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    
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
    
    AddKernelEmb( category,
      
      function( morphism )
        local kernel, embedding;
        
        embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        kernel := SyzygiesOfRows( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        kernel := AsLeftPresentation( kernel );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
    AddKernelEmbWithGivenKernelObject( category,
      
      function( morphism, kernel )
        local embedding;
        
        embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
    AddMonoAsKernelLift( category,
                         
      function( monomorphism, test_morphism )
        local lift;
        
        lift := RightDivide( UnderlyingMatrix( test_morphism ), UnderlyingMatrix( monomorphism ), UnderlyingMatrix( Range( monomorphism ) ) );
        
        if lift = fail then
            return fail;
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
    
    AddKernelEmbWithGivenKernelObject( category,
      
      function( morphism, kernel )
        local embedding;
        
        embedding := SyzygiesOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
    AddMonoAsKernelLift( category,
                         
      function( monomorphism, test_morphism )
        local lift;
        
        lift := LeftDivide( UnderlyingMatrix( monomorphism ), UnderlyingMatrix( test_morphism ), UnderlyingMatrix( Range( monomorphism ) ) );
        
        if lift = fail then
            return fail;
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
    
    AddIsEqualForMorphisms( category,
                            
      function( morphism_1, morphism_2 )
        local result_of_divide;
        
        result_of_divide := DecideZeroRows( UnderlyingMatrix( morphism_1 ) - UnderlyingMatrix( morphism_2 ), UnderlyingMatrix( Range( morphism_1 ) ) );
        
        return IsZero( result_of_divide );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_MORPHISMS_RIGHT,
                       
  function( category )
    
    AddIsEqualForMorphisms( category,
                            
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
    
    AddCokernelProjWithGivenCokernel( category,
                     
      function( morphism, cokernel_object )
        local projection;
        
        projection := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( Range( morphism ) ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelColiftWithGivenCokernel( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        return PresentationMorphism( cokernel_object, UnderlyingMatrix( test_morphism ), Range( test_morphism ) );
        
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
    
    AddCokernelProjWithGivenCokernel( category,
                     
      function( morphism, cokernel_object )
        local projection;
        
        projection := HomalgIdentityMatrix( NrRows( UnderlyingMatrix( Range( morphism ) ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelColiftWithGivenCokernel( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        return PresentationMorphism( cokernel_object, UnderlyingMatrix( test_morphism ), Range( test_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_DIRECT_SUM_LEFT,
                       
  function( category )
    
    AddDirectSum( category,
                  
      function( product_object )
        local objects, direct_sum;
        
        objects := product_object;
        
        objects := List( objects, UnderlyingMatrix );
        
        direct_sum := DiagMat( objects );
        
        return AsLeftPresentation( direct_sum );
        
    end );
    
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( category,
                                                 
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_factor, projection, projection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrColumns( UnderlyingMatrix( i ) ) );
        
        dimension_of_factor := object_column_dimension[ component_number ];
        
        projection := List( object_column_dimension, i -> 
                            HomalgZeroMatrix( i, dimension_of_factor, category!.ring_for_representation_category ) );
        
        projection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], category!.ring_for_representation_category );
        
        projection_matrix := projection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            projection_matrix := UnionOfRows( projection_matrix, projection[ i ] );
            
        od;
        
        return PresentationMorphism( direct_sum_object, projection_matrix, objects[ component_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( category,
                                                                 
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
    
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( category,
                                              
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_cofactor, injection, injection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrColumns( UnderlyingMatrix( i ) ) );
        
        dimension_of_cofactor := object_column_dimension[ component_number ];
        
        injection := List( object_column_dimension, i -> HomalgZeroMatrix( dimension_of_cofactor, i, category!.ring_for_representation_category ) );
        
        injection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], category!.ring_for_representation_category );
        
        injection_matrix := injection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            injection_matrix := UnionOfColumns( injection_matrix, injection[ i ] );
            
        od;
        
        return PresentationMorphism( objects[ component_number ], injection_matrix, direct_sum_object );
        
    end );
    
    AddUniversalMorphismFromCoproductWithGivenCoproduct( category,
                                                         
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
    
    AddDirectSum( category,
                  
      function( product_object )
        local objects, direct_sum;
        
        objects := product_object;
        
        objects := List( objects, UnderlyingMatrix );
        
        direct_sum := DiagMat( objects );
        
        return AsLeftPresentation( direct_sum );
        
    end );
    
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( category,
                                                 
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_factor, projection, projection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrRows( UnderlyingMatrix( i ) ) );
        
        dimension_of_factor := object_column_dimension[ component_number ];
        
        projection := List( object_column_dimension, i -> HomalgZeroMatrix( dimension_of_factor, i, category!.ring_for_representation_category ) );
        
        projection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], category!.ring_for_representation_category );
        
        projection_matrix := projection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            projection_matrix := Columns( projection_matrix, projection[ i ] );
            
        od;
        
        return PresentationMorphism( direct_sum_object, projection_matrix, objects[ component_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( category,
                                                                 
      function( product_morphism, direct_sum )
        local components, number_of_components, map_into_product, i;
        
        components := product_morphism;
        
        number_of_components := Length( components );
        
        map_into_product := UnderlyingMatrix( components[ 1 ] );
        
        for i in [ 2 .. number_of_components ] do
            
            map_into_product := UnionOfRows( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( Source( components[ 1 ] ), map_into_product, direct_sum );
        
    end );
    
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( category,
                                              
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_cofactor, injection, injection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrRows( UnderlyingMatrix( i ) ) );
        
        dimension_of_cofactor := object_column_dimension[ component_number ];
        
        injection := List( object_column_dimension, i -> HomalgZeroMatrix( i, dimension_of_cofactor, category!.ring_for_representation_category ) );
        
        injection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], category!.ring_for_representation_category );
        
        injection_matrix := injection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            injection_matrix := UnionOfRows( injection_matrix, injection[ i ] );
            
        od;
        
        return PresentationMorphism( objects[ component_number ], injection_matrix, direct_sum_object );
        
    end );
    
    AddUniversalMorphismFromCoproductWithGivenCoproduct( category,
                                                         
      function( product_morphism, direct_sum )
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
    
    AddZeroObject( category,
                   
      function( )
        local matrix;
        
        matrix := HomalgZeroMatrix( 0, 0, category!.ring_for_representation_category );
        
        return AsLeftPresentation( matrix );
        
    end );
    
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( category,
                                                                   
      function( object, terminal_object )
        local nr_columns, morphism;
        
        nr_columns := NrColumns( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( nr_columns, 0, category!.ring_for_representation_category );
        
        return PresentationMorphism( object, morphism, terminal_object );
        
    end );
    
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( category,
                                                                 
      function( object, initial_object )
        local nr_columns, morphism;
        
        nr_columns := NrColumns( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( 0, nr_columns, category!.ring_for_representation_category );
        
        return PresentationMorphism( initial_object, morphism, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_OBJECT_RIGHT,
                       
  function( category )
    
    AddZeroObject( category,
                   
      function( )
        local matrix;
        
        matrix := HomalgZeroMatrix( 0, 0, category!.ring_for_representation_category );
        
        return AsRightPresentation( matrix );
        
    end );
    
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( category,
                                                                   
      function( object, terminal_object )
        local nr_rows, morphism;
        
        nr_rows := NrRows( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( 0, nr_rows, category!.ring_for_representation_category );
        
        return PresentationMorphism( object, morphism, terminal_object );
        
    end );
    
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( category,
                                                                 
      function( object, initial_object )
        local nr_rows, morphism;
        
        nr_rows := NrRows( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( nr_rows, 0, category!.ring_for_representation_category );
        
        return PresentationMorphism( initial_object, morphism, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IDENTITY_LEFT,
                       
  function( category )
    
    AddIdentityMorphism( category,
                         
      function( object )
        local matrix;
        
        matrix := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( object ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( object, matrix, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IDENTITY_RIGHT,
                       
  function( category )
    
    AddIdentityMorphism( category,
                         
      function( object )
        local matrix;
        
        matrix := HomalgIdentityMatrix( NrRows( UnderlyingMatrix( object ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( object, matrix, object );
        
    end );
    
end );
