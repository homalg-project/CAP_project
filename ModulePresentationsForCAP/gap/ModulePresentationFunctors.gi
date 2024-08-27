# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Implementations
#

#######################################
##
## FunctorStandardModule
##
#######################################

BindGlobal( "INSTALL_FUNCTOR_STANDARD_MODULE_METHODS",
            
  function( functor_standard_module, is_category_of_presentations, presentations, basis_of_module, decide_zero, as_presentation )
    
    InstallMethod( functor_standard_module,
                   [ IsHomalgRing ],
                   
      function( ring )
        
        return functor_standard_module( presentations( ring ) );
        
    end );
    
    InstallOtherMethod( functor_standard_module,
                        [ is_category_of_presentations ],
                        
      function( category )
        local functor;
        
        functor := CapFunctor( Concatenation( "Standard module for ", Name( category ) ), category, category );
        
        AddObjectFunction( functor,
                           
          function( object )
            local matrix;
            
            matrix := basis_of_module( UnderlyingMatrix( object ) );
            
            return as_presentation( category, matrix );
            
        end );
        
        AddMorphismFunction( functor,
                             
          function( new_source, morphism, new_range )
            local matrix;
            
            matrix := UnderlyingMatrix( morphism );
            
            matrix := decide_zero( matrix, UnderlyingMatrix( new_range ) );
            
            return PresentationMorphism( new_source, matrix, new_range );
            
        end );
        
        return functor;
        
    end );
    
end );

BindGlobal( "INSTALL_FUNCTOR_STANDARD_MODULE",
            
  function( )
    
    INSTALL_FUNCTOR_STANDARD_MODULE_METHODS( FunctorStandardModuleLeft,  IsCategoryOfLeftPresentations, LeftPresentations,  BasisOfRowModule,    DecideZeroRows,    AsLeftPresentation  );
    
    INSTALL_FUNCTOR_STANDARD_MODULE_METHODS( FunctorStandardModuleRight, IsCategoryOfRightPresentations, RightPresentations, BasisOfColumnModule, DecideZeroColumns, AsRightPresentation );
    
end );

INSTALL_FUNCTOR_STANDARD_MODULE( );

#######################################
##
## FunctorGetRidOfZeroGenerators
##
#######################################

BindGlobal( "INSTALL_FUNCTOR_GET_RID_OF_ZERO_GENERATORS_METHODS",
            
  function( functor_get_rid_of_zero_generators, presentations, get_rid_of_zero_generators_transformation_triple, as_presentation, parity )
    
    InstallMethod( functor_get_rid_of_zero_generators,
                   [ IsHomalgRing ],
                   
      function( ring )
        local category, functor;
        
        category := presentations( ring );
        
        functor := CapFunctor( Concatenation( "Get rid of zero generators for ", Name( category ) ), category, category );
        
        AddObjectFunction( functor,
                           
          function( object )
            local matrix, triple;
            
            matrix := UnderlyingMatrix( object );
            
            matrix := get_rid_of_zero_generators_transformation_triple( matrix );
            
            return as_presentation( matrix[1] );
            
        end );
        
        if parity = "left" then
            
            AddMorphismFunction( functor,
                    
              function( new_source, morphism, new_range )
                local source_transformation_triple, range_transformation_triple, new_morphism_matrix;
                
                source_transformation_triple := get_rid_of_zero_generators_transformation_triple( UnderlyingMatrix( Source( morphism ) ) );
                
                range_transformation_triple := get_rid_of_zero_generators_transformation_triple( UnderlyingMatrix( Range( morphism ) ) );
                
                new_morphism_matrix := UnderlyingMatrix( morphism );
                
                new_morphism_matrix := source_transformation_triple[ 3 ] * new_morphism_matrix * range_transformation_triple[ 2 ];
                
                return PresentationMorphism( new_source, new_morphism_matrix, new_range );
                
            end );
            
        else
              
            AddMorphismFunction( functor,
                    
              function( new_source, morphism, new_range )
                local source_transformation_triple, range_transformation_triple, new_morphism_matrix;
                
                source_transformation_triple := get_rid_of_zero_generators_transformation_triple( UnderlyingMatrix( Source( morphism ) ) );
                
                range_transformation_triple := get_rid_of_zero_generators_transformation_triple( UnderlyingMatrix( Range( morphism ) ) );
                
                new_morphism_matrix := UnderlyingMatrix( morphism );
                
                new_morphism_matrix := range_transformation_triple[ 2 ] * new_morphism_matrix * source_transformation_triple[ 3 ];
                
                return PresentationMorphism( new_source, new_morphism_matrix, new_range );
                
            end );
            
        fi;
        
        return functor;
        
    end );
    
end );

