# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
AddDerivationToCAP( CocartesianCodiagonalWithGivenCocartesianMultiple,
  function( cat, a, n, cocartesian_multiple )
    local id_a;
    
    id_a := IdentityMorphism( cat, a );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( cat,
                   ListWithIdenticalEntries( n, a ),
                   a,
                   ListWithIdenticalEntries( n, id_a ),
                   cocartesian_multiple );
    
end : CategoryFilter := IsCocartesianCategory );

##
AddDerivationToCAP( CocartesianCodiagonal,
  function( cat, a, n )
    
    return CocartesianCodiagonalWithGivenCocartesianMultiple( cat,
                   a,
                   n,
                   Coproduct( cat, ListWithIdenticalEntries( n, a ) ) );
    
end : CategoryFilter := cat -> IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true );

##
AddDerivationToCAP( CocartesianCodiagonal,
  function( cat, a, n )
    
    if n = 0 then
        return UniversalMorphismFromInitialObject( cat, a );
    fi;
    
    return CocartesianCodiagonalWithGivenCocartesianMultiple( cat,
                   a,
                   n,
                   Coproduct( cat, ListWithIdenticalEntries( n, a ) ) );
    
end : CategoryFilter := cat -> not ( IsBound( cat!.supports_empty_limits ) and cat!.supports_empty_limits = true ) );

##
AddDerivationToCAP( CoproductOnMorphismsWithGivenCoproducts,
  function( cat, s, alpha, beta, r )
    
    return CoproductFunctorialWithGivenCoproducts(
                   cat,
                   s,
                   [ Source( alpha ), Source( beta ) ],
                   [ alpha, beta ],
                   [ Range( alpha ), Range( beta ) ],
                   r );
    
end : Description := "CoproductOnMorphisms is CoproductFunctorial",
      CategoryFilter := IsCocartesianCategory );

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
  function( cat, a, r )
    
    return InjectionOfCofactorOfCoproductWithGivenCoproduct( cat,
                   [ InitialObject( cat ), a ],
                   2,
                   r );
    
end : Description := "CocartesianLeftUnitorInverseWithGivenCoproduct using the injection into the second factor of the coproduct" );

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
  function( cat, a, r )
    
    return InjectionOfCofactorOfCoproductWithGivenCoproduct( cat,
                   [ a, InitialObject( cat ) ],
                   1,
                   r );
    
end : Description := "CocartesianRightUnitorInverseWithGivenCoproduct using the injection into the first factor of the coproduct" );

##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
  function( cat, s, a, b, c, r )
    local Db_c, bc, iota_b, iota_c, Da_bc, iota_a, iota_bc, Da_b, ab, iota_ab;
    
    Db_c := [ b, c ];
    
    bc := Coproduct( cat, Db_c );
    
    iota_b := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Db_c, 1, bc );
    iota_c := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Db_c, 2, bc );
    
    Da_bc := [ a, bc ];
    
    iota_a := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Da_bc, 1, r );
    iota_bc := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Da_bc, 2, r );
    
    Da_b := [ a, b ];
    
    ab := Coproduct( cat, Da_b );
    
    iota_ab := UniversalMorphismFromCoproductWithGivenCoproduct( cat, Da_b, r, [ iota_a, PreCompose( cat, iota_b, iota_bc ) ], ab );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( cat, [ ab, c ], r, [ iota_ab, PreCompose( cat, iota_c, iota_bc ) ], s );
    
