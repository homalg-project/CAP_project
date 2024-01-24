# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
InstallMethod( CocartesianCoevaluationMorphism,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b )
    
    return CocartesianLeftCoevaluationMorphism( b, a );

end );

##
InstallMethod( CocartesianCoevaluationMorphismWithGivenSource,
        [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b, s )

    CocartesianLeftCoevaluationMorphismWithGivenSource( b, a, s );
    
end );

##
InstallMethod( CocartesianEvaluationMorphism,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b )

    CocartesianLeftEvaluationMorphism( b, a );
    
end );

##
InstallMethod( CocartesianEvaluationMorphismWithGivenRange,
        [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b, r )
    
    CocartesianLeftEvaluationMorphismWithGivenRange( b, a, r );
    
end );

##
InstallMethod( CartesianCoevaluationMorphism,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b )

    CartesianLeftCoevaluationMorphism( b, a );
    
end );

##
InstallMethod( CartesianCoevaluationMorphismWithGivenRange,
        [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b, r )
    
    CartesianLeftCoevaluationMorphismWithGivenRange( b, a, r );
    
end );
