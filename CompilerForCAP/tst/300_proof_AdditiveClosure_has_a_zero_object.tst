gap> START_TEST( "AdditiveClosure_has_a_zero_object" );

# avoid wrapping the output
gap> old_screen_width := SizeScreen( )[1];;
gap> SizeScreen( [ 4096 ] );;

#
gap> LoadPackage( "AdditiveClosuresForCAP", false );
true

#
gap> dummy := DummyCategory( rec(
>     list_of_operations_to_install := [
>         "IsWellDefinedForObjects",
>         "IsWellDefinedForMorphismsWithGivenSourceAndRange",
>         "IsEqualForObjects",
>         "IsCongruentForMorphisms",
>         "ZeroMorphism",
>     ],
>     properties := [
>         "IsAbCategory",
>     ],
> ) );;
gap> cat := AdditiveClosure( dummy );;

# set a human readable name
gap> cat!.Name := "the additive closure of a preadditive category";;

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> CapJitEnableProofAssistantMode( );

#
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

#
gap> StateProposition( cat, "has_zero_object" );
Proposition:
The additive closure of a preadditive category has a zero object.

# ZeroObject is well-defined
gap> StateNextLemma( );


Lemma 1:
In the additive closure of a preadditive category, the zero object is an object:
We have
function ( cat )
    return IsWellDefinedForObjects( cat, ZeroObject( cat ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# UniversalMorphismIntoZeroObject is well-defined
gap> StateNextLemma( );


Lemma 2:
In the additive closure of a preadditive category, the universal morphism into the zero objects defines a morphism:
For an object A we have
function ( cat, A )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, UniversalMorphismIntoZeroObject( cat, A ), ZeroObject( cat ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# UniversalMorphismIntoZeroObject is unique
gap> StateNextLemma( );


Lemma 3:
In the additive closure of a preadditive category, the universal morphism into the zero object is unique:
For an object A and a morphism u : A → ZeroObject( cat ) we have
function ( cat, A, u )
    return IsCongruentForMorphisms( cat, UniversalMorphismIntoZeroObject( cat, A ), u );
end
This is immediate from the construction.

# UniversalMorphismFromZeroObject is well-defined
gap> StateNextLemma( );


Lemma 4:
In the additive closure of a preadditive category, the universal morphism from the zero objects defines a morphism:
For an object B we have
function ( cat, B )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, ZeroObject( cat ), UniversalMorphismFromZeroObject( cat, B ), B );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> AssertLemma( );
With this, the claim follows. ∎

# UniversalMorphismFromZeroObject is unique
gap> StateNextLemma( );


Lemma 5:
In the additive closure of a preadditive category, the universal morphism from the zero object is unique:
For an object B and a morphism u : ZeroObject( cat ) → B we have
function ( cat, B, u )
    return IsCongruentForMorphisms( cat, UniversalMorphismFromZeroObject( cat, B ), u );
end
This is immediate from the construction.
gap> AssertProposition( );


Summing up, we have shown:
The additive closure of a preadditive category has a zero object. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> SizeScreen( [ old_screen_width ] );;

#
gap> STOP_TEST( "AdditiveClosure_has_a_zero_object" );
