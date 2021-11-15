# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObject,

  function( cat, object )

    return IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom( cat, object, object );

end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalCoHom,

  function( cat, object )

    return IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom( cat, object, object );

end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

####################################
# Convenience Methods
####################################

##
InstallMethod( InternalCoHom,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  InternalCoHomOnObjects );

##
InstallMethod( InternalCoHom,
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
        
  InternalCoHomOnMorphisms );

##
InstallMethod( InternalCoHom,
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( a, beta )
    
    return InternalCoHomOnMorphisms( IdentityMorphism( a ), beta );
    
end );

##
InstallMethod( InternalCoHom,
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( alpha, b )
    
    return InternalCoHomOnMorphisms( alpha, IdentityMorphism( b ) );
    
end );
