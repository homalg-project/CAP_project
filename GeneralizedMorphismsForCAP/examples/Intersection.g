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
m_obj := Source( m );

m2 := PreCompose( TensorProductOnMorphisms( m, IdentityMorphism( m_obj ) ), m );
m3 := PreCompose( TensorProductOnMorphisms( m2, IdentityMorphism( m_obj ) ), m );
m4 := PreCompose( TensorProductOnMorphisms( m3, IdentityMorphism( m_obj ) ), m );

N := AsLeftPresentation( HomalgMatrix( [ [ "(x+y)^2 - (y-x)^3" ], [ "y^2 - x^2*(x+1)" ] ], 2, 1, R ) );

filt1 := TensorProductOnMorphisms( m, IdentityMorphism( N ) );
degree1 := CokernelObject( filt1 );

filt2 := TensorProductOnMorphisms( m2, IdentityMorphism( N ) );
filt2 := ImageEmbedding( filt2 );

filt3 := TensorProductOnMorphisms( m3, IdentityMorphism( N ) );
filt3 := ImageEmbedding( filt3 );

quot3 := CokernelObject( LiftAlongMonomorphism( filt2, filt3 ) );

ProjectionInFactorOfFiberProduct( [ m ], 1 );

zero_support_tester := function( module_presentation )
  local number_of_generators, list_of_generators, list_of_kernel_embeddings, ideal_embedding;
    
    number_of_generators := NrColumns( UnderlyingMatrix( module_presentation ) );
    
    list_of_generators := List( [ 1 .. number_of_generators ], i -> StandardGeneratorMorphism( module_presentation, i ) );
    
    list_of_kernel_embeddings := List( list_of_generators, KernelEmbedding );
    
    ideal_embedding := PreCompose( ProjectionInFactorOfFiberProduct( list_of_kernel_embeddings, 1 ), list_of_kernel_embeddings[1] );
    
    SetIsMonomorphism( ideal_embedding, true );
    
    return not IsDominating( ideal_embedding, m );
    
end;

Serre_cat := LeftPresentations( R ) / zero_support_tester;

dimension_of_factor := function( object )
  local underlying_object, number_of_generators, list_of_generators, growing_morphism, generator, serre_generator, dimension;
    
    underlying_object := UnderlyingHonestObject( object );
    
    number_of_generators := NrColumns( UnderlyingMatrix( underlying_object ) );
    
    list_of_generators := List( [ 1 .. number_of_generators ], i -> StandardGeneratorMorphism( underlying_object, i ) );
    
    growing_morphism := UniversalMorphismFromZeroObject( object );
    
    dimension := 0;
    
    for generator in list_of_generators do
        
        if IsEpimorphism( ImageEmbedding( growing_morphism ) ) then
            
            break;
            
        fi;
        
        dimension := dimension + 1;
        
        serre_generator := AsSerreQuotientCategoryByThreeArrowsMorphism( Serre_cat, generator );
        
        growing_morphism := UniversalMorphismFromDirectSum( [ serre_generator, growing_morphism ] );
        
    od;
    
    return dimension;
    
end;

quot3 := AsSerreQuotientByThreeArrowsObject( Serre_cat, quot3 );

im3 := ImageObject( TensorProductOnMorphisms( m3, IdentityMorphism( N ) ) );
im3_tilde := AsSerreQuotientByThreeArrowsObject( Serre_cat, im3 );

im4 := ImageObject( TensorProductOnMorphisms( m4, IdentityMorphism( N ) ) );
im4_tilde := AsSerreQuotientByThreeArrowsObject( Serre_cat, im4 );

dimension_of_factor( quot3 );