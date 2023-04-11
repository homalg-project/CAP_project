# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

InstallTrueMethod( IsCartesianCategory, IsBicartesianCategory );
InstallTrueMethod( IsCocartesianCategory, IsBicartesianCategory );
#= comment for Julia
InstallTrueMethod( IsBicartesianCategory, IsCartesianCategory and IsCocartesianCategory );
# =#

# https://ncatlab.org/nlab/show/bicartesian+closed+category
#= comment for Julia
InstallTrueMethod( IsBicartesianClosedCategory, IsCartesianClosedCategory and IsCocartesianCategory );
# =#
InstallTrueMethod( IsCartesianClosedCategory, IsBicartesianClosedCategory );
InstallTrueMethod( IsCocartesianCategory, IsBicartesianClosedCategory );
InstallTrueMethod( IsDistributiveCategory, IsBicartesianClosedCategory );

# https://ncatlab.org/nlab/show/bicartesian+coclosed+category
#= comment for Julia
InstallTrueMethod( IsBicartesianCoclosedCategory, IsCocartesianCoclosedCategory and IsCartesianCategory );
# =#
InstallTrueMethod( IsCocartesianCoclosedCategory, IsBicartesianCoclosedCategory );
InstallTrueMethod( IsCartesianCategory, IsBicartesianClosedCategory );
InstallTrueMethod( IsCodistributiveCategory, IsBicartesianCoclosedCategory );

InstallTrueMethod( IsCartesianCategory, IsFiniteCompleteCategory );
InstallTrueMethod( IsCocartesianCategory, IsFiniteCocompleteCategory );

InstallTrueMethod( IsBicartesianCategory, IsAbelianCategory );
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
