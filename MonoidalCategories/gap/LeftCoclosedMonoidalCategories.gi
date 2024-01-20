# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( IsomorphismFromLeftInternalCoHomToObject,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom, 1 ] ],
                    
  function( cat, object )

    return IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom( cat, object, object );

end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToLeftInternalCoHom,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom, 1 ] ],
                    
  function( cat, object )

    return IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom( cat, object, object );

end : CategoryFilter := IsSkeletalCategory );

####################################
# Convenience Methods
####################################

##
InstallMethod( LeftInternalCoHom,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  LeftInternalCoHomOnObjects );

##
InstallMethod( LeftInternalCoHom,
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
        
  LeftInternalCoHomOnMorphisms );

##
InstallMethod( LeftInternalCoHom,
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( a, beta )
    
    return LeftInternalCoHomOnMorphisms( IdentityMorphism( a ), beta );
    
end );

##
InstallMethod( LeftInternalCoHom,
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( alpha, b )
    
    return LeftInternalCoHomOnMorphisms( alpha, IdentityMorphism( b ) );
    
end );
