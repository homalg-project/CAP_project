#
# Toposes: derived methods
#
# Implementations
#

##
AddDerivationToCAP( AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts,
                    [ [ PreCompose, 2 ],
                      [ DirectProduct, 2 ],
                      [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 4 ],
                      [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 2 ] ],
                 
  function( s, a, b, c, r )
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
    
end : Description := "AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts using the universal morphism into direct product");

##
AddDerivationToCAP( AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts,
                    [ [ PreCompose, 2 ],
                      [ DirectProduct, 2 ],
                      [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 4 ],
                      [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 2 ] ],
                 
  function( s, a, b, c, r )
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
    
end : Description := "AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts using the universal morphism into direct product");

## TODO: Sebastian Posur explained why the following is dangerous
##       I included it here to gradually fix it

##
AddDerivationToCAP( TensorProductOnObjects,
                    
  function( arg )
    
    return CallFuncList( DirectProduct, arg );
    
end : Description := "TensorProductOnObjects is DirectProduct",
      CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( TensorProductOnMorphismsWithGivenTensorProducts,
                    
  function( s, alpha, beta, r )
    
    return DirectProductFunctorialWithGivenDirectProducts( s, [ alpha, beta ], r );
    
end : Description := "TensorProductOnMorphisms is DirectProductFunctorial",
      CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( TensorUnit,
                    
  function( arg )
    
    return CallFuncList( TerminalObject, arg );
    
end : Description := "TensorUnit is TerminalObject",
      CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( AssociatorLeftToRightWithGivenTensorProducts,
                    
  function( s, a, b, c, r )
    
    return AssociatorLeftToRightOfDirectProductsWithGivenDirectProducts( s, a, b, c, r );
    
end : Description := "AssociatorLeftToRight is AssociatorLeftToRightOfDirectProducts",
      CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( AssociatorRightToLeftWithGivenTensorProducts,
                    
  function( s, a, b, c, r )
    
    return AssociatorRightToLeftOfDirectProductsWithGivenDirectProducts( s, a, b, c, r );
    
end : Description := "AssociatorRightToLeft is AssociatorRightToLeftOfDirectProducts",
      CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( TensorProductOnObjects,
                    
  function( arg )
    
    return CallFuncList( Coproduct, arg );
    
end : Description := "TensorProductOnObjects is Coproduct",
      CategoryFilter := IsCoCartesianCoclosedCategory );

##
AddDerivationToCAP( TensorProductOnMorphismsWithGivenTensorProducts,
                    
  function( s, alpha, beta, r )
    
    return CoproductFunctorialWithGivenCoproducts( s, [ alpha, beta ], r );
    
end : Description := "TensorProductOnMorphisms is CoproductFunctorial",
      CategoryFilter := IsCoCartesianCoclosedCategory );

##
AddDerivationToCAP( TensorUnit,
                    
  function( arg )
    
    return CallFuncList( InitialObject, arg );
    
end : Description := "TensorUnit is InitialObject",
      CategoryFilter := IsCoCartesianCoclosedCategory );
