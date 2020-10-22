# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( CAP_INTERNAL_BRAIDED_CARTESIAN_CATEGORIES_BASIC_OPERATIONS, rec( ) );

##
CAP_INTERNAL_BRAIDED_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.CartesianBraiding := 
  [ [ "CartesianBraidingWithGivenDirectProducts", 1 ],
    [ "DirectProduct", 2 ] ];
##
InstallMethod( CartesianBraiding,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CartesianBraidingWithGivenDirectProducts( DirectProduct( object_1, object_2 ), object_1, object_2, DirectProduct( object_2, object_1 ) );
    
end );

##
InstallMethod( CartesianBraiding,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    local source_and_range;
    
    source_and_range := DirectProduct( object_1, object_2 );
    
    return CartesianBraidingWithGivenDirectProducts( source_and_range, object_1, object_2, source_and_range );
    
end );

##
CAP_INTERNAL_BRAIDED_CARTESIAN_CATEGORIES_BASIC_OPERATIONS.CartesianBraidingInverse := 
  [ [ "CartesianBraidingInverseWithGivenDirectProducts", 1 ],
    [ "DirectProduct", 2 ] ];
##
InstallMethod( CartesianBraidingInverse,
               [ IsCapCategoryObject, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    
    return CartesianBraidingInverseWithGivenDirectProducts( DirectProduct( object_2, object_1 ), object_1, object_2, DirectProduct( object_1, object_2 ) );
    
end );

##
InstallMethod( CartesianBraidingInverse,
               [ IsCapCategoryObject and IsCellOfSkeletalCategory, IsCapCategoryObject ],
               
  function( object_1, object_2 )
    local source_and_range;
    
    source_and_range := DirectProduct( object_1, object_2 );
    
    return CartesianBraidingInverseWithGivenDirectProducts( source_and_range, object_1, object_2, source_and_range );
    
end );

CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD( CAP_INTERNAL_BRAIDED_CARTESIAN_CATEGORIES_BASIC_OPERATIONS );
