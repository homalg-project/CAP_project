gap> START_TEST( "proof_hom_structure_for_linear_categories" );

# avoid wrapping the output
gap> old_screen_width := SizeScreen( )[1];;
gap> SizeScreen( [ 4096 ] );;

#
gap> LoadPackage( "FreydCategoriesForCAP", false );
true

#
gap> k := DummyCommutativeRing( );;

# CategoryOfRows expects a *homalg* ring
gap> SetFilterObj( k, IsHomalgRing );
gap> k!.RingFilter := IsHomalgRing;;
gap> k!.RingElementFilter := IsHomalgRingElement;;

#
gap> dummy := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "IsWellDefinedForObjects",
>         "IsWellDefinedForMorphismsWithGivenSourceAndRange",
>         "IsEqualForObjects",
>         "IsCongruentForMorphisms",
>         "IdentityMorphism",
>         "PreComposeList",
>         "AdditionForMorphisms",
>         "LinearCombinationOfMorphisms",
>     ],
>     properties := [
>         "IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms",
>         "IsEquippedWithHomomorphismStructure",
>     ],
>     commutative_ring_of_linear_category := k
> ) : FinalizeCategory := false );;
gap> SetRangeCategoryOfHomomorphismStructure( dummy, CategoryOfRows( k ) );
gap> AddBasisOfExternalHom( dummy, function ( cat, a, b )
>     
>     Error( "this is a dummy category without actual implementation" );
>     
> end );
gap> AddCoefficientsOfMorphism( dummy, function ( cat, alpha )
>     
>     Error( "this is a dummy category without actual implementation" );
>     
> end );
gap> Finalize( dummy );;

# set a human readable name
gap> dummy!.Name := "any linear category with finitely generated free external homs";;

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> CapJitEnableProofAssistantMode( );

#
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

#
gap> Assert( 0, CanCompute( dummy, "DistinguishedObjectOfHomomorphismStructure" ) );
gap> Assert( 0, CanCompute( dummy, "HomomorphismStructureOnObjects" ) );
gap> Assert( 0, CanCompute( dummy, "HomomorphismStructureOnMorphisms" ) );
gap> Assert( 0, CanCompute( dummy, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) );
gap> Assert( 0, CanCompute( dummy, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) );

#
gap> StateProposition( dummy, "is_equipped_with_hom_structure" );;
Proposition:
Any linear category with finitely generated free external homs is equipped with a homomorphism structure.

# DistinguishedObjectOfHomomorphismStructure is well-defined
gap> StateNextLemma( );


Lemma 1:
In any linear category with finitely generated free external homs, the distinguished object is an object in the range category of the homomorphism structure:
We have
function ( cat )
    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1 )
    if not IsInt( 1 ) then
        return false;
    elif not 1 >= 0 then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ ],
>         src_template := "1 >= 0",
>         dst_template := "true",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnObjects is well-defined
gap> StateNextLemma( );


Lemma 2:
In any linear category with finitely generated free external homs, the homomorphism structure on objects defines an object in the range category of the homomorphism structure:
For two objects A and B we have
function ( cat, A, B )
    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1 )
    if not IsInt( Length( BasisOfExternalHom( cat_1, A_1, B_1 ) ) ) then
        return false;
    elif not Length( BasisOfExternalHom( cat_1, A_1, B_1 ) ) >= 0 then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list" ],
>         variable_filters := [ IsList ],
>         src_template := "Length( list ) >= 0",
>         dst_template := "true",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms is well-defined
gap> StateNextLemma( );


