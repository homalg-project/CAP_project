##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
                    
  function( left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return Inverse( CocartesianAssociatorRightToLeftWithGivenCoproducts(
                      right_associated_object,
                      object_1, object_2, object_3,
                      left_associated_object )
                  );
    
end : Description := "CocartesianAssociatorLeftToRightWithGivenCoproducts as the inverse of CocartesianAssociatorRightToLeftWithGivenCoproducts" );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
                    
  function( right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return Inverse( CocartesianAssociatorLeftToRightWithGivenCoproducts(
                      left_associated_object,
                      object_1, object_2, object_3,
                      right_associated_object )
                  );
    
end : Description := "CocartesianAssociatorRightToLeftWithGivenCoproducts as the inverse of CocartesianAssociatorLeftToRightWithGivenCoproducts" );

##
AddDerivationToCAP( CocartesianLeftUnitorWithGivenCoproduct,
                  
  function( object, unit_u_object )
    
    return Inverse( CocartesianLeftUnitorInverseWithGivenCoproduct( object, unit_u_object ) );
    
end : Description := "CocartesianLeftUnitorWithGivenCoproduct as the inverse of CocartesianLeftUnitorInverseWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
                  
  function( object, unit_u_object )
    
    return Inverse( CocartesianLeftUnitorWithGivenCoproduct( object, unit_u_object ) );
    
end : Description := "CocartesianLeftUnitorInverseWithGivenCoproduct as the inverse of CocartesianLeftUnitorWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianRightUnitorWithGivenCoproduct,
                  
  function( object, object_u_unit )
    
    return Inverse( CocartesianRightUnitorInverseWithGivenCoproduct( object, object_u_unit ) );
    
end : Description := "CocartesianRightUnitorWithGivenCoproduct as the inverse of CocartesianRightUnitorInverseWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
                  
  function( object, object_u_unit )
    
    return Inverse( CocartesianRightUnitorWithGivenCoproduct( object, object_u_unit ) );
    
end : Description := "CocartesianRightUnitorInverseWithGivenCoproduct as the inverse of CocartesianRightUnitorWithGivenCoproduct" );

##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
                    
  function( left_associated_object, object_1, object_2, object_3, right_associated_object )
    
    return IdentityMorphism( left_associated_object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianAssociatorLeftToRightWithGivenCoproducts as the identity morphism" );

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
                    
  function( right_associated_object, object_1, object_2, object_3, left_associated_object )
    
    return IdentityMorphism( right_associated_object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianAssociatorRightToLeft as the identity morphism" );

##
AddDerivationToCAP( CocartesianLeftUnitorWithGivenCoproduct,
                    
  function( object, unit_u_object )
    
    return IdentityMorphism( object );
      
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianLeftUnitorWithGivenCoproduct as the identity morphism" );

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
                  
  function( object, unit_u_object )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianLeftUnitorInverseWithGivenCoproduct as the identity morphism" );

##
AddDerivationToCAP( CocartesianRightUnitorWithGivenCoproduct,
                    
  function( object, object_u_unit )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianRightUnitorWithGivenCoproduct as the identity morphism" );

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
                    
  function( object, object_u_unit )
    
    return IdentityMorphism( object );
    
end : CategoryFilter := IsStrictCocartesianCategory,
      Description := "CocartesianRightUnitorInverseWithGivenCoproduct as the identity morphism" );
