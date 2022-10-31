#! @Chapter Examples and Tests

#! @Section Generalized Morphisms Category


if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CAP", "examples/VectorSpacesConstructors.g" );;

fi;
# ActivateDerivationInfo();
#! @Example
vecspaces := CreateCapCategory( "VectorSpacesForGeneralizedMorphismsTest" );
#! VectorSpacesForGeneralizedMorphismsTest
ReadPackage( "CAP", "examples/VectorSpacesAllMethods.g" );
#! true
LoadPackage( "GeneralizedMorphismsForCAP", false );
#! true
B := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
C := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
B_1 := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
C_1 := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
c1_source_aid := VectorSpaceMorphism( B_1, [ [ 1, 0 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0 ] ]
#! 
SetIsSubobject( c1_source_aid, true );
c1_range_aid := VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 1 ], [ 0, 0 ] ], C_1 );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0 ],
#!   [  0,  1 ],
#!   [  0,  0 ] ]
#! 
SetIsFactorobject( c1_range_aid, true );
c1_associated := VectorSpaceMorphism( B_1, [ [ 1, 1 ] ], C_1 );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  1 ] ]
#! 
c1 := GeneralizedMorphism( c1_source_aid, c1_associated, c1_range_aid );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
B_2 := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
C_2 := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
c2_source_aid := VectorSpaceMorphism( B_2, [ [ 2, 0 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  2,  0 ] ]
#! 
SetIsSubobject( c2_source_aid, true );
c2_range_aid := VectorSpaceMorphism( C, [ [ 3, 0 ], [ 0, 3 ], [ 0, 0 ] ], C_2 );
#! A rational vector space homomorphism with matrix: 
#! [ [  3,  0 ],
#!   [  0,  3 ],
#!   [  0,  0 ] ]
#! 
SetIsFactorobject( c2_range_aid, true );
c2_associated := VectorSpaceMorphism( B_2, [ [ 6, 6 ] ], C_2 );
#! A rational vector space homomorphism with matrix: 
#! [ [  6,  6 ] ]
#! 
c2 := GeneralizedMorphism( c2_source_aid, c2_associated, c2_range_aid );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
IsCongruentForMorphisms( c1, c2 );
#! true
IsCongruentForMorphisms( c1, c1 );
#! true
c3_associated := VectorSpaceMorphism( B_1, [ [ 2, 2 ] ], C_1 );
#! A rational vector space homomorphism with matrix: 
#! [ [  2,  2 ] ]
#! 
c3 := GeneralizedMorphism( c1_source_aid, c3_associated, c1_range_aid );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
IsCongruentForMorphisms( c1, c3 );
#! false
IsCongruentForMorphisms( c2, c3 );
#! false
c1 + c2;
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
Arrow( c1 + c2 );
#! A rational vector space homomorphism with matrix: 
#! [ [  12,  12 ] ]
#! 
#! @EndExample

#! First composition test:

#! @Example
vecspaces := CreateCapCategory( "VectorSpacesForGeneralizedMorphismsTest" );
#! VectorSpacesForGeneralizedMorphismsTest
ReadPackage( "CAP", "examples/VectorSpacesAllMethods.g" );
#! true
A := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
B := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
C := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
phi_tilde_associated := VectorSpaceMorphism( A, [ [ 1, 2, 0 ] ], C );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  2,  0 ] ]
#! 
phi_tilde_source_aid := VectorSpaceMorphism( A, [ [ 1, 2 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  2 ] ]
#! 
phi_tilde := GeneralizedMorphismWithSourceAid( phi_tilde_source_aid, phi_tilde_associated );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
psi_tilde_associated := IdentityMorphism( B );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0 ],
#!   [  0,  1 ] ]
#! 
psi_tilde_source_aid := VectorSpaceMorphism( B, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], C );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
psi_tilde := GeneralizedMorphismWithSourceAid( psi_tilde_source_aid, psi_tilde_associated );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
composition := PreCompose( phi_tilde, psi_tilde );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
Arrow( composition );
#! A rational vector space homomorphism with matrix: 
#! [ [  1/2,    1 ] ]
#! 
SourceAid( composition );
#! A rational vector space homomorphism with matrix: 
#! [ [  1/2,    1 ] ]
#! 
RangeAid( composition );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0 ],
#!   [  0,  1 ] ]
#! @EndExample

