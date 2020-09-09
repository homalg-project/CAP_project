if not IsBound( VectorSpacesConstructorsLoaded ) then
  
  ReadPackage( "CAP", "examples/VectorSpacesConstructors.g" );
  
fi;

if not IsCapCategory( vecspaces ) then

  vecspaces := CreateCapCategory( "VectorSpacesCacheIssue" );
  
fi;

##
AddKernelObject( vecspaces,
  [
    [
      function( morphism )
        local homalg_matrix;
        
        homalg_matrix := morphism!.morphism;
        
        return QVectorSpace( NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );
        
      end,
      
      [ ]
    ],
    
    [
      function( morphism )
        
        return QVectorSpace( 0 );
        
      end,
      
      [ IsMonomorphism ],
    ]
  ],
  100
);

##
AddIdentityMorphism( vecspaces,
                     
  function( obj )

    return VectorSpaceMorphism( obj, HomalgIdentityMatrix( Dimension( obj ), VECTORSPACES_FIELD ), obj );
    
end );

##
AddIsMonomorphism( vecspaces,

  function( morphism )
  
    return RowRankOfMatrix( morphism!.morphism ) = Dimension( Source( morphism ) );
  
end );


