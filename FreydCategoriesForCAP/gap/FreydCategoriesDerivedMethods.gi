# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

## Derivations for basic operations with existing WithGiven

##
AddDerivationToCAP( ProjectionInSecondFactorOfWeakBiFiberProduct,
                    
  function( cat, alpha, beta )
    local first_projection;
    
    first_projection := ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    return Lift( cat, PreCompose( cat, first_projection, alpha ), beta );
    
end : Description := "ProjectionInSecondFactorOfWeakBiFiberProduct using ProjectionInFirstFactorOfWeakBiFiberProduct and Lift" );

##
AddDerivationToCAP( ProjectionInFirstFactorOfWeakBiFiberProduct,
                    
  function( cat, alpha, beta )
    local second_projection;
    
    second_projection := ProjectionInSecondFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    return Lift( cat, PreCompose( cat, second_projection, beta ), alpha );
    
end : Description := "ProjectionInFirstFactorOfWeakBiFiberProduct using ProjectionInSecondFactorOfWeakBiFiberProduct and Lift" );

##
AddDerivationToCAP( InjectionOfSecondCofactorOfWeakBiPushout,
                    
  function( cat, alpha, beta )
    local first_injection;
    
    first_injection := InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta );
    
    return Colift( cat, beta, PreCompose( cat, alpha, first_injection ) );
    
end : Description := "InjectionOfSecondCofactorOfWeakBiPushout using InjectionOfFirstCofactorOfWeakBiPushout and Colift" );

##
AddDerivationToCAP( InjectionOfFirstCofactorOfWeakBiPushout,
                    
  function( cat, alpha, beta )
    local second_injection;
    
    second_injection := InjectionOfSecondCofactorOfWeakBiPushout( cat, alpha, beta );
    
    return Colift( cat, alpha, PreCompose( cat, beta, second_injection ) );
    
end : Description := "InjectionOfFirstCofactorOfWeakBiPushout using InjectionOfSecondCofactorOfWeakBiPushout and Colift" );

##
AddDerivationToCAP( UniversalMorphismIntoWeakBiFiberProduct,
                                 
  function( cat, alpha, beta, test_mor_1, test_mor_2 )
    local projection_1, projection_2;
    
    projection_1 := ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    projection_2 := ProjectionInSecondFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    return Lift( cat, UniversalMorphismIntoDirectSum( cat, [ test_mor_1, test_mor_2 ] ),
                      UniversalMorphismIntoDirectSum( cat, [ projection_1, projection_2 ] ) );
    
end : Description := "UniversalMorphismIntoWeakBiFiberProduct using Lift" );

##
AddDerivationToCAP( UniversalMorphismIntoBiasedWeakFiberProduct,
                                 
  function( cat, alpha, beta, test_mor )
    
    return Lift( cat,
                 test_mor,
                 ProjectionOfBiasedWeakFiberProduct( cat, alpha, beta ) );
    
end : Description := "UniversalMorphismIntoBiasedWeakFiberProduct using Lift" );


##
AddDerivationToCAP( UniversalMorphismFromWeakBiPushout,
                                 
  function( cat, alpha, beta, test_mor_1, test_mor_2 )
    local injection_1, injection_2;
    
    injection_1 := InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta );
    
    injection_2 := InjectionOfSecondCofactorOfWeakBiPushout( cat, alpha, beta );
    
    return Colift( cat, UniversalMorphismFromDirectSum( cat, [ injection_1, injection_2 ] ),
                        UniversalMorphismFromDirectSum( cat, [ test_mor_1, test_mor_2 ] ) );
    
end : Description := "UniversalMorphismFromWeakBiPushout using Colift" );

##
AddDerivationToCAP( UniversalMorphismFromBiasedWeakPushout,
                                 
  function( cat, alpha, beta, test_mor )
    
    return Colift( cat,
                   InjectionOfBiasedWeakPushout( cat, alpha, beta ),
                   test_mor );
    
end : Description := "UniversalMorphismFromBiasedWeakPushout using Colift" );

##
AddDerivationToCAP( WeakKernelLift,
                                 
  function( cat, mor, test_mor )
    
    return Lift( cat, test_mor, WeakKernelEmbedding( cat, mor ) );
    
end : Description := "WeakKernelLift as Lift of WeakKernelEmbedding" );

##
AddDerivationToCAP( WeakCokernelColift,
                                 
  function( cat, mor, test_mor )
    
    return Colift( cat, WeakCokernelProjection( cat, mor ), test_mor );
    
end : Description := "WeakCokernelColift as Colift of WeakCokernelProjection" );


## Derivations for basic operations without existing WithGiven
##
AddDerivationToCAP( WeakKernelObject,
                    
  function( cat, mor )
    
    return Source( WeakKernelEmbedding( cat, mor ) );
    
end : Description := "WeakKernelObject as the source of WeakKernelEmbedding" );

