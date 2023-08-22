#! @Chapter Examples and Tests

#! @Section Generalized Morphisms Category

LoadPackage( "GeneralizedMorphismsForCAP", false );
LoadPackage( "LinearAlgebraForCAP" );

#! @Example
Q := HomalgFieldOfRationals();
#! Q
B := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
C := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
B_1 := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
C_1 := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
c1_source_aid := VectorSpaceMorphism( B_1, [ [ 1, 0 ] ], B );
#! <A morphism in Category of matrices over Q>
SetIsSubobject( c1_source_aid, true );
c1_range_aid := VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 1 ], [ 0, 0 ] ], C_1 );
#! <A morphism in Category of matrices over Q>
SetIsFactorobject( c1_range_aid, true );
c1_associated := VectorSpaceMorphism( B_1, [ [ 1, 1 ] ], C_1 );
#! <A morphism in Category of matrices over Q>
c1 := GeneralizedMorphism( c1_source_aid, c1_associated, c1_range_aid );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
B_2 := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
C_2 := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
c2_source_aid := VectorSpaceMorphism( B_2, [ [ 2, 0 ] ], B );
#! <A morphism in Category of matrices over Q>
SetIsSubobject( c2_source_aid, true );
c2_range_aid := VectorSpaceMorphism( C, [ [ 3, 0 ], [ 0, 3 ], [ 0, 0 ] ], C_2 );
#! <A morphism in Category of matrices over Q>
SetIsFactorobject( c2_range_aid, true );
c2_associated := VectorSpaceMorphism( B_2, [ [ 6, 6 ] ], C_2 );
#! <A morphism in Category of matrices over Q>
c2 := GeneralizedMorphism( c2_source_aid, c2_associated, c2_range_aid );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
IsCongruentForMorphisms( c1, c2 );
#! true
IsCongruentForMorphisms( c1, c1 );
#! true
c3_associated := VectorSpaceMorphism( B_1, [ [ 2, 2 ] ], C_1 );
#! <A morphism in Category of matrices over Q>
c3 := GeneralizedMorphism( c1_source_aid, c3_associated, c1_range_aid );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
IsCongruentForMorphisms( c1, c3 );
#! false
IsCongruentForMorphisms( c2, c3 );
#! false
c1 + c2;
#! <A morphism in Generalized morphism category of Category of matrices over Q>
Arrow( c1 + c2 );
#! <A morphism in Category of matrices over Q>
#! @EndExample

#! First composition test:

#! @Example
Q := HomalgFieldOfRationals();
#! Q
A := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
B := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
C := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
phi_tilde_associated := VectorSpaceMorphism( A, [ [ 1, 2, 0 ] ], C );
#! <A morphism in Category of matrices over Q>
phi_tilde_source_aid := VectorSpaceMorphism( A, [ [ 1, 2 ] ], B );
#! <A morphism in Category of matrices over Q>
phi_tilde := GeneralizedMorphismWithSourceAid( phi_tilde_source_aid, phi_tilde_associated );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
psi_tilde_associated := IdentityMorphism( B );
#! <An identity morphism in Category of matrices over Q>
psi_tilde_source_aid := VectorSpaceMorphism( B, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], C );
#! <A morphism in Category of matrices over Q>
psi_tilde := GeneralizedMorphismWithSourceAid( psi_tilde_source_aid, psi_tilde_associated );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
composition := PreCompose( phi_tilde, psi_tilde );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
Arrow( composition );
#! <A morphism in Category of matrices over Q>
SourceAid( composition );
#! <A morphism in Category of matrices over Q>
RangeAid( composition );
#! <An identity morphism in Category of matrices over Q>
#! @EndExample

#! Second composition test

#! @Example
Q := HomalgFieldOfRationals();
#! Q
A := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
B := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
C := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
phi2_tilde_associated := VectorSpaceMorphism( A, [ [ 1, 5 ] ], B );
#! <A morphism in Category of matrices over Q>
phi2_tilde_range_aid := VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], B );
#! <A morphism in Category of matrices over Q>
phi2_tilde := GeneralizedMorphismWithRangeAid( phi2_tilde_associated, phi2_tilde_range_aid );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
psi2_tilde_associated := VectorSpaceMorphism( C, [ [ 1 ], [ 3 ], [ 4 ] ], A );
#! <A morphism in Category of matrices over Q>
psi2_tilde_range_aid := VectorSpaceMorphism( B, [ [ 1 ], [ 1 ] ], A );
#! <A morphism in Category of matrices over Q>
psi2_tilde := GeneralizedMorphismWithRangeAid( psi2_tilde_associated, psi2_tilde_range_aid );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
composition2 := PreCompose( phi2_tilde, psi2_tilde );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
Arrow( composition2 );
#! <A morphism in Category of matrices over Q>
RangeAid( composition2 );
#! <A morphism in Category of matrices over Q>
SourceAid( composition2 );
#! <An identity morphism in Category of matrices over Q>
#! @EndExample

