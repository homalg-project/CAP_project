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
        
        new_object := LessGeneratorsTransformationTriple( UnderlyingMatrix( object ) )[ 1 ];
        
        return AsLeftPresentation( new_object );
        
    end );
    
    AddMorphismFunction( functor,
                         
      function( new_source, morphism, new_range )
        local source_transformation_triple, range_transformation_triple, new_morphism_matrix;
        
        source_transformation_triple := LessGeneratorsTransformationTriple( UnderlyingMatrix( Source( morphism ) ) );
        
        range_transformation_triple := LessGeneratorsTransformationTriple( UnderlyingMatrix( Range( morphism ) ) );
        
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
        
        new_object := LessGeneratorsTransformationTriple( UnderlyingMatrix( object ) )[ 1 ];
        
        return AsRightPresentation( new_object );
        
    end );
    
    AddMorphismFunction( functor,
                         
      function( new_source, morphism, new_range )
        local source_transformation_triple, range_transformation_triple, new_morphism_matrix;
        
        source_transformation_triple := LessGeneratorsTransformationTriple( UnderlyingMatrix( Source( morphism ) ) );
        
        range_transformation_triple := LessGeneratorsTransformationTriple( UnderlyingMatrix( Range( morphism ) ) );
        
        new_morphism_matrix := UnderlyingMatrix( morphism );
        
        new_morphism_matrix := range_transformation_triple[ 3 ] * new_morphism_matrix * source_transformation_triple[ 2 ];
        
        return PresentationMorphism( new_source, new_morphism_matrix, new_range );
        
    end );
    
    return functor;
    
end );
