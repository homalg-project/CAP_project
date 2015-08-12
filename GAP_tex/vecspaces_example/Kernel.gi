AddKernelEmb( vecspaces,

  function( morphism )
    local kernel_emb, kernel_obj;
    
    kernel_emb := SyzygiesOfRows( morphism!.morphism );
    
    kernel_obj := QVectorSpace( NrRows( kernel_emb ) );
    
    return VectorSpaceMorphism( kernel_obj, kernel_emb, Source( morphism ) );
    
end );

AddKernelLift( vecspaces,

  function( morphism, test_morphism )
    local kernel_matrix;
    
    kernel_matrix := SyzygiesOfRows( morphism!.morphism );

    return VectorSpaceMorphism( Source( test_morphism ),
                                RightDivide( test_morphism!.morphism, kernel_matrix ),
                                QVectorSpace( NrRows( kernel_matrix ) ) );
    
end );