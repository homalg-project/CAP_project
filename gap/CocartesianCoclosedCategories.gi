# THIS FILE WAS AUTOMATICALLY GENERATED
# FROM MonoidalCategories v2021.11-04
# USING CategoryConstructor v2021.11-07

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( IsomorphismFromCoexponentialToObject,

  function( cat, object )

    return IsomorphismFromCoexponentialToObjectWithGivenCoexponential( cat, object, object );

end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( IsomorphismFromObjectToCoexponential,

  function( cat, object )

    return IsomorphismFromObjectToCoexponentialWithGivenCoexponential( cat, object, object );

end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

####################################
# Convenience Methods
####################################

##
InstallMethod( Coexponential,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  CoexponentialOnObjects );

##
InstallMethod( Coexponential,
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
        
  CoexponentialOnMorphisms );

##
InstallMethod( Coexponential,
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( a, beta )
    
    return CoexponentialOnMorphisms( IdentityMorphism( a ), beta );
    
end );

##
InstallMethod( Coexponential,
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( alpha, b )
    
    return CoexponentialOnMorphisms( alpha, IdentityMorphism( b ) );
    
end );
