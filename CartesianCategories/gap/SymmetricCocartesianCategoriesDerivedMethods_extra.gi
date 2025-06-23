# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
InstallTrueMethod( IsSymmetricMonoidalCategory, IsSymmetricMonoidalCategoryStructureGivenByCoproduct );

## Final methods for monoidal structure
AddFinalDerivationBundle( "set the cartesian structure as the symmetric monoidal structure",
        [ [ InitialObject, 1 ],
          [ Coproduct, 1 ],
          [ CoproductOnMorphismsWithGivenCoproducts, 1 ],
          [ CocartesianLeftUnitorWithGivenCoproduct, 1 ],
          [ CocartesianLeftUnitorInverseWithGivenCoproduct, 1 ],
          [ CocartesianRightUnitorWithGivenCoproduct, 1 ],
          [ CocartesianRightUnitorInverseWithGivenCoproduct, 1 ],
          [ CocartesianAssociatorLeftToRightWithGivenCoproducts, 1 ],
          [ CocartesianAssociatorRightToLeftWithGivenCoproducts, 1 ],
          [ CocartesianBraidingWithGivenCoproducts, 1 ],
          [ CocartesianBraidingInverseWithGivenCoproducts, 1 ] ],
        [ TensorUnit,
          TensorProductOnObjects,
          TensorProductOnMorphismsWithGivenTensorProducts,
          LeftUnitorWithGivenTensorProduct,
          LeftUnitorInverseWithGivenTensorProduct,
          RightUnitorWithGivenTensorProduct,
          RightUnitorInverseWithGivenTensorProduct,
          AssociatorLeftToRightWithGivenTensorProducts,
          AssociatorRightToLeftWithGivenTensorProducts,
          BraidingWithGivenTensorProducts,
          BraidingInverseWithGivenTensorProducts ],
        
[ TensorUnit,
  [ [ InitialObject, 1 ] ],
  
  function( cat )
    
    return InitialObject( cat );
    
end ],
    
[ TensorProductOnObjects,
  [ [ Coproduct, 1 ] ],
  
  function( cat, a, b )
    
    return Coproduct( cat, [ a, b ] );
    
end ],
    
[ TensorProductOnMorphismsWithGivenTensorProducts,
  [ [ CoproductOnMorphismsWithGivenCoproducts, 1 ] ],
  
  function( cat, source, mor1, mor2, target )
    
    return CoproductOnMorphismsWithGivenCoproducts( cat, source, mor1, mor2, target );
    
end ],
    
[ LeftUnitorWithGivenTensorProduct,
  [ [ CocartesianLeftUnitorWithGivenCoproduct, 1 ] ],
  
  function( cat, a, source )
    
    return CocartesianLeftUnitorWithGivenCoproduct( cat, a, source );
    
end ],
    
[ LeftUnitorInverseWithGivenTensorProduct,
  [ [ CocartesianLeftUnitorInverseWithGivenCoproduct, 1 ] ],
  
  function( cat, a, target )
    
    return CocartesianLeftUnitorInverseWithGivenCoproduct( cat, a, target );
    
end ],
    
[ RightUnitorWithGivenTensorProduct,
  [ [ CocartesianRightUnitorWithGivenCoproduct, 1 ] ],
  
  function( cat, a, source )
    
    return CocartesianRightUnitorWithGivenCoproduct( cat, a, source );
    
end ],
    
[ RightUnitorInverseWithGivenTensorProduct,
  [ [ CocartesianRightUnitorInverseWithGivenCoproduct, 1 ] ],
  
  function( cat, a, target )
    
    return CocartesianRightUnitorInverseWithGivenCoproduct( cat, a, target );
    
end ],
    
[ AssociatorLeftToRightWithGivenTensorProducts,
  [ [ CocartesianAssociatorLeftToRightWithGivenCoproducts, 1 ] ],
  
  function( cat, source, a, b, c, target )
    
    return CocartesianAssociatorLeftToRightWithGivenCoproducts( cat, source, a, b, c, target );
    
end ],
    
[ AssociatorRightToLeftWithGivenTensorProducts,
  [ [ CocartesianAssociatorRightToLeftWithGivenCoproducts, 1 ] ],
  
  function( cat, source, a, b, c, target )
    
    return CocartesianAssociatorRightToLeftWithGivenCoproducts( cat, source, a, b, c, target );
    
end ],
    
[ BraidingWithGivenTensorProducts,
  [ [ CocartesianBraidingWithGivenCoproducts, 1 ] ],
  
  function( cat, source, a, b, target )
    
    return CocartesianBraidingWithGivenCoproducts( cat, source, a, b, target );
    
end ],
    
[ BraidingInverseWithGivenTensorProducts,
  [ [ CocartesianBraidingInverseWithGivenCoproducts, 1 ] ],
  
  function( cat, source, a, b, target )
    
    return CocartesianBraidingInverseWithGivenCoproducts( cat, source, a, b, target );
    
end ]

  : CategoryFilter := cat -> HasIsCocartesianCategory( cat ) and IsCocartesianCategory( cat ) and
                      HasIsSymmetricMonoidalCategoryStructureGivenByCoproduct( cat ) and IsSymmetricMonoidalCategoryStructureGivenByCoproduct( cat ) );
