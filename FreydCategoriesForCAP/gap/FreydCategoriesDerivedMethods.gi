#############################################################################
##
##     FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
##
##  Copyright 2018, Sebastian Posur, University of Siegen
##
#############################################################################

## Derivations for basic operations with existing WithGiven

##
AddWithGivenDerivationPairToCAP( ProjectionInSecondFactorOfWeakBiFiberProduct,
                    
  function( alpha, beta )
    local first_projection;
    
    first_projection := ProjectionInFirstFactorOfWeakBiFiberProduct( alpha, beta );
    
    return Lift( PreCompose( first_projection, alpha ), beta );
    
end : Description := "ProjectionInSecondFactorOfWeakBiFiberProduct using ProjectionInFirstFactorOfWeakBiFiberProduct and Lift" );

##
AddWithGivenDerivationPairToCAP( ProjectionInFirstFactorOfWeakBiFiberProduct,
                    
  function( alpha, beta )
    local second_projection;
    
    second_projection := ProjectionInSecondFactorOfWeakBiFiberProduct( alpha, beta );
    
    return Lift( PreCompose( second_projection, beta ), alpha );
    
end : Description := "ProjectionInFirstFactorOfWeakBiFiberProduct using ProjectionInSecondFactorOfWeakBiFiberProduct and Lift" );

##
AddWithGivenDerivationPairToCAP( InjectionOfSecondCofactorOfWeakBiPushout,
                    
  function( alpha, beta )
    local first_injection;
    
    first_injection := InjectionOfFirstCofactorOfWeakBiPushout( alpha, beta );
    
    return Colift( beta, PreCompose( alpha, first_injection ) );
    
end : Description := "InjectionOfSecondCofactorOfWeakBiPushout using InjectionOfFirstCofactorOfWeakBiPushout and Colift" );

##
AddWithGivenDerivationPairToCAP( InjectionOfFirstCofactorOfWeakBiPushout,
                    
  function( alpha, beta )
    local second_injection;
    
    second_injection := InjectionOfSecondCofactorOfWeakBiPushout( alpha, beta );
    
    return Colift( alpha, PreCompose( beta, second_injection ) );
    
end : Description := "InjectionOfFirstCofactorOfWeakBiPushout using InjectionOfSecondCofactorOfWeakBiPushout and Colift" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoWeakBiFiberProduct,
                                 
  function( alpha, beta, test_mor_1, test_mor_2 )
    local projection_1, projection_2;
    
    projection_1 := ProjectionInFirstFactorOfWeakBiFiberProduct( alpha, beta );
    
    projection_2 := ProjectionInSecondFactorOfWeakBiFiberProduct( alpha, beta );
    
    return Lift( UniversalMorphismIntoDirectSum( [ test_mor_1, test_mor_2 ] ),
                 UniversalMorphismIntoDirectSum( [ projection_1, projection_2 ] ) );
    
end : Description := "UniversalMorphismIntoWeakBiFiberProduct using Lift" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismIntoBiasedWeakFiberProduct,
                                 
  function( alpha, beta, test_mor )
    
    return Lift( test_mor,
                 ProjectionOfBiasedWeakFiberProduct( alpha, beta ) );
    
end : Description := "UniversalMorphismIntoBiasedWeakFiberProduct using Lift" );


##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromWeakBiPushout,
                                 
  function( alpha, beta, test_mor_1, test_mor_2 )
    local injection_1, injection_2;
    
    injection_1 := InjectionOfFirstCofactorOfWeakBiPushout( alpha, beta );
    
    injection_2 := InjectionOfSecondCofactorOfWeakBiPushout( alpha, beta );
    
    return Colift( UniversalMorphismFromDirectSum( [ injection_1, injection_2 ] ),
                   UniversalMorphismFromDirectSum( [ test_mor_1, test_mor_2 ] ) );
    
end : Description := "UniversalMorphismFromWeakBiPushout using Colift" );

