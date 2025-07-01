gap> START_TEST( "RingAsCategory_of_k_algebra_has_linear_structure" );

# avoid wrapping the output
gap> old_screen_width := SizeScreen( )[1];;
gap> SizeScreen( [ 4096 ] );;

#
gap> LoadPackage( "AdditiveClosuresForCAP", ">= 2025.06-01", false );
true
gap> LoadPackage( "FreydCategoriesForCAP", ">= 2024.06-03", false );
true

#
gap> R := DummyRing( );;
gap> k := DummyCommutativeRing( );;
gap> # we view R as a k-algebra
gap> R!.String := "a k-algebra";;
gap> CapJitAddTypeSignature( "*", [ RingElementFilter( k ), RingElementFilter( R ) ], RingElementFilter( R ) );

#
gap> cat := RingAsCategory( R : FinalizeCategory := false );;
gap> # we endow cat with a k-multiplication
gap> SetCommutativeRingOfLinearCategory( cat, k );
gap> AddMultiplyWithElementOfCommutativeRingForMorphisms( cat, { cat, lambda, mor } -> RingAsCategoryMorphism( cat, lambda * UnderlyingRingElement( mor ) ) );
gap> Finalize( cat );;

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> CapJitEnableProofAssistantMode( );

#
gap> StateProposition( cat, "is_equipped_with_linear_structure" );;
Proposition:
RingAsCategory( a k-algebra ) is equipped with a linear structure.

# MultiplyWithElementOfCommutativeRingForMorphisms is well-defined
gap> StateNextLemma( );


Lemma 1:
In RingAsCategory( a k-algebra ), multiplying a morphism by a ring element defines a morphism:
For two objects A and B, an element r of the commutative ring of the linear structure, and a morphism alpha : A → B we have
function ( cat, A, B, r, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, alpha ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, r_1, alpha_1 )
    return r_1 * UnderlyingRingElement( alpha_1 ) in UnderlyingRing( cat_1 );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# MultiplyWithElementOfCommutativeRingForMorphisms is associative
gap> StateNextLemma( );


Lemma 2:
In RingAsCategory( a k-algebra ), multiplication with ring elements is associative:
For two objects A and B, two elements r and s of the commutative ring of the linear structure, and a morphism alpha : A → B we have
function ( cat, A, B, r, s, alpha )
    return IsCongruentForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, MultiplyWithElementOfCommutativeRingForMorphisms( s, alpha ) ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, r * s, alpha ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "k", "l", "r" ],
>         variable_filters := [ RingElementFilter( k ), RingElementFilter( k ), RingElementFilter( R ) ],
>         src_template := "k * (l * r)",
>         dst_template := "(k * l) * r",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# MultiplyWithElementOfCommutativeRingForMorphisms is distributive from the right
gap> StateNextLemma( );


Lemma 3:
In RingAsCategory( a k-algebra ), composition distributes over the addition of ring elements:
For two objects A and B, two elements r and s of the commutative ring of the linear structure, and a morphism alpha : A → B we have
function ( cat, A, B, r, s, alpha )
    return IsCongruentForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r + s, alpha ), AdditionForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, alpha ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, s, alpha ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "k", "l", "r" ],
>         variable_filters := [ RingElementFilter( k ), RingElementFilter( k ), RingElementFilter( R ) ],
>         src_template := "(k + l) * r",
>         dst_template := "k * r +  l * r",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# MultiplyWithElementOfCommutativeRingForMorphisms is distributive from the left
gap> StateNextLemma( );


Lemma 4:
In RingAsCategory( a k-algebra ), ring multiplication distributes over the addition of morphisms:
For two objects A and B, an element r of the commutative ring of the linear structure, and two morphisms alpha : A → B and beta : A → B we have
function ( cat, A, B, r, alpha, beta )
    return IsCongruentForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, AdditionForMorphisms( cat, alpha, beta ) ), AdditionForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, alpha ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, beta ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "k", "r", "s" ],
>         variable_filters := [ RingElementFilter( k ), RingElementFilter( R ), RingElementFilter( R ) ],
>         src_template := "k * (r + s)",
>         dst_template := "k * r +  k * s",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# MultiplyWithElementOfCommutativeRingForMorphisms has a neutral element
gap> StateNextLemma( );


Lemma 5:
In RingAsCategory( a k-algebra ), multiplication with ring elements has a neutral element:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, One( CommutativeRingOfLinearCategory( cat ) ), alpha ), alpha );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "k", "r" ],
>         variable_filters := [ RingFilter( k ), RingElementFilter( R ) ],
>         src_template := "One( k ) * r",
>         dst_template := "r",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# composition is linear with regard to MultiplyWithElementOfCommutativeRingForMorphisms in the first component
gap> StateNextLemma( );


Lemma 6:
In RingAsCategory( a k-algebra ), composition is linear in the first component:
For three objects A, B, and C, an element r of the commutative ring of the linear structure, and two morphisms alpha : A → B and beta : B → C we have
function ( cat, A, B, C, r, alpha, beta )
    return IsCongruentForMorphisms( cat, PreCompose( cat, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, alpha ), beta ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, PreCompose( cat, alpha, beta ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "k", "r", "s" ],
>         variable_filters := [ RingElementFilter( k ), RingElementFilter( R ), RingElementFilter( R ) ],
>         src_template := "k * (r * s)",
>         dst_template := "(k * r) * s",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# composition is linear with regard to MultiplyWithElementOfCommutativeRingForMorphisms in the second component
gap> StateNextLemma( );


Lemma 7:
In RingAsCategory( a k-algebra ), composition is linear in the second component:
For three objects A, B, and C, an element r of the commutative ring of the linear structure, and two morphisms alpha : A → B and beta : B → C we have
function ( cat, A, B, C, r, alpha, beta )
    return IsCongruentForMorphisms( cat, PreCompose( cat, alpha, MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, beta ) ), MultiplyWithElementOfCommutativeRingForMorphisms( cat, r, PreCompose( cat, alpha, beta ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "k", "r", "s" ],
>         variable_filters := [ RingElementFilter( k ), RingElementFilter( R ), RingElementFilter( R ) ],
>         src_template := "k * (r * s)",
>         dst_template := "r * (k * s)",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

#
gap> AssertProposition( );


Summing up, we have shown:
RingAsCategory( a k-algebra ) is equipped with a linear structure. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> SizeScreen( [ old_screen_width ] );;

#
gap> STOP_TEST( "RingAsCategory_of_k_algebra_has_linear_structure" );