Lemma 3:
In any linear category with finitely generated free external homs, the homomorphism structure on morphisms defines a morphism in the range category of the homomorphism structure:
For four objects A, B, C, and D and two morphisms alpha : A → B and beta : C → D we have
function ( cat, A, B, C, D, alpha, beta )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, B, C ), HomomorphismStructureOnMorphisms( cat, alpha, beta ), HomomorphismStructureOnObjects( cat, A, D ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, C_1, D_1, alpha_1, beta_1 )
    if not IsHomalgMatrix( HomalgMatrixListList( List( BasisOfExternalHom( cat_1, B_1, C_1 ), function ( ell_2 )
                     return CoefficientsOfMorphism( cat_1, PreComposeList( cat_1, A_1, [ alpha_1, ell_2, beta_1 ], D_1 ) );
                 end ), Length( BasisOfExternalHom( cat_1, B_1, C_1 ) ), Length( BasisOfExternalHom( cat_1, A_1, D_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ) then
        return false;
    elif not NumberRows( HomalgMatrixListList( List( BasisOfExternalHom( cat_1, B_1, C_1 ), function ( ell_2 )
                       return CoefficientsOfMorphism( cat_1, PreComposeList( cat_1, A_1, [ alpha_1, ell_2, beta_1 ], D_1 ) );
                   end ), Length( BasisOfExternalHom( cat_1, B_1, C_1 ) ), Length( BasisOfExternalHom( cat_1, A_1, D_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ) = Length( BasisOfExternalHom( cat_1, B_1, C_1 ) ) then
        return false;
    elif not NumberColumns( HomalgMatrixListList( List( BasisOfExternalHom( cat_1, B_1, C_1 ), function ( ell_2 )
                       return CoefficientsOfMorphism( cat_1, PreComposeList( cat_1, A_1, [ alpha_1, ell_2, beta_1 ], D_1 ) );
                   end ), Length( BasisOfExternalHom( cat_1, B_1, C_1 ) ), Length( BasisOfExternalHom( cat_1, A_1, D_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ) = Length( BasisOfExternalHom( cat_1, A_1, D_1 ) ) then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "entries", "nr_rows", "nr_cols", "ring" ],
>         src_template := "NumberRows( HomalgMatrixListList( entries, nr_rows, nr_cols, ring ) )",
>         dst_template := "nr_rows",
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "entries", "nr_rows", "nr_cols", "ring" ],
>         src_template := "NumberColumns( HomalgMatrixListList( entries, nr_rows, nr_cols, ring ) )",
>         dst_template := "nr_cols",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms on identities
gap> StateNextLemma( );


Lemma 4:
In any linear category with finitely generated free external homs, the homomorphism structure preserves identities:
For two objects A and B we have
function ( cat, A, B )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), IdentityMorphism( cat, B ) ), IdentityMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) ) );
end
gap> # identites in PreComposeList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "mor", "B" ],
>         src_template := "PreComposeList( cat, A, [ IdentityMorphism( cat, A ), mor, IdentityMorphism( cat, B ) ], B )",
>         dst_template := "mor",
>     )
> );
gap> # equal to HomalgIdentityMatrix
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "matrix", "size", "ring" ],
>         src_template := "matrix = HomalgIdentityMatrix( size, ring )",
>         dst_template := "ForAll( [ 1 .. size ], i -> ForAll( [ 1 .. size ], j -> matrix[i, j] = CAP_JIT_INTERNAL_EXPR_CASE( i = j, One( ring ), true, Zero( ring ) ) ) )",
>         new_funcs := [ [ "i" ], [ "j" ] ],
>     )
> );
gap> # HomalgMatrixListList[i,j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_list", "nr_rows", "nr_cols", "ring", "i", "j" ],
>         src_template := "HomalgMatrixListList( list_list, nr_rows, nr_cols, ring )[i, j]",
>         dst_template := "list_list[i][j]",
>     )
> );
gap> # CoefficientsOfMorphism( BasisOfExternalHom[i] )[j]
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "i", "j" ],
>         src_template := "CoefficientsOfMorphism( cat, BasisOfExternalHom( cat, A, B )[i] )[j]",
>         dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i = j, One( CommutativeRingOfLinearCategory( cat ) ), true, Zero( CommutativeRingOfLinearCategory( cat ) ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms compatible with composition
gap> StateNextLemma( );


Lemma 5:
In any linear category with finitely generated free external homs, the homomorphism structure is compatible with composition:
For six objects A, B, C, D, E, and F and four morphisms alpha_1 : B → C, alpha_2 : A → B, beta_1 : D → E, and beta_2 : E → F we have
function ( cat, A, B, C, D, E, F, alpha_1, alpha_2, beta_1, beta_2 )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), PreCompose( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha_1, beta_1 ), HomomorphismStructureOnMorphisms( cat, alpha_2, beta_2 ) ), HomomorphismStructureOnMorphisms( cat, PreCompose( cat, alpha_2, alpha_1 ), PreCompose( cat, beta_1, beta_2 ) ) );
end
gap> # flatten PreComposeList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "C", "D", "alpha", "beta", "gamma", "delta", "epsilon" ],
>         src_template := "PreComposeList( cat, A, [ PreComposeList( cat, A, [ alpha, beta ], B ), gamma, PreComposeList( cat, C, [ delta, epsilon ], D ) ], D )",
>         dst_template := "PreComposeList( cat, A, [ alpha, beta, gamma, delta, epsilon ], D )",
>     )
> );
gap> # matrix multiplication for HomalgMatrixListList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_list1", "nr_rows1", "nr_cols1", "ring", "list_list2", "nr_cols2" ],
>         src_template := "HomalgMatrixListList( list_list1, nr_rows1, nr_cols1, ring ) * HomalgMatrixListList( list_list2, nr_cols1, nr_cols2, ring )",
>         dst_template := "HomalgMatrixListList( List( [ 1 .. nr_rows1 ], i -> List( [ 1 .. nr_cols2 ], j -> Sum( [ 1 .. nr_cols1 ], k -> list_list1[i][k] * list_list2[k][j] ) ) ) , nr_rows1, nr_cols2, ring )",
>         new_funcs := [ [ "i" ], [ "j" ], [ "k" ] ],
>     )
> );
gap> # equality for HomalgMatrixListList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
>         src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) = HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
>         dst_template := "list_list1 = list_list2",
>     )
> );
gap> # List( list1, func1 ) = List( list2, func2 )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list1", "func1", "list2", "func2" ],
>         variable_filters := [ IsList, IsFunction, IsList, IsFunction ],
>         src_template := "List( list1, func1 ) = List( list2, func2 )",
>         dst_template := "Length( list1 ) = Length( list2 ) and ForAll( [ 1 .. Length( list1 ) ], i -> func1( list1[i] ) = func2( list2[i] ) )",
>         new_funcs := [ [ "i" ] ],
>     )
> );
gap> # decide equality with CoefficientsOfMorphism by taking the linear combination with the corresponding basis
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "cat", "mor" ],
>         src_template := "list = CoefficientsOfMorphism( cat, mor )",
>         dst_template := """
>             Length( list ) = Length( BasisOfExternalHom( cat, Source( mor ), Range( mor ) ) ) and
>             IsCongruentForMorphisms( cat,
>                 LinearCombinationOfMorphisms( cat, Source( mor ), list, BasisOfExternalHom( cat, Source( mor ), Range( mor ) ), Range( mor ) ),
>                 mor
>             )
>         """,
>     )
> );
gap> # swap sums
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "list1", "list2", "value1", "value2", "list_of_morphisms", "target" ],
>         src_template := "LinearCombinationOfMorphisms( cat, source, List( list1, j -> Sum( list2, k -> value1 * value2 ) ), list_of_morphisms, target )",
>         dst_template := "LinearCombinationOfMorphisms( cat, source, List( list2, k -> value1 ), List( list2, k -> LinearCombinationOfMorphisms( cat, source, List( list1, j -> value2 ), list_of_morphisms, target ) ), target )",
>     )
> );
gap> # CoefficientsOfMorphism * BasisOfExternalHom
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
>         src_template := """
>             LinearCombinationOfMorphisms( cat,
>                 A,
>                 List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
>                 BasisOfExternalHom( cat, A, B ),
>                 B
>             )
>         """,
>         dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
>     )
> );
gap> # composition is linear
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "list", "alpha", "list2", "gamma", "coeffs" ],
>         src_template := "LinearCombinationOfMorphisms( cat, A, coeffs, List( list, k -> PreComposeList( cat, A, [ alpha, list2[k], gamma ], B ) ), B )",
>         dst_template := "PreComposeList( cat, A, [ alpha, LinearCombinationOfMorphisms( cat, Range( alpha ), coeffs, list2, Source( gamma ) ), gamma ], B )",
>     )
> );
gap> # CoefficientsOfMorphism * BasisOfExternalHom
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
>         src_template := """
>             LinearCombinationOfMorphisms( cat,
>                 A,
>                 List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
>                 BasisOfExternalHom( cat, A, B ),
>                 B
>             )
>         """,
>         dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
>     )
> );
gap> # flatten PreComposeList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "C", "D", "alpha", "beta", "gamma", "delta", "epsilon" ],
>         src_template := "PreComposeList( cat, A, [ alpha, PreComposeList( cat, B, [ beta, gamma, delta ], C ), epsilon ], D )",
>         dst_template := "PreComposeList( cat, A, [ alpha, beta, gamma, delta, epsilon ], D )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms additive in first component
gap> StateNextLemma( );


