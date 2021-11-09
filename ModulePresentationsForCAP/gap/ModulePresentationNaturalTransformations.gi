# SPDX-License-Identifier: GPL-2.0-or-later
# ModulePresentationsForCAP: Category R-pres for CAP
#
# Implementations
#

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

BindGlobal( "INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_GET_RID_OF_GENERATORS_METHOD",
            
  function( natural_transformation_from_identity_to_get_rid_of_zero_generators_method, presentations, get_rid_of_zero_generators, triple_getter  )
    
    InstallMethod( natural_transformation_from_identity_to_get_rid_of_zero_generators_method,
                   [ IsHomalgRing ],
                   
      function( ring )
        local get_rid_of_zero_generators_functor, category, natural_transformation;
        
        category := presentations( ring );
        
        get_rid_of_zero_generators_functor := get_rid_of_zero_generators( ring );
        
        natural_transformation := NaturalTransformation( Concatenation( "Natural isomorphism from Id to ", Name( get_rid_of_zero_generators_functor ) ),
                                                         IdentityMorphism( AsCatObject( category ) ), get_rid_of_zero_generators_functor );
        
        AddNaturalTransformationFunction( natural_transformation,
                                          
          function( id_object, object, smaller_object )
            local ZG, natiso;
            
            ZG := triple_getter( UnderlyingMatrix( object ) );
            
            natiso := PresentationMorphism( id_object, ZG[2], smaller_object );
            
            Assert( 4, IsIsomorphism( natiso ) );
            SetIsIsomorphism( natiso, true );
            
            return natiso;
            
        end );
        
        SetIsIsomorphism( natural_transformation, true );
        
        return natural_transformation;
        
    end );
    
end );

INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_GET_RID_OF_GENERATORS_METHOD( NaturalIsomorphismFromIdentityToGetRidOfZeroGeneratorsLeft,
                                                                        LeftPresentations,
                                                                        FunctorGetRidOfZeroGeneratorsLeft,
                                                                        NonZeroGeneratorsTransformationTripleLeft );

INSTALL_NATURAL_TRANSFORMATION_FROM_IDENTITY_TO_GET_RID_OF_GENERATORS_METHOD( NaturalIsomorphismFromIdentityToGetRidOfZeroGeneratorsRight,
                                                                        RightPresentations,
                                                                        FunctorGetRidOfZeroGeneratorsRight,
                                                                        NonZeroGeneratorsTransformationTripleRight );

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
            local LG, natiso;
            
            LG := triple_getter( UnderlyingMatrix( object ) );
            
            natiso := PresentationMorphism( id_object, LG[2], smaller_object );
            
            Assert( 4, IsIsomorphism( natiso ) );
            SetIsIsomorphism( natiso, true );
            
            return natiso;
            
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

########################################################
##
## Identity to double dual left Hom_R( _ , R ) functor
##
########################################################

##
InstallMethod( NaturalTransformationFromIdentityToDoubleDualLeft, 
                [ IsHomalgRing ], 
   function( ring )
   local category, double_dual_functor, natural_transformation;
   
   category := LeftPresentations( ring );
   
   double_dual_functor := FunctorDoubleDualLeft( ring );
   
   natural_transformation := NaturalTransformation( Concatenation( "Natural transformation from Id to ", Name( double_dual_functor ) ),
                                                         IdentityFunctor( category ), double_dual_functor );
                                                         
   AddNaturalTransformationFunction( natural_transformation, 
   
      function( id_object, object, double_dual_object )
        local A, representing_morphism, cokernel_projection_in_obj, double_dual_of_cokernel_projection, nat_mor; 
        
        A := UnderlyingMatrix( object );
        
        representing_morphism := PresentationMorphism( FreeLeftPresentation( NrRows( A ), ring ), A, FreeLeftPresentation( NrColumns( A ), ring ) );
        
        cokernel_projection_in_obj := CokernelProjection( representing_morphism );
        
        double_dual_of_cokernel_projection := ApplyFunctor( double_dual_functor, cokernel_projection_in_obj );
        
        nat_mor := CokernelColift(  representing_morphism, double_dual_of_cokernel_projection );
            
        return nat_mor;
        
      end );

   return natural_transformation;
end );

##
InstallMethod( NaturalTransformationFromIdentityToDoubleDualRight, 
                [ IsHomalgRing ], 
   function( ring )
   local category, double_dual_functor, natural_transformation;
   
   category := RightPresentations( ring );
   
   double_dual_functor := FunctorDoubleDualRight( ring );
   
   natural_transformation := NaturalTransformation( Concatenation( "Natural transformation from Id to ", Name( double_dual_functor ) ),
                                                         IdentityFunctor( category ), double_dual_functor );
                                                         
   AddNaturalTransformationFunction( natural_transformation, 
   
      function( id_object, object, double_dual_object )
        local A, representing_morphism, cokernel_projection_in_obj, double_dual_of_cokernel_projection, nat_mor; 
        
        A := UnderlyingMatrix( object );
        
        representing_morphism := PresentationMorphism( FreeRightPresentation( NrColumns( A ), ring ), A, FreeRightPresentation( NrRows( A ), ring ) );
        
        cokernel_projection_in_obj := CokernelProjection( representing_morphism );
        
        double_dual_of_cokernel_projection := ApplyFunctor( double_dual_functor, cokernel_projection_in_obj );
        
        nat_mor := CokernelColift(  representing_morphism, double_dual_of_cokernel_projection );
            
        return nat_mor;
        
      end );

   return natural_transformation;
end );
