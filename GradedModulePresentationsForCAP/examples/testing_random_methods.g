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


# Let us constructe some objects and morphisms in cat1

# The output of RandomObject( cat1, n ) is a graded left presentation whose matrix has at most n rows and n cols. If n < 0 then the output is fail.
M := RandomObject( cat1, 4 );

# The output of RandomMorphismWithFixedSource( M, n ) is a graded presentation morphism whose source is M and range has n relations. If n < 0 then the output is fail.
f := RandomMorphismWithFixedSource( M, 5 );

# The output of RandomMorphismWithFixedRange( M, n ) is a graded presentation morphism whose range is M and source has n generators. If n < 0 then the output is fail.
g := RandomMorphismWithFixedRange( M, 8 );

IsWellDefined( M );
IsWellDefined( f );
IsWellDefined( g );

# random methods for a homalg ring

S := GradedRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );;
SetWeightsOfIndeterminates( S, [ 1, 1, 1 ] );;


TRY_TO_ENHANCE_HOMALG_GRADED_RING_WITH_RANDOM_FUNCTIONS( S );
# true

####################################################
# (1)
# To return an element of degree d
# we use S!.random_homogeneous_element_func( d );
e := S!.random_homogeneous_element_func( 3 );

####################################################
# (2)
# To return an mxn-matrix of a morphism between two free left presentations: S(-a_1)+S(-a_2)+S(-a_3)+...+S(-a_m) ----> S(-b_1)+S(-b_2)+...+S(-b_n)
# we use S!.random_matrix_between_free_left_presentations_func( [ a_1, a_2, a_3, ..., a_m ], [ b_1, b_2, ..., b_n ] );
# See: ?RandomMatrixBetweenGradedFreeLeftModules
mat := S!.random_matrix_between_free_left_presentations_func( [ 3 ], [ 1, -2 ] );
# <A 1 x 2 matrix over a graded ring>
M := AsGradedLeftPresentation( mat, [ 1, -2 ] );
# <An object in The category of graded left f.p. modules over Q[x,y] (with weights [ 1, 1 ])>
IsWellDefined( M );
#true

###################################################
# (3)
# To return a mxn-matrix of a morphism between two free left presentations of rank m and n
# we use S!.random_matrix_for_left_presentation_func( m, n );
mat := S!.random_matrix_for_left_presentation_func( 2, 4 );
# [ <A 2 x 4 matrix over a graded ring>, [ -1, 1 ], [ 1, 2, 2, -1 ] ]
M := AsGradedLeftPresentation( mat[ 1 ], mat[ 3 ] );
# <An object in The category of graded left f.p. modules over Q[x,y] (with weights [ 1, 1 ])>
IsWellDefined( M );
# true

##################################################
# (4)
# To recover relations degrees of a left presentation M with underlying matrix mat and generators degrees gen_degs
# we use S!.detect_relations_degrees_func( mat, gen_degs, "left" );
S!.detect_relations_degrees_func( mat[ 1 ], mat[ 3 ], "left" );
# [ -1, 1 ]

##################################################
# (5)
# To recover generators degrees of a left presentation M with underlying matrix mat and relations degrees rel_degs
# we use S!.detect_generators_degrees_func( mat, rel_degs, "left" );
d := S!.detect_generators_degrees_func( mat[ 1 ], mat[ 2 ], "left" );
# [ 1, 0, 0, -1 ]
IsWellDefined( AsGradedLeftPresentation( mat[ 1 ], d ) );
# true
# As we notice the generators degrees or relations degrees are not uniquly determined.

####################################################
# (6)
# To return an nxm-matrix of a morphism between two free right presentations: S(-a_1)+S(-a_2)+S(-a_3)+...+S(-a_m) ----> S(-b_1)+S(-b_2)+...+S(-b_n)
# we use S!.random_matrix_between_free_right_presentations_func( [ b_1, b_2, ..., b_n ], [ a_1, a_2, a_3, ..., a_m ] );
# See: ?RandomMatrixBetweenGradedFreeRightModules
mat := S!.random_matrix_between_free_right_presentations_func( [ 3 ], [ 1, -2 ] );
# <A 1 x 2 matrix over a graded ring>
M := AsGradedRightPresentation( mat, [ 3 ] );
# <An object in The category of graded right f.p. modules over Q[x,y] (with weights [ 1, 1 ])>
IsWellDefined( M );
#true

###################################################
# (7)
# To return a nxm-matrix of a morphism between two free left presentations of rank m and n
# we use S!.random_matrix_for_right_presentation_func( n, m );
mat := S!.random_matrix_for_right_presentation_func( 2, 4 );
# [ <A 2 x 4 matrix over a graded ring>, [ 2, 2 ], [ 2, 0, -1, -1 ] ]
M := AsGradedRightPresentation( mat[ 1 ], mat[ 2 ] );
# <An object in The category of graded right f.p. modules over Q[x,y] (with weights [ 1, 1 ])>
IsWellDefined( M );
# true

##################################################
# (8)
# To recover relations degrees of a right presentation M with underlying matrix mat and generators degrees gen_degs
# we use S!.detect_relations_degrees_func( mat, gen_degs, "right" );
S!.detect_relations_degrees_func( mat[ 1 ], mat[ 2 ], "right" );
# [ 2, 0, 0, 0 ]
# As we notice the generators degrees or relations degrees are not uniquly determined.

##################################################
# (9)
# To recover generators degrees of a right presentation M with underlying matrix mat and relations degrees rel_degs
# we use S!.detect_generators_degrees_func( mat, rel_degs, "left" );
d := S!.detect_generators_degrees_func( mat[ 1 ], mat[ 3 ], "right" );
# [ 2, 2 ]
IsWellDefined( AsGradedRightPresentation( mat[ 1 ], d ) );
# true
# As we notice the generators degrees or relations degrees are not uniquly determined.

#################################################
# (10)
#
Degree( Zero( S ) );
# -1
S!.auxiliary_degree_func( Zero( S ) );
# fail
Degree( "x*y^4"/S );
# 5
S!.auxiliary_degree_func( "x*y^4"/S );
# 5


M := 0; f := 0; g := 0;

test_random_objects_and_morphisms :=

  function( cat, N, max )
    local i;
  
    for i in [ 1 .. N ] do
      
      Display( i );
      Display( "############################" );
  
      M := RandomObject( cat, Random( [ 0 .. max ] ) );
      
      if not IsWellDefined( M ) then
  
        Error( "M is not well-defined" );
  
      else
  
        #Display( "Ok" );
        Display( M );
  
      fi;
  
      f := RandomMorphismWithFixedSource( M, Random( [ 0 .. max ] ) );
  
      if not IsWellDefined( f ) then
  
        Error( "f is not well-defined" );
  
      else
  
        #Display( "Ok" );
        Display( f );
  
      fi;
      
      g := RandomMorphismWithFixedRange( M, Random( [ 0 .. max ] ) );
      
      if not IsWellDefined( g ) then
  
        Error( "g is not well-defined" );
  
      else
  
        #Display( "Ok" );
        Display( g );
  
      fi;
  
    od;
  
  end;

A := KoszulDualRing( S );

lp_cat_S := GradedLeftPresentations( S );
rp_cat_S := GradedRightPresentations( S );
lp_cat_A := GradedLeftPresentations( A );
rp_cat_A := GradedRightPresentations( A );

# test_random_objects_and_morphisms( lp_cat_S, 100, 5 );

