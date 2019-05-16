#! @Chunk Quickstart_RepD8

LoadPackage( "GroupRepresentationsForCAP" );

#! @Example
RepG := RepresentationCategory( 8, 3 );
#! The representation category of Group( [ f1, f2, f3 ] )
G := UnderlyingGroupForRepresentationCategory( RepG );
#! <pc group of size 8 with 3 generators>
StructureDescription( G );
#! "D8"
c := First( Irr( G ), i -> Degree( i ) = 2 );
#! Character( CharacterTable( D8 ), [ 2, 0, 0, -2, 0 ] )
v := RepresentationCategoryObject( c, RepG );
#! 1*(x_5)
Dimension( v );
#! 2
Display( AssociatorLeftToRight( v, v, v ) );
#! Component: (x_5)
#! 
#! 1/2,-1/2,1/2, 1/2, 
#! 1/2,-1/2,-1/2,-1/2,
#! 1/2,1/2, 1/2, -1/2,
#! 1/2,1/2, -1/2,1/2  
#! 
#! A morphism in Category of matrices over Q
#! ------------------------
Display( Braiding( v, v ) );
#! Component: (x_1)
#! 
#! 1
#! 
#! A morphism in Category of matrices over Q
#! ------------------------
#! Component: (x_2)
#! 
#! 1
#! 
#! A morphism in Category of matrices over Q
#! ------------------------
#! Component: (x_3)
#! 
#! 1
#! 
#! A morphism in Category of matrices over Q
#! ------------------------
#! Component: (x_4)
#! 
#! -1
#! 
#! A morphism in Category of matrices over Q
#! ------------------------
alpha := IdentityMorphism( TensorProductOnObjects( v, v ) ) + Braiding( v, v );
#! <A morphism in The representation category of Group( [ f1, f2, f3 ] )>
CokernelObject( alpha );
#! 1*(x_4)
TensorUnit( RepG );
#! 1*(x_1)
#! @EndExample