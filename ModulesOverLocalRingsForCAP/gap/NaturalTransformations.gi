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
InstallMethod( NaturalIsomorphismFromMinimalGeneratorsModelToIdentity,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local natural_transformation;
    
    natural_transformation :=
      NaturalTransformation( "Natural isomorphism from minimal generators model to identity",
                             FunctorMinimalGeneratorsModel( category ), IdentityFunctor( category ) );
    
    AddNaturalTransformationFunction( natural_transformation,
                                      
      function( minimal_generator_model, component_object, id_object )
        
        return MinimalGeneratorsModel( component_object );
        
    end );
    
    return natural_transformation;
    
end );

##
InstallMethod( NaturalIsomorphismFromMinimalRelationsModelToIdentity,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local natural_transformation;
    
    natural_transformation :=
      NaturalTransformation( "Natural isomorphism from minimal relations model to identity",
                             FunctorMinimalRelationsModel( category ), IdentityFunctor( category ) );
    
    AddNaturalTransformationFunction( natural_transformation,
                                      
      function( minimal_relations_model, component_object, id_object )
        
        return MinimalRelationsModel( component_object );
        
    end );
    
    return natural_transformation;
    
end );

##
InstallMethod( NaturalIsomorphismFromStandardGeneratorsModelToIdentity,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local natural_transformation;
    
    natural_transformation :=
      NaturalTransformation( "Natural isomorphism from standard generators model to identity",
                             FunctorStandardGeneratorsModel( category ), IdentityFunctor( category ) );
    
    AddNaturalTransformationFunction( natural_transformation,
                                      
      function( standard_generators_model, component_object, id_object )
        
        return StandardGeneratorsModel( component_object );
        
    end );
    
    return natural_transformation;
    
end ); 
