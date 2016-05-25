LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "RingsForHomalg" );
LoadPackage( "GeneralizedMorphismsForCAP" );


Q := HomalgFieldOfRationalsInSingular();
S := Q * "x,y";

elements_of_irrelevant_ideal := 
[ "x", "y" ];

HasSupportInZero := function( module_presentation )
  local number_of_generators, list_of_generators, list_of_kernel_embeddings, ideal_embedding,
        ideal_matrix, Fn1, F1, S, Sy, elem, matrix, entry;
    
    number_of_generators := NrColumns( UnderlyingMatrix( module_presentation ) );
    
    if number_of_generators = 0 then
        
        return true;
        
    fi;
    
    list_of_generators := List( [ 1 .. number_of_generators ], i -> StandardGeneratorMorphism( module_presentation, i ) );
    
    list_of_kernel_embeddings := List( list_of_generators, KernelEmbedding );
    
    ideal_embedding := 
      PreCompose( ProjectionInFactorOfFiberProduct( list_of_kernel_embeddings, 1 ), list_of_kernel_embeddings[1] );
    
    SetIsMonomorphism( ideal_embedding, true );
    
    S := UnderlyingHomalgRing( module_presentation );
    
    Sy := S * "RabinowitschTrickVariable";
    
    ideal_matrix := UnderlyingMatrix( ideal_embedding ) * Sy;
    
    Fn1 := FreeLeftPresentation( NrRows( ideal_matrix ) + 1, Sy );
    
    F1 := FreeLeftPresentation( 1, Sy );
    
    for elem in elements_of_irrelevant_ideal do
        
        entry := HomalgMatrix( [ [ elem ] ], 1, 1, S );
        
        entry := entry * Sy;
        
        entry := entry * HomalgMatrix( [ [ "RabinowitschTrickVariable" ] ], 1, 1, Sy ) - HomalgMatrix( [ [ "1" ] ], 1, 1, Sy );
        
        matrix := UnionOfRows( ideal_matrix, entry );
        
        if not IsEpimorphism( PresentationMorphism( Fn1, matrix, F1 ) ) then
            
            return false;
            
        fi;
        
    od;
    
    return true;
    
end;;

# A := LeftPresentations( S );
# C := FullSubcategoryByMembershipFunction( A, HasSupportInZero );
# Coh := A/C;
# Sh := CanonicalProjection( Coh );
# M := AsLeftPresentation( HomalgMatrix( [ [ "x*y" ] ], S ) );
# N := AsLeftPresentation( HomalgMatrix( [ [ "x" ] ], S ) );
# O := AsLeftPresentation( HomalgMatrix( [ [ "y" ] ], S ) );
# phi := PresentationMorphism( M, HomalgMatrix( [ [ 1, 1 ] ], S ), DirectSum( N, O ) );
# IsIsomorphism( phi );
# IsIsomorphism( ApplyFunctor( Sh, phi ) );


# Serre_cat := LeftPresentations( S ) / HasSupportInZero;
# Sh_functor := CanonicalProjection( Serre_cat );
# 
# 
# M := HomalgMatrix( [ [ "c*d^2" ], [ "b^3" ], [ "a^4" ] ], 3, 1, S );
# k:= AsLeftPresentation( M );
# k_sheaf := ApplyFunctor( Sh_functor, k );
# IsZero( k_sheaf );
# #! true
# 
# k_sheaf := ApplyFunctor( Sh_functor, ZeroObject( LeftPresentations( S ) ) );
# IsZero( k_sheaf );
# #! true
# 
# M := HomalgMatrix( [ [ "a*b" ] ], 1, 1, S );
# k:= AsLeftPresentation( M );
# k_sheaf := ApplyFunctor( Sh_functor, k );
# IsZero( k_sheaf );
# #! false
# 
# k_sheaf := ApplyFunctor( Sh_functor, FreeLeftPresentation( 3, S ) );
# IsZero( k_sheaf );
# #! false