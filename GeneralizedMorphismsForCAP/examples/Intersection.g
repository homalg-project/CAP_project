LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "GeneralizedMorphismsForCAP" );
LoadPackage( "RingsForHomalg" );

## We use left presentations

Q := HomalgFieldOfRationalsInSingular();;
R := Q * "x,y";
m := HomalgMatrix( [ [ "x" ], [ "y" ] ], 2, 1, R );
F := FreeLeftPresentation( 1, R );
M := AsLeftPresentation( m );
m := PresentationMorphism( F, HomalgIdentityMatrix( 1, R ), M );
m := KernelEmbedding( m );

ProjectionInFactorOfFiberProduct( [ m ], 1 );

zero_support_tester := function( module_presentation )
  local number_of_generators, list_of_generators, list_of_kernel_embeddings, ideal_embedding;
    
    number_of_generators := NrColumns( UnderlyingMatrix( module_presentation ) );
    
    list_of_generators := List( [ 1 .. number_of_generators ], i -> StandardGeneratorMorphism( module_presentation, i ) );
    
    list_of_kernel_embeddings := List( list_of_generators, KernelEmbedding );
    
    ideal_embedding := ProjectionInFactorOfFiberProduct( list_of_kernel_embeddings, 1 );
    
    return IsDominating( ideal_embedding, m );
    
end;