#! @Chapter Examples and Tests

#! @Section Intersection of Nodal Curve and Cusp

LoadPackage( "ModulePresentationsForCAP" );
LoadPackage( "GeneralizedMorphismsForCAP" );
LoadPackage( "RingsForHomalg" );

#! We are going to intersect the nodal curve 
#! $f = y^2 - x^2(x+1)$
#! and the cusp $g = (x+y)^2 - (y-x)^3$.
#! The two curves are arranged in a way such that they intersect
#! at $(0,0)$ with intersection number as high as possible.
#! We are going to compute this intersection number
#! using the definition of the intersection number as the
#! length of the module $R/(f,g)$ localized at $(0,0)$.
#! In order to model modules over the localization of $Q[x,y]$ at
#! $(0,0)$, we use a suitable Serre quotient category.

Q := HomalgFieldOfRationalsInSingular();;
R := Q * "x,y";;
m := HomalgMatrix( [ [ "x" ], [ "y" ] ], 2, 1, R );;
F := FreeLeftPresentation( 1, R );;
M := AsLeftPresentation( m );;
m := PresentationMorphism( F, HomalgIdentityMatrix( 1, R ), M );;
m := KernelEmbedding( m );;
m_obj := Source( m );;

zero_support_tester := function( module_presentation )
  local number_of_generators, list_of_generators, list_of_kernel_embeddings, ideal_embedding;
    
    number_of_generators := NrColumns( UnderlyingMatrix( module_presentation ) );
    
    list_of_generators := List( [ 1 .. number_of_generators ], i -> StandardGeneratorMorphism( module_presentation, i ) );
    
    list_of_kernel_embeddings := List( list_of_generators, KernelEmbedding );
    
    ideal_embedding := PreCompose( ProjectionInFactorOfFiberProduct( list_of_kernel_embeddings, 1 ), list_of_kernel_embeddings[1] );
    
    SetIsMonomorphism( ideal_embedding, true );
    
    return not IsDominating( ideal_embedding, m );
    
end;;

Serre_cat := LeftPresentations( R ) / zero_support_tester;

Sh_functor := CanonicalProjection( Serre_cat );

InstallFunctor( Sh_functor, "Sh" );

dimension_of_factor := function( object )
  local underlying_object, number_of_generators, list_of_generators, growing_morphism, generator, serre_generator, dimension,
        image_embedding, last_image_embedding;
    
    underlying_object := UnderlyingHonestObject( object );
    
    number_of_generators := NrColumns( UnderlyingMatrix( underlying_object ) );
    
    list_of_generators := List( [ 1 .. number_of_generators ], i -> StandardGeneratorMorphism( underlying_object, i ) );
    
    growing_morphism := UniversalMorphismFromZeroObject( object );
    
    dimension := 0;
    
    image_embedding := ImageEmbedding( growing_morphism );
    
    for generator in list_of_generators do
        
        last_image_embedding := image_embedding;
        
        if IsEpimorphism( last_image_embedding ) then
            
            break;
            
        fi;
        dimension := dimension + 1;
        
        serre_generator := Sh( generator );
        
        growing_morphism := UniversalMorphismFromDirectSum( [ serre_generator, growing_morphism ] );
        
        image_embedding := ImageEmbedding( growing_morphism );
        
        if not IsEqualAsSubobjects( image_embedding, last_image_embedding ) then
            
            dimension := dimension + 1;
            
        fi;
        
    od;
    
    return dimension;
    
end;

m2 := PreCompose( TensorProductOnMorphisms( m, IdentityMorphism( m_obj ) ), m );
m3 := PreCompose( TensorProductOnMorphisms( m2, IdentityMorphism( m_obj ) ), m );
m4 := PreCompose( TensorProductOnMorphisms( m3, IdentityMorphism( m_obj ) ), m );

N := AsLeftPresentation( HomalgMatrix( [ [ "(x+y)^2 - (y-x)^3" ], [ "y^2 - x^2*(x+1)" ] ], 2, 1, R ) );

filt1 := TensorProductOnMorphisms( m, IdentityMorphism( N ) );
filt1 := ImageEmbedding( filt1 );
quot1 := CokernelObject( filt1 );

filt2 := TensorProductOnMorphisms( m2, IdentityMorphism( N ) );
filt2 := ImageEmbedding( filt2 );
quot2 := CokernelObject( LiftAlongMonomorphism( filt1, filt2 ) );

filt3 := TensorProductOnMorphisms( m3, IdentityMorphism( N ) );
filt3 := ImageEmbedding( filt3 );
quot3 := CokernelObject( LiftAlongMonomorphism( filt2, filt3 ) );

filt4 := TensorProductOnMorphisms( m4, IdentityMorphism( N ) );
filt4 := ImageEmbedding( filt4 );
quot4 := CokernelObject( LiftAlongMonomorphism( filt3, filt4 ) );

im4 := ImageObject( TensorProductOnMorphisms( m4, IdentityMorphism( N ) ) );
im4_tilde := Sh( im4 );

quot1 := Sh( quot1 );
quot2 := Sh( quot2 );
quot3 := Sh( quot3 );
quot4 := Sh( quot4 );

dimension_of_factor( quot1 );
#! 1
dimension_of_factor( quot2 );
#! 2
dimension_of_factor( quot3 );
#! 1
dimension_of_factor( quot4 );
#! 1
IsZero( im4_tilde );
#! true