#! Third composition test

#! @Example
Q := HomalgFieldOfRationals();
#! Q
A := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
Asub := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
B := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
Bfac := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
Bsub := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
C := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
Cfac := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
Asub_into_A := VectorSpaceMorphism( Asub, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], A );
#! <A morphism in Category of matrices over Q>
Asub_to_Bfac := VectorSpaceMorphism( Asub, [ [ 1 ], [ 1 ] ], Bfac );
#! <A morphism in Category of matrices over Q>
B_onto_Bfac := VectorSpaceMorphism( B, [ [ 1 ], [ 1 ], [ 1 ] ], Bfac );
#! <A morphism in Category of matrices over Q>
Bsub_into_B := VectorSpaceMorphism( Bsub, [ [ 2, 2, 0 ], [ 0, 2, 2 ] ], B );
#! <A morphism in Category of matrices over Q>
Bsub_to_Cfac := VectorSpaceMorphism( Bsub, [ [ 3 ], [ 0 ] ], Cfac );
#! <A morphism in Category of matrices over Q>
C_onto_Cfac := VectorSpaceMorphism( C, [ [ 1 ], [ 2 ], [ 3 ] ], Cfac );
#! <A morphism in Category of matrices over Q>
generalized_morphism1 := GeneralizedMorphism( Asub_into_A, Asub_to_Bfac, B_onto_Bfac );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
generalized_morphism2 := GeneralizedMorphism( Bsub_into_B, Bsub_to_Cfac, C_onto_Cfac );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
IsWellDefined( generalized_morphism1 );
#! true
IsWellDefined( generalized_morphism2 );
#! true
p := PreCompose( generalized_morphism1, generalized_morphism2 );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
SourceAid( p );
#! <A morphism in Category of matrices over Q>
Arrow( p );
#! <A morphism in Category of matrices over Q>
RangeAid( p );
#! <A morphism in Category of matrices over Q>
A := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
Asub := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
B := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
Bfac := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
Bsub := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
C := VectorSpaceObject( 3, Q );
#! <A vector space object over Q of dimension 3>
Cfac := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
Bsub_to_Cfac := VectorSpaceMorphism( Bsub, [ [ 3, 3 ], [ 0, 0 ] ], Cfac );
#! <A morphism in Category of matrices over Q>
C_onto_Cfac := VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 2 ], [ 3, 3 ] ], Cfac );
#! <A morphism in Category of matrices over Q>
generalized_morphism1 := GeneralizedMorphism( Asub_into_A, Asub_to_Bfac, B_onto_Bfac );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
generalized_morphism2 := GeneralizedMorphism( Bsub_into_B, Bsub_to_Cfac, C_onto_Cfac );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
IsWellDefined( generalized_morphism1 );
#! true
IsWellDefined( generalized_morphism2 );
#! true
p := PreCompose( generalized_morphism1, generalized_morphism2 );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
SourceAid( p );
#! <A morphism in Category of matrices over Q>
Arrow( p );
#! <A morphism in Category of matrices over Q>
RangeAid( p );
#! <A morphism in Category of matrices over Q>
#! @EndExample

#! Honest representative test
#! @Example
Q := HomalgFieldOfRationals();
#! Q
A := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
B := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
phi_tilde_source_aid := VectorSpaceMorphism( A, [ [ 2 ] ], A );
#! <A morphism in Category of matrices over Q>
phi_tilde_associated := VectorSpaceMorphism( A, [ [ 1, 1 ] ], B );
#! <A morphism in Category of matrices over Q>
phi_tilde_range_aid := VectorSpaceMorphism( B, [ [ 1, 2 ], [ 3, 4 ] ], B );
#! <A morphism in Category of matrices over Q>
phi_tilde := GeneralizedMorphism( phi_tilde_source_aid, phi_tilde_associated, phi_tilde_range_aid );
#! <A morphism in Generalized morphism category of Category of matrices over Q>
HonestRepresentative( phi_tilde );
#! <A morphism in Category of matrices over Q>
IsWellDefined( phi_tilde );
#! true
IsWellDefined( psi_tilde );
#! true
#! @EndExample

