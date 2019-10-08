#! @Chapter Example on tensor products in Freyd categories

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "RingsForHomalg" );

#####################################
#! @Section Tensor products for categories of rows
#####################################

#! @Example
R := HomalgFieldOfRationalsInSingular() * "a,b,c,d,e,f,g,h,i,j";;
C := CategoryOfRows( R );;
T := TensorUnit( C );;
IsWellDefined( T );
#! true
#! @EndExample

#! We test the naturality of the braiding.

#! @Example
R2 := DirectSum( T, T );;
R3 := DirectSum( T, R2 );;
R4 := DirectSum( R2, R2 );;
alpha := CategoryOfRowsMorphism( T, HomalgMatrix( "[ a, b, c, d ]", 1, 4, R ), R4 );;
beta := CategoryOfRowsMorphism( R2, HomalgMatrix( "[ e, f, g, h, i, j ]", 2, 3, R ), R3 );;
IsCongruentForMorphisms(
    PreCompose( Braiding( T, R2 ), TensorProductOnMorphisms( beta, alpha ) ),
    PreCompose( TensorProductOnMorphisms( alpha, beta ), Braiding( R4, R3 ) )
);
#! true
#! @EndExample

#! We compute the torsion part of a f.p. module with the help of the induced tensor structure
#! on the Freyd category.

#! @Example
M := FreydCategoryObject( alpha );;
mu := MorphismToBidual( M );;
co := CoastrictionToImage( mu );;
IsIsomorphism( co );
#! true
#! @EndExample

#####################################
#! @Section Tensor products for categories of columns
#####################################

#! @Example
R := HomalgFieldOfRationalsInSingular() * "a,b,c,d,e,f,g,h,i,j";;
C := CategoryOfColumns( R );;
T := TensorUnit( C );;
IsWellDefined( T );
#! true
#! @EndExample

#! We test the naturality of the braiding.

#! @Example
R2 := DirectSum( T, T );;
R3 := DirectSum( T, R2 );;
R4 := DirectSum( R2, R2 );;
alpha := CategoryOfColumnsMorphism( T, HomalgMatrix( "[ a, b, c, d ]", 4, 1, R ), R4 );;
beta := CategoryOfColumnsMorphism( R2, HomalgMatrix( "[ e, f, g, h, i, j ]", 3, 2, R ), R3 );;
IsCongruentForMorphisms(
    PreCompose( Braiding( T, R2 ), TensorProductOnMorphisms( beta, alpha ) ),
    PreCompose( TensorProductOnMorphisms( alpha, beta ), Braiding( R4, R3 ) )
);
#! true
#! @EndExample

#! We compute the torsion part of a f.p. module with the help of the induced tensor structure
#! on the Freyd category.

#! @Example
M := FreydCategoryObject( alpha );;
mu := MorphismToBidual( M );;
co := CoastrictionToImage( mu );;
IsIsomorphism( co );
#! true
#! @EndExample
