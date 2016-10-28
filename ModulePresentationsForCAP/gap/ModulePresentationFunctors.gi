#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

#######################################
##
## FunctorStandardModule
##
#######################################

BindGlobal( "INSTALL_FUNCTOR_STANDARD_MODULE_METHODS",
            
  function( functor_standard_module, presentations, basis_of_module, as_presentation )
    
    InstallMethod( functor_standard_module,
                   [ IsHomalgRing ],
                   
      function( ring )
        local category, functor;
        
        category := presentations( ring );
        
        functor := CapFunctor( Concatenation( "Standard module for ", Name( category ) ), category, category );
        
        AddObjectFunction( functor,
                           
          function( object )
            local matrix;
            
            matrix := basis_of_module( UnderlyingMatrix( object ) );
            
            return as_presentation( matrix );
            
        end );
        
        AddMorphismFunction( functor,
                             
          function( new_source, morphism, new_range )
            local matrix;
            
            matrix := UnderlyingMatrix( morphism );
            
            return PresentationMorphism( new_source, matrix, new_range );
            
        end );
        
        return functor;
        
    end );
    
end );

BindGlobal( "INSTALL_FUNCTOR_STANDARD_MODULE",
            
  function( )
    
    INSTALL_FUNCTOR_STANDARD_MODULE_METHODS( FunctorStandardModuleLeft,  LeftPresentations,  BasisOfRowModule,    AsLeftPresentation  );
    
    INSTALL_FUNCTOR_STANDARD_MODULE_METHODS( FunctorStandardModuleRight, RightPresentations, BasisOfColumnModule, AsRightPresentation );
    
end );

INSTALL_FUNCTOR_STANDARD_MODULE( );

#######################################
##
## FunctorLessGenerators
##
#######################################

##
InstallMethod( FunctorLessGeneratorsLeft,
               [ IsHomalgRing ],
               
  function( ring )
    local category, functor;
    
    category := LeftPresentations( ring );
    
    functor := CapFunctor( Concatenation( "Less generators for ", Name( category ) ), category, category );
    
    AddObjectFunction( functor,
                       
      function( object )
        local new_object;
        
        new_object := LessGeneratorsTransformationTripleLeft( UnderlyingMatrix( object ) )[1];
        
        return AsLeftPresentation( new_object );
        
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
    local category, functor;
    
    category := RightPresentations( ring );
    
    functor := CapFunctor( Concatenation( "Less generators for ", Name( category ) ), category, category );
    
    AddObjectFunction( functor,
                       
      function( object )
        local new_object;
        
        new_object := LessGeneratorsTransformationTripleRight( UnderlyingMatrix( object ) )[1];
        
        return AsRightPresentation( new_object );
        
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

InstallMethod( FunctorDualForLeftPresentations,
                [ IsHomalgRing ], 
   function( ring )
     local category, functor;
     
     category := LeftPresentations( ring );
     
     functor := CapFunctor( Concatenation( "Hom( , R ) functor for ", Name( category ) ), category, category );
     
     AddObjectFunction( functor, 
     
           function( object )
           local mat, N, M, mor; 
           
           mat := UnderlyingMatrix( object );
           
           N := FreeLeftPresentation( NrColumns( mat ), ring );
           
           M := FreeLeftPresentation( NrRows( mat ), ring );
           
           mor := PresentationMorphism( N, Involution( mat ), M );
           
           return KernelObject( mor );
           
           end );
           
    AddMorphismFunction( functor, 
    
           function( new_source, morphism, new_range )
           local matrix_of_morphism, mor1, mor2, mor, mor3, matrix_of_the_source, matrix_of_the_range;
           
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


InstallMethod( FunctorDoubleDualForLeftPresentations,
                [ IsHomalgRing ], 
   function( ring )
     local category, functor, dual_functor;
     
     category := LeftPresentations( ring );
     
     functor := CapFunctor( Concatenation( " Hom( Hom( , R ), R ) functor for ", Name( category ) ), category, category );
     
     dual_functor := FunctorDualForLeftPresentations( ring );
    
     AddObjectFunction( functor, 
     
           function( object )
           
             return ApplyFunctor( dual_functor, ApplyFunctor( dual_functor, object ) );
             
           end );
           
    AddMorphismFunction( functor, 
    
           function( new_source, morphism, new_range )
           
             return ApplyFunctor( dual_functor, ApplyFunctor( dual_functor, morphism ) );
           
           end );
           
   return functor;
   
end );

