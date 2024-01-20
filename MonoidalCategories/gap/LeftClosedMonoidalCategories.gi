# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( IsomorphismFromLeftInternalHomToObject,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom, 1 ] ],
                    
  function( cat, object )
    
    return IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToLeftInternalHom,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom, 1 ] ],
                    
  function( cat, object )
    
    return IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom( cat, object, object );
    
end : CategoryFilter := IsSkeletalCategory );

####################################
# Convenience Methods
####################################

##
InstallMethod( LeftInternalHom,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  LeftInternalHomOnObjects );

##
InstallMethod( LeftInternalHom,
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
        
  LeftInternalHomOnMorphisms );

##
InstallMethod( LeftInternalHom,
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( a, beta )
    
    return LeftInternalHomOnMorphisms( IdentityMorphism( a ), beta );
    
end );

##
InstallMethod( LeftInternalHom,
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( alpha, b )
    
    return LeftInternalHomOnMorphisms( alpha, IdentityMorphism( b ) );
    
end );
