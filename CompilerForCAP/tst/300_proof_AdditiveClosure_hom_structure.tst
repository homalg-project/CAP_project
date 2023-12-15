gap> START_TEST( "proof_AdditiveClosure_hom_structure" );

#
gap> LoadPackage( "FreydCategoriesForCAP", false );
true

#
gap> dummy_range := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "IsWellDefinedForObjects",
>         "IsWellDefinedForMorphismsWithGivenSourceAndRange",
>         "IsEqualForObjects",
>         "IsCongruentForMorphisms",
>         "PreCompose",
>         "PreComposeList",
>         "IdentityMorphism",
>         "AdditionForMorphisms",
>         "SumOfMorphisms",
>         "ZeroMorphism",
>         "DirectSum",
>         "ProjectionInFactorOfDirectSum",
>         "UniversalMorphismIntoDirectSum",
>         "ComponentOfMorphismIntoDirectSum",
>         "InjectionOfCofactorOfDirectSum",
>         "UniversalMorphismFromDirectSum",
>         "ComponentOfMorphismFromDirectSum",
>         "MorphismBetweenDirectSums",
>     ],
>     properties := [
>         "IsAdditiveCategory",
>     ],
> ) : FinalizeCategory := false );;
gap> AddMorphismBetweenDirectSums( dummy_range, { cat, source_diagram, matrix, target_diagram } -> fail );
gap> Finalize( dummy_range );;

#
gap> dummy := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "IsWellDefinedForObjects",
>         "IsWellDefinedForMorphismsWithGivenSourceAndRange",
>         "IsEqualForObjects",
>         "IsCongruentForMorphisms",
>         "PreCompose",
>         "PreComposeList",
>         "IdentityMorphism",
>         "AdditionForMorphisms",
>         "SumOfMorphisms",
>         "ZeroMorphism",
>     ],
>     properties := [
>         "IsAbCategory",
>     ],
> ) : FinalizeCategory := false );;
gap> SetRangeCategoryOfHomomorphismStructure( dummy, dummy_range );
gap> AddHomomorphismStructureOnObjects( dummy, { cat, A, B } -> fail );
gap> AddHomomorphismStructureOnMorphisms( dummy, { cat, alpha, beta } -> fail );
gap> AddDistinguishedObjectOfHomomorphismStructure( dummy, { cat } -> fail );
gap> AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( dummy, { cat, alpha } -> fail );
gap> AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( dummy, { cat, source, target, alpha } -> fail );
gap> Finalize( dummy );;

#
gap> cat := AdditiveClosure( dummy );;

# set a human readable name
gap> cat!.Name := "the additive closure of a pre-additive category with a homomorphism structure in an additive category";;

#
gap> Assert( 0, HasRangeCategoryOfHomomorphismStructure( cat ) and RangeCategoryOfHomomorphismStructure( cat ) = dummy_range );
gap> Assert( 0, CanCompute( cat, "HomomorphismStructureOnObjects" ) );
gap> Assert( 0, CanCompute( cat, "HomomorphismStructureOnMorphisms" ) );
gap> Assert( 0, CanCompute( cat, "DistinguishedObjectOfHomomorphismStructure" ) );
gap> Assert( 0, CanCompute( cat, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) );
gap> Assert( 0, CanCompute( cat, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> CapJitEnableProofAssistantMode( );

#
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy_range );
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

#
gap> StateProposition( cat, "is_equipped_with_hom_structure" );
Proposition:
The additive closure of a pre-additive category with a homomorphism structure \
in an additive category is equipped with a homomorphism structure.

# DistinguishedObjectOfHomomorphismStructure is well-defined
gap> StateNextLemma( );


Lemma 1:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, the distinguished object is an object in the range\
 category of the homomorphism structure:
We have
function ( cat )
    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat 
         ), DistinguishedObjectOfHomomorphismStructure( cat ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1 )
    return 
     IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat_1 ), 
       DistinguishedObjectOfHomomorphismStructure( 
         UnderlyingCategory( cat_1 ) ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnObjects is well-defined
gap> StateNextLemma( );


Lemma 2:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, the homomorphism structure on objects defines an o\
bject in the range category of the homomorphism structure:
For two objects A and B we have
function ( cat, A, B )
    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat 
         ), HomomorphismStructureOnObjects( cat, A, B ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1 )
    return 
     IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat_1 ), 
       DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 ), 
         List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( j_2 )
                return 
                 DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 ), 
                   List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                     function ( s_3 )
                          return HomomorphismStructureOnObjects( 
                             UnderlyingCategory( cat_1 ), 
                             ObjectList( A_1 )[j_2], ObjectList( B_1 )[s_3] );
                      end ) );
            end ) ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms is well-defined
gap> StateNextLemma( );


Lemma 3:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, the homomorphism structure on morphisms defines a \
morphism in the range category of the homomorphism structure:
For four objects A, B, C, and D and two morphisms alpha : A → B and beta : C\
 → D we have
