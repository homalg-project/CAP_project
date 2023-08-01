# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

###########################
##
## In a terminal category
##
###########################

AddDerivationToCAP( IsLiftable,
                    "Two morphisms with equal targets are mutually liftable in a terminal category",
                    [  ],
                    
  function( cat, morphism1, morphism2 )
        
    ## equality of targets is part of the specification of the input and checked by the pre-function
    return true;
    
end : CategoryFilter := IsTerminalCategory );

AddDerivationToCAP( IsColiftable,
                    "Two morphisms with equal sources are mutually coliftable in a terminal category",
                    [  ],
                    
  function( cat, morphism1, morphism2 )
    
    ## equality of sources is part of the specification of the input and checked by the pre-function
    return true;
    
end : CategoryFilter := IsTerminalCategory );

###########################
##
## WithGiven pairs
##
###########################

AddDerivationToCAP( MorphismFromKernelObjectToSink,
                    "MorphismFromKernelObjectToSink as zero morphism from kernel object to range",
                    [ [ KernelObject, 1 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat, alpha )
    local K;
    
    K := KernelObject( cat, alpha );
    
    return ZeroMorphism( cat, K, Range( alpha ) );
    
  end );

##
AddDerivationToCAP( KernelLift,
                    "KernelLift using LiftAlongMonomorphism and KernelEmbedding",
                    [ [ LiftAlongMonomorphism, 1 ],
                      [ KernelEmbedding, 1 ] ],
                    
  function( cat, mor, test_object, test_morphism )
    
    return LiftAlongMonomorphism( cat, KernelEmbedding( cat, mor ), test_morphism );
    
  end );

##
AddDerivationToCAP( KernelLiftWithGivenKernelObject,
                    "KernelLift using LiftAlongMonomorphism and KernelEmbedding",
                    [ [ LiftAlongMonomorphism, 1 ],
                      [ KernelEmbeddingWithGivenKernelObject, 1 ] ],
                    
  function( cat, mor, test_object, test_morphism, kernel )
    
    return LiftAlongMonomorphism( cat, KernelEmbeddingWithGivenKernelObject( cat, mor, kernel ), test_morphism );
    
end );

##
AddDerivationToCAP( MorphismFromSourceToCokernelObject,
                    "MorphismFromSourceToCokernelObject as zero morphism from source to cokernel object",
                    [ [ CokernelObject, 1 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat, alpha )
    local C;
    
    C := CokernelObject( cat, alpha );
    
    return ZeroMorphism( cat, Source( alpha ), C );
    
  end );

##
AddDerivationToCAP( CokernelColift,
                    "CokernelColift using ColiftAlongEpimorphism and CokernelProjection",
                    [ [ ColiftAlongEpimorphism, 1 ],
                      [ CokernelProjection, 1 ] ],
                    
  function( cat, mor, test_object, test_morphism )
    
    return ColiftAlongEpimorphism( cat, CokernelProjection( cat, mor ), test_morphism );
    
  end );

##
AddDerivationToCAP( CokernelColiftWithGivenCokernelObject,
                    "CokernelColift using ColiftAlongEpimorphism and CokernelProjection",
                    [ [ ColiftAlongEpimorphism, 1 ],
                      [ CokernelProjectionWithGivenCokernelObject, 1 ] ],
                    
  function( cat, mor, test_object, test_morphism, cokernel )
      
      return ColiftAlongEpimorphism( cat, CokernelProjectionWithGivenCokernelObject( cat, mor, cokernel ), test_morphism );
      
end );

##
AddDerivationToCAP( UniversalMorphismIntoDirectSum,
                    "UniversalMorphismIntoDirectSum using the injections of the direct sum",
                    [ [ PreCompose, 2 ],
                      [ InjectionOfCofactorOfDirectSum, 2 ],
                      [ SumOfMorphisms, 1 ],
                      [ DirectSum, 1 ] ],
                    
  function( cat, diagram, test_object, source )
    local nr_components;
    
    nr_components := Length( source );
    
    return SumOfMorphisms( cat,
        test_object,
        List( [ 1 .. nr_components ], i -> PreCompose( cat, source[ i ], InjectionOfCofactorOfDirectSum( cat, diagram, i ) ) ),
        DirectSum( cat, diagram )
    );
    
  end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismIntoDirectSumWithGivenDirectSum,
                    "UniversalMorphismIntoDirectSum using the injections of the direct sum",
                    [ [ PreCompose, 2 ],
                      [ InjectionOfCofactorOfDirectSumWithGivenDirectSum, 2 ],
                      [ SumOfMorphisms, 1 ] ],
                    
  function( cat, diagram, test_object, source, direct_sum )
    local nr_components;
    
    nr_components := Length( source );
  
    return SumOfMorphisms( cat,
        test_object,
        List( [ 1 .. nr_components ], i -> PreCompose( cat, source[ i ], InjectionOfCofactorOfDirectSumWithGivenDirectSum( cat, diagram, i, direct_sum ) ) ),
        direct_sum
    );
  
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismFromDirectSum,
                    "UniversalMorphismFromDirectSum using projections of the direct sum",
                    [ [ PreCompose, 2 ],
                      [ ProjectionInFactorOfDirectSum, 2 ],
                      [ SumOfMorphisms, 1 ],
                      [ DirectSum, 1 ] ],
                    
  function( cat, diagram, test_object, sink )
    local nr_components;
    
    nr_components := Length( sink );
    
    return SumOfMorphisms( cat,
        DirectSum( cat, diagram ),
        List( [ 1 .. nr_components ], i -> PreCompose( cat, ProjectionInFactorOfDirectSum( cat, diagram, i ), sink[ i ] ) ),
        test_object
    );
    
  end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismFromDirectSumWithGivenDirectSum,
                    "UniversalMorphismFromDirectSum using projections of the direct sum",
                    [ [ PreCompose, 2 ],
                      [ ProjectionInFactorOfDirectSumWithGivenDirectSum, 2 ],
                      [ SumOfMorphisms, 1 ] ],
                    
  function( cat, diagram, test_object, sink, direct_sum )
    local nr_components;
    
    nr_components := Length( sink );
    
    return SumOfMorphisms( cat,
        direct_sum,
        List( [ 1 .. nr_components ], i -> PreCompose( cat, ProjectionInFactorOfDirectSumWithGivenDirectSum( cat, diagram, i, direct_sum ), sink[ i ] ) ),
        test_object
    );
  
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( ProjectionInFactorOfDirectSum,
                    "ProjectionInFactorOfDirectSum using UniversalMorphismFromDirectSum",
                    [ [ IdentityMorphism, 2 ],
                      [ ZeroMorphism, 2 ],
                      [ UniversalMorphismFromDirectSum, 1 ] ],
                    
  function( cat, list, projection_number )
    local morphisms;
    
    morphisms := List( [ 1 .. Length( list ) ], function( i )
        
        if i = projection_number then
            
            return IdentityMorphism( cat, list[projection_number] );
            
        else
            
            return ZeroMorphism( cat, list[i], list[projection_number] );
            
        fi;
        
    end );
    
    return UniversalMorphismFromDirectSum( cat, list, list[projection_number], morphisms );
    
  end );

##
AddDerivationToCAP( ProjectionInFactorOfDirectSumWithGivenDirectSum,
                    "ProjectionInFactorOfDirectSum using UniversalMorphismFromDirectSum",
                    [ [ IdentityMorphism, 2 ],
                      [ ZeroMorphism, 2 ],
                      [ UniversalMorphismFromDirectSumWithGivenDirectSum, 1 ] ],
                    
  function( cat, list, projection_number, direct_sum_object )
    local morphisms;
    
    morphisms := List( [ 1 .. Length( list ) ], function( i )
        
        if i = projection_number then
            
            return IdentityMorphism( cat, list[projection_number] );
            
        else
            
            return ZeroMorphism( cat, list[i], list[projection_number] );
            
        fi;
        
    end );
    
    return UniversalMorphismFromDirectSumWithGivenDirectSum( cat, list, list[projection_number], morphisms, direct_sum_object );
    
end );

##
AddDerivationToCAP( InjectionOfCofactorOfDirectSum,
                    "InjectionOfCofactorOfDirectSum using UniversalMorphismIntoDirectSum",
                    [ [ IdentityMorphism, 2 ],
                      [ ZeroMorphism, 2 ],
                      [ UniversalMorphismIntoDirectSum, 1 ] ],
                    
  function( cat, list, injection_number )
    local morphisms;
    
    morphisms := List( [ 1 .. Length( list ) ], function( i )
        
        if i = injection_number then
            
            return IdentityMorphism( cat, list[injection_number] );
            
        else
            
            return ZeroMorphism( cat, list[injection_number], list[i] );
            
        fi;
        
    end );
    
    return UniversalMorphismIntoDirectSum( cat, list, list[injection_number], morphisms );
    
  end );

##
AddDerivationToCAP( InjectionOfCofactorOfDirectSumWithGivenDirectSum,
                    "InjectionOfCofactorOfDirectSum using UniversalMorphismIntoDirectSum",
                    [ [ IdentityMorphism, 2 ],
                      [ ZeroMorphism, 2 ],
                      [ UniversalMorphismIntoDirectSumWithGivenDirectSum, 1 ] ],
                    
  function( cat, list, injection_number, direct_sum_object )
    local morphisms;
    
    morphisms := List( [ 1 .. Length( list ) ], function( i )
        
        if i = injection_number then
            
            return IdentityMorphism( cat, list[injection_number] );
            
        else
            
            return ZeroMorphism( cat, list[injection_number], list[i] );
            
        fi;
        
    end );
    
    return UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, list, list[injection_number], morphisms, direct_sum_object );
    
end );

##
AddDerivationToCAP( UniversalMorphismIntoTerminalObject,
                    "UniversalMorphismIntoTerminalObject computing the zero morphism",
                    [ [ TerminalObject, 1 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat, test_source )
    local terminal_object;
    
    terminal_object := TerminalObject( cat );
    
    return ZeroMorphism( cat, test_source, terminal_object );
    
  end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismIntoTerminalObjectWithGivenTerminalObject,
                    "UniversalMorphismIntoTerminalObject computing the zero morphism",
                    [ [ ZeroMorphism, 1 ] ],
                    
  function( cat, test_source, terminal_object )
    
    return ZeroMorphism( cat, test_source, terminal_object );
    
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismFromInitialObject,
                    "UniversalMorphismFromInitialObject computing the zero morphism",
                    [ [ InitialObject, 1 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat, test_sink )
    local initial_object;
    
    initial_object := InitialObject( cat );
    
    return ZeroMorphism( cat, initial_object, test_sink );
    
  end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismFromInitialObjectWithGivenInitialObject,
                    "UniversalMorphismFromInitialObject computing the zero morphism",
                    [ [ ZeroMorphism, 1 ] ],
                    
  function( cat, test_sink, initial_object )
    
    return ZeroMorphism( cat, initial_object, test_sink );
    
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismFromZeroObject,
                    "UniversalMorphismFromZeroObject computing the zero morphism",
                    [ [ ZeroObject, 1 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat, test_sink )
    local zero_object;
    
    zero_object := ZeroObject( cat );
    
    return ZeroMorphism( cat, zero_object, test_sink );
    
  end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismFromZeroObjectWithGivenZeroObject,
                    "UniversalMorphismFromZeroObject computing the zero morphism",
                    [ [ ZeroMorphism, 1 ] ],
                    
  function( cat, test_sink, zero_object )
    
    return ZeroMorphism( cat, zero_object, test_sink );
    
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismIntoZeroObject,
                    "UniversalMorphismIntoZeroObject computing the zero morphism",
                    [ [ ZeroObject, 1 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat, test_source )
    local zero_object;
    
    zero_object := ZeroObject( cat );
    
    return ZeroMorphism( cat, test_source, zero_object );
    
  end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( UniversalMorphismIntoZeroObjectWithGivenZeroObject,
                    "UniversalMorphismIntoZeroObject computing the zero morphism",
                    [ [ ZeroMorphism, 1 ] ],
                    
  function( cat, test_source, zero_object )
    
    return ZeroMorphism( cat, test_source, zero_object );
    
end : CategoryFilter := IsAdditiveCategory );

## FiberProduct from DirectProduct and Equalizer

##
AddDerivationToCAP( FiberProduct,
                    "FiberProduct as the source of IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
                    [ [ IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram, 1 ] ],
                    
  function( cat, diagram )
    
    return Source( IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram( cat, diagram ) );
    
end );

##
AddDerivationToCAP( ProjectionInFactorOfFiberProduct,
                    "ProjectionInFactorOfFiberProduct by composing the embedding of equalizer with the direct product projection",
                    [ [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 2 ],
                      [ PreCompose, 3 ],
                      [ EmbeddingOfEqualizer, 1 ],
                      [ DirectProduct, 1 ],
                      [ ComponentOfMorphismIntoDirectProduct, 1 ],
                      [ IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram, 1 ] ],
                    
  function( cat, diagram, projection_number )
    local D, direct_product, diagram_of_equalizer, iota;
    
    D := List( diagram, Source );
    
    direct_product := DirectProduct( cat, D );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( cat, ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, D, i, direct_product ), diagram[i] ) );
    
    iota := EmbeddingOfEqualizer( cat, direct_product, diagram_of_equalizer );
    
    return PreCompose( cat, IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram( cat, diagram ), ComponentOfMorphismIntoDirectProduct( cat, iota, D, projection_number ) );
    
  end );

##
AddDerivationToCAP( UniversalMorphismIntoFiberProduct,
                    "UniversalMorphismIntoFiberProduct as the universal morphism into equalizer of a univeral morphism into direct product",
                    [ [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 2 ],
                      [ PreCompose, 3 ],
                      [ UniversalMorphismIntoDirectProduct, 1 ],
                      [ UniversalMorphismIntoEqualizer, 1 ],
                      [ DirectProduct, 1 ],
                      [ IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct, 1 ] ],
                    
  function( cat, diagram, test_object, tau )
    local D, direct_product, diagram_of_equalizer, chi, psi;
    
    D := List( diagram, Source );
    
    direct_product := DirectProduct( cat, D );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( cat, ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, D, i, direct_product ), diagram[i] ) );
    
    chi := UniversalMorphismIntoDirectProduct( cat, D, test_object, tau );

    psi := UniversalMorphismIntoEqualizer( cat, direct_product, diagram_of_equalizer, test_object, chi );
    
    return PreCompose( cat, psi, IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct( cat, diagram ) );
    
  end );

##
AddDerivationToCAP( MorphismFromFiberProductToSink,
                    "MorphismFromFiberProductToSink by composing the first projection with the first morphism in the diagram",
                    [ [ ProjectionInFactorOfFiberProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram )
    local pi_1;
    
    pi_1 := ProjectionInFactorOfFiberProduct( cat, diagram, 1 );
    
    return PreCompose( cat, pi_1, diagram[1] );
    
  end );

## Pushout from Coproduct and Coequalizer

##
AddDerivationToCAP( Pushout,
                    "Pushout as the range of IsomorphismFromCoequalizerOfCoproductDiagramToPushout",
                    [ [ IsomorphismFromCoequalizerOfCoproductDiagramToPushout, 1 ] ],
                    
  function( cat, diagram )
    
    return Range( IsomorphismFromCoequalizerOfCoproductDiagramToPushout( cat, diagram ) );
    
end );

##
AddDerivationToCAP( InjectionOfCofactorOfPushout,
                    "InjectionOfCofactorOfPushout by composing the coproduct injection with the projection onto coequalizer",
                    [ [ InjectionOfCofactorOfCoproductWithGivenCoproduct, 2 ],
                      [ PreCompose, 3 ],
                      [ Coproduct, 1 ],
                      [ ProjectionOntoCoequalizer, 1 ],
                      [ ComponentOfMorphismFromCoproduct, 1 ],
                      [ IsomorphismFromCoequalizerOfCoproductDiagramToPushout, 1 ] ],
                    
  function( cat, diagram, injection_number )
    local D, coproduct, diagram_of_coequalizer, pi;
    
    D := List( diagram, Range );
    
    coproduct := Coproduct( cat, D );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( cat, diagram[i], InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, D, i, coproduct ) ) );
    
    pi := ProjectionOntoCoequalizer( cat, coproduct, diagram_of_coequalizer );
    
    return PreCompose( cat, ComponentOfMorphismFromCoproduct( cat, pi, D, injection_number ), IsomorphismFromCoequalizerOfCoproductDiagramToPushout( cat, diagram ) );
    
  end );

##
AddDerivationToCAP( UniversalMorphismFromPushout,
                    "UniversalMorphismFromPushout as the universal morphism from coequalizer of a univeral morphism from coproduct",
                    [ [ InjectionOfCofactorOfCoproductWithGivenCoproduct, 2 ],
                      [ PreCompose, 3 ],
                      [ UniversalMorphismFromCoproduct, 1 ],
                      [ UniversalMorphismFromCoequalizer, 1 ],
                      [ Coproduct, 1 ],
                      [ IsomorphismFromPushoutToCoequalizerOfCoproductDiagram, 1 ] ],
                    
  function( cat, diagram, test_object, tau )
    local D, coproduct, diagram_of_coequalizer, chi, psi;
    
    D := List( diagram, Range );
    
    coproduct := Coproduct( cat, D );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( cat, diagram[i], InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, D, i, coproduct ) ) );
    
    chi := UniversalMorphismFromCoproduct( cat, D, test_object, tau );
    
    psi := UniversalMorphismFromCoequalizer( cat, coproduct, diagram_of_coequalizer, test_object, chi );
    
    return PreCompose( cat, IsomorphismFromPushoutToCoequalizerOfCoproductDiagram( cat, diagram ), psi );
    
  end );

