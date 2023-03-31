# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CartesianBraiding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 1 ],
                      [ CartesianBraidingWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := BinaryDirectProduct( cat, object_1, object_2 );
    
    return CartesianBraidingWithGivenDirectProducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( CartesianBraidingInverse,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 1 ],
                      [ CartesianBraidingInverseWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := BinaryDirectProduct( cat, object_1, object_2 );
    
    return CartesianBraidingInverseWithGivenDirectProducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory );

##
InstallMethod( CheckCartesianBraiding,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( A, B, C )
    local AB, mor1, mor2, BC;
    
    AB := DirectProduct( A, B );
    
    mor1 := PreCompose( [
                    CartesianBraiding( AB, C ),
                    CartesianAssociatorRightToLeft( C, A, B ),
                    DirectProductOnMorphisms( CartesianBraiding( C, A ), IdentityMorphism( B ) ) ] );
    
    mor2 := PreCompose( [
                    CartesianAssociatorLeftToRight( A, B, C ),
                    DirectProductOnMorphisms( IdentityMorphism( A ), CartesianBraiding( B, C ) ),
                    CartesianAssociatorRightToLeft( A, C, B ) ] );
    
    if not IsCongruentForMorphisms( mor1, mor2 ) then
       return false;
    fi;
    
    BC := DirectProduct( B, C );
    
    mor1 := PreCompose( [
                    CartesianBraiding( A, BC ),
                    CartesianAssociatorLeftToRight( B, C, A ),
                    DirectProductOnMorphisms( IdentityMorphism( B ), CartesianBraiding( C, A ) ) ] );
    
    mor2 := PreCompose( [
                    CartesianAssociatorRightToLeft( A, B, C ),
                    DirectProductOnMorphisms( CartesianBraiding( A, B ), IdentityMorphism( C ) ),
                    CartesianAssociatorLeftToRight( B, A, C ) ] );
    
    return IsCongruentForMorphisms( mor1, mor2 );
    
end );
