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
InstallMethod( FreeModulePresentationOverLocalRing,
               [ IsCategoryOfModulePresentationsOverLocalRing, IsInt ],
               
  function( category, rank )
    local ring, object;
    
    ring := UnderlyingHomalgRing( category );
    
    object := FreeLeftPresentation( rank, ring );
    
    return AsSerreQuotientCategoryObject( category, object );
    
end );

##
InstallMethod( AsModulePresentationOverLocalRing,
               [ IsCategoryOfModulePresentationsOverLocalRing, IsHomalgMatrix ],
               
  function( category, matrix )
    
    return AsSerreQuotientCategoryObject( category, AsLeftPresentation( matrix ) );
    
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
InstallMethod( SuperfluousGeneratorsIndicesList,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, matrix, residue_matrix;
    
    category := CapCategory( presentation );
    
    matrix := UnderlyingMatrix( presentation );
    
    residue_matrix := matrix * UnderlyingHomalgRingModuloPrimeIdeal( category );
    
    return REFIndicesForMatricesOverIntegralDomain( residue_matrix );
    
end );

##
InstallMethod( SuperfluousRelationsIndicesList,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, matrix, syzygies, column_list, degree_function, row_list, degree_list, residue_matrix;
    
    category := CapCategory( presentation );
    
    matrix := UnderlyingMatrix( presentation );
    
    syzygies := SyzygiesOfRows( matrix );
    
    column_list := [ 1 .. NrColumns( syzygies ) ];
    
    if HasUnderlyingHomalgRingDegreeFunction( category ) then
        
        degree_function := UnderlyingHomalgRingDegreeFunction( category );
        
        #TODO: can we avoid this?
        row_list := EntriesOfHomalgMatrixAsListList( matrix );
        
        degree_list := List( [ 1 .. NrRows( matrix ) ], i -> Maximum( List( row_list[i], degree_function ) ) );
        
        SortParallel( degree_list, column_list );
        
        column_list := Reversed( column_list );
        
    fi;
    
    residue_matrix := syzygies * UnderlyingHomalgRingModuloPrimeIdeal( category );
    
    return REFIndicesForMatricesOverIntegralDomainWithGivenColumnOrdering( residue_matrix, column_list );
    
end );

##
InstallMethod( MinimalGeneratorsModel,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, matrix, indices, nr_cols, rank, ring, F, isomorphism_matrix,
          range, isomorphism, relations, minimal_model;
    
    category := CapCategory( presentation );
    
    matrix := UnderlyingMatrix( presentation );
    
    indices := SuperfluousGeneratorsIndicesList( presentation );
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
InstallMethod( MinimalNumberOfGenerators,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local matrix, indices, nr_cols, rank;
    
    matrix := UnderlyingMatrix( presentation );
    
    indices := SuperfluousGeneratorsIndicesList( presentation );
    
    nr_cols := NrColumns( matrix );
    
    rank := nr_cols - Size( indices );
    
    return rank;
    
end );

##
InstallMethod( MinimalRelationsModel,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, indices, matrix, row_list, minimal_model, range, ring, nr_cols, isomorphism_matrix;
    
    category := CapCategory( presentation );
    
    indices := SuperfluousRelationsIndicesList( presentation );
    
    matrix := UnderlyingMatrix( presentation );
    
    row_list := Difference( [ 1 .. NrRows( matrix ) ], indices );
    
    matrix := CertainRows( matrix, row_list );
    
    minimal_model := AsLeftPresentation( matrix );
    
    range := UnderlyingHonestObject( presentation );
    
    ring := UnderlyingHomalgRing( category );
    
    nr_cols := NrColumns( UnderlyingMatrix( presentation ) );
    
    isomorphism_matrix := HomalgIdentityMatrix( nr_cols, ring );
    
    return AsSerreQuotientCategoryMorphism( category, PresentationMorphism( minimal_model, isomorphism_matrix, range ) );
    
end );

##
InstallMethod( StandardGeneratorsModel,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, matrix, model, range, ring, nr_cols, isomorphism_matrix;
    
    category := CapCategory( presentation );
    
    matrix := UnderlyingMatrix( presentation );
    
    model := AsLeftPresentation( BasisOfRows( matrix ) );
    
    range := UnderlyingHonestObject( presentation );
    
    ring := UnderlyingHomalgRing( category );
    
    nr_cols := NrColumns( matrix );
    
    isomorphism_matrix := HomalgIdentityMatrix( nr_cols, ring );
    
    return AsSerreQuotientCategoryMorphism( category, PresentationMorphism( model, isomorphism_matrix, range ) );
    
end );

##
InstallMethod( FiltrationByPrimeIdealEmbedding,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               
  function( presentation )
    local category, underlying_presentation, projection;
    
    category := CapCategory( presentation );
    
    underlying_presentation := UnderlyingHonestObject( presentation );
    
    projection := PrimeIdealQuotientModuleProjection( category );
    
    projection :=
      PreCompose(
        LeftUnitorInverse( underlying_presentation ), 
        TensorProductOnMorphisms( projection, IdentityMorphism( underlying_presentation ) ) );
    
    return AsSerreQuotientCategoryMorphism( category, KernelEmbedding( projection ) );
    
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
      
      return object;
      
#       return ApplyFunctor( functor_minimal_model, object );
      
    end;
    
    differential_function := function( degree )
      local morphism, minimal_source, minimal_range;
      
      morphism := HonestRepresentative( UnderlyingGeneralizedMorphism( Differential( minimal_free_resolution, -degree ) ) );
      
      morphism := TensorProductOnMorphisms( morphism, IdentityMorphism( UnderlyingHonestObject( presentation_2 ) ) );
      
      morphism := AsSerreQuotientCategoryMorphism( category, morphism );
      
      return morphism;
      
#       return ApplyFunctor( functor_minimal_model, morphism );
    end;
    
    z_functor := ZFunctorObject( object_function, differential_function, category );
    
    return AsComplex( z_functor );
    
end );


####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsCategoryOfModulePresentationsOverLocalRingObject ],
               # FIXME: Fix the rank in GenericView and delete this afterwards
               9999,
               
  function( object )
    
    Display( UnderlyingMatrix( object ) );
    
    Print( "\n" );
    
    Print( StringMutable( object ) );
    
    Print( "\n" );
    
end );









