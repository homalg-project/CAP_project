# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( IsomorphismFromInternalHomToObject,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ IsomorphismFromInternalHomToObjectWithGivenInternalHom, 1 ] ],
                    
  function( cat, object )
    
    return IsomorphismFromInternalHomToObjectWithGivenInternalHom( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalHom,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ IsomorphismFromObjectToInternalHomWithGivenInternalHom, 1 ] ],
                    
  function( cat, object )
    
    return IsomorphismFromObjectToInternalHomWithGivenInternalHom( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory );

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
