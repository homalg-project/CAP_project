# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( DirectProductToExponentialAdjunctionMap,
                    "DirectProductToExponentialAdjunctionMap using CartesianCoevaluationMorphism and Exponential",
                    [ [ PreCompose, 1 ],
                      [ CartesianCoevaluationMorphism, 1 ],
                      [ ExponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )

    # f: a × b → c
    #
    #      a
    #      |
    #      | coev_ab
    #      v
    # Exp(b,a × b)
    #      |
    #      | Exp(id_b, f)
    #      v
    #   Exp(b,c)

    return PreCompose( cat,
             CartesianCoevaluationMorphism( cat, a, b ),
             ExponentialOnMorphisms( cat, IdentityMorphism( cat, b ), f ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( DirectProductToExponentialAdjunctionMapWithGivenExponential,
                    "DirectProductToExponentialAdjunctionMapWithGivenExponential using CartesianCoevaluationMorphism and Exponential",
                    [ [ CartesianCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ ExponentialOnMorphismsWithGivenExponentials, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, i )
    local coev_ab;
    
    # f: a × b → c
    #
    #      a
    #      |
    #      | coev_ab
    #      v
    # Exp(b,a × b)
    #      |
    #      | Exp(id_b, f)
    #      v
    #   Exp(b,c)
    
    coev_ab := CartesianCoevaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             coev_ab,
             ExponentialOnMorphismsWithGivenExponentials( cat, Range( coev_ab ), IdentityMorphism( cat, b ), f, i ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( ExponentialToDirectProductAdjunctionMap,
                    "ExponentialToDirectProductAdjunctionMap using DirectProductOnMorphisms and CartesianEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ DirectProductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianEvaluationMorphism, 1 ] ],
                    
  function( cat, b, c, g )

    # g: a → Exp(b,c)
    #
    #    a × b
    #      |
    #      | g × id_b
    #      v
    # Exp(b,c) × b
    #      |
    #      | ev_bc
    #      v
    #      c

    return PreCompose( cat,
             DirectProductOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             CartesianEvaluationMorphism( cat, b, c ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct,
                    "ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct using DirectProductOnMorphisms and CartesianEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ DirectProductOnMorphismsWithGivenDirectProducts, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CartesianEvaluationMorphism, 1 ] ],
                    
  function( cat, b, c, g, t )
    local ev_bc;
    
    # g: a → Exp(b,c)
    #
    #    a × b
    #      |
    #      | g × id_b
    #      v
    # Exp(b,c) × b
    #      |
    #      | ev_bc
    #      v
    #      c
     
    ev_bc := CartesianEvaluationMorphism( cat, b, c );
     
    return PreCompose( cat,
             DirectProductOnMorphismsWithGivenDirectProducts( cat, t, g, IdentityMorphism( cat, b ), Source( ev_bc ) ),
             ev_bc );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianEvaluationMorphismWithGivenSource,
                    "CartesianEvaluationMorphismWithGivenSource using the direct product-exponential adjunction on the identity",
                    [ [ ExponentialToDirectProductAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ ExponentialOnObjects, 1 ] ],
                    
  function( cat, a, b, direct_product_object )

    # Adjoint( id_Exp(a,b): Exp(a,b) → Exp(a,b) ) = ( Exp(a,b) × a → b )
    
    return ExponentialToDirectProductAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, ExponentialOnObjects( cat, a, b ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory );

##
AddDerivationToCAP( CartesianCoevaluationMorphismWithGivenRange,
                    "CartesianCoevaluationMorphismWithGivenRange using the direct product-exponential adjunction on the identity",
                    [ [ DirectProductToExponentialAdjunctionMap, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ DirectProduct, 1 ] ],
                    
  function( cat, a, b, internal_hom )
    
    # Adjoint( id_(a × b): a × b → a × b ) = ( a → Exp(b, a × b) )

    return DirectProductToExponentialAdjunctionMap( cat,
             a, b,
             IdentityMorphism( cat, BinaryDirectProduct( cat, a, b ) ) );
    
end : CategoryFilter := IsCartesianClosedCategory );
