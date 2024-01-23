# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
InstallMethod( CoclosedCoevaluationMorphism,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b )
    
    return CoclosedMonoidalLeftCoevaluationMorphism( b, a );

end );

##
InstallMethod( CoclosedCoevaluationMorphismWithGivenSource,
        [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b, s )

    CoclosedMonoidalLeftCoevaluationMorphismWithGivenSource( b, a, s );
    
end );

##
InstallMethod( CoclosedEvaluationMorphism,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b )

    CoclosedMonoidalLeftEvaluationMorphism( b, a );
    
end );

##
InstallMethod( CoclosedEvaluationMorphismWithGivenRange,
        [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b, r )
    
    CoclosedMonoidalLeftEvaluationMorphismWithGivenRange( b, a, r );
    
end );

##
InstallMethod( CoevaluationMorphism,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b )

    ClosedMonoidalLeftCoevaluationMorphism( b, a );
    
end );

##
InstallMethod( CoevaluationMorphismWithGivenRange,
        [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( a, b, r )
    
    ClosedMonoidalLeftCoevaluationMorphismWithGivenRange( b, a, r );
    
end );
