# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
InstallTrueMethod( IsSymmetricMonoidalCategory, IsSymmetricMonoidalCategoryStructureGivenByDirectProduct );

## Final methods for monoidal structure
AddFinalDerivationBundle( "set the cartesian structure as the symmetric monoidal structure",
        [ [ TerminalObject, 1 ],
          [ DirectProduct, 1 ],
          [ DirectProductOnMorphismsWithGivenDirectProducts, 1 ],
          [ CartesianLeftUnitorWithGivenDirectProduct, 1 ],
          [ CartesianLeftUnitorInverseWithGivenDirectProduct, 1 ],
          [ CartesianRightUnitorWithGivenDirectProduct, 1 ],
          [ CartesianRightUnitorInverseWithGivenDirectProduct, 1 ],
          [ CartesianAssociatorLeftToRightWithGivenDirectProducts, 1 ],
          [ CartesianAssociatorRightToLeftWithGivenDirectProducts, 1 ],
          [ CartesianBraidingWithGivenDirectProducts, 1 ],
          [ CartesianBraidingInverseWithGivenDirectProducts, 1 ] ],
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
  [ [ TerminalObject, 1 ] ],
  
  function( cat )
    
    return TerminalObject( cat );
    
end ],
  
[ TensorProductOnObjects,
  [ [ DirectProduct, 1 ] ],
  function( cat, a, b )
    
    return DirectProduct( cat, [ a, b ] );
    
end ],

[ TensorProductOnMorphismsWithGivenTensorProducts,
  [ [ DirectProductOnMorphismsWithGivenDirectProducts, 1 ] ],
  
  function( cat, source, mor1, mor2, target )
    
    return DirectProductOnMorphismsWithGivenDirectProducts( cat, source, mor1, mor2, target );
    
end ],

[ LeftUnitorWithGivenTensorProduct,
  [ [ CartesianLeftUnitorWithGivenDirectProduct, 1 ] ],
  
  function( cat, a, source )
    
    return CartesianLeftUnitorWithGivenDirectProduct( cat, a, source );
    
end ],

[ LeftUnitorInverseWithGivenTensorProduct,
  [ [ CartesianLeftUnitorInverseWithGivenDirectProduct, 1 ] ],
  
  function( cat, a, target )
    
    return CartesianLeftUnitorInverseWithGivenDirectProduct( cat, a, target );
    
end ],

[ RightUnitorWithGivenTensorProduct,
  [ [ CartesianRightUnitorWithGivenDirectProduct, 1 ] ],
  
  function( cat, a, source )
    
    return CartesianRightUnitorWithGivenDirectProduct( cat, a, source );
    
end ],

[ RightUnitorInverseWithGivenTensorProduct,
  [ [ CartesianRightUnitorInverseWithGivenDirectProduct, 1 ] ],
  
  function( cat, a, target )
    
    return CartesianRightUnitorInverseWithGivenDirectProduct( cat, a, target );
    
end ],

[ AssociatorLeftToRightWithGivenTensorProducts,
  [ [ CartesianAssociatorLeftToRightWithGivenDirectProducts, 1 ] ],
  
  function( cat, source, a, b, c, target )
    
    return CartesianAssociatorLeftToRightWithGivenDirectProducts( cat, source, a, b, c, target );
    
end ],

[ AssociatorRightToLeftWithGivenTensorProducts,
  [ [ CartesianAssociatorRightToLeftWithGivenDirectProducts, 1 ] ],
  
  function( cat, source, a, b, c, target )
    
    return CartesianAssociatorRightToLeftWithGivenDirectProducts( cat, source, a, b, c, target );
    
end ],

[ BraidingWithGivenTensorProducts,
  [ [ CartesianBraidingWithGivenDirectProducts, 1 ] ],
  
  function( cat, source, a, b, target )
    
    return CartesianBraidingWithGivenDirectProducts( cat, source, a, b, target );
    
end ],

[ BraidingInverseWithGivenTensorProducts,
  [ [ CartesianBraidingInverseWithGivenDirectProducts, 1 ] ],
  
  function( cat, source, a, b, target )
    
    return CartesianBraidingInverseWithGivenDirectProducts( cat, source, a, b, target );
    
end ]

  : CategoryFilter := cat -> HasIsCartesianCategory( cat ) and IsCartesianCategory( cat ) and
                      HasIsSymmetricMonoidalCategoryStructureGivenByDirectProduct( cat ) and IsSymmetricMonoidalCategoryStructureGivenByDirectProduct( cat ) );
