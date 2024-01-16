gap> START_TEST( "proof_AdditiveClosure_hom_structure" );

# avoid wrapping the output
gap> old_screen_width := SizeScreen( )[1];;
gap> SizeScreen( [ 4096 ] );;

#
gap> LoadPackage( "CAP", false );
true

#
gap> dummy_range := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "IsWellDefinedForObjects",
>         "IsWellDefinedForMorphismsWithGivenSourceAndRange",
>         "IsEqualForObjects",
>         "IsCongruentForMorphisms",
>         "PreCompose",
>         "IdentityMorphism",
>         "AdditionForMorphisms",
>     ],
>     properties := [
>         "IsAbCategory",
>     ],
> ) );;

#
gap> dummy := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "IsWellDefinedForObjects",
>         "IsWellDefinedForMorphismsWithGivenSourceAndRange",
>         "IsEqualForObjects",
>         "IsCongruentForMorphisms",
>         "PreCompose",
>         "IdentityMorphism",
>         "AdditionForMorphisms",
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
gap> cat := Opposite( dummy );;

# set a human readable name
gap> cat!.Name := "the opposite category of a category with a homomorphism structure";;

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
The opposite category of a category with a homomorphism structure is equipped with a homomorphism structure.

# DistinguishedObjectOfHomomorphismStructure is well-defined
gap> StateNextLemma( );


Lemma 1:
In the opposite category of a category with a homomorphism structure, the distinguished object is an object in the range category of the homomorphism structure:
We have
function ( cat )
    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1 )
    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat_1 ), DistinguishedObjectOfHomomorphismStructure( OppositeCategory( cat_1 ) ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnObjects is well-defined
gap> StateNextLemma( );


Lemma 2:
In the opposite category of a category with a homomorphism structure, the homomorphism structure on objects defines an object in the range category of the homomorphism structure:
For two objects A and B we have
function ( cat, A, B )
    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1 )
    return IsWellDefinedForObjects( RangeCategoryOfHomomorphismStructure( cat_1 ), HomomorphismStructureOnObjects( OppositeCategory( cat_1 ), Opposite( B_1 ), Opposite( A_1 ) ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms is well-defined
gap> StateNextLemma( );


Lemma 3:
In the opposite category of a category with a homomorphism structure, the homomorphism structure on morphisms defines a morphism in the range category of the homomorphism structure:
For four objects A, B, C, and D and two morphisms alpha : A → B and beta : C → D we have
function ( cat, A, B, C, D, alpha, beta )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, B, C ), HomomorphismStructureOnMorphisms( cat, alpha, beta ), HomomorphismStructureOnObjects( cat, A, D ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, C_1, D_1, alpha_1, beta_1 )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( RangeCategoryOfHomomorphismStructure( cat_1 ), HomomorphismStructureOnObjects( OppositeCategory( cat_1 ), Opposite( C_1 ), Opposite( B_1 ) ), HomomorphismStructureOnMorphisms( OppositeCategory( cat_1 ), Opposite( beta_1 ), Opposite( alpha_1 ) ), HomomorphismStructureOnObjects( OppositeCategory( cat_1 ), Opposite( D_1 ), Opposite( A_1 ) ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> # source and range of morphisms in the opposite category
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "alpha" ],
>         src_template := "Source( Opposite( alpha ) )",
>         dst_template := "Opposite( Range( alpha ) )",
>     )
> );
> ApplyLogicTemplateNTimes( 2,
>     rec(
>         variable_names := [ "alpha" ],
>         src_template := "Range( Opposite( alpha ) )",
>         dst_template := "Opposite( Source( alpha ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms preserves identities
gap> StateNextLemma( );


Lemma 4:
In the opposite category of a category with a homomorphism structure, the homomorphism structure preserves identities:
For two objects A and B we have
function ( cat, A, B )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), IdentityMorphism( cat, B ) ), IdentityMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) ) );
end
gap> # hom structure on identities in the underlying category
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "A", "B" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), IdentityMorphism( cat, B ) )",
>         dst_template := "IdentityMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms is compatible with composition
gap> StateNextLemma( );


Lemma 5:
In the opposite category of a category with a homomorphism structure, the homomorphism structure is compatible with composition:
For six objects A, B, C, D, E, and F and four morphisms alpha_1 : B → C, alpha_2 : A → B, beta_1 : D → E, and beta_2 : E → F we have
function ( cat, A, B, C, D, E, F, alpha_1, alpha_2, beta_1, beta_2 )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), PreCompose( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha_1, beta_1 ), HomomorphismStructureOnMorphisms( cat, alpha_2, beta_2 ) ), HomomorphismStructureOnMorphisms( cat, PreCompose( cat, alpha_2, alpha_1 ), PreCompose( cat, beta_1, beta_2 ) ) );
end
gap> # HomomorphismStructureOnMorphisms in the underlying category is compatible with the composition
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "beta", "gamma", "delta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "HomomorphismStructureOnMorphisms( cat, PreCompose( cat, alpha, beta ), PreCompose( cat, gamma, delta ) )",
>         dst_template := "PreCompose( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, beta, gamma ), HomomorphismStructureOnMorphisms( cat, alpha, delta ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# HomomorphismStructureOnMorphisms is compatible with addition in the first component
gap> StateNextLemma( );


