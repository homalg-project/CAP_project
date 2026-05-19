# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( LeftDistributivityExpandingWithGivenObjects,
                   "LeftDistributivityExpandingWithGivenObjects using the universal property of the direct sum",
                   [ [ IdentityMorphism, 1 ],
                     [ DirectSum, 1 ],
                     [ ProjectionInFactorOfDirectSumWithGivenDirectSum, 2 ],
                     [ TensorProductOnMorphismsWithGivenTensorProducts, 2 ],
                     [ TensorProductOnObjects, 2 ],
                     [ UniversalMorphismIntoDirectSumWithGivenDirectSum, 1 ] ],
                    
  function( cat, factored_object, object, summands, expanded_object )
    local nr_summands, id, diagram, sum_of_summands, projection_list, projection_list_tensored;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    diagram := List( [ 1 .. nr_summands ], i -> TensorProductOnObjects( cat, object, summands[i] ) );
    
    sum_of_summands := DirectSum( cat, summands );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSumWithGivenDirectSum( cat, summands, i, sum_of_summands ) );
    
    projection_list_tensored := List( [1 .. nr_summands ],
                                      i -> TensorProductOnMorphismsWithGivenTensorProducts( cat,
                                                    factored_object,
                                                    id,
                                                    projection_list[i],
                                                    diagram[i] ) );
    
    return UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, diagram, factored_object, projection_list_tensored, expanded_object );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( LeftDistributivityExpandingUsingMultiplicitiesWithGivenObjects,
                    "LeftDistributivityExpandingUsingMultiplicitiesWithGivenObjects using LeftDistributivityExpandingWithGivenObjects",
                    [ [ LeftDistributivityExpandingWithGivenObjects, 1 ] ],
                    
  function( cat, factored_object, object, summands, multiplicities, expanded_object )
    
    return LeftDistributivityExpandingWithGivenObjects( cat,
                factored_object,
                object,
                Concatenation( List( [ 1 .. Length( summands ) ], i -> ListWithIdenticalEntries( multiplicities[i], summands[i] ) ) ),
                expanded_object );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( LeftDistributivityFactoringWithGivenObjects,
                    "LeftDistributivityFactoringWithGivenObjects using the universal property of the direct sum",
                    [ [ IdentityMorphism, 1 ],
                      [ DirectSum, 1 ],
                      [ InjectionOfCofactorOfDirectSumWithGivenDirectSum, 2 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 2 ],
                      [ TensorProductOnObjects, 2 ],
                      [ UniversalMorphismFromDirectSumWithGivenDirectSum, 1 ] ],
                    
  function( cat, expanded_object, object, summands, factored_object )
    local nr_summands, id, diagram, sum_of_summands, injection_list, injection_list_tensored;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    diagram := List( [ 1 .. nr_summands ], i -> TensorProductOnObjects( cat, object, summands[i] ) );
    
    sum_of_summands := DirectSum( cat, summands );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSumWithGivenDirectSum( cat, summands, i, sum_of_summands ) );
    
    injection_list_tensored := List( [1 .. nr_summands ],
                                     i -> TensorProductOnMorphismsWithGivenTensorProducts( cat,
                                                    diagram[i],
                                                    id,
                                                    injection_list[i],
                                                    factored_object ) );
    
    return UniversalMorphismFromDirectSumWithGivenDirectSum( cat, diagram, factored_object, injection_list_tensored, expanded_object );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( LeftDistributivityFactoringUsingMultiplicitiesWithGivenObjects,
                    "LeftDistributivityFactoringUsingMultiplicitiesWithGivenObjects using LeftDistributivityFactoringWithGivenObjects",
                    [ [ LeftDistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, expanded_object, object, summands, multiplicities, factored_object )
    
    return LeftDistributivityFactoringWithGivenObjects( cat,
                expanded_object,
                object,
                Concatenation( List( [ 1 .. Length( summands ) ], i -> ListWithIdenticalEntries( multiplicities[i], summands[i] ) ) ),
                factored_object );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( RightDistributivityExpandingWithGivenObjects,
                    "RightDistributivityExpandingWithGivenObjects using the universal property of the direct sum",
                    [ [ IdentityMorphism, 1 ],
                      [ DirectSum, 1 ],
                      [ ProjectionInFactorOfDirectSumWithGivenDirectSum, 2 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 2 ],
                      [ TensorProductOnObjects, 2 ],
                      [ UniversalMorphismIntoDirectSumWithGivenDirectSum, 1 ] ],
                    
  function( cat, factored_object, summands, object, expanded_object )
    local nr_summands, id, diagram, sum_of_summands, projection_list, projection_list_tensored;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    diagram := List( [ 1 .. nr_summands ], i -> TensorProductOnObjects( cat, summands[i], object ) );
    
    sum_of_summands := DirectSum( cat, summands );
    
    projection_list := List( [ 1 .. nr_summands ], i -> ProjectionInFactorOfDirectSumWithGivenDirectSum( cat, summands, i, sum_of_summands ) );
    
    projection_list_tensored := List( [1 .. nr_summands ],
                                      i -> TensorProductOnMorphismsWithGivenTensorProducts( cat,
                                                    factored_object,
                                                    projection_list[i],
                                                    id,
                                                    diagram[i] ) );
    
    return UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, diagram, factored_object, projection_list_tensored, expanded_object );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( RightDistributivityExpandingUsingMultiplicitiesWithGivenObjects,
                    "RightDistributivityExpandingUsingMultiplicitiesWithGivenObjects using RightDistributivityExpandingWithGivenObjects",
                    [ [ RightDistributivityExpandingWithGivenObjects, 1 ] ],
                    
  function( cat, factored_object, summands, multiplicities, object, expanded_object )
    
    return RightDistributivityExpandingWithGivenObjects( cat,
                factored_object,
                Concatenation( List( [ 1 .. Length( summands ) ], i -> ListWithIdenticalEntries( multiplicities[i], summands[i] ) ) ),
                object,
                expanded_object );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( RightDistributivityFactoringWithGivenObjects,
                    "RightDistributivityFactoringWithGivenObjects using the universal property of the direct sum",
                    [ [ IdentityMorphism, 1 ],
                      [ DirectSum, 1 ],
                      [ InjectionOfCofactorOfDirectSumWithGivenDirectSum, 2 ],
                      [ TensorProductOnMorphismsWithGivenTensorProducts, 2 ],
                      [ TensorProductOnObjects, 2 ],
                      [ UniversalMorphismFromDirectSumWithGivenDirectSum, 1 ] ],
                    
  function( cat, expanded_object, summands, object, factored_object )
    local nr_summands, id, diagram, sum_of_summands, injection_list, injection_list_tensored;
    
    nr_summands := Length( summands );
    
    id := IdentityMorphism( cat, object );
    
    diagram := List( [ 1 .. nr_summands ], i -> TensorProductOnObjects( cat, summands[i], object ) );
    
    sum_of_summands := DirectSum( cat, summands );
    
    injection_list := List( [ 1 .. nr_summands ], i -> InjectionOfCofactorOfDirectSumWithGivenDirectSum( cat, summands, i, sum_of_summands ) );
    
    injection_list_tensored := List( [1 .. nr_summands ],
                                     i -> TensorProductOnMorphismsWithGivenTensorProducts( cat,
                                                    diagram[i],
                                                    injection_list[i],
                                                    id,
                                                    factored_object ) );
    
    return UniversalMorphismFromDirectSumWithGivenDirectSum( cat, diagram, factored_object, injection_list_tensored, expanded_object );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

##
AddDerivationToCAP( RightDistributivityFactoringUsingMultiplicitiesWithGivenObjects,
                    "RightDistributivityFactoringUsingMultiplicitiesWithGivenObjects using RightDistributivityFactoringWithGivenObjects",
                    [ [ RightDistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, expanded_object, summands, multiplicities, object, factored_object )
    return RightDistributivityFactoringWithGivenObjects( cat,
                expanded_object,
                Concatenation( List( [ 1 .. Length( summands ) ], i -> ListWithIdenticalEntries( multiplicities[i], summands[i] ) ) ),
                object,
                factored_object );
    
end : CategoryFilter := cat -> HasIsMonoidalCategory( cat ) and IsMonoidalCategory( cat ) and HasIsAdditiveCategory( cat ) and IsAdditiveCategory( cat ) );