function ( cat, A, B, C, D, alpha, beta )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( 
       RangeCategoryOfHomomorphismStructure( cat ), 
       HomomorphismStructureOnObjects( cat, B, C ), 
       HomomorphismStructureOnMorphisms( cat, alpha, beta ), 
       HomomorphismStructureOnObjects( cat, A, D ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, C_1, D_1, alpha_1, beta_1 )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( 
       RangeCategoryOfHomomorphismStructure( cat_1 ), 
       DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 ), 
         List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_2 )
                return 
                 DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 ), 
                   List( [ 1 .. Length( ObjectList( C_1 ) ) ], 
                     function ( s_3 )
                          return HomomorphismStructureOnObjects( 
                             UnderlyingCategory( cat_1 ), 
                             ObjectList( B_1 )[j_2], ObjectList( C_1 )[s_3] );
                      end ) );
            end ) ), 
       MorphismBetweenDirectSums( RangeCategoryOfHomomorphismStructure( cat_1 
           ), List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_2 )
                return 
                 DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 ), 
                   List( [ 1 .. Length( ObjectList( C_1 ) ) ], 
                     function ( s_3 )
                          return HomomorphismStructureOnObjects( 
                             UnderlyingCategory( cat_1 ), 
                             ObjectList( B_1 )[j_2], ObjectList( C_1 )[s_3] );
                      end ) );
            end ), List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
           function ( j_2 )
                return List( [ 1 .. Length( ObjectList( A_1 ) ) ], 
                   function ( i_3 )
                        return 
                         MorphismBetweenDirectSums( 
                           RangeCategoryOfHomomorphismStructure( cat_1 ), 
                           List( [ 1 .. Length( ObjectList( C_1 ) ) ], 
                             function ( s_4 )
                                  return HomomorphismStructureOnObjects( 
                                     UnderlyingCategory( cat_1 ), 
                                     ObjectList( B_1 )[j_2], 
                                     ObjectList( C_1 )[s_4] );
                              end ), 
                           List( [ 1 .. Length( ObjectList( C_1 ) ) ], 
                             function ( s_4 )
                                  return 
                                   List( [ 1 .. Length( ObjectList( D_1 ) ) ]
                                      , function ( t_5 )
                                          return 
                                           HomomorphismStructureOnMorphisms( 
                                             UnderlyingCategory( cat_1 ), 
                                             MorphismMatrix( alpha_1 )[i_3]
                                                [j_2], 
                                             MorphismMatrix( beta_1 )[s_4][t_5
                                               ] );
                                      end );
                              end ), 
                           List( [ 1 .. Length( ObjectList( D_1 ) ) ], 
                             function ( t_4 )
                                  return HomomorphismStructureOnObjects( 
                                     UnderlyingCategory( cat_1 ), 
                                     ObjectList( A_1 )[i_3], 
                                     ObjectList( D_1 )[t_4] );
                              end ) );
                    end );
            end ), List( [ 1 .. Length( ObjectList( A_1 ) ) ], 
           function ( i_2 )
                return 
                 DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 ), 
                   List( [ 1 .. Length( ObjectList( D_1 ) ) ], 
                     function ( t_3 )
                          return HomomorphismStructureOnObjects( 
                             UnderlyingCategory( cat_1 ), 
                             ObjectList( A_1 )[i_2], ObjectList( D_1 )[t_3] );
                      end ) );
            end ) ), DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 )
          , List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( j_2 )
                return 
                 DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 ), 
                   List( [ 1 .. Length( ObjectList( D_1 ) ) ], 
                     function ( s_3 )
                          return HomomorphismStructureOnObjects( 
                             UnderlyingCategory( cat_1 ), 
                             ObjectList( A_1 )[j_2], ObjectList( D_1 )[s_3] );
                      end ) );
            end ) ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms preserves identities
gap> StateNextLemma( );


Lemma 4:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, the homomorphism structure preserves identities:
For two objects A and B we have
function ( cat, A, B )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat 
         ), HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A )
          , IdentityMorphism( cat, B ) ), 
       IdentityMorphism( RangeCategoryOfHomomorphismStructure( cat ), 
         HomomorphismStructureOnObjects( cat, A, B ) ) );
end
gap> # check congruence with identity on direct sum componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "morphism", "list" ],
>         src_template := "IsCongruentForMorphisms( cat, morphism, IdentityMorphism( cat, DirectSum( cat, list ) ) )",
>         dst_template := "ForAll( [ 1 .. Length( list ) ], i -> ForAll( [ 1 .. Length( list ) ], j -> IsCongruentForMorphisms( cat, PreComposeList( cat, list[i], [ InjectionOfCofactorOfDirectSum( cat, list, i ), morphism, ProjectionInFactorOfDirectSum( cat, list, j ) ], list[j] ), CAP_JIT_INTERNAL_EXPR_CASE( i = j, IdentityMorphism( cat, list[i] ), true, ZeroMorphism( cat, list[i], list[j] ) ) ) ) )",
>         new_funcs := [ [ "i" ], [ "j"] ],
>     )
> );
gap> # injection * morphism_between_direct_sum * projection selects a component
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list", "i", "j", "matrix", "source", "target" ],
>         src_template := "PreComposeList( cat, source, [ InjectionOfCofactorOfDirectSum( cat, list, i ), MorphismBetweenDirectSums( cat, list, matrix, list ), ProjectionInFactorOfDirectSum( cat, list, j ) ], target )",
>         dst_template := "matrix[i][j]",
>     )
> );
gap> # pull equality into case distinction
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "morphism", "P", "case1", "case2" ],
>         src_template := "IsCongruentForMorphisms( cat, morphism, CAP_JIT_INTERNAL_EXPR_CASE( P, case1, true, case2 ) )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, IsCongruentForMorphisms( cat, morphism, case1 ), true, IsCongruentForMorphisms( cat, morphism, case2 ) )",
>     )
> );
gap> # replace j by i in the if case
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "case1", "case2", "i" ],
>         src_template := "j -> CAP_JIT_INTERNAL_EXPR_CASE( i = j, case1, true, case2 )",
>         dst_template := "x -> CAP_JIT_INTERNAL_EXPR_CASE( i = x, (j -> case1)(i), true, (j -> case2)(x) )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> # check congruence with identity on direct sum componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "morphism", "list" ],
>         src_template := "IsCongruentForMorphisms( cat, morphism, IdentityMorphism( cat, DirectSum( cat, list ) ) )",
>         dst_template := "ForAll( [ 1 .. Length( list ) ], i -> ForAll( [ 1 .. Length( list ) ], j -> IsCongruentForMorphisms( cat, PreComposeList( cat, list[i], [ InjectionOfCofactorOfDirectSum( cat, list, i ), morphism, ProjectionInFactorOfDirectSum( cat, list, j ) ], list[j] ), CAP_JIT_INTERNAL_EXPR_CASE( i = j, IdentityMorphism( cat, list[i] ), true, ZeroMorphism( cat, list[i], list[j] ) ) ) ) )",
>         new_funcs := [ [ "i" ], [ "j"] ],
>     )
> );
gap> # injection * morphism_between_direct_sum * projection selects a component
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list", "i", "j", "matrix", "source", "target" ],
>         src_template := "PreComposeList( cat, source, [ InjectionOfCofactorOfDirectSum( cat, list, i ), MorphismBetweenDirectSums( cat, list, matrix, list ), ProjectionInFactorOfDirectSum( cat, list, j ) ], target )",
>         dst_template := "matrix[i][j]",
>     )
> );
gap> # pull equality into case distinction
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "morphism", "P", "case1", "case2" ],
>         src_template := "IsCongruentForMorphisms( cat, morphism, CAP_JIT_INTERNAL_EXPR_CASE( P, case1, true, case2 ) )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, IsCongruentForMorphisms( cat, morphism, case1 ), true, IsCongruentForMorphisms( cat, morphism, case2 ) )",
>     )
> );
gap> # hom structure on identities in the underlying category
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), IdentityMorphism( cat, B ) )",
>         dst_template := "IdentityMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) )",
>     )
> );
gap> # hom structure on identity and zero in the underlying category
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "C" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryObject ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), ZeroMorphism( cat, B, C ) )",
>         dst_template := "ZeroMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ), HomomorphismStructureOnObjects( cat, A, C ) )",
>     )
> );
gap> # check congruence with zero morphism on direct sum componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "morphism", "list1", "list2" ],
>         src_template := "IsCongruentForMorphisms( cat, morphism, ZeroMorphism( cat, DirectSum( cat, list1 ), DirectSum( cat, list2 ) ) )",
>         dst_template := "ForAll( [ 1 .. Length( list1 ) ], k -> ForAll( [ 1 .. Length( list2 ) ], l -> IsCongruentForMorphisms( cat, PreComposeList( cat, list1[k], [ InjectionOfCofactorOfDirectSum( cat, list1, k ), morphism, ProjectionInFactorOfDirectSum( cat, list2, l ) ], list2[l] ), ZeroMorphism( cat, list1[k], list2[l] ) ) ) )",
>         new_funcs := [ [ "k" ], [ "l"] ],
>     )
> );
gap> # injection * morphism_between_direct_sum * projection selects a component
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "k", "l", "matrix", "source", "target" ],
>         src_template := "PreComposeList( cat, source, [ InjectionOfCofactorOfDirectSum( cat, list1, k ), MorphismBetweenDirectSums( cat, list1, matrix, list2 ), ProjectionInFactorOfDirectSum( cat, list2, l ) ], target )",
>         dst_template := "matrix[k][l]",
>     )
> );
gap> # hom structure on zero in the underlying category
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "mor" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryMorphism ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, ZeroMorphism( cat, A, B ), mor )",
>         dst_template := "ZeroMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, B, Source( mor ) ), HomomorphismStructureOnObjects( A, Range( mor ) ) )",
>     )
> );
gap> # eliminate case distinction
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "k", "l", "list" ],
>         src_template := "CAP_JIT_INTERNAL_EXPR_CASE( k = l, list[k], true, list[l] )",
>         dst_template := "list[l]",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms is compatible with composition
gap> StateNextLemma( );