##
AddWithGivenDerivationPairToCAP( UniversalMorphismFromBiasedWeakPushout,
                                 
  function( alpha, beta, test_mor )
    
    return Colift( InjectionOfBiasedWeakPushout( alpha, beta ),
                   test_mor );
    
end : Description := "UniversalMorphismFromBiasedWeakPushout using Colift" );

##
AddWithGivenDerivationPairToCAP( WeakKernelLift,
                                 
  function( mor, test_mor )
    
    return Lift( test_mor, WeakKernelEmbedding( mor ) );
    
end : Description := "WeakKernelLift as Lift of WeakKernelEmbedding" );

##
AddWithGivenDerivationPairToCAP( WeakCokernelColift,
                                 
  function( mor, test_mor )
    
    return Colift( WeakCokernelProjection( mor ), test_mor );
    
end : Description := "WeakCokernelColift as Colift of WeakCokernelProjection" );


## Derivations for basic operations without existing WithGiven
##
AddDerivationToCAP( WeakKernelObject,
                    
  function( mor )
    
    return Source( WeakKernelEmbedding( mor ) );
    
end : Description := "WeakKernelObject as the source of WeakKernelEmbedding" );

##
AddDerivationToCAP( WeakCokernelObject,
                    
  function( mor )
    
    return Range( WeakCokernelProjection( mor ) );
    
end : Description := "WeakCokernelObject as the range of WeakCokernelProjection" );

##
AddDerivationToCAP( WeakBiFiberProduct,
                    
  function( alpha, beta )
    
    return Source( ProjectionInFirstFactorOfWeakBiFiberProduct( alpha, beta ) );
    
end : Description := "WeakBiFiberProduct as the source of ProjectionInFirstFactorOfWeakBiFiberProduct" );

##
AddDerivationToCAP( WeakBiFiberProduct,
                    
  function( alpha, beta )
    
    return Source( ProjectionInSecondFactorOfWeakBiFiberProduct( alpha, beta ) );
    
end : Description := "WeakBiFiberProduct as the source of ProjectionInSecondFactorOfWeakBiFiberProduct" );

##
AddDerivationToCAP( BiasedWeakFiberProduct,
                    
  function( alpha, beta )
    
    return Source( ProjectionOfBiasedWeakFiberProduct( alpha, beta ) );
    
end : Description := "BiasedWeakFiberProduct as the source of ProjectionOfBiasedWeakFiberProduct" );


##
AddDerivationToCAP( WeakBiPushout,
                    
  function( alpha, beta )
    
    return Range( InjectionOfFirstCofactorOfWeakBiPushout( alpha, beta ) );
    
end : Description := "WeakBiPushout as the range of InjectionOfFirstCofactorOfWeakBiPushout" );

##
AddDerivationToCAP( WeakBiPushout,
                    
  function( alpha, beta )
    
    return Range( InjectionOfSecondCofactorOfWeakBiPushout( alpha, beta ) );
    
end : Description := "WeakBiPushout as the range of InjectionOfSecondCofactorOfWeakBiPushout" );

##
AddDerivationToCAP( BiasedWeakPushout,
                    
  function( alpha, beta )
    
    return Range( InjectionOfBiasedWeakPushout( alpha, beta ) );
    
end : Description := "BiasedWeakPushout as the range of InjectionOfBiasedWeakPushout" );


## abelian derivations

##
AddDerivationToCAP( IsMonomorphism,
                    
  function( alpha )
      
      return IsZeroForMorphisms( WeakKernelEmbedding( alpha ) );
      
end : Description := "IsMonomorphism by deciding whether WeakKernelEmbedding is zero" );

##
AddDerivationToCAP( IsEpimorphism,
                    
  function( alpha )
      
      return IsZeroForMorphisms( WeakCokernelProjection( alpha ) );
      
end : Description := "IsEpimorphism by deciding whether WeakCokernelProjection is zero" );

