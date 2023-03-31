# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( LeftDistributivityExpandingWithGivenObjects,
                    "LeftDistributivityExpandingWithGivenObjects using the universal property of the direct sum",
                    [ [ IdentityMorphism, 1 ],
                      [ ProjectionInFactorOfDirectSum, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ TensorProductOnObjects, 2 ],
                      [ UniversalMorphismIntoDirectSum, 1 ] ],
                    
  function( cat, factored_object, object, summands, expanded_object )
    local nr_summands, projection_list, id, diagram;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSum( cat, summands, i ) );
    
    projection_list := List( projection_list, mor -> TensorProductOnMorphisms( cat, id, mor ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( cat, object, summand ) );
    
    return UniversalMorphismIntoDirectSum( cat, diagram, factored_object, projection_list );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( LeftDistributivityFactoringWithGivenObjects,
                    "LeftDistributivityFactoringWithGivenObjects using the universal property of the direct sum",
                    [ [ IdentityMorphism, 1 ],
                      [ InjectionOfCofactorOfDirectSum, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ TensorProductOnObjects, 2 ],
                      [ UniversalMorphismFromDirectSum, 1 ] ],
                    
  function( cat, expanded_object, object, summands, factored_object )
    local nr_summands, injection_list, id, diagram;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSum( cat, summands, i ) );
    
    injection_list := List( injection_list, mor -> TensorProductOnMorphisms( cat, id, mor ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( cat, object, summand ) );
    
    return UniversalMorphismFromDirectSum( cat, diagram, factored_object, injection_list );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( RightDistributivityExpandingWithGivenObjects,
                    "RightDistributivityExpandingWithGivenObjects using the universal property of the direct sum",
                    [ [ IdentityMorphism, 1 ],
                      [ ProjectionInFactorOfDirectSum, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ TensorProductOnObjects, 2 ],
                      [ UniversalMorphismIntoDirectSum, 1 ] ],
                    
  function( cat, factored_object, summands, object, expanded_object )
    local nr_summands, projection_list, id, diagram;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSum( cat, summands, i ) );
    
    projection_list := List( projection_list, mor -> TensorProductOnMorphisms( cat, mor, id ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( cat, summand, object ) );
    
    return UniversalMorphismIntoDirectSum( cat, diagram, factored_object, projection_list );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( RightDistributivityFactoringWithGivenObjects,
                    "RightDistributivityFactoringWithGivenObjects using the universal property of the direct sum",
                    [ [ IdentityMorphism, 1 ],
                      [ InjectionOfCofactorOfDirectSum, 2 ],
                      [ TensorProductOnMorphisms, 2 ],
                      [ TensorProductOnObjects, 2 ],
                      [ UniversalMorphismFromDirectSum, 1 ] ],
                    
  function( cat, expanded_object, summands, object, factored_object )
    local nr_summands, injection_list, id, diagram;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSum( cat, summands, i ) );
    
    injection_list := List( injection_list, mor -> TensorProductOnMorphisms( cat, mor, id ) );
    
    diagram := List( summands, summand -> TensorProductOnObjects( cat, summand, object ) );
    
    return UniversalMorphismFromDirectSum( cat, diagram, factored_object, injection_list );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );
