#! @Chunk CohP1

#! @Chapter Graded Module Presentations

#! @Section Examples

#! @Example
LoadPackage( "GradedModulePresentationsForCAP" );
#! true
Q := HomalgFieldOfRationalsInSingular( );
#! Q
S := GradedRing( Q["x,y"] );
#! Q[x,y]
#! (weights: yet unset)
Sgrmod := GradedLeftPresentations( S );
#! The category of graded left f.p. modules over Q[x,y] (with weights [ 1, 1 ])
InfoOfInstalledOperationsOfCategory( Sgrmod );
#! 40 primitive operations were used to derive 173 operations for this category which
#! * IsAbCategory
#! * IsMonoidalCategory
#! * IsAbelianCategoryWithEnoughProjectives
#ListPrimitivelyInstalledOperationsOfCategory( Sgrmod );
M := GradedFreeLeftPresentation( 2, S, [ 1, 1 ] );
#! <An object in The category of graded left f.p. modules over Q[x,y]
#!  (with weights [ 1, 1 ])>
N := GradedFreeLeftPresentation( 1, S, [ 0 ] );
#! <An object in The category of graded left f.p. modules over Q[x,y]
#!  (with weights [ 1, 1 ])>
mat := HomalgMatrix( "[x,y]", 2, 1, S );
#! <A 2 x 1 matrix over a graded ring>
Display( mat );
#! x,
#! y
#! (over a graded ring)
phi := GradedPresentationMorphism( M, mat, N );
#! <A morphism in The category of graded left f.p. modules over Q[x,y]
#!  (with weights [ 1, 1 ])>
IsWellDefined( phi );
#! true
IsMonomorphism( phi );
#! false
IsEpimorphism( phi );
#! false
iota := ImageEmbedding( phi );
#! <A monomorphism in The category of graded left f.p. modules over Q[x,y]
#!  (with weights [ 1, 1 ])>
IsMonomorphism( iota );
#! true
IsIsomorphism( iota );
#! false
coker_mod := CokernelObject( phi );
#! <An object in The category of graded left f.p. modules over Q[x,y]
#!  (with weights [ 1, 1 ])>
Display( coker_mod );
#! x,
#! y
#! (over a graded ring)
#! 
#! An object in The category of graded left f.p. modules over Q[x,y]
#! (with weights [ 1, 1 ])
#! 
#! (graded, degree of generator:[ 0 ])
IsZero( coker_mod );
#! false
is_artinian := M -> AffineDimension( M ) <= 0;
#! function( M ) ... end
C := FullSubcategoryByMembershipFunction( Sgrmod, is_artinian );
#! <Subcategory of The category of graded left f.p. modules over Q[x,y]
#!  (with weights [ 1, 1 ]) by is_artinian>
CohP1 := Sgrmod / C;
#! The Serre quotient category of The category of graded left f.p. modules
#! over Q[x,y] (with weights [ 1, 1 ]) by test function with name: is_artinian
InfoOfInstalledOperationsOfCategory( CohP1 );
#! 21 primitive operations were used to derive 141 operations for this category which
#! * IsAbCategory
#! * IsAbelianCategory
Sh := CanonicalProjection( CohP1 );
#! Embedding in The Serre quotient category of The category of graded left
#! f.p. modules over Q[x,y] (with weights [ 1, 1 ]) by test function with name:
#! is_artinian
InstallFunctor( Sh, "Sheafification" );
psi := ApplyFunctor( Sh, phi );
#! <A morphism in The Serre quotient category of The category of graded left
#!  f.p. modules over Q[x,y] (with weights [ 1, 1 ]) by test function with name:
#!  is_artinian>
IsMonomorphism( psi );
#! false
IsEpimorphism( psi );
#! true
coker_shv := CokernelObject( psi );
#! <A zero object in The Serre quotient category of The category of graded left
#!  f.p. modules over Q[x,y] (with weights [ 1, 1 ]) by test function with name:
#!  is_artinian>
IsZero( coker_shv );
#! true
epsilon := ApplyFunctor( Sh, iota );
#! <A morphism in The Serre quotient category of The category of graded left
#!  f.p. modules over Q[x,y] (with weights [ 1, 1 ]) by test function with name:
#!  is_artinian>
IsIsomorphism( epsilon );
#! true
#! @EndExample
