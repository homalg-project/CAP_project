#! @Chapter Examples and Tests

#! @Section Monoidal Categories

LoadPackage( "ModulePresentationsForCAP" );

#! @Example
ZZ := HomalgRingOfIntegers();;
Ml := AsLeftPresentation( HomalgMatrix( [ [ 2 ] ], 1, 1, ZZ ) );
#! <An object in Category of left presentations of Z>
Nl := AsLeftPresentation( HomalgMatrix( [ [ 3 ] ], 1, 1, ZZ ) );
#! <An object in Category of left presentations of Z>
Tl := TensorProductOnObjects( Ml, Nl );
#! <An object in Category of left presentations of Z>
Display( UnderlyingMatrix( Tl ) );
#! [ [  2 ],
#!   [  3 ] ]
IsZeroForObjects( Tl );
#! true
Bl := Braiding( DirectSum( Ml, Nl ), DirectSum( Ml, Ml ) );
#! <A morphism in Category of left presentations of Z>
Display( UnderlyingMatrix( Bl ) );
#! [ [  1,  0,  0,  0 ],
#!   [  0,  0,  1,  0 ],
#!   [  0,  1,  0,  0 ],
#!   [  0,  0,  0,  1 ] ]
IsWellDefined( Bl );
#! true
Ul := TensorUnit( CapCategory( Ml ) );
#! <An object in Category of left presentations of Z>
IntHoml := InternalHomOnObjects( DirectSum( Ml, Ul ), Nl );
#! <An object in Category of left presentations of Z>
Display( UnderlyingMatrix( IntHoml ) );
#! [ [  1,  2 ],
#!   [  0,  3 ] ]
generator_l1 := StandardGeneratorMorphism( IntHoml, 1 );
#! <A morphism in Category of left presentations of Z>
morphism_l1 := LambdaElimination( DirectSum( Ml, Ul ), Nl, generator_l1 );
#! <A morphism in Category of left presentations of Z>
Display( UnderlyingMatrix( morphism_l1 ) );
#! [ [   -84 ],
#!   [  -196 ] ]
generator_l2 := StandardGeneratorMorphism( IntHoml, 2 );
#! <A morphism in Category of left presentations of Z>
morphism_l2 := LambdaElimination( DirectSum( Ml, Ul ), Nl, generator_l2 );
#! <A morphism in Category of left presentations of Z>
Display( UnderlyingMatrix( morphism_l2 ) );
#! [ [  -39 ],
#!   [  -91 ] ]
IsEqualForMorphisms( LambdaIntroduction( morphism_l1 ), generator_l1 );
#! false
IsCongruentForMorphisms( LambdaIntroduction( morphism_l1 ), generator_l1 );
#! true
IsEqualForMorphisms( LambdaIntroduction( morphism_l2 ), generator_l2 );
#! false
IsCongruentForMorphisms( LambdaIntroduction( morphism_l2 ), generator_l2 );
#! true
Mr := AsRightPresentation( HomalgMatrix( [ [ 2 ] ], 1, 1, ZZ ) );
#! <An object in Category of right presentations of Z>
Nr := AsRightPresentation( HomalgMatrix( [ [ 3 ] ], 1, 1, ZZ ) );
#! <An object in Category of right presentations of Z>
Tr := TensorProductOnObjects( Mr, Nr );
#! <An object in Category of right presentations of Z>
Display( UnderlyingMatrix( Tr ) );
#! [ [  2,  3 ] ]
IsZeroForObjects( Tr );
#! true
Br := Braiding( DirectSum( Mr, Nr ), DirectSum( Mr, Mr ) );
#! <A morphism in Category of right presentations of Z>
Display( UnderlyingMatrix( Br ) );
#! [ [  1,  0,  0,  0 ],
#!   [  0,  0,  1,  0 ],
#!   [  0,  1,  0,  0 ],
#!   [  0,  0,  0,  1 ] ]
IsWellDefined( Br );
#! true
Ur := TensorUnit( CapCategory( Mr ) );
#! <An object in Category of right presentations of Z>
IntHomr := InternalHomOnObjects( DirectSum( Mr, Ur ), Nr );
#! <An object in Category of right presentations of Z>
Display( UnderlyingMatrix( IntHomr ) );
#! [ [  1,  0 ],
#!   [  2,  3 ] ]
generator_r1 := StandardGeneratorMorphism( IntHomr, 1 );
#! <A morphism in Category of right presentations of Z>
morphism_r1 := LambdaElimination( DirectSum( Mr, Ur ), Nr, generator_r1 );
#! <A morphism in Category of right presentations of Z>
Display( UnderlyingMatrix( morphism_r1 ) );
#! [ [   -84,  -196 ] ]
generator_r2 := StandardGeneratorMorphism( IntHoml, 2 );
#! <A morphism in Category of left presentations of Z>
morphism_r2 := LambdaElimination( DirectSum( Ml, Ul ), Nl, generator_r2 );
#! <A morphism in Category of left presentations of Z>
Display( UnderlyingMatrix( morphism_r2 ) );
#! [ [  -39 ],
#!   [  -91 ] ]
IsEqualForMorphisms( LambdaIntroduction( morphism_r1 ), generator_r1 );
#! false
IsCongruentForMorphisms( LambdaIntroduction( morphism_r1 ), generator_r1 );
#! true
IsEqualForMorphisms( LambdaIntroduction( morphism_r2 ), generator_r2 );
#! false
IsCongruentForMorphisms( LambdaIntroduction( morphism_r2 ), generator_r2 );
#! true
#! @EndExample
