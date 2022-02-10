#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

QQ := HomalgFieldOfRationals( );;
cat := MatrixCategory( QQ );;


# CapFixpoint with object
# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func := EvalString( ReplacedString( """function( cat )
  local predicate, func, initial_value@
    
    predicate := { x, y } -> Dimension( x ) = 3 and Dimension( y ) = 2@
    
    func := x -> MatrixCategoryObject( cat, Dimension( x ) - 1 )@
    
    initial_value := MatrixCategoryObject( cat, 10 )@
    
    return CapFixpoint( predicate, func, initial_value )@
    
end""", "@", ";" ) );;

func( cat );
#! <A vector space object over Q of dimension 2>

Display( CapJitCompiledFunction( func, cat ) );
#! function ( cat_1 )
#!     return ObjectifyObjectForCAPWithAttributes( rec(
#!            ), cat_1, Dimension, CapFixpoint( function ( x_2, y_2 )
#!               return x_2 = 3 and y_2 = 2;
#!           end, function ( x_2 )
#!               return x_2 - 1;
#!           end, 10 ) );
#! end

# CapFixpoint with morphism
# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func := EvalString( ReplacedString( """function( cat )
  local obj, predicate, func, initial_value@
    
    obj := MatrixCategoryObject( cat, 1 )@
    
    predicate := { x, y } -> IsZeroForMorphisms( cat, y )@
    
    func := x -> SubtractionForMorphisms( cat, x, x )@
    
    initial_value := IdentityMorphism( cat, obj )@
    
    return CapFixpoint( predicate, func, initial_value )@
    
end""", "@", ";" ) );;

func( cat );
#! <A morphism in Category of matrices over Q>

Display( CapJitCompiledFunction( func, cat ) );
#! function ( cat_1 )
#!     local morphism_attr_1_1, deduped_2_1;
#!     deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
#!            ), cat_1, Dimension, 1 );
#!     morphism_attr_1_1 := CapFixpoint( function ( x_2, y_2 )
#!             return IsZero( y_2 );
#!         end, function ( x_2 )
#!             return x_2 + -1 * x_2;
#!         end, HomalgIdentityMatrix( 1, UnderlyingRing( cat_1 ) ) );
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, 
#!        morphism_attr_1_1 );
#! end

# Iterated with list
func := { cat, alpha, beta, gamma } ->
    Iterated(
        [ alpha, beta, gamma ],
        { alpha, beta } -> PreCompose( cat, alpha, beta )
    );;

Display( CapJitCompiledFunction( func, cat ) );
#! function ( cat_1, alpha_1, beta_1, gamma_1 )
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, Source( alpha_1 ), Range( gamma_1 ), UnderlyingMatrix, 
#!        UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) 
#!         * UnderlyingMatrix( gamma_1 ) );
#! end

# Iterated (case: from_initial_value)
# PreComposeList
func := { cat, morphism_list } ->
    Iterated(
        morphism_list,
        { alpha, beta } -> AdditionForMorphisms( cat, alpha, beta )
    );;

Display( CapJitCompiledFunction( func, cat ) );
#! function ( cat_1, morphism_list_1 )
#!     local deduped_1_1;
#!     deduped_1_1 := morphism_list_1[1];
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, Source( deduped_1_1 ), Range( deduped_1_1 ), 
#!        UnderlyingMatrix, Iterated( List( morphism_list_1, UnderlyingMatrix )
#!           , function ( alpha_2, beta_2 )
#!               return alpha_2 + beta_2;
#!           end ) );
#! end

# Iterated (case: from_compiler_hints)
# PreComposeList
func := { cat, morphism_list } ->
    Iterated(
        morphism_list,
        { alpha, beta } -> PreCompose( cat, alpha, beta )
    );;

Display( CapJitCompiledFunction( func, cat ) );
#! function ( cat_1, morphism_list_1 )
#!     local morphism_attr_1_1;
#!     morphism_attr_1_1 := Iterated( List( morphism_list_1, UnderlyingMatrix ), 
#!        function ( alpha_2, beta_2 )
#!             return alpha_2 * beta_2;
#!         end );
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
#!              ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), 
#!        ObjectifyObjectForCAPWithAttributes( rec(
#!              ), cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), 
#!        UnderlyingMatrix, morphism_attr_1_1 );
#! end

#! @EndExample
