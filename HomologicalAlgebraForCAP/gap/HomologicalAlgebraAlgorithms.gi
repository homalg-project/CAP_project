#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

###########################
##
## EpiMonoFactorization
##
###########################

##
InstallMethod( EpiMonoFactorization,
               [ IsCapCategoryMorphism ],
                                       
  function( morphism )
    local kernel_embedding, epimorphism, monomorphism;
    
    kernel_embedding := KernelEmbedding( morphism );
    
    epimorphism := CokernelProjection( kernel_embedding );
    
    monomorphism := CokernelColift( kernel_embedding, morphism );
    
    return [ epimorphism, monomorphism ];
    
end );

###########################
##
## Snake-Lemma
##
###########################

##
InstallMethodWithCacheFromObject( SnakeLemmaConnectingHomomorphism,
                                  [ IsCapCategoryMorphism,
                                    IsCapCategoryMorphism,
                                    IsCapCategoryMorphism,
                                    IsCapCategoryMorphism,
                                    IsCapCategoryMorphism ],
                                    
  function( morphism_up_right,
            morphism_middle_left,
            morphism_middle_middle,
            morphism_middle_right,
            morphism_down_left )
      local generalized_morphism1, generalized_morphism2, cokernel_proj, composition,
            domain, inverse_domain, honest_representative, codomain, inverse_codomain;

    generalized_morphism1 := GeneralizedMorphismWithRangeAid( KernelEmbedding( morphism_middle_right ), morphism_up_right );
    
    generalized_morphism2 := GeneralizedMorphismWithRangeAid( morphism_middle_middle, morphism_down_left );
    
    cokernel_proj := AsGeneralizedMorphism( CokernelProjection( morphism_middle_left ) );
    
    composition := PreCompose( generalized_morphism1, generalized_morphism2 );
    
    composition := PreCompose( composition, cokernel_proj );
    
    honest_representative := HonestRepresentative( composition );
    
    return honest_representative;
    
end );

## Alternative implementation:

#     generalized_morphism1 := GeneralizedMorphismWithRangeAid( KernelEmbedding( morphism_middle_right ), morphism_up_right );
#     
#     generalized_morphism2 := GeneralizedMorphismWithRangeAid( morphism_middle_middle, morphism_down_left );
#     
#     cokernel_proj := AsGeneralizedMorphism( CokernelProjection( morphism_middle_left ) );
#     
#     composition := PreCompose( generalized_morphism1, generalized_morphism2 );
#     
#     composition := PreCompose( composition, cokernel_proj );
    
#     domain := DomainOfGeneralizedMorphism( composition );
#     
#     inverse_domain := Inverse( domain );
    
    
#     
#     codomain := Codomain( composition );
#     
#     inverse_codomain := Inverse( codomain );
#     
#     return PreCompose( PreCompose( inverse_domain, associated_morphism ), inverse_codomain );

InstallMethodWithCacheFromObject( SnakeLemmaConnectingHomomorphismWithKernelAndCokernel,
                                  [ IsCapCategoryMorphism,
                                    IsCapCategoryMorphism,
                                    IsCapCategoryMorphism ],
                                    
  function( morphism_up_right,
            morphism_middle_middle,
            morphism_down_left )
      local generalized_morphism1, generalized_morphism2, cokernel_proj, composition,
            domain, inverse_domain, associated_morphism, codomain, inverse_codomain;
            
    composition := GeneralizedMorphism( morphism_up_right,
                                        morphism_middle_middle,
                                        morphism_down_left );
    
    associated_morphism := AssociatedMorphism( composition );
    
    return associated_morphism;
    
end );

############################################################
##
## Algorithms for spectral sequences
##
############################################################

##
InstallMethodWithCacheFromObject( GetSpectralSequenceObjectFromConsecutiveGeneralizedDifferentials,
                                  [ IsGeneralizedMorphism, IsGeneralizedMorphism ],
                                  
  function( generalized_morphism_into_entry, generalized_morphism_from_entry )
    local mono, epi, image_embedding;
    
    mono := DomainOfGeneralizedMorphism( generalized_morphism_from_entry );
    
    epi := Codomain( generalized_morphism_into_entry );
    
    image_embedding := ImageEmbedding( PreCompose( mono, epi ) );
    
    return GeneralizedMorphismWithRangeAid( image_embedding, epi );
    
end );

