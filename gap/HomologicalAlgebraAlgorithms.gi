#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

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
            domain, inverse_domain, associated_morphism, codomain, inverse_codomain;
            
#     composition := GeneralizedMorphism( morphism_up_right,
#                                         morphism_middle_middle,
#                                         morphism_down_left );
#     
#     associated_morphism := AssociatedMorphism( composition );
#     
#     return associated_morphism;

###################

    generalized_morphism1 := GeneralizedMorphismWithRangeAid( KernelEmb( morphism_middle_right ), morphism_up_right );
    
    generalized_morphism2 := GeneralizedMorphismWithRangeAid( morphism_middle_middle, morphism_down_left );
    
    cokernel_proj := AsGeneralizedMorphism( CokernelProj( morphism_middle_left ) );
    
    composition := PreCompose( generalized_morphism1, generalized_morphism2 );
    
    composition := PreCompose( composition, cokernel_proj );
    
    associated_morphism := AssociatedMorphism( composition );
    
    return associated_morphism;
    
end );

## Alternative implementation:

#     generalized_morphism1 := GeneralizedMorphismWithRangeAid( KernelEmb( morphism_middle_right ), morphism_up_right );
#     
#     generalized_morphism2 := GeneralizedMorphismWithRangeAid( morphism_middle_middle, morphism_down_left );
#     
#     cokernel_proj := AsGeneralizedMorphism( CokernelProj( morphism_middle_left ) );
#     
#     composition := PreCompose( generalized_morphism1, generalized_morphism2 );
#     
#     composition := PreCompose( composition, cokernel_proj );
    
#     domain := Domain( composition );
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
## Spectral sequence algorithm for cohomological bicomplexes
##
############################################################

##
InstallMethodWithCacheFromObject( GeneralizedDifferentialOfTotalCocomplex,
                                  [ IsCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( bicomplex, page, p, q )
    local vertical_differential, idempotent_source, idempotent_range, differential, i, generalized_morphism_given_by_cospans, auxiliary_cospan;
    
    vertical_differential := Differential( bicomplex[p], q );
    
    if page = 0 then
    
      differential := AsGeneralizedMorphism( vertical_differential );
    
      return differential;
      
    fi;
    
    differential := AsGeneralizedMorphism( Differential( bicomplex, p + ( page - 1 ) )[ q - ( page - 1 ) ] );
    
    idempotent_source := IdempotentDefinedBySubobject( KernelEmb( vertical_differential ) );
    
    idempotent_range := IdempotentDefinedByFactorobject( CokernelProj( Differential( bicomplex[p + page], q - page ) ) );
    
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
                                  [ IsCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( cocomplex, page, p, q )
    local generalized_morphism_into_entry, generalized_morphism_from_entry,
          mono, epi, image_embedding;
    
    generalized_morphism_into_entry :=
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p - page, q + page - 1 );
    
    generalized_morphism_from_entry :=
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p, q );
    
    mono := Domain( generalized_morphism_from_entry );
    
    epi := Codomain( generalized_morphism_into_entry );
    
    image_embedding := ImageEmbedding( PreCompose( mono, epi ) );
    
    return GeneralizedMorphismWithRangeAid( image_embedding, epi );
    
end );

##
InstallMethodWithCacheFromObject( SpectralSequenceDifferential,
                                  [ IsCocomplex, IsInt, IsInt, IsInt ],
                                  
  function( cocomplex, page, p, q )
    local generalized_morphism_into_source, generalized_differential, generalized_morphism_from_range,
          source_epi, range_mono, generalized_morphism;
    
    generalized_morphism_into_source :=
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p - page, q + page - 1 );
    
    generalized_differential := 
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p, q );

    generalized_morphism_from_range :=
      GeneralizedDifferentialOfTotalCocomplex( cocomplex, page, p + page, q - page + 1 );
      
    source_epi := GeneralizedInverse( Codomain( generalized_morphism_into_source ) );
    
    range_mono := GeneralizedInverse( Domain( generalized_morphism_from_range ) );
    
    generalized_morphism := PreCompose( source_epi, PreCompose( generalized_differential, range_mono ) );
    
    return AssociatedMorphism( generalized_morphism );
    
end );