Lemma 6:
In any linear category with finitely generated free external homs, the homomorphism structue is additive in the first component:
For four objects A, B, C, and D and three morphisms alpha_1 : A → B, alpha_2 : A → B, and beta : C → D we have
function ( cat, A, B, C, D, alpha_1, alpha_2, beta )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha_1, beta ), HomomorphismStructureOnMorphisms( cat, alpha_2, beta ) ), HomomorphismStructureOnMorphisms( cat, AdditionForMorphisms( cat, alpha_1, alpha_2 ), beta ) );
end
gap> # matrix addition for HomalgMatrixListList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
>         src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) + HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
>         dst_template := "HomalgMatrixListList( List( [ 1 .. nr_rows ], i -> List( [ 1 .. nr_cols ], j -> list_list1[i][j] + list_list2[i][j] ) ), nr_rows, nr_cols, ring )",
>         new_funcs := [ [ "i" ], [ "j" ] ],
>     )
> );
gap> # CoefficientsOfMorphism is linear
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "j", "A", "B", "list1", "list2" ],
>         src_template := "CoefficientsOfMorphism( cat, PreComposeList( cat, A, list1, B ) )[j] + CoefficientsOfMorphism( cat, PreComposeList( cat, A, list2, B ) )[j]",
>         dst_template := "CoefficientsOfMorphism( cat, AdditionForMorphisms( cat, PreComposeList( cat, A, list1, B ), PreComposeList( cat, A, list2, B ) ) )[j]",
>     )
> );
gap> # PreComposeList is linear
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha_1", "alpha_2", "beta", "gamma" ],
>         src_template := "AdditionForMorphisms( cat, PreComposeList( cat, A, [ alpha_1, beta, gamma ], B ), PreComposeList( cat, A, [ alpha_2, beta, gamma ], B ) )",
>         dst_template := "PreComposeList( cat, A, [ AdditionForMorphisms( cat, alpha_1, alpha_2 ), beta, gamma ], B )",
>     )
> );
gap> # equality for HomalgMatrixListList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
>         src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) = HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
>         dst_template := "list_list1 = list_list2",
>     )
> );
gap> # List( list1, func1 ) = List( list2, func2 )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list1", "func1", "list2", "func2" ],
>         variable_filters := [ IsList, IsFunction, IsList, IsFunction ],
>         src_template := "List( list1, func1 ) = List( list2, func2 )",
>         dst_template := "Length( list1 ) = Length( list2 ) and ForAll( [ 1 .. Length( list1 ) ], i -> func1( list1[i] ) = func2( list2[i] ) )",
>         new_funcs := [ [ "i" ] ],
>     )
> );
gap> # decide equality with CoefficientsOfMorphism by taking the linear combination with the corresponding basis
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "cat", "mor" ],
>         src_template := "list = CoefficientsOfMorphism( cat, mor )",
>         dst_template := """
>             Length( list ) = Length( BasisOfExternalHom( cat, Source( mor ), Range( mor ) ) ) and
>             IsCongruentForMorphisms( cat,
>                 LinearCombinationOfMorphisms( cat, Source( mor ), list, BasisOfExternalHom( cat, Source( mor ), Range( mor ) ), Range( mor ) ),
>                 mor
>             )
>         """,
>     )
> );
gap> # CoefficientsOfMorphism * BasisOfExternalHom
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
>         src_template := """
>             LinearCombinationOfMorphisms( cat,
>                 A,
>                 List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
>                 BasisOfExternalHom( cat, A, B ),
>                 B
>             )
>         """,
>         dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms additive in second component
gap> StateNextLemma( );