#! Second composition test

#! @Example
vecspaces := CreateCapCategory( "VectorSpacesForGeneralizedMorphismsTest" );
#! VectorSpacesForGeneralizedMorphismsTest
ReadPackage( "CAP", "examples/VectorSpacesAllMethods.g" );
#! true
A := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
B := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
C := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
phi2_tilde_associated := VectorSpaceMorphism( A, [ [ 1, 5 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  5 ] ]
#! 
phi2_tilde_range_aid := VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0 ],
#!   [  0,  1 ],
#!   [  1,  1 ] ]
#! 
phi2_tilde := GeneralizedMorphismWithRangeAid( phi2_tilde_associated, phi2_tilde_range_aid );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
psi2_tilde_associated := VectorSpaceMorphism( C, [ [ 1 ], [ 3 ], [ 4 ] ], A );
#! A rational vector space homomorphism with matrix: 
#! [ [  1 ],
#!   [  3 ],
#!   [  4 ] ]
#! 
psi2_tilde_range_aid := VectorSpaceMorphism( B, [ [ 1 ], [ 1 ] ], A );
#! A rational vector space homomorphism with matrix: 
#! [ [  1 ],
#!   [  1 ] ]
#! 
psi2_tilde := GeneralizedMorphismWithRangeAid( psi2_tilde_associated, psi2_tilde_range_aid );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
composition2 := PreCompose( phi2_tilde, psi2_tilde );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
Arrow( composition2 );
#! A rational vector space homomorphism with matrix: 
#! [ [  16 ] ]
#! 
RangeAid( composition2 );
#! A rational vector space homomorphism with matrix: 
#! [ [  1 ],
#!   [  1 ] ]
#! 
SourceAid( composition2 );
#! A rational vector space homomorphism with matrix: 
#! [ [  1 ] ]
#! @EndExample

#! Third composition test