##
InstallMethodWithCacheFromObject( GetSpectralSequenceDifferentialFromConsecutiveGeneralizedDifferentials,
                                  [ IsGeneralizedMorphism, IsGeneralizedMorphism, IsGeneralizedMorphism ],
                                  
  function( generalized_morphism_into_source, generalized_differential, generalized_morphism_from_range )
    local source_epi, range_mono, generalized_morphism;
    
    source_epi := GeneralizedInverse( Codomain( generalized_morphism_into_source ) );
    
    range_mono := GeneralizedInverse( DomainOfGeneralizedMorphism( generalized_morphism_from_range ) );
    
    generalized_morphism := PreCompose( source_epi, PreCompose( generalized_differential, range_mono ) );
    
    return AssociatedMorphism( generalized_morphism );
    
end );

############################################################
##
## Spectral sequence algorithm for cohomological bicomplexes
##
############################################################

##
InstallMethodWithCacheFromObject( GeneralizedDifferentialOfTotalCocomplex,
                                  [ IsCapCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( bicomplex, page, p, q )
    local vertical_differential, idempotent_source, idempotent_range, differential, i, generalized_morphism_given_by_cospans, auxiliary_cospan;
    
    vertical_differential := Differential( bicomplex[p], q );
    
    if page = 0 then
    
      differential := AsGeneralizedMorphism( vertical_differential );
    
      return differential;
      
    fi;
    
    differential := AsGeneralizedMorphism( Differential( bicomplex, p + ( page - 1 ) )[ q - ( page - 1 ) ] );
    
    idempotent_source := IdempotentDefinedBySubobject( KernelEmbedding( vertical_differential ) );
    
    idempotent_range := IdempotentDefinedByFactorobject( CokernelProjection( Differential( bicomplex[p + page], q - page ) ) );
    
    generalized_morphism_given_by_cospans := IdentityMorphism( Source( differential ) );
    
    for i in Reversed( [ 2 .. page ] ) do
      
      auxiliary_cospan := GeneralizedMorphismWithRangeAid(
        Differential( bicomplex, p + ( i - 2 ) )[ q - ( i - 2 ) ],
        Differential( bicomplex[ p + ( i - 1 ) ], q - ( i - 1 ) )
      );
      
      generalized_morphism_given_by_cospans := PreCompose( auxiliary_cospan, generalized_morphism_given_by_cospans );
      
    od;
    
    differential := PreCompose( differential, idempotent_range );
    
    generalized_morphism_given_by_cospans := PreCompose( idempotent_source, generalized_morphism_given_by_cospans );
    
    return PreCompose( generalized_morphism_given_by_cospans, differential );
    
end );

##
InstallMethodWithCacheFromObject( SpectralSequenceEntry,
                                  [ IsCapCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( cocomplex, page, p, q )
    local generalized_morphism_into_entry, generalized_morphism_from_entry,
          mono, epi, image_embedding;
    
    generalized_morphism_into_entry :=
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p - page, q + page - 1 );
    
    generalized_morphism_from_entry :=
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p, q );
    
    return GetSpectralSequenceObjectFromConsecutiveGeneralizedDifferentials( generalized_morphism_into_entry, generalized_morphism_from_entry );
    
end );

##
InstallMethodWithCacheFromObject( SpectralSequenceDifferential,
                                  [ IsCapCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( cocomplex, page, p, q )
    local generalized_morphism_into_source, generalized_differential, generalized_morphism_from_range,
          source_epi, range_mono, generalized_morphism;
    
    generalized_morphism_into_source :=
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p - page, q + page - 1 );
    
    generalized_differential := 
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p, q );

    generalized_morphism_from_range :=
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p + page, q - page + 1 );
    
    return GetSpectralSequenceDifferentialFromConsecutiveGeneralizedDifferentials( 
             generalized_morphism_into_source,
             generalized_differential,
             generalized_morphism_from_range );
    
end );

############################################################
##
## Spectral sequence algorithm for homological bicomplexes
##
############################################################

