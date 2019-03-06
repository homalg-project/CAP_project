#! @Chapter Examples and Tests

#! @Section Cokernel image closure 

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );;

#! @Example
R := HomalgFieldOfRationalsInSingular() * "x,y,z";;
RowsR := CategoryOfRows( R );;
m := AsCategoryOfRowsMorphism( 
    HomalgMatrix( "[[x],[y],[z]]", 3, 1, R )
);;
mu := AsCokernelImageClosureMorphism( m );;

C := CokernelObject( mu );;
C2 := AsFinitelyPresentedCokernelImageClosureObject( m );;
IsEqualForObjects( C, C2 );
#! true
n := AsCategoryOfRowsMorphism( 
    HomalgMatrix( "[[x,y],[y^2,z]]", 2, 2, R )
);;
nu := AsCokernelImageClosureMorphism( n );;
nu2 := PreCompose( nu, nu );;
IsWellDefined( nu2 );
#! true
IsCongruentForMorphisms( nu, nu2 );
#! false
nu + nu;;
nu2 - nu;;
cat := CapCategory( nu );;
ZeroObject( cat );;
ZeroMorphism( Source( nu ), Source( mu ) );;
UniversalMorphismIntoZeroObject( Source( nu ) );;
UniversalMorphismFromZeroObject( Source( nu ) );;

S := Source( mu );;
DirectSum( [S, S, S ] );;
DirectSumFunctorial( [ nu2, nu ] );;
UniversalMorphismIntoDirectSum( [ nu, nu ] );;
UniversalMorphismFromDirectSum( [ nu, nu ] );;
ProjectionInFactorOfDirectSum( [ S, S, S ], 2 );;
InjectionOfCofactorOfDirectSum( [ S, S, S, S ], 4 );;

CokernelColift( nu, CokernelProjection( nu ) );;

IsCongruentForMorphisms( nu, PreCompose( CoastrictionToImage( nu ), ImageEmbedding( nu ) ) );
#! true
u := UniversalMorphismFromImage( nu, [ nu, IdentityMorphism( Range( nu ) ) ] );;
IsWellDefined( u );
#! true
IsCongruentForMorphisms( nu, PreCompose( CoastrictionToImage( nu ), u ) );
#! true
IsCongruentForMorphisms( u, ImageEmbedding( nu ) );
#! true
kernel := KernelObject( mu );;
emb := KernelEmbedding( mu );;
p := PreCompose( EpimorphismFromSomeProjectiveObject( kernel ), KernelEmbedding( mu ) );;
KernelLift( mu, p );;
LiftAlongMonomorphism( emb, p );;
I_to_A := FunctorCokernelImageClosureToFreydCategory( RowsR );;
A_to_I := FunctorFreydCategoryToCokernelImageClosure( RowsR );;
ApplyFunctor( I_to_A, kernel );;
ApplyFunctor( A_to_I, ApplyFunctor( I_to_A, kernel ) );;
nu := NaturalIsomorphismFromIdentityToFinitePresentationOfCokernelImageClosureObject( RowsR );;
mu := NaturalIsomorphismFromFinitePresentationOfCokernelImageClosureObjectToIdentity( RowsR );;
IsCongruentForMorphisms(
    IdentityMorphism( kernel ),
    PreCompose( ApplyNaturalTransformation( nu, kernel ), ApplyNaturalTransformation( mu, kernel ) )
);
#! true
#! @EndExample