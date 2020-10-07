# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

###########################
##
## WithGiven pairs
##
###########################

AddWithGivenDerivationPairToCAP( MorphismFromKernelObjectToSink,
        
  function( alpha )
    local K;
    
    K := KernelObject( alpha );
    
    return ZeroMorphism( K, Range( alpha ) );
    
  end : Description := "MorphismFromKernelObjectToSink as zero morphism from kernel object to range" );

##
AddWithGivenDerivationPairToCAP( KernelLift,
  function( mor, test_morphism )
    
    return LiftAlongMonomorphism( KernelEmbedding( mor ), test_morphism );
    
  end,
  
  function( mor, test_morphism, kernel )
    
    return LiftAlongMonomorphism( KernelEmbeddingWithGivenKernelObject( mor, kernel ), test_morphism );
    
end : Description := "KernelLift using LiftAlongMonomorphism and KernelEmbedding" );

##
AddWithGivenDerivationPairToCAP( MorphismFromSourceToCokernelObject,
        
  function( alpha )
    local C;
    
    C := CokernelObject( alpha );
    
    return ZeroMorphism( Source( alpha ), C );
    
  end : Description := "MorphismFromSourceToCokernelObject as zero morphism from source to cokernel object" );

##
AddWithGivenDerivationPairToCAP( CokernelColift,
  function( mor, test_morphism )
    
    return ColiftAlongEpimorphism( CokernelProjection( mor ), test_morphism );
    
  end,

  function( mor, test_morphism, cokernel )
      
      return ColiftAlongEpimorphism( CokernelProjectionWithGivenCokernelObject( mor, cokernel ), test_morphism );
      
end : Description := "CokernelColift using ColiftAlongEpimorphism and CokernelProjection" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoDirectSum,
  function( diagram, source )
    local nr_components;
    
    nr_components := Length( source );
    
    return Sum( List( [ 1 .. nr_components ],
     i -> PreCompose( source[ i ], InjectionOfCofactorOfDirectSum( diagram, i ) ) ) );
    
  end,
  
  function( diagram, source, direct_sum )
    local nr_components;
    
    nr_components := Length( source );
  
    return Sum( List( [ 1 .. nr_components ], 
     i -> PreCompose( source[ i ], InjectionOfCofactorOfDirectSumWithGivenDirectSum( diagram, i, direct_sum ) ) ) );
  
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismIntoDirectSum using the injections of the direct sum" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromDirectSum,
  
  function( diagram, sink )
    local nr_components;
    
    nr_components := Length( sink );
    
    return Sum( List( [ 1 .. nr_components ],
      i -> PreCompose( ProjectionInFactorOfDirectSum( diagram, i ), sink[ i ] ) ) );
    
  end,
  
  function( diagram, sink, direct_sum )
    local nr_components;
    
    nr_components := Length( sink );
    
    return Sum( List( [ 1 .. nr_components ], 
      i -> PreCompose( ProjectionInFactorOfDirectSumWithGivenDirectSum( diagram, i, direct_sum ), sink[ i ] ) ) );
  
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismFromDirectSum using projections of the direct sum" );

##
AddWithGivenDerivationPairToCAP( ProjectionInFactorOfDirectSum,
  
  function( list, projection_number )
    local morphisms;
    
    morphisms := List( [ 1 .. Length( list ) ], function( i )
        
        if i = projection_number then
            
            return IdentityMorphism( list[projection_number] );
            
        else
            
            return ZeroMorphism( list[i], list[projection_number] );
            
        fi;
        
    end );
    
    return UniversalMorphismFromDirectSum( list, morphisms );
    
  end,
  
  function( list, projection_number, direct_sum_object )
    local morphisms;
    
    morphisms := List( [ 1 .. Length( list ) ], function( i )
        
        if i = projection_number then
            
            return IdentityMorphism( list[projection_number] );
            
        else
            
            return ZeroMorphism( list[i], list[projection_number] );
            
        fi;
        
    end );
    
    return UniversalMorphismFromDirectSumWithGivenDirectSum( list, morphisms, direct_sum_object );
    
end : Description := "ProjectionInFactorOfDirectSum using UniversalMorphismFromDirectSum" );

##
AddWithGivenDerivationPairToCAP( InjectionOfCofactorOfDirectSum,
  
  function( list, injection_number )
    local morphisms;
    
    morphisms := List( [ 1 .. Length( list ) ], function( i )
        
        if i = injection_number then
            
            return IdentityMorphism( list[injection_number] );
            
        else
            
            return ZeroMorphism( list[injection_number], list[i] );
            
        fi;
        
    end );
    
    return UniversalMorphismIntoDirectSum( list, morphisms );
    
  end,
  
  function( list, injection_number, direct_sum_object )
    local morphisms;
    
    morphisms := List( [ 1 .. Length( list ) ], function( i )
        
        if i = injection_number then
            
            return IdentityMorphism( list[injection_number] );
            
        else
            
            return ZeroMorphism( list[injection_number], list[i] );
            
        fi;
        
    end );
    
    return UniversalMorphismIntoDirectSumWithGivenDirectSum( list, morphisms, direct_sum_object );
    
end : Description := "InjectionOfCofactorOfDirectSum using UniversalMorphismIntoDirectSum" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoTerminalObject,
  
  function( test_source )
    local terminal_object;
    
    terminal_object := TerminalObject( CapCategory( test_source ) );
    
    return ZeroMorphism( test_source, terminal_object );
    
  end,
  
  function( test_source, terminal_object )
    
    return ZeroMorphism( test_source, terminal_object );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismIntoTerminalObject computing the zero morphism" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromInitialObject,
  
  function( test_sink )
    local initial_object;
    
    initial_object := InitialObject( CapCategory( test_sink ) );
    
    return ZeroMorphism( initial_object, test_sink );
    
  end,
                 
  function( test_sink, initial_object )
    
    return ZeroMorphism( initial_object, test_sink );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismFromInitialObject computing the zero morphism" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromZeroObject,
  
  function( test_sink )
    local zero_object;
    
    zero_object := ZeroObject( CapCategory( test_sink ) );
    
    return ZeroMorphism( zero_object, test_sink );
    
  end,
  
  function( test_sink, zero_object )
    
    return ZeroMorphism( zero_object, test_sink );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismFromZeroObject computing the zero morphism" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoZeroObject,
  
  function( test_source )
    local zero_object;
    
    zero_object := ZeroObject( CapCategory( test_source ) );
    
    return ZeroMorphism( test_source, zero_object );
    
  end,
                 
  function( test_source, zero_object )
    
    return ZeroMorphism( test_source, zero_object );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "UniversalMorphismIntoZeroObject computing the zero morphism" );

##
AddWithGivenDerivationPairToCAP( ProjectionInFactorOfFiberProduct,
        
  function( diagram, projection_number )
    local D, diagram_of_equalizer, iota;
    
    D := List( diagram, Source );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> ProjectionInFactorOfDirectProduct( D, i ) );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( diagram_of_equalizer[i], diagram[i] ) );
    
    iota := EmbeddingOfEqualizer( diagram_of_equalizer );
    
    return PreCompose( [ IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram( diagram ), iota, ProjectionInFactorOfDirectProduct( D, projection_number ) ] );
    
  end : Description := "ProjectionInFactorOfFiberProduct by composing the embedding of equalizer with the direct product projection" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoFiberProduct,
        
  function( diagram, tau )
    local D, diagram_of_equalizer, chi, psi;
    
    D := List( diagram, Source );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> ProjectionInFactorOfDirectProduct( D, i ) );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( diagram_of_equalizer[i], diagram[i] ) );
    
    chi := UniversalMorphismIntoDirectProduct( D, tau );

    psi := UniversalMorphismIntoEqualizer( diagram_of_equalizer, chi );
    
    return PreCompose( psi, IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct( diagram ) );
    
  end : Description := "UniversalMorphismIntoFiberProduct as the universal morphism into equalizer of a univeral morphism into direct product" );

##
AddWithGivenDerivationPairToCAP( ProjectionInFactorOfFiberProduct,
                      
  function( diagram, projection_number )
    local embedding_in_direct_sum, direct_sum_diagram, projection;
    
    embedding_in_direct_sum := FiberProductEmbeddingInDirectSum( diagram );
    
    direct_sum_diagram := List( diagram, Source );
    
    projection := ProjectionInFactorOfDirectSum( direct_sum_diagram, projection_number );
    
    return PreCompose( embedding_in_direct_sum, projection );
    
  end : Description := "ProjectionInFactorOfFiberProduct by composing the direct sum embedding with the direct sum projection" );

##
AddWithGivenDerivationPairToCAP( MorphismFromFiberProductToSink,
        
  function( diagram )
    local pi_1;
    
    pi_1 := ProjectionInFactorOfFiberProduct( diagram, 1 );
    
    return PreCompose( pi_1, diagram[1] );
    
  end : Description := "MorphismFromFiberProductToSink by composing the first projection with the first morphism in the diagram" );

##
AddWithGivenDerivationPairToCAP( InjectionOfCofactorOfPushout,
        
  function( diagram, injection_number )
    local D, diagram_of_coequalizer, pi;
    
    D := List( diagram, Range );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> InjectionOfCofactorOfCoproduct( D, i ) );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( diagram[i], diagram_of_coequalizer[i] ) );
    
    pi := ProjectionOntoCoequalizer( diagram_of_coequalizer );
    
    return PreCompose( [ InjectionOfCofactorOfCoproduct( D, injection_number ), pi, IsomorphismFromCoequalizerOfCoproductDiagramToPushout( diagram ) ] );
    
  end : Description := "InjectionOfCofactorOfPushout by composing the coproduct injection with the projection onto coequalizer" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromPushout,
        
  function( diagram, tau )
    local D, diagram_of_coequalizer, chi, psi;
    
    D := List( diagram, Range );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> InjectionOfCofactorOfCoproduct( D, i ) );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( diagram[i], diagram_of_coequalizer[i] ) );
    
    chi := UniversalMorphismFromCoproduct( D, tau );
    
    psi := UniversalMorphismFromCoequalizer( diagram_of_coequalizer, chi );
    
    return PreCompose( IsomorphismFromPushoutToCoequalizerOfCoproductDiagram( diagram ), psi );
    
  end : Description := "UniversalMorphismFromPushout as the universal morphism from coequalizer of a univeral morphism from coproduct" );

##
AddWithGivenDerivationPairToCAP( InjectionOfCofactorOfPushout,
                                         
  function( diagram, injection_number )
    local projection_from_direct_sum, direct_sum_diagram, injection;
    
    projection_from_direct_sum := DirectSumProjectionInPushout( diagram );
    
    direct_sum_diagram := List( diagram, Range );
    
    injection := InjectionOfCofactorOfDirectSum( direct_sum_diagram, injection_number );
    
    return PreCompose( injection, projection_from_direct_sum );
    
  end : Description := "InjectionOfCofactorOfPushout by composing the direct sum injection with the direct sum projection to the pushout" );

##
AddWithGivenDerivationPairToCAP( MorphismFromSourceToPushout,
  
  function( diagram )
    local iota_1;
    
    iota_1 := InjectionOfCofactorOfPushout( diagram, 1 );
    
    return PreCompose( diagram[1], iota_1 );
    
  end : Description := "MorphismFromSourceToPushout by composing the first morphism in the diagram with the first injection" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromZeroObject,
                  
  function( obj )
    local category;
    
    category := CapCategory( obj );
    
    return PreCompose( IsomorphismFromZeroObjectToInitialObject( category ),
                       UniversalMorphismFromInitialObject( obj ) );
    
  end : Description := "UniversalMorphismFromZeroObject using UniversalMorphismFromInitialObject" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoZeroObject,
                  
  function( obj )
    local category;
    
    category := CapCategory( obj );
    
    return PreCompose( UniversalMorphismIntoTerminalObject( obj ),
                       IsomorphismFromTerminalObjectToZeroObject( category ) );
  end : Description := "UniversalMorphismIntoZeroObject using UniversalMorphismIntoTerminalObject" );

##
AddWithGivenDerivationPairToCAP( ProjectionInFactorOfDirectSum,
                
  function( diagram, projection_number )
    
    return PreCompose( IsomorphismFromDirectSumToDirectProduct( diagram ),
                       ProjectionInFactorOfDirectProduct( diagram, projection_number ) );
    
  end : Description := "ProjectionInFactorOfDirectSum using ProjectionInFactorOfDirectProduct" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoDirectSum,
                    
  function( diagram, source )
    
    return PreCompose( UniversalMorphismIntoDirectProduct( diagram, source ),
                       IsomorphismFromDirectProductToDirectSum( diagram ) );
  end : Description := "UniversalMorphismIntoDirectSum using UniversalMorphismIntoDirectProduct" );

##
AddWithGivenDerivationPairToCAP( InjectionOfCofactorOfDirectSum,
                    
  function( diagram, injection_number )
    
    return PreCompose( InjectionOfCofactorOfCoproduct( diagram, injection_number ),
                       IsomorphismFromCoproductToDirectSum( diagram ) );
  end : Description := "InjectionOfCofactorOfDirectSum using InjectionOfCofactorOfCoproduct" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromDirectSum,
                    
  function( diagram, sink )
    
    return PreCompose( IsomorphismFromDirectSumToCoproduct( diagram ),
                       UniversalMorphismFromCoproduct( diagram, sink ) );
  end : Description := "UniversalMorphismFromDirectSum using UniversalMorphismFromCoproduct" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoTerminalObject,
  
  function( obj )
    local category;
    
    category := CapCategory( obj );
    
    return PreCompose( UniversalMorphismIntoZeroObject( obj ),
                       IsomorphismFromZeroObjectToTerminalObject( category ) );
    
  end : Description := "UniversalMorphismFromInitialObject using UniversalMorphismFromZeroObject" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromInitialObject,
  
  function( obj )
    local category;
    
    category := CapCategory( obj );
    
    return PreCompose( IsomorphismFromInitialObjectToZeroObject( category ),
                       UniversalMorphismFromZeroObject( obj ) );
    
  end : Description := "UniversalMorphismFromInitialObject using UniversalMorphismFromZeroObject" );

##
AddWithGivenDerivationPairToCAP( ProjectionInFactorOfDirectProduct,
  
  function( diagram, projection_number )
    
    return PreCompose( IsomorphismFromDirectProductToDirectSum( diagram ),
                       ProjectionInFactorOfDirectSum( diagram, projection_number ) );
  end : Description := "ProjectionInFactorOfDirectProduct using ProjectionInFactorOfDirectSum" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoDirectProduct,
                    
  function( diagram, source )
    
    return PreCompose( UniversalMorphismIntoDirectSum( diagram, source ),
                       IsomorphismFromDirectSumToDirectProduct( diagram ) );
    
  end : Description := "UniversalMorphismIntoDirectProduct using UniversalMorphismIntoDirectSum" );

