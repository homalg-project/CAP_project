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
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat, S, T, UnderlyingFieldForHomalg, UnderlyingRing( cat ), 
#!        UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat ), Dimension( T ), 
#!          ListN( diagram_S, List( morphism_matrix, function ( row )
#!                   return List( row, UnderlyingMatrix );
#!               end ), function ( source, row )
#!                 return UnionOfColumns( UnderlyingRing( cat ), 
#!                    Dimension( source ), row );
#!             end ) ) );
#! end

# compile the default derivation of
# MorphismBetweenDirectSumsWithGivenDirectSums
tree2 := SYNTAX_TREE( CapJitCompiledFunction(
    vec!.added_functions.MorphismBetweenDirectSumsWithGivenDirectSums[1][1],
    [ vec, W, [ V, V ], morphism_matrix, [ V, V ], W  ]
) );;
# fixup nams
Last( tree2.stats.statements[1].obj.args ).args[3].args[3].nams :=
    [ "source", "row" ];;
Display( SYNTAX_TREE_CODE( tree2 ) );
#! function ( cat, S, diagram_S, morphism_matrix, diagram_T, T )
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat, S, T, UnderlyingFieldForHomalg, UnderlyingRing( cat ), 
#!        UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat ), Dimension( T ), 
#!          ListN( diagram_S, morphism_matrix, 
#!            function ( source, row )
#!                 return UnionOfColumns( UnderlyingRing( cat ), 
#!                    Dimension( source ), 
#!                    List( row, function ( s )
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
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat, ObjectifyObjectForCAPWithAttributes( rec(
#!              ), cat, Dimension, NrRows( cap_jit_morphism_attribute ), 
#!          UnderlyingFieldForHomalg, UnderlyingRing( cat ) ), Source( morphism )
#!         , UnderlyingFieldForHomalg, UnderlyingRing( cat ), UnderlyingMatrix, 
#!        cap_jit_morphism_attribute );
#! end

#! @EndExample
