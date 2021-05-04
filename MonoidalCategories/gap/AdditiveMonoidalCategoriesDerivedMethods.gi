##
AddDerivationToCAP( LeftDistributivityExpandingWithGivenObjects,
                    
  function( cat, factored_object, object, summands, expanded_object )
    local nr_summands, projection_list, id, diagram;
    
    nr_summands := Size( summands );
    
    id := IdentityMorphism( object );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSum( summands, i ) );
    
    projection_list := List( projection_list, mor -> TensorProductOnMorphisms( id, mor ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( object, summand ) );
    
    return UniversalMorphismIntoDirectSum( diagram, projection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "LeftDistributivityExpandingWithGivenObjects using the universal property of the direct sum" );

##
AddDerivationToCAP( LeftDistributivityFactoringWithGivenObjects,
                    
  function( cat, expanded_object, object, summands, factored_object )
    local nr_summands, injection_list, id, diagram;
    
    nr_summands := Size( summands );
    
    id := IdentityMorphism( object );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSum( summands, i ) );
    
    injection_list := List( injection_list, mor -> TensorProductOnMorphisms( id, mor ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( object, summand ) );
    
    return UniversalMorphismFromDirectSum( diagram, injection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "LeftDistributivityFactoringWithGivenObjects using the universal property of the direct sum" );

##
AddDerivationToCAP( RightDistributivityExpandingWithGivenObjects,
                    
  function( cat, factored_object, summands, object, expanded_object )
    local nr_summands, projection_list, id, diagram;
    
    nr_summands := Size( summands );
    
    id := IdentityMorphism( object );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSum( summands, i ) );
    
    projection_list := List( projection_list, mor -> TensorProductOnMorphisms( mor, id ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( summand, object ) );
    
    return UniversalMorphismIntoDirectSum( diagram, projection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "RightDistributivityExpandingWithGivenObjects using the universal property of the direct sum" );

##
AddDerivationToCAP( RightDistributivityFactoringWithGivenObjects,
                    
  function( cat, expanded_object, summands, object, factored_object )
    local nr_summands, injection_list, id, diagram;
    
    nr_summands := Size( summands );
    
    id := IdentityMorphism( object );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSum( summands, i ) );
    
    injection_list := List( injection_list, mor -> TensorProductOnMorphisms( mor, id ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( summand, object ) );
    
    return UniversalMorphismFromDirectSum( diagram, injection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "RightDistributivityFactoringWithGivenObjects using the universal property of the direct sum" );