Lemma 5:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, the homomorphism structure is compatible with comp\
osition:
For six objects A, B, C, D, E, and F and four morphisms alpha_1 : B → C, alp\
ha_2 : A → B, beta_1 : D → E, and beta_2 : E → F we have
function ( cat, A, B, C, D, E, F, alpha_1, alpha_2, beta_1, beta_2 )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat 
         ), PreCompose( RangeCategoryOfHomomorphismStructure( cat ), 
         HomomorphismStructureOnMorphisms( cat, alpha_1, beta_1 ), 
         HomomorphismStructureOnMorphisms( cat, alpha_2, beta_2 ) ), 
       HomomorphismStructureOnMorphisms( cat, 
         PreCompose( cat, alpha_2, alpha_1 ), PreCompose( cat, beta_1, beta_2 
           ) ) );
end
gap> # composition of morphisms between direct sums via generalized matrix multiplication
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "cat", "list1", "list2", "list3", "matrix1", "matrix2" ],
>         src_template := "PreCompose( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list2, matrix2, list3 ) )",
>         dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], i -> List( [ 1 .. Length( list3 ) ], j -> SumOfMorphisms( cat, list1[i], List( [ 1 .. Length( list2 ) ], k -> PreCompose( cat, matrix1[i][k], matrix2[k][j] ) ), list3[j] ) ) ), list3 )",
>         new_funcs := [ [ "i" ], [ "j" ], [ "k" ] ],
>     )
> );
gap> # equality of morphisms between direct sums can be checked componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "ForAll( [ 1 .. Length( list1 ) ], x -> ForAll( [ 1 .. Length( list2 ) ], y -> IsCongruentForMorphisms( cat, matrix1[x][y], matrix2[x][y] ) ) )",
>         new_funcs := [ [ "x" ], [ "y" ] ],
>     )
> );
gap> # sum of morphisms between direct sums can be computed componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list1", "list2", "list3", "matrix" ],
>         src_template := "SumOfMorphisms( cat, source, List( list3, k -> MorphismBetweenDirectSums( cat, list1, matrix, list2 ) ), target )",
>         dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> SumOfMorphisms( cat, list1[a], List( list3, k -> matrix[a][b] ), list2[b] ) ) ), list2 )",
>         new_funcs := [ [ "a" ], [ "b" ] ],
>     )
> );
gap> # equality of morphisms between direct sums can be checked componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
>         new_funcs := [ [ "s" ], [ "t" ] ],
>     )
> );
gap> # HomomorphismStructureOnMorphisms in the underlying category is additive in the first component
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "alpha", "beta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, SumOfMorphisms( cat, source, List( list, k -> alpha ), target ), beta )",
>         dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, target, Source( beta ) ), List( list, k -> HomomorphismStructureOnMorphisms( cat, alpha, beta ) ), HomomorphismStructureOnObjects( cat, source, Range( beta ) ) )",
>     )
> );
gap> # HomomorphismStructureOnMorphisms in the underlying category is additive in the second component
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "alpha", "beta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, alpha, SumOfMorphisms( cat, source, List( list, k -> beta ), target ) )",
>         dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, Range( alpha ), source ), List( list, k -> HomomorphismStructureOnMorphisms( cat, alpha, beta ) ), HomomorphismStructureOnObjects( cat, Source( alpha ), target ) )", # alpha is a PreCompose, so we lose the correct source here, which previously was part of SumOfMorphisms
>     )
> );
gap> # HomomorphismStructureOnMorphisms in the underlying category is compatible with the composition
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "beta", "gamma", "delta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, PreCompose( cat, alpha, beta ), PreCompose( cat, gamma, delta ) )",
>         dst_template := "PreCompose( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, beta, gamma ), HomomorphismStructureOnMorphisms( cat, alpha, delta ) )",
>     )
> );
gap> # Source of entries of a morphism matrix
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Source( MorphismMatrix( alpha )[i][j] )",
>         dst_template := "ObjectList( Source( alpha ) )[i]",
>     )
> );
gap> # Range of entries of a morphism matrix
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Range( MorphismMatrix( alpha )[i][j] )",
>         dst_template := "ObjectList( Range( alpha ) )[j]",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms is compatible with addition in the first component
gap> StateNextLemma( );