##
AddDerivationToCAP( SomeProjectiveObjectForKernelObject,
                    
  function( morphism )
    
    return Source( EpimorphismFromSomeProjectiveObjectForKernelObject( morphism ) );
    
end : Description := "SomeProjectiveObjectForKernelObject as the source of EpimorphismFromSomeProjectiveObjectForKernelObject" );

##
AddDerivationToCAP( WeakBiFiberProductMorphismToDirectSum,
                    
  function( alpha, beta )
    local projection_1, projection_2;
    
    projection_1 := ProjectionInFirstFactorOfWeakBiFiberProduct( alpha, beta );
    
    projection_2 := ProjectionInSecondFactorOfWeakBiFiberProduct( alpha, beta );
    
    return UniversalMorphismIntoDirectSum( [ projection_1, projection_2 ] );
    
end : Description := "WeakBiFiberProductMorphismToDirectSum using UniversalMorphismIntoDirectSum of the two weak bi-fiber product projections" );

##
AddDerivationToCAP( DirectSumMorphismToWeakBiPushout,
                    
  function( alpha, beta )
    local injection_1, injection_2;
    
    injection_1 := InjectionOfFirstCofactorOfWeakBiPushout( alpha, beta );
    
    injection_2 := InjectionOfSecondCofactorOfWeakBiPushout( alpha, beta );
    
    return UniversalMorphismFromDirectSum( [ injection_1, injection_2 ] );
    
end : Description := "DirectSumMorphismToWeakBiPushout using UniversalMorphismFromDirectSum of the two weak bi-pushout injections" );

##
AddDerivationToCAP( WeakBiFiberProduct,
                    
  function( alpha, beta )
    
    return Source( WeakBiFiberProductMorphismToDirectSum( alpha, beta ) );
    
end : Description := "WeakBiFiberProduct as the source of WeakBiFiberProductMorphismToDirectSum" );

##
AddDerivationToCAP( WeakBiPushout,
                    
  function( alpha, beta )
    
    return Range( DirectSumMorphismToWeakBiPushout( alpha, beta ) );
    
end : Description := "WeakBiPushout as the range of DirectSumMorphismToWeakBiPushout" );

## Final derivations

##
AddFinalDerivation( WeakKernelObject,
                    [ [ KernelObject, 1 ] ],
                    [ WeakKernelObject,
                      WeakKernelEmbedding,
                      WeakKernelLift ],
                    
  function( morphism )
    
    return KernelObject( morphism );
    
end : Description := "WeakKernelObject as KernelObject" );

##
AddFinalDerivation( WeakKernelEmbedding,
                    [ [ KernelEmbedding, 1 ] ],
                    [ WeakKernelObject,
                      WeakKernelEmbedding,
                      WeakKernelLift ],
                    
  function( morphism )
    
    return KernelEmbedding( morphism );
    
end : Description := "WeakKernelEmbedding as KernelEmbedding" );

##
AddFinalDerivation( WeakKernelLift,
                    [ [ KernelLift, 1 ] ],
                    [ WeakKernelObject,
                      WeakKernelEmbedding,
                      WeakKernelLift ],
                    
  function( morphism, test_mor )
    
    return KernelLift( morphism, test_mor );
    
end : Description := "WeakKernelLift as KernelLift" );

##
AddFinalDerivation( WeakCokernelObject,
                    [ [ CokernelObject, 1 ] ],
                    [ WeakCokernelObject,
                      WeakCokernelProjection,
                      WeakCokernelColift ],
                    
  function( morphism )
    
    return CokernelObject( morphism );
    
end : Description := "WeakCokernelObject as CokernelObject" );

##
AddFinalDerivation( WeakCokernelProjection,
                    [ [ CokernelProjection, 1 ] ],
                    [ WeakCokernelObject,
                      WeakCokernelProjection,
                      WeakCokernelColift ],
                    
  function( morphism )
    
    return CokernelProjection( morphism );
    
end : Description := "WeakCokernelProjection as CokernelProjection" );

