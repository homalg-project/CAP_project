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
            local matrix, natiso;
            
            matrix := HomalgIdentityMatrix( nr_generators( UnderlyingMatrix( id_object ) ), ring );
            
            natiso := PresentationMorphism( id_object, matrix, standard_object );
            
            Assert( 4, IsIsomorphism( natiso ) );
            SetIsIsomorphism( natiso, true );
            
            return natiso;
            
        end );
        
        SetIsIsomorphism( natural_transformation, true );
        
        return natural_transformation;
        
    end );
    
end );

INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_STANDARD_MODULE_METHOD( NaturalIsomorphismFromIdentityToStandardModuleLeft,
                                                                        LeftPresentations,
                                                                        FunctorStandardModuleLeft,
                                                                        NrColumns );

INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_STANDARD_MODULE_METHOD( NaturalIsomorphismFromIdentityToStandardModuleRight,
                                                                        RightPresentations,
                                                                        FunctorStandardModuleRight,
                                                                        NrRows );

BindGlobal( "INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_LESS_GENERATORS_METHOD",
            
  function( natural_transformation_from_identity_to_less_generators_method, presentations, less_generators, triple_getter  )
    
    InstallMethod( natural_transformation_from_identity_to_less_generators_method,
                   [ IsHomalgRing ],
                   
      function( ring )
        local less_generators_functor, category, natural_transformation;
        
        category := presentations( ring );
        
        less_generators_functor := less_generators( ring );
        
        natural_transformation := NaturalTransformation( Concatenation( "Natural isomorphism from Id to ", Name( less_generators_functor ) ),
                                                         IdentityMorphism( AsCatObject( category ) ), less_generators_functor );
        
        AddNaturalTransformationFunction( natural_transformation,
                                          
          function( id_object, object, smaller_object )
            local LG;
            
            LG := triple_getter( UnderlyingMatrix( object ) );
            
            return PresentationMorphism( object, LG[2], smaller_object );
            
        end );
        
        SetIsIsomorphism( natural_transformation, true );
        
        return natural_transformation;
        
    end );
    
end );

INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_LESS_GENERATORS_METHOD( NaturalIsomorphismFromIdentityToLessGeneratorsLeft,
                                                                        LeftPresentations,
                                                                        FunctorLessGeneratorsLeft,
                                                                        LessGeneratorsTransformationTripleLeft );

INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_LESS_GENERATORS_METHOD( NaturalIsomorphismFromIdentityToLessGeneratorsRight,
                                                                        RightPresentations,
                                                                        FunctorLessGeneratorsRight,
                                                                        LessGeneratorsTransformationTripleRight );
