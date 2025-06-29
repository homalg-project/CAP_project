#! @Chapter Example on category of rows

LoadPackage( "RingsForHomalg" );
LoadPackage( "FreydCategoriesForCAP" );;

#####################################
#! @Section Simplifications
#####################################

#! @Example
Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
A3 := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );;
M1 := HomalgMatrix( "[ \
Dx  \
]", 1, 1, A3 );;
M2 := HomalgMatrix( "[ \
Dx, \
Dy  \
]", 2, 1, A3 );;
M3 := HomalgMatrix( "[ \
Dx, \
Dy, \
Dz  \
]", 3, 1, A3 );;
M := DiagMat( [ M1, M2, M3 ] );;
M := ShallowCopy( M );;
SetIsMutableMatrix( M, true );;
M[ 1, 2 ] := "1";;
M[ 2, 3 ] := "1";;
M[ 3, 3 ] := "1";;
MakeImmutable( M );;
tau1 := HomalgMatrix( "[ \
1, Dx, Dz, \
0,  0,  1, \
0,  1, Dy  \
]", 3, 3, A3 );;
tau2 := HomalgMatrix( "[ \
0,  1, Dz+x*y, \
0,  0,      1, \
1, Dz,    x-y  \
]", 3, 3, A3 );;
tau3 := HomalgMatrix( "[ \
1,  0, 0, \
1,  1, 0, \
0, -1, 1  \
]", 3, 3, A3 );;
tau := tau1 * tau2 * tau3;;
M := M * tau;;
rows := CategoryOfRows( A3 );;
alpha := AsCategoryOfRowsMorphism( M, rows );;
Mrows := FreydCategoryObject( alpha );;
Srows := SimplifyObject( Mrows, infinity );;
RankOfObject( Source( RelationMorphism( Srows ) ) );
#! 4
RankOfObject( Range( RelationMorphism( Srows ) ) );
#! 2
IsIsomorphism( SimplifyObject_IsoFromInputObject( Mrows, infinity ) );
#! true
IsIsomorphism( SimplifyObject_IsoToInputObject( Mrows, infinity ) );
#! true
#! @EndExample

#! Computing the grade filtration:
#! @Example
mu1 := GradeFiltrationNthMonomorphism( Mrows, 1 );;
IsZero( mu1 );
#! false
IsMonomorphism( mu1 );
#! true
mu2 := GradeFiltrationNthMonomorphism( Mrows, 2 );;
IsZero( mu2 );
#! false
IsMonomorphism( mu2 );
#! true
mu3 := GradeFiltrationNthMonomorphism( Mrows, 3 );;
IsZero( mu3 );
#! false
IsMonomorphism( mu3 );
#! true
mu4 := GradeFiltrationNthMonomorphism( Mrows, 4 );;
IsZero( mu4 );
#! true
#! @EndExample

#! @Example
cols := CategoryOfColumns( A3 );;
alpha := AsCategoryOfColumnsMorphism( M, cols );;
Mcols := FreydCategoryObject( alpha );;
Scols := SimplifyObject( Mcols, infinity );;
RankOfObject( Source( RelationMorphism( Scols ) ) );
#! 1
RankOfObject( Range( RelationMorphism( Scols ) ) );
#! 4
IsIsomorphism( SimplifyObject_IsoFromInputObject( Mcols, infinity ) );
#! true
IsIsomorphism( SimplifyObject_IsoToInputObject( Mcols, infinity ) );
#! true
#! @EndExample
