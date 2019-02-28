LoadPackage( "GradedModulePresentations" );

# If the ring has indeterminates and the degrees of these indeterminates 
# are contained in {0,1} or {0,-1} then the random methods are installed
# without need of any other package.
# For other cases we need the package NConvex or ( Convex and PolymakeInterface ).

S1 := GradedRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );
SetWeightsOfIndeterminates( S1, [ 1, 0, 1 ] );
cat1 := GradedLeftPresentations( S1 );
CanCompute( cat1, "RandomObject" );
# true

S2 := GradedRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );
SetWeightsOfIndeterminates( S2, [ 1, 0, -1 ] );
cat2 := GradedLeftPresentations( S2 );
CanCompute( cat2, "RandomObject" );
# false

S3 := GradedRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );
SetWeightsOfIndeterminates( S3, [ [1,2], [0,-4], [-1,8 ] ] );
cat3 := GradedLeftPresentations( S3 );
CanCompute( cat3, "RandomObject" );
# false

##
LoadPackage( "NConvex" );

S4 := GradedRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );
SetWeightsOfIndeterminates( S4, [ 1, 0, -1 ] );
cat4 := GradedLeftPresentations( S4 );
CanCompute( cat4, "RandomObject" );
# true if NConvex or (Convex && PolymakeInterface) are loaded

S5 := GradedRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );
SetWeightsOfIndeterminates( S5, [ [1,2], [0,-4], [-1,8 ] ] );
cat5 := GradedLeftPresentations( S5 );
CanCompute( cat5, "RandomObject" );
# true if NConvex or (Convex && PolymakeInterface) are loaded

M := RandomObject( cat1, 4 );
f := RandomMorphismWithFixedSource( M, 5 );
g := RandomMorphismWithFixedRange( M, 4 );
IsWellDefined( M );
IsWellDefined( f );
IsWellDefined( g );

M := 0; f := 0; g := 0;

test := function( cat, N, max )
  local i;

  for i in [ 1 .. N ] do
    
    Display( i );

    M := RandomObject( cat, Random( [ 0 .. max ] ) );

    f := RandomMorphismWithFixedSource( M, Random( [ 0 .. max ] ) );

    g := RandomMorphismWithFixedRange( M, Random( [ 0 .. max ] ) );

    if not IsWellDefined( f ) then

      Error( "f" );

    else

      Display( "Ok" );
      #Display( f );

    fi;
    
    if not IsWellDefined( g ) then

      Error( "g" );

    else

      Display( "Ok" );
      #Display( g );

    fi;

  od;

end;

test( cat1, 10, 5 );
