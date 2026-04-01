# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CoproductOnMorphismsWithGivenCoproducts,
                    "CoproductOnMorphismsWithGivenCoproducts via CoproductOfMorphismAndIdentityWithGivenCoproducts and CoproductOfIdentityAndMorphismWithGivenCoproducts and the functoriality of the coproduct",
                    [ [ CoproductOfMorphismAndIdentityWithGivenCoproducts, 1 ],
                      [ CoproductOfIdentityAndMorphismWithGivenCoproducts, 1 ],
                      [ IdentityMorphism, 2 ],
                      [ Coproduct, 4 ],
                      [ PreCompose, 1 ],
                    ],
                    
  function( cat, source, alpha, beta, range )
    local alpha_source, alpha_range, beta_source, beta_range, alpha_times_id_source_beta, id_range_alpha_times_beta;
    
    alpha_source := Source( alpha );
    alpha_range := Range( alpha );
    
    beta_source := Source( beta );
    beta_range := Range( beta );
    
    # α ⊔ Id_Source(β)
    alpha_times_id_source_beta := CoproductOfMorphismAndIdentityWithGivenCoproducts( cat,
                                        BinaryCoproduct( cat, alpha_source, beta_source ),
                                        alpha,
                                        IdentityMorphism( cat, beta_source ),
                                        BinaryCoproduct( cat, alpha_range, beta_source ) );
    
    # Id_Range(α) ⊔ β
    id_range_alpha_times_beta := CoproductOfIdentityAndMorphismWithGivenCoproducts( cat,
                                        BinaryCoproduct( cat, alpha_range, beta_source ),
                                        IdentityMorphism( cat, alpha_range ),
                                        beta,
                                        BinaryCoproduct( cat, alpha_range, beta_range ) );
    
    # The functoriality of the bifunctor '⊔':
    #
    # α ⊔ β = (α · Id_Range(α)) ⊔ (Id_Source(β) · β)
    #       = (α ⊔ Id_Source(β)) · (Id_Range(α) ⊔ β)
    return PreCompose( cat, alpha_times_id_source_beta, id_range_alpha_times_beta );
    
end );

##
AddDerivationToCAP( CoproductOfMorphismAndIdentityWithGivenCoproducts,
                    "CoproductOfMorphismAndIdentityWithGivenCoproducts via CoproductOnMorphismsWithGivenCoproducts",
                    [ [ CoproductOnMorphismsWithGivenCoproducts, 1 ] ],
                    
  function( cat, source, alpha, id_b, range )
    
    return CoproductOnMorphismsWithGivenCoproducts( cat, source, alpha, id_b, range );
    
end );

##
AddDerivationToCAP( CoproductOfIdentityAndMorphismWithGivenCoproducts,
                    "CoproductOfIdentityAndMorphismWithGivenCoproducts via CoproductOnMorphismsWithGivenCoproducts",
                    [ [ CoproductOnMorphismsWithGivenCoproducts, 1 ] ],
                    
  function( cat, source, id_a, beta, range )
    
    return CoproductOnMorphismsWithGivenCoproducts( cat, source, id_a, beta, range );
    
end );

##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
                    "CocartesianAssociatorLeftToRightWithGivenCoproducts as the inverse of CocartesianAssociatorRightToLeftWithGivenCoproducts",
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianAssociatorRightToLeftWithGivenCoproducts, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return InverseForMorphisms( cat, CocartesianAssociatorRightToLeftWithGivenCoproducts( cat,
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
                    "CocartesianAssociatorRightToLeftWithGivenCoproducts as the inverse of CocartesianAssociatorLeftToRightWithGivenCoproducts",
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianAssociatorLeftToRightWithGivenCoproducts, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return InverseForMorphisms( cat, CocartesianAssociatorLeftToRightWithGivenCoproducts( cat,
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end );

##
AddDerivationToCAP( CocartesianLeftUnitorWithGivenCoproduct,
                    "CocartesianLeftUnitorWithGivenCoproduct as the inverse of CocartesianLeftUnitorInverseWithGivenCoproduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianLeftUnitorInverseWithGivenCoproduct, 1 ] ],
                    
  function( cat, object, unit_u_object )
    
    return InverseForMorphisms( cat, CocartesianLeftUnitorInverseWithGivenCoproduct( cat, object, unit_u_object ) );
    
end );

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
                    "CocartesianLeftUnitorInverseWithGivenCoproduct as the inverse of CocartesianLeftUnitorWithGivenCoproduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianLeftUnitorWithGivenCoproduct, 1 ] ],
                    
  function( cat, object, unit_u_object )
    
    return InverseForMorphisms( cat, CocartesianLeftUnitorWithGivenCoproduct( cat, object, unit_u_object ) );
    
end );

##
AddDerivationToCAP( CocartesianRightUnitorWithGivenCoproduct,
                    "CocartesianRightUnitorWithGivenCoproduct as the inverse of CocartesianRightUnitorInverseWithGivenCoproduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianRightUnitorInverseWithGivenCoproduct, 1 ] ],
                    
  function( cat, object, object_u_unit )
    
    return InverseForMorphisms( cat, CocartesianRightUnitorInverseWithGivenCoproduct( cat, object, object_u_unit ) );
    
end );

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
                    "CocartesianRightUnitorInverseWithGivenCoproduct as the inverse of CocartesianRightUnitorWithGivenCoproduct",
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianRightUnitorWithGivenCoproduct, 1 ] ],
                    
  function( cat, object, object_u_unit )
    
    return InverseForMorphisms( cat, CocartesianRightUnitorWithGivenCoproduct( cat, object, object_u_unit ) );
    
end );

##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
                    "CocartesianAssociatorLeftToRightWithGivenCoproducts as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( cat, left_associated_object );
    
end : CategoryFilter := IsStrictCocartesianCategory );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
                    "CocartesianAssociatorRightToLeft as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( cat, right_associated_object );
    
end : CategoryFilter := IsStrictCocartesianCategory );

##
AddDerivationToCAP( CocartesianLeftUnitorWithGivenCoproduct,
                    "CocartesianLeftUnitorWithGivenCoproduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_u_object )
    
    return IdentityMorphism( cat, object );
      
end : CategoryFilter := IsStrictCocartesianCategory );

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
                    "CocartesianLeftUnitorInverseWithGivenCoproduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_u_object )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCocartesianCategory );

##
AddDerivationToCAP( CocartesianRightUnitorWithGivenCoproduct,
                    "CocartesianRightUnitorWithGivenCoproduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_u_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCocartesianCategory );

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
                    "CocartesianRightUnitorInverseWithGivenCoproduct as the identity morphism",
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_u_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCocartesianCategory );
