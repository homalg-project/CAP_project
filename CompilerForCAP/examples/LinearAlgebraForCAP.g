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
#! function ( cat_1, S_1, diagram_S_1, morphism_matrix_1, diagram_T_1, T_1 )
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, S_1, T_1, UnderlyingFieldForHomalg, 
#!        UnderlyingRing( cat_1 ), UnderlyingMatrix, 
#!        UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), 
#!          ListN( diagram_S_1, List( morphism_matrix_1, function ( row_2 )
#!                   return List( row_2, UnderlyingMatrix );
#!               end ), function ( source_2, row_2 )
#!                 return UnionOfColumns( UnderlyingRing( cat_1 ), 
#!                    Dimension( source_2 ), row_2 );
#!             end ) ) );
#! end

# compile the default derivation of
# MorphismBetweenDirectSumsWithGivenDirectSums
tree2 := SYNTAX_TREE( CapJitCompiledFunction(
    vec!.added_functions.MorphismBetweenDirectSumsWithGivenDirectSums[1][1],
    [ vec, W, [ V, V ], morphism_matrix, [ V, V ], W  ]
) );;
Display( SYNTAX_TREE_CODE( tree2 ) );
#! function ( cat_1, S_1, diagram_S_1, morphism_matrix_1, diagram_T_1, T_1 )
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, S_1, T_1, UnderlyingFieldForHomalg, 
#!        UnderlyingRing( cat_1 ), UnderlyingMatrix, 
#!        UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), 
#!          ListN( diagram_S_1, morphism_matrix_1, 
#!            function ( logic_new_func_x_2, logic_new_func_y_2 )
#!                 return UnionOfColumns( UnderlyingRing( cat_1 ), 
#!                    Dimension( logic_new_func_x_2 ), 
#!                    List( logic_new_func_y_2, function ( s_3 )
#!                           return UnderlyingMatrix( s_3 );
#!                       end ) );
#!             end ) ) );
#! end

KernelEmbedding( alpha );;
Display( Last( vec!.compiled_functions.KernelEmbedding ) );
#! function ( cat_1, morphism_1 )
#!     local cap_jit_morphism_attribute_1;
#!     cap_jit_morphism_attribute_1 
#!      := SyzygiesOfRows( UnderlyingMatrix( morphism_1 ) );
#!     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
#!            ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
#!              ), cat_1, Dimension, NrRows( cap_jit_morphism_attribute_1 ), 
#!          UnderlyingFieldForHomalg, UnderlyingRing( cat_1 ) ), 
#!        Source( morphism_1 ), UnderlyingFieldForHomalg, UnderlyingRing( cat_1 )
#!         , UnderlyingMatrix, cap_jit_morphism_attribute_1 );
#! end

#! @EndExample
