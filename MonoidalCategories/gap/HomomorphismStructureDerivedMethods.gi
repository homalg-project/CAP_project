##
AddDerivationToCAP( MorphismLiftingMorphismsFromTensorUnit,
                    [ [ MorphismUniquelyLiftingMorphismsFromTensorUnit, 1 ] ],
                    
  function( object )
    
    return MorphismUniquelyLiftingMorphismsFromTensorUnit( object );
    
end : Description := "MorphismLiftingMorphismsFromTensorUnit using MorphismUniquelyLiftingMorphismsFromTensorUnit" );

##
AddDerivationToCAP( LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism,
                    [ [ LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism, 1 ] ],
                    
  function( iota, eta )
    
    return LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism( iota, eta );
    
end : Description := "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism using LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism" );

##
AddDerivationToCAP( LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism,
                    [ [ Lift, 1 ] ],
                    
  function( iota, eta )
    
    return Lift( iota, eta );
    
end : Description := "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism using LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism" );

##
AddDerivationToCAP( LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism,
                    [ [ Lift, 1 ] ],
                    
  function( iota, eta )
    
    return Lift( iota, eta );
    
end : Description := "LiftAlongMorphismLiftingMorphismsFromTensorUnitWithGivenMorphism using LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnitWithGivenMorphism" );

####################################
## Final derived methods
####################################

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
    
    return InterpretAsObjectInRangeCategoryOfHomomorphismStructure( tensor_unit );
    
  end,
[
  HomomorphismStructureOnObjects,
  
  function( cat, a, b )
    local internalhom, hom;
    
    internalhom := InternalHomOnObjects( cat, a, b );
    
    hom := MorphismUniquelyLiftingMorphismsFromTensorUnit( internalhom );
    
    return InterpretAsObjectInRangeCategoryOfHomomorphismStructure( Source( hom ) );
    
end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  function( cat, s, alpha, beta, r )
    local internalhom, eta_s, hom;
    
    internalhom := InternalHomOnMorphisms( alpha, beta );
    
    eta_s := MorphismUniquelyLiftingMorphismsFromTensorUnit( Source( internalhom ) );
    
    hom := LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit( PreCompose( cat, eta_s, internalhom ) );

    return InterpretAsMorphismInRangeCategoryOfHomomorphismStructure( hom );
    
end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
  function( cat, alpha )
    local iota;

    iota := LambdaIntroduction( cat, alpha );

    iota := LiftAlongMorphismUniquelyLiftingMorphismsFromTensorUnit( iota );
    
    return InterpretAsMorphismInRangeCategoryOfHomomorphismStructure( iota );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  function( cat, a, b, iota )
    local internalhom;
    
    internalhom := InternalHomOnObjects( cat, a, b );
    
    iota := PreCompose( cat,
                    InterpretMorphismFromRangeCategoryOfHomomorphismStructure( cat, iota ),
                    MorphismUniquelyLiftingMorphismsFromTensorUnit( internalhom ) );
    
    return LambdaElimination( cat, a, b, iota );
    
  end
] :
  Description := "adding the homomorphism structure using the closed structure and a bidirectional interpretation"
);
