#! @Chapter Examples and tests

#! @Section Examples

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true
LoadPackage( "LinearAlgebraForCAP", false );
#! true

Q := HomalgFieldOfRationals();;
vec := MatrixCategory_as_CategoryOfRows( Q : no_precompiled_code := true );;

V := MatrixCategoryObject( vec, 2 );;
alpha := ZeroMorphism( V, V );;
beta := IdentityMorphism( V );;

W := DirectSum( V, V );;
morphism_matrix := [ [ alpha, beta ], [ beta, alpha ] ];;

# compile the derivation of MorphismBetweenDirectSumsWithGivenDirectSums
Print(
    vec!.added_functions.MorphismBetweenDirectSumsWithGivenDirectSums[1],
    "\n"
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
    vec!.added_functions.MorphismBetweenDirectSumsWithGivenDirectSums[1],
    vec
);;
Display( compiled_func2 );
#! function ( cat_1, S_1, diagram_S_1, morphism_matrix_1, diagram_T_1, T_1 )
#!     local deduped_2_1;
#!     deduped_2_1 := UnderlyingRing( cat_1 );
#!     return AsCapCategoryMorphism( cat_1, S_1, 
#!        UnionOfRows( deduped_2_1, AsInteger( T_1 ), 
#!          ListN( diagram_S_1, morphism_matrix_1, function ( source_2, row_2 )
#!                 return UnionOfColumns( deduped_2_1, AsInteger( source_2 ), 
#!                    List( row_2, AsHomalgMatrix ) );
#!             end ) ), T_1 );
#! end

Display( ENHANCED_SYNTAX_TREE_CODE(
    CapJitCompiledCAPOperationAsEnhancedSyntaxTree(
        vec, "KernelEmbedding", true
    )
) );
#! function ( cat_1, alpha_1 )
#!     local morphism_attr_1_1;
#!     morphism_attr_1_1 := SyzygiesOfRows( AsHomalgMatrix( alpha_1 ) );
#!     return 
#!      AsCapCategoryMorphism( cat_1, 
#!        AsCapCategoryObject( cat_1, NumberRows( morphism_attr_1_1 ) ), 
#!        morphism_attr_1_1, Source( alpha_1 ) );
#! end

#! @EndExample
