#############################################################################
##
##                                       ModulesOverLocalRingsForCAP
##
##  Copyright 2017, Sebastian Posur, University of Siegen
##
#############################################################################

####################################
##
## Constructors
##
####################################

InstallMethod( FreeModulePresentationOverLocalRing,
               [ IsCategoryOfModulePresentationsOverLocalRing, IsInt ],
               
  function( category, rank )
    local ring, object;
    
    ring := UnderlyingHomalgRing( category );
    
    object := FreeLeftPresentation( rank, ring );
    
    return AsSerreQuotientCategoryObject( category, object );
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( UnderlyingMatrix,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    
    return UnderlyingMatrix( UnderlyingHonestObject( presentation ) );
    
end );


##
InstallMethod( MinimalGeneratorsModel,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, matrix, residue_matrix, indices, nr_cols, rank, ring, F, isomorphism_matrix,
          range, isomorphism, relations, minimal_model;
    
    category := CapCategory( presentation );
    
    matrix := UnderlyingMatrix( presentation );
    
    residue_matrix := matrix * UnderlyingHomalgRingModuloPrimeIdeal( category );
    
    indices := REFIndicesForMatricesOverIntegralDomain( residue_matrix );
    #TODO: make a shortcut for indices = []
    nr_cols := NrColumns( matrix );
    
    rank := nr_cols - Size( indices );
    
    ring := UnderlyingHomalgRing( category );
    
    F := FreeLeftPresentation( rank, ring );
    
    isomorphism_matrix := CertainRows( HomalgIdentityMatrix( nr_cols, ring ), Difference( [ 1 .. nr_cols ], indices ) );
    
    range := UnderlyingHonestObject( presentation );
    
    isomorphism := PresentationMorphism( F, isomorphism_matrix, range );
    
    relations := UnderlyingMatrix( KernelEmbedding( isomorphism ) );
    
    minimal_model := AsLeftPresentation( relations );
    
    return AsSerreQuotientCategoryMorphism( category, PresentationMorphism( minimal_model, isomorphism_matrix, range ) );
    
end );

##
InstallMethod( MinimalRelationsModel,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, minimal_free_resolution, d1, minimal_model, range, ring, isomorphism_matrix, nr_cols;
    
    category := CapCategory( presentation );
    
    minimal_free_resolution := MinimalFreeResolution( presentation );
    
    d1 := Differential( minimal_free_resolution, 1 );
    
    d1 := UnderlyingMatrix( HonestRepresentative( UnderlyingGeneralizedMorphism( d1 ) ) );
    
    minimal_model := AsLeftPresentation( d1 );
    
    range := UnderlyingHonestObject( presentation );
    
    ring := UnderlyingHomalgRing( category );
    
    nr_cols := NrColumns( UnderlyingMatrix( presentation ) );
    
    isomorphism_matrix := HomalgIdentityMatrix( nr_cols, ring );
    
    return AsSerreQuotientCategoryMorphism( category, PresentationMorphism( minimal_model, isomorphism_matrix, range ) );
    
end );

##
InstallMethod( MinimalNumberOfGenerators,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, matrix, residue_matrix, indices, nr_cols, rank;
    
    category := CapCategory( presentation );
    
    matrix := UnderlyingMatrix( presentation );
    
    residue_matrix := matrix * UnderlyingHomalgRingModuloPrimeIdeal( category );
    
    indices := REFIndicesForMatricesOverIntegralDomain( residue_matrix );
    
    nr_cols := NrColumns( matrix );
    
    rank := nr_cols - Size( indices );
    
    return rank;
    
end );

##
InstallMethod( FiltrationByPrimeIdealEmbedding,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, underlying_presentation, prime_ideal_embedding, embedding;
    
    category := CapCategory( presentation );
    
    underlying_presentation := UnderlyingHonestObject( presentation );
    
    prime_ideal_embedding := PrimeIdealAsModuleEmbedding( category );
    
    embedding := 
      PreCompose( 
        TensorProductOnMorphisms( prime_ideal_embedding, IdentityMorphism( underlying_presentation ) ),
        LeftUnitor( underlying_presentation ) );
    
    embedding := AsSerreQuotientCategoryMorphism( category, embedding );
    
    embedding := PreCompose( MinimalGeneratorsModel( Source( embedding ) ), embedding );
    
    embedding := PreCompose( MinimalRelationsModel( Source( embedding ) ), embedding ) ;
    
    embedding := ImageEmbedding( embedding );
    
    return embedding;
    
end );

##
InstallMethod( CoverByFreeModule,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category;
    
    category := CapCategory( presentation );
    
    return AsSerreQuotientCategoryMorphism( category,
      CoverByFreeModule( UnderlyingHonestObject( presentation ) ) );
    
end );

##
InstallMethod( MinimalFreeResolutionDifferentialOp,
               [ IsCategoryOfModulePresentationsOverLocalRingObject, IsInt ],
               
  function( presentation, degree )
    local minimal, number_of_generators;
    
    if degree > 0 then
        
        return IdentityMorphism( ZeroObject( presentation ) );
        
    elif degree = 0 then
        
        number_of_generators := MinimalNumberOfGenerators( presentation );
        
        return UniversalMorphismIntoZeroObject( 
                 FreeModulePresentationOverLocalRing( CapCategory( presentation ), number_of_generators ) );
        
    elif degree = -1 then
        
        minimal := MinimalGeneratorsModel( presentation );
        
        return StepOfMinimalFreeResolutionOfKernel( CoverByFreeModule( Source( minimal ) ) );
        
    else
        
        return StepOfMinimalFreeResolutionOfKernel( MinimalFreeResolutionDifferential( presentation, degree + 1 ) );
        
    fi;
    
end );
##
InstallMethod( MinimalFreeResolution,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, object_function, differential_function, z_functor;
    
    category := CapCategory( presentation );
    
    object_function := function( degree )
      
      return Source( MinimalFreeResolutionDifferential( presentation, degree ) );
      
    end;
    
    differential_function := function( degree )
      
      return MinimalFreeResolutionDifferential( presentation, degree );
      
    end;
    
    z_functor := ZFunctorObject( object_function, differential_function, category );
    
    return AsComplex( z_functor );
    
end );

InstallMethodWithCache( TorComplex,
                        [ IsCategoryOfModulePresentationsOverLocalRingObject,
                          IsCategoryOfModulePresentationsOverLocalRingObject ],
                          
  function( presentation_1, presentation_2 )
    
    local category, minimal_free_resolution, object_function, differential_function, z_functor, functor_minimal_model;
    
    category := CapCategory( presentation_1 );
    
    minimal_free_resolution := MinimalFreeResolution( presentation_1 );
    
    functor_minimal_model := FunctorMinimalModel( category );
    
    object_function := function( degree )
      local object;
      
      object := TensorProductOnObjects( UnderlyingHonestObject( minimal_free_resolution[ -degree ] ), 
                                        UnderlyingHonestObject( presentation_2 ) );
      
      object := AsSerreQuotientCategoryObject( category, object );
      
      return ApplyFunctor( functor_minimal_model, object );
      
    end;
    
    differential_function := function( degree )
      local morphism, minimal_source, minimal_range;
      
      morphism := HonestRepresentative( UnderlyingGeneralizedMorphism( Differential( minimal_free_resolution, -degree ) ) );
      
      morphism := TensorProductOnMorphisms( morphism, IdentityMorphism( UnderlyingHonestObject( presentation_2 ) ) );
      
      morphism := AsSerreQuotientCategoryMorphism( category, morphism );
      
      return ApplyFunctor( functor_minimal_model, morphism );
#       
#       #TODO: make this a functor!
#       minimal_source := MinimalGeneratorsModel( Source( morphism ) );
#       
#       minimal_range := MinimalGeneratorsModel( Range( morphism ) );
#       
#       return PreCompose( [ minimal_source, morphism, Inverse( minimal_range ) ] );
#       
    end;
    
    z_functor := ZFunctorObject( object_function, differential_function, category );
    
    return AsComplex( z_functor );
    
end );












