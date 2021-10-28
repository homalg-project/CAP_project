##
AddDerivationToCAP( MorphismLiftingMorphismsFromTensorUnit,
                    [ [ MorphismUniquelyLiftingMorphismsFromTensorUnit, 1 ] ],
                    
  function( cat, object )
    
    return MorphismUniquelyLiftingMorphismsFromTensorUnit( cat, object );
    
end : Description := "MorphismLiftingMorphismsFromTensorUnit using MorphismUniquelyLiftingMorphismsFromTensorUnit" );

##
AddDerivationToCAP( LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism,
                    [ [ LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism, 1 ] ],
                    
  function( cat, iota, eta )
    
    return LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism( cat, iota, eta );
    
end : Description := "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism using LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism" );

##
AddDerivationToCAP( LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism,
                    [ [ Lift, 1 ] ],
                    
  function( cat, iota, eta )
    
    return Lift( cat, iota, eta );
    
end : Description := "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism using Lift" );

##
AddDerivationToCAP( LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism,
                    [ [ Lift, 1 ] ],
                    
  function( cat, iota, eta )
    
    return Lift( cat, iota, eta );
    
end : Description := "LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism using Lift" );

####################################
## Final derived methods
####################################

##
AddFinalDerivation( MorphismUniquelyLiftingMorphismsFromTensorUnit,
                    [ 
                      ],
                    [ 
                      MorphismUniquelyLiftingMorphismsFromTensorUnit,
                      #LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism, # this will be overwritten below in any case, usually we do not overwrite already installed operations but the installation below is the fastest in any case
                      InterpretAsObjectInRangeCategoryOfHomomorphismStructure,
                      InterpretAsMorphismInRangeCategoryOfHomomorphismStructure,
                      InterpretObjectFromRangeCategoryOfHomomorphismStructure,
                      InterpretMorphismFromRangeCategoryOfHomomorphismStructure
                    ],
        
  function( cat, a )

    return IdentityMorphism( a );
    
  end,
[
  LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism,
  function( cat, iota, eta )
    
    return iota;
    
end
],
[
  InterpretAsObjectInRangeCategoryOfHomomorphismStructure,
  function( cat, h )
    
    return h;
    
end
],
[
  InterpretAsMorphismInRangeCategoryOfHomomorphismStructure,
  function( cat, alpha )
    
    return alpha;
    
end
],
[
  InterpretObjectFromRangeCategoryOfHomomorphismStructure,
  function( cat, o )
    
    return o;
    
end
],
[
  InterpretMorphismFromRangeCategoryOfHomomorphismStructure,
  
  function( cat, omega )
    
    return omega;
    
end
] : CategoryFilter := IsSymmetricClosedMonoidalCategory,
    Description := "adding the trivial bidirectional interpretation assuming a closed symmetric structure"
);

##
AddFinalDerivation( DistinguishedObjectOfHomomorphismStructure,
                    [ [ TensorUnit, 1 ],
                      [ InternalHomOnObjects, 1 ],
                      [ MorphismUniquelyLiftingMorphismsFromTensorUnit, 3 ],
                      [ InterpretAsObjectInRangeCategoryOfHomomorphismStructure, 2 ],
                      [ InternalHomOnMorphismsWithGivenInternalHoms, 1 ],
                      [ PreCompose, 2 ],
                      [ LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism, 2 ],
                      [ InterpretAsMorphismInRangeCategoryOfHomomorphismStructure, 2 ],
                      [ InterpretMorphismFromRangeCategoryOfHomomorphismStructure, 1 ],
                      [ LambdaIntroduction, 1 ],
                      [ LambdaElimination, 1 ],
                      ],
                    [
                      DistinguishedObjectOfHomomorphismStructure,
                      HomomorphismStructureOnObjects,
                      HomomorphismStructureOnMorphismsWithGivenObjects,
                      InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
                      InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
                    ],
        
  function( cat )
    local tensor_unit;
    
    tensor_unit := TensorUnit( cat );
    
    return InterpretAsObjectInRangeCategoryOfHomomorphismStructure( cat, tensor_unit );
    
  end,
[
  HomomorphismStructureOnObjects,
  function( cat, a, b )
    local internalhom, hom;
    
    internalhom := InternalHomOnObjects( cat, a, b );
    
    hom := MorphismUniquelyLiftingMorphismsFromTensorUnit( cat, internalhom );
    
    return InterpretAsObjectInRangeCategoryOfHomomorphismStructure( cat, Source( hom ) );
    
end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  function( cat, s, alpha, beta, r )
    local internalhom, eta_s, hom;
    
    internalhom := InternalHomOnMorphisms( cat, alpha, beta );
    
    eta_s := MorphismUniquelyLiftingMorphismsFromTensorUnit( cat, Source( internalhom ) );
    
    hom := LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit( cat, PreCompose( cat, eta_s, internalhom ) );

    return InterpretAsMorphismInRangeCategoryOfHomomorphismStructure( cat, hom );
    
end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
  function( cat, alpha )
    local iota;

    iota := LambdaIntroduction( cat, alpha );

    iota := LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit( cat, iota );
    
    return InterpretAsMorphismInRangeCategoryOfHomomorphismStructure( cat, iota );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  function( cat, a, b, iota )
    local internalhom;
    
    internalhom := InternalHomOnObjects( cat, a, b );
    
    iota := PreCompose( cat,
                    InterpretMorphismFromRangeCategoryOfHomomorphismStructure( cat, iota ),
                    MorphismUniquelyLiftingMorphismsFromTensorUnit( cat, internalhom ) );
    
    return LambdaElimination( cat, a, b, iota );
    
  end
] :
  Description := "adding the homomorphism structure using the closed structure and a bidirectional interpretation"
);
