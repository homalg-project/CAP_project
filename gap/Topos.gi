# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
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
InstallTrueMethod( IsDistributiveCartesianCategory, IsBicartesianClosedCategory );

InstallTrueMethod( IsBicartesianCategory, IsBicartesianCoclosedCategory );
InstallTrueMethod( IsCocartesianCoclosedCategory, IsBicartesianCoclosedCategory );
#InstallTrueMethod( IsCodistributiveCocartesianCategory, IsBicartesianCoclosedCategory );

InstallTrueMethod( IsCartesianCategory, IsFiniteCompleteCategory );
InstallTrueMethod( IsCocartesianCategory, IsFiniteCocompleteCategory );

InstallTrueMethod( IsFiniteCompleteCategory, IsAbelianCategory );
InstallTrueMethod( IsFiniteCocompleteCategory, IsAbelianCategory );

InstallTrueMethod( IsFiniteCompleteCategory, IsElementaryTopos );
InstallTrueMethod( IsFiniteCocompleteCategory, IsElementaryTopos );
InstallTrueMethod( IsBicartesianClosedCategory, IsElementaryTopos );

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

##
InstallMethod( AddSubobjectClassifier,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then
        
        TryNextMethod( );
        
    fi;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddSubobjectClassifier( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );
