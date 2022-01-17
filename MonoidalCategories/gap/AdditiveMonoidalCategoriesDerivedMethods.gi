# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( LeftDistributivityExpandingWithGivenObjects,
                    
  function( cat, factored_object, object, summands, expanded_object )
    local nr_summands, projection_list, id, diagram;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSum( cat, summands, i ) );
    
    projection_list := List( projection_list, mor -> TensorProductOnMorphisms( cat, id, mor ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( cat, object, summand ) );
    
    return UniversalMorphismIntoDirectSum( cat, diagram, factored_object, projection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "LeftDistributivityExpandingWithGivenObjects using the universal property of the direct sum" );

##
AddDerivationToCAP( LeftDistributivityFactoringWithGivenObjects,
                    
  function( cat, expanded_object, object, summands, factored_object )
    local nr_summands, injection_list, id, diagram;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSum( cat, summands, i ) );
    
    injection_list := List( injection_list, mor -> TensorProductOnMorphisms( cat, id, mor ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( cat, object, summand ) );
    
    return UniversalMorphismFromDirectSum( cat, diagram, factored_object, injection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "LeftDistributivityFactoringWithGivenObjects using the universal property of the direct sum" );

##
AddDerivationToCAP( RightDistributivityExpandingWithGivenObjects,
                    
  function( cat, factored_object, summands, object, expanded_object )
    local nr_summands, projection_list, id, diagram;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSum( cat, summands, i ) );
    
    projection_list := List( projection_list, mor -> TensorProductOnMorphisms( cat, mor, id ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( cat, summand, object ) );
    
    return UniversalMorphismIntoDirectSum( cat, diagram, factored_object, projection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "RightDistributivityExpandingWithGivenObjects using the universal property of the direct sum" );

##
AddDerivationToCAP( RightDistributivityFactoringWithGivenObjects,
                    
  function( cat, expanded_object, summands, object, factored_object )
    local nr_summands, injection_list, id, diagram;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSum( cat, summands, i ) );
    
    injection_list := List( injection_list, mor -> TensorProductOnMorphisms( cat, mor, id ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( cat, summand, object ) );
    
    return UniversalMorphismFromDirectSum( cat, diagram, factored_object, injection_list );
    
end : CategoryFilter := IsMonoidalCategory and IsAdditiveCategory,
      Description := "RightDistributivityFactoringWithGivenObjects using the universal property of the direct sum" );
