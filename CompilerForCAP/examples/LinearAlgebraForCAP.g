#! @Chapter Examples and tests

#! @Section Examples

LoadPackage( "LinearAlgebraForCAP" );

#! @Example

Q := HomalgFieldOfRationals();;
vec := MATRIX_CATEGORY( Q : no_precompiled_code := true );;

V := MatrixCategoryObject( vec, 2 );;
alpha := ZeroMorphism( V, V );;
beta := IdentityMorphism( V );;

W := DirectSum( V, V );;
morphism_matrix := [ [ alpha, beta ], [ beta, alpha ] ];;

# compile the primitive installation of
# MorphismBetweenDirectSumsWithGivenDirectSums
Display(
    vec!.added_functions.MorphismBetweenDirectSumsWithGivenDirectSums[2][1]
);
#! function ( cat, S, diagram_S, morphism_matrix, diagram_T, T )
#!     local underlying_matrix;
#!     underlying_matrix := List( morphism_matrix, function ( row )
#!             return List( row, UnderlyingMatrix );
#!         end );
#!     underlying_matrix := ListN( diagram_S, underlying_matrix, 
#!        function ( source, row )
#!             return UnionOfColumns( homalg_field, Dimension( source ), row );
#!         end );
#!     return 
#!      VectorSpaceMorphism( cat, S, UnionOfRows( homalg_field, Dimension( T ), 
#!          underlying_matrix ), T );
#! end
compiled_func1 := CapJitCompiledFunction(
    vec!.added_functions.MorphismBetweenDirectSumsWithGivenDirectSums[2][1],
    vec
);;
Display( compiled_func1 );
#! function ( cat_1, S_1, diagram_S_1, morphism_matrix_1, diagram_T_1, T_1 )
#!     local hoisted_1_1, deduped_2_1;
#!     deduped_2_1 := UnderlyingRing( cat_1 );
#!     hoisted_1_1 := deduped_2_1;
#!     return CreateCapCategoryMorphismWithAttributes( cat_1, S_1, T_1, 
#!        UnderlyingMatrix, UnionOfRows( deduped_2_1, Dimension( T_1 ), 
#!          ListN( diagram_S_1, List( morphism_matrix_1, function ( row_2 )
#!                   return List( row_2, UnderlyingMatrix );
#!               end ), function ( source_2, row_2 )
#!                 return UnionOfColumns( hoisted_1_1, Dimension( source_2 ), 
#!                    row_2 );
#!             end ) ) );
#! end

# compile the default derivation of
# MorphismBetweenDirectSumsWithGivenDirectSums
Display(
    vec!.added_functions.MorphismBetweenDirectSumsWithGivenDirectSums[1][1]
);
#! function ( cat, S, diagram_S, morphism_matrix, diagram_T, T )
#!     local test_diagram_product, test_diagram_coproduct;
#!     test_diagram_coproduct := ListN( diagram_S, morphism_matrix, 
#!        function ( source, row )
#!             return UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, 
#!                diagram_T, source, row, T );
#!         end );
#!     return UniversalMorphismFromDirectSumWithGivenDirectSum( cat, diagram_S, 
#!        T, test_diagram_coproduct, S );
#! end
compiled_func2 := CapJitCompiledFunction(
    vec!.added_functions.MorphismBetweenDirectSumsWithGivenDirectSums[1][1],
    vec
);;
Display( compiled_func2 );
#! function ( cat_1, S_1, diagram_S_1, morphism_matrix_1, diagram_T_1, T_1 )
#!     local hoisted_1_1, deduped_2_1;
#!     deduped_2_1 := UnderlyingRing( cat_1 );
#!     hoisted_1_1 := deduped_2_1;
#!     return CreateCapCategoryMorphismWithAttributes( cat_1, S_1, T_1, 
#!        UnderlyingMatrix, UnionOfRows( deduped_2_1, Dimension( T_1 ), 
#!          ListN( diagram_S_1, morphism_matrix_1, 
#!            function ( logic_new_func_x_2, logic_new_func_y_2 )
#!                 return 
#!                  UnionOfColumns( hoisted_1_1, Dimension( logic_new_func_x_2 )
#!                     , List( logic_new_func_y_2, UnderlyingMatrix ) );
#!             end ) ) );
#! end

Display( ENHANCED_SYNTAX_TREE_CODE(
    CapJitCompiledCAPOperationAsEnhancedSyntaxTree(
        vec, "KernelEmbedding", true
    )
) );
#! function ( cat_1, morphism_1 )
#!     local morphism_attr_1_1;
#!     morphism_attr_1_1 := SyzygiesOfRows( UnderlyingMatrix( morphism_1 ) );
#!     return CreateCapCategoryMorphismWithAttributes( cat_1, 
#!        CreateCapCategoryObjectWithAttributes( cat_1, Dimension, 
#!          NumberRows( morphism_attr_1_1 ) ), Source( morphism_1 ), 
#!        UnderlyingMatrix, morphism_attr_1_1 );
#! end

#! @EndExample
