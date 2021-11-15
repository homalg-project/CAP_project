# THIS FILE WAS AUTOMATICALLY GENERATED FROM MonoidalCategories v2021.11-02

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CocartesianBraiding,

  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := Coproduct( cat, object_1, object_2 );
    
    return CocartesianBraidingWithGivenCoproducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( CocartesianBraidingInverse,

  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := Coproduct( cat, object_1, object_2 );
    
    return CocartesianBraidingInverseWithGivenCoproducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
InstallMethod( CheckCocartesianBraiding,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( A, B, C )
    local AB, mor1, mor2, BC;
    
    AB := Coproduct( A, B );
    
    mor1 := PreCompose( [
                    CocartesianBraiding( AB, C ),
                    CocartesianAssociatorRightToLeft( C, A, B ),
                    CoproductOnMorphisms( CocartesianBraiding( C, A ), IdentityMorphism( B ) ) ] );
    
    mor2 := PreCompose( [
                    CocartesianAssociatorLeftToRight( A, B, C ),
                    CoproductOnMorphisms( IdentityMorphism( A ), CocartesianBraiding( B, C ) ),
                    CocartesianAssociatorRightToLeft( A, C, B ) ] );
    
    if not IsCongruentForMorphisms( mor1, mor2 ) then
       return false;
    fi;
    
    BC := Coproduct( B, C );
    
    mor1 := PreCompose( [
                    CocartesianBraiding( A, BC ),
                    CocartesianAssociatorLeftToRight( B, C, A ),
                    CoproductOnMorphisms( IdentityMorphism( B ), CocartesianBraiding( C, A ) ) ] );
    
    mor2 := PreCompose( [
                    CocartesianAssociatorRightToLeft( A, B, C ),
                    CoproductOnMorphisms( CocartesianBraiding( A, B ), IdentityMorphism( C ) ),
                    CocartesianAssociatorLeftToRight( B, A, C ) ] );
    
    return IsCongruentForMorphisms( mor1, mor2 );
    
end );
