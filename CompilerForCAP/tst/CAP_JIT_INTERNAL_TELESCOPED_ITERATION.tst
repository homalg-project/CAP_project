gap> START_TEST( "CAP_JIT_INTERNAL_TELESCOPED_ITERATION" );

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> LoadPackage( "FreydCategoriesForCAP", false );
true

#
gap> ReadPackage( "LinearAlgebraForCAP", "gap/CompilerLogic.gi" );
true

#
gap> QQ := HomalgFieldOfRationals( );;
gap> cat := CategoryOfRows( QQ );;

# CapFixpoint with object
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
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 
       CapFixpoint( function ( x_2, y_2 )
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
    local morphism_attr_1_1, deduped_2_1;
    deduped_2_1 := CreateCapCategoryObjectWithAttributes( cat_1, 
       RankOfObject, 1 );
    morphism_attr_1_1 := CapFixpoint( function ( x_2, y_2 )
            return IsZero( y_2 );
        end, function ( x_2 )
            return x_2 - x_2;
        end, HomalgIdentityMatrix( 1, UnderlyingRing( cat_1 ) ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_2_1, 
       deduped_2_1, UnderlyingMatrix, morphism_attr_1_1 );
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
>         [ ],
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

# Iterated (case: from_initial_value)
# sum of morphisms
gap> func := { cat, morphism_list } ->
>     Iterated(
>         morphism_list,
>         { alpha, beta } -> AdditionForMorphisms( cat, alpha, beta )
>     );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, morphism_list_1 )
    local deduped_1_1;
    deduped_1_1 := morphism_list_1[1];
    return CreateCapCategoryMorphismWithAttributes( cat_1, 
       Source( deduped_1_1 ), Range( deduped_1_1 ), UnderlyingMatrix, 
       Iterated( List( morphism_list_1, UnderlyingMatrix ), 
         function ( alpha_2, beta_2 )
              return alpha_2 + beta_2;
          end ) );
end

# Iterated with three arguments (case: from_initial_value)
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

# Iterated (case: global_variables)
# PreComposeList
gap> MY_GLOBAL_OBJECT := ObjectConstructor( cat, 1 );;
gap> func := { cat, morphism_list } ->
>     Iterated(
>         morphism_list,
>         { alpha, beta } -> MorphismConstructor( cat, MY_GLOBAL_OBJECT, MorphismDatum( cat, alpha ) + MorphismDatum( cat, beta ), MY_GLOBAL_OBJECT )
>     );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, morphism_list_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, MY_GLOBAL_OBJECT, 
       MY_GLOBAL_OBJECT, UnderlyingMatrix, 
       Iterated( List( morphism_list_1, UnderlyingMatrix ), 
         function ( alpha_2, beta_2 )
              return alpha_2 + beta_2;
          end ) );
end

# Iterated (case: from_compiler_hints)
# PreComposeList
gap> func := { cat, morphism_list } ->
>     Iterated(
>         morphism_list,
>         { alpha, beta } -> PreCompose( cat, alpha, beta )
>     );;

#
gap> Display( CapJitCompiledFunction( func, cat ) );
function ( cat_1, morphism_list_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := Iterated( List( morphism_list_1, UnderlyingMatrix ), 
       function ( alpha_2, beta_2 )
            return alpha_2 * beta_2;
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, 
       CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 
         NumberRows( morphism_attr_1_1 ) ), 
       CreateCapCategoryObjectWithAttributes( cat_1, RankOfObject, 
         NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, 
       morphism_attr_1_1 );
end

#
gap> STOP_TEST( "CAP_JIT_INTERNAL_TELESCOPED_ITERATION" );
