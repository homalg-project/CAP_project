#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

QQ := HomalgFieldOfRationals( );;
cat := MatrixCategory( QQ );;


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

# Iterated (for morphisms)
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

#! @EndExample