BindGlobal( "INSTALL_FUNCTOR_GET_RID_OF_ZERO_GENERATORS",
            
  function( )
    
    INSTALL_FUNCTOR_GET_RID_OF_ZERO_GENERATORS_METHODS(
            FunctorGetRidOfZeroGeneratorsLeft,  LeftPresentations,  NonZeroGeneratorsTransformationTripleLeft,  AsLeftPresentation,  "left" );
    
    INSTALL_FUNCTOR_GET_RID_OF_ZERO_GENERATORS_METHODS(
            FunctorGetRidOfZeroGeneratorsRight, RightPresentations, NonZeroGeneratorsTransformationTripleRight, AsRightPresentation, "right" );
    
end );

INSTALL_FUNCTOR_GET_RID_OF_ZERO_GENERATORS( );

#######################################
##
## FunctorLessGenerators
##
#######################################

##
InstallMethod( FunctorLessGeneratorsLeft,
               [ IsHomalgRing ],
               
  function( ring )
    
    return FunctorLessGeneratorsLeft( LeftPresentations( ring ) );
    
end );

##
InstallOtherMethod( FunctorLessGeneratorsLeft,
                    [ IsCategoryOfLeftPresentations ],
                    
  function( category )
    local functor;
    
    functor := CapFunctor( Concatenation( "Less generators for ", Name( category ) ), category, category );
    
    AddObjectFunction( functor,
                       
      function( object )
        local new_object;
        
        new_object := LessGeneratorsTransformationTripleLeft( UnderlyingMatrix( object ) )[1];
        
        return AsLeftPresentation( category, new_object );
        
    end );
    
    AddMorphismFunction( functor,
                         
      function( new_source, morphism, new_range )
        local source_transformation_triple, range_transformation_triple, new_morphism_matrix;
        
        source_transformation_triple := LessGeneratorsTransformationTripleLeft( UnderlyingMatrix( Source( morphism ) ) );
        
        range_transformation_triple := LessGeneratorsTransformationTripleLeft( UnderlyingMatrix( Range( morphism ) ) );
        
        new_morphism_matrix := UnderlyingMatrix( morphism );
        
        new_morphism_matrix := source_transformation_triple[ 3 ] * new_morphism_matrix * range_transformation_triple[ 2 ];
        
        return PresentationMorphism( new_source, new_morphism_matrix, new_range );
        
    end );
    
    return functor;
    
end );

##
InstallMethod( FunctorLessGeneratorsRight,
               [ IsHomalgRing ],
               
  function( ring )
    
    return FunctorLessGeneratorsRight( RightPresentations( ring ) );
    
end );

