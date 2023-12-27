# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CoproductToCoexponentialAdjunctionMap,
                    "CoproductToCoexponentialAdjunctionMap using CocartesianCoevaluationMorphism and Coexponential",
                    [ [ PreCompose, 1 ],
                      [ CoexponentialOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ],
                      [ CocartesianCoevaluationMorphism, 1 ] ],
                    
  function( cat, c, b, g )
    
    # g: a → c ⊔ b
    #
    #    Coexp(a,b)
    #        |
    #        | Coexp(g, id_b)
    #        v
    # Coexp(c ⊔ b, b)
    #        |
    #        | cocacoev_cb
    #        v
    #        c

    return PreCompose( cat,
             CoexponentialOnMorphisms( cat, g, IdentityMorphism( cat, b ) ),
             CocartesianCoevaluationMorphism( cat, c, b ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoproductToCoexponentialAdjunctionMapWithGivenCoexponential,
                    "CoproductToCoexponentialAdjunctionMapWithGivenCoexponential using CocartesianCoevaluationMorphism and Coexponential",
                    [ [ CocartesianCoevaluationMorphism, 1 ],
                      [ PreCompose, 1 ],
                      [ CoexponentialOnMorphismsWithGivenCoexponentials, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, c, b, g, i )
    local cocacoev_cb;
    
    # g: a → c ⊔ b
    #
    #    Coexp(a,b)
    #        |
    #        | Coexp(g, id_b)
    #        v
    # Coexp(c ⊔ b, b)
    #        |
    #        | cocacoev_cb
    #        v
    #        c
    
    cocacoev_cb := CocartesianCoevaluationMorphism( cat, c, b );
    
    return PreCompose( cat,
             CoexponentialOnMorphismsWithGivenCoexponentials( cat, i, g, IdentityMorphism( cat, b ), Source( cocacoev_cb ) ),
             cocacoev_cb );
    
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoexponentialToCoproductAdjunctionMap,
                    "CoexponentialToCoproductAdjunctionMap using CoproductOnMorphisms and CocartesianEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ CocartesianEvaluationMorphism, 1 ],
                      [ CoproductOnMorphisms, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f )
    
    # f: Coexp(a,b) → c
    #
    #        a
    #        |
    #        | cocaev_ab
    #        v
    # Coexp(a,b) ⊔ b
    #        |
    #        | f ⊔ id_b
    #        v
    #      c ⊔ b
    
    return PreCompose( cat,
             CocartesianEvaluationMorphism( cat, a, b ),
             CoproductOnMorphisms( cat, f, IdentityMorphism( cat, b ) ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory );

##
AddDerivationToCAP( CoexponentialToCoproductAdjunctionMapWithGivenCoproduct,
                    "CoexponentialToCoproductAdjunctionMapWithGivenCoproduct using CoproductOnMorphisms and CocartesianEvaluationMorphism",
                    [ [ PreCompose, 1 ],
                      [ CocartesianEvaluationMorphism, 1 ],
                      [ CoproductOnMorphismsWithGivenCoproducts, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat, a, b, f, t )
    local cocaev_bc;
    
    # f: Coexp(a,b) → c
    #
    #        a
    #        |
    #        | cocaev_ab
    #        v
    # Coexp(a,b) ⊔ b
    #        |
    #        | f ⊔ id_b
    #        v
    #      c ⊔ b
    
    cocaev_bc := CocartesianEvaluationMorphism( cat, a, b );
    
    return PreCompose( cat,
             cocaev_bc,
             CoproductOnMorphismsWithGivenCoproducts( cat, Range( cocaev_bc ), f, IdentityMorphism( cat, b ), t ) );
             
end : CategoryFilter := IsCocartesianCoclosedCategory );

####################################
## Final derived methods
####################################

## Final methods for CocartesianDual
AddFinalDerivationBundle( "IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject as the identity of Coexp(1,a)",
                    [ [ IdentityMorphism, 1 ],
                      [ CoexponentialOnObjects, 1 ],
                      [ InitialObject, 1 ] ],
                    [ CocartesianDualOnObjects,
                      CocartesianDualOnMorphismsWithGivenCocartesianDuals,
                      MorphismFromCocartesianBidualWithGivenCocartesianBidual,
                      IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject,
                      IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject,
                      UniversalPropertyOfCocartesianDual,
                      CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects,
                      CocartesianEvaluationForCocartesianDualWithGivenCoproduct,
                      MorphismFromCoexponentialToCoproductWithGivenObjects
                      ],
[
  IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject,
  [ [ IdentityMorphism, 1 ],
    [ CoexponentialOnObjects, 1 ],
    [ InitialObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, CoexponentialOnObjects( cat, InitialObject( cat ), object ) );
    
  end
],
[
  IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject,
  [ [ IdentityMorphism, 1 ],
    [ CoexponentialOnObjects, 1 ],
    [ InitialObject, 1 ] ],
  function( cat, object )
    
    return IdentityMorphism( cat, CoexponentialOnObjects( cat, InitialObject( cat ), object ) );
    
  end
] : CategoryFilter := IsCocartesianCoclosedCategory );
