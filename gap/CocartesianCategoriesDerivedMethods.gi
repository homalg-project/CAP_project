# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.11-04
# USING CategoryConstructor v2021.11-07

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return InverseForMorphisms( cat, CocartesianAssociatorRightToLeftWithGivenCoproducts( cat,
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end : Description := "CocartesianAssociatorLeftToRightWithGivenCoproducts as the inverse of CocartesianAssociatorRightToLeftWithGivenCoproducts" );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return InverseForMorphisms( cat, CocartesianAssociatorLeftToRightWithGivenCoproducts( cat,
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end : Description := "CocartesianAssociatorRightToLeftWithGivenCoproducts as the inverse of CocartesianAssociatorLeftToRightWithGivenCoproducts" );

##
AddDerivationToCAP( CocartesianLeftUnitorWithGivenCoproduct,
                  
  function( cat, object, unit_u_object )
    
    return InverseForMorphisms( cat, CocartesianLeftUnitorInverseWithGivenCoproduct( cat, object, unit_u_object ) );
    
end : Description := "CocartesianLeftUnitorWithGivenCoproduct as the inverse of CocartesianLeftUnitorInverseWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
                  
  function( cat, object, unit_u_object )
    
    return InverseForMorphisms( cat, CocartesianLeftUnitorWithGivenCoproduct( cat, object, unit_u_object ) );
    
end : Description := "CocartesianLeftUnitorInverseWithGivenCoproduct as the inverse of CocartesianLeftUnitorWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianRightUnitorWithGivenCoproduct,
                  
  function( cat, object, object_u_unit )
    
    return InverseForMorphisms( cat, CocartesianRightUnitorInverseWithGivenCoproduct( cat, object, object_u_unit ) );
    
end : Description := "CocartesianRightUnitorWithGivenCoproduct as the inverse of CocartesianRightUnitorInverseWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
                  
  function( cat, object, object_u_unit )
    
    return InverseForMorphisms( cat, CocartesianRightUnitorWithGivenCoproduct( cat, object, object_u_unit ) );
    
end : Description := "CocartesianRightUnitorInverseWithGivenCoproduct as the inverse of CocartesianRightUnitorWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
                    
  function( cat, left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( cat, left_associated_object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianAssociatorLeftToRightWithGivenCoproducts as the identity morphism" );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
                    
  function( cat, right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( cat, right_associated_object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianAssociatorRightToLeft as the identity morphism" );

##
AddDerivationToCAP( CocartesianLeftUnitorWithGivenCoproduct,
                    
  function( cat, object, unit_u_object )
    
    return IdentityMorphism( cat, object );
      
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianLeftUnitorWithGivenCoproduct as the identity morphism" );

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
                  
  function( cat, object, unit_u_object )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianLeftUnitorInverseWithGivenCoproduct as the identity morphism" );

##
AddDerivationToCAP( CocartesianRightUnitorWithGivenCoproduct,
                    
  function( cat, object, object_u_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianRightUnitorWithGivenCoproduct as the identity morphism" );

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
                    
  function( cat, object, object_u_unit )
    
    return IdentityMorphism( cat, object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianRightUnitorInverseWithGivenCoproduct as the identity morphism" );
