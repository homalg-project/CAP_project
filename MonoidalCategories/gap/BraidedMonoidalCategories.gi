InstallValue( CAP_INTERNAL_BRAIDED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_BRAIDED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.Braiding := 
  [ [ "BraidingWithGivenTensorProducts", 1 ],
    [ "TensorProductOnObjects", 2 ] ];
##
InstallMethod( Braiding,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return BraidingWithGivenTensorProducts( TensorProductOnObjects( object_1, object_2 ), object_1, object_2, TensorProductOnObjects( object_2, object_1 ) );
    
end );

##
InstallMethod( Braiding,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( object_1, object_2 );
    
    return BraidingWithGivenTensorProducts( source_and_range, object_1, object_2, source_and_range );
    
end );

##
CAP_INTERNAL_BRAIDED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS.BraidingInverse := 
  [ [ "BraidingInverseWithGivenTensorProducts", 1 ],
    [ "TensorProductOnObjects", 2 ] ];
##
InstallMethod( BraidingInverse,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return BraidingInverseWithGivenTensorProducts( TensorProductOnObjects( object_2, object_1 ), object_1, object_2, TensorProductOnObjects( object_1, object_2 ) );
    
end );

##
InstallMethod( BraidingInverse,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    local source_and_range;
    
    source_and_range := TensorProductOnObjects( object_1, object_2 );
    
    return BraidingInverseWithGivenTensorProducts( source_and_range, object_1, object_2, source_and_range );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_BRAIDED_MONOIDAL_CATEGORIES_BASIC_OPERATIONS );

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
