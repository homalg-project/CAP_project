#! @Chapter Examples and Tests

#! @Section CoFreyd category

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true

ZZZ := HomalgRingOfIntegers( );;
rows := CategoryOfRows( ZZZ );;
co_freyd := CoFreydCategory( rows );
#! CoFreyd( Rows( Z ) )
rows_obj := CategoryOfRowsObject( rows, 1 );; # ZZZ^1
co_freyd_obj := AsCoFreydCategoryObject( rows_obj );; # ZZZ^1 -> 0
rows_mor := CategoryOfRowsMorphism( rows, rows_obj, HomalgMatrix( [ 2 ], 1, 1, ZZZ ), rows_obj );; # ZZZ^1 --2-> ZZZ^1
co_freyd_mor := CoFreydCategoryMorphism( co_freyd_obj, rows_mor, co_freyd_obj );;
IsWellDefined( co_freyd_mor );
#! true
Display( KernelObject( co_freyd_mor ) );
#! 
#! --------------------------------
#! CoRelation morphism:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 1
#! 
#! Matrix: 
#! [ [  2 ] ]
#! 
#! Range: 
#! A row module over Z of rank 1
#! 
#! A morphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#! 
#! An object in CoFreyd( Rows( Z ) )
#! 
Display( UnderlyingMorphism( KernelEmbedding( co_freyd_mor ) ) );
#! Source: 
#! A row module over Z of rank 1
#! 
#! Matrix: 
#! [ [  1 ] ]
#! 
#! Range: 
#! A row module over Z of rank 1
#! 
#! An identity morphism in Rows( Z )
Display( CokernelObject( co_freyd_mor ) );
#! 
#! --------------------------------
#! CoRelation morphism:
#! --------------------------------
#! 
#! Source: 
#! A row module over Z of rank 0
#! 
#! Matrix: 
#! (an empty 0 x 0 matrix)
#! 
#! Range: 
#! A row module over Z of rank 0
#! 
#! A zero, split epi-, split monomorphism in Rows( Z )
#! 
#! 
#! --------------------------------
#! General description:
#! --------------------------------
#! 
#! An object in CoFreyd( Rows( Z ) )
#! 
Display( UnderlyingMorphism( CokernelProjection( co_freyd_mor ) ) );
#! Source: 
#! A row module over Z of rank 1
#! 
#! Matrix: 
#! (an empty 1 x 0 matrix)
#! 
#! Range: 
#! A row module over Z of rank 0
#! 
#! A zero, split epimorphism in Rows( Z )

#! @EndExample
