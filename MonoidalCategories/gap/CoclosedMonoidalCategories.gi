##
AddDerivationToCAP( IsomorphismFromInternalCoHomToObject,

  function( cat, object )

    return IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom( object, object );

end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( IsomorphismFromObjectToInternalCoHom,

  function( cat, object )

    return IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom( object, object );

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
