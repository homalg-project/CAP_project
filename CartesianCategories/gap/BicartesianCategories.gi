# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

InstallTrueMethod( IsCartesianCategory, IsBicartesianCategory );
InstallTrueMethod( IsCocartesianCategory, IsBicartesianCategory );
InstallTrueMethod( IsBicartesianCategory, IsCartesianCategory and IsCocartesianCategory );

InstallTrueMethod( IsBicartesianCategory, IsAbelianCategory );

# https://ncatlab.org/nlab/show/bicartesian+closed+category
InstallTrueMethod( IsBicartesianCategory, IsBicartesianClosedCategory );
InstallTrueMethod( IsCartesianClosedCategory, IsBicartesianClosedCategory );
InstallTrueMethod( IsDistributiveCategory, IsBicartesianClosedCategory );

InstallTrueMethod( IsBicartesianCategory, IsBicartesianCoclosedCategory );
InstallTrueMethod( IsCocartesianCoclosedCategory, IsBicartesianCoclosedCategory );
#InstallTrueMethod( IsCodistributiveCategory, IsBicartesianCoclosedCategory );

InstallTrueMethod( IsCartesianCategory, IsFiniteCompleteCategory );
InstallTrueMethod( IsCocartesianCategory, IsFiniteCocompleteCategory );

InstallTrueMethod( IsFiniteCompleteCategory, IsAbelianCategory );
InstallTrueMethod( IsFiniteCocompleteCategory, IsAbelianCategory );

##
InstallMethodForCompilerForCAP( BinaryDirectProduct,
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( cat, object_1, object_2 )
    
    return DirectProduct( cat, [ object_1, object_2 ] );
    
end );

##
InstallMethodForCompilerForCAP( BinaryCoproduct,
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( cat, object_1, object_2 )
    
    return Coproduct( cat, [ object_1, object_2 ] );
    
end );