##
AddFinalDerivation( WeakCokernelColift,
                    [ [ CokernelColift, 1 ] ],
                    [ WeakCokernelObject,
                      WeakCokernelProjection,
                      WeakCokernelColift ],
                    
  function( morphism, test_mor )
    
    return CokernelColift( morphism, test_mor );
    
end : Description := "WeakCokernelColift as CokernelColift" );

## Final derivation for weak fiber products and weak pushouts.
## Decision: we use a derivation from weak kernels and direct sums

##
AddFinalDerivation( WeakBiFiberProductMorphismToDirectSum,
                    [ [ DirectSumDiagonalDifference, 1 ],
                      [ WeakKernelEmbedding, 1 ] ],
                    [ WeakBiFiberProduct ],
                      
  function( alpha, beta )
    local diagonal_difference;
    
    diagonal_difference := DirectSumDiagonalDifference( [ alpha, beta ] );
    
    return WeakKernelEmbedding( diagonal_difference );
    
end : Description := "WeakBiFiberProductMorphismToDirectSum as WeakKernelEmbedding of DirectSumDiagonalDifference" );

##
AddFinalDerivation( ProjectionInFirstFactorOfWeakBiFiberProduct,
                     [ [ WeakBiFiberProductMorphismToDirectSum, 1 ],
                       [ PreCompose, 1 ],
                       [ ProjectionInFactorOfDirectSum, 1 ] ],
                     [ ProjectionInFirstFactorOfWeakBiFiberProduct ],
                       
  function( alpha, beta )
    local morphism_to_direct_sum;
    
    morphism_to_direct_sum := WeakBiFiberProductMorphismToDirectSum( alpha, beta );
    
    return PreCompose( morphism_to_direct_sum, ProjectionInFactorOfDirectSum( [ Source( alpha ), Source( beta ) ], 1 ) );
    
end : Description := "ProjectionInFirstFactorOfWeakBiFiberProduct as composition of WeakBiFiberProductMorphismToDirectSum with the first direct sum projection" );

##
AddFinalDerivation( ProjectionInSecondFactorOfWeakBiFiberProduct,
                     [ [ WeakBiFiberProductMorphismToDirectSum, 1 ],
                       [ PreCompose, 1 ],
                       [ ProjectionInFactorOfDirectSum, 1 ] ],
                     [ ProjectionInSecondFactorOfWeakBiFiberProduct ],
                       
  function( alpha, beta )
    local morphism_to_direct_sum;
    
    morphism_to_direct_sum := WeakBiFiberProductMorphismToDirectSum( alpha, beta );
    
    return PreCompose( morphism_to_direct_sum, ProjectionInFactorOfDirectSum( [ Source( alpha ), Source( beta ) ], 2 ) );
    
end : Description := "ProjectionInSecondFactorOfWeakBiFiberProduct as composition of WeakBiFiberProductMorphismToDirectSum with the second direct sum projection" );

##
AddFinalDerivation( UniversalMorphismIntoWeakBiFiberProduct,
                    [ [ UniversalMorphismIntoDirectSum, 1 ],
                      [ DirectSumDiagonalDifference, 1 ],
                      [ WeakKernelLift, 1 ] ],
                    [ WeakBiFiberProduct ],
                    
  function( alpha, beta, test_mor_1, test_mor_2 )
    local test_mor, diagonal_difference;
    
    test_mor := UniversalMorphismIntoDirectSum( [ test_mor_1, test_mor_2 ] );
    
    diagonal_difference := DirectSumDiagonalDifference( [ alpha, beta ] );
    
    return WeakKernelLift( diagonal_difference, test_mor );
    
end : Description := "UniversalMorphismIntoWeakBiFiberProduct using WeakKernelLift" );


## weak bi-pushout
##
AddFinalDerivation( DirectSumMorphismToWeakBiPushout,
                    [ [ DirectSumCodiagonalDifference, 1 ],
                      [ WeakCokernelProjection, 1 ] ],
                    [ WeakBiPushout ],
                      
  function( alpha, beta )
    local co_diagonal_difference;
    
    co_diagonal_difference := DirectSumCodiagonalDifference( [ alpha, beta ] );
    
    return WeakCokernelProjection( co_diagonal_difference );
    
end : Description := "DirectSumMorphismToWeakBiPushout as WeakCokernelProjection of DirectSumCodiagonalDifference" );

