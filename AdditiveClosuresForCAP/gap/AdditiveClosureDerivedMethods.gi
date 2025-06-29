# SPDX-License-Identifier: GPL-2.0-or-later
# AdditiveClosuresForCAP: Additive closures for pre-abelian categories
#
# Implementations
#

## Derivations for basic operations with existing WithGiven

##
AddDerivationToCAP( ProjectionInSecondFactorOfWeakBiFiberProduct,
                    "ProjectionInSecondFactorOfWeakBiFiberProduct using ProjectionInFirstFactorOfWeakBiFiberProduct and Lift",
                    [ [ ProjectionInFirstFactorOfWeakBiFiberProduct, 1 ],
                      [ Lift, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, beta )
    local first_projection;
    
    first_projection := ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    return Lift( cat, PreCompose( cat, first_projection, alpha ), beta );
    
end );

##
AddDerivationToCAP( ProjectionInFirstFactorOfWeakBiFiberProduct,
                    "ProjectionInFirstFactorOfWeakBiFiberProduct using ProjectionInSecondFactorOfWeakBiFiberProduct and Lift",
                    [ [ ProjectionInSecondFactorOfWeakBiFiberProduct, 1 ],
                      [ Lift, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, beta )
    local second_projection;
    
    second_projection := ProjectionInSecondFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    return Lift( cat, PreCompose( cat, second_projection, beta ), alpha );
    
end );

##
AddDerivationToCAP( InjectionOfSecondCofactorOfWeakBiPushout,
                    "InjectionOfSecondCofactorOfWeakBiPushout using InjectionOfFirstCofactorOfWeakBiPushout and Colift",
                    [ [ InjectionOfFirstCofactorOfWeakBiPushout, 1 ],
                      [ Colift, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, beta )
    local first_injection;
    
    first_injection := InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta );
    
    return Colift( cat, beta, PreCompose( cat, alpha, first_injection ) );
    
end );

##
AddDerivationToCAP( InjectionOfFirstCofactorOfWeakBiPushout,
                    "InjectionOfFirstCofactorOfWeakBiPushout using InjectionOfSecondCofactorOfWeakBiPushout and Colift",
                    [ [ InjectionOfSecondCofactorOfWeakBiPushout, 1 ],
                      [ Colift, 1 ],
                      [ PreCompose, 1 ] ],
                    
  function( cat, alpha, beta )
    local second_injection;
    
    second_injection := InjectionOfSecondCofactorOfWeakBiPushout( cat, alpha, beta );
    
    return Colift( cat, alpha, PreCompose( cat, beta, second_injection ) );
    
end );

##
AddDerivationToCAP( UniversalMorphismIntoWeakBiFiberProduct,
                    "UniversalMorphismIntoWeakBiFiberProduct using Lift",
                    [ [ ProjectionInFirstFactorOfWeakBiFiberProduct, 1 ],
                      [ ProjectionInSecondFactorOfWeakBiFiberProduct, 1 ],
                      [ Lift, 1 ],
                      [ UniversalMorphismIntoDirectSum, 2 ] ],
                    
  function( cat, alpha, beta, test_mor_1, test_mor_2 )
    local projection_1, projection_2;
    
    projection_1 := ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    projection_2 := ProjectionInSecondFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    return Lift( cat, UniversalMorphismIntoDirectSum( cat, [ test_mor_1, test_mor_2 ] ),
                      UniversalMorphismIntoDirectSum( cat, [ projection_1, projection_2 ] ) );
    
end );

##
AddDerivationToCAP( UniversalMorphismIntoBiasedWeakFiberProduct,
                    "UniversalMorphismIntoBiasedWeakFiberProduct using Lift",
                    [ [ Lift, 1 ],
                      [ ProjectionOfBiasedWeakFiberProduct, 1 ] ],
                    
  function( cat, alpha, beta, test_mor )
    
    return Lift( cat,
                 test_mor,
                 ProjectionOfBiasedWeakFiberProduct( cat, alpha, beta ) );
    
end );


##
AddDerivationToCAP( UniversalMorphismFromWeakBiPushout,
                    "UniversalMorphismFromWeakBiPushout using Colift",
                    [ [ InjectionOfFirstCofactorOfWeakBiPushout, 1 ],
                      [ InjectionOfSecondCofactorOfWeakBiPushout, 1 ],
                      [ Colift, 1 ],
                      [ UniversalMorphismFromDirectSum, 2 ] ],
                    
  function( cat, alpha, beta, test_mor_1, test_mor_2 )
    local injection_1, injection_2;
    
    injection_1 := InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta );
    
    injection_2 := InjectionOfSecondCofactorOfWeakBiPushout( cat, alpha, beta );
    
    return Colift( cat, UniversalMorphismFromDirectSum( cat, [ injection_1, injection_2 ] ),
                        UniversalMorphismFromDirectSum( cat, [ test_mor_1, test_mor_2 ] ) );
    
end );

##
AddDerivationToCAP( UniversalMorphismFromBiasedWeakPushout,
                    "UniversalMorphismFromBiasedWeakPushout using Colift",
                    [ [ Colift, 1 ],
                      [ InjectionOfBiasedWeakPushout, 1 ] ],
                    
  function( cat, alpha, beta, test_mor )
    
    return Colift( cat,
                   InjectionOfBiasedWeakPushout( cat, alpha, beta ),
                   test_mor );
    
end );

##
AddDerivationToCAP( WeakKernelLift,
                    "WeakKernelLift as Lift of WeakKernelEmbedding",
                    [ [ Lift, 1 ],
                      [ WeakKernelEmbedding, 1 ] ],
                    
  function( cat, mor, test_mor )
    
    return Lift( cat, test_mor, WeakKernelEmbedding( cat, mor ) );
    
end );

##
AddDerivationToCAP( WeakCokernelColift,
                    "WeakCokernelColift as Colift of WeakCokernelProjection",
                    [ [ Colift, 1 ],
                      [ WeakCokernelProjection, 1 ] ],
                    
  function( cat, mor, test_mor )
    
    return Colift( cat, WeakCokernelProjection( cat, mor ), test_mor );
    
end );


## Derivations for basic operations without existing WithGiven
##
AddDerivationToCAP( WeakKernelObject,
                    "WeakKernelObject as the source of WeakKernelEmbedding",
                    [ [ WeakKernelEmbedding, 1 ] ],
                    
  function( cat, mor )
    
    return Source( WeakKernelEmbedding( cat, mor ) );
    
end );

##
AddDerivationToCAP( WeakCokernelObject,
                    "WeakCokernelObject as the range of WeakCokernelProjection",
                    [ [ WeakCokernelProjection, 1 ] ],
                    
  function( cat, mor )
    
    return Range( WeakCokernelProjection( cat, mor ) );
    
end );

##
AddDerivationToCAP( WeakBiFiberProduct,
                    "WeakBiFiberProduct as the source of ProjectionInFirstFactorOfWeakBiFiberProduct",
                    [ [ ProjectionInFirstFactorOfWeakBiFiberProduct, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Source( ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta ) );
    
end );

##
AddDerivationToCAP( WeakBiFiberProduct,
                    "WeakBiFiberProduct as the source of ProjectionInSecondFactorOfWeakBiFiberProduct",
                    [ [ ProjectionInSecondFactorOfWeakBiFiberProduct, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Source( ProjectionInSecondFactorOfWeakBiFiberProduct( cat, alpha, beta ) );
    
end );

##
AddDerivationToCAP( BiasedWeakFiberProduct,
                    "BiasedWeakFiberProduct as the source of ProjectionOfBiasedWeakFiberProduct",
                    [ [ ProjectionOfBiasedWeakFiberProduct, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Source( ProjectionOfBiasedWeakFiberProduct( cat, alpha, beta ) );
    
end );


##
AddDerivationToCAP( WeakBiPushout,
                    "WeakBiPushout as the range of InjectionOfFirstCofactorOfWeakBiPushout",
                    [ [ InjectionOfFirstCofactorOfWeakBiPushout, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Range( InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta ) );
    
end );

##
AddDerivationToCAP( WeakBiPushout,
                    "WeakBiPushout as the range of InjectionOfSecondCofactorOfWeakBiPushout",
                    [ [ InjectionOfSecondCofactorOfWeakBiPushout, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Range( InjectionOfSecondCofactorOfWeakBiPushout( cat, alpha, beta ) );
    
end );

##
AddDerivationToCAP( BiasedWeakPushout,
                    "BiasedWeakPushout as the range of InjectionOfBiasedWeakPushout",
                    [ [ InjectionOfBiasedWeakPushout, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Range( InjectionOfBiasedWeakPushout( cat, alpha, beta ) );
    
end );


## abelian derivations

##
AddDerivationToCAP( IsMonomorphism,
                    "IsMonomorphism by deciding whether WeakKernelEmbedding is zero",
                    [ [ IsZeroForMorphisms, 1 ],
                      [ WeakKernelEmbedding, 1 ] ],
                    
  function( cat, alpha )
      
      return IsZeroForMorphisms( cat, WeakKernelEmbedding( cat, alpha ) );
      
end );

##
AddDerivationToCAP( IsEpimorphism,
                    "IsEpimorphism by deciding whether WeakCokernelProjection is zero",
                    [ [ IsZeroForMorphisms, 1 ],
                      [ WeakCokernelProjection, 1 ] ],
                    
  function( cat, alpha )
      
      return IsZeroForMorphisms( cat, WeakCokernelProjection( cat, alpha ) );
      
end );

##
AddDerivationToCAP( WeakBiFiberProductMorphismToDirectSum,
                    "WeakBiFiberProductMorphismToDirectSum using UniversalMorphismIntoDirectSum of the two weak bi-fiber product projections",
                    [ [ ProjectionInFirstFactorOfWeakBiFiberProduct, 1 ],
                      [ ProjectionInSecondFactorOfWeakBiFiberProduct, 1 ],
                      [ UniversalMorphismIntoDirectSum, 1 ] ],
                    
  function( cat, alpha, beta )
    local projection_1, projection_2;
    
    projection_1 := ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    projection_2 := ProjectionInSecondFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    return UniversalMorphismIntoDirectSum( cat, [ projection_1, projection_2 ] );
    
end );

##
AddDerivationToCAP( DirectSumMorphismToWeakBiPushout,
                    "DirectSumMorphismToWeakBiPushout using UniversalMorphismFromDirectSum of the two weak bi-pushout injections",
                    [ [ InjectionOfFirstCofactorOfWeakBiPushout, 1 ],
                      [ InjectionOfSecondCofactorOfWeakBiPushout, 1 ],
                      [ UniversalMorphismFromDirectSum, 1 ] ],
                    
  function( cat, alpha, beta )
    local injection_1, injection_2;
    
    injection_1 := InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta );
    
    injection_2 := InjectionOfSecondCofactorOfWeakBiPushout( cat, alpha, beta );
    
    return UniversalMorphismFromDirectSum( cat, [ injection_1, injection_2 ] );
    
end );

##
AddDerivationToCAP( WeakBiFiberProduct,
                    "WeakBiFiberProduct as the source of WeakBiFiberProductMorphismToDirectSum",
                    [ [ WeakBiFiberProductMorphismToDirectSum, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Source( WeakBiFiberProductMorphismToDirectSum( cat, alpha, beta ) );
    
end );

##
AddDerivationToCAP( WeakBiPushout,
                    "WeakBiPushout as the range of DirectSumMorphismToWeakBiPushout",
                    [ [ DirectSumMorphismToWeakBiPushout, 1 ] ],
                    
  function( cat, alpha, beta )
    
    return Range( DirectSumMorphismToWeakBiPushout( cat, alpha, beta ) );
    
end );

## Final derivations

##
AddFinalDerivationBundle( "weak kernel using kernel",
                    [ [ KernelObject, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ KernelLift, 1 ] ],
                    
                    [ WeakKernelObject,
                      WeakKernelEmbedding,
                      WeakKernelLift ],
[
  WeakKernelObject,
  [ [ KernelObject, 1 ] ],
  function( cat, morphism )
    
    return KernelObject( cat, morphism );
    
  end
],
[
  WeakKernelEmbedding,
  [ [ KernelEmbedding, 1 ] ],
  function( cat, morphism )
    
    return KernelEmbedding( cat, morphism );
    
  end
],
[
  WeakKernelLift,
  [ [ KernelLift, 1 ] ],
  function( cat, morphism, test_mor )
    
    return KernelLift( cat, morphism, test_mor );
    
  end
] );

##
AddFinalDerivationBundle( "weak cokernel using cokernel",
                    [ [ CokernelObject, 1 ],
                      [ CokernelProjection, 1 ],
                      [ CokernelColift, 1 ] ],
                    
                    [ WeakCokernelObject,
                      WeakCokernelProjection,
                      WeakCokernelColift ],
[
  WeakCokernelObject,
  [ [ CokernelObject, 1 ] ],
  function( cat, morphism )
    
    return CokernelObject( cat, morphism );
    
  end
],
[
  WeakCokernelProjection,
  [ [ CokernelProjection, 1 ] ],
  function( cat, morphism )
    
    return CokernelProjection( cat, morphism );
    
  end
],
[
  WeakCokernelColift,
  [ [ CokernelColift, 1 ] ],
  function( cat, morphism, test_mor )
    
    return CokernelColift( cat, morphism, test_mor );
    
  end
] );

## Final derivation for weak fiber products and weak pushouts.
## Decision: we use a derivation from weak kernels and direct sums

##
AddFinalDerivationBundle( "WeakBiFiberProductMorphismToDirectSum via WeakKernelEmbedding and direct sum",
                    [ [ DirectSum, 1 ],
                      [ PreCompose, 2 ],
                      [ ProjectionInFactorOfDirectSumWithGivenDirectSum, 2 ],
                      [ SubtractionForMorphisms, 1 ],
                      [ WeakKernelEmbedding, 1 ],
                      [ ProjectionInFactorOfDirectSum, 1 ],
                      [ UniversalMorphismIntoDirectSum, 1 ],
                      [ WeakKernelLift, 1 ],
                    ],
                    [
                      WeakBiFiberProduct,
                      ProjectionInFirstFactorOfWeakBiFiberProduct,
                      ProjectionInSecondFactorOfWeakBiFiberProduct,
                      UniversalMorphismIntoWeakBiFiberProduct,
                      WeakBiFiberProductMorphismToDirectSum,
                    ],
[
  WeakBiFiberProductMorphismToDirectSum,
  [ [ DirectSum, 1 ],
    [ PreCompose, 2 ],
    [ ProjectionInFactorOfDirectSumWithGivenDirectSum, 2 ],
    [ SubtractionForMorphisms, 1 ],
    [ WeakKernelEmbedding, 1 ] ],
  function( cat, alpha, beta )
    local direct_sum_diagram, direct_sum, proj1_alpha, proj2_beta, difference;
    
    direct_sum_diagram := [ Source( alpha ), Source( beta ) ];
    
    direct_sum := DirectSum( cat, direct_sum_diagram );
    
    proj1_alpha := PreCompose( cat, ProjectionInFactorOfDirectSumWithGivenDirectSum( cat, direct_sum_diagram, 1, direct_sum ), alpha );
    
    proj2_beta := PreCompose( cat, ProjectionInFactorOfDirectSumWithGivenDirectSum( cat, direct_sum_diagram, 2, direct_sum ), beta );
    
    difference := SubtractionForMorphisms( cat, proj1_alpha, proj2_beta );
    
    return WeakKernelEmbedding( cat, difference );
    
  end
],
[
  ProjectionInFirstFactorOfWeakBiFiberProduct,
  [ [ WeakBiFiberProductMorphismToDirectSum, 1 ],
    [ PreCompose, 1 ],
    [ ProjectionInFactorOfDirectSum, 1 ] ],
  function( cat, alpha, beta )
    local morphism_to_direct_sum;
    
    morphism_to_direct_sum := WeakBiFiberProductMorphismToDirectSum( cat, alpha, beta );
    
    return PreCompose( cat, morphism_to_direct_sum, ProjectionInFactorOfDirectSum( cat, [ Source( alpha ), Source( beta ) ], 1 ) );
    
  end
],
[
  ProjectionInSecondFactorOfWeakBiFiberProduct,
  [ [ WeakBiFiberProductMorphismToDirectSum, 1 ],
    [ PreCompose, 1 ],
    [ ProjectionInFactorOfDirectSum, 1 ] ],
  function( cat, alpha, beta )
    local morphism_to_direct_sum;
    
    morphism_to_direct_sum := WeakBiFiberProductMorphismToDirectSum( cat, alpha, beta );
    
    return PreCompose( cat, morphism_to_direct_sum, ProjectionInFactorOfDirectSum( cat, [ Source( alpha ), Source( beta ) ], 2 ) );
    
  end
],
[
  UniversalMorphismIntoWeakBiFiberProduct,
  [ [ UniversalMorphismIntoDirectSum, 1 ],
    [ DirectSum, 1 ],
    [ PreCompose, 2 ],
    [ ProjectionInFactorOfDirectSumWithGivenDirectSum, 2 ],
    [ SubtractionForMorphisms, 1 ],
    [ WeakKernelLift, 1 ] ],
  function( cat, alpha, beta, test_mor_1, test_mor_2 )
    local test_mor, direct_sum_diagram, direct_sum, proj1_alpha, proj2_beta, difference;
    
    test_mor := UniversalMorphismIntoDirectSum( cat, [ test_mor_1, test_mor_2 ] );
    
    direct_sum_diagram := [ Source( alpha ), Source( beta ) ];
    
    direct_sum := DirectSum( cat, direct_sum_diagram );
    
    proj1_alpha := PreCompose( cat, ProjectionInFactorOfDirectSumWithGivenDirectSum( cat, direct_sum_diagram, 1, direct_sum ), alpha );
    
    proj2_beta := PreCompose( cat, ProjectionInFactorOfDirectSumWithGivenDirectSum( cat, direct_sum_diagram, 2, direct_sum ), beta );
    
    difference := SubtractionForMorphisms( cat, proj1_alpha, proj2_beta );
    
    return WeakKernelLift( cat, difference, test_mor );
    
  end
] );

## weak bi-pushout
##
AddFinalDerivationBundle( "DirectSumMorphismToWeakBiPushout via WeakCokernelProjection and direct sum",
                    [ [ DirectSum, 1 ],
                      [ PreCompose, 2 ],
                      [ InjectionOfCofactorOfDirectSumWithGivenDirectSum, 2 ],
                      [ SubtractionForMorphisms, 1 ],
                      [ WeakCokernelProjection, 1 ],
                      [ InjectionOfCofactorOfDirectSum, 1 ],
                      [ UniversalMorphismFromDirectSum, 1 ],
                      [ WeakCokernelColift, 1 ],
                    ],
                    [
                      WeakBiPushout,
                      InjectionOfFirstCofactorOfWeakBiPushout,
                      InjectionOfSecondCofactorOfWeakBiPushout,
                      UniversalMorphismFromWeakBiPushout,
                      DirectSumMorphismToWeakBiPushout,
                    ],
[
  DirectSumMorphismToWeakBiPushout,
  [ [ DirectSum, 1 ],
    [ PreCompose, 2 ],
    [ InjectionOfCofactorOfDirectSumWithGivenDirectSum, 2 ],
    [ SubtractionForMorphisms, 1 ],
    [ WeakCokernelProjection, 1 ] ],
  function( cat, alpha, beta )
    local direct_sum_diagram, direct_sum, alpha_inj1, beta_inj2, difference;
    
    direct_sum_diagram := [ Range( alpha ), Range( beta ) ];
    
    direct_sum := DirectSum( cat, direct_sum_diagram );
    
    alpha_inj1 := PreCompose( cat, alpha, InjectionOfCofactorOfDirectSumWithGivenDirectSum( cat, direct_sum_diagram, 1, direct_sum ) );
    
    beta_inj2 := PreCompose( cat, beta, InjectionOfCofactorOfDirectSumWithGivenDirectSum( cat, direct_sum_diagram, 2, direct_sum ) );
    
    difference := SubtractionForMorphisms( cat, alpha_inj1, beta_inj2 );
    
    return WeakCokernelProjection( cat, difference );
    
end
],
[
  InjectionOfFirstCofactorOfWeakBiPushout,
  [ [ DirectSumMorphismToWeakBiPushout, 1 ],
    [ PreCompose, 1 ],
    [ InjectionOfCofactorOfDirectSum, 1 ] ],
  function( cat, alpha, beta )
    local direct_sum_morphism;
    
    direct_sum_morphism := DirectSumMorphismToWeakBiPushout( cat, alpha, beta );
    
    return PreCompose( cat, InjectionOfCofactorOfDirectSum( cat, [ Range( alpha ), Range( beta ) ], 1 ), direct_sum_morphism );
    
  end
],
[
  InjectionOfSecondCofactorOfWeakBiPushout,
  [ [ DirectSumMorphismToWeakBiPushout, 1 ],
    [ PreCompose, 1 ],
    [ InjectionOfCofactorOfDirectSum, 1 ] ],
  function( cat, alpha, beta )
    local direct_sum_morphism;
    
    direct_sum_morphism := DirectSumMorphismToWeakBiPushout( cat, alpha, beta );
    
    return PreCompose( cat, InjectionOfCofactorOfDirectSum( cat, [ Range( alpha ), Range( beta ) ], 2 ), direct_sum_morphism );
    
  end
],
[
  UniversalMorphismFromWeakBiPushout,
  [ [ UniversalMorphismFromDirectSum, 1 ],
    [ DirectSum, 1 ],
    [ PreCompose, 2 ],
    [ InjectionOfCofactorOfDirectSumWithGivenDirectSum, 2 ],
    [ SubtractionForMorphisms, 1 ],
    [ WeakCokernelColift, 1 ] ],
  function( cat, alpha, beta, test_mor_1, test_mor_2 )
    local test_mor, direct_sum_diagram, direct_sum, alpha_inj1, beta_inj2, difference;
    
    test_mor := UniversalMorphismFromDirectSum( cat, [ test_mor_1, test_mor_2 ] );
    
    direct_sum_diagram := [ Range( alpha ), Range( beta ) ];
    
    direct_sum := DirectSum( cat, direct_sum_diagram );
    
    alpha_inj1 := PreCompose( cat, alpha, InjectionOfCofactorOfDirectSumWithGivenDirectSum( cat, direct_sum_diagram, 1, direct_sum ) );
    
    beta_inj2 := PreCompose( cat, beta, InjectionOfCofactorOfDirectSumWithGivenDirectSum( cat, direct_sum_diagram, 2, direct_sum ) );
    
    difference := SubtractionForMorphisms( cat, alpha_inj1, beta_inj2 );

    return WeakCokernelColift( cat, difference, test_mor );
    
  end
] );

## Final derivation for biased weak fiber products and biased weak pushouts.
## Decision: we use a derivation from weak fiber products and weak pushouts

##
AddFinalDerivation( ProjectionOfBiasedWeakFiberProduct,
                    "ProjectionOfBiasedWeakFiberProduct using ProjectionInFirstFactorOfWeakBiFiberProduct",
                    [ [ ProjectionInFirstFactorOfWeakBiFiberProduct, 1 ] ],
                    [
                      BiasedWeakFiberProduct,
                      ProjectionOfBiasedWeakFiberProduct,
                    ],
                    
  function( cat, alpha, beta )
    
    return ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta );

end );

##
AddFinalDerivation( InjectionOfBiasedWeakPushout,
                    "ProjectioInjectionOfBiasedWeakPushoutnOfBiasedWeakFiberProduct using InjectionOfFirstCofactorOfWeakBiPushout",
                    [ [ InjectionOfFirstCofactorOfWeakBiPushout, 1 ] ],
                    [
                      BiasedWeakPushout,
                      InjectionOfBiasedWeakPushout,
                    ],
                    
  function( cat, alpha, beta )
    
    return InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta );

end );