Lemma 7:
In any linear category with finitely generated free external homs, the homomorphism structure is additive in the second component:
For four objects A, B, C, and D and three morphisms alpha : A → B, beta_1 : C → D, and beta_2 : C → D we have
function ( cat, A, B, C, D, alpha, beta_1, beta_2 )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha, beta_1 ), HomomorphismStructureOnMorphisms( cat, alpha, beta_2 ) ), HomomorphismStructureOnMorphisms( cat, alpha, AdditionForMorphisms( cat, beta_1, beta_2 ) ) );
end
gap> # matrix addition for HomalgMatrixListList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
>         src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) + HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
>         dst_template := "HomalgMatrixListList( List( [ 1 .. nr_rows ], i -> List( [ 1 .. nr_cols ], j -> list_list1[i][j] + list_list2[i][j] ) ) , nr_rows, nr_cols, ring )",
>         new_funcs := [ [ "i" ], [ "j" ] ],
>     )
> );
gap> # CoefficientsOfMorphism is linear
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "j", "A", "B", "list1", "list2" ],
>         src_template := "CoefficientsOfMorphism( cat, PreComposeList( cat, A, list1, B ) )[j] + CoefficientsOfMorphism( cat, PreComposeList( cat, A, list2, B ) )[j]",
>         dst_template := "CoefficientsOfMorphism( cat, AdditionForMorphisms( cat, PreComposeList( cat, A, list1, B ), PreComposeList( cat, A, list2, B ) ) )[j]",
>     )
> );
gap> # PreComposeList is linear
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha", "beta", "gamma_1", "gamma_2" ],
>         src_template := "AdditionForMorphisms( cat, PreComposeList( cat, A, [ alpha, beta, gamma_1 ], B ), PreComposeList( cat, A, [ alpha, beta, gamma_2 ], B ) )",
>         dst_template := "PreComposeList( cat, A, [ alpha, beta, AdditionForMorphisms( cat, gamma_1, gamma_2 ) ], B )",
>     )
> );
gap> # equality for HomalgMatrixListList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
>         src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) = HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
>         dst_template := "list_list1 = list_list2",
>     )
> );
gap> # List( list1, func1 ) = List( list2, func2 )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list1", "func1", "list2", "func2" ],
>         src_template := "List( list1, func1 ) = List( list2, func2 )",
>         dst_template := "Length( list1 ) = Length( list2 ) and ForAll( [ 1 .. Length( list1 ) ], i -> func1( list1[i] ) = func2( list2[i] ) )",
>         new_funcs := [ [ "i" ] ],
>     )
> );
gap> # decide equality of CoefficientsOfMorphism by taking the linear combination with the corresponding basis
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "cat", "mor" ],
>         src_template := "list = CoefficientsOfMorphism( cat, mor )",
>         dst_template := """
>             Length( list ) = Length( BasisOfExternalHom( cat, Source( mor ), Range( mor ) ) ) and
>             IsCongruentForMorphisms( cat,
>                 LinearCombinationOfMorphisms( cat, Source( mor ), list, BasisOfExternalHom( cat, Source( mor ), Range( mor ) ), Range( mor ) ),
>                 mor
>             )
>         """,
>     )
> );
gap> # CoefficientsOfMorphism * BasisOfExternalHom
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
>         src_template := """
>             LinearCombinationOfMorphisms( cat,
>                 A,
>                 List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
>                 BasisOfExternalHom( cat, A, B ),
>                 B
>             )
>         """,
>         dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure well-defined
gap> StateNextLemma( );


