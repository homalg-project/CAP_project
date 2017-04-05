#############################################################################
##
##                                       ModulesOverLocalRingsForCAP
##
##  Copyright 2017, Sebastian Posur, University of Siegen
##
#############################################################################

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
InstallMethod( MinimalNumberOfGenerators,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    
    return NrColumns( UnderlyingMatrix( Source( MinimalGeneratorsModel( presentation ) ) ) );
    
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
    
    embedding := ImageEmbedding( embedding );
    
    return AsSerreQuotientCategoryMorphism( category, embedding );
    
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
    local minimal;
    
    if degree > 0 then
        
        return IdentityMorphism( ZeroObject( presentation ) );
        
    elif degree = 0 then
        
        minimal := MinimalGeneratorsModel( presentation );
        
        return UniversalMorphismIntoZeroObject( Source( minimal ) );
        
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