##
InstallOtherMethod( FunctorLessGeneratorsRight,
                    [ IsCategoryOfRightPresentations ],
                     
  function( category )
    local functor;
    
    functor := CapFunctor( Concatenation( "Less generators for ", Name( category ) ), category, category );
    
    AddObjectFunction( functor,
                       
      function( object )
        local new_object;
        
        new_object := LessGeneratorsTransformationTripleRight( UnderlyingMatrix( object ) )[1];
        
        return AsRightPresentation( category, new_object );
        
    end );
    
    AddMorphismFunction( functor,
                         
      function( new_source, morphism, new_range )
        local source_transformation_triple, range_transformation_triple, new_morphism_matrix;
        
        source_transformation_triple := LessGeneratorsTransformationTripleRight( UnderlyingMatrix( Source( morphism ) ) );
        
        range_transformation_triple := LessGeneratorsTransformationTripleRight( UnderlyingMatrix( Range( morphism ) ) );
        
        new_morphism_matrix := UnderlyingMatrix( morphism );
        
        new_morphism_matrix := range_transformation_triple[ 2 ] * new_morphism_matrix * source_transformation_triple[ 3 ];
        
        return PresentationMorphism( new_source, new_morphism_matrix, new_range );
        
    end );
    
    return functor;
    
end );

##
InstallMethod( FunctorDualLeft,
               [ IsHomalgRing ],
               
  function( ring )
    
    return FunctorDualLeft( LeftPresentations( ring ) );
    
end );

##
InstallOtherMethod( FunctorDualLeft,
                    [ IsCategoryOfLeftPresentations ],
                    
   function( category )
     local ring, functor;
     
     ring := UnderlyingRing( category );
     
     functor := CapFunctor( Concatenation( "Hom( , R ) functor for ", Name( category ) ), Opposite( category ), category );
     
     AddObjectFunction( functor, 
     
           function( obj )
           local object, mat, N, M, mor; 
           
           object := Opposite( obj );
           
           mat := UnderlyingMatrix( object );
           
           N := FreeLeftPresentation( NrColumns( mat ), ring );
           
           M := FreeLeftPresentation( NrRows( mat ), ring );
           
           mor := PresentationMorphism( N, Involution( mat ), M );
           
           return KernelObject( mor );
           
           end );
           
    AddMorphismFunction( functor, 
    
           function( new_source, morphism_, new_range )
           local morphism, matrix_of_morphism, mor1, mor2, mor, mor3, matrix_of_the_source, matrix_of_the_range;
           
           morphism := Opposite( morphism_ );
           
           matrix_of_morphism := UnderlyingMatrix( morphism );
           
           
           mor2 := PresentationMorphism( FreeLeftPresentation( NrColumns( matrix_of_morphism ), ring )
                                         , Involution( matrix_of_morphism ), FreeLeftPresentation( NrRows( matrix_of_morphism ), ring ) );
           
           matrix_of_the_range := UnderlyingMatrix( Range( morphism ) );
           
           mor1 := KernelEmbedding( PresentationMorphism( FreeLeftPresentation( NrColumns( matrix_of_the_range ), ring )
                                         , Involution( matrix_of_the_range ), FreeLeftPresentation( NrRows( matrix_of_the_range ), ring ) ) );
           
           mor := PreCompose( mor1, mor2 );
           
           matrix_of_the_source := UnderlyingMatrix( Source( morphism ) );
           
           mor3 := PresentationMorphism( FreeLeftPresentation( NrColumns( matrix_of_the_source ), ring )
                                         , Involution( matrix_of_the_source ), FreeLeftPresentation( NrRows( matrix_of_the_source ), ring ) );
            
           return KernelLift( mor3, mor );
           
           end );
           
   return functor;
   
end );

##
InstallMethod( FunctorDualRight,
               [ IsHomalgRing ],
               
  function( ring )
    
    return FunctorDualRight( RightPresentations( ring ) );
    
end );