##
AddDerivationToCAP( WeakCokernelObject,
                    
  function( cat, mor )
    
    return Range( WeakCokernelProjection( cat, mor ) );
    
end : Description := "WeakCokernelObject as the range of WeakCokernelProjection" );

##
AddDerivationToCAP( WeakBiFiberProduct,
                    
  function( cat, alpha, beta )
    
    return Source( ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta ) );
    
end : Description := "WeakBiFiberProduct as the source of ProjectionInFirstFactorOfWeakBiFiberProduct" );

##
AddDerivationToCAP( WeakBiFiberProduct,
                    
  function( cat, alpha, beta )
    
    return Source( ProjectionInSecondFactorOfWeakBiFiberProduct( cat, alpha, beta ) );
    
end : Description := "WeakBiFiberProduct as the source of ProjectionInSecondFactorOfWeakBiFiberProduct" );

##
AddDerivationToCAP( BiasedWeakFiberProduct,
                    
  function( cat, alpha, beta )
    
    return Source( ProjectionOfBiasedWeakFiberProduct( cat, alpha, beta ) );
    
end : Description := "BiasedWeakFiberProduct as the source of ProjectionOfBiasedWeakFiberProduct" );


##
AddDerivationToCAP( WeakBiPushout,
                    
  function( cat, alpha, beta )
    
    return Range( InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta ) );
    
end : Description := "WeakBiPushout as the range of InjectionOfFirstCofactorOfWeakBiPushout" );

##
AddDerivationToCAP( WeakBiPushout,
                    
  function( cat, alpha, beta )
    
    return Range( InjectionOfSecondCofactorOfWeakBiPushout( cat, alpha, beta ) );
    
end : Description := "WeakBiPushout as the range of InjectionOfSecondCofactorOfWeakBiPushout" );

##
AddDerivationToCAP( BiasedWeakPushout,
                    
  function( cat, alpha, beta )
    
    return Range( InjectionOfBiasedWeakPushout( cat, alpha, beta ) );
    
end : Description := "BiasedWeakPushout as the range of InjectionOfBiasedWeakPushout" );


## abelian derivations

##
AddDerivationToCAP( IsMonomorphism,
                    
  function( cat, alpha )
      
      return IsZeroForMorphisms( cat, WeakKernelEmbedding( cat, alpha ) );
      
end : Description := "IsMonomorphism by deciding whether WeakKernelEmbedding is zero" );

##
AddDerivationToCAP( IsEpimorphism,
                    
  function( cat, alpha )
      
      return IsZeroForMorphisms( cat, WeakCokernelProjection( cat, alpha ) );
      
end : Description := "IsEpimorphism by deciding whether WeakCokernelProjection is zero" );

##
AddDerivationToCAP( SomeProjectiveObjectForKernelObject,
                    
  function( cat, morphism )
    
    return Source( EpimorphismFromSomeProjectiveObjectForKernelObject( cat, morphism ) );
    
end : Description := "SomeProjectiveObjectForKernelObject as the source of EpimorphismFromSomeProjectiveObjectForKernelObject" );

##
AddDerivationToCAP( WeakBiFiberProductMorphismToDirectSum,
                    
  function( cat, alpha, beta )
    local projection_1, projection_2;
    
    projection_1 := ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    projection_2 := ProjectionInSecondFactorOfWeakBiFiberProduct( cat, alpha, beta );
    
    return UniversalMorphismIntoDirectSum( cat, [ projection_1, projection_2 ] );
    
end : Description := "WeakBiFiberProductMorphismToDirectSum using UniversalMorphismIntoDirectSum of the two weak bi-fiber product projections" );

##
AddDerivationToCAP( DirectSumMorphismToWeakBiPushout,
                    
  function( cat, alpha, beta )
    local injection_1, injection_2;
    
    injection_1 := InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta );
    
    injection_2 := InjectionOfSecondCofactorOfWeakBiPushout( cat, alpha, beta );
    
    return UniversalMorphismFromDirectSum( cat, [ injection_1, injection_2 ] );
    
end : Description := "DirectSumMorphismToWeakBiPushout using UniversalMorphismFromDirectSum of the two weak bi-pushout injections" );

##
AddDerivationToCAP( WeakBiFiberProduct,
                    
  function( cat, alpha, beta )
    
    return Source( WeakBiFiberProductMorphismToDirectSum( cat, alpha, beta ) );
    
end : Description := "WeakBiFiberProduct as the source of WeakBiFiberProductMorphismToDirectSum" );

##
AddDerivationToCAP( WeakBiPushout,
                    
  function( cat, alpha, beta )
    
    return Range( DirectSumMorphismToWeakBiPushout( cat, alpha, beta ) );
    
end : Description := "WeakBiPushout as the range of DirectSumMorphismToWeakBiPushout" );

## Final derivations