Lemma 8:
In any linear category with finitely generated free external homs, interpreting a morphism as a morphism from the distinguished object defines a morphism in the range category of the homomorphism structure:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha ), HomomorphismStructureOnObjects( cat, A, B ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    if not IsHomalgMatrix( HomalgRowVector( CoefficientsOfMorphism( cat_1, alpha_1 ), Length( BasisOfExternalHom( cat_1, A_1, B_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ) then
        return false;
    elif not NumberRows( HomalgRowVector( CoefficientsOfMorphism( cat_1, alpha_1 ), Length( BasisOfExternalHom( cat_1, A_1, B_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ) = 1 then
        return false;
    elif not NumberColumns( HomalgRowVector( CoefficientsOfMorphism( cat_1, alpha_1 ), Length( BasisOfExternalHom( cat_1, A_1, B_1 ) ), CommutativeRingOfLinearCategory( cat_1 ) ) ) = Length( BasisOfExternalHom( cat_1, A_1, B_1 ) ) then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "entries", "nr_cols", "ring" ],
>         src_template := "NumberRows( HomalgRowVector( entries, nr_cols, ring ) )",
>         dst_template := "1",
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "entries", "nr_cols", "ring" ],
>         src_template := "NumberColumns( HomalgRowVector( entries, nr_cols, ring ) )",
>         dst_template := "nr_cols",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism well-defined
gap> StateNextLemma( );


Lemma 9:
In any linear category with finitely generated free external homs, reinterpreting a morphism from the distinguished morphism as a usual morphism defines a morphism:
For two objects A and B and a morphism alpha : DistinguishedObjectOfHomomorphismStructure( cat ) → HomomorphismStructureOnObjects( cat, A, B ) in the range category of the homomorphism structure we have
function ( cat, A, B, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, alpha ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat_1, A_1, LinearCombinationOfMorphisms( cat_1, A_1, EntriesOfHomalgRowVector( UnderlyingMatrix( alpha_1 ) ), BasisOfExternalHom( cat_1, A_1, B_1 ), B_1 ), B_1 );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure injective
gap> StateNextLemma( );


Lemma 10:
In any linear category with finitely generated free external homs, interpreting morphisms as morphisms from the distinguished object is an injective operation:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha ) ), alpha );
end
gap> # EntriesOfHomalgRowVector( HomalgRowVector )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "entries", "nr_cols", "ring" ],
>         src_template := "EntriesOfHomalgRowVector( HomalgRowVector( entries, nr_cols, ring ) )",
>         dst_template := "entries",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    return IsCongruentForMorphisms( cat_1, LinearCombinationOfMorphisms( cat_1, A_1, CoefficientsOfMorphism( cat_1, alpha_1 ), BasisOfExternalHom( cat_1, A_1, B_1 ), B_1 ), alpha_1 );
end
gap> # linear combination with basis
> # CONDITION: only if alpha : A -> B
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha" ],
>         src_template := "LinearCombinationOfMorphisms( cat, A, CoefficientsOfMorphism( cat, alpha ), BasisOfExternalHom( cat, A, B ), B )",
>         dst_template := "alpha",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure surjective
gap> StateNextLemma( );


Lemma 11:
In any linear category with finitely generated free external homs, interpreting morphisms as morphisms from the distinguished object is a surjective operation:
For two objects S and T and a morphism alpha : DistinguishedObjectOfHomomorphismStructure( cat ) → HomomorphismStructureOnObjects( cat, S, T ) in the range category of the homomorphism structure we have
function ( cat, S, T, alpha )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, S, T, alpha ) ), alpha );
end
gap> # coefficients of a linear combination of a basis
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "coefficients" ],
>         src_template := "CoefficientsOfMorphism( cat, LinearCombinationOfMorphisms( cat, source, coefficients, BasisOfExternalHom( cat, source, target ), target ) )",
>         dst_template := "coefficients",
>     )
> );
gap> # HomalgRowVector( EntriesOfHomalgRowVector )
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "row_vector", "nr_cols", "ring" ],
>         src_template := "HomalgRowVector( EntriesOfHomalgRowVector( row_vector ), nr_cols, ring )",
>         dst_template := "row_vector",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# naturality of InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure
gap> StateNextLemma( );


