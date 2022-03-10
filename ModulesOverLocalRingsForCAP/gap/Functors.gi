# SPDX-License-Identifier: GPL-2.0-or-later
# ModulesOverLocalRingsForCAP: Category of modules over a local ring modeled by Serre quotients for CAP
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( FunctorMinimalGeneratorsModel,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local functor;
    
    functor := CapFunctor( Concatenation( "Minimal generators model for ", Name( category ) ), category, category );
    
    AddObjectFunction( functor,
                       
      function( object )
        
        return Source( MinimalGeneratorsModel( object ) );
        
    end );
    
    AddMorphismFunction( functor,
                         
      function( new_source, morphism, new_range )
        local minimal_model_source, minimal_model_range;
        
        minimal_model_source := MinimalGeneratorsModel( Source( morphism ) );
        
        minimal_model_range := MinimalGeneratorsModel( Range( morphism ) );
        
        return PreCompose( [ minimal_model_source, morphism, Inverse( minimal_model_range ) ] );
        
    end );
    
    return functor;
    
end );


##
InstallMethod( FunctorMinimalRelationsModel,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local functor;
    
    functor := CapFunctor( Concatenation( "Minimal relations model for ", Name( category ) ), category, category );
    
    AddObjectFunction( functor,
                       
      function( object )
        
        return Source( MinimalRelationsModel( object ) );
        
    end );
    
    AddMorphismFunction( functor,
                         
      function( new_source, morphism, new_range )
        local minimal_model_source, minimal_model_range;
        
        minimal_model_source := MinimalRelationsModel( Source( morphism ) );
        
        minimal_model_range := MinimalRelationsModel( Range( morphism ) );
        
        return PreCompose( [ minimal_model_source, morphism, Inverse( minimal_model_range ) ] );
        
    end );
    
    return functor;
    
end );

##
InstallMethod( FunctorStandardGeneratorsModel,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local functor;
    
    functor := CapFunctor( Concatenation( "Standard generators model for ", Name( category ) ), category, category );
    
    AddObjectFunction( functor,
                     
      function( object )
        
        return Source( StandardGeneratorsModel( object ) );
        
    end );
    
    AddMorphismFunction( functor,
                         
      function( new_source, morphism, new_range )
        local model_source, model_range;
        
        model_source := MinimalRelationsModel( Source( morphism ) );
        
        model_range := MinimalRelationsModel( Range( morphism ) );
        
        return PreCompose( [ model_source, morphism, Inverse( model_range ) ] );
        
    end );
    
    return functor;
    
end );

##
InstallMethod( FunctorMinimalModel,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    
    return PreCompose( [
             FunctorMinimalGeneratorsModel( category ),
             FunctorStandardGeneratorsModel( category ),
             FunctorMinimalRelationsModel( category ) ] );
    
end );

