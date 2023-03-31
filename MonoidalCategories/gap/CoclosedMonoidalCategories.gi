# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObject,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom, 1 ] ],
                    
  function( cat, object )

    return IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom( cat, object, object );

end : CategoryFilter := IsSkeletalCategory );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalCoHom,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom, 1 ] ],
                    
  function( cat, object )

    return IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom( cat, object, object );

end : CategoryFilter := IsSkeletalCategory );

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