##
AddDerivationToCAP( MorphismFromSourceToPushout,
                    "MorphismFromSourceToPushout by composing the first morphism in the diagram with the first injection",
                    [ [ InjectionOfCofactorOfPushout, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram )
    local iota_1;
    
    iota_1 := InjectionOfCofactorOfPushout( cat, diagram, 1 );
    
    return PreCompose( cat, diagram[1], iota_1 );
    
  end );

##
AddDerivationToCAP( UniversalMorphismFromZeroObject,
                    "UniversalMorphismFromZeroObject using UniversalMorphismFromInitialObject",
                    [ [ IsomorphismFromZeroObjectToInitialObject, 1 ],
                      [ UniversalMorphismFromInitialObject, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, obj )
    
    return PreCompose( cat, IsomorphismFromZeroObjectToInitialObject( cat ),
                       UniversalMorphismFromInitialObject( cat, obj ) );
    
  end );

##
AddDerivationToCAP( UniversalMorphismIntoZeroObject,
                    "UniversalMorphismIntoZeroObject using UniversalMorphismIntoTerminalObject",
                    [ [ UniversalMorphismIntoTerminalObject, 1 ],
                      [ IsomorphismFromTerminalObjectToZeroObject, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, obj )
    
    return PreCompose( cat, UniversalMorphismIntoTerminalObject( cat, obj ),
                       IsomorphismFromTerminalObjectToZeroObject( cat ) );
  end );

##
AddDerivationToCAP( ProjectionInFactorOfDirectSum,
                    "ProjectionInFactorOfDirectSum using ProjectionInFactorOfDirectProduct",
                    [ [ IsomorphismFromDirectSumToDirectProduct, 1 ],
                      [ ProjectionInFactorOfDirectProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram, projection_number )
    
    return PreCompose( cat, IsomorphismFromDirectSumToDirectProduct( cat, diagram ),
                       ProjectionInFactorOfDirectProduct( cat, diagram, projection_number ) );
    
  end );

##
AddDerivationToCAP( UniversalMorphismIntoDirectSum,
                    "UniversalMorphismIntoDirectSum using UniversalMorphismIntoDirectProduct",
                    [ [ UniversalMorphismIntoDirectProduct, 1 ],
                      [ IsomorphismFromDirectProductToDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram, test_object, source )
    
    return PreCompose( cat, UniversalMorphismIntoDirectProduct( cat, diagram, test_object, source ),
                       IsomorphismFromDirectProductToDirectSum( cat, diagram ) );
  end );

##
AddDerivationToCAP( ComponentOfMorphismIntoDirectSum,
                    "ComponentOfMorphismIntoDirectSum using ComponentOfMorphismIntoDirectProduct",
                    [ [ IsomorphismFromDirectSumToDirectProduct, 1 ],
                      [ ComponentOfMorphismIntoDirectProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, summands, nr )
    
    return ComponentOfMorphismIntoDirectProduct( cat,
        PreCompose( cat, alpha, IsomorphismFromDirectSumToDirectProduct( cat, summands ) ),
        summands,
        nr
    );
    
  end );

##
AddDerivationToCAP( InjectionOfCofactorOfDirectSum,
                    "InjectionOfCofactorOfDirectSum using InjectionOfCofactorOfCoproduct",
                    [ [ InjectionOfCofactorOfCoproduct, 1 ],
                      [ IsomorphismFromCoproductToDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram, injection_number )
    
    return PreCompose( cat, InjectionOfCofactorOfCoproduct( cat, diagram, injection_number ),
                       IsomorphismFromCoproductToDirectSum( cat, diagram ) );
  end );

##
AddDerivationToCAP( UniversalMorphismFromDirectSum,
                    "UniversalMorphismFromDirectSum using UniversalMorphismFromCoproduct",
                    [ [ IsomorphismFromDirectSumToCoproduct, 1 ],
                      [ UniversalMorphismFromCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram, test_object, sink )
    
    return PreCompose( cat, IsomorphismFromDirectSumToCoproduct( cat, diagram ),
                       UniversalMorphismFromCoproduct( cat, diagram, test_object, sink ) );
  end );

##
AddDerivationToCAP( ComponentOfMorphismFromDirectSum,
                    "ComponentOfMorphismFromDirectSum using ComponentOfMorphismFromCoproduct",
                    [ [ IsomorphismFromCoproductToDirectSum, 1 ],
                      [ ComponentOfMorphismFromCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, summands, nr )
    
    return ComponentOfMorphismFromCoproduct( cat,
        PreCompose( cat, IsomorphismFromCoproductToDirectSum( cat, summands ), alpha ),
        summands,
        nr
    );
    
  end );

##
AddDerivationToCAP( UniversalMorphismIntoTerminalObject,
                    "UniversalMorphismFromInitialObject using UniversalMorphismFromZeroObject",
                    [ [ UniversalMorphismIntoZeroObject, 1 ],
                      [ IsomorphismFromZeroObjectToTerminalObject, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, obj )
    
    return PreCompose( cat, UniversalMorphismIntoZeroObject( cat, obj ),
                       IsomorphismFromZeroObjectToTerminalObject( cat ) );
    
  end );

##
AddDerivationToCAP( UniversalMorphismFromInitialObject,
                    "UniversalMorphismFromInitialObject using UniversalMorphismFromZeroObject",
                    [ [ IsomorphismFromInitialObjectToZeroObject, 1 ],
                      [ UniversalMorphismFromZeroObject, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, obj )
    
    return PreCompose( cat, IsomorphismFromInitialObjectToZeroObject( cat ),
                       UniversalMorphismFromZeroObject( cat, obj ) );
    
  end );

##
AddDerivationToCAP( ProjectionInFactorOfDirectProduct,
                    "ProjectionInFactorOfDirectProduct using ProjectionInFactorOfDirectSum",
                    [ [ IsomorphismFromDirectProductToDirectSum, 1 ],
                      [ ProjectionInFactorOfDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram, projection_number )
    
    return PreCompose( cat, IsomorphismFromDirectProductToDirectSum( cat, diagram ),
                       ProjectionInFactorOfDirectSum( cat, diagram, projection_number ) );
  end );

##
AddDerivationToCAP( UniversalMorphismIntoDirectProduct,
                    "UniversalMorphismIntoDirectProduct using UniversalMorphismIntoDirectSum",
                    [ [ UniversalMorphismIntoDirectSum, 1 ],
                      [ IsomorphismFromDirectSumToDirectProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram, test_object, source )
    
    return PreCompose( cat, UniversalMorphismIntoDirectSum( cat, diagram, test_object, source ),
                       IsomorphismFromDirectSumToDirectProduct( cat, diagram ) );
    
  end );

##
AddDerivationToCAP( ComponentOfMorphismIntoDirectProduct,
                    "ComponentOfMorphismIntoDirectProduct using ComponentOfMorphismIntoDirectSum",
                    [ [ IsomorphismFromDirectProductToDirectSum, 1 ],
                      [ ComponentOfMorphismIntoDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, factors, nr )
    
    return ComponentOfMorphismIntoDirectSum( cat,
        PreCompose( cat, alpha, IsomorphismFromDirectProductToDirectSum( cat, factors ) ),
        factors,
        nr
    );
    
  end );

##
AddDerivationToCAP( InjectionOfCofactorOfCoproduct,
                    "InjectionOfCofactorOfCoproduct using InjectionOfCofactorOfDirectSum",
                    [ [ InjectionOfCofactorOfDirectSum, 1 ],
                      [ IsomorphismFromDirectSumToCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram, injection_number )
    
    return PreCompose( cat, InjectionOfCofactorOfDirectSum( cat, diagram, injection_number ),
                       IsomorphismFromDirectSumToCoproduct( cat, diagram ) );
  end );

##
AddDerivationToCAP( UniversalMorphismFromCoproduct,
                    "UniversalMorphismFromCoproduct using UniversalMorphismFromDirectSum",
                    [ [ IsomorphismFromCoproductToDirectSum, 1 ],
                      [ UniversalMorphismFromDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, diagram, test_object, sink )
    
    return PreCompose( cat, IsomorphismFromCoproductToDirectSum( cat, diagram ),
                       UniversalMorphismFromDirectSum( cat, diagram, test_object, sink ) );
  end );

##
AddDerivationToCAP( ComponentOfMorphismFromCoproduct,
                    "ComponentOfMorphismFromCoproduct using ComponentOfMorphismFromDirectSum",
                    [ [ IsomorphismFromDirectSumToCoproduct, 1 ],
                      [ ComponentOfMorphismFromDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, cofactors, nr )
    
    return ComponentOfMorphismFromDirectSum( cat,
        PreCompose( cat, IsomorphismFromDirectSumToCoproduct( cat, cofactors ), alpha ),
        cofactors,
        nr
    );
    
  end );

##
AddDerivationToCAP( UniversalMorphismIntoEqualizer,
                    "UniversalMorphismIntoEqualizer using the universality of the kernel representation of the equalizer",
                    [ [ JointPairwiseDifferencesOfMorphismsIntoDirectProduct, 1 ],
                      [ KernelLift, 1 ],
                      [ IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, A, diagram, test_object, tau )
    local joint_pairwise_differences, kernel_lift;
    
    joint_pairwise_differences := JointPairwiseDifferencesOfMorphismsIntoDirectProduct( cat, A, diagram );
    
    kernel_lift := KernelLift( cat, joint_pairwise_differences, test_object, tau );
    
    return PreCompose( cat,
             kernel_lift,
             IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer( cat, A, diagram )
           );
    
  end );

##
AddDerivationToCAP( UniversalMorphismFromCoequalizer,
                    "UniversalMorphismFromCoequalizer using the universality of the cokernel representation of the coequalizer",
                    [ [ JointPairwiseDifferencesOfMorphismsFromCoproduct, 1 ],
                      [ CokernelColift, 1 ],
                      [ IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, A, diagram, test_object, tau )
    local joint_pairwise_differences, cokernel_colift;
    
    joint_pairwise_differences := JointPairwiseDifferencesOfMorphismsFromCoproduct( cat, A, diagram );
    
    cokernel_colift := CokernelColift( cat, joint_pairwise_differences, test_object, tau );
    
    return PreCompose( cat,
             IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct( cat, A, diagram ),
             cokernel_colift
           );
    
  end );

##
AddDerivationToCAP( ImageEmbedding,
                    "ImageEmbedding as the kernel embedding of the cokernel projection",
                    [ [ CokernelProjection, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ IsomorphismFromImageObjectToKernelOfCokernel, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, mor )
    local image_embedding;
    
    image_embedding := KernelEmbedding( cat, CokernelProjection( cat, mor ) );
    
    return PreCompose( cat, IsomorphismFromImageObjectToKernelOfCokernel( cat, mor ),
                       image_embedding );
  
  end : CategoryFilter := IsAbelianCategory ); ##FIXME: PreAbelian?

##
AddDerivationToCAP( CoimageProjection,
                    "CoimageProjection as the cokernel projection of the kernel embedding",
                    [ [ KernelEmbedding, 1 ],
                      [ CokernelProjection, 1 ],
                      [ IsomorphismFromCokernelOfKernelToCoimage, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, mor )
    local coimage_projection;
    
    coimage_projection := CokernelProjection( cat, KernelEmbedding( cat, mor ) );
    
    return PreCompose( cat, coimage_projection,
                       IsomorphismFromCokernelOfKernelToCoimage( cat, mor ) );
    
end : CategoryFilter := IsAbelianCategory ); ##FIXME: PreAbelian?

##
AddDerivationToCAP( CoimageProjection,
                    "CoimageProjection as the coastriction to image",
                    [ [ CanonicalIdentificationFromImageObjectToCoimage, 1 ],
                      [ CoastrictionToImage, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, mor )
    local iso;
    
    iso := CanonicalIdentificationFromImageObjectToCoimage( cat, mor );
    
    return PreCompose( cat, CoastrictionToImage( cat, mor ), iso );
    
end );

##
AddDerivationToCAP( CoastrictionToImage,
                    "CoastrictionToImage using that image embedding can be seen as a kernel",
                    [ [ ImageEmbedding, 1 ],
                      [ LiftAlongMonomorphism, 1 ] ],
                    
  function( cat, morphism )
    local image_embedding;
    
    image_embedding := ImageEmbedding( cat, morphism );
    
    return LiftAlongMonomorphism( cat, image_embedding, morphism );
  
  end );

##
AddDerivationToCAP( CoastrictionToImageWithGivenImageObject,
                    "CoastrictionToImage using that image embedding can be seen as a kernel",
                    [ [ ImageEmbeddingWithGivenImageObject, 1 ],
                      [ LiftAlongMonomorphism, 1 ] ],
                    
  function( cat, morphism, image )
    local image_embedding;
    
    image_embedding := ImageEmbeddingWithGivenImageObject( cat, morphism, image );
    
    return LiftAlongMonomorphism( cat, image_embedding, morphism );
  
end );

##
AddDerivationToCAP( AstrictionToCoimage,
                    "AstrictionToCoimage using that coimage projection can be seen as a cokernel",
                    [ [ CoimageProjection, 1 ],
                      [ ColiftAlongEpimorphism, 1 ] ],
                    
  function( cat, morphism )
    local coimage_projection;
    
    coimage_projection := CoimageProjection( cat, morphism );
    
    return ColiftAlongEpimorphism( cat, coimage_projection, morphism );
    
  end );

##
AddDerivationToCAP( AstrictionToCoimageWithGivenCoimageObject,
                    "AstrictionToCoimage using that coimage projection can be seen as a cokernel",
                    [ [ CoimageProjectionWithGivenCoimageObject, 1 ],
                      [ ColiftAlongEpimorphism, 1 ] ],
                    
  function( cat, morphism, coimage )
    local coimage_projection;
    
    coimage_projection := CoimageProjectionWithGivenCoimageObject( cat, morphism, coimage );
    
    return ColiftAlongEpimorphism( cat, coimage_projection, morphism );
    
end );

##
AddDerivationToCAP( AstrictionToCoimage,
                    "AstrictionToCoimage as the image embedding",
                    [ [ ImageEmbedding, 1 ],
                      [ PreCompose, 1 ],
                      [ CanonicalIdentificationFromCoimageToImageObject, 1 ] ],
                    
  function( cat, morphism )
    local image_emb;
    
    image_emb := ImageEmbedding( cat, morphism );
    
    return PreCompose( cat, CanonicalIdentificationFromCoimageToImageObject( cat, morphism ), image_emb );
    
  end );

##
AddDerivationToCAP( AstrictionToCoimageWithGivenCoimageObject,
                    "AstrictionToCoimage as the image embedding",
                    [ [ ImageEmbedding, 1 ],
                      [ PreCompose, 1 ],
                      [ CanonicalIdentificationFromCoimageToImageObject, 1 ] ],
                    
  function( cat, morphism, coimage )
    local image_emb;
    
    image_emb := ImageEmbedding( cat, morphism );
    
    return PreCompose( cat, CanonicalIdentificationFromCoimageToImageObject( cat, morphism ), image_emb );
    
end );

##
AddDerivationToCAP( UniversalMorphismFromImage,
                    "UniversalMorphismFromImage using ImageEmbedding and LiftAlongMonomorphism",
                    [ [ ImageEmbedding, 1 ],
                      [ LiftAlongMonomorphism, 1 ] ],
                    
  function( cat, morphism, test_factorization )
    local image_embedding;
    
    image_embedding := ImageEmbedding( cat, morphism );
    
    return LiftAlongMonomorphism( cat, test_factorization[2], image_embedding );
    
  end );

##
AddDerivationToCAP( UniversalMorphismFromImageWithGivenImageObject,
                    "UniversalMorphismFromImage using ImageEmbedding and LiftAlongMonomorphism",
                    [ [ ImageEmbeddingWithGivenImageObject, 1 ],
                      [ LiftAlongMonomorphism, 1 ] ],
                    
  function( cat, morphism, test_factorization, image )
    local image_embedding;
    
    image_embedding := ImageEmbeddingWithGivenImageObject( cat, morphism, image );
    
    return LiftAlongMonomorphism( cat, test_factorization[2], image_embedding );
    
end );

##
AddDerivationToCAP( UniversalMorphismIntoCoimage,
                    "UniversalMorphismIntoCoimage using CoimageProjection and ColiftAlongEpimorphism",
                    [ [ CoimageProjection, 1 ],
                      [ ColiftAlongEpimorphism, 1 ] ],
                    
  function( cat, morphism, test_factorization )
    local coimage_projection;
    
    coimage_projection := CoimageProjection( cat, morphism );
    
    return ColiftAlongEpimorphism( cat, test_factorization[1], coimage_projection );
    
  end );

##
AddDerivationToCAP( UniversalMorphismIntoCoimageWithGivenCoimageObject,
                    "UniversalMorphismIntoCoimage using CoimageProjection and ColiftAlongEpimorphism",
                    [ [ CoimageProjectionWithGivenCoimageObject, 1 ],
                      [ ColiftAlongEpimorphism, 1 ] ],
                    
  function( cat, morphism, test_factorization, coimage )
    local coimage_projection;
    
    coimage_projection := CoimageProjectionWithGivenCoimageObject( cat, morphism, coimage );
    
    return ColiftAlongEpimorphism( cat, test_factorization[1], coimage_projection );
    
end );

##
AddDerivationToCAP( UniversalMorphismIntoCoimage,
                    "UniversalMorphismIntoCoimage using UniversalMorphismFromImage and CanonicalIdentificationFromImageObjectToCoimage",
                    [ [ UniversalMorphismFromImage, 1 ],
                      [ CanonicalIdentificationFromImageObjectToCoimage, 1 ],
                      [ InverseForMorphisms, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, morphism, test_factorization )
    local induced_mor;
    
    induced_mor := UniversalMorphismFromImage( cat, morphism, test_factorization );
    
    return PreCompose( cat, InverseForMorphisms( cat, induced_mor ), CanonicalIdentificationFromImageObjectToCoimage( cat, morphism ) );
    
  end );

##
AddDerivationToCAP( UniversalMorphismIntoEqualizer,
                    "UniversalMorphismIntoEqualizer using LiftAlongMonomorphism and EmbeddingOfEqualizer",
                    [ [ LiftAlongMonomorphism, 1 ],
                      [ EmbeddingOfEqualizer, 1 ] ],
                    
  function( cat, A, diagram, test_object, test_morphism )
    
    return LiftAlongMonomorphism( cat, EmbeddingOfEqualizer( cat, A, diagram ), test_morphism );
    
  end );

##
AddDerivationToCAP( UniversalMorphismIntoEqualizerWithGivenEqualizer,
                    "UniversalMorphismIntoEqualizer using LiftAlongMonomorphism and EmbeddingOfEqualizer",
                    [ [ LiftAlongMonomorphism, 1 ],
                      [ EmbeddingOfEqualizerWithGivenEqualizer, 1 ] ],
                    
  function( cat, A, diagram, test_object, test_morphism, equalizer )
    
    return LiftAlongMonomorphism( cat, EmbeddingOfEqualizerWithGivenEqualizer( cat, A, diagram, equalizer ), test_morphism );
    
end );

##
AddDerivationToCAP( MorphismFromEqualizerToSink,
                    "MorphismFromEqualizerToSink by composing the embedding with the first morphism in the diagram",
                    [ [ EmbeddingOfEqualizer, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, A, diagram )
    local iota;
    
    iota := EmbeddingOfEqualizer( cat, A, diagram );
    
    return PreCompose( cat, iota, diagram[1] );
    
  end );

##
AddDerivationToCAP( UniversalMorphismFromCoequalizer,
                    "UniversalMorphismFromCoequalizer using ColiftAlongEpimorphism and ProjectionOntoCoequalizer",
                    [ [ ColiftAlongEpimorphism, 1 ],
                      [ ProjectionOntoCoequalizer, 1 ] ],
                    
  function( cat, A, diagram, test_object, test_morphism )
    
    return ColiftAlongEpimorphism( cat, ProjectionOntoCoequalizer( cat, A, diagram ), test_morphism );
    
  end );

##
AddDerivationToCAP( UniversalMorphismFromCoequalizerWithGivenCoequalizer,
                    "UniversalMorphismFromCoequalizer using ColiftAlongEpimorphism and ProjectionOntoCoequalizer",
                    [ [ ColiftAlongEpimorphism, 1 ],
                      [ ProjectionOntoCoequalizerWithGivenCoequalizer, 1 ] ],
                    
  function( cat, A, diagram, test_object, test_morphism, coequalizer )
      
      return ColiftAlongEpimorphism( cat, ProjectionOntoCoequalizerWithGivenCoequalizer( cat, A, diagram, coequalizer ), test_morphism );
      
end );

##
AddDerivationToCAP( MorphismFromSourceToCoequalizer,
                    "MorphismFromSourceToCoequalizer by composing the first morphism in the diagram with the projection",
                    [ [ ProjectionOntoCoequalizer, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, A, diagram )
    local pi;
    
    pi := ProjectionOntoCoequalizer( cat, A, diagram );
    
    return PreCompose( cat, diagram[1], pi );
    
  end );

##
AddDerivationToCAP( ImageObjectFunctorialWithGivenImageObjects,
                    "ImageObjectFunctorialWithGivenImageObjects using the universality",
                    [ [ LiftAlongMonomorphism, 1 ],
                      [ ImageEmbeddingWithGivenImageObject, 2 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, I, alpha, nu, alphap, Ip )
    
    return LiftAlongMonomorphism( cat,
                   ImageEmbeddingWithGivenImageObject( cat, alphap, Ip ),
                   PreCompose( cat, ImageEmbeddingWithGivenImageObject( cat, alpha, I ), nu ) );
    
end );

##
AddDerivationToCAP( CoimageObjectFunctorialWithGivenCoimageObjects,
                    "CoimageObjectFunctorialWithGivenCoimageObjects using the universality",
                    [ [ ColiftAlongEpimorphism, 1 ],
                      [ CoimageProjectionWithGivenCoimageObject, 2 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, C, alpha, mu, alphap, Cp )
    
    return ColiftAlongEpimorphism( cat,
                   CoimageProjectionWithGivenCoimageObject( cat, alpha, C ),
                   PreCompose( cat, mu, CoimageProjectionWithGivenCoimageObject( cat, alphap, Cp ) ) );
    
end );

##
AddDerivationToCAP( ProjectiveCoverObject,
                    "ProjectiveCoverObject as the source of EpimorphismFromProjectiveCoverObject",
                    [ [ EpimorphismFromProjectiveCoverObject, 1 ] ],
                    
  function( cat, obj )
    
    return Source( EpimorphismFromProjectiveCoverObject( cat, obj ) );
    
end );

##
AddDerivationToCAP( InjectiveEnvelopeObject,
                    "InjectiveEnvelopeObject as the range of MonomorphismIntoInjectiveEnvelopeObject",
                    [ [ MonomorphismIntoInjectiveEnvelopeObject, 1 ] ],
                    
  function( cat, obj )
    
    return Range( MonomorphismIntoInjectiveEnvelopeObject( cat, obj ) );
    
end );

###########################
##
## Methods returning a boolean
##
###########################

##
AddDerivationToCAP( IsBijectiveObject,
                    "IsBijectiveObject by checking if the object is both projective and injective",
                    [ [ IsProjective, 1 ],
                      [ IsInjective, 1 ] ],
                    
  function( cat, object )
    
    return IsProjective( cat, object ) and IsInjective( cat, object );
    
end );

##
AddDerivationToCAP( IsProjective,
                    "IsProjective by checking if the object is a retract of some projective object",
                    [ [ EpimorphismFromSomeProjectiveObject, 1 ],
                      [ IsSplitEpimorphism, 1 ] ],
                    
  function( cat, object )
    
    return IsSplitEpimorphism( cat, EpimorphismFromSomeProjectiveObject( cat, object ) );
    
end );

##
AddDerivationToCAP( IsInjective,
                    "IsInjective by checking if the object is a retract of some injective object",
                    [ [ MonomorphismIntoSomeInjectiveObject, 1 ],
                      [ IsSplitMonomorphism, 1 ] ],
                    
  function( cat, object )
    
    return IsSplitMonomorphism( cat, MonomorphismIntoSomeInjectiveObject( cat, object ) );
    
end );

##
AddDerivationToCAP( IsOne,
                    "IsOne by comparing with the identity morphism",
                    [ [ IdentityMorphism, 1 ],
                      [ IsCongruentForMorphisms, 1 ] ],
                    
  function( cat, morphism )
    local object;
    
    object := Source( morphism );
    
    return IsCongruentForMorphisms( cat, IdentityMorphism( cat, object ), morphism );
    
end );

##
AddDerivationToCAP( IsEndomorphism,
                    "IsEndomorphism by deciding whether source and range are equal as objects",
                    [ [ IsEqualForObjects, 1 ] ],
                    
  function( cat, morphism )
    
    return IsEqualForObjects( cat, Source( morphism ), Range( morphism ) );
    
end );

##
AddDerivationToCAP( IsAutomorphism,
                    "IsAutomorphism by checking IsEndomorphism and IsIsomorphism",
                    [ [ IsEndomorphism, 1 ],
                      [ IsIsomorphism, 1 ] ],
                    
  function( cat, morphism )
    
    return IsEndomorphism( cat, morphism ) and IsIsomorphism( cat, morphism );
    
end );

##
AddDerivationToCAP( IsZeroForMorphisms,
                    "IsZeroForMorphisms by deciding whether the given morphism is congruent to the zero morphism",
                    [ [ ZeroMorphism, 1 ],
                      [ IsCongruentForMorphisms, 1 ] ],
                    
  function( cat, morphism )
    local zero_morphism;
    
    zero_morphism := ZeroMorphism( cat, Source( morphism ), Range( morphism ) );
    
    return IsCongruentForMorphisms( cat, zero_morphism, morphism );
    
end );

##
AddDerivationToCAP( IsEqualToIdentityMorphism,
                    "IsEqualToIdentityMorphism using IsEqualForMorphismsOnMor and IdentityMorphism",
                    [ [ IsEqualForMorphismsOnMor, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, morphism )
    
    return IsEqualForMorphismsOnMor( cat, morphism, IdentityMorphism( cat, Source( morphism ) ) );
    
end );

##
AddDerivationToCAP( IsEqualToZeroMorphism,
                    "IsEqualToZeroMorphism using IsEqualForMorphisms and ZeroMorphism",
                    [ [ IsEqualForMorphisms, 1 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat, morphism )
    
    return IsEqualForMorphisms( cat, morphism, ZeroMorphism( cat, Source( morphism ), Range( morphism ) ) );
    
end );

##
AddDerivationToCAP( IsZeroForObjects,
                    "IsZeroForObjects by comparing identity morphism with zero morphism",
                    [ [ IsCongruentForMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat, object )
  
    return IsCongruentForMorphisms( cat, IdentityMorphism( cat, object ), ZeroMorphism( cat, object, object ) );
    
end );

##
AddDerivationToCAP( IsTerminal,
                    "IsTerminal using IsZeroForObjects",
                    [ [ IsZeroForObjects, 1 ] ],
                    
  function( cat, object )
    
    return IsZeroForObjects( cat, object );
    
end : CategoryFilter := IsAdditiveCategory ); #Ab-Category?

##
AddDerivationToCAP( IsTerminal,
                    "IsTerminal using IsIsomorphism( cat, UniversalMorphismIntoTerminalObject )",
                    [ [ IsIsomorphism, 1 ],
                      [ UniversalMorphismIntoTerminalObject, 1 ] ],
                    
  function( cat, object )
    
    return IsIsomorphism( cat, UniversalMorphismIntoTerminalObject( cat, object ) );
    
end );

##
AddDerivationToCAP( IsInitial,
                    "IsInitial using IsZeroForObjects",
                    [ [ IsZeroForObjects, 1 ] ],
                    
  function( cat, object )
    
    return IsZeroForObjects( cat, object );
    
end : CategoryFilter := IsAdditiveCategory ); #Ab-Category?

##
AddDerivationToCAP( IsInitial,
                    "IsInitial using IsIsomorphism( cat, UniversalMorphismFromInitialObject )",
                    [ [ IsIsomorphism, 1 ],
                      [ UniversalMorphismFromInitialObject, 1 ] ],
                    
  function( cat, object )
    
    return IsIsomorphism( cat, UniversalMorphismFromInitialObject( cat, object ) );
    
end );

##
AddDerivationToCAP( IsEqualForMorphismsOnMor,
                    "IsEqualForMorphismsOnMor using IsEqualForMorphisms",
                    [ [ IsEqualForMorphisms, 1 ],
                      [ IsEqualForObjects, 2 ] ],
                    
  function( cat, morphism_1, morphism_2 )
    local value_1, value_2;
    
    value_1 := IsEqualForObjects( cat, Source( morphism_1 ), Source( morphism_2 ) );
    
    value_2 := IsEqualForObjects( cat, Range( morphism_1 ), Range( morphism_2 ) );
    
    if value_1 and value_2 then
        
        return IsEqualForMorphisms( cat, morphism_1, morphism_2 );
        
    else
        
        return false;
        
    fi;
    
end );

##
AddDerivationToCAP( IsIdempotent,
                    "IsIdempotent by comparing the square of the morphism with itself",
                    [ [ IsCongruentForMorphisms, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, morphism )
    
    return IsCongruentForMorphisms( cat, PreCompose( cat, morphism, morphism ), morphism );
    
end );

##
AddDerivationToCAP( IsMonomorphism,
                    "IsMonomorphism by deciding if the kernel is a zero object",
                    [ [ IsZeroForObjects, 1 ],
                      [ KernelObject, 1 ] ],
                    
  function( cat, morphism )
    
    return IsZeroForObjects( cat, KernelObject( cat, morphism ) );
    
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( IsMonomorphism,
                    "IsMonomorphism by deciding if the diagonal morphism is an isomorphism",
                    [ [ IsIsomorphism, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ UniversalMorphismIntoFiberProduct, 1 ] ],
                    
  function( cat, morphism )
    local pullback_diagram, pullback_projection_1, pullback_projection_2, identity, diagonal_morphism;
      
      pullback_diagram := [ morphism, morphism ];
      
      identity := IdentityMorphism( cat, Source( morphism ) );
      
      diagonal_morphism := UniversalMorphismIntoFiberProduct( cat, pullback_diagram, [ identity, identity ] );
      
      return IsIsomorphism( cat, diagonal_morphism );
    
end );

##
AddDerivationToCAP( IsEpimorphism,
                    "IsEpimorphism by deciding if the cokernel is a zero object",
                    [ [ IsZeroForObjects, 1 ],
                      [ CokernelObject, 1 ] ],
                    
  function( cat, morphism )
    
    return IsZeroForObjects( cat, CokernelObject( cat, morphism ) );
    
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( IsEpimorphism,
                    "IsEpimorphism by deciding if the codiagonal morphism is an isomorphism",
                    [ [ IdentityMorphism, 1 ],
                      [ UniversalMorphismFromPushout, 1 ],
                      [ IsIsomorphism, 1 ] ],
                    
  function( cat, morphism )
    local pushout_diagram, identity, codiagonal_morphism;
      
      pushout_diagram := [ morphism, morphism ];
      
      identity := IdentityMorphism( cat, Range( morphism ) );
      
      codiagonal_morphism := UniversalMorphismFromPushout( cat, pushout_diagram, [ identity, identity ] );
      
      return IsIsomorphism( cat, codiagonal_morphism );
    
end );

##
AddDerivationToCAP( IsIsomorphism,
                    "IsIsomorphism by deciding if it is a mono and an epi",
                    [ [ IsMonomorphism, 1 ],
                      [ IsEpimorphism, 1 ] ],
                    
  function( cat, morphism )
    
    return IsMonomorphism( cat, morphism ) and IsEpimorphism( cat, morphism );
    
end : CategoryFilter := IsAbelianCategory );

##
AddDerivationToCAP( IsIsomorphism,
                    "IsIsomorphism by deciding if it is a split mono and a split epi",
                    [ [ IsSplitMonomorphism, 1 ],
                      [ IsSplitEpimorphism, 1 ] ],
                    
  function( cat, morphism )
    
    return IsSplitMonomorphism( cat, morphism ) and IsSplitEpimorphism( cat, morphism );
    
end );

##
AddDerivationToCAP( IsIsomorphism,
                    "IsIsomorphism by deciding if it is a split mono and an epi",
                    [ [ IsSplitMonomorphism, 1 ],
                      [ IsEpimorphism, 1 ] ],
                    
  function( cat, morphism )
    
    return IsSplitMonomorphism( cat, morphism ) and IsEpimorphism( cat, morphism );
    
end );

##
AddDerivationToCAP( IsIsomorphism,
                    "IsIsomorphism by deciding if it is a mono and a split epi",
                    [ [ IsMonomorphism, 1 ],
                      [ IsSplitEpimorphism, 1 ] ],
                    
  function( cat, morphism )
    
    return IsMonomorphism( cat, morphism ) and IsSplitEpimorphism( cat, morphism );
    
end );

##
AddDerivationToCAP( IsSplitEpimorphism,
                    "IsSplitEpimorphism by using IsLiftable",
                    [ [ IsLiftable, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, morphism )
    
    return IsLiftable( cat, IdentityMorphism( cat, Range( morphism ) ), morphism );
  
end );

##
AddDerivationToCAP( IsSplitMonomorphism,
                    "IsSplitMonomorphism by using IsColiftable",
                    [ [ IsColiftable, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, morphism )
    
    return IsColiftable( cat, morphism, IdentityMorphism( cat, Source( morphism ) ) );
  
end );

##
AddDerivationToCAP( IsEqualAsSubobjects,
                    "IsEqualAsSubobjects(sub1, sub2) if sub1 dominates sub2 and vice versa",
                    [ [ IsDominating, 2 ] ],
                    
  function( cat, sub1, sub2 )
    
    return IsDominating( cat, sub1, sub2 ) and IsDominating( cat, sub2, sub1 );
    
end );

##
AddDerivationToCAP( IsEqualAsFactorobjects,
                    "IsEqualAsFactorobjects(factor1, factor2) if factor1 dominates factor2 and vice versa",
                    [ [ IsCodominating, 2 ] ],
                    
  function( cat, factor1, factor2 )
    
    return IsCodominating( cat, factor1, factor2 ) and IsCodominating( cat, factor2, factor1 );
    
end );

##
AddDerivationToCAP( IsDominating,
                    "IsDominating using IsLiftableAlongMonomorphism",
                    [ [ IsLiftableAlongMonomorphism, 1 ] ],
                    
  function( cat, sub1, sub2 )
    
    return IsLiftableAlongMonomorphism( cat, sub2, sub1 );
    
end );

##
AddDerivationToCAP( IsDominating,
                    "IsDominating using IsCodominating and duality by cokernel",
                    [ [ CokernelProjection, 2 ],
                      [ IsCodominating, 1 ] ],
                    
  function( cat, sub1, sub2 )
    local cokernel_projection_1, cokernel_projection_2;
    
    cokernel_projection_1 := CokernelProjection( cat, sub1 );
    
    cokernel_projection_2 := CokernelProjection( cat, sub2 );
    
    return IsCodominating( cat, cokernel_projection_1, cokernel_projection_2 );
    
end );

##
AddDerivationToCAP( IsDominating,
                    "IsDominating(sub1, sub2) by deciding if sub1 composed with CokernelProjection(cat, sub2) is zero",
                    [ [ CokernelProjection, 1 ],
                      [ PreCompose, 1 ],
                      [ IsZeroForMorphisms, 1 ] ],
                    
  function( cat, sub1, sub2 )
    local cokernel_projection, composition;
    
    cokernel_projection := CokernelProjection( cat, sub2 );
    
    composition := PreCompose( cat, sub1, cokernel_projection );
    
    return IsZeroForMorphisms( cat, composition );
    
end );

##
AddDerivationToCAP( IsCodominating,
                    "IsCodominating using IsColiftableAlongEpimorphism",
                    [ [ IsColiftableAlongEpimorphism, 1 ] ],
                    
  function( cat, factor1, factor2 )
    
    return IsColiftableAlongEpimorphism( cat, factor2, factor1 );
    
end );

##
AddDerivationToCAP( IsCodominating,
                    "IsCodominating using IsDominating and duality by kernel",
                    [ [ KernelEmbedding, 2 ],
                      [ IsDominating, 1 ] ],
                    
  function( cat, factor1, factor2 )
    local kernel_embedding_1, kernel_embedding_2;
    
    kernel_embedding_1 := KernelEmbedding( cat, factor1 );
    
    kernel_embedding_2 := KernelEmbedding( cat, factor2 );
    
    return IsDominating( cat, kernel_embedding_2, kernel_embedding_1 );
    
end );

##
AddDerivationToCAP( IsCodominating,
                    "IsCodominating(factor1, factor2) by deciding if KernelEmbedding(cat, factor2) composed with factor1 is zero",
                    [ [ KernelEmbedding, 1 ],
                      [ PreCompose, 1 ],
                      [ IsZeroForMorphisms, 1 ] ],
                    
  function( cat, factor1, factor2 )
    local kernel_embedding, composition;
    
    kernel_embedding := KernelEmbedding( cat, factor2 );
    
    composition := PreCompose( cat, kernel_embedding, factor1 );
    
    return IsZeroForMorphisms( cat, composition );
    
end );

##
AddDerivationToCAP( IsLiftableAlongMonomorphism,
                    "IsLiftableAlongMonomorphism using IsLiftable",
                    [ [ IsLiftable, 1 ] ],
                    
  function( cat, iota, tau )
    
    return IsLiftable( cat, tau, iota );
    
end );

##
AddDerivationToCAP( IsColiftableAlongEpimorphism,
                    "IsColiftableAlongEpimorphism using IsColiftable",
                    [ [ IsColiftable, 1 ] ],
                    
  function( cat, epsilon, tau )
    
    return IsColiftable( cat, epsilon, tau );
    
end );

##
AddDerivationToCAP( IsProjective,
                    "",
                    [ [ EpimorphismFromProjectiveCoverObject, 1 ],
                      [ IsIsomorphism, 1 ] ],
                    
  function( cat, alpha )
    
    return IsIsomorphism( cat, EpimorphismFromProjectiveCoverObject( cat, alpha ) );
    
end );

##
AddDerivationToCAP( IsInjective,
                    "",
                    [ [ MonomorphismIntoInjectiveEnvelopeObject, 1 ],
                      [ IsIsomorphism, 1 ] ],
                    
  function( cat, alpha )
    
    return IsIsomorphism( cat, MonomorphismIntoInjectiveEnvelopeObject( cat, alpha ) );
    
end );

###########################
##
## Methods returning a morphism where the source and range can directly be read of from the input
##
###########################

##
AddDerivationToCAP( ZeroMorphism,
                    "Zero morphism by composition of morphism into and from zero object",
                    [ [ PreCompose, 1 ],
                      [ UniversalMorphismIntoZeroObject, 1 ],
                      [ UniversalMorphismFromZeroObject, 1 ] ],
                    
  function( cat, obj_source, obj_range )
    
    return PreCompose( cat, UniversalMorphismIntoZeroObject( cat, obj_source ), UniversalMorphismFromZeroObject( cat, obj_range ) );
    
  end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( ZeroMorphism,
                    "computing the empty sum of morphisms",
                    [ [ SumOfMorphisms, 1 ] ],
                    
  function( cat, obj_source, obj_range )
    
    return SumOfMorphisms( cat, obj_source, [ ], obj_range );
    
  end : CategoryFilter := IsAbCategory );

##
AddDerivationToCAP( PostCompose,
                    "PostCompose using PreCompose and swapping arguments",
                    [ [ PreCompose, 1 ] ],
                    
  function( cat, right_mor, left_mor )
    
    return PreCompose( cat, left_mor, right_mor );
    
end );

##
AddDerivationToCAP( PreCompose,
                    "PreCompose using PostCompose and swapping arguments",
                    [ [ PostCompose, 1 ] ],
                    
  function( cat, left_mor, right_mor )
    
    return PostCompose( cat, right_mor, left_mor );
    
end );

##
AddDerivationToCAP( PreCompose,
                    "PreCompose by wrapping the arguments in a list",
                    [ [ PreComposeList, 1 ] ],
                    
  function( cat, left_mor, right_mor )
    
    return PreComposeList( cat, [ left_mor, right_mor ] );
    
end );

##
AddDerivationToCAP( PreComposeList,
                    "PreComposeList by iterating PreCompose",
                    [ [ PreCompose, 2 ] ],
                    
  function( cat, morphism_list )
    
    return Iterated( morphism_list, { alpha, beta } -> PreCompose( cat, alpha, beta ) );
    
end );

##
AddDerivationToCAP( PostCompose,
                    "PostCompose by wrapping the arguments in a list",
                    [ [ PostComposeList, 1 ] ],
                    
  function( cat, mor_right, mor_left )
    
    return PostComposeList( cat, [ mor_right, mor_left ] );
    
end );

##
AddDerivationToCAP( PostComposeList,
                    "PostComposeList by iterating PostCompose",
                    [ [ PostCompose, 2 ] ],
                    
  function( cat, morphism_list )
    
    return Iterated( morphism_list, { beta, alpha } -> PostCompose( cat, beta, alpha ) );
    
end );

##
AddDerivationToCAP( InverseForMorphisms,
                    "InverseForMorphisms using LiftAlongMonomorphism of an identity morphism",
                    [ [ IdentityMorphism, 1 ],
                      [ LiftAlongMonomorphism, 1 ] ],
                    
  function( cat, mor )
    local identity_of_range;
        
        identity_of_range := IdentityMorphism( cat, Range( mor ) );
        
        return LiftAlongMonomorphism( cat, mor, identity_of_range );
        
end );

##
AddDerivationToCAP( InverseForMorphisms,
                    "InverseForMorphisms using ColiftAlongEpimorphism of an identity morphism",
                    [ [ IdentityMorphism, 1 ],
                      [ ColiftAlongEpimorphism, 1 ] ],
                    
  function( cat, mor )
    local identity_of_source;
    
    identity_of_source := IdentityMorphism( cat, Source( mor ) );
    
    return ColiftAlongEpimorphism( cat, mor, identity_of_source );
      
end );

##
AddDerivationToCAP( PreInverseForMorphisms,
                    "PreInverseForMorphisms using IdentityMorphism and Lift",
                    [ [ IdentityMorphism, 1 ],
                      [ Lift, 1 ] ],
                    
  function( cat, mor )
    
    return Lift( cat, IdentityMorphism( cat, Range( mor ) ), mor );
    
end );

##
AddDerivationToCAP( PostInverseForMorphisms,
                    "PostInverseForMorphisms using IdentityMorphism and Colift",
                    [ [ IdentityMorphism, 1 ],
                      [ Colift, 1 ] ],
                    
  function( cat, mor )
    
    return Colift( cat, mor, IdentityMorphism( cat, Source( mor ) ) );
    
end );

##
AddDerivationToCAP( AdditionForMorphisms,
                    "AdditionForMorphisms using SumOfMorphisms",
                    [ [ SumOfMorphisms, 1 ] ],
                    
  function( cat, mor1, mor2 )
    
    return SumOfMorphisms( cat, Source( mor1 ), [ mor1, mor2 ], Range( mor1 ) );
    
end : CategoryFilter := IsAbCategory );

##
AddDerivationToCAP( AdditionForMorphisms,
                    "AdditionForMorphisms(mor1, mor2) as the composition of (mor1,mor2) with the codiagonal morphism",
                    [ [ UniversalMorphismIntoDirectSum, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ UniversalMorphismFromDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, mor1, mor2 )
    local return_value, B, identity_morphism_B, componentwise_morphism, addition_morphism;
    
    B := Range( mor1 );
    
    componentwise_morphism := UniversalMorphismIntoDirectSum( cat, [ mor1, mor2 ] );
    
    identity_morphism_B := IdentityMorphism( cat, B );
    
    addition_morphism := UniversalMorphismFromDirectSum( cat, [ identity_morphism_B, identity_morphism_B ] );
    
    return PreCompose( cat, componentwise_morphism, addition_morphism );
    
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( SubtractionForMorphisms,
                    "SubtractionForMorphisms(mor1, mor2) as the sum of mor1 and the additive inverse of mor2",
                    [ [ AdditionForMorphisms, 1 ],
                      [ AdditiveInverseForMorphisms, 1 ] ],
                    
  function( cat, mor1, mor2 )
    
    return AdditionForMorphisms( cat, mor1, AdditiveInverseForMorphisms( cat, mor2 ) );
    
end : CategoryFilter := IsAbCategory );

##
AddDerivationToCAP( SumOfMorphisms,
                    "SumOfMorphisms using AdditionForMorphisms and ZeroMorphism",
                    [ [ AdditionForMorphisms, 2 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat, obj1, mors, obj2 )
    local zero_morphism;
    
    zero_morphism := ZeroMorphism( cat, obj1, obj2 );
    
    return Iterated( mors, { alpha, beta } -> AdditionForMorphisms( cat, alpha, beta ), zero_morphism );
    
end : CategoryFilter := IsAbCategory );

##
AddDerivationToCAP( LinearCombinationOfMorphisms,
                    "LinearCombinationOfMorphisms using SumOfMorphisms and MultiplyWithElementOfCommutativeRingForMorphisms",
                    [ [ MultiplyWithElementOfCommutativeRingForMorphisms, 2 ],
                      [ SumOfMorphisms, 1 ] ],
                    
  function( cat, obj1, coeffs, mors, obj2 )
    local morphisms;
    
    morphisms := ListN( coeffs, mors, { r, alpha } -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, alpha ) );
    
    return SumOfMorphisms( cat, obj1, morphisms, obj2 );
    
end : CategoryFilter := IsLinearCategoryOverCommutativeRing );

##
AddDerivationToCAP( LiftAlongMonomorphism,
                    "LiftAlongMonomorphism using Lift",
                    [ [ Lift, 1 ] ],
                    
  function( cat, alpha, beta )
    
    ## Caution with the order of the arguments!
    return Lift( cat, beta, alpha );
    
end );

##
AddDerivationToCAP( ProjectiveLift,
                    "ProjectiveLift using Lift",
                    [ [ Lift, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Lift( cat, alpha, beta );
    
end );


##
AddDerivationToCAP( ColiftAlongEpimorphism,
                    "ColiftAlongEpimorphism using Colift",
                    [ [ Colift, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Colift( cat, alpha, beta );
    
end );

##
AddDerivationToCAP( InjectiveColift,
                    "InjectiveColift using Colift",
                    [ [ Colift, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Colift( cat, alpha, beta );
    
end );

##
AddDerivationToCAP( RandomMorphismByInteger,
                    "RandomMorphismByInteger using RandomObjectByInteger and RandomMorphismWithFixedSourceByInteger",
                    [ [ RandomObjectByInteger, 1 ],
                      [ RandomMorphismWithFixedSourceByInteger, 1 ] ],
                    
  function( cat, n )
    
    return RandomMorphismWithFixedSourceByInteger( cat, RandomObjectByInteger( cat, n ), 1 + Log2Int( n ) );
    
end );

##
AddDerivationToCAP( RandomMorphismByInteger,
                    "RandomMorphismByInteger using RandomObjectByInteger and RandomMorphismWithFixedRangeByInteger",
                    [ [ RandomObjectByInteger, 1 ],
                      [ RandomMorphismWithFixedRangeByInteger, 1 ] ],
                    
  function( cat, n )
    
    return RandomMorphismWithFixedRangeByInteger( cat, RandomObjectByInteger( cat, n ),  1 + Log2Int( n ) );
    
end );

##
AddDerivationToCAP( RandomMorphismWithFixedSourceByInteger,
                    "RandomMorphismWithFixedSourceByInteger using RandomObjectByInteger and RandomMorphismWithFixedSourceAndRangeByInteger",
                    [ [ RandomObjectByInteger, 1 ],
                      [ RandomMorphismWithFixedSourceAndRangeByInteger, 1 ] ],
                    
  function( cat, S, n )
    
    return RandomMorphismWithFixedSourceAndRangeByInteger( cat, S, RandomObjectByInteger( cat, n ), 1 + Log2Int( n ) );
    
end : CategoryFilter := IsAbCategory );

##
AddDerivationToCAP( RandomMorphismWithFixedRangeByInteger,
                    "RandomMorphismWithFixedRangeByInteger using RandomObjectByInteger and RandomMorphismWithFixedSourceAndRangeByInteger",
                    [ [ RandomObjectByInteger, 1 ],
                      [ RandomMorphismWithFixedSourceAndRangeByInteger, 1 ] ],
                    
  function( cat, R, n )
    
    return RandomMorphismWithFixedSourceAndRangeByInteger( cat, RandomObjectByInteger( cat, n ), R, 1 + Log2Int( n ) );
    
end : CategoryFilter := IsAbCategory );

##
AddDerivationToCAP( RandomMorphismByInteger,
                    "RandomMorphismByInteger using RandomObjectByInteger and RandomMorphismWithFixedSourceAndRangeByInteger",
                    [ [ RandomObjectByInteger, 2 ],
                      [ RandomMorphismWithFixedSourceAndRangeByInteger, 1 ] ],
                    
  function( cat, n )
    
    return RandomMorphismWithFixedSourceAndRangeByInteger( cat, RandomObjectByInteger( cat, n ), RandomObjectByInteger( cat, n ), 1 + Log2Int( n ) );
    
end : CategoryFilter := IsAbCategory );

##
AddDerivationToCAP( RandomMorphismByList,
                    "RandomMorphismByList using RandomObjectByList and RandomMorphismWithFixedSourceByList",
                    [ [ RandomObjectByList, 1 ],
                      [ RandomMorphismWithFixedSourceByList, 1 ] ],
                    
  function( cat, L )
    
    if Length( L ) <> 2 or not ForAll( L, IsList ) then
        Error( "the list passed to 'RandomMorphismByList' in ", Name( cat ), " must be a list consisting of two lists!\n" );
    fi;
    
    return RandomMorphismWithFixedSourceByList( cat, RandomObjectByList( cat, L[1] ), L[2] );
    
end );

##
AddDerivationToCAP( RandomMorphismByList,
                    "RandomMorphismByList using RandomObjectByList and RandomMorphismWithFixedRangeByList",
                    [ [ RandomObjectByList, 1 ],
                      [ RandomMorphismWithFixedRangeByList, 1 ] ],
                    
  function( cat, L )
    
    if Length( L ) <> 2 or not ForAll( L, IsList ) then
        Error( "the list passed to 'RandomMorphismByList' in ", Name( cat ), " must be a list consisting of two lists!\n" );
    fi;
    
    return RandomMorphismWithFixedRangeByList( cat, RandomObjectByList( cat, L[1] ), L[2] );
    
end );

##
AddDerivationToCAP( RandomMorphismWithFixedSourceByList,
                    "RandomMorphismWithFixedSourceByList using RandomObjectByList and RandomMorphismWithFixedSourceAndRangeByList",
                    [ [ RandomObjectByList, 1 ],
                      [ RandomMorphismWithFixedSourceAndRangeByList, 1 ] ],
                    
  function( cat, S, L )
    
    if Length( L ) <> 2 or not ForAll( L, IsList ) then
        Error( "the list passed to 'RandomMorphismWithFixedSourceByList' in ", Name( cat ), " must be a list consisting of two lists!\n" );
    fi;
    
    return RandomMorphismWithFixedSourceAndRangeByList( cat, S, RandomObjectByList( cat, L[1] ), L[2] );
    
end : CategoryFilter := IsAbCategory );

##
AddDerivationToCAP( RandomMorphismWithFixedRangeByList,
                    "RandomMorphismWithFixedRangeByList using RandomObjectByList and RandomMorphismWithFixedSourceAndRangeByList",
                    [ [ RandomObjectByList, 1 ],
                      [ RandomMorphismWithFixedSourceAndRangeByList, 1 ] ],
                    
  function( cat, R, L )
    
    if Length( L ) <> 2 or not ForAll( L, IsList ) then
        Error( "the list passed to 'RandomMorphismWithFixedRangeByList' in ", Name( cat ), " must be a list consisting of two lists!\n" );
    fi;
    
    return RandomMorphismWithFixedSourceAndRangeByList( cat, RandomObjectByList( cat, L[1] ), R, L[2] );

end : CategoryFilter := IsAbCategory );

##
AddDerivationToCAP( RandomMorphismByList,
                    "RandomMorphismByList using RandomObjectByList and RandomMorphismWithFixedSourceAndRangeByList",
                    [ [ RandomObjectByList, 2 ],
                      [ RandomMorphismWithFixedSourceAndRangeByList, 1 ] ],
                    
  function( cat, L )
    
    if Length( L ) <> 3 or not ForAll( L, IsList ) then
        Error( "the list passed to 'RandomMorphismByList' in ", Name( cat ), " must be a list consisting of three lists!\n" );
    fi;
    
    return RandomMorphismWithFixedSourceAndRangeByList( cat, RandomObjectByList( cat, L[1] ), RandomObjectByList( cat, L[2] ), L[3] );
    
end : CategoryFilter := IsAbCategory );


##
AddDerivationToCAP( IsomorphismFromKernelOfCokernelToImageObject,
                    "IsomorphismFromKernelOfCokernelToImageObject as the inverse of IsomorphismFromImageObjectToKernelOfCokernel",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromImageObjectToKernelOfCokernel, 1 ] ],
                    
  function( cat, morphism )
    
    return InverseForMorphisms( cat, IsomorphismFromImageObjectToKernelOfCokernel( cat, morphism ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromImageObjectToKernelOfCokernel,
                    "IsomorphismFromImageObjectToKernelOfCokernel as the inverse of IsomorphismFromKernelOfCokernelToImageObject",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromKernelOfCokernelToImageObject, 1 ] ],
                    
  function( cat, morphism )
    
    return InverseForMorphisms( cat, IsomorphismFromKernelOfCokernelToImageObject( cat, morphism ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromImageObjectToKernelOfCokernel,
                    "IsomorphismFromImageObjectToKernelOfCokernel using the universal property of the image",
                    [ [ KernelEmbedding, 1 ],
                      [ CokernelProjection, 1 ],
                      [ LiftAlongMonomorphism, 1 ],
                      [ UniversalMorphismFromImage, 1 ] ],
                    
  function( cat, morphism )
    local kernel_emb, morphism_to_kernel;
    
    kernel_emb := KernelEmbedding( cat, CokernelProjection( cat, morphism ) );
    
    morphism_to_kernel := LiftAlongMonomorphism( cat, kernel_emb, morphism );
    
    return UniversalMorphismFromImage( cat, morphism, [ morphism_to_kernel, kernel_emb ] );
    
end : CategoryFilter := IsAbelianCategory );

##
AddDerivationToCAP( IsomorphismFromCokernelOfKernelToCoimage,
                    "IsomorphismFromCokernelOfKernelToCoimage as the inverse of IsomorphismFromCoimageToCokernelOfKernel",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromCoimageToCokernelOfKernel, 1 ] ],
                    
  function( cat, morphism )
    
    return InverseForMorphisms( cat, IsomorphismFromCoimageToCokernelOfKernel( cat, morphism ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromCokernelOfKernelToCoimage,
                    "IsomorphismFromCokernelOfKernelToCoimage using the universal property of the coimage",
                    [ [ CokernelProjection, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ ColiftAlongEpimorphism, 1 ],
                      [ UniversalMorphismIntoCoimage, 1 ] ],
                    
  function( cat, morphism )
    local cokernel_proj, morphism_from_cokernel;
    
    cokernel_proj := CokernelProjection( cat, KernelEmbedding( cat, morphism ) );
    
    morphism_from_cokernel := ColiftAlongEpimorphism( cat, cokernel_proj, morphism );
    
    return UniversalMorphismIntoCoimage( cat, morphism, [ cokernel_proj, morphism_from_cokernel ] );
    
end : CategoryFilter := IsAbelianCategory );

##
AddDerivationToCAP( IsomorphismFromCoimageToCokernelOfKernel,
                    "IsomorphismFromCoimageToCokernelOfKernel as the inverse of IsomorphismFromCokernelOfKernelToCoimage",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromCokernelOfKernelToCoimage, 1 ] ],
                    
  function( cat, morphism )
    
    return InverseForMorphisms( cat, IsomorphismFromCokernelOfKernelToCoimage( cat, morphism ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct,
                    "IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct using the universal property of the kernel",
                    [ [ JointPairwiseDifferencesOfMorphismsIntoDirectProduct, 1 ],
                      [ Equalizer, 1 ],
                      [ EmbeddingOfEqualizerWithGivenEqualizer, 1 ],
                      [ KernelLift, 1 ] ],
                    
  function( cat, A, diagram )
    local joint_pairwise_differences, equalizer, equalizer_embedding;
    
    joint_pairwise_differences := JointPairwiseDifferencesOfMorphismsIntoDirectProduct( cat, A, diagram );
    
    equalizer := Equalizer( cat, A, diagram );
    
    equalizer_embedding := EmbeddingOfEqualizerWithGivenEqualizer( cat, A, diagram, equalizer );
    
    return KernelLift( cat, joint_pairwise_differences, equalizer, equalizer_embedding );
    
end );

##
AddDerivationToCAP( IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer,
                    "IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer using the universal property of the equalizer",
                    [ [ JointPairwiseDifferencesOfMorphismsIntoDirectProduct, 1 ],
                      [ KernelObject, 1 ],
                      [ KernelEmbeddingWithGivenKernelObject, 1 ],
                      [ UniversalMorphismIntoEqualizer, 1 ] ],
                    
  function( cat, A, diagram )
    local joint_pairwise_differences, kernel_object, kernel_embedding;
    
    joint_pairwise_differences := JointPairwiseDifferencesOfMorphismsIntoDirectProduct( cat, A, diagram );
    
    kernel_object := KernelObject( cat, joint_pairwise_differences );
    
    kernel_embedding := KernelEmbeddingWithGivenKernelObject( cat, joint_pairwise_differences, kernel_object );
    
    return UniversalMorphismIntoEqualizer( cat, A, diagram, kernel_object, kernel_embedding );
    
end );

##
AddDerivationToCAP( IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct,
                    "IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct using the universal property of the coequalizer",
                    [ [ JointPairwiseDifferencesOfMorphismsFromCoproduct, 1 ],
                      [ CokernelObject, 1 ],
                      [ CokernelProjectionWithGivenCokernelObject, 1 ],
                      [ UniversalMorphismFromCoequalizer, 1 ] ],
                    
  function( cat, A, diagram )
    local joint_pairwise_differences, cokernel_object, cokernel_proj;
    
    joint_pairwise_differences := JointPairwiseDifferencesOfMorphismsFromCoproduct( cat, A, diagram );
    
    cokernel_object := CokernelObject( cat, joint_pairwise_differences );
    
    cokernel_proj := CokernelProjectionWithGivenCokernelObject( cat, joint_pairwise_differences, cokernel_object );
    
    return UniversalMorphismFromCoequalizer( cat, A, diagram, cokernel_object, cokernel_proj );
    
end );

##
AddDerivationToCAP( IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer,
                    "IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer using the universal property of the cokernel",
                    [ [ JointPairwiseDifferencesOfMorphismsFromCoproduct, 1 ],
                      [ Coequalizer, 1 ],
                      [ ProjectionOntoCoequalizerWithGivenCoequalizer, 1 ],
                      [ CokernelColift, 1 ] ],
                    
  function( cat, A, diagram )
    local joint_pairwise_differences, coequalizer, coequalizer_projection;
    
    joint_pairwise_differences := JointPairwiseDifferencesOfMorphismsFromCoproduct( cat, A, diagram );
    
    coequalizer := Coequalizer( cat, A, diagram );
    
    coequalizer_projection := ProjectionOntoCoequalizerWithGivenCoequalizer( cat, A, diagram, coequalizer );
    
    return CokernelColift( cat, joint_pairwise_differences, coequalizer, coequalizer_projection );
    
end );

##
AddDerivationToCAP( IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram,
                    "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram using the universal property of the equalizer",
                    [ [ DirectProduct, 1 ],
                      [ PreCompose, 2 ],
                      [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 2 ],
                      [ ProjectionInFactorOfFiberProductWithGivenFiberProduct, 2 ],
                      [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 1 ],
                      [ FiberProduct, 1 ],
                      [ UniversalMorphismIntoEqualizer, 1 ] ],
                    
  function( cat, diagram )
    local sources_of_diagram, direct_product, direct_product_diagram, fiber_product, test_source, fiber_product_embedding;
    
    sources_of_diagram := List( diagram, Source );
    
    direct_product := DirectProduct( cat, sources_of_diagram );
    
    direct_product_diagram := List( [ 1.. Length( sources_of_diagram ) ],
                                    i -> PreCompose( cat, ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, sources_of_diagram, i, direct_product ), diagram[ i ] ) );
    
    fiber_product := FiberProduct( cat, diagram );
    
    test_source := List( [ 1 .. Length( diagram ) ], i -> ProjectionInFactorOfFiberProductWithGivenFiberProduct( cat, diagram, i, fiber_product ) );
    
    fiber_product_embedding := UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, sources_of_diagram, fiber_product, test_source, direct_product );
    
    return UniversalMorphismIntoEqualizer( cat, direct_product, direct_product_diagram, fiber_product, fiber_product_embedding );
    
end );

##
AddDerivationToCAP( IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram,
                    "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram as the inverse of IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
                    [ [ IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct, 1 ],
                      [ InverseForMorphisms, 1 ] ],
                    
  function( cat, diagram )
    
    return InverseForMorphisms( cat, IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct( cat, diagram ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct,
                    "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct using the universal property of the fiber product",
                    [ [ PreCompose, 4 ],
                      [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 2 ],
                      [ DirectProduct, 1 ],
                      [ Equalizer, 1 ],
                      [ EmbeddingOfEqualizerWithGivenEqualizer, 1 ],
                      [ UniversalMorphismIntoFiberProduct, 1 ] ],
                    
  function( cat, diagram )
    local sources_of_diagram, direct_product, direct_product_diagram, equalizer, equalizer_embedding, equalizer_of_direct_product_diagram;
    
    sources_of_diagram := List( diagram, Source );
    
    direct_product := DirectProduct( cat, sources_of_diagram );
    
    direct_product_diagram := List( [ 1.. Length( sources_of_diagram ) ],
                                    i -> PreCompose( cat, ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, sources_of_diagram, i, direct_product ), diagram[ i ] ) );
    
    equalizer := Equalizer( cat, direct_product, direct_product_diagram );
    
    equalizer_embedding := EmbeddingOfEqualizerWithGivenEqualizer( cat, direct_product, direct_product_diagram, equalizer );
    
    equalizer_of_direct_product_diagram := List( [ 1 .. Length( direct_product_diagram ) ], i -> PreCompose( cat, equalizer_embedding, direct_product_diagram[ i ] ) );
    
    return UniversalMorphismIntoFiberProduct( cat, diagram, equalizer, equalizer_of_direct_product_diagram );
    
end );

##
AddDerivationToCAP( IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct,
                    "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct as the inverse of IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
                    [ [ IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram, 1 ],
                      [ InverseForMorphisms, 1 ] ],
                    
  function( cat, diagram )
    
    return InverseForMorphisms( cat, IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram( cat, diagram ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromPushoutToCoequalizerOfCoproductDiagram,
                    "IsomorphismFromPushoutToCoequalizerOfCoproductDiagram using the universal property of the pushout",
                    [ [ Coproduct, 1 ],
                      [ PreCompose, 4 ],
                      [ InjectionOfCofactorOfCoproductWithGivenCoproduct, 2 ],
                      [ Coequalizer, 1 ],
                      [ ProjectionOntoCoequalizerWithGivenCoequalizer, 1 ],
                      [ UniversalMorphismFromPushout, 1 ] ],
                    
  function( cat, diagram )
    local ranges_of_diagram, coproduct, coproduct_diagram, coequalizer, coequalizer_projection, coequalizer_of_coproduct_diagram;
    
    ranges_of_diagram := List( diagram, Range );
    
    coproduct := Coproduct( cat, ranges_of_diagram );
    
    coproduct_diagram := List( [ 1 .. Length( ranges_of_diagram ) ],
                               i -> PreCompose( cat, diagram[ i ], InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, ranges_of_diagram, i, coproduct ) ) );
    
    coequalizer := Coequalizer( cat, coproduct, coproduct_diagram );
    
    coequalizer_projection := ProjectionOntoCoequalizerWithGivenCoequalizer( cat, coproduct, coproduct_diagram, coequalizer );
    
    coequalizer_of_coproduct_diagram := List( [ 1 .. Length( coproduct_diagram ) ], i -> PreCompose( cat, coproduct_diagram[ i ], coequalizer_projection ) );
    
    return UniversalMorphismFromPushout( cat, diagram, coequalizer, coequalizer_of_coproduct_diagram );
    
end );

##
AddDerivationToCAP( IsomorphismFromPushoutToCoequalizerOfCoproductDiagram,
                    "IsomorphismFromPushoutToCoequalizerOfCoproductDiagram as the inverse of IsomorphismFromCoequalizerOfCoproductDiagramToPushout",
                    [ [ IsomorphismFromCoequalizerOfCoproductDiagramToPushout, 1 ],
                      [ InverseForMorphisms, 1 ] ],
                    
  function( cat, diagram )
    
    return InverseForMorphisms( cat, IsomorphismFromCoequalizerOfCoproductDiagramToPushout( cat, diagram ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromCoequalizerOfCoproductDiagramToPushout,
                    "IsomorphismFromCoequalizerOfCoproductDiagramToPushout using the universal property of the coequalizer",
                    [ [ Coproduct, 1 ],
                      [ PreCompose, 2 ],
                      [ InjectionOfCofactorOfCoproductWithGivenCoproduct, 2 ],
                      [ InjectionOfCofactorOfPushoutWithGivenPushout, 2 ],
                      [ UniversalMorphismFromCoproductWithGivenCoproduct, 1 ],
                      [ Pushout, 1 ],
                      [ UniversalMorphismFromCoequalizer, 1 ] ],
                    
  function( cat, diagram )
    local ranges_of_diagram, coproduct, coproduct_diagram, pushout, test_sink, pushout_injection;
    
    ranges_of_diagram := List( diagram, Range );
    
    coproduct := Coproduct( cat, ranges_of_diagram );
    
    coproduct_diagram := List( [ 1 .. Length( ranges_of_diagram ) ],
                               i -> PreCompose( cat, diagram[ i ], InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, ranges_of_diagram, i, coproduct ) ) );
    
    pushout := Pushout( cat, diagram );
    
    test_sink := List( [ 1 .. Length( diagram ) ], i -> InjectionOfCofactorOfPushoutWithGivenPushout( cat, diagram, i, pushout ) );
    
    pushout_injection := UniversalMorphismFromCoproductWithGivenCoproduct( cat, ranges_of_diagram, pushout, test_sink, coproduct );
    
    return UniversalMorphismFromCoequalizer( cat, coproduct, coproduct_diagram, pushout, pushout_injection );
    
end );

##
AddDerivationToCAP( IsomorphismFromCoequalizerOfCoproductDiagramToPushout,
                    "IsomorphismFromCoequalizerOfCoproductDiagramToPushout as the inverse of IsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
                    [ [ IsomorphismFromPushoutToCoequalizerOfCoproductDiagram, 1 ],
                      [ InverseForMorphisms, 1 ] ],
                    
  function( cat, diagram )
    
    return InverseForMorphisms( cat, IsomorphismFromPushoutToCoequalizerOfCoproductDiagram( cat, diagram ) );
    
end );

##
AddDerivationToCAP( ColiftAlongEpimorphism,
                    "ColiftAlongEpimorphism by inverting the cokernel colift from the cokernel of the kernel to the range of a given epimorphism",
                    [ [ KernelEmbedding, 1 ],
                      [ CokernelColift, 2 ],
                      [ PreCompose, 1 ],
                      [ InverseForMorphisms, 1 ] ],
                    
  function( cat, epimorphism, test_morphism )
    local kernel_emb, cokernel_colift_to_range_of_epimorphism, cokernel_colift_to_range_of_test_morphism;
    
    kernel_emb := KernelEmbedding( cat, epimorphism );
    
    cokernel_colift_to_range_of_epimorphism :=
      CokernelColift( cat, kernel_emb, epimorphism );
      
    cokernel_colift_to_range_of_test_morphism :=
      CokernelColift( cat, kernel_emb, test_morphism );
    
    return PreCompose( cat, InverseForMorphisms( cat, cokernel_colift_to_range_of_epimorphism ), cokernel_colift_to_range_of_test_morphism );
    
end : CategoryFilter := IsAbelianCategory );

##
AddDerivationToCAP( LiftAlongMonomorphism,
                    "LiftAlongMonomorphism by inverting the kernel lift from the source to the kernel of the cokernel of a given monomorphism",
                    [ [ CokernelProjection, 1 ],
                      [ KernelLift, 2 ],
                      [ PreCompose, 1 ],
                      [ InverseForMorphisms, 1 ] ],
                    
  function( cat, monomorphism, test_morphism )
    local cokernel_proj, kernel_lift_from_source_of_monomorphism, kernel_lift_from_source_of_test_morphism;
    
    cokernel_proj := CokernelProjection( cat, monomorphism );
    
    kernel_lift_from_source_of_monomorphism :=
      KernelLift( cat, cokernel_proj, monomorphism );
      
    kernel_lift_from_source_of_test_morphism :=
      KernelLift( cat, cokernel_proj, test_morphism );
    
    return PreCompose( cat, kernel_lift_from_source_of_test_morphism, InverseForMorphisms( cat, kernel_lift_from_source_of_monomorphism ) );
    
end : CategoryFilter := IsAbelianCategory );

##
AddDerivationToCAP( ComponentOfMorphismIntoDirectProduct,
                    "ComponentOfMorphismIntoDirectProduct by composing with the direct product projection",
                    [ [ ProjectionInFactorOfDirectProduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, factors, nr )
    
    return PreCompose( cat, alpha, ProjectionInFactorOfDirectProduct( cat, factors, nr ) );
    
end );

##
AddDerivationToCAP( ComponentOfMorphismFromCoproduct,
                    "ComponentOfMorphismFromCoproduct by composing with the coproduct injection",
                    [ [ InjectionOfCofactorOfCoproduct, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, cofactors, nr )
    
    return PreCompose( cat, InjectionOfCofactorOfCoproduct( cat, cofactors, nr ), alpha );
    
end );

##
AddDerivationToCAP( ComponentOfMorphismIntoDirectSum,
                    "ComponentOfMorphismIntoDirectSum by composing with the direct sum projection",
                    [ [ ProjectionInFactorOfDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, summands, nr )
    
    return PreCompose( cat, alpha, ProjectionInFactorOfDirectSum( cat, summands, nr ) );
    
end );

##
AddDerivationToCAP( ComponentOfMorphismFromDirectSum,
                    "ComponentOfMorphismFromDirectSum by composing with the direct sum injection",
                    [ [ InjectionOfCofactorOfDirectSum, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, summands, nr )
    
    return PreCompose( cat, InjectionOfCofactorOfDirectSum( cat, summands, nr ), alpha );
    
end );

##
AddDerivationToCAP( MorphismBetweenDirectSumsWithGivenDirectSums,
                    "MorphismBetweenDirectSumsWithGivenDirectSums using universal morphisms of direct sums (without support for empty limits)",
                    [ [ ZeroMorphism, 1 ],
                      [ UniversalMorphismIntoDirectSumWithGivenDirectSum, 2 ],
                      [ UniversalMorphismFromDirectSumWithGivenDirectSum, 1 ] ],
                    
  function( cat, S, diagram_S, morphism_matrix, diagram_T, T )
    local test_diagram_product, test_diagram_coproduct;
    
    if morphism_matrix = [ ] or morphism_matrix[1] = [ ] then
        return ZeroMorphism( cat, S, T );
    fi;
    
    test_diagram_coproduct := ListN( diagram_S, morphism_matrix,
        { source, row } -> UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, diagram_T, source, row, T )
    );
    
    return UniversalMorphismFromDirectSumWithGivenDirectSum( cat, diagram_S, T, test_diagram_coproduct, S );
    
end : CategoryFilter := cat -> not ( IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true ) );

##
AddDerivationToCAP( MorphismBetweenDirectSumsWithGivenDirectSums,
                    "MorphismBetweenDirectSumsWithGivenDirectSums using universal morphisms of direct sums (with support for empty limits)",
                    [ [ UniversalMorphismIntoDirectSumWithGivenDirectSum, 2 ],
                      [ UniversalMorphismFromDirectSumWithGivenDirectSum, 1 ] ],
                    
  function( cat, S, diagram_S, morphism_matrix, diagram_T, T )
    local test_diagram_product, test_diagram_coproduct;
    
    test_diagram_coproduct := ListN( diagram_S, morphism_matrix,
        { source, row } -> UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, diagram_T, source, row, T )
    );
    
    return UniversalMorphismFromDirectSumWithGivenDirectSum( cat, diagram_S, T, test_diagram_coproduct, S );
    
end : CategoryFilter := cat -> IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true );

##
AddDerivationToCAP( HomologyObjectFunctorialWithGivenHomologyObjects,
                    "HomologyObjectFunctorialWithGivenHomologyObjects using functoriality of (co)kernels and images in abelian categories",
                    [ [ ImageEmbedding, 2 ],
                      [ PreCompose, 5 ],
                      [ KernelEmbedding, 2 ],
                      [ CokernelProjection, 2 ],
                      [ CokernelObjectFunctorial, 1 ],
                      [ LiftAlongMonomorphism, 1 ],
                      [ IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject, 1 ],
                      [ IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject, 1 ] ],
                    
  function( cat, homology_source, mor_list, homology_range )
    local alpha, beta, epsilon, gamma, delta, image_emb_source, image_emb_range, cok_functorial, functorial_mor;
    
    alpha := mor_list[1];
    
    beta := mor_list[2];
    
    epsilon := mor_list[3];
    
    gamma := mor_list[4];
    
    delta := mor_list[5];
    
    image_emb_source := ImageEmbedding( cat,
      PreCompose( cat, KernelEmbedding( cat, beta ), CokernelProjection( cat, alpha ) )
    );
    
    image_emb_range := ImageEmbedding( cat,
      PreCompose( cat, KernelEmbedding( cat, delta ), CokernelProjection( cat, gamma ) )
    );
    
    cok_functorial := CokernelObjectFunctorial( cat, alpha, epsilon, gamma );
    
    functorial_mor :=
      LiftAlongMonomorphism( cat,
        image_emb_range, PreCompose( cat, image_emb_source, cok_functorial )
      );
    
    return PreCompose( cat,
        IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( cat, alpha, beta ),
        PreCompose( cat,
            functorial_mor,
            IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject( cat, gamma, delta )
        )
    );
    
end : CategoryFilter := IsAbelianCategory );


###########################
##
## Methods returning a morphism with source or range constructed within the method!
## If there is a method available which only constructs this source or range,
## one has to be sure that this source is equal to that construction (by IsEqualForObjects)
##
###########################

##
AddDerivationToCAP( ZeroObjectFunctorial,
                    "ZeroObjectFunctorial using ZeroMorphism",
                    [ [ ZeroObject, 1 ],
                      [ ZeroMorphism, 1 ] ],
                    
  function( cat )
    local zero_object;
    
    zero_object := ZeroObject( cat );
    
    return ZeroMorphism( cat, zero_object, zero_object );
    
end );

##
AddDerivationToCAP( JointPairwiseDifferencesOfMorphismsIntoDirectProduct,
                    "JointPairwiseDifferencesOfMorphismsIntoDirectProduct using the operations defining this morphism (without support for empty limits)",
                    [ [ UniversalMorphismIntoTerminalObject, 1 ],
                      [ UniversalMorphismIntoDirectProduct, 2 ],
                      [ SubtractionForMorphisms, 1 ] ],
                    
  function( cat, A, diagram )
    local number_of_morphisms, ranges, mor1, mor2;
    
    number_of_morphisms := Length( diagram );
    
    if number_of_morphisms = 1 then
        
        return UniversalMorphismIntoTerminalObject( cat, A );
        
    fi;
    
    ranges := List( diagram, Range );
    
    mor1 := UniversalMorphismIntoDirectProduct( cat, ranges{[ 1 .. number_of_morphisms - 1 ]}, A, diagram{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := UniversalMorphismIntoDirectProduct( cat, ranges{[ 2 .. number_of_morphisms ]}, A, diagram{[ 2 .. number_of_morphisms ]} );
    
    return SubtractionForMorphisms( cat, mor1, mor2 );
    
end : CategoryFilter := cat -> not ( IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true ) );

##
AddDerivationToCAP( JointPairwiseDifferencesOfMorphismsIntoDirectProduct,
                    "JointPairwiseDifferencesOfMorphismsIntoDirectProduct using the operations defining this morphism (with support for empty limits)",
                    [ [ UniversalMorphismIntoDirectProduct, 2 ],
                      [ SubtractionForMorphisms, 1 ] ],
                    
  function( cat, A, diagram )
    local number_of_morphisms, ranges, mor1, mor2;
    
    number_of_morphisms := Length( diagram );
    
    ranges := List( diagram, Range );
    
    mor1 := UniversalMorphismIntoDirectProduct( cat, ranges{[ 1 .. number_of_morphisms - 1 ]}, A, diagram{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := UniversalMorphismIntoDirectProduct( cat, ranges{[ 2 .. number_of_morphisms ]}, A, diagram{[ 2 .. number_of_morphisms ]} );
    
    return SubtractionForMorphisms( cat, mor1, mor2 );
    
end : CategoryFilter := cat -> IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true );

##
AddDerivationToCAP( JointPairwiseDifferencesOfMorphismsFromCoproduct,
                    "JointPairwiseDifferencesOfMorphismsFromCoproduct using the operations defining this morphism (without support for empty limits)",
                    [ [ UniversalMorphismFromInitialObject, 1 ],
                      [ UniversalMorphismFromCoproduct, 2 ],
                      [ SubtractionForMorphisms, 1 ] ],
                    
  function( cat, A, diagram )
    local number_of_morphisms, sources, mor1, mor2;
    
    number_of_morphisms := Length( diagram );
 
    if number_of_morphisms = 1 then
        
        return UniversalMorphismFromInitialObject( cat, A );
        
    fi;
    
    sources := List( diagram, Source );
    
    mor1 := UniversalMorphismFromCoproduct( cat, sources{[ 1 .. number_of_morphisms - 1 ]}, A, diagram{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := UniversalMorphismFromCoproduct( cat, sources{[ 2 .. number_of_morphisms ]}, A, diagram{[ 2 .. number_of_morphisms ]} );
    
    return SubtractionForMorphisms( cat, mor1, mor2 );
    
end : CategoryFilter := cat -> not ( IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true ) );

##
AddDerivationToCAP( JointPairwiseDifferencesOfMorphismsFromCoproduct,
                    "JointPairwiseDifferencesOfMorphismsFromCoproduct using the operations defining this morphism (with support for empty limits)",
                    [ [ UniversalMorphismFromCoproduct, 2 ],
                      [ SubtractionForMorphisms, 1 ] ],
                    
  function( cat, A, diagram )
    local number_of_morphisms, sources, mor1, mor2;
    
    number_of_morphisms := Length( diagram );
    
    sources := List( diagram, Source );
    
    mor1 := UniversalMorphismFromCoproduct( cat, sources{[ 1 .. number_of_morphisms - 1 ]}, A, diagram{[ 1 .. number_of_morphisms - 1 ]} );
    
    mor2 := UniversalMorphismFromCoproduct( cat, sources{[ 2 .. number_of_morphisms ]}, A, diagram{[ 2 .. number_of_morphisms ]} );
    
    return SubtractionForMorphisms( cat, mor1, mor2 );
    
end : CategoryFilter := cat -> IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true );

##
AddDerivationToCAP( EmbeddingOfEqualizer,
                    "EmbeddingOfEqualizer using the kernel embedding of JointPairwiseDifferencesOfMorphismsIntoDirectProduct",
                    [ [ KernelEmbedding, 1 ],
                      [ JointPairwiseDifferencesOfMorphismsIntoDirectProduct, 1 ],
                      [ PreCompose, 1 ],
                      [ IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct, 1 ] ],
                    
  function( cat, A, diagram )
    local kernel_of_pairwise_differences;
    
    kernel_of_pairwise_differences := KernelEmbedding( cat, JointPairwiseDifferencesOfMorphismsIntoDirectProduct( cat, A, diagram ) );
    
    return PreCompose( cat, IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct( cat, A, diagram ),
                       kernel_of_pairwise_differences );
    
end );

##
AddDerivationToCAP( ProjectionOntoCoequalizer,
                    "ProjectionOntoCoequalizer using the cokernel projection of JointPairwiseDifferencesOfMorphismsFromCoproduct",
                    [ [ CokernelProjection, 1 ],
                      [ JointPairwiseDifferencesOfMorphismsFromCoproduct, 1 ],
                      [ PreCompose, 1 ],
                      [ IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer, 1 ] ],
                    
  function( cat, A, diagram )
    local cokernel_proj_of_pairwise_differences;
    
    cokernel_proj_of_pairwise_differences := CokernelProjection( cat, JointPairwiseDifferencesOfMorphismsFromCoproduct( cat, A, diagram ) );
    
    return PreCompose( cat, cokernel_proj_of_pairwise_differences,
                       IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer( cat, A, diagram ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromInitialObjectToZeroObject,
                    "IsomorphismFromInitialObjectToZeroObject as the unique morphism from initial object to zero object",
                    [ [ UniversalMorphismFromInitialObject, 1 ],
                      [ ZeroObject, 1 ] ],
                    
  function( cat )
    
    return UniversalMorphismFromInitialObject( cat, ZeroObject( cat ) );
    
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( IsomorphismFromInitialObjectToZeroObject,
                    "IsomorphismFromInitialObjectToZeroObject using the universal property of the zero object",
                    [ [ UniversalMorphismIntoZeroObject, 1 ],
                      [ InitialObject, 1 ] ],
                    
  function( cat )
    
    return UniversalMorphismIntoZeroObject( cat, InitialObject( cat ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromInitialObjectToZeroObject,
                    "IsomorphismFromInitialObjectToZeroObject as the inverse of IsomorphismFromZeroObjectToInitialObject",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromZeroObjectToInitialObject, 1 ] ],
                    
  function( cat )
    
    return InverseForMorphisms( cat, IsomorphismFromZeroObjectToInitialObject( cat ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToInitialObject,
                    "IsomorphismFromZeroObjectToInitialObject as the inverse of IsomorphismFromInitialObjectToZeroObject",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromInitialObjectToZeroObject, 1 ] ],
                    
  function( cat )
    
    return InverseForMorphisms( cat, IsomorphismFromInitialObjectToZeroObject( cat ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToInitialObject,
                    "IsomorphismFromZeroObjectToInitialObject using the universal property of the zero object",
                    [ [ UniversalMorphismFromZeroObject, 1 ],
                      [ InitialObject, 1 ] ],
                    
  function( cat )
    
    return UniversalMorphismFromZeroObject( cat, InitialObject( cat ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToTerminalObject,
                    "IsomorphismFromZeroObjectToTerminalObject as the unique morphism from zero object to terminal object",
                    [ [ UniversalMorphismIntoTerminalObject, 1 ],
                      [ ZeroObject, 1 ] ],
                    
  function( cat )
    
    return UniversalMorphismIntoTerminalObject( cat, ZeroObject( cat ) );
    
end : CategoryFilter := IsAdditiveCategory );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToTerminalObject,
                    "IsomorphismFromZeroObjectToTerminalObject using the universal property of the zero object",
                    [ [ UniversalMorphismFromZeroObject, 1 ],
                      [ TerminalObject, 1 ] ],
                    
  function( cat )
    
    return UniversalMorphismFromZeroObject( cat, TerminalObject( cat ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromTerminalObjectToZeroObject,
                    "IsomorphismFromTerminalObjectToZeroObject as the inverse of IsomorphismFromZeroObjectToTerminalObject",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromZeroObjectToTerminalObject, 1 ] ],
                    
  function( cat )
    
    return InverseForMorphisms( cat, IsomorphismFromZeroObjectToTerminalObject( cat ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromTerminalObjectToZeroObject,
                    "IsomorphismFromTerminalObjectToZeroObject using the universal property of the zero object",
                    [ [ UniversalMorphismIntoZeroObject, 1 ],
                      [ TerminalObject, 1 ] ],
                    
  function( cat )
    
    return UniversalMorphismIntoZeroObject( cat, TerminalObject( cat ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromZeroObjectToTerminalObject,
                    "IsomorphismFromZeroObjectToTerminalObject as the inverse of IsomorphismFromTerminalObjectToZeroObject",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromTerminalObjectToZeroObject, 1 ] ],
                    
  function( cat )
    
    return InverseForMorphisms( cat, IsomorphismFromTerminalObjectToZeroObject( cat ) );
    
end );


##
AddDerivationToCAP( IsomorphismFromDirectProductToDirectSum,
                    "IsomorphismFromDirectProductToDirectSum using direct product projections and universal property of direct sum",
                    [ [ ProjectionInFactorOfDirectProduct, 2 ],
                      [ DirectProduct, 1 ],
                      [ UniversalMorphismIntoDirectSum, 1 ] ],
                    
  function( cat, diagram )
    local source;
    
    source := List( [ 1 .. Length( diagram ) ], i -> ProjectionInFactorOfDirectProduct( cat, diagram, i ) );
    
    return UniversalMorphismIntoDirectSum( cat, diagram, DirectProduct( cat, diagram ), source );
    
end );

##
AddDerivationToCAP( IsomorphismFromDirectProductToDirectSum,
                    "IsomorphismFromDirectProductToDirectSum as the inverse of IsomorphismFromDirectSumToDirectProduct",
                    [ [ IsomorphismFromDirectSumToDirectProduct, 1 ],
                      [ InverseForMorphisms, 1 ] ],
                    
  function( cat, diagram )
    
    return InverseForMorphisms( cat, IsomorphismFromDirectSumToDirectProduct( cat, diagram ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromDirectSumToDirectProduct,
                    "IsomorphismFromDirectSumToDirectProduct using direct sum projections and universal property of direct product",
                    [ [ ProjectionInFactorOfDirectSum, 2 ],
                      [ DirectSum, 1 ],
                      [ UniversalMorphismIntoDirectProduct, 1 ] ],
                    
  function( cat, diagram )
    local source;
    
    source := List( [ 1 .. Length( diagram ) ], i -> ProjectionInFactorOfDirectSum( cat, diagram, i ) );
    
    return UniversalMorphismIntoDirectProduct( cat, diagram, DirectSum( cat, diagram ), source );
    
end );

##
AddDerivationToCAP( IsomorphismFromDirectSumToDirectProduct,
                    "IsomorphismFromDirectSumToDirectProduct as the inverse of IsomorphismFromDirectProductToDirectSum",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromDirectProductToDirectSum, 1 ] ],
                    
  function( cat, diagram )
    
    return InverseForMorphisms( cat, IsomorphismFromDirectProductToDirectSum( cat, diagram ) );
    
end );

##
AddDerivationToCAP( IsomorphismFromCoproductToDirectSum,
                    "IsomorphismFromCoproductToDirectSum using cofactor injections and the universal property of the coproduct",
                    [ [ InjectionOfCofactorOfDirectSum, 2 ],
                      [ DirectSum, 1 ],
                      [ UniversalMorphismFromCoproduct, 1 ] ],
                    
  function( cat, diagram )
    local sink;
    
    sink := List( [ 1 .. Length( diagram ) ], i -> InjectionOfCofactorOfDirectSum( cat, diagram, i ) );
    
    return UniversalMorphismFromCoproduct( cat, diagram, DirectSum( cat, diagram ), sink );
    
end );

##
AddDerivationToCAP( IsomorphismFromCoproductToDirectSum,
                    "IsomorphismFromCoproductToDirectSum as the inverse of IsomorphismFromDirectSumToCoproduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromDirectSumToCoproduct, 1 ] ],
                    
  function( cat, diagram )
    
    return InverseForMorphisms( cat, IsomorphismFromDirectSumToCoproduct( cat, diagram ) );
  
end );

##
AddDerivationToCAP( IsomorphismFromDirectSumToCoproduct,
                    "IsomorphismFromDirectSumToCoproduct using cofactor injections and the universal property of the direct sum",
                    [ [ InjectionOfCofactorOfCoproduct, 2 ],
                      [ Coproduct, 1 ],
                      [ UniversalMorphismFromDirectSum, 1 ] ],
                    
  function( cat, diagram )
    local sink;
    
    sink := List( [ 1 .. Length( diagram ) ], i -> InjectionOfCofactorOfCoproduct( cat, diagram, i ) );
    
    return UniversalMorphismFromDirectSum( cat, diagram, Coproduct( cat, diagram ), sink );
    
end );

##
AddDerivationToCAP( IsomorphismFromDirectSumToCoproduct,
                    "IsomorphismFromDirectSumToCoproduct as the inverse of IsomorphismFromCoproductToDirectSum",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromCoproductToDirectSum, 1 ] ],
                    
  function( cat, diagram )
    
    return InverseForMorphisms( cat, IsomorphismFromCoproductToDirectSum( cat, diagram ) );
    
end );

## B -β→ C ←α- A, ℓ•β = α ⇔ ν(ℓ)•H(A,β) = ν(α)
##
AddDerivationToCAP( Lift,
                    "Derive Lift using the homomorphism structure and Lift in the range of the homomorphism structure",
                    [ [ IdentityMorphism, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
                      [ HomomorphismStructureOnMorphisms, 1 ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
                      [ Lift, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, alpha, beta )
    local range_cat, a, b;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    a := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha );
    
    b := HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, Source( alpha ) ), beta );
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, Source( alpha ), Source( beta ), Lift( range_cat, a, b ) );
    
end : CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := cat -> HasRangeCategoryOfHomomorphismStructure( cat ) );

##
AddDerivationToCAP( LiftOrFail,
                    "Derive LiftOrFail using the homomorphism structure and LiftOrFail in the range of the homomorphism structure",
                    [ [ IdentityMorphism, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
                      [ HomomorphismStructureOnMorphisms, 1 ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
                      [ LiftOrFail, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, alpha, beta )
    local range_cat, a, b, l;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    a := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha );
    
    b := HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, Source( alpha ) ), beta );
    
    l := LiftOrFail( range_cat, a, b );
    
    if l = fail then
      
      return fail;
      
    fi;
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, Source( alpha ), Source( beta ), l );
    
end : CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := cat -> HasRangeCategoryOfHomomorphismStructure( cat ) );

##
AddDerivationToCAP( IsLiftable,
                    "Derive IsLiftable using the homomorphism structure and Liftable in the range of the homomorphism structure",
                    [ [ IdentityMorphism, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
                      [ HomomorphismStructureOnMorphisms, 1 ],
                      [ IsLiftable, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, alpha, beta )
    local range_cat, a, b;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    a := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha );
    
    b := HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, Source( alpha ) ), beta );
    
    return IsLiftable( range_cat, a, b );
    
end : CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := cat -> HasRangeCategoryOfHomomorphismStructure( cat ) );

## B ←β- C -α→ A, α•ℓ = β ⇔ ν(ℓ)•H(α,B) = ν(β)
##
AddDerivationToCAP( Colift,
                    "Derive Colift using the homomorphism structure and Lift in the range of the homomorphism structure",
                    [ [ IdentityMorphism, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
                      [ HomomorphismStructureOnMorphisms, 1 ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
                      [ Lift, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, alpha, beta )
    local range_cat, b, a;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    b := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, beta );
    
    a := HomomorphismStructureOnMorphisms( cat, alpha, IdentityMorphism( cat, Range( beta ) ) );
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, Range( alpha ), Range( beta ), Lift( range_cat, b, a ) );
    
end : CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := cat -> HasRangeCategoryOfHomomorphismStructure( cat ) );

##
AddDerivationToCAP( ColiftOrFail,
                    "Derive ColiftOrFail using the homomorphism structure and LiftOrFail in the range of the homomorphism structure",
                    [ [ IdentityMorphism, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
                      [ HomomorphismStructureOnMorphisms, 1 ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 1 ],
                      [ LiftOrFail, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, alpha, beta )
    local range_cat, b, a, l;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    b := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, beta );
    
    a := HomomorphismStructureOnMorphisms( cat, alpha, IdentityMorphism( cat, Range( beta ) ) );
    
    l := LiftOrFail( range_cat, b, a );
    
    if l = fail then
      
      return fail;
      
    fi;
    
    return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, Range( alpha ), Range( beta ), l );
    
end : CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := cat -> HasRangeCategoryOfHomomorphismStructure( cat ) );

##
AddDerivationToCAP( IsColiftable,
                    "Derive IsColiftable using the homomorphism structure and IsLiftable in the range of the homomorphism structure",
                    [ [ IdentityMorphism, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
                      [ HomomorphismStructureOnMorphisms, 1 ],
                      [ IsLiftable, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, alpha, beta )
    local range_cat, b, a;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    b := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, beta );
    
    a := HomomorphismStructureOnMorphisms( cat, alpha, IdentityMorphism( cat, Range( beta ) ) );
    
    return IsLiftable( range_cat, b, a );
    
end : CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := cat -> HasRangeCategoryOfHomomorphismStructure( cat ) );

##
AddDerivationToCAP( Lift,
                    "Lift by SolveLinearSystemInAbCategory",
                    [ [ IdentityMorphism, 1 ],
                      [ SolveLinearSystemInAbCategory, 1 ] ],
                    
  function( cat, alpha, beta )
    local left_coefficients, right_coefficients, right_side, right_divide;
    
    left_coefficients := [ [ IdentityMorphism( cat, Source( alpha ) ) ] ];
    
    right_coefficients := [ [ beta ] ];
    
    right_side := [ alpha ];
    
    right_divide := SolveLinearSystemInAbCategory( cat,
                      left_coefficients, right_coefficients, right_side );
    
    return right_divide[1];
    
end );

##
AddDerivationToCAP( LiftOrFail,
                    "LiftOrFail by SolveLinearSystemInAbCategoryOrFail",
                    [ [ IdentityMorphism, 1 ],
                      [ SolveLinearSystemInAbCategoryOrFail, 1 ] ],
                    
  function( cat, alpha, beta )
    local left_coefficients, right_coefficients, right_side, right_divide;
    
    left_coefficients := [ [ IdentityMorphism( cat, Source( alpha ) ) ] ];
    
    right_coefficients := [ [ beta ] ];
    
    right_side := [ alpha ];
    
    right_divide := SolveLinearSystemInAbCategoryOrFail( cat,
                      left_coefficients, right_coefficients, right_side );
    
    if right_divide = fail then
      
      return fail;
      
    fi;
    
    return right_divide[1];
    
end );

##
AddDerivationToCAP( IsLiftable,
                    "IsLiftable by MereExistenceOfSolutionOfLinearSystemInAbCategory",
                    [ [ IdentityMorphism, 1 ],
                      [ MereExistenceOfSolutionOfLinearSystemInAbCategory, 1 ] ],
                    
  function( cat, alpha, beta )
    local left_coefficients, right_coefficients, right_side;
    
    left_coefficients := [ [ IdentityMorphism( cat, Source( alpha ) ) ] ];
    
    right_coefficients := [ [ beta ] ];
    
    right_side := [ alpha ];
    
    return MereExistenceOfSolutionOfLinearSystemInAbCategory( cat,
                      left_coefficients, right_coefficients, right_side );
    
end );

##
AddDerivationToCAP( Colift,
                    "Colift by SolveLinearSystemInAbCategory",
                    [ [ IdentityMorphism, 1 ],
                      [ SolveLinearSystemInAbCategory, 1 ] ],
                    
  function( cat, alpha, beta )
    local left_coefficients, right_coefficients, right_side, left_divide;
    
    left_coefficients := [ [ alpha ] ];
    
    right_coefficients := [ [ IdentityMorphism( cat, Range( beta ) ) ] ];
    
    right_side := [ beta ];
    
    left_divide := SolveLinearSystemInAbCategory( cat,
                      left_coefficients, right_coefficients, right_side );
    
    return left_divide[1];
    
end );

##
AddDerivationToCAP( ColiftOrFail,
                    "ColiftOrFail by SolveLinearSystemInAbCategoryOrFail",
                    [ [ IdentityMorphism, 1 ],
                      [ SolveLinearSystemInAbCategoryOrFail, 1 ] ],
                    
  function( cat, alpha, beta )
    local left_coefficients, right_coefficients, right_side, left_divide;
    
    left_coefficients := [ [ alpha ] ];
    
    right_coefficients := [ [ IdentityMorphism( cat, Range( beta ) ) ] ];
    
    right_side := [ beta ];
    
    left_divide := SolveLinearSystemInAbCategoryOrFail( cat,
                      left_coefficients, right_coefficients, right_side );
    
    if left_divide = fail then
      
      return fail;
      
    fi;
    
    return left_divide[1];
    
end );

##
AddDerivationToCAP( IsColiftable,
                    "IsColiftable by MereExistenceOfSolutionOfLinearSystemInAbCategory",
                    [ [ IdentityMorphism, 1 ],
                      [ MereExistenceOfSolutionOfLinearSystemInAbCategory, 1 ] ],
                    
  function( cat, alpha, beta )
    local left_coefficients, right_coefficients, right_side;
    
    left_coefficients := [ [ alpha ] ];
    
    right_coefficients := [ [ IdentityMorphism( cat, Range( beta ) ) ] ];
    
    right_side := [ beta ];
    
    return MereExistenceOfSolutionOfLinearSystemInAbCategory( cat,
                      left_coefficients, right_coefficients, right_side );
    
end );

##
AddDerivationToCAP( LiftOrFail,
                    "LiftOrFail using IsLiftable and Lift",
                    [ [ IsLiftable, 1 ],
                      [ Lift, 1 ] ],
                    
  function( cat, alpha, beta )
    
    if IsLiftable( cat, alpha, beta ) then
        
        return Lift( cat, alpha, beta );
        
    else
        
        return fail;
        
    fi;
    
end );

##
AddDerivationToCAP( ColiftOrFail,
                    "ColiftOrFail using IsColiftable and Colift",
                    [ [ IsColiftable, 1 ],
                      [ Colift, 1 ] ],
                    
  function( cat, alpha, beta )
    
    if IsColiftable( cat, alpha, beta ) then
        
        return Colift( cat, alpha, beta );
        
    else
        
        return fail;
        
    fi;
    
end );

##
AddDerivationToCAP( SolveLinearSystemInAbCategoryOrFail,
                    "SolveLinearSystemInAbCategoryOrFail using MereExistenceOfSolutionOfLinearSystemInAbCategory and SolveLinearSystemInAbCategory",
                    [ [ MereExistenceOfSolutionOfLinearSystemInAbCategory, 1 ],
                      [ SolveLinearSystemInAbCategory, 1 ] ],
                    
  function( cat, left_coefficients, right_coefficients, right_side )
    
    if MereExistenceOfSolutionOfLinearSystemInAbCategory( cat, left_coefficients, right_coefficients, right_side ) then
        
        return SolveLinearSystemInAbCategory( cat, left_coefficients, right_coefficients, right_side );
        
    else
        
        return fail;
        
    fi;
    
end );

##
AddDerivationToCAP( IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject,
                    "IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject as the inverse of IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject",
                    [ [ InverseForMorphisms, 1 ],
                      [ IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return InverseForMorphisms( cat, IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( cat, alpha, beta ) );
    
end );

###########################
##
## Methods returning a nonnegative integer or infinity
##
###########################

##
AddDerivationToCAP( ProjectiveDimension,
                    "ProjectiveDimension by iteratively testing whether the syzygy object is projective",
                    [ [ IsProjective, 2 ],
                      [ KernelObject, 2 ],
                      [ EpimorphismFromSomeProjectiveObject, 2 ] ],
                    
  function( cat, obj )
    local dim, syzygy_obj;

    dim := 0;
    
    syzygy_obj := obj;

    while not IsProjective( cat, syzygy_obj ) do
      syzygy_obj := KernelObject( cat, EpimorphismFromSomeProjectiveObject( cat, syzygy_obj ) );
      dim := dim + 1;
    od;
    
    return dim;

end : CategoryFilter := cat -> HasIsLocallyOfFiniteProjectiveDimension( cat ) and IsLocallyOfFiniteProjectiveDimension( cat ) and HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) );

##
AddDerivationToCAP( InjectiveDimension,
                    "InjectiveDimension by iteratively testing whether the cosyzygy object is injective",
                    [ [ IsInjective, 2 ],
                      [ CokernelObject, 2 ],
                      [ MonomorphismIntoSomeInjectiveObject, 2 ] ],
                    
  function( cat, obj )
    local dim, cosyzygy_obj;

    dim := 0;
    
    cosyzygy_obj := obj;

    while not IsInjective( cat, cosyzygy_obj ) do
      cosyzygy_obj := CokernelObject( cat, MonomorphismIntoSomeInjectiveObject( cat, cosyzygy_obj ) );
      dim := dim + 1;
    od;
    
    return dim;

end : CategoryFilter := cat -> HasIsLocallyOfFiniteInjectiveDimension( cat ) and IsLocallyOfFiniteInjectiveDimension( cat ) and HasIsAbelianCategory( cat ) and IsAbelianCategory( cat ) );


###########################
##
## Methods returning an object
##
###########################

##
AddDerivationToCAP( KernelObject,
                    "KernelObject as the source of KernelEmbedding",
                    [ [ KernelEmbedding, 1 ] ],
                    
  function( cat, mor )
    
    return Source( KernelEmbedding( cat, mor ) );
    
end );

##
AddDerivationToCAP( CokernelObject,
                    "CokernelObject as the range of CokernelProjection",
                    [ [ CokernelProjection, 1 ] ],
                    
  function( cat, mor )
    
    return Range( CokernelProjection( cat, mor ) );
    
end );

##
AddDerivationToCAP( Coproduct,
                    "Coproduct as the range of the first injection",
                    [ [ InjectionOfCofactorOfCoproduct, 1 ] ],
                    
  function( cat, object_product_list )
    
    return Range( InjectionOfCofactorOfCoproduct( cat, object_product_list, 1 ) );
    
end : CategoryFilter := cat -> not ( IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true ) );

##
AddDerivationToCAP( DirectProduct,
                    "DirectProduct as Source of ProjectionInFactorOfDirectProduct",
                    [ [ ProjectionInFactorOfDirectProduct, 1 ] ],
                    
  function( cat, object_product_list )
    
    return Source( ProjectionInFactorOfDirectProduct( cat, object_product_list, 1 ) );
    
end : CategoryFilter := cat -> not ( IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true ) );

##
AddDerivationToCAP( DirectProduct,
                    "DirectProduct as the source of IsomorphismFromDirectProductToDirectSum",
                    [ [ IsomorphismFromDirectProductToDirectSum, 1 ] ],
                    
  function( cat, object_product_list )
    
    return Source( IsomorphismFromDirectProductToDirectSum( cat, object_product_list ) );
    
end );

##
AddDerivationToCAP( Coproduct,
                    "Coproduct as the range of IsomorphismFromDirectSumToCoproduct",
                    [ [ IsomorphismFromDirectSumToCoproduct, 1 ] ],
                    
  function( cat, object_product_list )
    
    return Range( IsomorphismFromDirectSumToCoproduct( cat, object_product_list ) );
    
end );

##
AddDerivationToCAP( TerminalObject,
                    "TerminalObject as the source of IsomorphismFromTerminalObjectToZeroObject",
                    [ [ IsomorphismFromTerminalObjectToZeroObject, 1 ] ],
                    
  function( cat )
    
    return Source( IsomorphismFromTerminalObjectToZeroObject( cat ) );
    
end );

##
AddDerivationToCAP( TerminalObject,
                    "TerminalObject as the range of IsomorphismFromZeroObjectToTerminalObject",
                    [ [ IsomorphismFromZeroObjectToTerminalObject, 1 ] ],
                    
  function( cat )
    
    return Range( IsomorphismFromZeroObjectToTerminalObject( cat ) );
    
end );

##
AddDerivationToCAP( InitialObject,
                    "InitialObject as the source of IsomorphismFromInitialObjectToZeroObject",
                    [ [ IsomorphismFromInitialObjectToZeroObject, 1 ] ],
                    
  function( cat )
    
    return Source( IsomorphismFromInitialObjectToZeroObject( cat ) );
    
end );

##
AddDerivationToCAP( InitialObject,
                    "InitialObject as the range of IsomorphismFromZeroObjectToInitialObject",
                    [ [ IsomorphismFromZeroObjectToInitialObject, 1 ] ],
                    
  function( cat )
    
    return Range( IsomorphismFromZeroObjectToInitialObject( cat ) );
    
end );


##
AddDerivationToCAP( ImageObject,
                    "ImageObject as the source of ImageEmbedding",
                    [ [ ImageEmbedding, 1 ] ],
                    
  function( cat, mor )
    
    return Source( ImageEmbedding( cat, mor ) );
    
end );

##
AddDerivationToCAP( ImageObject,
                    "ImageObject as the source of IsomorphismFromImageObjectToKernelOfCokernel",
                    [ [ IsomorphismFromImageObjectToKernelOfCokernel, 1 ] ],
                    
  function( cat, morphism )
    
    return Source( IsomorphismFromImageObjectToKernelOfCokernel( cat, morphism ) );
    
end );

##
AddDerivationToCAP( ImageObject,
                    "ImageObject as the range of IsomorphismFromKernelOfCokernelToImageObject",
                    [ [ IsomorphismFromKernelOfCokernelToImageObject, 1 ] ],
                    
  function( cat, morphism )
    
    return Range( IsomorphismFromKernelOfCokernelToImageObject( cat, morphism ) );
    
end );

##
AddDerivationToCAP( CoimageObject,
                    "CoimageObject as the range of CoimageProjection",
                    [ [ CoimageProjection, 1 ] ],
                    
  function( cat, morphism )
    
    return Range( CoimageProjection( cat, morphism ) );
    
end );

##
AddDerivationToCAP( CoimageObject,
                    "CoimageObject as the range of IsomorphismFromCokernelOfKernelToCoimage",
                    [ [ IsomorphismFromCokernelOfKernelToCoimage, 1 ] ],
                    
  function( cat, morphism )
    
    return Range( IsomorphismFromCokernelOfKernelToCoimage( cat, morphism ) );
    
end );

##
AddDerivationToCAP( CoimageObject,
                    "CoimageObject as the source of IsomorphismFromCoimageToCokernelOfKernel",
                    [ [ IsomorphismFromCoimageToCokernelOfKernel, 1 ] ],
                    
  function( cat, morphism )
    
    return Source( IsomorphismFromCoimageToCokernelOfKernel( cat, morphism ) );
    
end );

##
AddDerivationToCAP( CoimageObject,
                    "CoimageObject as the range of CanonicalIdentificationFromImageObjectToCoimage",
                    [ [ CanonicalIdentificationFromImageObjectToCoimage, 1 ] ],
                    
  function( cat, morphism )
    
    return Range( CanonicalIdentificationFromImageObjectToCoimage( cat, morphism ) );
    
end );

##
AddDerivationToCAP( CoimageObject,
                    "CoimageObject as the source of CanonicalIdentificationFromCoimageToImageObject",
                    [ [ CanonicalIdentificationFromCoimageToImageObject, 1 ] ],
                    
  function( cat, morphism )
    
    return Source( CanonicalIdentificationFromCoimageToImageObject( cat, morphism ) );
    
end );

##
AddDerivationToCAP( SomeProjectiveObject,
                    "SomeProjectiveObject as the source of EpimorphismFromSomeProjectiveObject",
                    [ [ EpimorphismFromSomeProjectiveObject, 1 ] ],
                    
  function( cat, obj )
    
    return Source( EpimorphismFromSomeProjectiveObject( cat, obj ) );
    
end );

##
AddDerivationToCAP( SomeInjectiveObject,
                    "SomeInjectiveObject as the range of MonomorphismIntoSomeInjectiveObject",
                    [ [ MonomorphismIntoSomeInjectiveObject, 1 ] ],
                    
  function( cat, obj )
    
    return Range( MonomorphismIntoSomeInjectiveObject( cat, obj ) );
    
end );

##
AddDerivationToCAP( Equalizer,
                    "Equalizer as the source of EmbeddingOfEqualizer",
                    [ [ EmbeddingOfEqualizer, 1 ] ],
                    
  function( cat, A, diagram )
    
    return Source( EmbeddingOfEqualizer( cat, A, diagram ) );
    
end );

##
AddDerivationToCAP( Coequalizer,
                    "Coequalizer as the range of ProjectionOntoCoequalizer",
                    [ [ ProjectionOntoCoequalizer, 1 ] ],
                    
  function( cat, A, diagram )
    
    return Range( ProjectionOntoCoequalizer( cat, A, diagram ) );
    
end );

##
AddDerivationToCAP( HomologyObject,
                    "HomologyObject as the source of IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject",
                    [ [ IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Source( IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( cat, alpha, beta ) );
    
end );

###########################
##
## Methods returning a twocell
##
###########################

##
AddDerivationToCAP( HorizontalPostCompose,
                    "HorizontalPostCompose using HorizontalPreCompose",
                    [ [ HorizontalPreCompose, 1 ] ],
                    
  function( cat, twocell_right, twocell_left )
    
    return HorizontalPreCompose( cat, twocell_left, twocell_right );
    
end );

##
AddDerivationToCAP( HorizontalPreCompose,
                    "HorizontalPreCompose using HorizontalPostCompose",
                    [ [ HorizontalPostCompose, 1 ] ],
                    
  function( cat, twocell_left, twocell_right )
    
    return HorizontalPostCompose( cat, twocell_right, twocell_left );
    
end );

##
AddDerivationToCAP( VerticalPostCompose,
                    "VerticalPostCompose using VerticalPreCompose",
                    [ [ VerticalPreCompose, 1 ] ],
                    
  function( cat, twocell_below, twocell_above )
    
    return VerticalPreCompose( cat, twocell_above, twocell_below );
    
end );

##
AddDerivationToCAP( VerticalPreCompose,
                    "VerticalPreCompose using VerticalPostCompose",
                    [ [ VerticalPostCompose, 1 ] ],
                    
  function( cat, twocell_above, twocell_below )
    
    return VerticalPostCompose( cat, twocell_below, twocell_above );
    
end );

###########################
##
## Methods involving homomorphism structures
##
###########################

##
AddDerivationToCAP( SolveLinearSystemInAbCategory,
                    "SolveLinearSystemInAbCategory using the homomorphism structure",
                    [ [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 2 ],
                      [ HomomorphismStructureOnMorphismsWithGivenObjects, 4 ],
                      [ HomomorphismStructureOnObjects, 6 ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 2 ],
                      [ UniversalMorphismIntoDirectSum, 1, RangeCategoryOfHomomorphismStructure ],
                      [ MorphismBetweenDirectSums, 1, RangeCategoryOfHomomorphismStructure ],
                      [ Lift, 1, RangeCategoryOfHomomorphismStructure ],
                      [ ComponentOfMorphismIntoDirectSum, 2, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, left_coefficients, right_coefficients, right_side )
    local range_cat, m, n, distinguished_object, interpretations, nu, H_B_C, H_A_D, list, H, lift, summands;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    m := Length( left_coefficients );
    
    n := Length( left_coefficients[1] );
    
    ## create lift diagram
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    interpretations := List( [ 1 .. m ], i -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, right_side[i] ) );
    
    nu := UniversalMorphismIntoDirectSum( range_cat,
        List( interpretations, mor -> Range( mor ) ),
        distinguished_object,
        interpretations
    );
    
    # left_coefficients[i][j] : A_i -> B_j
    # right_coefficients[i][j] : C_j -> D_i
    
    H_B_C := List( [ 1 .. n ], j -> HomomorphismStructureOnObjects( cat, Range( left_coefficients[1][j] ), Source( right_coefficients[1][j] ) ) );
    
    H_A_D := List( [ 1 .. m ], i -> HomomorphismStructureOnObjects( cat, Source( left_coefficients[i][1] ), Range( right_coefficients[i][1] ) ) );
    
    list :=
      List( [ 1 .. n ],
      j -> List( [ 1 .. m ], i -> HomomorphismStructureOnMorphismsWithGivenObjects( cat, H_B_C[j], left_coefficients[i][j], right_coefficients[i][j], H_A_D[i] ) ) 
    );
    
    H := MorphismBetweenDirectSums( range_cat, H_B_C, list, H_A_D );
    
    ## the actual computation of the solution
    lift := Lift( range_cat, nu, H );
    
    ## reinterpretation of the solution
    summands := List( [ 1 .. n ], j -> HomomorphismStructureOnObjects( cat, Range( left_coefficients[1][j] ), Source( right_coefficients[1][j] ) ) );
    
    return
      List( [ 1 .. n ], j -> 
        InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
          Range( left_coefficients[1][j] ),
          Source( right_coefficients[1][j] ),
          ComponentOfMorphismIntoDirectSum( range_cat, lift, summands, j )
        )
      );
  end :
  CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
  CategoryFilter := cat -> HasIsAbCategory( cat ) and IsAbCategory( cat ) and HasRangeCategoryOfHomomorphismStructure( cat )
);

##
AddDerivationToCAP( SolveLinearSystemInAbCategoryOrFail,
                    "SolveLinearSystemInAbCategoryOrFail using the homomorphism structure",
                    [ [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 2 ],
                      [ HomomorphismStructureOnMorphismsWithGivenObjects, 4 ],
                      [ HomomorphismStructureOnObjects, 6 ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 2 ],
                      [ UniversalMorphismIntoDirectSum, 1, RangeCategoryOfHomomorphismStructure ],
                      [ MorphismBetweenDirectSums, 1, RangeCategoryOfHomomorphismStructure ],
                      [ LiftOrFail, 1, RangeCategoryOfHomomorphismStructure ],
                      [ ComponentOfMorphismIntoDirectSum, 2, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, left_coefficients, right_coefficients, right_side )
    local range_cat, m, n, distinguished_object, interpretations, nu, H_B_C, H_A_D, list, H, lift, summands;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    m := Length( left_coefficients );
    
    n := Length( left_coefficients[1] );
    
    ## create lift diagram
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    interpretations := List( [ 1 .. m ], i -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, right_side[i] ) );
    
    nu := UniversalMorphismIntoDirectSum( range_cat,
        List( interpretations, mor -> Range( mor ) ),
        distinguished_object,
        interpretations
    );
    
    # left_coefficients[i][j] : A_i -> B_j
    # right_coefficients[i][j] : C_j -> D_i
    
    H_B_C := List( [ 1 .. n ], j -> HomomorphismStructureOnObjects( cat, Range( left_coefficients[1][j] ), Source( right_coefficients[1][j] ) ) );
    
    H_A_D := List( [ 1 .. m ], i -> HomomorphismStructureOnObjects( cat, Source( left_coefficients[i][1] ), Range( right_coefficients[i][1] ) ) );
    
    list :=
      List( [ 1 .. n ],
      j -> List( [ 1 .. m ], i -> HomomorphismStructureOnMorphismsWithGivenObjects( cat, H_B_C[j], left_coefficients[i][j], right_coefficients[i][j], H_A_D[i] ) ) 
    );
    
    H := MorphismBetweenDirectSums( range_cat, H_B_C, list, H_A_D );
    
    ## the actual computation of the solution
    lift := LiftOrFail( range_cat, nu, H );
    
    if lift = fail then
        
        return fail;
        
    fi;
    
    ## reinterpretation of the solution
    summands := List( [ 1 .. n ], j -> HomomorphismStructureOnObjects( cat, Range( left_coefficients[1][j] ), Source( right_coefficients[1][j] ) ) );
    
    return
      List( [ 1 .. n ], j -> 
        InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
          Range( left_coefficients[1][j] ),
          Source( right_coefficients[1][j] ),
          ComponentOfMorphismIntoDirectSum( range_cat, lift, summands, j )
        )
      );
  end :
  CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
  CategoryFilter := cat -> HasIsAbCategory( cat ) and IsAbCategory( cat ) and HasRangeCategoryOfHomomorphismStructure( cat )
);

##
AddDerivationToCAP( MereExistenceOfSolutionOfLinearSystemInAbCategory,
                    "MereExistenceOfSolutionOfLinearSystemInAbCategory using the homomorphism structure",
                    [ [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 2 ],
                      [ HomomorphismStructureOnObjects, 4 ],
                      [ HomomorphismStructureOnMorphismsWithGivenObjects, 4 ],
                      [ UniversalMorphismIntoDirectSum, 1, RangeCategoryOfHomomorphismStructure ],
                      [ MorphismBetweenDirectSums, 1, RangeCategoryOfHomomorphismStructure ],
                      [ IsLiftable, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, left_coefficients, right_coefficients, right_side )
    local range_cat, m, n, distinguished_object, interpretations, nu, H_B_C, H_A_D, list, H;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    m := Length( left_coefficients );
    
    n := Length( left_coefficients[1] );
    
    ## create lift diagram
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    interpretations := List( [ 1 .. m ], i -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, right_side[i] ) );
    
    nu := UniversalMorphismIntoDirectSum( range_cat,
        List( interpretations, mor -> Range( mor ) ),
        distinguished_object,
        interpretations
    );
    
    # left_coefficients[i][j] : A_i -> B_j
    # right_coefficients[i][j] : C_j -> D_i
    
    H_B_C := List( [ 1 .. n ], j -> HomomorphismStructureOnObjects( cat, Range( left_coefficients[1][j] ), Source( right_coefficients[1][j] ) ) );
    
    H_A_D := List( [ 1 .. m ], i -> HomomorphismStructureOnObjects( cat, Source( left_coefficients[i][1] ), Range( right_coefficients[i][1] ) ) );
    
    list :=
      List( [ 1 .. n ],
      j -> List( [ 1 .. m ], i -> HomomorphismStructureOnMorphismsWithGivenObjects( cat, H_B_C[j], left_coefficients[i][j], right_coefficients[i][j], H_A_D[i] ) ) 
    );
    
    H := MorphismBetweenDirectSums( range_cat, H_B_C, list, H_A_D );
    
    ## the actual computation of the solution
    return IsLiftable( range_cat, nu, H );
    
  end :
  CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
  CategoryFilter := cat -> HasIsAbCategory( cat ) and IsAbCategory( cat ) and HasRangeCategoryOfHomomorphismStructure( cat )
);

## Final methods for Equalizer

##
AddFinalDerivationBundle( "IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct as the identity of the kernel of the pairwise differences",
                    [ [ JointPairwiseDifferencesOfMorphismsIntoDirectProduct, 1 ], 
                      [ KernelObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Equalizer,
                      EmbeddingOfEqualizer,
                      EmbeddingOfEqualizerWithGivenEqualizer,
                      UniversalMorphismIntoEqualizer,
                      UniversalMorphismIntoEqualizerWithGivenEqualizer,
                      IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct,
                      IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer ],
[
  IsomorphismFromEqualizerToKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProduct,
  [ [ KernelObject, 1 ],
    [ JointPairwiseDifferencesOfMorphismsIntoDirectProduct, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, A, diagram )
    local kernel_of_pairwise_differences;
    
    kernel_of_pairwise_differences := KernelObject( cat, JointPairwiseDifferencesOfMorphismsIntoDirectProduct( cat, A, diagram ) );
    
    return IdentityMorphism( cat, kernel_of_pairwise_differences );
    
  end
],
[
  IsomorphismFromKernelOfJointPairwiseDifferencesOfMorphismsIntoDirectProductToEqualizer,
  [ [ KernelObject, 1 ],
    [ JointPairwiseDifferencesOfMorphismsIntoDirectProduct, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, A, diagram )
    local kernel_of_pairwise_differences;
    
    kernel_of_pairwise_differences := KernelObject( cat, JointPairwiseDifferencesOfMorphismsIntoDirectProduct( cat, A, diagram ) );
    
    return IdentityMorphism( cat, kernel_of_pairwise_differences );
    
  end
] );

## Final methods for Coequalizer

##
AddFinalDerivationBundle( "IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct as the identity of the kernel of the pairwise differences",
                    [ [ JointPairwiseDifferencesOfMorphismsFromCoproduct, 1 ], 
                      [ CokernelObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Coequalizer,
                      ProjectionOntoCoequalizer,
                      ProjectionOntoCoequalizerWithGivenCoequalizer,
                      UniversalMorphismFromCoequalizer,
                      UniversalMorphismFromCoequalizerWithGivenCoequalizer,
                      IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct,
                      IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer ],
[
  IsomorphismFromCoequalizerToCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproduct,
  [ [ CokernelObject, 1 ],
    [ JointPairwiseDifferencesOfMorphismsFromCoproduct, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, A, diagram )
    local cokernel_of_pairwise_differences;
    
    cokernel_of_pairwise_differences := CokernelObject( cat, JointPairwiseDifferencesOfMorphismsFromCoproduct( cat, A, diagram ) );
    
    return IdentityMorphism( cat, cokernel_of_pairwise_differences );
    
  end
],
[
  IsomorphismFromCokernelOfJointPairwiseDifferencesOfMorphismsFromCoproductToCoequalizer,
  [ [ CokernelObject, 1 ],
    [ JointPairwiseDifferencesOfMorphismsFromCoproduct, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, A, diagram )
    local cokernel_of_pairwise_differences;
    
    cokernel_of_pairwise_differences := CokernelObject( cat, JointPairwiseDifferencesOfMorphismsFromCoproduct( cat, A, diagram ) );
    
    return IdentityMorphism( cat, cokernel_of_pairwise_differences );
    
  end
] );

## Final methods for FiberProduct

##
AddFinalDerivationBundle( "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram as the identity of the equalizer of direct product diagram",
                    [ [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 2 ], ## Length( diagram ) would be the correct number
                      [ PreCompose, 2 ], ## Length( diagram ) would be the correct number
                      [ DirectProduct, 1 ],
                      [ Equalizer, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ FiberProduct,
                      ProjectionInFactorOfFiberProduct,
                      ProjectionInFactorOfFiberProductWithGivenFiberProduct,
                      UniversalMorphismIntoFiberProduct,
                      UniversalMorphismIntoFiberProductWithGivenFiberProduct,
                      IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram,
                      IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct ],
[
  IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram,
  [ [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 2 ],
    [ PreCompose, 2 ],
    [ DirectProduct, 1 ],
    [ Equalizer, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, diagram )
    local D, direct_product, diagram_of_equalizer, equalizer_of_direct_product_diagram;
    
    D := List( diagram, Source );
    
    direct_product := DirectProduct( cat, D );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( cat, ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, D, i, direct_product ), diagram[i] ) );
    
    equalizer_of_direct_product_diagram := Equalizer( cat, direct_product, diagram_of_equalizer );
    
    return IdentityMorphism( cat, equalizer_of_direct_product_diagram );
    
  end,
],
[
  IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct,
  [ [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 2 ],
    [ PreCompose, 2 ],
    [ DirectProduct, 1 ],
    [ Equalizer, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, diagram )
    local D, direct_product, diagram_of_equalizer, equalizer_of_direct_product_diagram;
    
    D := List( diagram, Source );
    
    direct_product := DirectProduct( cat, D );
    
    diagram_of_equalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( cat, ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, D, i, direct_product ), diagram[i] ) );
    
    equalizer_of_direct_product_diagram := Equalizer( cat, direct_product, diagram_of_equalizer );
    
    return IdentityMorphism( cat, equalizer_of_direct_product_diagram );
    
  end,
] );

## Final methods for Pushout

##
AddFinalDerivationBundle( "IsomorphismFromPushoutToCoequalizerOfCoproductDiagram as the identity of the coequalizer of coproduct diagram",
                    [ [ InjectionOfCofactorOfCoproductWithGivenCoproduct, 2 ], ## Length( diagram ) would be the correct number
                      [ PreCompose, 2 ], ## Length( diagram ) would be the correct number
                      [ Coproduct, 1 ],
                      [ Coequalizer, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ Pushout,
                      InjectionOfCofactorOfPushout,
                      InjectionOfCofactorOfPushoutWithGivenPushout,
                      UniversalMorphismFromPushout,
                      UniversalMorphismFromPushoutWithGivenPushout,
                      IsomorphismFromPushoutToCoequalizerOfCoproductDiagram,
                      IsomorphismFromCoequalizerOfCoproductDiagramToPushout ],
[
  IsomorphismFromPushoutToCoequalizerOfCoproductDiagram,
  [ [ InjectionOfCofactorOfCoproductWithGivenCoproduct, 2 ],
    [ PreCompose, 2 ],
    [ Coproduct, 1 ],
    [ Coequalizer, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, diagram )
    local D, coproduct, diagram_of_coequalizer, coequalizer_of_coproduct_diagram;
    
    D := List( diagram, Range );
    
    coproduct := Coproduct( cat, D );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( cat, diagram[i], InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, D, i, coproduct ) ) );
    
    coequalizer_of_coproduct_diagram := Coequalizer( cat, coproduct, diagram_of_coequalizer );
    
    return IdentityMorphism( cat, coequalizer_of_coproduct_diagram );
    
  end,
],
[
  IsomorphismFromCoequalizerOfCoproductDiagramToPushout,
  [ [ InjectionOfCofactorOfCoproductWithGivenCoproduct, 2 ],
    [ PreCompose, 2 ],
    [ Coproduct, 1 ],
    [ Coequalizer, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, diagram )
    local D, coproduct, diagram_of_coequalizer, coequalizer_of_coproduct_diagram;
    
    D := List( diagram, Range );
    
    coproduct := Coproduct( cat, D );
    
    diagram_of_coequalizer := List( [ 1 .. Length( D ) ], i -> PreCompose( cat, diagram[i], InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, D, i, coproduct ) ) );
    
    coequalizer_of_coproduct_diagram := Coequalizer( cat, coproduct, diagram_of_coequalizer );
    
    return IdentityMorphism( cat, coequalizer_of_coproduct_diagram );
    
  end,
] );

## Final methods for Image

##
AddFinalDerivationBundle( "IsomorphismFromImageObjectToKernelOfCokernel as the identity of the kernel of the cokernel",
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
[
  IsomorphismFromImageObjectToKernelOfCokernel,
  [ [ KernelObject, 1 ],
    [ CokernelProjection, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, mor )
    local kernel_of_cokernel;
    
    kernel_of_cokernel := KernelObject( cat, CokernelProjection( cat, mor ) );
    
    return IdentityMorphism( cat, kernel_of_cokernel );
    
  end,
],
[
  IsomorphismFromKernelOfCokernelToImageObject,
  [ [ KernelObject, 1 ],
    [ CokernelProjection, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, mor )
    local kernel_of_cokernel;
    
    kernel_of_cokernel := KernelObject( cat, CokernelProjection( cat, mor ) );
    
    return IdentityMorphism( cat, kernel_of_cokernel );
    
  end,
] : CategoryFilter := IsAbelianCategory );

##
AddDerivationToCAP( MorphismFromCoimageToImageWithGivenObjects,
                    "MorphismFromCoimageToImageWithGivenObjects using that images are given by kernels of cokernels",
                    [ [ CokernelProjection, 1 ],
                      [ CoimageProjection, 1 ],
                      [ KernelLift, 1 ],
                      [ AstrictionToCoimageWithGivenCoimageObject, 1 ],
                      [ PreCompose, 1 ],
                      [ IsomorphismFromKernelOfCokernelToImageObject, 1 ] ],
                    
  function( cat, coimage, morphism, image )
    local coimage_projection, cokernel_projection, kernel_lift;
    
    cokernel_projection := CokernelProjection( cat, morphism );
    
    coimage_projection := CoimageProjection( cat, morphism );
    
    kernel_lift := KernelLift( cat, cokernel_projection, coimage, AstrictionToCoimageWithGivenCoimageObject( cat, morphism, coimage ) );
    
    return PreCompose( cat, kernel_lift, IsomorphismFromKernelOfCokernelToImageObject( cat, morphism ) );
    
end : CategoryFilter := IsPreAbelianCategory );

##
AddDerivationToCAP( InverseMorphismFromCoimageToImageWithGivenObjects,
                    "InverseMorphismFromCoimageToImageWithGivenObjects as the inverse of MorphismFromCoimageToImage",
                    [ [ InverseForMorphisms, 1 ],
                      [ MorphismFromCoimageToImageWithGivenObjects, 1 ] ],
                    
  function( cat, coimage, morphism, image )
    
    return InverseForMorphisms( cat, MorphismFromCoimageToImageWithGivenObjects( cat, coimage, morphism, image ) );
    
end : CategoryFilter := IsAbelianCategory );

##
AddDerivationToCAP( CanonicalIdentificationFromCoimageToImageObject,
                    "CanonicalIdentificationFromCoimageToImageObject as the inverse of CanonicalIdentificationFromImageObjectToCoimage",
                    [ [ InverseForMorphisms, 1 ],
                      [ CanonicalIdentificationFromImageObjectToCoimage, 1 ] ],
                    
  function( cat, morphism )
    
    return InverseForMorphisms( cat, CanonicalIdentificationFromImageObjectToCoimage( cat, morphism ) );
    
end );

## Final methods for Coimage

##
AddFinalDerivationBundle( "IsomorphismFromCoimageToCokernelOfKernel as the identity of the cokernel of the kernel",
                    [ [ CokernelObject, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ CoimageObject,
                      CoimageProjection,
                      CoimageProjectionWithGivenCoimageObject,
                      AstrictionToCoimage,
                      AstrictionToCoimageWithGivenCoimageObject,
                      UniversalMorphismIntoCoimage,
                      UniversalMorphismIntoCoimageWithGivenCoimageObject,
                      IsomorphismFromCoimageToCokernelOfKernel,
                      IsomorphismFromCokernelOfKernelToCoimage ],
[
  IsomorphismFromCoimageToCokernelOfKernel,
  [ [ CokernelObject, 1 ],
    [ KernelEmbedding, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, mor )
    local cokernel_of_kernel;
    
    cokernel_of_kernel := CokernelObject( cat, KernelEmbedding( cat, mor ) );
    
    return IdentityMorphism( cat, cokernel_of_kernel );
    
  end,
],
[
  IsomorphismFromCokernelOfKernelToCoimage,
  [ [ CokernelObject, 1 ],
    [ KernelEmbedding, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, mor )
    local cokernel_of_kernel;
    
    cokernel_of_kernel := CokernelObject( cat, KernelEmbedding( cat, mor ) );
    
    return IdentityMorphism( cat, cokernel_of_kernel );
    
  end,
] : CategoryFilter := IsAbelianCategory );

## Final methods for initial object

##
AddFinalDerivationBundle( "IsomorphismFromInitialObjectToZeroObject as the identity of the zero object",
                    [ [ ZeroObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ IsomorphismFromInitialObjectToZeroObject,
                      IsomorphismFromZeroObjectToInitialObject,
                      InitialObject,
                      UniversalMorphismFromInitialObject
                      ## NOTE: the combination of AddZeroObject and AddUniversalMorphismFromInitialObjectWithGivenInitialObject
                      ## is okay because only having UniversalMorphismFromInitialObjectWithGivenInitialObject, you cannot
                      ## deduce an InitialObject
#                       UniversalMorphismFromInitialObjectWithGivenInitialObject
                    ],
[
  IsomorphismFromInitialObjectToZeroObject,
  [ [ ZeroObject, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat )
    
    return IdentityMorphism( cat, ZeroObject( cat ) );
    
  end,
],
[
  IsomorphismFromZeroObjectToInitialObject,
  [ [ ZeroObject, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat )
    
    return IdentityMorphism( cat, ZeroObject( cat ) );
    
  end,
] );

## Final methods for terminal object

##
AddFinalDerivationBundle( "IsomorphismFromTerminalObjectToZeroObject as the identity of the zero object",
                    [ [ ZeroObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ IsomorphismFromTerminalObjectToZeroObject,
                      IsomorphismFromZeroObjectToTerminalObject,
                      TerminalObject,
                      UniversalMorphismIntoTerminalObject
                      ## NOTE: the combination of AddZeroObject and AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject
                      ## is okay because only having UniversalMorphismIntoTerminalObjectWithGivenTerminalObject, you cannot
                      ## deduce a TerminalObject
#                       UniversalMorphismIntoTerminalObjectWithGivenTerminalObject
                    ],
[
  IsomorphismFromTerminalObjectToZeroObject,
  [ [ ZeroObject, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat )
    
    return IdentityMorphism( cat, ZeroObject( cat ) );
    
  end,
],
[
  IsomorphismFromZeroObjectToTerminalObject,
  [ [ ZeroObject, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat )
    
    return IdentityMorphism( cat, ZeroObject( cat ) );
    
  end,
] );

## Final methods for product

##
AddFinalDerivationBundle( "IsomorphismFromDirectSumToDirectProduct as the identity of the direct sum",
                    [ [ DirectSum, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ IsomorphismFromDirectSumToDirectProduct,
                      IsomorphismFromDirectProductToDirectSum,
                      DirectProduct,
                      DirectProductFunctorialWithGivenDirectProducts,
                      ProjectionInFactorOfDirectProduct,
#                       ProjectionInFactorOfDirectProductWithGivenDirectProduct,
                      UniversalMorphismIntoDirectProduct ],
#                       UniversalMorphismIntoDirectProductWithGivenDirectProduct ],
[
  IsomorphismFromDirectSumToDirectProduct,
  [ [ DirectSum, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, diagram )
    
    return IdentityMorphism( cat, DirectSum( cat, diagram ) );
    
  end,
],
[
  IsomorphismFromDirectProductToDirectSum,
  [ [ DirectSum, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, diagram )
    
    return IdentityMorphism( cat, DirectSum( cat, diagram ) );
    
  end,
] );

## Final methods for coproduct

##
AddFinalDerivationBundle( "IsomorphismFromCoproductToDirectSum as the identity of the direct sum",
                    [ [ DirectSum, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ IsomorphismFromCoproductToDirectSum,
                      IsomorphismFromDirectSumToCoproduct,
                      Coproduct,
                      CoproductFunctorialWithGivenCoproducts,
                      InjectionOfCofactorOfCoproduct,
#                       InjectionOfCofactorOfCoproductWithGivenCoproduct,
                      UniversalMorphismFromCoproduct ],
#                       UniversalMorphismFromCoproductWithGivenCoproduct ],
[
  IsomorphismFromCoproductToDirectSum,
  [ [ DirectSum, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, diagram )
    
    return IdentityMorphism( cat, DirectSum( cat, diagram ) );
    
  end,
],
[
  IsomorphismFromDirectSumToCoproduct,
  [ [ DirectSum, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, diagram )
    
    return IdentityMorphism( cat, DirectSum( cat, diagram ) );
    
  end,
] );

################

## Final methods for random methods by lists

##
AddFinalDerivationBundle( "Derive all <ByList> random methods from <ByInteger> random methods",
                    [ [ RandomObjectByInteger, 1 ],
                      [ RandomMorphismWithFixedSourceAndRangeByInteger, 1 ],
                      [ RandomMorphismWithFixedSourceByInteger, 1 ],
                      [ RandomMorphismWithFixedRangeByInteger, 1 ],
                      [ RandomMorphismByInteger, 1 ],
                    ],
                    [ RandomObjectByList,
                      RandomMorphismWithFixedSourceAndRangeByList,
                      RandomMorphismWithFixedSourceByList,
                      RandomMorphismWithFixedRangeByList,
                      RandomMorphismByList ],
[
  RandomObjectByList,
  [ [ RandomObjectByInteger, 1 ] ],
  function( cat, L )
    
    if Length( L ) <> 1 or not IsInt( L[1] ) then
        Error( "the list passed to 'RandomObjectByList' in ", Name( cat ), " must consist of only one integer!\n" );
    fi;
    
    return RandomObjectByInteger( cat, L[1] );
    
  end
],
[
  RandomMorphismWithFixedSourceAndRangeByList,
  [ [ RandomMorphismWithFixedSourceAndRangeByInteger, 1 ] ],
  function( cat, S, R, L )
    
    if Length( L ) <> 1 or not IsInt( L[1] ) then
        Error( "the list passed to 'RandomMorphismWithFixedSourceAndRangeByList' in ", Name( cat ), " must consist of only one integer!\n" );
    fi;
    
    return RandomMorphismWithFixedSourceAndRangeByInteger( cat, S, R, L[1] );
    
  end
],
[
  RandomMorphismWithFixedSourceByList,
  [ [ RandomMorphismWithFixedSourceByInteger, 1 ] ],
  function( cat, S, L )
    
    if Length( L ) <> 1 or not IsInt( L[1] ) then
        Error( "the list passed to 'RandomMorphismWithFixedSourceByList' in ", Name( cat ), " must consist of only one integer!\n" );
    fi;
    
    return RandomMorphismWithFixedSourceByInteger( cat, S, L[1] );
    
  end
],
[
  RandomMorphismWithFixedRangeByList,
  [ [ RandomMorphismWithFixedRangeByInteger, 1 ] ],
  function( cat, R, L )
    
    if Length( L ) <> 1 or not IsInt( L[1] ) then
        Error( "the list passed to 'RandomMorphismWithFixedRangeByList' in ", Name( cat ), " must consist of only one integer!\n" );
    fi;
    
    return RandomMorphismWithFixedRangeByInteger( cat, R, L[1] );
    
  end
],
[
  RandomMorphismByList,
  [ [ RandomMorphismByInteger, 1 ] ],
  function( cat, L )
    
    if Length( L ) <> 1 or not IsInt( L[1] ) then
        Error( "the list passed to 'RandomMorphismByList' in ", Name( cat ), " must consist of only one integer!\n" );
    fi;
    
    return RandomMorphismByInteger( cat, L[1] );
    
  end
] );

## Final methods for homology object

##
AddFinalDerivationBundle( "IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject as the identity of the homology object constructed as an image object",
                    [ [ ImageObject, 1 ],
                      [ PreCompose, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ CokernelProjection, 1 ],
                      [ IdentityMorphism, 1 ],
                    ],
                    [ IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject,
                      IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject,
                      HomologyObject,
                      HomologyObjectFunctorialWithGivenHomologyObjects ],
[
  IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject,
  [ [ ImageObject, 1 ],
    [ PreCompose, 1 ],
    [ KernelEmbedding, 1 ],
    [ CokernelProjection, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, alpha, beta )
    local homology_object;
    
    homology_object := ImageObject( cat, PreCompose( cat, KernelEmbedding( cat, beta ), CokernelProjection( cat, alpha ) ) );
    
    return IdentityMorphism( cat, homology_object );
    
  end,
],
[
  IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject,
  [ [ ImageObject, 1 ],
    [ PreCompose, 1 ],
    [ KernelEmbedding, 1 ],
    [ CokernelProjection, 1 ],
    [ IdentityMorphism, 1 ] ],
  function( cat, alpha, beta )
    local homology_object;
    
    homology_object := ImageObject( cat, PreCompose( cat, KernelEmbedding( cat, beta ), CokernelProjection( cat, alpha ) ) );
    
    return IdentityMorphism( cat, homology_object );
    
  end,
] : CategoryFilter := IsAbelianCategory );

## Final methods for IsEqual/IsCongruentForMorphisms
##
AddFinalDerivation( IsCongruentForMorphisms,
                    "Use IsEqualForMorphisms for IsCongruentForMorphisms",
                    [ [ IsEqualForMorphisms, 1 ] ],
                    [ IsCongruentForMorphisms ],
                    
  { cat, mor1, mor2 } -> IsEqualForMorphisms( cat, mor1, mor2 ) : CategoryFilter := cat -> cat!.is_computable );

##
AddFinalDerivation( IsEqualForMorphisms,
                    "Use IsCongruentForMorphisms for IsEqualForMorphisms",
                    [ [ IsCongruentForMorphisms, 1 ] ],
                    [ IsEqualForMorphisms ],
                    
  { cat, mor1, mor2 } -> IsCongruentForMorphisms( cat, mor1, mor2 ) );

## Final methods for BasisOfExternalHom & CoefficientsOfMorphism

##
AddFinalDerivationBundle( "Adding BasisOfExternalHom and CoefficientsOfMorphism using homomorphism structure",
                    [
                      [ HomomorphismStructureOnObjects, 1 ],
                      [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 2 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
                      [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ BasisOfExternalHom, 1, RangeCategoryOfHomomorphismStructure ],
                      [ CoefficientsOfMorphism, 1, RangeCategoryOfHomomorphismStructure ],
                    ],
                    [
                      BasisOfExternalHom,
                      CoefficientsOfMorphism
                    ],
[
  BasisOfExternalHom,
  [ [ HomomorphismStructureOnObjects, 1 ],
    [ InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism, 2 ],
    [ DistinguishedObjectOfHomomorphismStructure, 1 ],
    [ BasisOfExternalHom, 1, RangeCategoryOfHomomorphismStructure ] ],
  function( cat, a, b )
    local range_cat, hom_a_b, D, B;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    hom_a_b := HomomorphismStructureOnObjects( cat, a, b );
    
    D := DistinguishedObjectOfHomomorphismStructure( cat );
    
    B := BasisOfExternalHom( range_cat, D, hom_a_b );
    
    return List( B, m -> InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, a, b, m ) );
  
  end,
],
[
  CoefficientsOfMorphism,
  [ [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure, 1 ],
    [ CoefficientsOfMorphism, 1, RangeCategoryOfHomomorphismStructure ] ],
  function( cat, alpha )
    local range_cat, beta;
    
    range_cat := RangeCategoryOfHomomorphismStructure( cat );
    
    beta := InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha );
    
    return CoefficientsOfMorphism( range_cat, beta );
    
  end,
] :
  CategoryGetters := rec( range_cat := RangeCategoryOfHomomorphismStructure ),
  CategoryFilter :=
    function( cat )
      local range_cat, required_methods;
      
      if not ( HasIsLinearCategoryOverCommutativeRing( cat ) and IsLinearCategoryOverCommutativeRing( cat ) ) then
        
        return false;
        
      fi;
      
      if not HasRangeCategoryOfHomomorphismStructure( cat ) then
        
        return false;
        
      fi;
      
      range_cat := RangeCategoryOfHomomorphismStructure( cat );
      
      if IsIdenticalObj( cat, range_cat ) then
        
        return false;
        
      fi;
      
      if not ( HasIsLinearCategoryOverCommutativeRing( range_cat ) and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        
        return false;
        
      fi;
      
      if not IsIdenticalObj( CommutativeRingOfLinearCategory( cat ), CommutativeRingOfLinearCategory( range_cat ) ) then
        
        return false;
        
      fi;
      
      return true;
      
  end
);
