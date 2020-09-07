#! @Chapter Examples and tests

#! @Section Examples

#! @Example

Q := HomalgFieldOfRationals();;
vec := MatrixCategory( Q :
    enable_compilation := [ "MorphismBetweenDirectSums" ]
);;

V := VectorSpaceObject( 2, Q );;
alpha := ZeroMorphism( V, V );;
beta := IdentityMorphism( V );;

W := DirectSum( V, V );;
morphism_matrix := [ [ alpha, beta ], [ beta, alpha ] ];;

# compile the primitive installation of MorphismBetweenDirectSums
MorphismBetweenDirectSums( morphism_matrix );;
tree1 := SYNTAX_TREE(
    vec!.compiled_functions.MorphismBetweenDirectSums[3]
);;
# fixup nams
tree1.nams := [ "S", "morphism_matrix", "T" ];;
tree1.nloc := 0;;
tree1.stats.statements[1].branches[2].body.statements[1].
    obj.args[12].args[1].args[2].nams := [ "row" ];;
tree1.stats.statements[1].branches[2].body.statements[1].
    obj.args[12].args[1].args[2].nloc := 0;;
Display( SYNTAX_TREE_CODE( tree1 ) );
#! function ( S, morphism_matrix, T )
#!     if morphism_matrix = [  ] or morphism_matrix[1] = [  ] then
#!         return ZeroMorphism( S, T );
#!     else
#!         return ObjectifyWithAttributes( rec(
#!                ), CAP_JIT_INTERNAL_GLOBAL_VARIABLE_3, CapCategory, 
#!            CAP_JIT_INTERNAL_GLOBAL_VARIABLE_1, Source, S, Range, T, 
#!            UnderlyingFieldForHomalg, CAP_JIT_INTERNAL_GLOBAL_VARIABLE_2, 
#!            UnderlyingMatrix, 
#!            UnionOfRows( List( morphism_matrix, function ( row )
#!                     return UnionOfColumns( List( row, UnderlyingMatrix ) );
#!                 end ) ) );
#!     fi;
#!     return;
#! end

# compile the default derivation of MorphismBetweenDirectSums
tree2 := SYNTAX_TREE( CapJitCompiledFunction(
    vec!.added_functions.MorphismBetweenDirectSums[1][1],
    [ W, morphism_matrix, W  ]
) );;
# fixup nams
tree2.nams := [ "S", "morphism_matrix", "T" ];;
tree2.nloc := 0;;
tree2.stats.statements[1].branches[2].body.statements[1].
    obj.args[12].args[1].args[2].nams := [ "row" ];;
tree2.stats.statements[1].branches[2].body.statements[1].
    obj.args[12].args[1].args[2].nloc := 0;;
Display( SYNTAX_TREE_CODE( tree2 ) );
#! function ( S, morphism_matrix, T )
#!     if morphism_matrix = [  ] or morphism_matrix[1] = [  ] then
#!         return ZeroMorphism( S, T );
#!     else
#!         return ObjectifyWithAttributes( rec(
#!                ), CAP_JIT_INTERNAL_GLOBAL_VARIABLE_3, CapCategory, 
#!            CAP_JIT_INTERNAL_GLOBAL_VARIABLE_1, Source, S, Range, T, 
#!            UnderlyingFieldForHomalg, CAP_JIT_INTERNAL_GLOBAL_VARIABLE_2, 
#!            UnderlyingMatrix, 
#!            UnionOfRows( List( morphism_matrix, function ( row )
#!                     return UnionOfColumns( List( row, function ( s )
#!                               return UnderlyingMatrix( s );
#!                           end ) );
#!                 end ) ) );
#!     fi;
#!     return;
#! end

#! @EndExample
