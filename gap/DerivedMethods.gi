# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( DirectProductOnMorphismsWithGivenDirectProducts,
  function( cat, s, alpha, beta, r )
    
    return DirectProductFunctorialWithGivenDirectProducts( s, [ alpha, beta ], r );

end : Description := "TensorProductOnMorphisms is DirectProductFunctorial",
      CategoryFilter := IsCartesianCategory );

##
AddDerivationToCAP( CoproductOnMorphismsWithGivenCoproducts,
  function( cat, s, alpha, beta, r )
    
    return CoproductFunctorialWithGivenCoproducts( s, [ alpha, beta ], r );

end : Description := "CoproductOnMorphisms is CoproductFunctorial",
      CategoryFilter := IsCocartesianCategory );

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
                    [ [ PreCompose, 2 ],
                      [ DirectProduct, 2 ],
                      [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 4 ],
                      [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 2 ] ],
                 
  function( cat, s, a, b, c, r )
    local D, bc, pi_b, pi_c, pi_a, pi_bc, ab, pi_ab;
    
    D := [ b, c ];
    
    bc := DirectProduct( D );
    
    pi_b := ProjectionInFactorOfDirectProductWithGivenDirectProduct( D, 1, bc );
    pi_c := ProjectionInFactorOfDirectProductWithGivenDirectProduct( D, 2, bc );
    
    D := [ a, bc ];
    
    pi_a := ProjectionInFactorOfDirectProductWithGivenDirectProduct( D, 1, s );
    pi_bc := ProjectionInFactorOfDirectProductWithGivenDirectProduct( D, 2, s );
    
    pi_b := PreCompose( pi_bc, pi_b );
    pi_c := PreCompose( pi_bc, pi_c );
    
    D := [ a, b ];
    
    ab := DirectProduct( D );
    
    pi_ab := UniversalMorphismIntoDirectProductWithGivenDirectProduct( D, [ pi_a, pi_b ], ab );
    
    D := [ ab, c ];
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( D, [ pi_ab, pi_c ], r );
    
end : Description := "CartesianAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts using the universal morphism into direct product");

##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
                    [ [ PreCompose, 2 ],
                      [ DirectProduct, 2 ],
                      [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 4 ],
                      [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 2 ] ],
                 
  function( cat, s, a, b, c, r )
    local D, ab, pi_a, pi_b, pi_ab, pi_c, bc, pi_bc;
    
    D := [ a, b ];
    
    ab := DirectProduct( D );
    
    pi_a := ProjectionInFactorOfDirectProductWithGivenDirectProduct( D, 1, ab );
    pi_b := ProjectionInFactorOfDirectProductWithGivenDirectProduct( D, 2, ab );
    
    D := [ ab, c ];
    
    pi_ab := ProjectionInFactorOfDirectProductWithGivenDirectProduct( D, 1, s );
    pi_c := ProjectionInFactorOfDirectProductWithGivenDirectProduct( D, 2, s );
    
    pi_a := PreCompose( pi_ab, pi_a );
    pi_b := PreCompose( pi_ab, pi_b );
    
    D := [ b, c ];
    
    bc := DirectProduct( D );
    
    pi_bc := UniversalMorphismIntoDirectProductWithGivenDirectProduct( D, [ pi_b, pi_c ], bc );
    
    D := [ a, bc ];
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( D, [ pi_a, pi_bc ], r );
    
end : Description := "CartesianAssociatorLeftToRightWithGivenDirectProducts using the universal morphism into direct product");

##
AddDerivationToCAP( SubobjectOfClassifyingMorphism,
                    [ [ TruthMorphismOfTrueWithGivenObjects , 1 ],
                      [ ProjectionInFactorOfFiberProduct , 1 ] ],
  function( cat, mor )

      local category, truth;

      category := CapCategory(mor);

      truth := TruthMorphismOfTrueWithGivenObjects(
                  TerminalObject(category), SubobjectClassifier(category));

      return ProjectionInFactorOfFiberProduct([ mor , truth ], 1);

end : Description := "SubobjectOfClassifyingMorphism using the fiber product along the true morphism" );

## Final derivations

##
AddFinalDerivation( CanonicalIdentificationFromImageObjectToCoimage,
                    [ [ ImageObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ CanonicalIdentificationFromCoimageToImageObject,
                      CanonicalIdentificationFromImageObjectToCoimage,
                      Coimage,
                      CoimageProjection,
                      CoimageProjectionWithGivenCoimage,
                      AstrictionToCoimage,
                      AstrictionToCoimageWithGivenCoimage,
                      UniversalMorphismIntoCoimage,
                      UniversalMorphismIntoCoimageWithGivenCoimage,
                      IsomorphismFromCoimageToCokernelOfKernel,
                      IsomorphismFromCokernelOfKernelToCoimage ],
                    
  function( cat, mor )
    
    return IdentityMorphism( ImageObject( mor ) );
    
  end,
  [
    CanonicalIdentificationFromCoimageToImageObject,
    function( cat, mor )
    
      return IdentityMorphism( ImageObject( mor ) );
    
    end
  ] : CategoryFilter := HasIsElementaryTopos and IsElementaryTopos );

##
AddDerivationToCAP( TruthMorphismOfTrueWithGivenObjects,
  function( cat, T, Omega )
    
    return ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier(
                   IdentityMorphism( cat, T ),
                   Omega );
    
end );
