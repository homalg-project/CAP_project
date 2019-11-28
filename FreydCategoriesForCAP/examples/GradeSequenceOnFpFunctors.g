#! @Chapter Examples and Tests

## homalg: AbelianSystems/examples/ReducedBasisOfModule.g

LoadPackage( "RingsForHomalg" );
LoadPackage( "FreydCategoriesForCAP" );;

#####################################
#! @Section Grade filtration
#####################################

#! @Example
Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
wmat := HomalgMatrix( "[ \
x*y,  y*z,    z,        0,         0,    \
x^3*z,x^2*z^2,0,        x*z^2,     -z^2, \
x^4,  x^3*z,  0,        x^2*z,     -x*z, \
0,    0,      x*y,      -y^2,      x^2-1,\
0,    0,      x^2*z,    -x*y*z,    y*z,  \
0,    0,      x^2*y-x^2,-x*y^2+x*y,y^2-y \
]", 6, 5, Qxyz );;
RowsR := CategoryOfRows( Qxyz );;
Freyd := FreydCategory( RowsR );;
Adel := AdelmanCategory( RowsR );;
M := wmat/Freyd;;
#! @EndExample

#! We compute the grade sequence of functors (it turns out that on the level of functors, we don't get monos)

#! @Example
M_tor := M/Adel;;
Mu1 := GradeFiltrationNthNaturalTransformationComponent( M_tor, 1 );;
IsZero( Mu1 );
#! false
IsMonomorphism( Mu1 );
#! true
Mu2 := GradeFiltrationNthNaturalTransformationComponent( M_tor, 2 );;
IsZero( Mu2 );
#! false
IsMonomorphism( Mu2 );
#! false
Mu3 := GradeFiltrationNthNaturalTransformationComponent( M_tor, 3 );;
IsZero( Mu3 );
#! false
IsMonomorphism( Mu3 );
#! false
Mu4 := GradeFiltrationNthNaturalTransformationComponent( M_tor, 4 );;
IsZero( Mu4 );
#! true
#! @EndExample

#! We compute the grade sequence of modules (here, we really get monos and thus a filtration)

#! @Example
mu1 := GradeFiltrationNthMonomorphism( M, 1 );;
IsZero( mu1 );
#! false
IsMonomorphism( mu1 );
#! true
mu2 := GradeFiltrationNthMonomorphism( M, 2 );;
IsZero( mu2 );
#! false
IsMonomorphism( mu2 );
#! true
mu3 := GradeFiltrationNthMonomorphism( M, 3 );;
IsZero( mu3 );
#! false
IsMonomorphism( mu3 );
#! true
mu4 := GradeFiltrationNthMonomorphism( M, 4 );;
IsZero( mu4 );
#! true
#! @EndExample
