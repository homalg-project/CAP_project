# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects,
                    "InternalHomToTensorProductRightAdjunctionIsomorphismWithGivenObjects using BasisOfExternalHom and InternalHomToTensorProductRightAdjunctMorphism",
                    [ [ InternalHomOnObjects, 1 ],
                      [ BasisOfExternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct, 2 ],
                      [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects, 2 ],
                      [ UniversalMorphismFromCoproductWithGivenCoproduct, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, H_b_hom_ac, a, b, c, H_a_x_b_c )
    local H, Hom_b_hom_ac, a_x_b, iso, distinguished_object;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    Hom_b_hom_ac := BasisOfExternalHom( cat,
                            b,
                            InternalHomOnObjects( cat, a, c ) );
    
    a_x_b := TensorProductOnObjects( cat, a, b );
    
    iso := List( Hom_b_hom_ac, mor ->
                 InternalHomToTensorProductRightAdjunctMorphismWithGivenTensorProduct( cat,
                         a,
                         c,
                         mor,
                         a_x_b ) );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( H,
                   ListWithIdenticalEntries( Length( Hom_b_hom_ac ), distinguished_object ),
                   H_a_x_b_c,
                   List( iso, mor ->
                         InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
                                 distinguished_object,
                                 mor,
                                 H_a_x_b_c ) ),
                   H_b_hom_ac );
    
end :
  CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
  CategoryFilter := function( cat )
    return HasIsClosedMonoidalCategory( cat ) and IsClosedMonoidalCategory( cat ) and
           HasRangeCategoryOfHomomorphismStructure( cat ) and
           HasIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( cat ) and
           IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( cat );
end );

##
AddDerivationToCAP( InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects,
                    "InternalHomToTensorProductLeftAdjunctionIsomorphismWithGivenObjects using BasisOfExternalHom and InternalHomToTensorProductLeftAdjunctMorphism",
                    [ [ InternalHomOnObjects, 1 ],
                      [ BasisOfExternalHom, 1 ],
                      [ TensorProductOnObjects, 1 ],
                      [ InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct, 2 ],
                      [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects, 2 ],
                      [ UniversalMorphismFromCoproductWithGivenCoproduct, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, H_a_hom_bc, a, b, c, H_a_x_b_c )
    local H, Hom_a_hom_bc, a_x_b, iso, distinguished_object;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    Hom_a_hom_bc := BasisOfExternalHom( cat,
                            a,
                            InternalHomOnObjects( cat, b, c ) );
    
    a_x_b := TensorProductOnObjects( cat, a, b );
    
    iso := List( Hom_a_hom_bc, mor ->
                 InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( cat,
                         b,
                         c,
                         mor,
                         a_x_b ) );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( H,
                   ListWithIdenticalEntries( Length( Hom_a_hom_bc ), distinguished_object ),
                   H_a_x_b_c,
                   List( iso, mor ->
                         InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
                                 distinguished_object,
                                 mor,
                                 H_a_x_b_c ) ),
                   H_a_hom_bc );
    
end :
  CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
  CategoryFilter := function( cat )
    return HasIsClosedMonoidalCategory( cat ) and IsClosedMonoidalCategory( cat ) and
           HasRangeCategoryOfHomomorphismStructure( cat ) and
           HasIsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( cat ) and
           IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms( cat );
end );

##
AddDerivationToCAP( TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects,
                    "TensorProductToInternalHomRightAdjunctionIsomorphismWithGivenObjects for terminal categories",
                    [ [ MorphismsOfExternalHom, 1, RangeCategoryOfHomomorphismStructure ] ],
        
  function( cat, H_a_tensor_b_c, a, b, c, H_b_hom_ac )
    local H;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    return MorphismsOfExternalHom( H, H_a_tensor_b_c, H_b_hom_ac )[1];
    
end : CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := function( cat )
        return HasIsTerminalCategory( cat ) and IsTerminalCategory( cat ) and
               HasRangeCategoryOfHomomorphismStructure( cat ) and
               IsCapTerminalCategoryWithSingleObject( RangeCategoryOfHomomorphismStructure( cat ) );
end );

##
AddDerivationToCAP( TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects,
                    "TensorProductToInternalHomLeftAdjunctionIsomorphismWithGivenObjects for terminal categories",
                    [ [ MorphismsOfExternalHom, 1, RangeCategoryOfHomomorphismStructure ] ],
        
  function( cat, H_a_tensor_b_c, a, b, c, H_a_hom_bc )
    local H;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    return MorphismsOfExternalHom( H, H_a_tensor_b_c, H_a_hom_bc )[1];
    
end : CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
      CategoryFilter := function( cat )
        return HasIsTerminalCategory( cat ) and IsTerminalCategory( cat ) and
               HasRangeCategoryOfHomomorphismStructure( cat ) and
               IsCapTerminalCategoryWithSingleObject( RangeCategoryOfHomomorphismStructure( cat ) );
end );