##
AddWithGivenDerivationPairToCAP( InjectionOfCofactorOfCoproduct,
                      
  function( diagram, injection_number )
    
    return PreCompose( InjectionOfCofactorOfDirectSum( diagram, injection_number ),
                       IsomorphismFromDirectSumToCoproduct( diagram ) );
  end : Description := "InjectionOfCofactorOfCoproduct using InjectionOfCofactorOfDirectSum" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromCoproduct,
                    
  function( diagram, sink )
    
    return PreCompose( IsomorphismFromCoproductToDirectSum( diagram ),
                       UniversalMorphismFromDirectSum( diagram, sink ) );
  end : Description := "UniversalMorphismFromCoproduct using UniversalMorphismFromDirectSum" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoFiberProduct,
                                       
  function( diagram, source )
    local test_function, direct_sum_diagonal_difference, kernel_lift;
    
    test_function := CallFuncList( UniversalMorphismIntoDirectSum, source );
    
    direct_sum_diagonal_difference := DirectSumDiagonalDifference( diagram );
    
    kernel_lift := KernelLift( direct_sum_diagonal_difference, test_function );
    
    return PreCompose(
             kernel_lift,
             IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct( diagram )
           );
    
  end : Description := "UniversalMorphismIntoFiberProduct using the universality of the kernel representation of the pullback" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromPushout,
                            
  function( diagram, sink )
    local test_function, direct_sum_codiagonal_difference, cokernel_colift;
    
    test_function := CallFuncList( UniversalMorphismFromDirectSum, sink );
    
    direct_sum_codiagonal_difference := DirectSumCodiagonalDifference( diagram );
    
    cokernel_colift := CokernelColift( direct_sum_codiagonal_difference, test_function );
    
    return PreCompose( IsomorphismFromPushoutToCokernelOfDiagonalDifference( diagram ),
                       cokernel_colift );
    
  end : Description := "UniversalMorphismFromPushout using the universality of the cokernel representation of the pushout" );

##
AddWithGivenDerivationPairToCAP( ImageEmbedding,
                      
  function( mor )
    local image_embedding;
    
    image_embedding := KernelEmbedding( CokernelProjection( mor ) );
    
    return PreCompose( IsomorphismFromImageObjectToKernelOfCokernel( mor ),
                       image_embedding );
  
  end : CategoryFilter := IsAbelianCategory, ##FIXME: PreAbelian?
      Description := "ImageEmbedding as the kernel embedding of the cokernel projection"
);

##
AddWithGivenDerivationPairToCAP( CoimageProjection,
  
  function( mor )
    local coimage_projection;
    
    coimage_projection := CokernelProjection( KernelEmbedding( mor ) );
    
    return PreCompose( coimage_projection,
                       IsomorphismFromCokernelOfKernelToCoimage( mor ) );
    
end : CategoryFilter := IsAbelianCategory, ##FIXME: PreAbelian?
      Description := "CoimageProjection as the cokernel projection of the kernel embedding" );

##
AddWithGivenDerivationPairToCAP( CoimageProjection,
  
  function( mor )
    local iso;
    
    iso := CanonicalIdentificationFromImageObjectToCoimage( mor );
    
    return PreCompose( CoastrictionToImage( mor ), iso );
    
end : Description := "CoimageProjection as the coastriction to image" );

##
AddWithGivenDerivationPairToCAP( CoastrictionToImage,
                      
  function( morphism )
    local image_embedding;
    
    image_embedding := ImageEmbedding( morphism );
    
    return LiftAlongMonomorphism( image_embedding, morphism );
  
  end,
  
  function( morphism, image )
    local image_embedding;
    
    image_embedding := ImageEmbeddingWithGivenImageObject( morphism, image );
    
    return LiftAlongMonomorphism( image_embedding, morphism );
  
end : Description := "CoastrictionToImage using that image embedding can be seen as a kernel" );

##
AddWithGivenDerivationPairToCAP( AstrictionToCoimage,
          
  function( morphism )
    local coimage_projection;
    
    coimage_projection := CoimageProjection( morphism );
    
    return ColiftAlongEpimorphism( coimage_projection, morphism );
    
  end,
  
  function( morphism, coimage )
    local coimage_projection;
    
    coimage_projection := CoimageProjectionWithGivenCoimage( morphism, coimage );
    
    return ColiftAlongEpimorphism( coimage_projection, morphism );
    
end : Description := "AstrictionToCoimage using that coimage projection can be seen as a cokernel" );

##
AddWithGivenDerivationPairToCAP( AstrictionToCoimage,
          
  function( morphism )
    local image_emb;
    
    image_emb := ImageEmbedding( morphism );
    
    return PreCompose( CanonicalIdentificationFromCoimageToImageObject( morphism ), image_emb );
    
  end,
  
  function( morphism, coimage )
    local image_emb;
    
    image_emb := ImageEmbedding( morphism );
    
    return PreCompose( CanonicalIdentificationFromCoimageToImageObject( morphism ), image_emb );
    
end : Description := "AstrictionToCoimage as the image embedding" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromImage,
                      
  function( morphism, test_factorization )
    local image_embedding;
    
    image_embedding := ImageEmbedding( morphism );
    
    return LiftAlongMonomorphism( test_factorization[2], image_embedding );
    
  end,
  
  function( morphism, test_factorization, image )
    local image_embedding;
    
    image_embedding := ImageEmbeddingWithGivenImageObject( morphism, image );
    
    return LiftAlongMonomorphism( test_factorization[2], image_embedding );
    
end : Description := "UniversalMorphismFromImage using ImageEmbedding and LiftAlongMonomorphism" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoCoimage,
  
  function( morphism, test_factorization )
    local coimage_projection;
    
    coimage_projection := CoimageProjection( morphism );
    
    return ColiftAlongEpimorphism( test_factorization[1], coimage_projection );
    
  end,
  
  function( morphism, test_factorization, coimage )
    local coimage_projection;
    
    coimage_projection := CoimageProjectionWithGivenCoimage( morphism, coimage );
    
    return ColiftAlongEpimorphism( test_factorization[1], coimage_projection );
    
end : Description := "UniversalMorphismIntoCoimage using CoimageProjection and ColiftAlongEpimorphism" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoCoimage,
  
  function( morphism, test_factorization )
    local induced_mor;
    
    induced_mor := UniversalMorphismFromImage( morphism, test_factorization );
    
    return PreCompose( Inverse( induced_mor ), CanonicalIdentificationFromImageObjectToCoimage( morphism ) );
    
  end : Description := "UniversalMorphismIntoCoimage using UniversalMorphismFromImage and CanonicalIdentificationFromImageObjectToCoimage" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoEqualizer,
  function( diagram, test_morphism )
    
    return LiftAlongMonomorphism( EmbeddingOfEqualizer( diagram ), test_morphism );
    
  end,
  
  function( diagram, test_morphism, equalizer )
    
    return LiftAlongMonomorphism( EmbeddingOfEqualizerWithGivenEqualizer( diagram, equalizer ), test_morphism );
    
end : Description := "UniversalMorphismIntoEqualizer using LiftAlongMonomorphism and EmbeddingOfEqualizer" );

##
AddWithGivenDerivationPairToCAP( MorphismFromEqualizerToSink,
        
  function( diagram )
    local iota;
    
    iota := EmbeddingOfEqualizer( diagram );
    
    return PreCompose( iota, diagram[1] );
    
  end : Description := "MorphismFromEqualizerToSink by composing the embedding with the first morphism in the diagram" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromCoequalizer,
  function( diagram, test_morphism )
    
    return ColiftAlongEpimorphism( ProjectionOntoCoequalizer( diagram ), test_morphism );
    
  end,

  function( diagram, test_morphism, coequalizer )
      
      return ColiftAlongEpimorphism( ProjectionOntoCoequalizerWithGivenCoequalizer( diagram, coequalizer ), test_morphism );
      
end : Description := "UniversalMorphismFromCoequalizer using ColiftAlongEpimorphism and ProjectionOntoCoequalizer" );

##
AddWithGivenDerivationPairToCAP( MorphismFromSourceToCoequalizer,
  
  function( diagram )
    local pi;
    
    pi := ProjectionOntoCoequalizer( diagram );
    
    return PreCompose( diagram[1], pi );
    
  end : Description := "MorphismFromSourceToCoequalizer by composing the first morphism in the diagram with the projection" );

###########################
##
## Methods returning a boolean
##
###########################

##
AddDerivationToCAP( IsProjective,
  function( object )
    
    return IsLiftable(
      IdentityMorphism( object ),
      EpimorphismFromSomeProjectiveObject( object )
    );
    
end : Description := "IsProjective by checking if the object is a summand of some projective object" );

##
AddDerivationToCAP( IsInjective,
  function( object )
    
    return IsColiftable(
      MonomorphismIntoSomeInjectiveObject( object ),
      IdentityMorphism( object )
    );
    
end : Description := "IsInjective by checking if the object is a summand of some injective object" );

##
AddDerivationToCAP( IsOne,
                    
  function( morphism )
    local object;
    
    object := Source( morphism );
    
    return IsCongruentForMorphisms( IdentityMorphism( object ), morphism );
    
end : Description := "IsOne by comparing with the identity morphism" );

##
AddDerivationToCAP( IsEndomorphism,
                      
  function( morphism )
    
    return IsEqualForObjects( Source( morphism ), Range( morphism ) );
    
end : Description := "IsEndomorphism by deciding whether source and range are equal as objects" );

##
AddDerivationToCAP( IsAutomorphism,
                    
  function( morphism )
    
    return IsIsomorphism( morphism ) and IsEndomorphism( morphism );
    
end : Description := "IsAutomorphism by checking IsIsomorphism and IsEndomorphism");

##
AddDerivationToCAP( IsZeroForMorphisms,
                      
  function( morphism )
    local zero_morphism;
    
    zero_morphism := ZeroMorphism( Source( morphism ), Range( morphism ) );
    
    return IsCongruentForMorphisms( zero_morphism, morphism );
    
end : Description := "IsZeroForMorphisms by deciding whether the given morphism is congruent to the zero morphism" );

