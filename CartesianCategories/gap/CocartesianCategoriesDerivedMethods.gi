# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianAssociatorRightToLeftWithGivenCoproducts, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return InverseForMorphisms( cat, CocartesianAssociatorRightToLeftWithGivenCoproducts( cat,
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end : Description := "CocartesianAssociatorLeftToRightWithGivenCoproducts as the inverse of CocartesianAssociatorRightToLeftWithGivenCoproducts" );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianAssociatorLeftToRightWithGivenCoproducts, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return InverseForMorphisms( cat, CocartesianAssociatorLeftToRightWithGivenCoproducts( cat,
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end : Description := "CocartesianAssociatorRightToLeftWithGivenCoproducts as the inverse of CocartesianAssociatorLeftToRightWithGivenCoproducts" );

##
AddDerivationToCAP( CocartesianLeftUnitorWithGivenCoproduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianLeftUnitorInverseWithGivenCoproduct, 1 ] ],
                    
  function( cat, object, unit_u_object )
    
    return InverseForMorphisms( cat, CocartesianLeftUnitorInverseWithGivenCoproduct( cat, object, unit_u_object ) );
    
end : Description := "CocartesianLeftUnitorWithGivenCoproduct as the inverse of CocartesianLeftUnitorInverseWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianLeftUnitorWithGivenCoproduct, 1 ] ],
                    
  function( cat, object, unit_u_object )
    
    return InverseForMorphisms( cat, CocartesianLeftUnitorWithGivenCoproduct( cat, object, unit_u_object ) );
    
end : Description := "CocartesianLeftUnitorInverseWithGivenCoproduct as the inverse of CocartesianLeftUnitorWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianRightUnitorWithGivenCoproduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianRightUnitorInverseWithGivenCoproduct, 1 ] ],
                    
  function( cat, object, object_u_unit )
    
    return InverseForMorphisms( cat, CocartesianRightUnitorInverseWithGivenCoproduct( cat, object, object_u_unit ) );
    
end : Description := "CocartesianRightUnitorWithGivenCoproduct as the inverse of CocartesianRightUnitorInverseWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
                    [ [ InverseForMorphisms, 1 ],
                      [ CocartesianRightUnitorWithGivenCoproduct, 1 ] ],
                    
  function( cat, object, object_u_unit )
    
    return InverseForMorphisms( cat, CocartesianRightUnitorWithGivenCoproduct( cat, object, object_u_unit ) );
    
end : Description := "CocartesianRightUnitorInverseWithGivenCoproduct as the inverse of CocartesianRightUnitorWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( cat, left_associated_object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianAssociatorLeftToRightWithGivenCoproducts as the identity morphism" );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( cat, right_associated_object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianAssociatorRightToLeft as the identity morphism" );

##
AddDerivationToCAP( CocartesianLeftUnitorWithGivenCoproduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_u_object )
    
    return IdentityMorphism( cat, object );
      
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianLeftUnitorWithGivenCoproduct as the identity morphism" );

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, unit_u_object )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianLeftUnitorInverseWithGivenCoproduct as the identity morphism" );

##
AddDerivationToCAP( CocartesianRightUnitorWithGivenCoproduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_u_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianRightUnitorWithGivenCoproduct as the identity morphism" );

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
                    [ [ IdentityMorphism, 1 ] ],
                    
  function( cat, object, object_u_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianRightUnitorInverseWithGivenCoproduct as the identity morphism" );
