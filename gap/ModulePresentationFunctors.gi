#############################################################################
##
##                                       ModulePresentationsForHomalg package
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
        
        functor := HomalgFunctor( Concatenation( "Standard module for ", Name( category ) ), category, category );
        
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
            
            return PresentationMorphism( new_source, morphism, new_range );
            
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




