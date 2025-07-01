gap> START_TEST( "CAP_JIT_INTERNAL_TELESCOPED_ITERATION" );

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> LoadPackage( "AdditiveClosuresForCAP", false );
true
gap> LoadPackage( "LinearAlgebraForCAP", false );
true

#
gap> ReadPackage( "LinearAlgebraForCAP", "gap/CompilerLogic.gi" );
true

#
gap> QQ := HomalgFieldOfRationals( );;
gap> cat := CategoryOfRows( QQ );;
gap> mat := MatrixCategory( QQ );;

# CapFixpoint with CreateCapCategoryObject
gap> func := function( cat )
>   local predicate, func, initial_value;
>     
>     predicate := { x, y } -> RankOfObject( x ) = 3 and RankOfObject( y ) = 2;
>     
>     func := x -> CategoryOfRowsObject( cat, RankOfObject( x ) - 1 );
>     
>     initial_value := CategoryOfRowsObject( cat, 10 );
>     
>     return CapFixpoint( predicate, func, initial_value );
>     
> end;;

#
gap> func( cat );
<A row module over Q of rank 2>

#
gap> Display( CapJitCompiledFunction( func, cat, [ "category" ], "object" ) );
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 
       CapFixpoint( function ( x_2, y_2 )
              return x_2 = 3 and y_2 = 2;
          end, function ( x_2 )
              return x_2 - 1;
          end, 10 ) );
end

# CapFixpoint with AsCapCategoryObject
gap> func := function( cat )
>   local predicate, func, initial_value;
>     
>     predicate := { x, y } -> AsInteger( x ) = 3 and AsInteger( y ) = 2;
>     
>     func := x -> AsCapCategoryObject( cat, AsInteger( x ) - 1 );
>     
>     initial_value := AsCapCategoryObject( cat, 10 );
>     
>     return CapFixpoint( predicate, func, initial_value );
>     
> end;;

#
gap> func( mat );
<A vector space object over Q of dimension 2>

#
gap> Display( CapJitCompiledFunction( func, mat, [ "category" ], "object" ) );
function ( cat_1 )
    return AsCapCategoryObject( cat_1, CapFixpoint( function ( x_2, y_2 )
              return x_2 = 3 and y_2 = 2;
          end, function ( x_2 )
              return x_2 - 1;
          end, 10 ) );
end

# CapFixpoint with morphism
gap> func := function( cat )
>   local obj, predicate, func, initial_value;
>     
>     obj := CategoryOfRowsObject( cat, 1 );
>     
>     predicate := { x, y } -> IsZeroForMorphisms( cat, y );
>     
>     func := x -> SubtractionForMorphisms( cat, x, x );
>     
>     initial_value := IdentityMorphism( cat, obj );
>     
>     return CapFixpoint( predicate, func, initial_value );
>     
> end;;

#
gap> func( cat );
<A morphism in Rows( Q )>

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := CapFixpoint( function ( x_2, y_2 )
            return IsZero( y_2 );
        end, function ( x_2 )
            return x_2 - x_2;
        end, HomalgIdentityMatrix( 1, UnderlyingRing( cat_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, 
       CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 
         NumberRows( deduped_1_1 ) ), CreateCapCategoryObjectWithAttributes( 
         cat_1, RankOfObject, NumberColumns( deduped_1_1 ) ), UnderlyingMatrix
        , deduped_1_1 );
end

# Iterated with literal list
gap> func := { cat, alpha, beta, gamma } ->
>     Iterated(
>         [ alpha, beta, gamma ],
>         { alpha, beta } -> PreCompose( cat, alpha, beta )
>     );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, alpha_1, beta_1, gamma_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, Source( alpha_1 ), 
       Range( gamma_1 ), UnderlyingMatrix, 
       UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) 
        * UnderlyingMatrix( gamma_1 ) );
end

# Iterated with literal list and initial_value
gap> func := { cat, source, alpha, beta, gamma } ->
>     Iterated(
>         [ alpha, beta, gamma ],
>         { alpha, beta } -> PreCompose( cat, alpha, beta ),
>         IdentityMorphism( cat, source )
>     );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, source_1, alpha_1, beta_1, gamma_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, 
       Range( gamma_1 ), UnderlyingMatrix, 
       UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) 
        * UnderlyingMatrix( gamma_1 ) );
end

# Iterated with empty literal list and initial_value
gap> func := { cat, source } ->
>     Iterated(
>         CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( cat ) ) ),
>         { alpha, beta } -> PreCompose( cat, alpha, beta ),
>         IdentityMorphism( cat, source )
>     );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, source_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, 
       source_1, UnderlyingMatrix, 
       HomalgIdentityMatrix( RankOfObject( source_1 ), 
         UnderlyingRing( cat_1 ) ) );
end

# Iterated with empty literal list, initial_value, and terminal_value
gap> func := { cat, source, range } ->
>     Iterated(
>         CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( cat ) ) ),
>         { alpha, beta } -> PreCompose( cat, alpha, beta ),
>         IdentityMorphism( cat, source ),
>         IdentityMorphism( cat, range )
>     );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, source_1, range_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, 
       UnderlyingMatrix, HomalgIdentityMatrix( RankOfObject( range_1 ), 
         UnderlyingRing( cat_1 ) ) );
end

# Iterated with two arguments
# sum of morphisms
gap> func := { cat, morphism_list } ->
>     Iterated(
>         morphism_list,
>         { alpha, beta } -> AdditionForMorphisms( cat, alpha, beta )
>     );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, morphism_list_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, 
       Iterated( List( morphism_list_1, Source ), function ( alpha_2, beta_2 )
              return alpha_2;
          end ), Iterated( List( morphism_list_1, Range ), 
         function ( alpha_2, beta_2 )
              return alpha_2;
          end ), UnderlyingMatrix, 
       Iterated( List( morphism_list_1, UnderlyingMatrix ), 
         function ( alpha_2, beta_2 )
              return alpha_2 + beta_2;
          end ) );
end

# Iterated with three arguments
# sum of morphisms
gap> func := { cat, source, morphism_list, range } ->
>     Iterated(
>         morphism_list,
>         { alpha, beta } -> AdditionForMorphisms( cat, alpha, beta ),
>         ZeroMorphism( cat, source, range )
>     );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, source_1, morphism_list_1, range_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, source_1, range_1, 
       UnderlyingMatrix, Iterated( List( morphism_list_1, UnderlyingMatrix ), 
         function ( alpha_2, beta_2 )
              return alpha_2 + beta_2;
          end, HomalgZeroMatrix( RankOfObject( source_1 ), 
           RankOfObject( range_1 ), UnderlyingRing( cat_1 ) ) ) );
end

#
gap> STOP_TEST( "CAP_JIT_INTERNAL_TELESCOPED_ITERATION" );
