# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( IsomorphismFromInternalHomToObject,

  function( cat, object )
    
    return IsomorphismFromInternalHomToObjectWithGivenInternalHom( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHom,

  function( cat, object )
    
    return IsomorphismFromObjectToInternalHomWithGivenInternalHom( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

####################################
# Convenience Methods
####################################

##
InstallMethod( InternalHom,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  InternalHomOnObjects );

##
InstallMethod( InternalHom,
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
        
  InternalHomOnMorphisms );

##
InstallMethod( InternalHom,
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( a, beta )
    
    return InternalHomOnMorphisms( IdentityMorphism( a ), beta );
    
end );

##
InstallMethod( InternalHom,
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( alpha, b )
    
    return InternalHomOnMorphisms( alpha, IdentityMorphism( b ) );
    
end );
