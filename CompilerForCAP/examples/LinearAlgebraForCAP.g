#! @Chapter Examples and tests

#! @Section Examples

LoadPackage( "LinearAlgebraForCAP" );

#! @Example

Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q : enable_compilation := true );;

V := VectorSpaceObject( 2, Q );;
alpha := ZeroMorphism( V, V );;
beta := IdentityMorphism( V );;

W := DirectSum( V, V );;
morphism_matrix := [ [ alpha, beta ], [ beta, alpha ] ];;

# compile the primitive installation of
# MorphismBetweenDirectSumsWithGivenDirectSums
MorphismBetweenDirectSumsWithGivenDirectSums(
    vec,
    W,
    [ V, V ],
    morphism_matrix,
    [ V, V ],
    W
);;
tree1 := SYNTAX_TREE(
    vec!.compiled_functions.MorphismBetweenDirectSumsWithGivenDirectSums[3]
);;
Display( SYNTAX_TREE_CODE( tree1 ) );
#! function ( cat, S, diagram_S, morphism_matrix, diagram_T, T )
#!     return ObjectifyWithAttributes( rec(
#!            ), MorphismType( cat ), CapCategory, cat, Source, S, Range, T, 
#!        UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, 
#!        UnionOfRows( UnderlyingRing( cat ), Dimension( T ), 
#!          List( [ 1 .. Length( List( morphism_matrix, function ( row )
#!                         return List( row, UnderlyingMatrix );
#!                     end ) ) ], function ( i )
#!                 return UnionOfColumns( UnderlyingRing( cat ), 
#!                    Dimension( diagram_S[i] ), 
#!                    List( morphism_matrix[i], UnderlyingMatrix ) );
#!             end ) ) );
#! end

# compile the default derivation of
# MorphismBetweenDirectSumsWithGivenDirectSums
tree2 := SYNTAX_TREE( CapJitCompiledFunction(
    vec!.added_functions.MorphismBetweenDirectSumsWithGivenDirectSums[1][1],
    [ vec, W, [ V, V ], morphism_matrix, [ V, V ], W  ]
) );;
# fixup nams
tree2.stats.statements[1].obj.args[12].args[3].args[2].nams := [ "i" ];;
Display( SYNTAX_TREE_CODE( tree2 ) );
#! function ( cat, S, diagram_S, morphism_matrix, diagram_T, T )
#!     return ObjectifyWithAttributes( rec(
#!            ), MorphismType( cat ), CapCategory, cat, Source, S, Range, T, 
#!        UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, 
#!        UnionOfRows( UnderlyingRing( cat ), Dimension( T ), 
#!          List( [ 1 .. Length( morphism_matrix ) ], function ( i )
#!                 return UnionOfColumns( UnderlyingRing( cat ), 
#!                    Dimension( diagram_S[i] ), 
#!                    List( morphism_matrix[i], function ( s )
#!                           return UnderlyingMatrix( s );
#!                       end ) );
#!             end ) ) );
#! end

KernelEmbedding( alpha );;
Display( Last( vec!.compiled_functions.KernelEmbedding ) );
#! function ( cat, morphism )
#!     local cap_jit_morphism_attribute;
#!     cap_jit_morphism_attribute 
#!      := SyzygiesOfRows( UnderlyingMatrix( morphism ) );
#!     return ObjectifyWithAttributes( rec(
#!            ), MorphismType( cat ), CapCategory, cat, Source, 
#!        ObjectifyWithAttributes( rec(
#!              ), ObjectType( cat ), CapCategory, cat, Dimension, 
#!          NrRows( cap_jit_morphism_attribute ), UnderlyingFieldForHomalg, 
#!          UnderlyingRing( cat ) ), Range, Source( morphism ), 
#!        UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, 
#!        cap_jit_morphism_attribute );
#! end

#! @EndExample
