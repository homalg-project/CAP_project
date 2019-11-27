#! @Chapter Examples and Tests

#! @Section Adelman category basics

LoadPackage( "FreydCategoriesForCAP" );;

#! @Example
R := HomalgRingOfIntegers();;
RowsR := CategoryOfRows( R );;
one := AsCategoryOfRowsMorphism( HomalgMatrix( [ [ 1 ] ], 1, 1, R ), RowsR );;
two := AsCategoryOfRowsMorphism( HomalgMatrix( [ [ 2 ] ], 1, 1, R ), RowsR );;
four := AsCategoryOfRowsMorphism( HomalgMatrix( [ [ 4 ] ], 1, 1, R ), RowsR );;
source := AdelmanCategoryObject( two, two );;
range := AdelmanCategoryObject( two, four );;
mor := AdelmanCategoryMorphism( source, one, range );;
IsZero( mor );
#! false
emb := EmbeddingFunctorIntoFreydCategory( RowsR );;
ind := AdelmanCategoryFunctorInducedByUniversalProperty( emb );;
IsZero( ApplyFunctor( ind, mor ) );
#! true
M := FreydCategoryObject( four );;
as_tensor := EmbeddingFunctorOfFreydCategoryIntoAdelmanCategory( RowsR );;
ApplyFunctor( as_tensor, M );;
#! @EndExample