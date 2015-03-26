## Implemented:
## - AddKernel
## - AddKernelEmb
## - AddKernelEmbWithGivenKernel
## - AddKernelLift (using KernelEmb)
## - AddKernelLiftWithGivenKernel (using KernelEmbWithGivenKernel)

if not IsBound( VectorSpacesConstructorsLoaded ) then
  
  ReadPackage( "CAP", "examples/testfiles/VectorSpacesConstructors.gi" );
  
fi;

if not IsCapCategory( vecspaces ) then
  
  vecspaces := CreateCapCategory( "VectorSpacesK2" );
  
fi;

##
AddKernelObject( vecspaces,

  function( morphism )
    local homalg_matrix;

    homalg_matrix := morphism!.morphism;
  
    return QVectorSpace( NrRows( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ) );

end );

##
AddKernelEmb( vecspaces,

  function( morphism )
    local kernel_emb, kernel_obj;
    
    kernel_emb := SyzygiesOfRows( morphism!.morphism );
    
    kernel_obj := QVectorSpace( NrRows( kernel_emb ) );
    
    return VectorSpaceMorphism( kernel_obj, kernel_emb, Source( morphism ) );
    
end );

##
AddKernelEmbWithGivenKernel( vecspaces,

  function( morphism, kernel )
    local kernel_emb;

    kernel_emb := SyzygiesOfRows( morphism!.morphism );

    return VectorSpaceMorphism( kernel, kernel_emb, Source( morphism ) );

end );

##
AddKernelLift( vecspaces,

  function( mor, test_morphism )
   local kernel_emb;
   
   kernel_emb := KernelEmb( mor );
   
   return VectorSpaceMorphism( Source( test_morphism ), RightDivide( test_morphism!.morphism, kernel_emb!.morphism ), Source( kernel_emb ) );
   
end );

##
AddKernelLiftWithGivenKernel( vecspaces,

  function( mor, test_morphism, kernel )
   local kernel_emb;
   
   kernel_emb := KernelEmbWithGivenKernel( mor, kernel );
   
   return VectorSpaceMorphism( Source( test_morphism ), RightDivide( test_morphism!.morphism, kernel_emb!.morphism ), kernel );
   
end );