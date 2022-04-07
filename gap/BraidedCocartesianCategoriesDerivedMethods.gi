# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CocartesianBraidingInverseWithGivenCoproducts,
                  
  function( cat, object_2_u_object_1, object_1, object_2, object_1_u_object_2 )
    ##TODO: Use CocartesianBraidingWithGiven
    return InverseForMorphisms( cat, CocartesianBraiding( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsCocartesianCategory,
      Description := "CocartesianBraidingInverseWithGivenCoproducts as the inverse of the braiding" );

##
AddDerivationToCAP( CocartesianBraidingWithGivenCoproducts,
                  
  function( cat, object_1_u_object_2, object_1, object_2, object_2_u_object_1 )
    ##TODO: Use CocartesianBraidingInverseWithGiven
    return InverseForMorphisms( cat, CocartesianBraidingInverse( cat, object_1, object_2 ) );
    
end : CategoryFilter := IsCocartesianCategory,
      Description := "CocartesianBraidingWithGivenCoproducts as the inverse of CocartesianBraidingInverse" );
