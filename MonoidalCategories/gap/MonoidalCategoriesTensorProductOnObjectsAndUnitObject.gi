# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

##
InstallMethod( TensorProductOp,
               [ IsList, IsCapCategoryObject ],
               
  function( list, object )
    local size, i;
    
    size := Length( list );
    
    if size = 1 then
        
        return object;
        
    else
        
        for i in [ 2 .. size ] do
            
            object := TensorProductOnObjects( object, list[i] );
            
        od;
        
    fi;
    
    return object;
    
end );

##
InstallMethod( TensorProductOp,
               [ IsList, IsCapCategoryMorphism ],
               
  function( list, morphism )
    local size, i;
    
    size := Length( list );
    
    if size = 1 then
        
        return morphism;
        
    else
        
        for i in [ 2 .. size ] do
            
            morphism := TensorProductOnMorphisms( morphism, list[i] );
            
        od;
        
    fi;
    
    return morphism;
    
end );
