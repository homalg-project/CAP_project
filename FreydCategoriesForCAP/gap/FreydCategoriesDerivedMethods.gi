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
    
end : );

## Derivations for basic operations without existing WithGiven
##
AddDerivationToCAP( WeakKernelObject,
                    
  function( mor )
    
    return Source( WeakKernelEmbedding( mor ) );
    
end : Description := "WeakKernelObject as the source of WeakKernelEmbedding" );

##
AddDerivationToCAP( WeakKernelLift,
                    
  function( mor, test_mor )
    
    return Lift( test_mor, WeakKernelEmbedding( mor ) );
    
end : Description := "WeakKernelLift as Lift of WeakKernelEmbedding" );

##
AddDerivationToCAP( WeakCokernelObject,
                    
  function( mor )
    
    return Range( WeakCokernelProjection( mor ) );
    
end : Description := "WeakCokernelObject as the range of WeakCokernelProjection" );

##
AddDerivationToCAP( WeakCokernelColift,
                    
  function( mor, test_mor )
    
    return Colift( WeakCokernelProjection( mor ), test_mor );
    
end : Description := "WeakCokernelColift as Colift of WeakCokernelProjection" );

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
AddDerivationToCAP( WeakBiPushout,
                    
  function( alpha, beta )
    
    return Range( InjectionOfFirstCofactorOfWeakBiPushout( alpha, beta ) );
    
end : Description := "WeakBiPushout as the range of InjectionOfFirstCofactorOfWeakBiPushout" );

##
AddDerivationToCAP( WeakBiPushout,
                    
  function( alpha, beta )
    
    return Range( InjectionOfSecondCofactorOfWeakBiPushout( alpha, beta ) );
    
end : Description := "WeakBiPushout as the range of InjectionOfSecondCofactorOfWeakBiPushout" );

## abelian derivations

##
AddDerivationToCAP( IsMonomorphism,
                    
  function( alpha )
      
      return IsZero( WeakKernelEmbedding( alpha ) );
      
end : Description := "IsMonomorphism by deciding whether WeakKernelEmbedding is zero" );

##
AddDerivationToCAP( IsEpimorphism,
                    
  function( alpha )
      
      return IsZero( WeakCokernelProjection( alpha ) );
      
end : Description := "IsEpimorphism by deciding whether WeakCokernelProjection is zero" );

##
AddDerivationToCAP( SomeProjectiveObjectForKernelObject,
                    
  function( morphism )
    
    return Source( EpimorphismFromSomeProjectiveObjectForKernelObject( morphism ) );
    
end : Description := "SomeProjectiveObjectForKernelObject as the source of EpimorphismFromSomeProjectiveObjectForKernelObject" );
