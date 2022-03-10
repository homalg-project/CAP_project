# SPDX-License-Identifier: GPL-2.0-or-later
# ToricSheaves: Toric sheaves as Serre quotients
#
# Implementations
#

InstallMethod( CategoryOfToricSheaves,
               [ IsToricVariety ],
               
  function( variety )
    local cox_ring, rays_in_maximal_cones, irrelevant_ideal_generators, i, j,
          current_generator;
    
    cox_ring := CoxRing( variety );
    
    ByASmallerPresentation( DegreeGroup( cox_ring ) );
    
    rays_in_maximal_cones := RaysInMaximalCones( FanOfVariety( variety ) );
    
    irrelevant_ideal_generators := [ ];
    
    for i in rays_in_maximal_cones do
        current_generator :=  [ ];
        for j in [ 1 .. Length( i ) ] do
            if i[ j ] = 0 then
                Add( current_generator, j );
            fi;
        od;
        Add( irrelevant_ideal_generators, current_generator );
    od;
    
    return CategoryOfToricSheaves( cox_ring, irrelevant_ideal_generators, IsSmooth( variety ) );
    
end );
