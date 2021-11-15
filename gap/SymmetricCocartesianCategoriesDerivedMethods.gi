# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-02

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CocartesianBraidingWithGivenCoproducts,
                  
  function( cat, object_1_u_object_2, object_1, object_2, object_2_u_object_1 )
    
    return CocartesianBraidingInverseWithGivenCoproducts( cat,
                            object_1_u_object_2,
                            object_2, object_1,
                            object_2_u_object_1 );
    
end : CategoryFilter := IsCocartesianCategory,
      Description := "CocartesianBraidingWithGivenCoproducts using CocartesianBraidingInverseWithGivenCoproducts" );

##
AddDerivationToCAP( CocartesianBraidingInverseWithGivenCoproducts,
                  
  function( cat, object_2_u_object_1, object_1, object_2, object_1_u_object_2 )
    
    return CocartesianBraidingWithGivenCoproducts( cat,
                     object_2_u_object_1,
                     object_2, object_1,
                     object_1_u_object_2 );
    
end : CategoryFilter := IsCocartesianCategory,
      Description := "CocartesianBraidingInverseWithGivenCoproducts using CocartesianBraidingWithGivenCoproducts" );
