## Implemented:
## - AddKernel
## - AddKernelEmbedding
## - AddKernelEmbeddingWithGivenKernelObject
## - AddKernelLift
## - AddKernelLiftWithGivenKernelObject

if not IsBound( VectorSpacesConstructorsLoaded ) then
  
  ReadPackage( "CAP", "examples/VectorSpacesConstructors.g" );
  
fi;

if not IsCapCategory( vecspaces ) then
  
  vecspaces := CreateCapCategory( "VectorSpacesK1" );
  
fi;

##
AddKernelObject( vecspaces,

  function( morphism )
    local homalg_matrix;

    homalg_matrix := morphism!.morphism;
  
    return QVectorSpace( NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );

end );

##
AddKernelEmbedding( vecspaces,

  function( morphism )
    local kernel_emb, kernel_obj;
    
    kernel_emb := SyzygiesOfRows( morphism!.morphism );
    
    kernel_obj := QVectorSpace( NrRows( kernel_emb ) );
    
    return VectorSpaceMorphism( kernel_obj, kernel_emb, Source( morphism ) );
    
end );

##
AddKernelEmbeddingWithGivenKernelObject( vecspaces,

  function( morphism, kernel )
    local kernel_emb;

    kernel_emb := SyzygiesOfRows( morphism!.morphism );

    return VectorSpaceMorphism( kernel, kernel_emb, Source( morphism ) );

end );

##
AddKernelLift( vecspaces,

  function( mor, test_object, test_morphism )
   local kernel_emb;
   
   kernel_emb := SyzygiesOfRows( mor!.morphism );
   
   return VectorSpaceMorphism( Source( test_morphism ), RightDivide( test_morphism!.morphism, kernel_emb ), QVectorSpace( NrRows( kernel_emb ) ) );
   
end );

##
AddKernelLiftWithGivenKernelObject( vecspaces,

  function( mor, test_object, test_morphism, kernel )
   local kernel_emb;
   
   kernel_emb := SyzygiesOfRows( mor!.morphism );
   
   return VectorSpaceMorphism( Source( test_morphism ), RightDivide( test_morphism!.morphism, kernel_emb ), kernel );
   
end );

Finalize( vecspaces );