Lemma 6:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, the homomorphism structue is additive in the first\
 component:
For four objects A, B, C, and D and three morphisms alpha_1 : A → B, alpha_2\
 : A → B, and beta : C → D we have
function ( cat, A, B, C, D, alpha_1, alpha_2, beta )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat 
         ), AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat )
          , HomomorphismStructureOnMorphisms( cat, alpha_1, beta ), 
         HomomorphismStructureOnMorphisms( cat, alpha_2, beta ) ), 
       HomomorphismStructureOnMorphisms( cat, 
         AdditionForMorphisms( cat, alpha_1, alpha_2 ), beta ) );
end
gap> # adding morphisms between direct sums can be done componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
>         new_funcs := [ [ "a" ], [ "b" ] ],
>     )
> );
gap> # equality of morphisms between direct sums can be checked componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
>         new_funcs := [ [ "s" ], [ "t" ] ],
>     )
> );
gap> # adding morphisms between direct sums can be done componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
>         new_funcs := [ [ "a" ], [ "b" ] ],
>     )
> );
gap> # equality of morphisms between direct sums can be checked componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
>         new_funcs := [ [ "s" ], [ "t" ] ],
>     )
> );
gap> # HomomorphismStructureOnMorphisms in the underlying category is additive in the first component
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha_1", "alpha_2", "beta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, AdditionForMorphisms( cat, alpha_1, alpha_2 ), beta )",
>         dst_template := "AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha_1, beta ), HomomorphismStructureOnMorphisms( cat, alpha_2, beta ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms is compatible with addition in the second component
gap> StateNextLemma( );


Lemma 7:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, the homomorphism structure is additive in the seco\
nd component:
For four objects A, B, C, and D and three morphisms alpha : A → B, beta_1 : \
C → D, and beta_2 : C → D we have
function ( cat, A, B, C, D, alpha, beta_1, beta_2 )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat 
         ), AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat )
          , HomomorphismStructureOnMorphisms( cat, alpha, beta_1 ), 
         HomomorphismStructureOnMorphisms( cat, alpha, beta_2 ) ), 
       HomomorphismStructureOnMorphisms( cat, alpha, 
         AdditionForMorphisms( cat, beta_1, beta_2 ) ) );
end
gap> # adding morphisms between direct sums can be done componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
>         new_funcs := [ [ "a" ], [ "b" ] ],
>     )
> );
gap> # equality of morphisms between direct sums can be checked componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
>         new_funcs := [ [ "s" ], [ "t" ] ],
>     )
> );
gap> # adding morphisms between direct sums can be done componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
>         new_funcs := [ [ "a" ], [ "b" ] ],
>     )
> );
gap> # equality of morphisms between direct sums can be checked componentwise
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
>         src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
>         dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
>         new_funcs := [ [ "s" ], [ "t" ] ],
>     )
> );
gap> # HomomorphismStructureOnMorphisms in the underlying category is additive in the second component
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "beta_1", "beta_2" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, alpha, AdditionForMorphisms( cat, beta_1, beta_2 ) )",
>         dst_template := "AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha, beta_1 ), HomomorphismStructureOnMorphisms( cat, alpha, beta_2 ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure well-defined
gap> StateNextLemma( );


Lemma 8:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, interpreting a morphism as a morphism from the dis\
tinguished object defines a morphism in the range category of the homomorphism\
 structure:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( 
       RangeCategoryOfHomomorphismStructure( cat ), 
       DistinguishedObjectOfHomomorphismStructure( cat ), 
       InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructu\
re( cat, alpha ), HomomorphismStructureOnObjects( cat, A, B ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( 
       RangeCategoryOfHomomorphismStructure( cat_1 ), 
       DistinguishedObjectOfHomomorphismStructure( 
         UnderlyingCategory( cat_1 ) ), UniversalMorphismIntoDirectSum( 
         RangeCategoryOfHomomorphismStructure( cat_1 ), 
         List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( j_2 )
                return 
                 DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 ), 
                   List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                     function ( s_3 )
                          return HomomorphismStructureOnObjects( 
                             UnderlyingCategory( cat_1 ), 
                             ObjectList( A_1 )[j_2], ObjectList( B_1 )[s_3] );
                      end ) );
            end ), DistinguishedObjectOfHomomorphismStructure( 
           UnderlyingCategory( cat_1 ) ), 
         List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( j_2 )
                return UniversalMorphismIntoDirectSum( 
                   RangeCategoryOfHomomorphismStructure( cat_1 ), 
                   List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                     function ( s_3 )
                          return HomomorphismStructureOnObjects( 
                             UnderlyingCategory( cat_1 ), 
                             ObjectList( A_1 )[j_2], ObjectList( B_1 )[s_3] );
                      end ), DistinguishedObjectOfHomomorphismStructure( 
                     UnderlyingCategory( cat_1 ) ), 
                   List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                     function ( s_3 )
                          return 
                           InterpretMorphismAsMorphismFromDistinguishedObjectT\
oHomomorphismStructure( UnderlyingCategory( cat_1 ), 
                             MorphismMatrix( alpha_1 )[j_2][s_3] );
                      end ) );
            end ) ), DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 )
          , List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( j_2 )
                return 
                 DirectSum( RangeCategoryOfHomomorphismStructure( cat_1 ), 
                   List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                     function ( s_3 )
                          return HomomorphismStructureOnObjects( 
                             UnderlyingCategory( cat_1 ), 
                             ObjectList( A_1 )[j_2], ObjectList( B_1 )[s_3] );
                      end ) );
            end ) ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism well-defined
gap> StateNextLemma( );


