# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
AddDerivationToCAP( CartesianDiagonalWithGivenCartesianPower,
                    "",
                    [ [ IdentityMorphism, 1 ],
                      [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 1 ] ],
                    
  function( cat, a, n, cartesian_power )
    local id_a;
    
    id_a := IdentityMorphism( cat, a );
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat,
                   ListWithIdenticalEntries( n, a ),
                   a,
                   ListWithIdenticalEntries( n, id_a ),
                   cartesian_power );
    
end );

##
AddDerivationToCAP( CartesianDiagonal,
                    "",
                    [ [ CartesianDiagonalWithGivenCartesianPower, 1 ],
                      [ DirectProduct, 1 ] ],
                    
  function( cat, a, n )
    
    return CartesianDiagonalWithGivenCartesianPower( cat,
                   a,
                   n,
                   DirectProduct( cat, ListWithIdenticalEntries( n, a ) ) );
    
end );

##
AddDerivationToCAP( DirectProductOnMorphismsWithGivenDirectProducts,
                    "TensorProductOnMorphisms is DirectProductFunctorial",
                    [ [ DirectProductFunctorialWithGivenDirectProducts, 1 ] ],
                    
  function( cat, s, alpha, beta, r )
    
    return DirectProductFunctorialWithGivenDirectProducts( cat,
                   s,
                   [ Source( alpha ), Source( beta ) ],
                   [ alpha, beta ],
                   [ Range( alpha ), Range( beta ) ],
                   r );
    
end : CategoryFilter := IsCartesianCategory );

##
AddDerivationToCAP( CartesianLeftUnitorWithGivenDirectProduct,
                    "CartesianLeftUnitorWithGivenDirectProduct using the projection onto the second factor of the direct product",
                    [ [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 1 ],
                      [ TerminalObject, 1 ] ],
                    
  function( cat, a, s )
    
    return ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat,
                   [ TerminalObject( cat ), a ],
                   2,
                   s );
    
end );

##
AddDerivationToCAP( CartesianRightUnitorWithGivenDirectProduct,
                    "CartesianRightUnitorWithGivenDirectProduct using the projection onto the first factor of the direct product",
                    [ [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 1 ],
                      [ TerminalObject, 1 ] ],
                    
  function( cat, a, s )
    
    return ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat,
                   [ a, TerminalObject( cat ) ],
                   1,
                   s );
    
end );

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
                    "CartesianAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts using the universal morphism into direct product",
                    [ [ DirectProduct, 2 ],
                      [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 4 ],
                      [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 2 ],
                      [ PreCompose, 2 ] ],
                    
  function( cat, s, a, b, c, r )
    local Db_c, bc, pi_b, pi_c, Da_bc, pi_a, pi_bc, Da_b, ab, pi_ab;
    
    Db_c := [ b, c ];
    
    bc := DirectProduct( cat, Db_c );
    
    pi_b := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Db_c, 1, bc );
    pi_c := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Db_c, 2, bc );
    
    Da_bc := [ a, bc ];
    
    pi_a := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Da_bc, 1, s );
    pi_bc := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Da_bc, 2, s );
    
    Da_b := [ a, b ];
    
    ab := DirectProduct( cat, Da_b );
    
    pi_ab := UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, Da_b, s, [ pi_a, PreCompose( cat, pi_bc, pi_b ) ], ab );
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, [ ab, c ], s, [ pi_ab, PreCompose( cat, pi_bc, pi_c ) ], r );
    
end );

##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
                    "CartesianAssociatorLeftToRightWithGivenDirectProducts using the universal morphism into direct product",
                    [ [ DirectProduct, 2 ],
                      [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 4 ],
                      [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 2 ],
                      [ PreCompose, 2 ] ],
                    
  function( cat, s, a, b, c, r )
    local Da_b, ab, pi_a, pi_b, Dab_c, pi_ab, pi_c, Db_c, bc, pi_bc;
    
    Da_b := [ a, b ];
    
    ab := DirectProduct( cat, Da_b );
    
    pi_a := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Da_b, 1, ab );
    pi_b := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Da_b, 2, ab );
    
    Dab_c := [ ab, c ];
    
    pi_ab := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Dab_c, 1, s );
    pi_c := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Dab_c, 2, s );
    
    Db_c := [ b, c ];
    
    bc := DirectProduct( cat, Db_c );
    
    pi_bc := UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, Db_c, s, [ PreCompose( cat, pi_ab, pi_b ), pi_c ], bc );
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, [ a, bc ], s, [ PreCompose( cat, pi_ab, pi_a ), pi_bc ], r );
    
