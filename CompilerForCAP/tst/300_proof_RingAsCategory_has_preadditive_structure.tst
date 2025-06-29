gap> START_TEST( "RingAsCategory_has_preadditive_structure" );

# avoid wrapping the output
gap> old_screen_width := SizeScreen( )[1];;
gap> SizeScreen( [ 4096 ] );;

#
gap> LoadPackage( "AdditiveClosuresForCAP", ">= 2025.06-01", false );
true

#
gap> R := DummyRing( );;
gap> R!.String := "an arbitrary ring";;
gap> cat := RingAsCategory( R );;

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> CapJitEnableProofAssistantMode( );

#
gap> StateProposition( cat, "is_equipped_with_preadditive_structure" );;
Proposition:
RingAsCategory( an arbitrary ring ) is equipped with a preadditive structure.

# AdditionForMorphisms well-defined
gap> StateNextLemma( );


Lemma 1:
In RingAsCategory( an arbitrary ring ), the addition of morphisms defines a morphism:
For two objects A and B and two morphisms alpha : A → B and beta : A → B we have
function ( cat, A, B, alpha, beta )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, AdditionForMorphisms( cat, alpha, beta ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1, beta_1 )
    return UnderlyingRingElement( alpha_1 ) + UnderlyingRingElement( beta_1 ) in UnderlyingRing( cat_1 );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditionForMorphisms associative
gap> StateNextLemma( );


Lemma 2:
In RingAsCategory( an arbitrary ring ), addition of morphisms is associative:
For two objects A and B and three morphisms alpha : A → B, beta : A → B, and gamma : A → B we have
function ( cat, A, B, alpha, beta, gamma )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, AdditionForMorphisms( cat, alpha, beta ), gamma ), AdditionForMorphisms( cat, alpha, AdditionForMorphisms( cat, beta, gamma ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "a", "b", "c" ],
>         variable_filters := [ RingElementFilter( R ), RingElementFilter( R ), RingElementFilter( R ) ],
>         src_template := "a + (b + c)",
>         dst_template := "(a + b) + c",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditionForMorphisms commutative
gap> StateNextLemma( );


Lemma 3:
In RingAsCategory( an arbitrary ring ), addition of morphisms is commutative:
For two objects A and B and two morphisms alpha : A → B and beta : A → B we have
function ( cat, A, B, alpha, beta )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, alpha, beta ), AdditionForMorphisms( cat, beta, alpha ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "a", "b" ],
>         variable_filters := [ RingElementFilter( R ), RingElementFilter( R ) ],
>         src_template := "b + a",
>         dst_template := "a + b",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# composition is additive in the first component
gap> StateNextLemma( );


Lemma 4:
In RingAsCategory( an arbitrary ring ), composition is additive in the first component:
For three objects A, B, and C and three morphisms alpha : A → B, beta : A → B, and phi : B → C we have
function ( cat, A, B, C, alpha, beta, phi )
    return IsCongruentForMorphisms( cat, PreCompose( cat, AdditionForMorphisms( cat, alpha, beta ), phi ), AdditionForMorphisms( cat, PreCompose( cat, alpha, phi ), PreCompose( cat, beta, phi ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "r", "a", "b" ],
>         variable_filters := [ RingElementFilter( R ), RingElementFilter( R ), RingElementFilter( R ) ],
>         src_template := "(a + b) * r",
>         dst_template := "a * r + b * r",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# composition is additive in the second component
gap> StateNextLemma( );


Lemma 5:
In RingAsCategory( an arbitrary ring ), composition is additive in the second component:
For three objects A, B, and C and three morphisms alpha : B → C, beta : B → C, and phi : A → B we have
function ( cat, A, B, C, alpha, beta, phi )
    return IsCongruentForMorphisms( cat, PreCompose( cat, phi, AdditionForMorphisms( cat, alpha, beta ) ), AdditionForMorphisms( cat, PreCompose( cat, phi, alpha ), PreCompose( cat, phi, beta ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "r", "a", "b" ],
>         variable_filters := [ RingElementFilter( R ), RingElementFilter( R ), RingElementFilter( R ) ],
>         src_template := "r * (a + b)",
>         dst_template := "r * a + r * b",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# ZeroMorphism well-defined
gap> StateNextLemma( );


Lemma 6:
In RingAsCategory( an arbitrary ring ), the zero morphism between two objects is a morphism:
For two objects A and B we have
function ( cat, A, B )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, ZeroMorphism( cat, A, B ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1 )
    return ZeroImmutable( UnderlyingRing( cat_1 ) ) in UnderlyingRing( cat_1 );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# ZeroMorphism left neutral
gap> StateNextLemma( );


Lemma 7:
In RingAsCategory( an arbitrary ring ), zero morphisms are left neutral:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, ZeroMorphism( cat, A, B ), alpha ), alpha );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "ring", "a" ],
>         variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
>         src_template := "Zero( ring ) + a",
>         dst_template := "a",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# ZeroMorphism right neutral
gap> StateNextLemma( );


Lemma 8:
In RingAsCategory( an arbitrary ring ), zero morphisms are right neutral:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, alpha, ZeroMorphism( cat, A, B ) ), alpha );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "ring", "a" ],
>         variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
>         src_template := "a + Zero( ring )",
>         dst_template := "a",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditiveInverse well-defined
gap> StateNextLemma( );


Lemma 9:
In RingAsCategory( an arbitrary ring ), the additive inverse of a morphism defines a morphism:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, AdditiveInverseForMorphisms( cat, alpha ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    return - UnderlyingRingElement( alpha_1 ) in UnderlyingRing( cat_1 );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditiveInverse left inverse
gap> StateNextLemma( );


Lemma 10:
In RingAsCategory( an arbitrary ring ), additive inverses are left inverse:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, AdditiveInverseForMorphisms( cat, alpha ), alpha ), ZeroMorphism( cat, A, B ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "ring", "a" ],
>         variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
>         src_template := "-a + a = Zero( ring )",
>         dst_template := "true",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditiveInverse right inverse
gap> StateNextLemma( );


Lemma 11:
In RingAsCategory( an arbitrary ring ), additive inverses are right inverse:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, alpha, AdditiveInverseForMorphisms( cat, alpha ) ), ZeroMorphism( cat, A, B ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "ring", "a" ],
>         variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
>         src_template := "a + (-a) = Zero( ring )",
>         dst_template := "true",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

#
gap> AssertProposition( );


Summing up, we have shown:
RingAsCategory( an arbitrary ring ) is equipped with a preadditive structure. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> SizeScreen( [ old_screen_width ] );;

#
gap> STOP_TEST( "RingAsCategory_has_preadditive_structure" );