##
InstallMethodWithCacheFromObject( GeneralizedDifferentialOfTotalComplex,
                                  [ IsCapComplex, IsInt, IsInt, IsInt ],
                                  
  function( bicomplex, page, p, q )
    local vertical_differential, idempotent_source, idempotent_range, differential, i, generalized_morphism_given_by_cospans, auxiliary_cospan;
    
    vertical_differential := Differential( bicomplex[p], q );
    
    if page = 0 then
    
      differential := AsGeneralizedMorphism( vertical_differential );
    
      return differential;
      
    fi;
    
    differential := AsGeneralizedMorphism( Differential( bicomplex, p - page + 1 )[ q + ( page - 1 ) ] );
    
    idempotent_source := IdempotentDefinedBySubobject( KernelEmbedding( vertical_differential ) );
    
    idempotent_range := IdempotentDefinedByFactorobject( CokernelProjection( Differential( bicomplex[p - page], q + page ) ) );
    
    generalized_morphism_given_by_cospans := IdentityMorphism( Source( differential ) );
    
    for i in Reversed( [ 2 .. page ] ) do
      
      auxiliary_cospan := GeneralizedMorphismWithRangeAid(
        Differential( bicomplex, p - ( i - 2 ) )[ q + ( i - 2 ) ],
        Differential( bicomplex[ p - ( i - 1 ) ], q + ( i - 1 ) )
      );
      
      generalized_morphism_given_by_cospans := PreCompose( auxiliary_cospan, generalized_morphism_given_by_cospans );
      
    od;
    
    differential := PreCompose( differential, idempotent_range );
    
    generalized_morphism_given_by_cospans := PreCompose( idempotent_source, generalized_morphism_given_by_cospans );
    
    return PreCompose( generalized_morphism_given_by_cospans, differential );
    
end );

##
InstallMethodWithCacheFromObject( SpectralSequenceEntry,
                                  [ IsCapComplex, IsInt, IsInt, IsInt ],
                                  
  function( complex, page, p, q )
    local generalized_morphism_into_entry, generalized_morphism_from_entry,
          mono, epi, image_embedding;
    
    generalized_morphism_into_entry :=
      GeneralizedDifferentialOfTotalComplex( complex, page, p + page, q - page + 1 );
    
    generalized_morphism_from_entry :=
      GeneralizedDifferentialOfTotalComplex( complex, page, p, q );
    
    return GetSpectralSequenceObjectFromConsecutiveGeneralizedDifferentials( generalized_morphism_into_entry, generalized_morphism_from_entry );
    
end );