##
InstallOtherMethod( FunctorDualRight,
                    [ IsCategoryOfRightPresentations ],
                    
   function( category )
     local ring, functor;
     
     ring := UnderlyingRing( category );
     
     functor := CapFunctor( Concatenation( "Hom( , R ) functor for ", Name( category ) ), Opposite( category ), category );
     
     AddObjectFunction( functor, 
     
           function( obj )
           local object, mat, N, M, mor; 
           
           object := Opposite( obj );
           
           mat := UnderlyingMatrix( object );
           
           N := FreeRightPresentation( NrColumns( mat ), ring );
           
           M := FreeRightPresentation( NrRows( mat ), ring );
           
           mor := PresentationMorphism( M, Involution( mat ), N );
           
           return KernelObject( mor );
           
           end );
           
    AddMorphismFunction( functor, 
    
           function( new_source, morphism_, new_range )
           local morphism, matrix_of_morphism, mor1, mor2, mor, mor3, matrix_of_the_source, matrix_of_the_range;
           
           morphism := Opposite( morphism_ );
           
           matrix_of_morphism := UnderlyingMatrix( morphism );
           
           mor2 := PresentationMorphism( FreeRightPresentation( NrRows( matrix_of_morphism ), ring )
                                         , Involution( matrix_of_morphism ), FreeRightPresentation( NrColumns( matrix_of_morphism ), ring ) );
           
           matrix_of_the_range := UnderlyingMatrix( Range( morphism ) );
           
           mor1 := KernelEmbedding( PresentationMorphism( FreeRightPresentation( NrRows( matrix_of_the_range ), ring )
                                         , Involution( matrix_of_the_range ), FreeRightPresentation( NrColumns( matrix_of_the_range ), ring ) ) );
           
           mor := PreCompose( mor1, mor2 );
           
           matrix_of_the_source := UnderlyingMatrix( Source( morphism ) );
           
           mor3 := PresentationMorphism( FreeRightPresentation( NrRows( matrix_of_the_source ), ring )
                                         , Involution( matrix_of_the_source ), FreeRightPresentation( NrColumns( matrix_of_the_source ), ring ) );
            
           return KernelLift( mor3, mor );
           
           end );
           
   return functor;
   
end );

##
InstallMethod( FunctorDoubleDualLeft,
               [ IsHomalgRing ],
               
  function( ring )
    
    return FunctorDoubleDualLeft( LeftPresentations( ring ) );
    
end );

##
InstallOtherMethod( FunctorDoubleDualLeft,
                    [ IsCategoryOfLeftPresentations ],
                    
   function( category )
     local functor, dual_functor;
     
     functor := CapFunctor( Concatenation( " Hom( Hom( , R ), R ) functor for ", Name( category ) ), category, category );
     
     dual_functor := FunctorDualLeft( category );
    
     AddObjectFunction( functor, 
     
           function( object )
           
             return ApplyFunctor( dual_functor, Opposite( ApplyFunctor( dual_functor, Opposite( object ) ) ) );
             
           end );
           
    AddMorphismFunction( functor, 
    
           function( new_source, morphism, new_range )
           
             return ApplyFunctor( dual_functor, Opposite( ApplyFunctor( dual_functor, Opposite( morphism ) ) ) );
           
           end );
           
   return functor;
   
end );

##
InstallMethod( FunctorDoubleDualRight,
               [ IsHomalgRing ],
               
  function( ring )
    
    return FunctorDoubleDualRight( RightPresentations( ring ) );
    
end );

##
InstallOtherMethod( FunctorDoubleDualRight,
                    [ IsCategoryOfRightPresentations ],
                    
   function( category )
     local functor, dual_functor;
     
     functor := CapFunctor( Concatenation( " Hom( Hom( , R ), R ) functor for ", Name( category ) ), category, category );
     
     dual_functor := FunctorDualRight( category );
    
     AddObjectFunction( functor, 
     
           function( object )
           
             return ApplyFunctor( dual_functor, Opposite( ApplyFunctor( dual_functor, Opposite( object ) ) ) );
             
           end );
           
    AddMorphismFunction( functor, 
    
           function( new_source, morphism, new_range )
           
             return ApplyFunctor( dual_functor, Opposite( ApplyFunctor( dual_functor, Opposite( morphism ) ) ) );
           
           end );
           
   return functor;
   
end );
