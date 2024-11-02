#! @Chapter Examples and Tests

#! @Section Monoidal structure of AdditiveClosure

#! @Example
LoadPackage( "FreydCategoriesForCAP", false );
#! true
T := TerminalCategoryWithMultipleObjects( );
#! TerminalCategoryWithMultipleObjects( )
A := "A" / T;
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
B := "B" / T;
#! <A zero object in TerminalCategoryWithMultipleObjects( )>
AT := AdditiveClosure( T );
#! AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )
ABAA := [ A, B, A, A ] / AT;
#! <An object in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by 4 underlying objects>
BAB := [ B, A, B ] / AT;
#! <An object in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by 3 underlying objects>
AB := [ A, B ] / AT;
#! <An object in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by 2 underlying objects>
mor_AB := MorphismConstructor( A, "A -> B", B );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
mor_BA := MorphismConstructor( B, "B -> A", A );
#! <A zero, isomorphism in TerminalCategoryWithMultipleObjects( )>
id_A := IdentityMorphism( A );
#! <A zero, identity morphism in TerminalCategoryWithMultipleObjects( )>
id_B := IdentityMorphism( B );
#! <A zero, identity morphism in TerminalCategoryWithMultipleObjects( )>
alpha := MorphismConstructor( ABAA,
  [ [ mor_AB, id_A, mor_AB ],
    [ id_B, mor_BA, id_B ],
    [ mor_AB, id_A, mor_AB ],
    [ mor_AB, id_A, mor_AB ] ],
    BAB );
#! <A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by a 4 x 3 matrix of underlying morphisms>
IsWellDefined( alpha );
#! true
alpha2 := TensorProduct( alpha, alpha );
#! <A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by a 16 x 9 matrix of underlying morphisms>
IsWellDefined( alpha2 );
#! true
IsIsomorphism( alpha2 );
#! true
left := LeftUnitor( ABAA );
#! <A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by a 4 x 4 matrix of underlying morphisms>
IsWellDefined( left );
#! true
left_inv := LeftUnitorInverse( ABAA );
#! <A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by a 4 x 4 matrix of underlying morphisms>
PreCompose( left, left_inv ) = IdentityMorphism( Source( left ) );
#! true
PreCompose( left_inv, left ) = IdentityMorphism( Range( left ) );
#! true
right := RightUnitor( BAB );
#! <A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by a 3 x 3 matrix of underlying morphisms>
IsWellDefined( right );
#! true
right_inv := RightUnitorInverse( BAB );
#! <A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by a 3 x 3 matrix of underlying morphisms>
PreCompose( right, right_inv ) = IdentityMorphism( Source( right ) );
#! true
PreCompose( right_inv, right ) = IdentityMorphism( Range( right ) );
#! true
aslr := AssociatorLeftToRight( AB, BAB, AB );
#! <A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by a 12 x 12 matrix of underlying morphisms>
IsWellDefined( aslr );
#! true
asrl := AssociatorRightToLeft( AB, BAB, AB );
#! <A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )\
#!  defined by a 12 x 12 matrix of underlying morphisms>
PreCompose( aslr, asrl ) = IdentityMorphism( Source( aslr ) );
#! true
PreCompose( asrl, aslr ) = IdentityMorphism( Range( aslr ) );
#! true
#! @EndExample

