# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
AddDerivationToCAP( DirectProductOnMorphismsWithGivenDirectProducts,
  function( cat, s, alpha, beta, r )
    
    return DirectProductFunctorialWithGivenDirectProducts(
                   cat,
                   s,
                   [ Source( alpha ), Source( beta ) ],
                   [ alpha, beta ],
                   [ Range( alpha ), Range( beta ) ],
                   r );
    
end : Description := "TensorProductOnMorphisms is DirectProductFunctorial",
      CategoryFilter := IsCartesianCategory );

##
AddDerivationToCAP( CartesianLeftUnitorWithGivenDirectProduct,
  function( cat, a, s )
    
    return ProjectionInFactorOfDirectProductWithGivenDirectProduct(
                   [ TerminalObject( cat ), a ],
                   2,
                   s );
    
end : Description := "CartesianLeftUnitorWithGivenDirectProduct using the projection onto the second factor of the direct product" );

##
AddDerivationToCAP( CartesianRightUnitorWithGivenDirectProduct,
  function( cat, a, s )
    
    return ProjectionInFactorOfDirectProductWithGivenDirectProduct(
                   [ a, TerminalObject( cat ) ],
                   1,
                   s );
    
end : Description := "CartesianRightUnitorWithGivenDirectProduct using the projection onto the first factor of the direct product" );

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
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
    
end : Description := "CartesianAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts using the universal morphism into direct product" );

##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
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
    
end : Description := "CartesianAssociatorLeftToRightWithGivenDirectProducts using the universal morphism into direct product" );

##
AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
  function( cat, axb, a, b, bxa )
    local p1, p2;
    
    p1 := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, [ a, b ], 1, axb );
    p2 := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, [ a, b ], 2, axb );
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, [ b, a ], axb, [ p2, p1 ], bxa );
    
end : Description := "CartesianBraidingWithGivenDirectProducts using the direct product projections and the universal morphism in the direct product" );

##
AddDerivationToCAP( LeftCartesianDistributivityFactoringWithGivenObjects,
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
    
end : Description := "LeftCartesianDistributivityFactoringWithGivenObjects using the coproduct injections, the functoriality of the direct product, and the universal morphism of coproducts" );

##
AddDerivationToCAP( RightCartesianDistributivityFactoringWithGivenObjects,
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
    
end : Description := "RightCartesianDistributivityFactoringWithGivenObjects using the coproduct injections, the functoriality of the direct product, and the universal morphism of coproducts" );

##
AddDerivationToCAP( LeftCartesianDistributivityExpandingWithGivenObjects,
  function( cat, ax_UkLk, a, L, Uk_axLk )
    
    return InverseForMorphisms( cat, LeftCartesianDistributivityFactoringWithGivenObjects( cat, Uk_axLk, a, L, ax_UkLk ) );
    
end : CategoryFilter := IsDistributiveCartesianCategory,
  Description := "LeftCartesianDistributivityExpandingWithGivenObjects using LeftCartesianDistributivityFactoringWithGivenObjects" );

##
AddDerivationToCAP( RightCartesianDistributivityExpandingWithGivenObjects,
  function( cat, UkLk_xa, L, a, Uk_Lkxa )
    
    return InverseForMorphisms( cat, RightCartesianDistributivityFactoringWithGivenObjects( cat, Uk_Lkxa, L, a, UkLk_xa ) );
    
end : CategoryFilter := IsDistributiveCartesianCategory,
  Description := "RightCartesianDistributivityExpandingWithGivenObjects using RightCartesianDistributivityFactoringWithGivenObjects" );