Lemma 12:
In any linear category with finitely generated free external homs, interpreting morphisms as morphisms from the distinguished object is a natural transformation:
For four objects A, B, C, and D and three morphisms alpha : A → B, xi : B → C, and beta : C → D we have
function ( cat, A, B, C, D, alpha, xi, beta )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, PreComposeList( cat, A, [ alpha, xi, beta ], D ) ), PreCompose( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, xi ), HomomorphismStructureOnMorphisms( cat, alpha, beta ) ) );
end
gap> # matrix multiplication for HomalgRowVector and HomalgMatrixListList
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list1", "nr_cols1", "ring", "list_list2", "nr_cols2" ],
>         src_template := "HomalgRowVector( list1, nr_cols1, ring ) * HomalgMatrixListList( list_list2, nr_cols1, nr_cols2, ring )",
>         dst_template := "HomalgRowVector( List( [ 1 .. nr_cols2 ], j -> Sum( [ 1 .. nr_cols1 ], k -> list1[k] * list_list2[k][j] ) ), nr_cols2, ring )",
>         new_funcs := [ [ "j" ], [ "k" ] ],
>     )
> );
gap> # equality for HomalgRowVector
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list1", "nr_cols", "ring", "list2" ],
>         src_template := "HomalgRowVector( list1, nr_cols, ring ) = HomalgRowVector( list2, nr_cols, ring )",
>         dst_template := "list1 = list2",
>     )
> );
gap> # decide equality of CoefficientsOfMorphism by taking the linear combination with the corresponding basis (swapped arguments compared to the version above)
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "list", "cat", "mor" ],
>         src_template := "CoefficientsOfMorphism( cat, mor ) = list",
>         dst_template := """
>             Length( BasisOfExternalHom( cat, Source( mor ), Range( mor ) ) ) = Length( list ) and
>             IsCongruentForMorphisms( cat,
>                 mor,
>                 LinearCombinationOfMorphisms( cat, Source( mor ), list, BasisOfExternalHom( cat, Source( mor ), Range( mor ) ), Range( mor ) )
>             )
>         """,
>     )
> );
gap> # swap sums
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "list1", "list2", "value1", "value2", "list_of_morphisms", "target" ],
>         src_template := "LinearCombinationOfMorphisms( cat, source, List( list1, j -> Sum( list2, k -> value1 * value2 ) ), list_of_morphisms, target )",
>         dst_template := "LinearCombinationOfMorphisms( cat, source, List( list2, k -> value1 ), List( list2, k -> LinearCombinationOfMorphisms( cat, source, List( list1, j -> value2 ), list_of_morphisms, target ) ), target )",
>     )
> );
gap> # CoefficientsOfMorphism * BasisOfExternalHom
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
>         src_template := """
>             LinearCombinationOfMorphisms( cat,
>                 A,
>                 List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
>                 BasisOfExternalHom( cat, A, B ),
>                 B
>             )
>         """,
>         dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
>     )
> );
gap> # composition is linear
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "source", "list", "alpha", "list2", "gamma", "target", "coeffs" ],
>         src_template := "LinearCombinationOfMorphisms( cat, source, coeffs, List( list, k -> PreComposeList( cat, A, [ alpha, list2[k], gamma ], B ) ), target )",
>         dst_template := "PreComposeList( cat, A, [ alpha, LinearCombinationOfMorphisms( cat, Range( alpha ), coeffs, list2, Source( gamma ) ), gamma ], B )",
>     )
> );
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, C_1, D_1, alpha_1, xi_1, beta_1 )
    return IsCongruentForMorphisms( cat_1, PreComposeList( cat_1, A_1, [ alpha_1, xi_1, beta_1 ], D_1 ), PreComposeList( cat_1, A_1, [ alpha_1, LinearCombinationOfMorphisms( cat_1, B_1, List( [ 1 .. Length( BasisOfExternalHom( cat_1, B_1, C_1 ) ) ], function ( logic_new_func_k_2 )
                      return CoefficientsOfMorphism( cat_1, xi_1 )[logic_new_func_k_2];
                  end ), BasisOfExternalHom( cat_1, B_1, C_1 ), C_1 ), beta_1 ], D_1 ) );
end
gap> # CoefficientsOfMorphism * BasisOfExternalHom
> # CONDITION: only if mor : A -> B
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B", "mor" ],
>         src_template := """
>             LinearCombinationOfMorphisms( cat,
>                 A,
>                 List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, mor )[j] ),
>                 BasisOfExternalHom( cat, A, B ),
>                 B
>             )
>         """,
>         dst_template := "mor",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# all lemmata proven
gap> StateNextLemma( );


All lemmata are proven.

#
gap> AssertProposition( );


Summing up, we have shown:
Any linear category with finitely generated free external homs is equipped with a homomorphism structure. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> SizeScreen( [ old_screen_width ] );;

#
gap> STOP_TEST( "proof_hom_structure_for_linear_categories" );