Lemma 9:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, reinterpreting a morphism from the distinguished m\
orphism as a usual morphism defines a morphism:
For two objects A and B and a morphism alpha : DistinguishedObjectOfHomomorphi\
smStructure( cat ) → HomomorphismStructureOnObjects( cat, A, B ) in the rang\
e category of the homomorphism structure we have
function ( cat, A, B, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, 
       InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphi\
sm( cat, A, B, alpha ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    if
     not IsList( List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( j_2 )
                   return List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                      function ( s_3 )
                           return 
                            InterpretMorphismFromDistinguishedObjectToHomomorp\
hismStructureAsMorphism( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[j_2], 
                              ObjectList( B_1 )[s_3], 
                              ComponentOfMorphismIntoDirectSum( 
                                RangeCategoryOfHomomorphismStructure( cat_1 )
                                 , ComponentOfMorphismIntoDirectSum( 
                                  RangeCategoryOfHomomorphismStructure( cat_1 
                                    ), alpha_1, 
                                  List( [ 1 .. Length( ObjectList( A_1 ) ) ], 
                                    function ( j_4 )
                                         return 
                                          DirectSum( 
                                            RangeCategoryOfHomomorphismStructu\
re( cat_1 ), List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( s_5 )
                                                   return 
                                                    HomomorphismStructureOnObj\
ects( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[j_4], 
                                                      ObjectList( B_1 )[s_5] )
                                                    ;
                                               end ) );
                                     end ), j_2 ), 
                                List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                                  function ( s_4 )
                                       return HomomorphismStructureOnObjects( 
                                          UnderlyingCategory( cat_1 ), 
                                          ObjectList( A_1 )[j_2], 
                                          ObjectList( B_1 )[s_4] );
                                   end ), s_3 ) );
                       end );
               end ) ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                 return 
                  IsList( List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                      function ( s_3 )
                           return 
                            InterpretMorphismFromDistinguishedObjectToHomomorp\
hismStructureAsMorphism( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[i_2], 
                              ObjectList( B_1 )[s_3], 
                              ComponentOfMorphismIntoDirectSum( 
                                RangeCategoryOfHomomorphismStructure( cat_1 )
                                 , ComponentOfMorphismIntoDirectSum( 
                                  RangeCategoryOfHomomorphismStructure( cat_1 
                                    ), alpha_1, 
                                  List( [ 1 .. Length( ObjectList( A_1 ) ) ], 
                                    function ( j_4 )
                                         return 
                                          DirectSum( 
                                            RangeCategoryOfHomomorphismStructu\
re( cat_1 ), List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( s_5 )
                                                   return 
                                                    HomomorphismStructureOnObj\
ects( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[j_4], 
                                                      ObjectList( B_1 )[s_5] )
                                                    ;
                                               end ) );
                                     end ), i_2 ), 
                                List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                                  function ( s_4 )
                                       return HomomorphismStructureOnObjects( 
                                          UnderlyingCategory( cat_1 ), 
                                          ObjectList( A_1 )[i_2], 
                                          ObjectList( B_1 )[s_4] );
                                   end ), s_3 ) );
                       end ) );
             end ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                 return ForAll( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                    function ( j_3 )
                         return 
                          IsWellDefinedForMorphismsWithGivenSourceAndRange( 
                            UnderlyingCategory( cat_1 ), 
                            ObjectList( A_1 )[i_2], 
                            InterpretMorphismFromDistinguishedObjectToHomomorp\
hismStructureAsMorphism( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[i_2], 
                              ObjectList( B_1 )[j_3], 
                              ComponentOfMorphismIntoDirectSum( 
                                RangeCategoryOfHomomorphismStructure( cat_1 )
                                 , ComponentOfMorphismIntoDirectSum( 
                                  RangeCategoryOfHomomorphismStructure( cat_1 
                                    ), alpha_1, 
                                  List( [ 1 .. Length( ObjectList( A_1 ) ) ], 
                                    function ( j_4 )
                                         return 
                                          DirectSum( 
                                            RangeCategoryOfHomomorphismStructu\
re( cat_1 ), List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( s_5 )
                                                   return 
                                                    HomomorphismStructureOnObj\
ects( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[j_4], 
                                                      ObjectList( B_1 )[s_5] )
                                                    ;
                                               end ) );
                                     end ), i_2 ), 
                                List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                                  function ( s_4 )
                                       return HomomorphismStructureOnObjects( 
                                          UnderlyingCategory( cat_1 ), 
                                          ObjectList( A_1 )[i_2], 
                                          ObjectList( B_1 )[s_4] );
                                   end ), j_3 ) ), ObjectList( B_1 )[j_3] );
                     end );
             end ) then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure is injective
gap> StateNextLemma( );


Lemma 10:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, interpreting morphisms as morphisms from the disti\
nguished object is an injective operation:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return 
     IsCongruentForMorphisms( cat, 
       InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphi\
sm( cat, A, B, 
         InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStruc\
ture( cat, alpha ) ), alpha );
end
gap> # ComponentOfMorphismIntoDirectSum of UniversalMorphismIntoDirectSum gives the original morphisms
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "cat", "list", "T", "list_of_morphisms", "i" ],
>         src_template := "ComponentOfMorphismIntoDirectSum( cat, UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms ), list, i )",
>         dst_template := "list_of_morphisms[i]",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    return ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
            return ForAll( [ 1 .. Length( ObjectList( B_1 ) ) ], 
               function ( j_3 )
                    return 
                     IsCongruentForMorphisms( UnderlyingCategory( cat_1 ), 
                       InterpretMorphismFromDistinguishedObjectToHomomorphismS\
tructureAsMorphism( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[i_2], 
                         ObjectList( B_1 )[j_3], 
                         InterpretMorphismAsMorphismFromDistinguishedObjectToH\
omomorphismStructure( UnderlyingCategory( cat_1 ), 
                           MorphismMatrix( alpha_1 )[i_2][j_3] ) ), 
                       MorphismMatrix( alpha_1 )[i_2][j_3] );
                end );
        end );
end
gap> # interpreting and reinterpreting in the underlying category gives the original morphism
> # CONDITION: only if alpha : A -> B
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryMorphism ],
>         src_template := "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha ) )",
>         dst_template := "alpha",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure is surjective
gap> StateNextLemma( );


Lemma 11:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, interpreting morphisms as morphisms from the disti\
nguished object is a surjective operation:
For two objects S and T and a morphism alpha : DistinguishedObjectOfHomomorphi\
smStructure( cat ) → HomomorphismStructureOnObjects( cat, S, T ) in the rang\
e category of the homomorphism structure we have
function ( cat, S, T, alpha )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat 
         ), 
       InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructu\