##
AddDerivationToCAP( IsIdenticalToIdentityMorphism,
                    [ [ IsEqualForMorphismsOnMor, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( morphism )
    
    return IsEqualForMorphismsOnMor( morphism, IdentityMorphism( Source( morphism ) ) );
    
end : Description := "IsIdenticalToIdentityMorphism using IsEqualForMorphismsOnMor and IdentityMorphism" );

##
AddDerivationToCAP( IsIdenticalToZeroMorphism,
                    
  function( morphism )
    
    return IsEqualForMorphismsOnMor( morphism, ZeroMorphism( Source( morphism ), Range( morphism ) ) );
    
end : Description := "IsIdenticalToZeroMorphism using IsEqualForMorphismsOnMor and ZeroMorphism" );

##
AddDerivationToCAP( IsZeroForObjects,
                    [ [ IsCongruentForMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ZeroMorphism, 1 ] ],
                 
  function( object )
  
    return IsCongruentForMorphisms( IdentityMorphism( object ), ZeroMorphism( object, object ) );
    
end : Description := "IsZeroForObjects by comparing identity morphism with zero morphism" );

##
AddDerivationToCAP( IsTerminal,
                  
  function( object )
    
    return IsZeroForObjects( object );
    
end : Description := "IsTerminal using IsZeroForObjects",
      CategoryFilter := IsAdditiveCategory ); #Ab-Category?

##
AddDerivationToCAP( IsTerminal,
                  
  function( object )
    
    return IsIsomorphism( UniversalMorphismIntoTerminalObject( object ) );
    
end : Description := "IsTerminal using IsIsomorphism( UniversalMorphismIntoTerminalObject )" );

##
AddDerivationToCAP( IsInitial,
                  
  function( object )
    
    return IsZeroForObjects( object );
    
end : Description := "IsInitial using IsZeroForObjects",
      CategoryFilter := IsAdditiveCategory ); #Ab-Category?

##
AddDerivationToCAP( IsInitial,
                  
  function( object )
    
    return IsIsomorphism( UniversalMorphismFromInitialObject( object ) );
    
end : Description := "IsInitial using IsIsomorphism( UniversalMorphismFromInitialObject )" );

##
AddDerivationToCAP( IsEqualForMorphismsOnMor,
                    [ [ IsEqualForMorphisms, 1 ],
                      [ IsEqualForObjects, 2 ] ],
                    
  function( morphism_1, morphism_2 )
    local value_1, value_2;
    
    value_1 := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if value_1 = fail then
      
      return fail;
      
    fi;
    
    value_2 := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if value_2 = fail then
      
      return fail;
      
    fi;
    
    
    if ( value_1 = false ) or ( value_2 = false ) then
    
      return false;
    
    fi;
    
    return IsEqualForMorphisms( morphism_1, morphism_2 );
    
end : Description := "IsEqualForMorphismsOnMor using IsEqualForMorphisms" );

##
AddDerivationToCAP( IsIdempotent,
  function( morphism )
    
    return IsCongruentForMorphisms( PreCompose( morphism, morphism ), morphism );
    
end : Description := "IsIdempotent by comparing the square of the morphism with itself" );

##
AddDerivationToCAP( IsMonomorphism,
                    [ [ IsZeroForObjects, 1 ],
                      [ KernelObject, 1 ] ],
  function( morphism )
    
    return IsZeroForObjects( KernelObject( morphism ) );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "IsMonomorphism by deciding if the kernel is a zero object" );

##
AddDerivationToCAP( IsMonomorphism,
                    [ [ IsIsomorphism, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ UniversalMorphismIntoFiberProduct, 1 ] ],
                 
  function( morphism )
    local pullback_diagram, pullback_projection_1, pullback_projection_2, identity, diagonal_morphism;
      
      pullback_diagram := [ morphism, morphism ];
      
      identity := IdentityMorphism( Source( morphism ) );
      
      diagonal_morphism := UniversalMorphismIntoFiberProduct( pullback_diagram, identity, identity );
      
      return IsIsomorphism( diagonal_morphism );
    
end : Description := "IsMonomorphism by deciding if the diagonal morphism is an isomorphism" );

##
AddDerivationToCAP( IsEpimorphism,
                    [ [ IsZeroForObjects, 1 ],
                      [ CokernelObject, 1 ] ],
  function( morphism )
    
    return IsZeroForObjects( CokernelObject( morphism ) );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "IsEpimorphism by deciding if the cokernel is a zero object" );

##
AddDerivationToCAP( IsEpimorphism,
                    [ [ IdentityMorphism, 1 ],
                      [ UniversalMorphismFromPushout, 1 ],
                      [ IsIsomorphism, 1 ] ],
                 
  function( morphism )
    local pushout_diagram, identity, codiagonal_morphism;
      
      pushout_diagram := [ morphism, morphism ];
      
      identity := IdentityMorphism( Range( morphism ) );
      
      codiagonal_morphism := UniversalMorphismFromPushout( pushout_diagram, identity, identity );
      
      return IsIsomorphism( codiagonal_morphism );
    
end : Description := "IsEpimorphism by deciding if the codiagonal morphism is an isomorphism" );

##
AddDerivationToCAP( IsIsomorphism,
                    [ [ IsMonomorphism, 1 ],
                      [ IsEpimorphism, 1 ] ],
                 
  function( morphism )
    
    return IsMonomorphism( morphism ) and IsEpimorphism( morphism );
    
end : CategoryFilter := IsAbelianCategory,
      Description := "IsIsomorphism by deciding if it is a mono and an epi" );

##
AddDerivationToCAP( IsIsomorphism,
                    [ [ IsSplitMonomorphism, 1 ],
                      [ IsSplitEpimorphism, 1 ] ],
                 
  function( morphism )
    
    return IsSplitMonomorphism( morphism ) and IsSplitEpimorphism( morphism );
    
end : Description := "IsIsomorphism by deciding if it is a split mono and a split epi" );

##
AddDerivationToCAP( IsIsomorphism,
                    [ [ IsSplitMonomorphism, 1 ],
                      [ IsEpimorphism, 1 ] ],
                 
  function( morphism )
    
    return IsSplitMonomorphism( morphism ) and IsEpimorphism( morphism );
    
end : Description := "IsIsomorphism by deciding if it is a split mono and an epi" );

##
AddDerivationToCAP( IsIsomorphism,
                    [ [ IsMonomorphism, 1 ],
                      [ IsSplitEpimorphism, 1 ] ],
                 
  function( morphism )
    
    return IsMonomorphism( morphism ) and IsSplitEpimorphism( morphism );
    
end : Description := "IsIsomorphism by deciding if it is a mono and a split epi" );

##
AddDerivationToCAP( IsSplitEpimorphism,
                    [ [ IsLiftable, 1 ],
                      [ IdentityMorphism, 1 ] ],
  
  function( morphism )
    
    return IsLiftable( IdentityMorphism( Range( morphism ) ), morphism );
  
end : Description := "IsSplitEpimorphism by using IsLiftable" );

##
AddDerivationToCAP( IsSplitMonomorphism,
                    [ [ IsColiftable, 1 ],
                      [ IdentityMorphism, 1 ] ],
  
  function( morphism )
    
    return IsColiftable( morphism, IdentityMorphism( Source( morphism ) ) );
  
end : Description := "IsSplitMonomorphism by using IsColiftable" );

##
AddDerivationToCAP( IsEqualAsSubobjects,
                    [ [ IsDominating, 2 ] ],
               
  function( sub1, sub2 );
    
    return IsDominating( sub1, sub2 ) and IsDominating( sub2, sub1 );
    
end : Description := "IsEqualAsSubobjects(sub1, sub2) if sub1 dominates sub2 and vice versa" );

##
AddDerivationToCAP( IsEqualAsFactorobjects,
                    [ [ IsCodominating, 2 ] ],
                                  
  function( factor1, factor2 )
    
    return IsCodominating( factor1, factor2 ) and IsCodominating( factor1, factor2 );
    
end : Description := "IsEqualAsFactorobjects(factor1, factor2) if factor1 dominates factor2 and vice versa" );

##
AddDerivationToCAP( IsDominating,
                    [ [ CokernelProjection, 2 ],
                      [ IsCodominating, 1 ] ],
                                  
  function( sub1, sub2 )
    local cokernel_projection_1, cokernel_projection_2;
    
    cokernel_projection_1 := CokernelProjection( sub1 );
    
    cokernel_projection_2 := CokernelProjection( sub2 );
    
    return IsCodominating( cokernel_projection_1, cokernel_projection_2 );
    
end : Description := "IsDominating using IsCodominating and duality by cokernel" );

##
AddDerivationToCAP( IsDominating,
                    [ [ CokernelProjection, 1 ],
                      [ PreCompose, 1 ],
                      [ IsZeroForMorphisms, 1 ] ],
                                  
  function( sub1, sub2 )
    local cokernel_projection, composition;
    
    cokernel_projection := CokernelProjection( sub2 );
    
    composition := PreCompose( sub1, cokernel_projection );
    
    return IsZeroForMorphisms( composition );
    
end : Description := "IsDominating(sub1, sub2) by deciding if sub1 composed with CokernelProjection(sub2) is zero" );

##
AddDerivationToCAP( IsCodominating,
                    [ [ KernelEmbedding, 2 ],
                      [ IsDominating, 1 ] ],
                                  
  function( factor1, factor2 )
    local kernel_embedding_1, kernel_embedding_2;
    
    kernel_embedding_1 := KernelEmbedding( factor1 );
    
    kernel_embedding_2 := KernelEmbedding( factor2 );
    
    return IsDominating( kernel_embedding_2, kernel_embedding_1 );
    
end : Description := "IsCodominating using IsDominating and duality by kernel" );

##
AddDerivationToCAP( IsCodominating,
                    [ [ KernelEmbedding, 1 ],
                      [ PreCompose, 1 ],
                      [ IsZeroForMorphisms, 1 ] ],
                                  
  function( factor1, factor2 )
    local kernel_embedding, composition;
    
    kernel_embedding := KernelEmbedding( factor2 );
    
    composition := PreCompose( kernel_embedding, factor1 );
    
    return IsZeroForMorphisms( composition );
    
end : Description := "IsCodominating(factor1, factor2) by deciding if KernelEmbedding(factor2) composed with factor1 is zero" );

##
AddDerivationToCAP( IsLiftable,
                    [ [ Lift, 1 ] ],
  function( alpha, beta )
    
    return IsCapCategoryMorphism( Lift( alpha, beta ) );
    
end : Description := "IsLiftable using Lift" );

##
AddDerivationToCAP( IsLiftableAlongMonomorphism,
                    [ [ Lift, 1 ] ],
  function( iota, tau )
    
    return IsCapCategoryMorphism( Lift( tau, iota ) );
    
end : Description := "IsLiftableAlongMonomorphism using Lift" );

##
AddDerivationToCAP( IsColiftable,
                    [ [ Colift, 1 ] ],
  function( alpha, beta )
    
    return IsCapCategoryMorphism( Colift( alpha, beta ) );
    
end : Description := "IsColiftable using Colift" );

##
AddDerivationToCAP( IsColiftableAlongEpimorphism,
                    [ [ Colift, 1 ] ],
  function( epsilon, tau )
    
    return IsCapCategoryMorphism( Colift( epsilon, tau ) );
    
end : Description := "IsColiftableAlongEpimorphism using Colift" );

###########################
##
## Methods returning a morphism where the source and range can directly be read of from the input
##
###########################

##
AddDerivationToCAP( ZeroMorphism,
                    [ [ PreCompose, 1 ],
                      [ UniversalMorphismIntoZeroObject, 1 ],
                      [ UniversalMorphismFromZeroObject, 1 ] ],
                 
  function( obj_source, obj_range )
    
    return PreCompose( UniversalMorphismIntoZeroObject( obj_source ), UniversalMorphismFromZeroObject( obj_range ) );
    
  end : CategoryFilter := IsAdditiveCategory,
        Description := "Zero morphism by composition of morphism into and from zero object" );

##
AddDerivationToCAP( PostCompose,
                    [ [ PreCompose, 1 ] ],
                    
  function( right_mor, left_mor )
    
    return PreCompose( left_mor, right_mor );
    
end : Description := "PostCompose using PreCompose and swapping arguments" );

##
AddDerivationToCAP( PreCompose,
                    [ [ PostCompose, 1 ] ],
                    
  function( left_mor, right_mor )
    
    return PostCompose( right_mor, left_mor );
    
end : Description := "PreCompose using PostCompose and swapping arguments" );

##
AddDerivationToCAP( Inverse,
                    [ [ IdentityMorphism, 1 ],
                      [ LiftAlongMonomorphism, 1 ] ],
                                       
  function( mor )
    local identity_of_range;
        
        identity_of_range := IdentityMorphism( Range( mor ) );
        
        return LiftAlongMonomorphism( mor, identity_of_range );
        
end : Description := "Inverse using LiftAlongMonomorphism of an identity morphism" );

##
AddDerivationToCAP( Inverse,
                    [ [ IdentityMorphism, 1 ],
                      [ ColiftAlongEpimorphism, 1 ] ],
                                       
  function( mor )
    local identity_of_source;
    
    identity_of_source := IdentityMorphism( Source( mor ) );
    
    return ColiftAlongEpimorphism( mor, identity_of_source );
      
end : Description := "Inverse using ColiftAlongEpimorphism of an identity morphism" );


##
AddDerivationToCAP( AdditionForMorphisms,
                    [ [ UniversalMorphismIntoDirectSum, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ UniversalMorphismFromDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                      
  function( mor1, mor2 )
    local return_value, B, identity_morphism_B, componentwise_morphism, addition_morphism;
    
    B := Range( mor1 );
    
    componentwise_morphism := UniversalMorphismIntoDirectSum( mor1, mor2 );
    
    identity_morphism_B := IdentityMorphism( B );
    
    addition_morphism := UniversalMorphismFromDirectSum( identity_morphism_B, identity_morphism_B );
    
    return PreCompose( componentwise_morphism, addition_morphism );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "AdditionForMorphisms(mor1, mor2) as the composition of (mor1,mor2) with the codiagonal morphism" );

##
AddDerivationToCAP( SubtractionForMorphisms,
                      
  function( mor1, mor2 )
    
    return AdditionForMorphisms( mor1, AdditiveInverseForMorphisms( mor2 ) );
    
end : CategoryFilter := IsAbCategory,
      Description := "SubtractionForMorphisms(mor1, mor2) as the sum of mor1 and the additive inverse of mor2" );

##
AddDerivationToCAP( LiftAlongMonomorphism,
                    [ [ Lift, 1 ] ],
                    
  function( alpha, beta )
    
    ## Caution with the order of the arguments!
    return Lift( beta, alpha );
    
end : Description := "LiftAlongMonomorphism using Lift" );

##
AddDerivationToCAP( ProjectiveLift,
                    [ [ Lift, 1 ] ],
                    
  function( alpha, beta )
    
    return Lift( alpha, beta );
    
end : Description := "ProjectiveLift using Lift" );


##
AddDerivationToCAP( ColiftAlongEpimorphism,
                    [ [ Colift, 1 ] ],
                    
  function( alpha, beta )
    
    return Colift( alpha, beta );
    
end : Description := "ColiftAlongEpimorphism using Colift" );

##
AddDerivationToCAP( InjectiveColift,
                    [ [ Colift, 1 ] ],
                    
  function( alpha, beta )
    
    return Colift( alpha, beta );
    
end : Description := "InjectiveColift using Colift" );

##
AddDerivationToCAP( RandomMorphismByInteger,
                    [
                      [ RandomObjectByInteger, 1 ],
                      [ RandomMorphismWithFixedSourceByInteger, 1 ]
                    ],

  function( category, n )
    local M;
    
    M := RandomObjectByInteger( category, n );
    
    if M = fail then
      
      return fail;
    
    else
      
      return RandomMorphismWithFixedSourceByInteger( M, n );
    
    fi;
    
end : Description := "RandomMorphismByInteger using RandomObjectByInteger and RandomMorphismWithFixedSourceByInteger" );

##
AddDerivationToCAP( RandomMorphismByInteger,
                    [
                      [ RandomObjectByInteger, 1 ],
                      [ RandomMorphismWithFixedRangeByInteger, 1 ]
                    ],

  function( category, n )
    local M;
    
    M := RandomObjectByInteger( category, n );
    
    if M = fail then
      
      return fail;
    
    else
      
      return RandomMorphismWithFixedRangeByInteger( M, n );
    
    fi;
    
end : Description := "RandomMorphismByInteger using RandomObjectByInteger and RandomMorphismWithFixedRangeByInteger" );

##
AddDerivationToCAP( IsomorphismFromKernelOfCokernelToImageObject,
        
  function( morphism )
    
    return Inverse( IsomorphismFromImageObjectToKernelOfCokernel( morphism ) );
    
end : Description := "IsomorphismFromKernelOfCokernelToImageObject as the inverse of IsomorphismFromImageObjectToKernelOfCokernel" );

##
AddDerivationToCAP( IsomorphismFromImageObjectToKernelOfCokernel,
        
  function( morphism )
    
    return Inverse( IsomorphismFromKernelOfCokernelToImageObject( morphism ) );
    
end : Description := "IsomorphismFromImageObjectToKernelOfCokernel as the inverse of IsomorphismFromKernelOfCokernelToImageObject" );

##
AddDerivationToCAP( IsomorphismFromImageObjectToKernelOfCokernel,
        
  function( morphism )
    local kernel_emb, morphism_to_kernel;
    
    kernel_emb := KernelEmbedding( CokernelProjection( morphism ) );
    
    morphism_to_kernel := LiftAlongMonomorphism( kernel_emb, morphism );
    
    return UniversalMorphismFromImage( morphism, [ morphism_to_kernel, kernel_emb ] );
    
end : Description := "IsomorphismFromImageObjectToKernelOfCokernel using the universal property of the image" );

##
AddDerivationToCAP( IsomorphismFromCokernelOfKernelToCoimage,
        
  function( morphism )
    
    return Inverse( IsomorphismFromCoimageToCokernelOfKernel( morphism ) );
    
end : Description := "IsomorphismFromCokernelOfKernelToCoimage as the inverse of IsomorphismFromCoimageToCokernelOfKernel" );

##
AddDerivationToCAP( IsomorphismFromCokernelOfKernelToCoimage,
        
  function( morphism )
    local cokernel_proj, morphism_from_cokernel;
    
    cokernel_proj := CokernelProjection( KernelEmbedding( morphism ) );
    
    morphism_from_cokernel := ColiftAlongEpimorphism( cokernel_proj, morphism );
    
    return UniversalMorphismIntoCoimage( morphism, [ cokernel_proj, morphism_from_cokernel ] );
    
end : Description := "IsomorphismFromCokernelOfKernelToCoimage using the universal property of the coimage" );

##
AddDerivationToCAP( IsomorphismFromCoimageToCokernelOfKernel,
        
  function( morphism )
    
    return Inverse( IsomorphismFromCokernelOfKernelToCoimage( morphism ) );
    
end : Description := "IsomorphismFromCoimageToCokernelOfKernel as the inverse of IsomorphismFromCokernelOfKernelToCoimage" );

##
AddDerivationToCAP( IsomorphismFromFiberProductToKernelOfDiagonalDifference,
          
  function( diagram )
    local direct_sum_diagonal_difference, fiber_product_embedding_in_direct_sum;
    
    direct_sum_diagonal_difference := DirectSumDiagonalDifference( diagram );
    
    fiber_product_embedding_in_direct_sum := FiberProductEmbeddingInDirectSum( diagram );
    
    return KernelLift( direct_sum_diagonal_difference, fiber_product_embedding_in_direct_sum );
    
end : Description := "IsomorphismFromFiberProductToKernelOfDiagonalDifference using the universal property of the kernel" );

##
AddDerivationToCAP( IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct,
          
  function( diagram )
    local kernel_emb, sources_of_diagram, test_source;
    
    kernel_emb := KernelEmbedding( DirectSumDiagonalDifference( diagram ) );
    
    sources_of_diagram := List( diagram, Source );
    
    test_source := List( [ 1 .. Length( diagram ) ],
                         i -> PreCompose( kernel_emb, ProjectionInFactorOfDirectSum( sources_of_diagram, i ) ) );
    
    return UniversalMorphismIntoFiberProduct( diagram, test_source );
    
end : Description := "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct using the universal property of the fiber product" );

##
AddDerivationToCAP( IsomorphismFromPushoutToCokernelOfDiagonalDifference,
          
  function( diagram )
    local cokernel_proj, ranges_of_diagram, test_sink;
    
    cokernel_proj := CokernelProjection( DirectSumCodiagonalDifference( diagram ) );
    
    ranges_of_diagram := List( diagram, Range );
    
    test_sink := List( [ 1 .. Length( diagram ) ],
                       i -> PreCompose( InjectionOfCofactorOfDirectSum( ranges_of_diagram, i ), cokernel_proj ) );
    
    return UniversalMorphismFromPushout( diagram, test_sink );
    
end : Description := "IsomorphismFromPushoutToCokernelOfDiagonalDifference using the universal property of the pushout" );

##
AddDerivationToCAP( IsomorphismFromCokernelOfDiagonalDifferenceToPushout,
          
  function( diagram )
    local direct_sum_codiagonal_difference, direct_sum_projection_in_pushout;
    
    direct_sum_codiagonal_difference := DirectSumCodiagonalDifference( diagram );
    
    direct_sum_projection_in_pushout := DirectSumProjectionInPushout( diagram );
    
    return CokernelColift( direct_sum_codiagonal_difference, direct_sum_projection_in_pushout );
    
end : Description := "IsomorphismFromCokernelOfDiagonalDifferenceToPushout using the universal property of the cokernel" );

##
AddDerivationToCAP( IsomorphismFromFiberProductToKernelOfDiagonalDifference,
                    [ [ IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct( diagram ) );
    
end : Description := "IsomorphismFromFiberProductToKernelOfDiagonalDifference as the inverse of IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct" );

##
AddDerivationToCAP( IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct,
                    [ [ IsomorphismFromFiberProductToKernelOfDiagonalDifference, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromFiberProductToKernelOfDiagonalDifference( diagram ) );
    
end : Description := "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct as the inverse of IsomorphismFromFiberProductToKernelOfDiagonalDifference" );

##
AddDerivationToCAP( IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram,
                    [ [ IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct( diagram ) );
    
end : Description := "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram as the inverse of IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct" );

##
AddDerivationToCAP( IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct,
                    [ [ IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram( diagram ) );
    
end : Description := "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct as the inverse of IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram" );

##
AddDerivationToCAP( IsomorphismFromPushoutToCokernelOfDiagonalDifference,
                    [ [ IsomorphismFromCokernelOfDiagonalDifferenceToPushout , 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromCokernelOfDiagonalDifferenceToPushout( diagram ) );
    
end : Description := "IsomorphismFromPushoutToCokernelOfDiagonalDifference as the inverse of IsomorphismFromCokernelOfDiagonalDifferenceToPushout" );

##
AddDerivationToCAP( IsomorphismFromCokernelOfDiagonalDifferenceToPushout,
                    [ [ IsomorphismFromPushoutToCokernelOfDiagonalDifference, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromPushoutToCokernelOfDiagonalDifference( diagram ) );
    
end : Description := "IsomorphismFromCokernelOfDiagonalDifferenceToPushout as the inverse of IsomorphismFromPushoutToCokernelOfDiagonalDifference" );

##
AddDerivationToCAP( IsomorphismFromPushoutToCoequalizerOfCoproductDiagram,
                    [ [ IsomorphismFromCoequalizerOfCoproductDiagramToPushout , 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromCoequalizerOfCoproductDiagramToPushout( diagram ) );
    
end : Description := "IsomorphismFromPushoutToCoequalizerOfCoproductDiagram as the inverse of IsomorphismFromCoequalizerOfCoproductDiagramToPushout" );

##
AddDerivationToCAP( IsomorphismFromCoequalizerOfCoproductDiagramToPushout,
                    [ [ IsomorphismFromPushoutToCoequalizerOfCoproductDiagram, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromPushoutToCoequalizerOfCoproductDiagram( diagram ) );
    
end : Description := "IsomorphismFromCoequalizerOfCoproductDiagramToPushout as the inverse of IsomorphismFromPushoutToCoequalizerOfCoproductDiagram" );

##
AddDerivationToCAP( ColiftAlongEpimorphism,
                    [ [ KernelEmbedding, 1 ],
                      [ CokernelColift, 2 ],
                      [ PreCompose, 1 ],
                      [ Inverse, 1 ] ],
                    
  function( epimorphism, test_morphism )
    local kernel_emb, cokernel_colift_to_range_of_epimorphism, cokernel_colift_to_range_of_test_morphism;
    
    kernel_emb := KernelEmbedding( epimorphism );
    
    cokernel_colift_to_range_of_epimorphism :=
      CokernelColift( kernel_emb, epimorphism );
      
    cokernel_colift_to_range_of_test_morphism :=
      CokernelColift( kernel_emb, test_morphism );
    
    return PreCompose( Inverse( cokernel_colift_to_range_of_epimorphism ), cokernel_colift_to_range_of_test_morphism );
    
end : CategoryFilter := IsAbelianCategory, 
      Description := "ColiftAlongEpimorphism by inverting the cokernel colift from the cokernel of the kernel to the range of a given epimorphism");

##
AddDerivationToCAP( LiftAlongMonomorphism,
                    [ [ CokernelProjection, 1 ],
                      [ KernelLift, 2 ],
                      [ PreCompose, 1 ],
                      [ Inverse, 1 ] ],
                    
  function( monomorphism, test_morphism )
    local cokernel_proj, kernel_lift_from_source_of_monomorphism, kernel_lift_from_source_of_test_morphism;
    
    cokernel_proj := CokernelProjection( monomorphism );
    
    kernel_lift_from_source_of_monomorphism :=
      KernelLift( cokernel_proj, monomorphism );
      
    kernel_lift_from_source_of_test_morphism :=
      KernelLift( cokernel_proj, test_morphism );
    
    return PreCompose( kernel_lift_from_source_of_test_morphism, Inverse( kernel_lift_from_source_of_monomorphism ) );
    
end : CategoryFilter := IsAbelianCategory, 
      Description := "LiftAlongMonomorphism by inverting the kernel lift from the source to the kernel of the cokernel of a given monomorphism");


##
AddDerivationToCAP( ComponentOfMorphismIntoDirectSum,
                    
  function( alpha, summands, nr )
    
    return PreCompose( alpha, ProjectionInFactorOfDirectSum( summands, nr ) );
    
end : Description := "ComponentOfMorphismIntoDirectSum by composing with the direct sum projection" );

##
AddDerivationToCAP( ComponentOfMorphismFromDirectSum,
                    
  function( alpha, summands, nr )
    
    return PreCompose( InjectionOfCofactorOfDirectSum( summands, nr ), alpha );
    
end : Description := "ComponentOfMorphismFromDirectSum by composing with the direct sum injection" );

##
AddDerivationToCAP( MorphismBetweenDirectSums,
                    
  function( S, morphism_matrix, T )
    local diagram_direct_sum_source, diagram_direct_sum_range, test_diagram_product, test_diagram_coproduct;
    
    if morphism_matrix = [ ] or morphism_matrix[1] = [ ] then
        return ZeroMorphism( S, T );
    fi;
    
    diagram_direct_sum_source := List( morphism_matrix, row -> Source( row[1] ) );
    
    diagram_direct_sum_range := List( morphism_matrix[1], entry -> Range( entry ) );
    
    test_diagram_coproduct := List( morphism_matrix,
        test_diagram_product -> UniversalMorphismIntoDirectSumWithGivenDirectSum( diagram_direct_sum_range, test_diagram_product, T )
    );
    
    return UniversalMorphismFromDirectSumWithGivenDirectSum( diagram_direct_sum_source, test_diagram_coproduct, S );
    
end : Description := "MorphismBetweenDirectSums using universal morphisms of direct sums" );

##
AddDerivationToCAP( HomologyObjectFunctorialWithGivenHomologyObjects,
                    
  function( homology_source, mor_list, homology_range )
    local alpha, beta, epsilon, gamma, delta, image_emb_source, image_emb_range, cok_functorial, functorial_mor;
    
    alpha := mor_list[1];
    
    beta := mor_list[2];
    
    epsilon := mor_list[3];
    
    gamma := mor_list[4];
    
    delta := mor_list[5];
    
    image_emb_source := ImageEmbedding(
      PreCompose( KernelEmbedding( beta ), CokernelProjection( alpha ) )
    );
    
    image_emb_range := ImageEmbedding(
      PreCompose( KernelEmbedding( delta ), CokernelProjection( gamma ) )
    );
    
    cok_functorial := CokernelFunctorial( alpha, epsilon, gamma );
    
    functorial_mor :=
      LiftAlongMonomorphism(
        image_emb_range, PreCompose( image_emb_source, cok_functorial )
      );
    
    return PreCompose( [
        IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( alpha, beta ),
        functorial_mor,
        IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject( gamma, delta )
      ]
    );
    
end : CategoryFilter := HasIsAbelianCategory and IsAbelianCategory,
      Description := "HomologyObjectFunctorialWithGivenHomologyObjects using functoriality of (co)kernels and images in abelian categories" );


###########################
##
## Methods returning a morphism with source or range constructed within the method!
## If there is a method available which only constructs this source or range,
## one has to be sure that this source is equal to that construction (by IsEqualForObjects)
##
###########################

##
AddDerivationToCAP( KernelObjectFunctorialWithGivenKernelObjects,
                    [ [ KernelLift, 1 ],
                      [ PreCompose, 1 ],
                      [ KernelEmbedding, 1 ] ],
                                  
  function( kernel_alpha, alpha, mu, alpha_p, kernel_alpha_p )
    
    return KernelLift(
                alpha_p,
                PreCompose( KernelEmbedding( alpha ), mu )
              );
    
end : Description := "KernelObjectFunctorialWithGivenKernelObjects using the universality of the kernel" );

##
AddDerivationToCAP( CokernelObjectFunctorialWithGivenCokernelObjects,
                    [ [ CokernelColift, 1 ],
                      [ PreCompose, 1 ],
                      [ CokernelProjection, 1 ] ],
                                  
  function( cokernel_alpha, alpha, nu, alpha_p, cokernel_alpha_p )
    
    return CokernelColift(
                alpha,
                PreCompose( nu, CokernelProjection( alpha_p ) )
              );
    
end : Description := "CokernelObjectFunctorialWithGivenCokernelObjects using the universality of the cokernel" );



##
AddDerivationToCAP( CoproductFunctorialWithGivenCoproducts,
                    [ [ PreCompose, 2 ], ## Length( morphism_list ) would be the correct number
                      [ InjectionOfCofactorOfCoproduct, 2 ], ## Length( morphism_list ) would be the correct number
                      [ UniversalMorphismFromCoproduct, 1 ] ], 
                                  
  function( coproduct_source, morphism_list, coproduct_range )
    local coproduct_diagram, sink, diagram;
        
        coproduct_diagram := List( morphism_list, mor -> Range( mor ) );
        
        sink := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( morphism_list[i], InjectionOfCofactorOfCoproduct( coproduct_diagram, i ) ) );
        
        diagram := List( morphism_list, mor -> Source( mor ) );
        
        return UniversalMorphismFromCoproduct( diagram, sink );
        
end : Description := "CoproductFunctorialWithGivenCoproducts using the universality of the coproduct" );



##
AddDerivationToCAP( DirectProductFunctorialWithGivenDirectProducts,
                    [ [ PreCompose, 2 ], ## Length( morphism_list ) would be the correct number
                      [ ProjectionInFactorOfDirectProduct, 2 ], ## Length( morphism_list ) would be the correct number
                      [ UniversalMorphismIntoDirectProduct, 1 ] ],
                                  
  function( direct_product_source, morphism_list, direct_product_range )
    local direct_product_diagram, source, diagram;
        
        direct_product_diagram := List( morphism_list, mor -> Source( mor ) );
        
        source := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( ProjectionInFactorOfDirectProduct( direct_product_diagram, i ), morphism_list[i] ) );
        
        diagram := List( morphism_list, mor -> Range( mor ) );
        
        return UniversalMorphismIntoDirectProduct( diagram, source );
        
end : Description := "DirectProductFunctorialWithGivenDirectProducts using universality of direct product" );

##
AddDerivationToCAP( DirectSumFunctorialWithGivenDirectSums,
                    [ [ PreCompose, 2 ], ## Length( morphism_list ) would be the correct number
                      [ ProjectionInFactorOfDirectSum, 2 ], ## Length( morphism_list ) would be the correct number
                      [ UniversalMorphismIntoDirectSum, 1 ] ],
                 
  function( direct_sum_source, morphism_list, direct_sum_range )
    local direct_sum_diagram, source, diagram;
        
        direct_sum_diagram := List( morphism_list, mor -> Source( mor ) );
        
        source := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( ProjectionInFactorOfDirectSum( direct_sum_diagram, i ), morphism_list[i] ) );
        
        diagram := List( morphism_list, mor -> Range( mor ) );
        
        return UniversalMorphismIntoDirectSum( diagram, source );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "DirectSumFunctorialWithGivenDirectSums using the universal morphism into direct sum");

##
AddDerivationToCAP( DirectSumFunctorialWithGivenDirectSums,
                    [ [ PreCompose, 2 ], ## Length( morphism_list ) would be the correct number
                      [ InjectionOfCofactorOfDirectSum, 2 ], ## Length( morphism_list ) would be the correct number
                      [ UniversalMorphismFromDirectSum, 1 ] ], 
                                  
  function( direct_sum_source, morphism_list, direct_sum_range )
    local direct_sum_diagram, sink, diagram;
        
        direct_sum_diagram := List( morphism_list, mor -> Range( mor ) );
        
        sink := List( [ 1 .. Length( morphism_list ) ], i -> PreCompose( morphism_list[i], InjectionOfCofactorOfDirectSum( direct_sum_diagram, i ) ) );
        
        diagram := List( morphism_list, mor -> Source( mor ) );
        
        return UniversalMorphismFromDirectSum( diagram, sink );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "DirectSumFunctorialWithGivenDirectSums using the universal morphism from direct sum" );


##
AddDerivationToCAP( TerminalObjectFunctorial,
                    [ [ TerminalObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                                  
  function( category )
    local terminal_object;
    
    terminal_object := TerminalObject( category );
    
    return IdentityMorphism( terminal_object );
    
end : Description := "TerminalObjectFunctorial using the identity morphism of terminal object" );

##
AddDerivationToCAP( TerminalObjectFunctorial,
                    [ [ TerminalObject, 1 ],
                      [ UniversalMorphismIntoTerminalObject, 1 ] ],
                                  
  function( category )
    local terminal_object;
    
    terminal_object := TerminalObject( category );
    
    return UniversalMorphismIntoTerminalObject( terminal_object );
    
end : Description := "TerminalObjectFunctorial using the universality of terminal object" );


##
AddDerivationToCAP( InitialObjectFunctorial,
                    [ [ InitialObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                                  
  function( category )
    local initial_object;
    
    initial_object := InitialObject( category );
    
    return IdentityMorphism( initial_object );
    
end : Description := "InitialObjectFunctorial using the identity morphism of initial object" );

##
AddDerivationToCAP( InitialObjectFunctorial,
                    [ [ InitialObject, 1 ],
                      [ UniversalMorphismFromInitialObject, 1 ] ],
                                  
  function( category )
    local initial_object;
    
    initial_object := InitialObject( category );
    
    return UniversalMorphismFromInitialObject( initial_object );
    
end : Description := "InitialObjectFunctorial using the universality of the initial object" );

##
AddDerivationToCAP( ZeroObjectFunctorial,
                                  
  function( category )
    local zero_object;
    
    zero_object := ZeroObject( category );
    
    return IdentityMorphism( zero_object );
    
end : Description := "ZeroObjectFunctorial using the identity morphism of zero object" );

##
AddDerivationToCAP( ZeroObjectFunctorial,
                                  
  function( category )
    local zero_object;
    
    zero_object := ZeroObject( category );
    
    return UniversalMorphismIntoZeroObject( zero_object );
    
end : Description := "ZeroObjectFunctorial using the universality of zero object" );

##
AddDerivationToCAP( ZeroObjectFunctorial,
                                  
  function( category )
    local zero_object;
    
    zero_object := ZeroObject( category );
    
    return ZeroMorphism( zero_object, zero_object );
    
end : Description := "ZeroObjectFunctorial using ZeroMorphism" );

##
AddDerivationToCAP( ZeroObjectFunctorial,
                                  
  function( category )
    local zero_object;
    
    zero_object := ZeroObject( category );
    
    return UniversalMorphismFromZeroObject( zero_object );
    
end : Description := "ZeroObjectFunctorial using the universality of zero object" );

##
AddDerivationToCAP( DirectSumDiagonalDifference,
                    [ [ PreCompose, 2 ], ## Length( diagram ) would be the correct number here
                      [ ProjectionInFactorOfDirectSum, 2 ], ## Length( diagram ) would be the correct number here
                      [ UniversalMorphismIntoDirectSum, 2 ], ## 2*(Length( diagram ) - 1) would be the correct number here
                      [ AdditiveInverseForMorphisms,1 ],
                      [ AdditionForMorphisms, 1 ] ],
                    
  function( diagram )
    local direct_sum_diagram, number_of_morphisms, list_of_morphisms, mor1, mor2;
    
    direct_sum_diagram := List( diagram, Source );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( ProjectionInFactorOfDirectSum( direct_sum_diagram, i ), diagram[ i ] ) );
    
    if number_of_morphisms = 1 then
        
        return UniversalMorphismIntoZeroObject( Source( list_of_morphisms[1] ) );
        
    fi;
    
    mor1 := CallFuncList( UniversalMorphismIntoDirectSum, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismIntoDirectSum, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    return SubtractionForMorphisms( mor1, mor2 );
    
end : Description := "DirectSumDiagonalDifference using the operations defining this morphism" );

##
AddDerivationToCAP( EqualizerFunctorialWithGivenEqualizers,
                    [ [ PreCompose, 2 ], ## Length( morphism_of_morphisms ) would be the right number
                      [ EmbeddingOfEqualizer, 1 ],
                      [ UniversalMorphismIntoEqualizer, 1 ] ],
        
  function( equalizer_source, source_diagram, morphism_diagram, range_diagram, equalizer_range )
    local embedding, source;
        
        embedding := EmbeddingOfEqualizer( source_diagram );
        
        source := PreCompose( embedding, morphism_diagram );
        
        return UniversalMorphismIntoEqualizer( range_diagram, source );
        
end : Description := "EqualizerFunctorialWithGivenEqualizers using the universality of the equalizer" );

##
AddDerivationToCAP( FiberProductFunctorialWithGivenFiberProducts,
                    [ [ PreCompose, 2 ], ## Length( morphism_of_morphisms ) would be the right number
                      [ ProjectionInFactorOfFiberProduct, 2 ], ## Length( morphism_of_morphisms ) would be the right number,
                      [ UniversalMorphismIntoFiberProduct, 1 ] ],
                                  
  function( fiber_product_source, source_diagram, morphism_diagram, range_diagram, fiber_product_range )
    local source;
        
        source := List( [ 1 .. Length( morphism_diagram ) ], 
          i -> PreCompose( ProjectionInFactorOfFiberProduct( source_diagram, i ), morphism_diagram[i] ) );
        
        return UniversalMorphismIntoFiberProduct( range_diagram, source );
        
end : Description := "FiberProductFunctorialWithGivenFiberProducts using the universality of the fiber product" );

##
AddDerivationToCAP( DirectSumCodiagonalDifference,
                    [ [ InjectionOfCofactorOfDirectSum, 2 ], ## Length( diagram ) would be the correct number
                      [ PreCompose, 2 ], ## Length( diagram ) would be the correct number
                      [ UniversalMorphismFromDirectSum, 2 ], ## 2*( Length( diagram ) - 1 ) would be the correct number 
                      [ AdditiveInverseForMorphisms, 1 ],
                      [ AdditionForMorphisms, 1 ] ],
                    
  function( diagram )
    local cobase, direct_sum_diagram, number_of_morphisms, list_of_morphisms, mor1, mor2;
    
    direct_sum_diagram := List( diagram, Range );
    
    number_of_morphisms := Length( diagram );
    
    list_of_morphisms := List( [ 1 .. number_of_morphisms ], i -> PreCompose( diagram[ i ], InjectionOfCofactorOfDirectSum( direct_sum_diagram, i ) ) );
    
    if number_of_morphisms = 1 then
        
        return UniversalMorphismFromZeroObject( Range( list_of_morphisms[1] ) );
        
    fi;
    
    mor1 := CallFuncList( UniversalMorphismFromDirectSum, list_of_morphisms{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := CallFuncList( UniversalMorphismFromDirectSum, list_of_morphisms{[ 2 .. number_of_morphisms ]} );
    
    return SubtractionForMorphisms( mor1, mor2 );
    
end : Description := "DirectSumCodiagonalDifference using the operations defining this morphism" );


##
AddDerivationToCAP( CoequalizerFunctorialWithGivenCoequalizers,
                    [ [ PreCompose, 2 ], ## Length( morphism_of_morphisms ) would be the right number
                      [ ProjectionOntoCoequalizer, 1 ],
                      [ UniversalMorphismFromCoequalizer, 1 ] ],
        
  function( coequalizer_source, source_diagram, morphism_diagram, range_diagram, coequalizer_range )
    local projection, range;
        
        projection := ProjectionOntoCoequalizer( source_diagram );
        
        range := PreCompose(morphism_diagram, projection );
        
        return UniversalMorphismFromCoequalizer( range_diagram, range );
        
end : Description := "CoequalizerFunctorialWithGivenCoequalizers using the universality of the coequalizer" );

##
AddDerivationToCAP( PushoutFunctorialWithGivenPushouts,
                    [ [ PreCompose, 2 ], ## Length( morphism_of_morphisms ) would be the correct number here
                      [ InjectionOfCofactorOfPushout, 2 ], ## Length( morphism_of_morphisms ) would be the correct number here
                      [ UniversalMorphismFromPushout, 1 ] ],
                                  
  function( pushout_source, source_diagram, morphism_diagram, range_diagram, pushout_range )
    local sink;
        
        sink := List( [ 1 .. Length( morphism_diagram ) ], 
          i -> PreCompose( morphism_diagram[i], InjectionOfCofactorOfPushout( range_diagram, i ) ) );
        
        return UniversalMorphismFromPushout( source_diagram, sink );
        
end : Description := "PushoutFunctorialWithGivenPushouts using the universality of the pushout" );

##
AddDerivationToCAP( FiberProductEmbeddingInDirectSum,
                    [ [ KernelEmbedding, 1 ],
                      [ DirectSumDiagonalDifference, 1 ],
                      [ IsomorphismFromFiberProductToKernelOfDiagonalDifference, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( diagram )
    local kernel_of_diagonal_difference;
    
    kernel_of_diagonal_difference := KernelEmbedding( DirectSumDiagonalDifference( diagram ) );
    
    return PreCompose( IsomorphismFromFiberProductToKernelOfDiagonalDifference( diagram ),
                       kernel_of_diagonal_difference );
    
end : Description := "FiberProductEmbeddingInDirectSum as the kernel embedding of DirectSumDiagonalDifference" );

##
AddDerivationToCAP( FiberProductEmbeddingInDirectSum,
        
  function( diagram )
    local sources_of_diagram, test_source;
    
    sources_of_diagram := List( diagram, Source );
    
    test_source := List( [ 1 .. Length( diagram ) ], i -> ProjectionInFactorOfFiberProduct( diagram, i ) );
    
    return UniversalMorphismIntoDirectSum( sources_of_diagram, test_source );

end : Description := "FiberProductEmbeddingInDirectSum using the universal property of the direct sum" );

##
AddDerivationToCAP( DirectSumProjectionInPushout,
                    [ [ CokernelProjection, 1 ],
                      [ DirectSumCodiagonalDifference, 1 ],
                      [ IsomorphismFromCokernelOfDiagonalDifferenceToPushout, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( diagram )
    local cokernel_proj_of_diagonal_difference;
    
    cokernel_proj_of_diagonal_difference := CokernelProjection( DirectSumCodiagonalDifference( diagram ) );
    
    return PreCompose( cokernel_proj_of_diagonal_difference,
                       IsomorphismFromCokernelOfDiagonalDifferenceToPushout( diagram ) );
    
end : Description := "DirectSumProjectionInPushout as the cokernel projection of DirectSumCodiagonalDifference" );

##
AddDerivationToCAP( DirectSumProjectionInPushout,
        
  function( diagram )
    local ranges_of_diagram, test_sink;
    
    ranges_of_diagram := List( diagram, Range );
    
    test_sink := List( [ 1 .. Length( diagram ) ], i -> InjectionOfCofactorOfPushout( diagram, i ) );
    
    return UniversalMorphismFromDirectSum( ranges_of_diagram, test_sink );
    
end : Description := "DirectSumProjectionInPushout using the universal property of the direct sum" );


##
AddDerivationToCAP( IsomorphismFromInitialObjectToZeroObject,
                    [ [ UniversalMorphismFromInitialObject, 1 ],
                      [ ZeroObject, 1 ] ],
                      
  function( category )
    
    return UniversalMorphismFromInitialObject( ZeroObject( category ) );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "IsomorphismFromInitialObjectToZeroObject as the unique morphism from initial object to zero object" );

##
AddDerivationToCAP( IsomorphismFromInitialObjectToZeroObject,
        
  function( category )
    
    return UniversalMorphismIntoZeroObject( InitialObject( category ) );
    
end : Description := "IsomorphismFromInitialObjectToZeroObject using the universal property of the zero object" );

##
AddDerivationToCAP( IsomorphismFromInitialObjectToZeroObject,
                    [ [ Inverse, 1 ],
                      [ IsomorphismFromZeroObjectToInitialObject, 1 ] ],
  function( category )
    
    return Inverse( IsomorphismFromZeroObjectToInitialObject( category ) );
    
end : Description := "IsomorphismFromInitialObjectToZeroObject as the inverse of IsomorphismFromZeroObjectToInitialObject" );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToInitialObject,
                    [ [ Inverse, 1 ],
                      [ IsomorphismFromInitialObjectToZeroObject, 1 ] ],
  function( category )
    
    return Inverse( IsomorphismFromInitialObjectToZeroObject( category ) );
    
end : Description := "IsomorphismFromZeroObjectToInitialObject as the inverse of IsomorphismFromInitialObjectToZeroObject" );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToInitialObject,
         
  function( category )
    
    return UniversalMorphismFromZeroObject( InitialObject( category ) );
    
end : Description := "IsomorphismFromZeroObjectToInitialObject using the universal property of the zero object" );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToTerminalObject,
                    [ [ UniversalMorphismIntoTerminalObject, 1 ],
                      [ ZeroObject, 1 ] ],
  function( category )
    
    return UniversalMorphismIntoTerminalObject( ZeroObject( category ) );
    
end : CategoryFilter := IsAdditiveCategory,
      Description := "IsomorphismFromZeroObjectToTerminalObject as the unique morphism from zero object to terminal object" );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToTerminalObject,
        
  function( category )
    
    return UniversalMorphismFromZeroObject( TerminalObject( category ) );
    
end : Description := "IsomorphismFromZeroObjectToTerminalObject using the universal property of the zero object" );

##
AddDerivationToCAP( IsomorphismFromTerminalObjectToZeroObject,
                    [ [ Inverse, 1 ],
                      [ IsomorphismFromZeroObjectToTerminalObject, 1 ] ],
  function( category )
    
    return Inverse( IsomorphismFromZeroObjectToTerminalObject( category ) );
    
end : Description := "IsomorphismFromTerminalObjectToZeroObject as the inverse of IsomorphismFromZeroObjectToTerminalObject" );

##
AddDerivationToCAP( IsomorphismFromTerminalObjectToZeroObject,
        
  function( category )
    
    return UniversalMorphismIntoZeroObject( TerminalObject( category ) );
    
end : Description := "IsomorphismFromTerminalObjectToZeroObject using the universal property of the zero object" );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToTerminalObject,
                    [ [ Inverse, 1 ],
                      [ IsomorphismFromTerminalObjectToZeroObject, 1 ] ],
  function( category )
    
    return Inverse( IsomorphismFromTerminalObjectToZeroObject( category ) );
    
end : Description := "IsomorphismFromZeroObjectToTerminalObject as the inverse of IsomorphismFromTerminalObjectToZeroObject" );


##
AddDerivationToCAP( IsomorphismFromDirectProductToDirectSum,
                    [ [ ProjectionInFactorOfDirectProduct, 2 ], ## Length( diagram ) would be the correct number
                      [ UniversalMorphismIntoDirectSum, 1 ] ],
                    
  function( diagram )
    local source;
    
    source := List( [ 1 .. Length( diagram ) ], i -> ProjectionInFactorOfDirectProduct( diagram, i ) );
    
    return UniversalMorphismIntoDirectSum( diagram, source );
    
end : Description := "IsomorphismFromDirectProductToDirectSum using direct product projections and universal property of direct sum" );

##
AddDerivationToCAP( IsomorphismFromDirectProductToDirectSum,
                    [ [ IsomorphismFromDirectSumToDirectProduct, 1 ],
                      [ Inverse, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromDirectSumToDirectProduct( diagram ) );
    
end : Description := "IsomorphismFromDirectProductToDirectSum as the inverse of IsomorphismFromDirectSumToDirectProduct" );

##
AddDerivationToCAP( IsomorphismFromDirectSumToDirectProduct,
                    [ [ ProjectionInFactorOfDirectSum, 2 ], ## Length( diagram ) would be the correct number
                      [ UniversalMorphismIntoDirectProduct, 1 ] ],
                    
  function( diagram )
    local source;
    
    source := List( [ 1 .. Length( diagram ) ], i -> ProjectionInFactorOfDirectSum( diagram, i ) );
    
    return UniversalMorphismIntoDirectProduct( diagram, source );
    
end : Description := "IsomorphismFromDirectSumToDirectProduct using direct sum projections and universal property of direct product" );

##
AddDerivationToCAP( IsomorphismFromDirectSumToDirectProduct,
                    [ [ Inverse, 1 ],
                      [ IsomorphismFromDirectProductToDirectSum, 1 ] ],
                      
  function( diagram );
    
    return Inverse( IsomorphismFromDirectProductToDirectSum( diagram ) );
    
end : Description := "IsomorphismFromDirectSumToDirectProduct as the inverse of IsomorphismFromDirectProductToDirectSum" );

##
AddDerivationToCAP( IsomorphismFromCoproductToDirectSum,
                    [ [ InjectionOfCofactorOfDirectSum, 2 ], ## Length( diagram ) would be the correct number
                      [ UniversalMorphismFromCoproduct, 1 ] ],
                    
  function( diagram )
    local sink;
    
    sink := List( [ 1 .. Length( diagram ) ], i -> InjectionOfCofactorOfDirectSum( diagram, i ) );
    
    return UniversalMorphismFromCoproduct( diagram, sink );
    
end : Description := "IsomorphismFromCoproductToDirectSum using cofactor injections and the universal property of the coproduct" );

##
AddDerivationToCAP( IsomorphismFromCoproductToDirectSum,
                    [ [ Inverse, 1 ],
                      [ IsomorphismFromDirectSumToCoproduct, 1 ] ],
                      
  function( diagram )
    
    return Inverse( IsomorphismFromDirectSumToCoproduct( diagram ) );
  
end : Description := "IsomorphismFromCoproductToDirectSum as the inverse of IsomorphismFromDirectSumToCoproduct" );

##
AddDerivationToCAP( IsomorphismFromDirectSumToCoproduct,
                    [ [ InjectionOfCofactorOfCoproduct, 2 ], ## Length( diagram ) would be the correct number
                      [ UniversalMorphismFromDirectSum, 1 ] ],
                    
  function( diagram )
    local sink;
    
    sink := List( [ 1 .. Length( diagram ) ], i -> InjectionOfCofactorOfCoproduct( diagram, i ) );
    
    return UniversalMorphismFromDirectSum( diagram, sink );
    
end : Description := "IsomorphismFromDirectSumToCoproduct using cofactor injections and the universal property of the direct sum" );

##
AddDerivationToCAP( IsomorphismFromDirectSumToCoproduct,
                    [ [ Inverse, 1 ],
                      [ IsomorphismFromCoproductToDirectSum, 1 ] ],
                    
  function( diagram )
    
    return Inverse( IsomorphismFromCoproductToDirectSum( diagram ) );
    
end : Description := "IsomorphismFromDirectSumToCoproduct as the inverse of IsomorphismFromCoproductToDirectSum" );

##
AddDerivationToCAP( Lift,
                    [ [ IdentityMorphism, 1 ],
                      [ SolveLinearSystemInAbCategory, 1 ] ],
  function( alpha, beta )
    local left_coefficients, right_coefficients, right_side, right_divide;
    
    left_coefficients := [ [ IdentityMorphism( Source( alpha ) ) ] ];
    
    right_coefficients := [ [ beta ] ];
    
    right_side := [ alpha ];
    
    right_divide := SolveLinearSystemInAbCategory(
                      left_coefficients, right_coefficients, right_side );
    
    if right_divide = fail then
      
      return fail;
      
    fi;
    
    return right_divide[1];
    
end : Description := "Lift by SolveLinearSystemInAbCategory" );
              
##
AddDerivationToCAP( Colift,
                    [ [ IdentityMorphism, 1 ],
                      [ SolveLinearSystemInAbCategory, 1 ] ],
  function( alpha, beta )
    local left_coefficients, right_coefficients, right_side, left_divide;
    
    left_coefficients := [ [ alpha ] ];
    
    right_coefficients := [ [ IdentityMorphism( Range( beta ) ) ] ];
    
    right_side := [ beta ];
    
    left_divide := SolveLinearSystemInAbCategory(
                      left_coefficients, right_coefficients, right_side );
    
    if left_divide = fail then
      
      return fail;
      
    fi;
    
    return left_divide[1];
    
end : Description := "Colift by SolveLinearSystemInAbCategory" );

##
AddDerivationToCAP( IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject,
  function( alpha, beta )
    
    return Inverse( IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( alpha, beta ) );
    
end : Description := "IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject as the inverse of IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject" );


###########################
##
## Methods returning an object
##
###########################

##
AddDerivationToCAP( KernelObject,
                    [ [ KernelEmbedding, 1 ] ],
                    
  function( mor )
    
    return Source( KernelEmbedding( mor ) );
    
end : Description := "KernelObject as the source of KernelEmbedding" );

##
AddDerivationToCAP( CokernelObject,
                    [ [ CokernelProjection, 1 ] ],
                                  
  function( mor )
    
    return Range( CokernelProjection( mor ) );
    
end : Description := "CokernelObject as the range of CokernelProjection" );

##
AddDerivationToCAP( Coproduct,
                    [ [ InjectionOfCofactorOfCoproduct, 1 ] ],
                                        
  function( object_product_list )
    
    return Range( InjectionOfCofactorOfCoproduct( object_product_list, 1 ) );
    
end : Description := "Coproduct as the range of the first injection" );

##
AddDerivationToCAP( DirectProduct,
                    [ [ ProjectionInFactorOfDirectProduct, 1 ] ],
                                        
  function( object_product_list )
    
    return Source( ProjectionInFactorOfDirectProduct( object_product_list, 1 ) );
    
end : Description := "DirectProduct as Source of ProjectionInFactorOfDirectProduct" );

##
AddDerivationToCAP( DirectProduct,
                    [ [ IsomorphismFromDirectProductToDirectSum, 1 ] ],
  function( object_product_list )
    
    return Source( IsomorphismFromDirectProductToDirectSum( object_product_list ) );
    
end : Description := "DirectProduct as the source of IsomorphismFromDirectProductToDirectSum" );

##
AddDerivationToCAP( Coproduct,
                    [ [ IsomorphismFromDirectSumToCoproduct, 1 ] ],
  function( object_product_list )
    
    return Range( IsomorphismFromDirectSumToCoproduct( object_product_list ) );
    
end : Description := "Coproduct as the range of IsomorphismFromDirectSumToCoproduct" );

##
AddDerivationToCAP( TerminalObject,
                    [ [ IsomorphismFromTerminalObjectToZeroObject, 1 ] ],
               
  function( category )
    
    return Source( IsomorphismFromTerminalObjectToZeroObject( category ) );
    
end : Description := "TerminalObject as the source of IsomorphismFromTerminalObjectToZeroObject" );

##
AddDerivationToCAP( TerminalObject,
                    [ [ IsomorphismFromZeroObjectToTerminalObject, 1 ] ],
               
  function( category )
    
    return Range( IsomorphismFromZeroObjectToTerminalObject( category ) );
    
end : Description := "TerminalObject as the range of IsomorphismFromZeroObjectToTerminalObject" );

##
AddDerivationToCAP( InitialObject,
                    [ [ IsomorphismFromInitialObjectToZeroObject, 1 ] ],
               
  function( category )
    
    return Source( IsomorphismFromInitialObjectToZeroObject( category ) );
    
end : Description := "InitialObject as the source of IsomorphismFromInitialObjectToZeroObject" );

##
AddDerivationToCAP( InitialObject,
                    [ [ IsomorphismFromZeroObjectToInitialObject, 1 ] ],
               
  function( category )
    
    return Range( IsomorphismFromZeroObjectToInitialObject( category ) );
    
end : Description := "InitialObject as the range of IsomorphismFromZeroObjectToInitialObject" );


##
AddDerivationToCAP( FiberProduct,
                    [ [ FiberProductEmbeddingInDirectSum, 1 ] ],
                    
function( diagram )
    
    return Source( FiberProductEmbeddingInDirectSum( diagram ) );
    
end : Description := "FiberProduct as the source of FiberProductEmbeddingInDirectSum" );

##
AddDerivationToCAP( Pushout,
                    [ [ DirectSumProjectionInPushout, 1 ] ],
                    
  function( diagram )
    
    return Range( DirectSumProjectionInPushout( diagram ) );
    
end : Description := "Pushout as the range of DirectSumProjectionInPushout" );

##
AddDerivationToCAP( ImageObject,
                    [ [ ImageEmbedding, 1 ] ],
                    
  function( mor )
    
    return Source( ImageEmbedding( mor ) );
    
end : Description := "ImageObject as the source of ImageEmbedding" );

##
AddDerivationToCAP( ImageObject,
                    
  function( morphism )
    
    return Source( IsomorphismFromImageObjectToKernelOfCokernel( morphism ) );
    
end : Description := "ImageObject as the source of IsomorphismFromImageObjectToKernelOfCokernel" );

##
AddDerivationToCAP( ImageObject,
                  
  function( morphism )
    
    return Range( IsomorphismFromKernelOfCokernelToImageObject( morphism ) );
    
end : Description := "ImageObject as the range of IsomorphismFromKernelOfCokernelToImageObject" );

##
AddDerivationToCAP( Coimage,
        
  function( morphism )
    
    return Range( CoimageProjection( morphism ) );
    
end : Description := "Coimage as the range of CoimageProjection" );

##
AddDerivationToCAP( Coimage,
        
  function( morphism )
    
    return Range( IsomorphismFromCokernelOfKernelToCoimage( morphism ) );
    
end : Description := "Coimage as the range of IsomorphismFromCokernelOfKernelToCoimage" );

##
AddDerivationToCAP( Coimage,
        
  function( morphism )
    
    return Source( IsomorphismFromCoimageToCokernelOfKernel( morphism ) );
    
end : Description := "Coimage as the source of IsomorphismFromCoimageToCokernelOfKernel" );

##
AddDerivationToCAP( Coimage,
        
  function( morphism )
    
    return Range( CanonicalIdentificationFromImageObjectToCoimage( morphism ) );
    
end : Description := "Coimage as the range of CanonicalIdentificationFromImageObjectToCoimage" );

##
AddDerivationToCAP( Coimage,
        
  function( morphism )
    
    return Source( CanonicalIdentificationFromCoimageToImageObject( morphism ) );
    
end : Description := "Coimage as the source of CanonicalIdentificationFromCoimageToImageObject" );

##
AddDerivationToCAP( FiberProduct,
      
  function( diagram )
    
    return Source( IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram( diagram ) );
    
end : Description := "FiberProduct as the source of IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram" );

##
AddDerivationToCAP( Pushout,
      
  function( diagram )
    
    return Range( IsomorphismFromCoequalizerOfCoproductDiagramToPushout( diagram ) );
    
end : Description := "Pushout as the range of IsomorphismFromCoequalizerOfCoproductDiagramToPushout" );

##
AddDerivationToCAP( SomeProjectiveObject,
                    [ [ EpimorphismFromSomeProjectiveObject, 1 ] ],
                    
  function( obj )
    
    return Source( EpimorphismFromSomeProjectiveObject( obj ) );
    
end : Description := "SomeProjectiveObject as the source of EpimorphismFromSomeProjectiveObject" );

##
AddDerivationToCAP( SomeInjectiveObject,
                    [ [ MonomorphismIntoSomeInjectiveObject, 1 ] ],
                    
  function( obj )
    
    return Range( MonomorphismIntoSomeInjectiveObject( obj ) );
    
end : Description := "SomeInjectiveObject as the range of MonomorphismIntoSomeInjectiveObject" );

##
AddDerivationToCAP( Equalizer,
                    [ [ EmbeddingOfEqualizer, 1 ] ],
                    
function( diagram )
    
    return Source( EmbeddingOfEqualizer( diagram ) );
    
end : Description := "Equalizer as the source of EmbeddingOfEqualizer" );

##
AddDerivationToCAP( Coequalizer,
                    [ [ ProjectionOntoCoequalizer, 1 ] ],
                    
  function( diagram )
    
    return Range( ProjectionOntoCoequalizer( diagram ) );
    
end : Description := "Coequalizer as the range of ProjectionOntoCoequalizer" );

##
AddDerivationToCAP( HomologyObject,
                    
  function( alpha, beta )
    
    return Source( IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( alpha, beta ) );
    
end : Description := "HomologyObject as the source of IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject" );

###########################
##
## Methods returning a twocell
##
###########################

##
AddDerivationToCAP( HorizontalPostCompose,
                    [ [ HorizontalPreCompose, 1 ] ],
                    
  function( twocell_right, twocell_left )
    
    return HorizontalPreCompose( twocell_left, twocell_right );
    
end : Description := "HorizontalPostCompose using HorizontalPreCompose" );

##
AddDerivationToCAP( HorizontalPreCompose,
                    [ [ HorizontalPostCompose, 1 ] ],
                    
  function( twocell_left, twocell_right )
    
    return HorizontalPostCompose( twocell_right, twocell_left );
    
end : Description := "HorizontalPreCompose using HorizontalPostCompose" );

##
AddDerivationToCAP( VerticalPostCompose,
                    [ [ VerticalPreCompose, 1 ] ],
                    
  function( twocell_below, twocell_above )
    
    return VerticalPreCompose( twocell_above, twocell_below );
    
end : Description := "VerticalPostCompose using VerticalPreCompose" );

##
AddDerivationToCAP( VerticalPreCompose,
                    [ [ VerticalPostCompose, 1 ] ],
                    
  function( twocell_above, twocell_below )
    
    return VerticalPostCompose( twocell_below, twocell_above );
    
end : Description := "VerticalPreCompose using VerticalPostCompose" );

###########################
##
## Methods involving homomorphism structures
##
###########################

##
AddDerivationToCAP( SolveLinearSystemInAbCategory,
                    [ [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
                      [ HomomorphismStructureOnMorphismsWithGivenObjects, 1 ],
                      [ HomomorphismStructureOnObjects, 1 ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ] ],
  function( left_coefficients, right_coefficients, right_side )
    local m, n, nu, H, lift, summands, list;
    
    m := Size( left_coefficients );
    
    n := Size( left_coefficients[1] );
    
    ## create lift diagram
    
    nu :=
      UniversalMorphismIntoDirectSum(
        List( [ 1 .. m ],
        i -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( right_side[i] ) )
    );
    
    list := 
      List( [ 1 .. n ],
      j -> List( [ 1 .. m ], i -> HomomorphismStructureOnMorphisms( left_coefficients[i][j], right_coefficients[i][j] ) ) 
    );
    
    H := MorphismBetweenDirectSums( list );
    
    ## the actual computation of the solution
    lift := Lift( nu, H );
    
    if lift = fail then
        
        return fail;
        
    fi;
    
    ## reinterpretation of the solution
    summands := List( [ 1 .. n ], j -> HomomorphismStructureOnObjects( Range( left_coefficients[1][j] ), Source( right_coefficients[1][j] ) ) );
    
    return
      List( [ 1 .. n ], j -> 
        InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
          Range( left_coefficients[1][j] ),
          Source( right_coefficients[1][j] ),
          PreCompose( lift, ProjectionInFactorOfDirectSum( summands, j ) )
        )
      );
  end :
  ConditionsListComplete := true,
  CategoryFilter := function( cat )
    local B, conditions;
    
    if HasIsAbCategory( cat ) and IsAbCategory( cat ) and HasRangeCategoryOfHomomorphismStructure( cat ) then
        
        B := RangeCategoryOfHomomorphismStructure( cat );
        
        conditions := [
          "UniversalMorphismIntoDirectSum",
          "MorphismBetweenDirectSums",
          "Lift",
          "PreCompose"
        ];
        
        if ForAll( conditions, c -> CanCompute( B, c ) ) then
            
            return true;
            
        fi;
        
    fi;
    
    return false;
    
  end,
  Description := "SolveLinearSystemInAbCategory using the homomorphism structure" 
);

##
AddDerivationToCAP( MereExistenceOfSolutionOfLinearSystemInAbCategory,
                    [ [ SolveLinearSystemInAbCategory, 1 ] ],
  function( left_coefficients, right_coefficients, right_side )
    
    return SolveLinearSystemInAbCategory( left_coefficients, right_coefficients, right_side ) <> fail;
    
end : Description := "MereExistenceOfSolutionOfLinearSystemInAbCategory using SolveLinearSystemInAbCategory" );

##
AddDerivationToCAP( MereExistenceOfSolutionOfLinearSystemInAbCategory,
                    [ [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
                      [ HomomorphismStructureOnMorphismsWithGivenObjects, 1 ]
                    ],
  function( left_coefficients, right_coefficients, right_side )
    local m, n, nu, H, lift, summands, list;
    
    m := Size( left_coefficients );
    
    n := Size( left_coefficients[1] );
    
    ## create lift diagram
    
    nu :=
      UniversalMorphismIntoDirectSum(
        List( [ 1 .. m ],
        i -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( right_side[i] ) )
    );
    
    list :=
      List( [ 1 .. n ],
      j -> List( [ 1 .. m ], i -> HomomorphismStructureOnMorphisms( left_coefficients[i][j], right_coefficients[i][j] ) )
    );
    
    H := MorphismBetweenDirectSums( list );
    
    ## the actual computation of the solution
    return IsLiftable( nu, H );
    
  end :
  ConditionsListComplete := true,
  CategoryFilter := function( cat )
    local B, conditions;
    
    if HasIsAbCategory( cat ) and IsAbCategory( cat ) and HasRangeCategoryOfHomomorphismStructure( cat ) then
        
        B := RangeCategoryOfHomomorphismStructure( cat );
        
        conditions := [
          "UniversalMorphismIntoDirectSum",
          "MorphismBetweenDirectSums",
          "IsLiftable"
        ];
        
        if ForAll( conditions, c -> CanCompute( B, c ) ) then
            
            return true;
            
        fi;
        
    fi;
    
    return false;
    
  end,
  Description := "MereExistenceOfSolutionOfLinearSystemInAbCategory using the homomorphism structure"
);

## Final methods for FiberProduct

##
AddFinalDerivation( IsomorphismFromFiberProductToKernelOfDiagonalDifference,
                    [ [ DirectSumDiagonalDifference, 1 ], 
                      [ KernelObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ FiberProduct,
                      ProjectionInFactorOfFiberProduct,
                      ProjectionInFactorOfFiberProductWithGivenFiberProduct,
                      UniversalMorphismIntoFiberProduct,
                      UniversalMorphismIntoFiberProductWithGivenFiberProduct,
                      FiberProductEmbeddingInDirectSum,
                      IsomorphismFromFiberProductToKernelOfDiagonalDifference,
                      IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct ],
                    
  function( diagram )
    local kernel_of_diagonal_difference;
    
    kernel_of_diagonal_difference := KernelObject( DirectSumDiagonalDifference( diagram ) );
    
    return IdentityMorphism( kernel_of_diagonal_difference );
    
end : Description := "IsomorphismFromFiberProductToKernelOfDiagonalDifference as the identity of the kernel of diagonal difference" );

##
AddFinalDerivation( IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct,
                    [ [ DirectSumDiagonalDifference, 1 ], 
                      [ KernelObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ FiberProduct,
                      ProjectionInFactorOfFiberProduct,
                      ProjectionInFactorOfFiberProductWithGivenFiberProduct,
                      UniversalMorphismIntoFiberProduct,
                      UniversalMorphismIntoFiberProductWithGivenFiberProduct,
                      FiberProductEmbeddingInDirectSum,
                      IsomorphismFromFiberProductToKernelOfDiagonalDifference,
                      IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct ],
                    
  function( diagram )
    local kernel_of_diagonal_difference;
    
    kernel_of_diagonal_difference := KernelObject( DirectSumDiagonalDifference( diagram ) );
    
    return IdentityMorphism( kernel_of_diagonal_difference );
    
end : Description := "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct as the identity of the kernel of diagonal difference" );

##
AddFinalDerivation( IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram,
                    [ [ ProjectionInFactorOfDirectProduct, 2 ], ## Length( diagram ) would be the correct number
                      [ PreCompose, 2 ], ## Length( diagram ) would be the correct number
                      [ Equalizer, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ FiberProduct,
                      ProjectionInFactorOfFiberProduct,
                      ProjectionInFactorOfFiberProductWithGivenFiberProduct,
                      UniversalMorphismIntoFiberProduct,
                      UniversalMorphismIntoFiberProductWithGivenFiberProduct,
                      IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram,
                      IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct ],
                    
  function( diagram )
    local D, diagram_of_equalizer, equalizer_of_direct_product_diagram;
    
    D := List( diagram, Source );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> ProjectionInFactorOfDirectProduct( D, i ) );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( diagram_of_equalizer[i], diagram[i] ) );
    
    equalizer_of_direct_product_diagram := Equalizer( diagram_of_equalizer );
    
    return IdentityMorphism( equalizer_of_direct_product_diagram );

end : Description := "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram as the identity of the equalizer of direct product diagram" );

##
AddFinalDerivation( IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct,
                    [ [ ProjectionInFactorOfDirectProduct, 2 ], ## Length( diagram ) would be the correct number
                      [ PreCompose, 2 ], ## Length( diagram ) would be the correct number
                      [ Equalizer, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ FiberProduct,
                      ProjectionInFactorOfFiberProduct,
                      ProjectionInFactorOfFiberProductWithGivenFiberProduct,
                      UniversalMorphismIntoFiberProduct,
                      UniversalMorphismIntoFiberProductWithGivenFiberProduct,
                      IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram,
                      IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct ],
                    
  function( diagram )
    local D, diagram_of_equalizer, equalizer_of_direct_product_diagram;
    
    D := List( diagram, Source );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> ProjectionInFactorOfDirectProduct( D, i ) );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( diagram_of_equalizer[i], diagram[i] ) );
    
    equalizer_of_direct_product_diagram := Equalizer( diagram_of_equalizer );
    
    return IdentityMorphism( equalizer_of_direct_product_diagram );

end : Description := "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct as the identity of the equalizer of direct product diagram" );

## Final methods for Pushout

##
AddFinalDerivation( IsomorphismFromPushoutToCokernelOfDiagonalDifference,
                    [ [ CokernelObject, 1 ],
                      [ DirectSumCodiagonalDifference, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Pushout,
                      InjectionOfCofactorOfPushout,
                      InjectionOfCofactorOfPushoutWithGivenPushout,
                      UniversalMorphismFromPushout,
                      UniversalMorphismFromPushoutWithGivenPushout,
                      DirectSumProjectionInPushout,
                      IsomorphismFromPushoutToCokernelOfDiagonalDifference,
                      IsomorphismFromCokernelOfDiagonalDifferenceToPushout ],
                    
  function( diagram )
    local cokernel_of_diagonal_difference;
    
    cokernel_of_diagonal_difference := CokernelObject( DirectSumCodiagonalDifference( diagram ) );
    
    return IdentityMorphism( cokernel_of_diagonal_difference );
    
end : Description := "IsomorphismFromPushoutToCokernelOfDiagonalDifference as the identity of the cokernel of diagonal difference" );

##
AddFinalDerivation( IsomorphismFromCokernelOfDiagonalDifferenceToPushout,
                    [ [ CokernelObject, 1 ],
                      [ DirectSumCodiagonalDifference, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Pushout,
                      InjectionOfCofactorOfPushout,
                      InjectionOfCofactorOfPushoutWithGivenPushout,
                      UniversalMorphismFromPushout,
                      UniversalMorphismFromPushoutWithGivenPushout,
                      DirectSumProjectionInPushout,
                      IsomorphismFromPushoutToCokernelOfDiagonalDifference,
                      IsomorphismFromCokernelOfDiagonalDifferenceToPushout ],
                    
  function( diagram )
    local cokernel_of_diagonal_difference;
    
    cokernel_of_diagonal_difference := CokernelObject( DirectSumCodiagonalDifference( diagram ) );
    
    return IdentityMorphism( cokernel_of_diagonal_difference );
    
end : Description := "IsomorphismFromCokernelOfDiagonalDifferenceToPushout as the identity of the cokernel of diagonal difference" );

##
AddFinalDerivation( IsomorphismFromPushoutToCoequalizerOfCoproductDiagram,
                    [ [ InjectionOfCofactorOfCoproduct, 2 ], ## Length( diagram ) would be the correct number
                      [ PreCompose, 2 ], ## Length( diagram ) would be the correct number
                      [ Coequalizer, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Pushout,
                      InjectionOfCofactorOfPushout,
                      InjectionOfCofactorOfPushoutWithGivenPushout,
                      UniversalMorphismFromPushout,
                      UniversalMorphismFromPushoutWithGivenPushout,
                      IsomorphismFromPushoutToCoequalizerOfCoproductDiagram,
                      IsomorphismFromCoequalizerOfCoproductDiagramToPushout ],
                    
  function( diagram )
    local D, diagram_of_coequalizer, coequalizer_of_coproduct_diagram;
    
    D := List( diagram, Range );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> InjectionOfCofactorOfCoproduct( D, i ) );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( diagram[i], diagram_of_coequalizer[i] ) );
    
    coequalizer_of_coproduct_diagram := Coequalizer( diagram_of_coequalizer );
    
    return IdentityMorphism( coequalizer_of_coproduct_diagram );
    
end : Description := "IsomorphismFromPushoutToCoequalizerOfCoproductDiagram as the identity of the coequalizer of coproduct diagram" );

##
AddFinalDerivation( IsomorphismFromCoequalizerOfCoproductDiagramToPushout,
                    [ [ InjectionOfCofactorOfCoproduct, 2 ], ## Length( diagram ) would be the correct number
                      [ PreCompose, 2 ], ## Length( diagram ) would be the correct number
                      [ Coequalizer, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Pushout,
                      InjectionOfCofactorOfPushout,
                      InjectionOfCofactorOfPushoutWithGivenPushout,
                      UniversalMorphismFromPushout,
                      UniversalMorphismFromPushoutWithGivenPushout,
                      IsomorphismFromPushoutToCoequalizerOfCoproductDiagram,
                      IsomorphismFromCoequalizerOfCoproductDiagramToPushout ],
                    
  function( diagram )
    local D, diagram_of_coequalizer, coequalizer_of_coproduct_diagram;
    
    D := List( diagram, Range );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> InjectionOfCofactorOfCoproduct( D, i ) );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( diagram[i], diagram_of_coequalizer[i] ) );
    
    coequalizer_of_coproduct_diagram := Coequalizer( diagram_of_coequalizer );
    
    return IdentityMorphism( coequalizer_of_coproduct_diagram );
    
end : Description := "IsomorphismFromCoequalizerOfCoproductDiagramToPushout as the identity of the coequalizer of coproduct diagram" );

## Final methods for Image

##
AddFinalDerivation( IsomorphismFromImageObjectToKernelOfCokernel,
                    [ [ KernelObject, 1 ],
                      [ CokernelProjection, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ ImageObject,
                      ImageEmbedding,
                      ImageEmbeddingWithGivenImageObject,
                      CoastrictionToImage,
                      CoastrictionToImageWithGivenImageObject,
                      UniversalMorphismFromImage,
                      UniversalMorphismFromImageWithGivenImageObject,
                      IsomorphismFromImageObjectToKernelOfCokernel,
                      IsomorphismFromKernelOfCokernelToImageObject ],
                    
  function( mor )
    local kernel_of_cokernel;
    
    kernel_of_cokernel := KernelObject( CokernelProjection( mor ) );
    
    return IdentityMorphism( kernel_of_cokernel );
    
end : Description := "IsomorphismFromImageObjectToKernelOfCokernel as the identity of the kernel of the cokernel" );

##
AddFinalDerivation( IsomorphismFromKernelOfCokernelToImageObject,
                    [ [ KernelObject, 1 ],
                      [ CokernelProjection, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ ImageObject,
                      ImageEmbedding,
                      ImageEmbeddingWithGivenImageObject,
                      CoastrictionToImage,
                      CoastrictionToImageWithGivenImageObject,
                      UniversalMorphismFromImage,
                      UniversalMorphismFromImageWithGivenImageObject,
                      IsomorphismFromImageObjectToKernelOfCokernel,
                      IsomorphismFromKernelOfCokernelToImageObject ],
                    
  function( mor )
    local kernel_of_cokernel;
    
    kernel_of_cokernel := KernelObject( CokernelProjection( mor ) );
    
    return IdentityMorphism( kernel_of_cokernel );
    
end : Description := "IsomorphismFromKernelOfCokernelToImageObject as the identity of the kernel of the cokernel" );

##
AddDerivationToCAP( MorphismFromCoimageToImageWithGivenObjects,
                    
  ##CoimageObject, ImageObject as Assumptions
  function( coimage, morphism, image )
    local coimage_projection, cokernel_projection, kernel_lift;
    
    cokernel_projection := CokernelProjection( morphism );
    
    coimage_projection := CoimageProjection( morphism );
    
    kernel_lift := KernelLift( cokernel_projection , AstrictionToCoimage( morphism ) );
    
    return PreCompose( kernel_lift, IsomorphismFromKernelOfCokernelToImageObject( morphism ) );
    
end : CategoryFilter := IsPreAbelianCategory,
      Description := "MorphismFromCoimageToImageWithGivenObjects using that images are given by kernels of cokernels" );

##
AddDerivationToCAP( InverseMorphismFromCoimageToImageWithGivenObjects,
                    
  function( coimage, morphism, image )
    
    return Inverse( MorphismFromCoimageToImage( morphism ) );
    
end : CategoryFilter := IsAbelianCategory,
      Description := "InverseMorphismFromCoimageToImageWithGivenObjects as the inverse of MorphismFromCoimageToImage" );

##
AddDerivationToCAP( CanonicalIdentificationFromCoimageToImageObject,
                    
  function( morphism )
    
    return Inverse( CanonicalIdentificationFromImageObjectToCoimage( morphism ) );
    
end : Description := "CanonicalIdentificationFromCoimageToImageObject as the inverse of CanonicalIdentificationFromImageObjectToCoimage" );

## Final methods for Coimage

##
AddFinalDerivation( IsomorphismFromCoimageToCokernelOfKernel,
                    [ [ CokernelObject, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Coimage,
                      CoimageProjection,
                      CoimageProjectionWithGivenCoimage,
                      AstrictionToCoimage,
                      AstrictionToCoimageWithGivenCoimage,
                      UniversalMorphismIntoCoimage,
                      UniversalMorphismIntoCoimageWithGivenCoimage,
                      IsomorphismFromCoimageToCokernelOfKernel,
                      IsomorphismFromCokernelOfKernelToCoimage ],
                    
  function( mor )
    local cokernel_of_kernel;
    
    cokernel_of_kernel := CokernelObject( KernelEmbedding( mor ) );
    
    return IdentityMorphism( cokernel_of_kernel );
    
end : Description := "IsomorphismFromCoimageToCokernelOfKernel as the identity of the cokernel of the kernel" );

##
AddFinalDerivation( IsomorphismFromCokernelOfKernelToCoimage,
                    [ [ CokernelObject, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Coimage,
                      CoimageProjection,
                      CoimageProjectionWithGivenCoimage,
                      AstrictionToCoimage,
                      AstrictionToCoimageWithGivenCoimage,
                      UniversalMorphismIntoCoimage,
                      UniversalMorphismIntoCoimageWithGivenCoimage,
                      IsomorphismFromCoimageToCokernelOfKernel,
                      IsomorphismFromCokernelOfKernelToCoimage ],
                    
  function( mor )
    local cokernel_of_kernel;
    
    cokernel_of_kernel := CokernelObject( KernelEmbedding( mor ) );
    
    return IdentityMorphism( cokernel_of_kernel );
    
end : Description := "IsomorphismFromCokernelOfKernelToCoimage as the identity of the cokernel of the kernel" );


## Final methods for initial object

##
AddFinalDerivation( IsomorphismFromInitialObjectToZeroObject,
                    [ [ ZeroObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ InitialObject,
                      UniversalMorphismFromInitialObject
                      ## NOTE: the combination of AddZeroObject and AddUniversalMorphismFromInitialObjectWithGivenInitialObject
                      ## is okay because only having UniversalMorphismFromInitialObjectWithGivenInitialObject, you cannot
                      ## deduce an InitialObject
#                       UniversalMorphismFromInitialObjectWithGivenInitialObject
                    ],
                    
  function( category )
    
    return IdentityMorphism( ZeroObject( category ) );
    
end : Description := "IsomorphismFromInitialObjectToZeroObject as the identity of the zero object" );

##
AddFinalDerivation( IsomorphismFromZeroObjectToInitialObject,
                    [ [ ZeroObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ InitialObject,
                      UniversalMorphismFromInitialObject
                      ## NOTE: the combination of AddZeroObject and AddUniversalMorphismFromInitialObjectWithGivenInitialObject
                      ## is okay because only having UniversalMorphismFromInitialObjectWithGivenInitialObject, you cannot
                      ## deduce an InitialObject
#                       UniversalMorphismFromInitialObjectWithGivenInitialObject
                    ],
                    
  function( category )
    
    return IdentityMorphism( ZeroObject( category ) );
    
end : Description := "IsomorphismFromZeroObjectToInitialObject as the identity of the zero object" );

## Final methods for terminal object

##
AddFinalDerivation( IsomorphismFromTerminalObjectToZeroObject,
                    [ [ ZeroObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ TerminalObject,
                      UniversalMorphismIntoTerminalObject
                      ## NOTE: the combination of AddZeroObject and AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject
                      ## is okay because only having UniversalMorphismIntoTerminalObjectWithGivenTerminalObject, you cannot
                      ## deduce a TerminalObject
#                       UniversalMorphismIntoTerminalObjectWithGivenTerminalObject
                    ],
                    
  function( category )
    
    return IdentityMorphism( ZeroObject( category ) );
    
end : Description := "IsomorphismFromTerminalObjectToZeroObject as the identity of the zero object" );

##
AddFinalDerivation( IsomorphismFromZeroObjectToTerminalObject,
                    [ [ ZeroObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ TerminalObject,
                      UniversalMorphismIntoTerminalObject
                      ## NOTE: the combination of AddZeroObject and AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject
                      ## is okay because only having UniversalMorphismIntoTerminalObjectWithGivenTerminalObject, you cannot
                      ## deduce a TerminalObject
#                       UniversalMorphismIntoTerminalObjectWithGivenTerminalObject
                    ],
                    
  function( category )
    
    return IdentityMorphism( ZeroObject( category ) );
    
end : Description := "IsomorphismFromZeroObjectToTerminalObject as the identity of the zero object" );

## Final methods for product

##
AddFinalDerivation( IsomorphismFromDirectSumToDirectProduct,
                    [ [ DirectSum, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ DirectProduct,
                      DirectProductFunctorialWithGivenDirectProducts,
                      ProjectionInFactorOfDirectProduct,
#                       ProjectionInFactorOfDirectProductWithGivenDirectProduct,
                      UniversalMorphismIntoDirectProduct ],
#                       UniversalMorphismIntoDirectProductWithGivenDirectProduct ],
                      
  function( diagram )
    
    return IdentityMorphism( DirectSum( diagram ) );
    
end : Description := "IsomorphismFromDirectSumToDirectProduct as the identity of the direct sum" );

##
AddFinalDerivation( IsomorphismFromDirectProductToDirectSum,
                    [ [ DirectSum, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ DirectProduct,
                      DirectProductFunctorialWithGivenDirectProducts,
                      ProjectionInFactorOfDirectProduct,
#                       ProjectionInFactorOfDirectProductWithGivenDirectProduct,
                      UniversalMorphismIntoDirectProduct ],
#                       UniversalMorphismIntoDirectProductWithGivenDirectProduct ],
                      
  function( diagram )
    
    return IdentityMorphism( DirectSum( diagram ) );
    
end : Description := "IsomorphismFromDirectProductToDirectSum as the identity of the direct sum" );

## Final methods for coproduct

##
AddFinalDerivation( IsomorphismFromCoproductToDirectSum,
                    [ [ DirectSum, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Coproduct,
                      CoproductFunctorialWithGivenCoproducts,
                      InjectionOfCofactorOfCoproduct,
#                       InjectionOfCofactorOfCoproductWithGivenCoproduct,
                      UniversalMorphismFromCoproduct ],
#                       UniversalMorphismFromCoproductWithGivenCoproduct ],
                      
  function( diagram )
    
    return IdentityMorphism( DirectSum( diagram ) );
    
end : Description := "IsomorphismFromCoproductToDirectSum as the identity of the direct sum" );

##
AddFinalDerivation( IsomorphismFromDirectSumToCoproduct,
                    [ [ DirectSum, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Coproduct,
                      CoproductFunctorialWithGivenCoproducts,
                      InjectionOfCofactorOfCoproduct,
#                       InjectionOfCofactorOfCoproductWithGivenCoproduct,
                      UniversalMorphismFromCoproduct ],
#                       UniversalMorphismFromCoproductWithGivenCoproduct ],
                      
  function( diagram )
    
    return IdentityMorphism( DirectSum( diagram ) );
    
end : Description := "IsomorphismFromDirectSumToCoproduct as the identity of the direct sum" );

## Final methods for homology object

##
AddFinalDerivation( IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject,
                    [ [ ImageObject, 1 ],
                      [ PreCompose, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ CokernelProjection, 1 ] ],
                    [ HomologyObject,
                      HomologyObjectFunctorialWithGivenHomologyObjects ],
                      
  function( alpha, beta )
    local homology_object;
    
    homology_object := ImageObject( PreCompose( KernelEmbedding( beta ), CokernelProjection( alpha ) ) );
    
    return IdentityMorphism( homology_object );
    
end : CategoryFilter := HasIsAbelianCategory and IsAbelianCategory,
      Description := "IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject as the identity of the homology object constructed as an image object" );


## Final method for IsEqualForObjects
##
AddFinalDerivation( IsEqualForObjects,
                    [ ],
                    [ IsEqualForObjects ],
                    
  ReturnFail );

## Final methods for IsEqual/IsEqualForMorphisms
##
AddFinalDerivation( IsCongruentForMorphisms,
                    [ ],
                    [ IsCongruentForMorphisms,
                      IsEqualForMorphisms ],
                      
  ReturnFail : Description := "Only IsIdenticalObj for comparing" );

##
AddFinalDerivation( IsEqualForMorphisms,
                    [ ],
                    [ IsCongruentForMorphisms,
                      IsEqualForMorphisms ],
                      
  ReturnFail : Description := "Only IsIdenticalObj for comparing" );

##
AddFinalDerivation( IsCongruentForMorphisms,
                    [ [ IsEqualForMorphisms, 1 ] ],
                    [ IsCongruentForMorphisms ],
                    
  IsEqualForMorphisms : Description := "Use IsEqualForMorphisms for IsCongruentForMorphisms" );

##
AddFinalDerivation( IsEqualForMorphisms,
                    [ [ IsCongruentForMorphisms, 1 ] ],
                    [ IsEqualForMorphisms ],
                    
  IsCongruentForMorphisms : Description := "Use IsCongruentForMorphisms for IsEqualForMorphisms" );

## Final methods for BasisOfExternalHom & CoefficientsOfMorphism

##
AddFinalDerivation( BasisOfExternalHom,
                    [
                      [ HomomorphismStructureOnObjects ],
                      [ HomomorphismStructureOnMorphismsWithGivenObjects ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure ],
                      [ DistinguishedObjectOfHomomorphismStructure ],
                      [ MultiplyWithElementOfCommutativeRingForMorphisms ]
                    ],
                    [
                      BasisOfExternalHom,
                      CoefficientsOfMorphismWithGivenBasisOfExternalHom
                    ],
  function( a, b )
    local hom_a_b, D, B;
    
    hom_a_b := HomomorphismStructureOnObjects( a, b );
    
    D := DistinguishedObjectOfHomomorphismStructure( CapCategory( a ) );
    
    B := ValueGlobal( "BasisOfExternalHom" )( D, hom_a_b );
    
    return List( B, m -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( a, b, m ) );
  
  end,
[
  CoefficientsOfMorphismWithGivenBasisOfExternalHom,
  function( alpha, L )
    local beta;
        
    beta := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha );
    
    return CoefficientsOfMorphism( beta );
    
  end
] : ConditionsListComplete := true,
  CategoryFilter :=
    function( category )
      local range_cat, required_methods;
      
      if not ( HasIsLinearCategoryOverCommutativeRing( category ) and IsLinearCategoryOverCommutativeRing( category ) ) then
        
        return false;
        
      fi;
      
      if not HasRangeCategoryOfHomomorphismStructure( category ) then
        
        return false;
        
      fi;
      
      range_cat := RangeCategoryOfHomomorphismStructure( category );
      
      if IsIdenticalObj( category, range_cat ) then
        
        return false;
        
      fi;
      
      if not ( HasIsLinearCategoryOverCommutativeRing( range_cat ) and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        
        return false;
        
      fi;
      
      if not IsIdenticalObj( CommutativeRingOfLinearCategory( category ), CommutativeRingOfLinearCategory( range_cat ) ) then
        
        return false;
        
      fi;
      
      required_methods := [
                            "BasisOfExternalHom",
                            "CoefficientsOfMorphismWithGivenBasisOfExternalHom",
                            "MultiplyWithElementOfCommutativeRingForMorphisms"
                          ];
      
      if not ForAll( required_methods, m -> CanCompute( range_cat, m ) ) then
        
        return false;
        
      fi;
      
      return true;
      
  end,
  Description := "Adding BasisOfExternalHom using homomorphism structure"
);
