# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



####################################
## Final derived methods
####################################

##
AddFinalDerivation( DistinguishedObjectOfHomomorphismStructure,
                    [ [ TerminalObject, 1 ],
                      [ ExponentialOnObjects, 1 ],
                      [ ExponentialOnMorphismsWithGivenExponentials, 1 ],
                      [ CartesianLambdaIntroduction, 1 ],
                      [ CartesianLambdaElimination, 1 ],
                      ],
                    [
                      DistinguishedObjectOfHomomorphismStructure,
                      HomomorphismStructureOnObjects,
                      HomomorphismStructureOnMorphismsWithGivenObjects,
                      InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
                      InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism
                    ],
        
  function ( cat )
    
    return TerminalObject( cat );
    
  end,
[
  HomomorphismStructureOnObjects,
  function ( cat, a, b )
    
    return ExponentialOnObjects( cat, a, b );
    
end
],
[
  HomomorphismStructureOnMorphismsWithGivenObjects,
  function ( cat, s, alpha, beta, r )
    
    return ExponentialOnMorphismsWithGivenExponentials( cat, s, alpha, beta, r );
    
end
],
[
  InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure,
  function( cat, alpha )
    local iota;
    
    return CartesianLambdaIntroduction( cat, alpha );
    
  end
],
[
  InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism,
  function ( cat, a, b, iota )
    
    return CartesianLambdaElimination( cat, a, b, iota );
    
  end
] : CategoryFilter := function( cat )
      return ( not HasRangeCategoryOfHomomorphismStructure( cat ) or
               ( WasCreatedAsWrapperCapCategory( cat ) and
                 IsIdenticalObj( ModelingCategory( cat ), RangeCategoryOfHomomorphismStructure( cat ) ) ) ) and
             not ( IsBound( cat!.do_not_use_cartesian_closed_structure_as_homomorphism_structure ) and
               IsIdenticalObj( cat!.do_not_use_cartesian_closed_structure_as_homomorphism_structure, true ) );
    end,
    FunctionCalledBeforeInstallation :=
      function( cat )
        SetRangeCategoryOfHomomorphismStructure( cat, cat );
        SetIsEquippedWithHomomorphismStructure( cat, true );
    end,
    Description := "adding the homomorphism structure using the closed cartesian structure"
);