end : Description := "CocartesianAssociatorLeftToRightWithGivenCoproducts using the universal morphism from coproduct" );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
  function( cat, s, a, b, c, r )
    local Da_b, ab, iota_a, iota_b, Dab_c, iota_ab, iota_c, Db_c, bc, iota_bc;
    
    Da_b := [ a, b ];
    
    ab := Coproduct( cat, Da_b );
    
    iota_a := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Da_b, 1, ab );
    iota_b := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Da_b, 2, ab );
    
    Dab_c := [ ab, c ];
    
    iota_ab := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Dab_c, 1, r );
    iota_c := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Dab_c, 2, r );
    
    Db_c := [ b, c ];
    
    bc := Coproduct( cat, Db_c );
    
    iota_bc := UniversalMorphismFromCoproductWithGivenCoproduct( cat, Db_c, r, [ PreCompose( cat, iota_b, iota_ab ), iota_c ], bc );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( cat, [ a, bc ], r, [ PreCompose( cat, iota_a, iota_ab ), iota_bc ], s );
    
end : Description := "CocartesianAssociatorRightToLeftWithGivenCoproducts using the universal morphism from coproduct" );

##
AddDerivationToCAP( CocartesianBraidingWithGivenCoproducts,
  function( cat, aub, a, b, bua )
    local i1, i2;
    
    i1 := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, [ b, a ], 1, bua );
    i2 := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, [ b, a ], 2, bua );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( cat, [ a, b ], bua, [ i2, i1 ], aub );
    
end : Description := "CocartesianBraidingWithGivenCoproducts using the coproduct injections and the universal morphism into the coproduct" );

##
AddDerivationToCAP( LeftCocartesianCodistributivityExpandingWithGivenObjects,
  function( cat, au_XkLk, a, L, Xk_auLk )
    local l, piL, aupiL;
    
    l := Length( L );
    
    piL := List( [ 1 .. l ], k -> ProjectionInFactorOfDirectProduct( cat, L, k ) );
    
    aupiL := List( piL, pi_b -> CoproductOnMorphisms( cat, IdentityMorphism( cat, a ), pi_b ) );
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat,
                   List( aupiL, Range ),
                   au_XkLk,
                   aupiL,
                   Xk_auLk );
    
end : Description := "LeftCocartesianCodistributivityExpandingWithGivenObjects using the direct product projections, the functoriality of the coproduct, and the universal morphism of direct products" );

##
AddDerivationToCAP( RightCocartesianCodistributivityExpandingWithGivenObjects,
  function( cat, XkLk_ua, L, a, Xk_Lkua )
    local l, piL, piLua;
    
    l := Length( L );
    
    piL := List( [ 1 .. l ], k -> ProjectionInFactorOfDirectProduct( cat, L, k ) );
    
    piLua := List( piL, pi_b -> CoproductOnMorphisms( cat, pi_b, IdentityMorphism( cat, a ) ) );
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat,
                   List( piLua, Range ),
                   XkLk_ua,
                   piLua,
                   Xk_Lkua );
    
end : Description := "RightCocartesianCodistributivityExpandingWithGivenObjects using the direct product projections, the functoriality of the coproduct, and the universal morphism of direct product" );

##
AddDerivationToCAP( LeftCocartesianCodistributivityFactoringWithGivenObjects,
  function( cat, Xk_auLk, a, L, au_XkLk )
    
    return InverseForMorphisms( cat, LeftCocartesianCodistributivityExpandingWithGivenObjects( cat, au_XkLk, a, L, Xk_auLk ) );
    
end : CategoryFilter := IsCodistributiveCategory,
  Description := "LeftCocartesianCodistributivityFactoringWithGivenObjects using LeftCocartesianCodistributivityExpandingWithGivenObjects" );

##
AddDerivationToCAP( RightCocartesianCodistributivityFactoringWithGivenObjects,
  function( cat, Xk_Lkua, L, a, XkLk_ua )
    
    return InverseForMorphisms( cat, RightCocartesianCodistributivityExpandingWithGivenObjects( cat, XkLk_ua, L, a, Xk_Lkua ) );
    
end : CategoryFilter := IsCodistributiveCategory,
  Description := "RightCocartesianCodistributivityFactoringWithGivenObjects using RightCocartesianCodistributivityExpandingWithGivenObjects" );
