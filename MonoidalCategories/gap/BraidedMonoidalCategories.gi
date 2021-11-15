# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( Braiding,

  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object_1, object_2 );
    
    return BraidingWithGivenTensorProducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( BraidingInverse,

  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( cat, object_1, object_2 );
    
    return BraidingInverseWithGivenTensorProducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
InstallMethod( CheckBraiding,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( A, B, C )
    local AB, mor1, mor2, BC;
    
    AB := TensorProduct( A, B );
    
    mor1 := PreCompose( [
                    Braiding( AB, C ),
                    AssociatorRightToLeft( C, A, B ),
                    TensorProductOnMorphisms( Braiding( C, A ), IdentityMorphism( B ) ) ] );
    
    mor2 := PreCompose( [
                    AssociatorLeftToRight( A, B, C ),
                    TensorProductOnMorphisms( IdentityMorphism( A ), Braiding( B, C ) ),
                    AssociatorRightToLeft( A, C, B ) ] );
    
    if not IsCongruentForMorphisms( mor1, mor2 ) then
       return false;
    fi;
    
    BC := TensorProduct( B, C );
    
    mor1 := PreCompose( [
                    Braiding( A, BC ),
                    AssociatorLeftToRight( B, C, A ),
                    TensorProductOnMorphisms( IdentityMorphism( B ), Braiding( C, A ) ) ] );
    
    mor2 := PreCompose( [
                    AssociatorRightToLeft( A, B, C ),
                    TensorProductOnMorphisms( Braiding( A, B ), IdentityMorphism( C ) ),
                    AssociatorLeftToRight( B, A, C ) ] );
    
    return IsCongruentForMorphisms( mor1, mor2 );
    
end );