## InjectionOfSecondCofactorOfWeakBiPushout
AddFinalDerivation( InjectionOfFirstCofactorOfWeakBiPushout,
                     [ [ DirectSumMorphismToWeakBiPushout, 1 ],
                       [ PreCompose, 1 ],
                       [ InjectionOfCofactorOfDirectSum, 1 ] ],
                     [ InjectionOfFirstCofactorOfWeakBiPushout ],
                       
  function( alpha, beta )
    local direct_sum_morphism;
    
    direct_sum_morphism := DirectSumMorphismToWeakBiPushout( alpha, beta );
    
    return PreCompose( InjectionOfCofactorOfDirectSum( [ Range( alpha ), Range( beta ) ], 1 ), direct_sum_morphism );
    
end : Description := "InjectionOfFirstCofactorOfWeakBiPushout as composition of first direct sum injection with DirectSumMorphismToWeakBiPushout" );

##
AddFinalDerivation( InjectionOfSecondCofactorOfWeakBiPushout,
                     [ [ DirectSumMorphismToWeakBiPushout, 1 ],
                       [ PreCompose, 1 ],
                       [ InjectionOfCofactorOfDirectSum, 1 ] ],
                     [ InjectionOfSecondCofactorOfWeakBiPushout ],
                       
  function( alpha, beta )
    local direct_sum_morphism;
    
    direct_sum_morphism := DirectSumMorphismToWeakBiPushout( alpha, beta );
    
    return PreCompose( InjectionOfCofactorOfDirectSum( [ Range( alpha ), Range( beta ) ], 2 ), direct_sum_morphism );
    
end : Description := "InjectionOfSecondCofactorOfWeakBiPushout as composition of second direct sum injection with DirectSumMorphismToWeakBiPushout" );

##
AddFinalDerivation( UniversalMorphismFromWeakBiPushout,
                    [ [ UniversalMorphismFromDirectSum, 1 ],
                      [ DirectSumCodiagonalDifference, 1 ],
                      [ WeakCokernelColift, 1 ] ],
                    [ WeakBiPushout ],
                    
  function( alpha, beta, test_mor_1, test_mor_2 )
    local test_mor, co_diagonal_difference;
    
    test_mor := UniversalMorphismFromDirectSum( [ test_mor_1, test_mor_2 ] );
    
    co_diagonal_difference := DirectSumCodiagonalDifference( [ alpha, beta ] );
    
    return WeakCokernelColift( co_diagonal_difference, test_mor );
    
end : Description := "UniversalMorphismFromWeakBiPushout using WeakCokernelColift" );


## Final derivation for biased weak fiber products and biased weak pushouts.
## Decision: we use a derivation from weak fiber products and weak pushouts

##
AddFinalDerivation( ProjectionOfBiasedWeakFiberProduct,
                    [ [ ProjectionInFirstFactorOfWeakBiFiberProduct, 1 ] ],
                    [ BiasedWeakFiberProduct ],
                    
  function( alpha, beta )
    
    return ProjectionInFirstFactorOfWeakBiFiberProduct( alpha, beta );

end : Description := "ProjectionOfBiasedWeakFiberProduct using ProjectionInFirstFactorOfWeakBiFiberProduct" );

##
AddFinalDerivation( InjectionOfBiasedWeakPushout,
                    [ [ InjectionOfFirstCofactorOfWeakBiPushout, 1 ] ],
                    [ BiasedWeakPushout ],
                    
  function( alpha, beta )
    
    return InjectionOfFirstCofactorOfWeakBiPushout( alpha, beta );

end : Description := "ProjectioInjectionOfBiasedWeakPushoutnOfBiasedWeakFiberProduct using InjectionOfFirstCofactorOfWeakBiPushout" );
