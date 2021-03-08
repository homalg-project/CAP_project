if not IsBound( VectorSpacesConstructorsLoaded ) then

  ReadPackage( "CAP", "examples/VectorSpacesConstructors.g" );;

fi;
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
Asub_into_A := InDeductiveSystem( Asub_into_A );
Asub_to_Bfac := InDeductiveSystem( Asub_to_Bfac );
B_onto_Bfac := InDeductiveSystem( B_onto_Bfac );
Bsub_into_B := InDeductiveSystem( Bsub_into_B );
Bsub_to_Cfac := InDeductiveSystem( Bsub_to_Cfac );
C_onto_Cfac := InDeductiveSystem( C_onto_Cfac );
SetIsAbelianCategory( CapCategory( C_onto_Cfac ), true );
generalized_morphism1 := GeneralizedMorphism( Asub_into_A, Asub_to_Bfac, B_onto_Bfac );
#! <A morphism in the category Generalized morphism category of VectorSpacesForGeneralizedMorphismsTest>
generalized_morphism2 := GeneralizedMorphism( Bsub_into_B, Bsub_to_Cfac, C_onto_Cfac );
generalized_morphism1 := InDeductiveSystem( generalized_morphism1 );
generalized_morphism2 := InDeductiveSystem( generalized_morphism2 );
p := PreCompose( generalized_morphism1, generalized_morphism2 );