end );

##
AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
                    "CartesianBraidingWithGivenDirectProducts using the direct product projections and the universal morphism in the direct product",
                    [ [ ProjectionInFactorOfDirectProductWithGivenDirectProduct, 2 ],
                      [ UniversalMorphismIntoDirectProductWithGivenDirectProduct, 1 ] ],
                    
  function( cat, axb, a, b, bxa )
    local p_a, p_b;
    
    p_a := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, [ a, b ], 1, axb );
    p_b := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, [ a, b ], 2, axb );
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, [ b, a ], axb, [ p_b, p_a ], bxa );
    
end );

##
AddDerivationToCAP( LeftCartesianDistributivityFactoringWithGivenObjects,
                    "LeftCartesianDistributivityFactoringWithGivenObjects using the coproduct injections, the functoriality of the direct product, and the universal morphism of coproducts",
                    [ [ InjectionOfCofactorOfCoproduct, 2 ],
                      [ DirectProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ UniversalMorphismFromCoproductWithGivenCoproduct, 1 ] ],
                    
  function( cat, Uk_axLk, a, L, ax_UkLk )
    local l, iotaL, axiotaL;
    
    l := Length( L );
    
    iotaL := List( [ 1 .. l ], k -> InjectionOfCofactorOfCoproduct( cat, L, k ) );
    
    axiotaL := List( iotaL, iota_b -> DirectProductOnMorphisms( cat, IdentityMorphism( cat, a ), iota_b ) );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( cat,
                   List( axiotaL, Source ),
                   ax_UkLk,
                   axiotaL,
                   Uk_axLk );
    
end );

##
AddDerivationToCAP( RightCartesianDistributivityFactoringWithGivenObjects,
                    "RightCartesianDistributivityFactoringWithGivenObjects using the coproduct injections, the functoriality of the direct product, and the universal morphism of coproducts",
                    [ [ InjectionOfCofactorOfCoproduct, 2 ],
                      [ DirectProductOnMorphisms, 2 ],
                      [ IdentityMorphism, 2 ],
                      [ UniversalMorphismFromCoproductWithGivenCoproduct, 1 ] ],
                    
  function( cat, Uk_Lkxa, L, a, UkLk_xa )
    local l, iotaL, iotaLxa;
    
    l := Length( L );
    
    iotaL := List( [ 1 .. l ], k -> InjectionOfCofactorOfCoproduct( cat, L, k ) );
    
    iotaLxa := List( iotaL, iota_b -> DirectProductOnMorphisms( cat, iota_b, IdentityMorphism( cat, a ) ) );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( cat,
                   List( iotaLxa, Source ),
                   UkLk_xa,
                   iotaLxa,
                   Uk_Lkxa );
    
end );

##
AddDerivationToCAP( LeftCartesianDistributivityExpandingWithGivenObjects,
                    "LeftCartesianDistributivityExpandingWithGivenObjects using LeftCartesianDistributivityFactoringWithGivenObjects",
                    [ [ InverseForMorphisms, 1 ],
                      [ LeftCartesianDistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, ax_UkLk, a, L, Uk_axLk )
    
    return InverseForMorphisms( cat, LeftCartesianDistributivityFactoringWithGivenObjects( cat, Uk_axLk, a, L, ax_UkLk ) );
    
end : CategoryFilter := IsDistributiveCategory );

##
AddDerivationToCAP( RightCartesianDistributivityExpandingWithGivenObjects,
                    "RightCartesianDistributivityExpandingWithGivenObjects using RightCartesianDistributivityFactoringWithGivenObjects",
                    [ [ InverseForMorphisms, 1 ],
                      [ RightCartesianDistributivityFactoringWithGivenObjects, 1 ] ],
                    
  function( cat, UkLk_xa, L, a, Uk_Lkxa )
    
    return InverseForMorphisms( cat, RightCartesianDistributivityFactoringWithGivenObjects( cat, Uk_Lkxa, L, a, UkLk_xa ) );
    
end : CategoryFilter := IsDistributiveCategory );