Lemma 6:
In the opposite category of a category with a homomorphism structure, the homomorphism structue is additive in the first component:
For four objects A, B, C, and D and three morphisms alpha_1 : A → B, alpha_2 : A → B, and beta : C → D we have
function ( cat, A, B, C, D, alpha_1, alpha_2, beta )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha_1, beta ), HomomorphismStructureOnMorphisms( cat, alpha_2, beta ) ), HomomorphismStructureOnMorphisms( cat, AdditionForMorphisms( cat, alpha_1, alpha_2 ), beta ) );
end
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

# HomomorphismStructureOnMorphisms is compatible with addition in the second component
gap> StateNextLemma( );


Lemma 7:
In the opposite category of a category with a homomorphism structure, the homomorphism structure is additive in the second component:
For four objects A, B, C, and D and three morphisms alpha : A → B, beta_1 : C → D, and beta_2 : C → D we have
function ( cat, A, B, C, D, alpha, beta_1, beta_2 )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha, beta_1 ), HomomorphismStructureOnMorphisms( cat, alpha, beta_2 ) ), HomomorphismStructureOnMorphisms( cat, alpha, AdditionForMorphisms( cat, beta_1, beta_2 ) ) );
end
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

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure well-defined
gap> StateNextLemma( );


Lemma 8:
In the opposite category of a category with a homomorphism structure, interpreting a morphism as a morphism from the distinguished object defines a morphism in the range category of the homomorphism structure:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha ), HomomorphismStructureOnObjects( cat, A, B ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( RangeCategoryOfHomomorphismStructure( cat_1 ), DistinguishedObjectOfHomomorphismStructure( OppositeCategory( cat_1 ) ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( OppositeCategory( cat_1 ), Opposite( alpha_1 ) ), HomomorphismStructureOnObjects( OppositeCategory( cat_1 ), Opposite( B_1 ), Opposite( A_1 ) ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> # source and range of morphisms in the opposite category
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha" ],
>         src_template := "Source( Opposite( alpha ) )",
>         dst_template := "Opposite( Range( alpha ) )",
>     )
> );
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha" ],
>         src_template := "Range( Opposite( alpha ) )",
>         dst_template := "Opposite( Source( alpha ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism well-defined
gap> StateNextLemma( );


Lemma 9:
In the opposite category of a category with a homomorphism structure, reinterpreting a morphism from the distinguished morphism as a usual morphism defines a morphism:
For two objects A and B and a morphism alpha : DistinguishedObjectOfHomomorphismStructure( cat ) → HomomorphismStructureOnObjects( cat, A, B ) in the range category of the homomorphism structure we have
function ( cat, A, B, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, alpha ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( OppositeCategory( cat_1 ), Opposite( B_1 ), InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( OppositeCategory( cat_1 ), Opposite( B_1 ), Opposite( A_1 ), alpha_1 ), Opposite( A_1 ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure is injective
gap> StateNextLemma( );


Lemma 10:
In the opposite category of a category with a homomorphism structure, interpreting morphisms as morphisms from the distinguished object is an injective operation:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha ) ), alpha );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    return IsCongruentForMorphisms( OppositeCategory( cat_1 ), InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( OppositeCategory( cat_1 ), Opposite( B_1 ), Opposite( A_1 ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( OppositeCategory( cat_1 ), Opposite( alpha_1 ) ) ), Opposite( alpha_1 ) );
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
In the opposite category of a category with a homomorphism structure, interpreting morphisms as morphisms from the distinguished object is a surjective operation:
For two objects S and T and a morphism alpha : DistinguishedObjectOfHomomorphismStructure( cat ) → HomomorphismStructureOnObjects( cat, S, T ) in the range category of the homomorphism structure we have
function ( cat, S, T, alpha )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, S, T, alpha ) ), alpha );
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
gap> AssertLemma( );
With this, the claim follows. ∎

# naturality of InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure
gap> StateNextLemma( );


Lemma 12:
In the opposite category of a category with a homomorphism structure, interpreting morphisms as morphisms from the distinguished object is a natural transformation:
For four objects A, B, C, and D and three morphisms alpha : A → B, xi : B → C, and beta : C → D we have
function ( cat, A, B, C, D, alpha, xi, beta )
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, PreComposeList( cat, A, [ alpha, xi, beta ], D ) ), PreCompose( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, xi ), HomomorphismStructureOnMorphisms( cat, alpha, beta ) ) );
end
gap> # interpretation in the underlying category is a natural transformation
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "range_cat", "cat", "alpha", "xi", "beta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "PreCompose( range_cat, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, xi ), HomomorphismStructureOnMorphisms( cat, alpha, beta ) )",
>         dst_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, PostComposeList( cat, Source( alpha ), [ beta, xi, alpha ], Range( beta ) ) )",
>     )
> );
gap> # source and range of morphisms in the opposite category
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha" ],
>         src_template := "Source( Opposite( alpha ) )",
>         dst_template := "Opposite( Range( alpha ) )",
>     )
> );
> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha" ],
>         src_template := "Range( Opposite( alpha ) )",
>         dst_template := "Opposite( Source( alpha ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

#
gap> AssertProposition( );


Summing up, we have shown:
The opposite category of a category with a homomorphism structure is equipped with a homomorphism structure. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> SizeScreen( [ old_screen_width ] );;

#
gap> STOP_TEST( "proof_AdditiveClosure_hom_structure" );
