#############################################################################
##
##                                       ModulesOverLocalRingsForCAP
##
##  Copyright 2017, Sebastian Posur, University of Siegen
##
#############################################################################

#############################
##
## Constructors
##
#############################

##
InstallMethod( CategoryOfLeftModulePresentationsOverLocalRing,
               [ IsHomalgRing, IsList ],
               
  function( ring, prime_ideal_generators )
    local prime_ideal_matrix, membership_function, ideal_string, category;
    
    prime_ideal_matrix :=
      HomalgMatrix( [ prime_ideal_generators ], Size( prime_ideal_generators ), 1, ring );
    
    membership_function := function( module_presentation )
        local annihilator;
        
        annihilator := Annihilator( module_presentation );
        
        return not IsZero( DecideZeroRows( UnderlyingMatrix( annihilator ), prime_ideal_matrix ) );
        
    end;
    
    ideal_string := String( prime_ideal_generators );
    
    RemoveCharacters( ideal_string, "\"" );
    
    category := SerreQuotientCategoryByCospans( LeftPresentations( ring ), membership_function,
      Concatenation( "presentations not supported in ", ideal_string ) );
    
    SetSpecializedObjectFilterForSerreQuotients( category, IsCategoryOfModulePresentationsOverLocalRingObject );
    
    SetSpecializedMorphismFilterForSerreQuotients( category, IsCategoryOfModulePresentationsOverLocalRingMorphism );
    
    SetFilterObj( category, IsCategoryOfModulePresentationsOverLocalRing );
    
    SetPrimeIdealAsHomalgMatrix( category, prime_ideal_matrix );
    
    SetUnderlyingHomalgRing( category, ring );
    
    return category;
    
end );

#############################
##
## Attributes
##
#############################

##
InstallMethod( UnderlyingHomalgRingModuloPrimeIdeal,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    
    return UnderlyingHomalgRing( category ) / PrimeIdealAsHomalgMatrix( category );
    
end );

##
InstallMethod( PrimeIdealAsModuleEmbedding,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    local ideal_embedding;
    
    ideal_embedding := AsMorphismBetweenFreeLeftPresentations( PrimeIdealAsHomalgMatrix( category ) );
    
    return ImageEmbedding( ideal_embedding );
    
end );

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
InstallMethod( FunctorMinimalModel,
               [ IsCategoryOfModulePresentationsOverLocalRing ],
               
  function( category )
    
    return PreCompose( FunctorMinimalGeneratorsModel( category ), FunctorMinimalRelationsModel( category ) );
    
end );