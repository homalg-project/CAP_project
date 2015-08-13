AddAdditionForMorphisms( vecspaces,
                         
  function( a, b )
    
    return VectorSpaceMorphism( Source( a ),
              a!.morphism + b!.morphism,
              Range( a ) );
    
end );

AddAdditiveInverseForMorphisms( vecspaces,
                                
  function( a )
    
    return VectorSpaceMorphism( Source( a ),
              - a!.morphism,
              Range( a ) );
    
end );

AddZeroMorphism( vecspaces,
                     
  function( a, b )
    
    return VectorSpaceMorphism( a,
              HomalgZeroMatrix( Dimension( a ),
                                Dimension( b ),
                                VECTORSPACES_FIELD ),
              b );
    
end );