##
InstallMethodWithCacheFromObject( SpectralSequenceDifferential,
                                  [ IsCapCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( complex, page, p, q )
    local generalized_morphism_into_source, generalized_differential, generalized_morphism_from_range,
          source_epi, range_mono, generalized_morphism;
    
    generalized_morphism_into_source :=
      GeneralizedDifferentialOfTotalComplex( complex, page, p + page, q - page + 1 );
    
    generalized_differential := 
      GeneralizedDifferentialOfTotalComplex( complex, page, p, q );

    generalized_morphism_from_range :=
      GeneralizedDifferentialOfTotalComplex( complex, page, p - page, q + page - 1 );
    
    return GetSpectralSequenceDifferentialFromConsecutiveGeneralizedDifferentials( 
             generalized_morphism_into_source,
             generalized_differential,
             generalized_morphism_from_range );
    
end );

#############################################################################
##
## Spectral sequence algorithm for ascending filtered complexes (homological)
##
#############################################################################

##
InstallMethodWithCacheFromObject( GeneralizedDifferentialOfAscendingFilteredComplex,
                                  [ IsCapComplex, IsInt, IsInt, IsInt ],
                                  
  function( complex, r, p, q )
    local n, embedding, generalized_embedding, j, projection, generalized_projection, differential;
    
    n := p+q;
    
    embedding := Embedding( complex[n], p - 1 );
    
    generalized_embedding := PseudoInverse( AsGeneralizedMorphism( CokernelProjection( embedding ) ) );
    
    embedding := IdentityMorphism( complex[n-1][p-r] );
      
    for j in [ 0 .. r - 1 ] do
      
      embedding := PreCompose( embedding, Embedding( complex[n-1], p - r + j ) );
      
    od;
    
    projection := CokernelProjection( Embedding( complex[n-1],p-r-1 ) );
    
    generalized_projection := GeneralizedMorphismWithSourceAid( embedding, projection );
    
    differential := AsGeneralizedMorphism( Differential( complex, n )[p] );
    
    return PreCompose( PreCompose( generalized_embedding, differential ), generalized_projection );
    
end );

##
InstallMethodWithCacheFromObject( SpectralSequenceEntryOfAscendingFilteredComplex,
                                  [ IsCapComplex, IsInt, IsInt, IsInt ], 
                                  
function( complex, r, p, q )
    local generalized_morphism_into_entry, generalized_morphism_from_entry,
          mono, epi, image_embedding;
    
    generalized_morphism_into_entry :=
      GeneralizedDifferentialOfAscendingFilteredComplex( complex, r, p + r, q - r + 1 );
    
    generalized_morphism_from_entry :=
      GeneralizedDifferentialOfAscendingFilteredComplex( complex, r, p, q );
    
    return GetSpectralSequenceObjectFromConsecutiveGeneralizedDifferentials( generalized_morphism_into_entry, generalized_morphism_from_entry );
    
end );

##
InstallMethodWithCacheFromObject( SpectralSequenceDifferentialOfAscendingFilteredComplex,
                                  [ IsCapComplex, IsInt, IsInt, IsInt ],
                                  
  function( complex, r, p, q )
    local generalized_morphism_into_source, generalized_differential, generalized_morphism_from_range,
          source_epi, range_mono, generalized_morphism;
    
    generalized_morphism_into_source :=
      GeneralizedDifferentialOfAscendingFilteredComplex( complex, r, p + r, q - r + 1 );
    
    generalized_differential := 
      GeneralizedDifferentialOfAscendingFilteredComplex( complex, r, p, q );

    generalized_morphism_from_range :=
      GeneralizedDifferentialOfAscendingFilteredComplex( complex, r, p - r, q + r - 1 );
    
    return GetSpectralSequenceDifferentialFromConsecutiveGeneralizedDifferentials( 
             generalized_morphism_into_source,
             generalized_differential,
             generalized_morphism_from_range );
    
end );

##################################################################################
##
## Spectral sequence algorithm for descending filtered cocomplexes (cohomological)
##
##################################################################################

##
InstallMethodWithCacheFromObject( GeneralizedDifferentialOfDescendingFilteredCocomplex,
                                  [ IsCapCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( cocomplex, r, p, q )
    local n, embedding, generalized_embedding, j, projection, generalized_projection, differential;
    
    n := p+q;
    
    embedding := Embedding( cocomplex[n], p + 1 );
    
    generalized_embedding := PseudoInverse( AsGeneralizedMorphism( CokernelProjection( embedding ) ) );
    
    embedding := IdentityMorphism( cocomplex[n+1][p+r] );
      
    for j in [ 0 .. r - 1 ] do
      
      embedding := PreCompose( embedding, Embedding( cocomplex[n+1], p + r - j ) );
      
    od;
    
    projection := CokernelProjection( Embedding( cocomplex[n+1],p+r+1 ) );
    
    generalized_projection := GeneralizedMorphismWithSourceAid( embedding, projection );
    
    differential := AsGeneralizedMorphism( Differential( cocomplex, n )[p] );
    
    return PreCompose( PreCompose( generalized_embedding, differential ), generalized_projection );
    
end );

##
InstallMethodWithCacheFromObject( SpectralSequenceEntryOfDescendingFilteredCocomplex,
                                  [ IsCapCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( cocomplex, page, p, q )
    local generalized_morphism_into_entry, generalized_morphism_from_entry,
          mono, epi, image_embedding;
    
    generalized_morphism_into_entry :=
      GeneralizedDifferentialOfDescendingFilteredCocomplex( cocomplex, page, p - page, q + page - 1 );
    
    generalized_morphism_from_entry :=
      GeneralizedDifferentialOfDescendingFilteredCocomplex( cocomplex, page, p, q );
    
    return GetSpectralSequenceObjectFromConsecutiveGeneralizedDifferentials( generalized_morphism_into_entry, generalized_morphism_from_entry );
    
end );

##
InstallMethodWithCacheFromObject( SpectralSequenceDifferentialOfDescendingFilteredCocomplex,
                                  [ IsCapCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( cocomplex, page, p, q )
    local generalized_morphism_into_source, generalized_differential, generalized_morphism_from_range,
          source_epi, range_mono, generalized_morphism;
    
    generalized_morphism_into_source :=
      GeneralizedDifferentialOfDescendingFilteredCocomplex( cocomplex, page, p - page, q + page - 1 );
    
    generalized_differential := 
      GeneralizedDifferentialOfDescendingFilteredCocomplex( cocomplex, page, p, q );

    generalized_morphism_from_range :=
      GeneralizedDifferentialOfDescendingFilteredCocomplex( cocomplex, page, p + page, q - page + 1 );
    
    return GetSpectralSequenceDifferentialFromConsecutiveGeneralizedDifferentials( 
             generalized_morphism_into_source,
             generalized_differential,
             generalized_morphism_from_range );
    
end );
