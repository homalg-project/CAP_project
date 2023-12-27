# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
AddDerivationToCAP( ExponentialToDirectProductRightAdjunctionIsomorphismWithGivenObjects,
                    "ExponentialToDirectProductRightAdjunctionIsomorphismWithGivenObjects using MorphismsOfExternalHom and ExponentialToDirectProductRightAdjunctMorphism",
                    [ [ ExponentialOnObjects, 1 ],
                      [ MorphismsOfExternalHom, 1 ],
                      [ DirectProduct, 1 ],
                      [ ExponentialToDirectProductRightAdjunctMorphismWithGivenDirectProduct, 2 ],
                      [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects, 2 ],
                      [ UniversalMorphismFromCoproductWithGivenCoproduct, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, H_b_exp_ac, a, b, c, H_a_x_b_c )
    local H, Hom_b_exp_ac, a_x_b, iso, distinguished_object;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    Hom_b_exp_ac := MorphismsOfExternalHom( cat,
                            b,
                            ExponentialOnObjects( cat, a, c ) );
    
    a_x_b := BinaryDirectProduct( cat, a, b );
    
    iso := List( Hom_b_exp_ac, mor ->
                 ExponentialToDirectProductRightAdjunctMorphismWithGivenDirectProduct( cat,
                         a,
                         c,
                         mor,
                         a_x_b ) );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( H,
                   ListWithIdenticalEntries( Length( Hom_b_exp_ac ), distinguished_object ),
                   H_a_x_b_c,
                   List( iso, mor ->
                         InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
                                 distinguished_object,
                                 mor,
                                 H_a_x_b_c ) ),
                   H_b_exp_ac );
    
end :
  CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
  CategoryFilter := function( cat )
    return HasIsCartesianClosedCategory( cat ) and IsCartesianClosedCategory( cat ) and
           HasRangeCategoryOfHomomorphismStructure( cat ) and
           ( IsCapTerminalCategoryWithSingleObject( RangeCategoryOfHomomorphismStructure( cat ) ) or
             ( IsBoundGlobal( "IsSkeletalCategoryOfFiniteSets" ) and
               ValueGlobal( "IsSkeletalCategoryOfFiniteSets" )( RangeCategoryOfHomomorphismStructure( cat ) ) ) );
end );

##
AddDerivationToCAP( ExponentialToDirectProductLeftAdjunctionIsomorphismWithGivenObjects,
                    "ExponentialToDirectProductLeftAdjunctionIsomorphismWithGivenObjects using MorphismsOfExternalHom and ExponentialToDirectProductLeftAdjunctMorphism",
                    [ [ ExponentialOnObjects, 1 ],
                      [ MorphismsOfExternalHom, 1 ],
                      [ DirectProduct, 1 ],
                      [ ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct, 2 ],
                      [ DistinguishedObjectOfHomomorphismStructure, 1 ],
                      [ InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects, 2 ],
                      [ UniversalMorphismFromCoproductWithGivenCoproduct, 1, RangeCategoryOfHomomorphismStructure ] ],
                    
  function( cat, H_a_exp_bc, a, b, c, H_a_x_b_c )
    local H, Hom_a_exp_bc, a_x_b, iso, distinguished_object;
    
    H := RangeCategoryOfHomomorphismStructure( cat );
    
    Hom_a_exp_bc := MorphismsOfExternalHom( cat,
                            a,
                            ExponentialOnObjects( cat, b, c ) );
    
    a_x_b := BinaryDirectProduct( cat, a, b );
    
    iso := List( Hom_a_exp_bc, mor ->
                 ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct( cat,
                         b,
                         c,
                         mor,
                         a_x_b ) );
    
    distinguished_object := DistinguishedObjectOfHomomorphismStructure( cat );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( H,
                   ListWithIdenticalEntries( Length( Hom_a_exp_bc ), distinguished_object ),
                   H_a_x_b_c,
                   List( iso, mor ->
                         InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
                                 distinguished_object,
                                 mor,
                                 H_a_x_b_c ) ),
                   H_a_exp_bc );
    
end :
  CategoryGetters := rec( H := RangeCategoryOfHomomorphismStructure ),
  CategoryFilter := function( cat )
    return HasIsCartesianClosedCategory( cat ) and IsCartesianClosedCategory( cat ) and
           HasRangeCategoryOfHomomorphismStructure( cat ) and
           ( IsCapTerminalCategoryWithSingleObject( RangeCategoryOfHomomorphismStructure( cat ) ) or
             ( IsBoundGlobal( "IsSkeletalCategoryOfFiniteSets" ) and
               ValueGlobal( "IsSkeletalCategoryOfFiniteSets" )( RangeCategoryOfHomomorphismStructure( cat ) ) ) );
end );
