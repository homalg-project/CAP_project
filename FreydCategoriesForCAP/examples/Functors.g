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
IsZeroForMorphisms( mor );
#! false
emb := EmbeddingFunctorIntoFreydCategory( RowsR );;
ind := AdelmanCategoryFunctorInducedByUniversalProperty( emb );;
IsZeroForMorphisms( ApplyFunctor( ind, mor ) );
#! true
M := FreydCategoryObject( AsCategoryOfRowsMorphism( HomalgMatrix( [ [  2, 2, 2 ], [ 4, 4, 6 ] ], 2, 3, R ), RowsR ) );;
as_tensor := EmbeddingFunctorOfFreydCategoryIntoAdelmanCategory( RowsR );;
Mt := ApplyFunctor( as_tensor, M );;
lsat := LeftSatelliteAsEndofunctorOfAdelmanCategory( RowsR );;
rsat := RightSatelliteAsEndofunctorOfAdelmanCategory( RowsR );;
torsion := ApplyFunctor( ind, ( ApplyFunctor( rsat, ApplyFunctor( lsat, Mt ) ) ) );;
unit := UnitOfSatelliteAdjunctionOfAdelmanCategory( RowsR );;
IsZeroForMorphisms( ApplyNaturalTransformation( unit, Mt ) );
#! true
counit := CounitOfSatelliteAdjunctionOfAdelmanCategory( RowsR );;
t := ApplyNaturalTransformation( counit, Mt );;
#! @EndExample