re( cat, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorp\
hism( cat, S, T, alpha ) ), alpha );
end
gap> # interpreting and reinterpreting in the underlying category gives the original morphism
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryMorphism ],
>         src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, alpha ) )",
>         dst_template := "alpha",
>     )
> );
gap> # UniversalMorphismIntoDirectSum of ComponentOfMorphismIntoDirectSum gives the original morphism
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "cat", "list", "list2", "T", "alpha" ],
>         src_template := "UniversalMorphismIntoDirectSum( cat, list, T, List( list2, i -> ComponentOfMorphismIntoDirectSum( cat, alpha, list, i ) ) )",
>         dst_template := "alpha",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# naturality of InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure
gap> StateNextLemma( );


Lemma 12:
In the additive closure of a pre-additive category with a homomorphism structu\
re in an additive category, interpreting morphisms as morphisms from the disti\
nguished object is a natural transformation:
For four objects A, B, C, and D and three morphisms alpha : A → B, xi : B → C,\
and beta : C → D we have
function ( cat, A, B, C, D, alpha, xi, beta )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat 
         ), 
       InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructu\
re( cat, PreComposeList( cat, A, [ alpha, xi, beta ], D ) ), 
       PreCompose( RangeCategoryOfHomomorphismStructure( cat ), 
         InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStruc\
ture( cat, xi ), HomomorphismStructureOnMorphisms( cat, alpha, beta ) ) );
end
gap> # degenerate version of MorphismBetweenDirectSums ⋅ MorphismBetweenDirectSums
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "cat", "T", "list1", "list2", "list_of_morphisms", "matrix" ],
>         src_template := "PreCompose( cat, UniversalMorphismIntoDirectSum( cat, list1, T, list_of_morphisms ), MorphismBetweenDirectSums( cat, list1, matrix, list2 ) )",
>         dst_template := "UniversalMorphismIntoDirectSum( cat, list2, T, List( [ 1 .. Length( list2 ) ], j -> SumOfMorphisms( cat, T, List( [ 1 .. Length( list1 ) ], k -> PreCompose( cat, list_of_morphisms[k], matrix[k][j] ) ), list2[j] ) ) )",
>         new_funcs := [ [ "j" ], [ "k" ] ],
>     )
> );
gap> # degenerate version of MorphismBetweenDirectSums = MorphismBetweenDirectSums
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list", "T", "list_of_morphisms_1", "list_of_morphisms_2" ],
>         src_template := "IsCongruentForMorphisms( cat, UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_1 ), UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_2 ) )",
>         dst_template := "ForAll( [ 1 .. Length( list ) ], s -> IsCongruentForMorphisms( cat, list_of_morphisms_1[s], list_of_morphisms_2[s] ) )",
>         new_funcs := [ [ "s" ] ],
>     )
> );
gap> # degenerate version of SumOfMorphisms( MorphismBetweenDirectSums )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "T", "list2", "list3", "list_of_morphisms" ],
>         src_template := "SumOfMorphisms( cat, source, List( list3, k -> UniversalMorphismIntoDirectSum( cat, list2, T, list_of_morphisms ) ), target )",
>         dst_template := "UniversalMorphismIntoDirectSum( cat, list2, T, List( [ 1 .. Length( list2 ) ], b -> SumOfMorphisms( cat, T, List( list3, k -> list_of_morphisms[b] ), list2[b] ) ) )",
>         new_funcs := [ [ "b" ] ],
>     )
> );
gap> # degenerate version of MorphismBetweenDirectSums = MorphismBetweenDirectSums
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "list", "T", "list_of_morphisms_1", "list_of_morphisms_2" ],
>         src_template := "IsCongruentForMorphisms( cat, UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_1 ), UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_2 ) )",
>         dst_template := "ForAll( [ 1 .. Length( list ) ], s -> IsCongruentForMorphisms( cat, list_of_morphisms_1[s], list_of_morphisms_2[s] ) )",
>         new_funcs := [ [ "s" ] ],
>     )
> );
gap> # pull composition into the case distinction
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "P", "beta_1", "beta_2" ],
>         src_template := "PreCompose( cat, CAP_JIT_INTERNAL_EXPR_CASE( P, beta_1, true, beta_2 ), alpha )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, PreCompose( cat, beta_1, alpha ), true, PreCompose( cat, beta_2, alpha ) )",
>     )
> );
gap> # composition with the identity
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "B" ],
>         src_template := "PreCompose( cat, IdentityMorphism( cat, B ), alpha )",
>         dst_template := "alpha",
>     )
> );
gap> # composition with zero
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "B_1", "B_2" ],
>         src_template := "PreCompose( cat, ZeroMorphism( cat, B_1, B_2 ), alpha )",
>         dst_template := "ZeroMorphism( cat, B_1, Range( alpha ) )",
>     )
> );
gap> # Range of entries of a morphism matrix
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Range( MorphismMatrix( alpha )[i][j] )",
>         dst_template := "ObjectList( Range( alpha ) )[j]",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, C_1, D_1, alpha_1, xi_1, beta_1 )
    return ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], 
       function ( logic_new_func_s_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1 ) ) ], 
               function ( logic_new_func_s_3 )
                    return 
                     IsCongruentForMorphisms( 
                       RangeCategoryOfHomomorphismStructure( cat_1 ), 
                       InterpretMorphismAsMorphismFromDistinguishedObjectToHom\
omorphismStructure( UnderlyingCategory( cat_1 ), 
                         SumOfMorphisms( UnderlyingCategory( cat_1 ), 
                           ObjectList( A_1 )[logic_new_func_s_2], 
                           List( [ 1 .. Length( ObjectList( D_1 ) ) ], 
                             function ( k_4 )
                                  return 
                                   PreCompose( UnderlyingCategory( cat_1 ), 
                                     SumOfMorphisms( 
                                       UnderlyingCategory( cat_1 ), 
                                       ObjectList( A_1 )[logic_new_func_s_2], 
                                       List( 
                                         [ 1 .. Length( ObjectList( C_1 ) ) ]
                                          , function ( k_5 )
                                              return 
                                               PreCompose( 
                                                 UnderlyingCategory( cat_1 ), 
                                                 SumOfMorphisms( 
                                                   UnderlyingCategory( cat_1 )
                                                    , 
                                                   ObjectList( A_1 )
                                                      [logic_new_func_s_2], 
                                                   List( 
                                                     [ 1 .. 
                                                        Length( 
                                                           ObjectList( B_1 ) 
                                                           ) ], 
                                                     function ( k_6 )
                                                          return 
                                                           PreCompose( 
                                                             UnderlyingCategor\
y( cat_1 ), SumOfMorphisms( UnderlyingCategory( cat_1 ), ObjectList( A_1 )
                                                                  [logic_new_f\
unc_s_2], List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( k_7 )
                                                                      if
                                                                       logic_n\
ew_func_s_2 = k_7 then
                                                                          retu\
rn MorphismMatrix( alpha_1 )[k_7][k_6];
                                                                      else
                                                                          retu\
rn ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[logic_new_func\
_s_2], ObjectList( B_1 )[k_6] );
                                                                      fi;
                                                                      return;
                                                                  end ), 
                                                               ObjectList( 
                                                                   B_1 )[k_6] 
                                                               ), 
                                                             MorphismMatrix( 
                                                                   xi_1 )[k_6]
                                                                [k_5] );
                                                      end ), 
                                                   ObjectList( C_1 )[k_5] ), 
                                                 MorphismMatrix( beta_1 )[k_5]
                                                    [k_4] );
                                          end ), ObjectList( D_1 )[k_4] ), 
                                     CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                                              if k_4 = logic_new_func_s_3 then
                                                  return 
                                                   IdentityMorphism( 
                                                     UnderlyingCategory( 
                                                       cat_1 ), 
                                                     ObjectList( D_1 )[k_4] );
                                              else
                                                  return 
                                                   ZeroMorphism( 
                                                     UnderlyingCategory( 
                                                       cat_1 ), 
                                                     ObjectList( D_1 )[k_4], 
                                                     ObjectList( D_1 )
                                                        [logic_new_func_s_3] )
                                                   ;
                                              fi;
                                              return;
                                          end )(  ) );
                              end ), ObjectList( D_1 )[logic_new_func_s_3] ) )
                        , 
                       SumOfMorphisms( RangeCategoryOfHomomorphismStructure( 
                           cat_1 ), 
                         DistinguishedObjectOfHomomorphismStructure( 
                           UnderlyingCategory( cat_1 ) ), 
                         List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                           function ( logic_new_func_k_4 )
                                return 
                                 SumOfMorphisms( 
                                   RangeCategoryOfHomomorphismStructure( 
                                     cat_1 ), 
                                   DistinguishedObjectOfHomomorphismStructure
                                      ( UnderlyingCategory( cat_1 ) ), 
                                   List( [ 1 .. Length( ObjectList( C_1 ) ) ]
                                      , function ( logic_new_func_k_5 )
                                          return 
                                           PreCompose( 
                                             RangeCategoryOfHomomorphismStruct\
ure( cat_1 ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphism\
Structure( UnderlyingCategory( cat_1 ), MorphismMatrix( xi_1 )
                                                    [logic_new_func_k_4]
                                                  [logic_new_func_k_5] ), 
                                             HomomorphismStructureOnMorphisms
                                                ( UnderlyingCategory( cat_1 )
                                                , 
                                               MorphismMatrix( alpha_1 )
                                                    [logic_new_func_s_2]
                                                  [logic_new_func_k_4], 
                                               MorphismMatrix( beta_1 )
                                                    [logic_new_func_k_5]
                                                  [logic_new_func_s_3] ) );
                                      end ), HomomorphismStructureOnObjects( 
                                     UnderlyingCategory( cat_1 ), 
                                     ObjectList( A_1 )[logic_new_func_s_2], 
                                     ObjectList( D_1 )[logic_new_func_s_3] ) )
                                 ;
                            end ), HomomorphismStructureOnObjects( 
                           UnderlyingCategory( cat_1 ), 
                           ObjectList( A_1 )[logic_new_func_s_2], 
                           ObjectList( D_1 )[logic_new_func_s_3] ) ) );
                end );
        end );
