AddKernelEmbedding( vecspaces,

  function( cat, morphism )
    local kernel_emb, kernel_obj;
    
    kernel_emb := SyzygiesOfRows( morphism!.morphism );
    
    kernel_obj := QVectorSpace( NrRows( kernel_emb ) );
    
    return VectorSpaceMorphism( kernel_obj, kernel_emb, Source( morphism ) );
    
end );

AddLiftAlongMonomorphism( vecspaces,

  function( cat, monomorphism, test_morphism )

    return VectorSpaceMorphism(
             Source( test_morphism ),
             RightDivide( test_morphism!.morphism, monomorphism!.morphism ),
             Source( monomorphism ) );

end );