#! @Example
vecspaces := CreateCapCategory( "VectorSpacesForGeneralizedMorphismsTest" );
#! VectorSpacesForGeneralizedMorphismsTest
ReadPackage( "CAP", "examples/VectorSpacesAllMethods.g" );
#! true
A := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
Asub := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
B := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
Bfac := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
Bsub := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
C := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
Cfac := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
Asub_into_A := VectorSpaceMorphism( Asub, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], A );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
Asub_to_Bfac := VectorSpaceMorphism( Asub, [ [ 1 ], [ 1 ] ], Bfac );
#! A rational vector space homomorphism with matrix: 
#! [ [  1 ],
#!   [  1 ] ]
#! 
B_onto_Bfac := VectorSpaceMorphism( B, [ [ 1 ], [ 1 ], [ 1 ] ], Bfac );
#! A rational vector space homomorphism with matrix: 
#! [ [  1 ],
#!   [  1 ],
#!   [  1 ] ]
#! 
Bsub_into_B := VectorSpaceMorphism( Bsub, [ [ 2, 2, 0 ], [ 0, 2, 2 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  2,  2,  0 ],
#!   [  0,  2,  2 ] ]
#! 
Bsub_to_Cfac := VectorSpaceMorphism( Bsub, [ [ 3 ], [ 0 ] ], Cfac );
#! A rational vector space homomorphism with matrix: 
#! [ [  3 ],
#!   [  0 ] ]
#! 
C_onto_Cfac := VectorSpaceMorphism( C, [ [ 1 ], [ 2 ], [ 3 ] ], Cfac );
#! A rational vector space homomorphism with matrix: 
#! [ [  1 ],
#!   [  2 ],
#!   [  3 ] ]
#! 
generalized_morphism1 := GeneralizedMorphism( Asub_into_A, Asub_to_Bfac, B_onto_Bfac );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
generalized_morphism2 := GeneralizedMorphism( Bsub_into_B, Bsub_to_Cfac, C_onto_Cfac );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
IsWellDefined( generalized_morphism1 );
#! true
IsWellDefined( generalized_morphism2 );
#! true
p := PreCompose( generalized_morphism1, generalized_morphism2 );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
SourceAid( p );
#! A rational vector space homomorphism with matrix: 
#! [ [  -1,   1,   0 ],
#!   [   1,   0,   0 ] ]
#! 
Arrow( p );
#! A rational vector space homomorphism with matrix: 
#! (an empty 2 x 0 matrix)
#! 
RangeAid( p );
#! A rational vector space homomorphism with matrix: 
#! (an empty 3 x 0 matrix)
A := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
Asub := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
B := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
Bfac := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
Bsub := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
C := QVectorSpace( 3 );
#! <A rational vector space of dimension 3>
Cfac := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
Asub_into_A := VectorSpaceMorphism( Asub, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], A );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
Asub_to_Bfac := VectorSpaceMorphism( Asub, [ [ 1 ], [ 1 ] ], Bfac );
#! A rational vector space homomorphism with matrix: 
#! [ [  1 ],
#!   [  1 ] ]
#! 
B_onto_Bfac := VectorSpaceMorphism( B, [ [ 1 ], [ 1 ], [ 1 ] ], Bfac );
#! A rational vector space homomorphism with matrix: 
#! [ [  1 ],
#!   [  1 ],
#!   [  1 ] ]
#! 
Bsub_into_B := VectorSpaceMorphism( Bsub, [ [ 2, 2, 0 ], [ 0, 2, 2 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  2,  2,  0 ],
#!   [  0,  2,  2 ] ]
#! 
Bsub_to_Cfac := VectorSpaceMorphism( Bsub, [ [ 3, 3 ], [ 0, 0 ] ], Cfac );
#! A rational vector space homomorphism with matrix: 
#! [ [  3,  3 ],
#!   [  0,  0 ] ]
#! 
C_onto_Cfac := VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 2 ], [ 3, 3 ] ], Cfac );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  0 ],
#!   [  0,  2 ],
#!   [  3,  3 ] ]
#! 
generalized_morphism1 := GeneralizedMorphism( Asub_into_A, Asub_to_Bfac, B_onto_Bfac );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
generalized_morphism2 := GeneralizedMorphism( Bsub_into_B, Bsub_to_Cfac, C_onto_Cfac );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
IsWellDefined( generalized_morphism1 );
#! true
IsWellDefined( generalized_morphism2 );
#! true
p := PreCompose( generalized_morphism1, generalized_morphism2 );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
SourceAid( p );
#! A rational vector space homomorphism with matrix: 
#! [ [  -1,   1,   0 ],
#!   [   1,   0,   0 ] ]
#! 
Arrow( p );
#! A rational vector space homomorphism with matrix: 
#! [ [  0 ],
#!   [  0 ] ]
#! 
RangeAid( p );
#! A rational vector space homomorphism with matrix: 
#! [ [  -1 ],
#!   [   2 ],
#!   [   0 ] ]
#! @EndExample

#! Honest representative test
#! @Example
vecspaces := CreateCapCategory( "VectorSpacesForGeneralizedMorphismsTest" );
#! VectorSpacesForGeneralizedMorphismsTest
ReadPackage( "CAP", "examples/VectorSpacesAllMethods.g" );
#! true
A := QVectorSpace( 1 );
#! <A rational vector space of dimension 1>
B := QVectorSpace( 2 );
#! <A rational vector space of dimension 2>
phi_tilde_source_aid := VectorSpaceMorphism( A, [ [ 2 ] ], A );
#! A rational vector space homomorphism with matrix: 
#! [ [  2 ] ]
#! 
phi_tilde_associated := VectorSpaceMorphism( A, [ [ 1, 1 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  1 ] ]
#!
phi_tilde_range_aid := VectorSpaceMorphism( B, [ [ 1, 2 ], [ 3, 4 ] ], B );
#! A rational vector space homomorphism with matrix: 
#! [ [  1,  2 ],
#!   [  3,  4 ] ]
#!
phi_tilde := GeneralizedMorphism( phi_tilde_source_aid, phi_tilde_associated, phi_tilde_range_aid );
#! <A morphism in Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
HonestRepresentative( phi_tilde );
#! A rational vector space homomorphism with matrix: 
#! [ [  -1/4,   1/4 ] ]
#!
IsWellDefined( phi_tilde );
#! true
IsWellDefined( psi_tilde );
#! true
#! @EndExample