end
gap> # drop zero morphisms in sums of morphisms
> # CONDITION: only if `i in [ 1 .. l ]`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "l", "i", "alpha", "B_1", "B_2" ],
>         src_template := "SumOfMorphisms( cat, B_1, List( [ 1 .. l ], k -> CAP_JIT_INTERNAL_EXPR_CASE( i = k, alpha, true, ZeroMorphism( cat, B_1, B_2 ) ) ), B_2 )",
>         dst_template := "(k -> alpha)(i)",
>     )
> );
gap> # pull composition into case distinction
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "index1", "index2", "value_if_equal", "value_if_not_equal" ],
>         src_template := "PreCompose( cat, alpha, CAP_JIT_INTERNAL_EXPR_CASE( index1 = index2, value_if_equal, true, value_if_not_equal ) )",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( index1 = index2, PreCompose( cat, alpha, value_if_equal ), true, PreCompose( cat, alpha, value_if_not_equal ) )",
>     )
> );
gap> # composition with the identity
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "object" ],
>         src_template := "PreCompose( cat, alpha, IdentityMorphism( cat, object ) )",
>         dst_template := "alpha",
>     )
> );
gap> # composition with zero
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "object1", "object2" ],
>         src_template := "PreCompose( cat, alpha, ZeroMorphism( cat, object1, object2 ) )",
>         dst_template := "ZeroMorphism( cat, Source( alpha ), object2 )",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, C_1, D_1, alpha_1, xi_1, beta_1 )
    return ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], 
       function ( logic_new_func_s_2 )
            return ForAll( [ 1 .. Length( ObjectList( D_1 ) ) ], 
               function ( logic_new_func_s_3 )
                    return 
                     IsCongruentForMorphisms( 
                       RangeCategoryOfHomomorphismStructure( cat_1 ), 
                       InterpretMorphismAsMorphismFromDistinguishedObjectToHom\
omorphismStructure( UnderlyingCategory( cat_1 ), 
                         SumOfMorphisms( UnderlyingCategory( cat_1 ), 
                           ObjectList( A_1 )[logic_new_func_s_2], 
                           List( [ 1 .. Length( ObjectList( D_1 ) ) ], 
                             function ( k_4 )
                                  if k_4 = logic_new_func_s_3 then
                                      return 
                                       SumOfMorphisms( 
                                         UnderlyingCategory( cat_1 ), 
                                         ObjectList( A_1 )[logic_new_func_s_2]
                                          , 
                                         List( 
                                           [ 1 .. Length( ObjectList( C_1 ) ) 
                                             ], function ( k_5 )
                                                return 
                                                 PreCompose( 
                                                   UnderlyingCategory( cat_1 )
                                                    , 
                                                   SumOfMorphisms( 
                                                     UnderlyingCategory( 
                                                       cat_1 ), 
                                                     ObjectList( A_1 )
                                                        [logic_new_func_s_2], 
                                                     List( 
                                                       [ 1 .. 
                                                          Length( 
                                                             ObjectList( B_1 
                                                               ) ) ], 
                                                       function ( k_6 )
                                                            return 
                                                             PreCompose( 
                                                               UnderlyingCateg\
ory( cat_1 ), MorphismMatrix( alpha_1 )[logic_new_func_s_2][k_6], 
                                                               MorphismMatrix
                                                                      ( xi_1 )
                                                                    [k_6][k_5
                                                                 ] );
                                                        end ), 
                                                     ObjectList( C_1 )[k_5] )
                                                    , 
                                                   MorphismMatrix( beta_1 )
                                                        [k_5][k_4] );
                                            end ), ObjectList( D_1 )[k_4] );
                                  else
                                      return 
                                       ZeroMorphism( 
                                         UnderlyingCategory( cat_1 ), 
                                         ObjectList( A_1 )[logic_new_func_s_2]
                                          , 
                                         ObjectList( D_1 )[logic_new_func_s_3
                                           ] );
                                  fi;
                                  return;
                              end ), ObjectList( D_1 )[logic_new_func_s_3] ) )
                        , 
                       SumOfMorphisms( RangeCategoryOfHomomorphismStructure( 
                           cat_1 ), 
                         DistinguishedObjectOfHomomorphismStructure( 
                           UnderlyingCategory( cat_1 ) ), 
                         List( [ 1 .. Length( ObjectList( B_1 ) ) ], 
                           function ( logic_new_func_k_4 )
                                return 
                                 SumOfMorphisms( 
                                   RangeCategoryOfHomomorphismStructure( 
                                     cat_1 ), 
                                   DistinguishedObjectOfHomomorphismStructure
                                      ( UnderlyingCategory( cat_1 ) ), 
                                   List( [ 1 .. Length( ObjectList( C_1 ) ) ]
                                      , function ( logic_new_func_k_5 )
                                          return 
                                           PreCompose( 
                                             RangeCategoryOfHomomorphismStruct\
ure( cat_1 ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphism\
Structure( UnderlyingCategory( cat_1 ), MorphismMatrix( xi_1 )
                                                    [logic_new_func_k_4]
                                                  [logic_new_func_k_5] ), 
                                             HomomorphismStructureOnMorphisms
                                                ( UnderlyingCategory( cat_1 )
                                                , 
                                               MorphismMatrix( alpha_1 )
                                                    [logic_new_func_s_2]
                                                  [logic_new_func_k_4], 
                                               MorphismMatrix( beta_1 )
                                                    [logic_new_func_k_5]
                                                  [logic_new_func_s_3] ) );
                                      end ), HomomorphismStructureOnObjects( 
                                     UnderlyingCategory( cat_1 ), 
                                     ObjectList( A_1 )[logic_new_func_s_2], 
                                     ObjectList( D_1 )[logic_new_func_s_3] ) )
                                 ;
                            end ), HomomorphismStructureOnObjects( 
                           UnderlyingCategory( cat_1 ), 
                           ObjectList( A_1 )[logic_new_func_s_2], 
                           ObjectList( D_1 )[logic_new_func_s_3] ) ) );
                end );
        end );