##
AddFinalDerivationBundle( # WeakKernelObject,
                    [ [ KernelObject, 1 ],
                      [ KernelEmbedding, 1 ],
                      [ KernelLift, 1 ] ],
                    
                    [ WeakKernelObject,
                      WeakKernelEmbedding,
                      WeakKernelLift ],
[
  WeakKernelObject,
  function( cat, morphism )
    
    return KernelObject( cat, morphism );
    
  end
],
[
  WeakKernelEmbedding,
  function( cat, morphism )
    
    return KernelEmbedding( cat, morphism );
    
  end
],
[
  WeakKernelLift,
  function( cat, morphism, test_mor )
    
    return KernelLift( cat, morphism, test_mor );
    
  end
] : Description := "weak kernel using kernel" );

##
AddFinalDerivationBundle( # WeakCokernelObject,
                    [ [ CokernelObject, 1 ],
                      [ CokernelProjection, 1 ],
                      [ CokernelColift, 1 ] ],
                    
                    [ WeakCokernelObject,
                      WeakCokernelProjection,
                      WeakCokernelColift ],
[
  WeakCokernelObject,
  function( cat, morphism )
    
    return CokernelObject( cat, morphism );
    
  end
],
[
  WeakCokernelProjection,
  function( cat, morphism )
    
    return CokernelProjection( cat, morphism );
    
  end
],
[
  WeakCokernelColift,
  function( cat, morphism, test_mor )
    
    return CokernelColift( cat, morphism, test_mor );
    
  end
] : Description := "weak cokernel using cokernel" );

## Final derivation for weak fiber products and weak pushouts.
## Decision: we use a derivation from weak kernels and direct sums

##
AddFinalDerivationBundle( # WeakBiFiberProductMorphismToDirectSum,
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
  function( cat, alpha, beta )
    local morphism_to_direct_sum;
    
    morphism_to_direct_sum := WeakBiFiberProductMorphismToDirectSum( cat, alpha, beta );
    
    return PreCompose( cat, morphism_to_direct_sum, ProjectionInFactorOfDirectSum( cat, [ Source( alpha ), Source( beta ) ], 1 ) );
    
  end
],
[
  ProjectionInSecondFactorOfWeakBiFiberProduct,
  function( cat, alpha, beta )
    local morphism_to_direct_sum;
    
    morphism_to_direct_sum := WeakBiFiberProductMorphismToDirectSum( cat, alpha, beta );
    
    return PreCompose( cat, morphism_to_direct_sum, ProjectionInFactorOfDirectSum( cat, [ Source( alpha ), Source( beta ) ], 2 ) );
    
  end
],
[
  UniversalMorphismIntoWeakBiFiberProduct,
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
] : Description := "WeakBiFiberProductMorphismToDirectSum via WeakKernelEmbedding and direct sum" );

## weak bi-pushout
##
AddFinalDerivationBundle( # DirectSumMorphismToWeakBiPushout,
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
  function( cat, alpha, beta )
    local direct_sum_morphism;
    
    direct_sum_morphism := DirectSumMorphismToWeakBiPushout( cat, alpha, beta );
    
    return PreCompose( cat, InjectionOfCofactorOfDirectSum( cat, [ Range( alpha ), Range( beta ) ], 1 ), direct_sum_morphism );
    
  end
],
[
  InjectionOfSecondCofactorOfWeakBiPushout,
  function( cat, alpha, beta )
    local direct_sum_morphism;
    
    direct_sum_morphism := DirectSumMorphismToWeakBiPushout( cat, alpha, beta );
    
    return PreCompose( cat, InjectionOfCofactorOfDirectSum( cat, [ Range( alpha ), Range( beta ) ], 2 ), direct_sum_morphism );
    
  end
],
[
  UniversalMorphismFromWeakBiPushout,
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
] : Description := "DirectSumMorphismToWeakBiPushout via WeakCokernelProjection and direct sum" );

## Final derivation for biased weak fiber products and biased weak pushouts.
## Decision: we use a derivation from weak fiber products and weak pushouts

##
AddFinalDerivation( ProjectionOfBiasedWeakFiberProduct,
                    [ [ ProjectionInFirstFactorOfWeakBiFiberProduct, 1 ] ],
                    [
                      BiasedWeakFiberProduct,
                      ProjectionOfBiasedWeakFiberProduct,
                    ],
                    
  function( cat, alpha, beta )
    
    return ProjectionInFirstFactorOfWeakBiFiberProduct( cat, alpha, beta );

end : Description := "ProjectionOfBiasedWeakFiberProduct using ProjectionInFirstFactorOfWeakBiFiberProduct" );

##
AddFinalDerivation( InjectionOfBiasedWeakPushout,
                    [ [ InjectionOfFirstCofactorOfWeakBiPushout, 1 ] ],
                    [
                      BiasedWeakPushout,
                      InjectionOfBiasedWeakPushout,
                    ],
                    
  function( cat, alpha, beta )
    
    return InjectionOfFirstCofactorOfWeakBiPushout( cat, alpha, beta );

end : Description := "ProjectioInjectionOfBiasedWeakPushoutnOfBiasedWeakFiberProduct using InjectionOfFirstCofactorOfWeakBiPushout" );
