#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

#################################
##
## Identity to StandardModule
##
#################################

BindGlobal( "INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_STANDARD_MODULE_METHOD",
            
  function( natural_transformation_from_identity_to_standard_module_method, presentations, standard_module, nr_generators  )
    
    InstallMethod( natural_transformation_from_identity_to_standard_module_method,
                   [ IsHomalgRing ],
                   
      function( ring )
        local standard_module_functor, category, natural_transformation;
        
        category := presentations( ring );
        
        standard_module_functor := standard_module( ring );
        
        natural_transformation := NaturalTransformation( Concatenation( "Natural isomorphism from Id to ", Name( standard_module_functor ) ),
                                                         IdentityMorphism( AsCatObject( category ) ), standard_module_functor );
        
        AddNaturalTransformationFunction( natural_transformation,
                                          
          function( id_object, object, standard_object )
            local matrix;
            
            matrix := HomalgIdentityMatrix( nr_generators( UnderlyingMatrix( id_object ) ), ring );
            
            return PresentationMorphism( id_object, matrix, standard_object );
            
        end );
        
        SetIsIsomorphism( natural_transformation, true );
        
        return natural_transformation;
        
    end );
    
end );

BindGlobal( "INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_STANDARD_MODULE",
            
  function( )
    
    INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_STANDARD_MODULE_METHOD( NaturalIsomorphismFromIdentityToStandardModuleLeft,
                                                                            LeftPresentations,
                                                                            FunctorStandardModuleLeft,
                                                                            NrColumns );
    
    INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_STANDARD_MODULE_METHOD( NaturalIsomorphismFromIdentityToStandardModuleRight,
                                                                            RightPresentations,
                                                                            FunctorStandardModuleRight,
                                                                            NrRows );
    
end );

INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_STANDARD_MODULE( );