end
gap> # drop zero morphisms in sums of morphisms
> # CONDITION: only if `i in [ 1 .. l ]`
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "l", "i", "alpha", "B_1", "B_2" ],
>         src_template := "SumOfMorphisms( cat, B_1, List( [ 1 .. l ], k -> CAP_JIT_INTERNAL_EXPR_CASE( k = i, alpha, true, ZeroMorphism( cat, B_1, B_2 ) ) ), B_2 )",
>         dst_template := "(k -> alpha)(i)",
>     )
> );
gap> # interpretation in the underlying category is additive
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "list", "target" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsList, IsDummyCategoryObject ],
>         src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, SumOfMorphisms( cat, source, list, target ) )",
>         dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ), List( [ 1 .. Length( list ) ], x -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, list[x] ) ), HomomorphismStructureOnObjects( cat, source, target ) )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> # composition is additive in the first component
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "list", "target", "mor" ],
>         src_template := "PreCompose( cat, SumOfMorphisms( cat, source, list, target ), mor )",
>         dst_template := "SumOfMorphisms( cat, source, List( [ 1 .. Length( list ) ], x -> PreCompose( cat, list[x], mor ) ), Range( mor ) )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> # interpretation in the underlying category is additive
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "list", "target" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsList, IsDummyCategoryObject ],
>         src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, SumOfMorphisms( cat, source, list, target ) )",
>         dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ), List( [ 1 .. Length( list ) ], x -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, list[x] ) ), HomomorphismStructureOnObjects( cat, source, target ) )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> # interpretation in the underlying category is a natural transformation
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "xi", "beta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, PreCompose( cat, PreCompose( cat, alpha, xi ), beta ) )",
>         dst_template := "PreCompose( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, xi ), HomomorphismStructureOnMorphisms( cat, alpha, beta ) )",
>     )
> );
gap> # Range of entries of a morphism matrix
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Range( MorphismMatrix( alpha )[i][j] )",
>         dst_template := "ObjectList( Range( alpha ) )[j]",
>     )
> );
gap> # swap sums
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "m", "n", "alpha", "A", "B" ],
>         src_template := "SumOfMorphisms( cat, A, List( [ 1 .. m ], i -> SumOfMorphisms( cat, A, List( [ 1 .. n ], j -> alpha ), B ) ), B )",
>         dst_template := "SumOfMorphisms( cat, A, List( [ 1 .. n ], j -> SumOfMorphisms( cat, A, List( [ 1 .. m ], i -> alpha ), B ) ), B )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

#
gap> AssertProposition( );


Summing up, we have shown:
The additive closure of a pre-additive category with a homomorphism structure \
in an additive category is equipped with a homomorphism structure. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> STOP_TEST( "proof_AdditiveClosure_hom_structure" );
