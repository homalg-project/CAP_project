gap> START_TEST( "AdditiveClosure_has_preadditive_structure" );

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
>         "PreCompose",
>         "IdentityMorphism",
>         "SumOfMorphisms",
>         "ZeroMorphism",
>         "AdditionForMorphisms",
>         "AdditiveInverseForMorphisms",
>     ],
>     properties := [
>         "IsAbCategory",
>     ],
> ) );;
gap> # set a human readable name
gap> dummy!.Name := "a preadditive category";;
gap> cat := AdditiveClosure( dummy );;

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> CapJitEnableProofAssistantMode( );
gap> StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

#
gap> StateProposition( cat, "is_equipped_with_preadditive_structure" );
Proposition:
AdditiveClosure( a preadditive category ) is equipped with a preadditive structure.

# AdditionForMorphisms well-defined
gap> StateNextLemma( );


Lemma 1:
In AdditiveClosure( a preadditive category ), the addition of morphisms defines a morphism:
For two objects A and B and two morphisms alpha : A → B and beta : A → B we have
function ( cat, A, B, alpha, beta )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, AdditionForMorphisms( cat, alpha, beta ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1, beta_1 )
    if not IsList( List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                   return List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_3 )
                           return AdditionForMorphisms( UnderlyingCategory( cat_1 ), MorphismMatrix( alpha_1 )[i_2][j_3], MorphismMatrix( beta_1 )[i_2][j_3] );
                       end );
               end ) ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                 return IsList( List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_3 )
                           return AdditionForMorphisms( UnderlyingCategory( cat_1 ), MorphismMatrix( alpha_1 )[i_2][j_3], MorphismMatrix( beta_1 )[i_2][j_3] );
                       end ) );
             end ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                 return ForAll( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_3 )
                         return IsWellDefinedForMorphismsWithGivenSourceAndRange( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[i_2], AdditionForMorphisms( UnderlyingCategory( cat_1 ), MorphismMatrix( alpha_1 )[i_2][j_3], MorphismMatrix( beta_1 )[i_2][j_3] ), ObjectList( B_1 )[j_3] );
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
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Source( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Range( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Range( additive_closure_morphism ) )[j]",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditionForMorphisms associative
gap> StateNextLemma( );


Lemma 2:
In AdditiveClosure( a preadditive category ), addition of morphisms is associative:
For two objects A and B and three morphisms alpha : A → B, beta : A → B, and gamma : A → B we have
function ( cat, A, B, alpha, beta, gamma )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, AdditionForMorphisms( cat, alpha, beta ), gamma ), AdditionForMorphisms( cat, alpha, AdditionForMorphisms( cat, beta, gamma ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "beta", "gamma" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "AdditionForMorphisms( cat, AdditionForMorphisms( cat, alpha, beta ), gamma )",
>         dst_template := "AdditionForMorphisms( cat, alpha, AdditionForMorphisms( cat, beta, gamma ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditionForMorphisms commutative
gap> StateNextLemma( );


Lemma 3:
In AdditiveClosure( a preadditive category ), addition of morphisms is commutative:
For two objects A and B and two morphisms alpha : A → B and beta : A → B we have
function ( cat, A, B, alpha, beta )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, alpha, beta ), AdditionForMorphisms( cat, beta, alpha ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "beta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "AdditionForMorphisms( cat, alpha, beta )",
>         dst_template := "AdditionForMorphisms( cat, beta, alpha )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# composition is additive in the first component
gap> StateNextLemma( );


Lemma 4:
In AdditiveClosure( a preadditive category ), composition is additive in the first component:
For three objects A, B, and C and three morphisms alpha : A → B, beta : A → B, and phi : B → C we have
function ( cat, A, B, C, alpha, beta, phi )
    return IsCongruentForMorphisms( cat, PreCompose( cat, AdditionForMorphisms( cat, alpha, beta ), phi ), AdditionForMorphisms( cat, PreCompose( cat, alpha, phi ), PreCompose( cat, beta, phi ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "func1", "func2" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsFunction, IsFunction ],
>         src_template := "AdditionForMorphisms( cat, SumOfMorphisms( cat, source, List( list, func1 ), target ), SumOfMorphisms( cat, source, List( list, func2 ), target ) )",
>         dst_template := "SumOfMorphisms( cat, source, List( list, x -> AdditionForMorphisms( cat, func1( x ), func2( x ) ) ), target )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "mor", "alpha", "beta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "PreCompose( cat, AdditionForMorphisms( cat, alpha, beta ), mor )",
>         dst_template := "AdditionForMorphisms( cat, PreCompose( cat, alpha, mor ), PreCompose( cat, beta, mor ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# composition is additive in the second component
gap> StateNextLemma( );


Lemma 5:
In AdditiveClosure( a preadditive category ), composition is additive in the second component:
For three objects A, B, and C and three morphisms alpha : B → C, beta : B → C, and phi : A → B we have
function ( cat, A, B, C, alpha, beta, phi )
    return IsCongruentForMorphisms( cat, PreCompose( cat, phi, AdditionForMorphisms( cat, alpha, beta ) ), AdditionForMorphisms( cat, PreCompose( cat, phi, alpha ), PreCompose( cat, phi, beta ) ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "source", "target", "list", "func1", "func2" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsFunction, IsFunction ],
>         src_template := "AdditionForMorphisms( cat, SumOfMorphisms( cat, source, List( list, func1 ), target ), SumOfMorphisms( cat, source, List( list, func2 ), target ) )",
>         dst_template := "SumOfMorphisms( cat, source, List( list, x -> AdditionForMorphisms( cat, func1( x ), func2( x ) ) ), target )",
>         new_funcs := [ [ "x" ] ],
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "mor", "alpha", "beta" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
>         src_template := "PreCompose( cat, mor, AdditionForMorphisms( cat, alpha, beta ) )",
>         dst_template := "AdditionForMorphisms( cat, PreCompose( cat, mor, alpha ), PreCompose( cat, mor, beta ) )",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# ZeroMorphism well-defined
gap> StateNextLemma( );


Lemma 6:
In AdditiveClosure( a preadditive category ), the zero morphism between two objects is a morphism:
For two objects A and B we have
function ( cat, A, B )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, ZeroMorphism( cat, A, B ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1 )
    if not IsList( List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                   return List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_3 )
                           return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[i_2], ObjectList( B_1 )[j_3] );
                       end );
               end ) ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                 return IsList( List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_3 )
                           return ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[i_2], ObjectList( B_1 )[j_3] );
                       end ) );
             end ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                 return ForAll( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_3 )
                         return IsWellDefinedForMorphismsWithGivenSourceAndRange( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[i_2], ZeroMorphism( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[i_2], ObjectList( B_1 )[j_3] ), ObjectList( B_1 )[j_3] );
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

# ZeroMorphism left neutral
gap> StateNextLemma( );


Lemma 7:
In AdditiveClosure( a preadditive category ), zero morphisms are left neutral:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, ZeroMorphism( cat, A, B ), alpha ), alpha );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "A", "B" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
>         src_template := "AdditionForMorphisms( cat, ZeroMorphism( cat, A, B ), alpha )",
>         dst_template := "alpha",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# ZeroMorphism right neutral
gap> StateNextLemma( );


Lemma 8:
In AdditiveClosure( a preadditive category ), zero morphisms are right neutral:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, alpha, ZeroMorphism( cat, A, B ) ), alpha );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha", "A", "B" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
>         src_template := "AdditionForMorphisms( cat, alpha, ZeroMorphism( cat, A, B ) )",
>         dst_template := "alpha",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditiveInverse well-defined
gap> StateNextLemma( );


Lemma 9:
In AdditiveClosure( a preadditive category ), the additive inverse of a morphism defines a morphism:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, A, AdditiveInverseForMorphisms( cat, alpha ), B );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    if not IsList( List( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                   return List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_3 )
                           return AdditiveInverseForMorphisms( UnderlyingCategory( cat_1 ), MorphismMatrix( alpha_1 )[i_2][j_3] );
                       end );
               end ) ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                 return IsList( List( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_3 )
                           return AdditiveInverseForMorphisms( UnderlyingCategory( cat_1 ), MorphismMatrix( alpha_1 )[i_2][j_3] );
                       end ) );
             end ) then
        return false;
    elif not ForAll( [ 1 .. Length( ObjectList( A_1 ) ) ], function ( i_2 )
                 return ForAll( [ 1 .. Length( ObjectList( B_1 ) ) ], function ( j_3 )
                         return IsWellDefinedForMorphismsWithGivenSourceAndRange( UnderlyingCategory( cat_1 ), ObjectList( A_1 )[i_2], AdditiveInverseForMorphisms( UnderlyingCategory( cat_1 ), MorphismMatrix( alpha_1 )[i_2][j_3] ), ObjectList( B_1 )[j_3] );
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
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Source( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Range( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Range( additive_closure_morphism ) )[j]",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditiveInverse left inverse
gap> StateNextLemma( );


Lemma 10:
In AdditiveClosure( a preadditive category ), additive inverses are left inverse:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, AdditiveInverseForMorphisms( cat, alpha ), alpha ), ZeroMorphism( cat, A, B ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism ],
>         src_template := "AdditionForMorphisms( cat, AdditiveInverseForMorphisms( cat, alpha ), alpha )",
>         dst_template := "ZeroMorphism( cat, Source( alpha ), Range( alpha ) )",
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Source( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Range( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Range( additive_closure_morphism ) )[j]",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# AdditiveInverse right inverse
gap> StateNextLemma( );


Lemma 11:
In AdditiveClosure( a preadditive category ), additive inverses are right inverse:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsCongruentForMorphisms( cat, AdditionForMorphisms( cat, alpha, AdditiveInverseForMorphisms( cat, alpha ) ), ZeroMorphism( cat, A, B ) );
end
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "cat", "alpha" ],
>         variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism ],
>         src_template := "AdditionForMorphisms( cat, alpha, AdditiveInverseForMorphisms( cat, alpha ) )",
>         dst_template := "ZeroMorphism( cat, Source( alpha ), Range( alpha ) )",
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Source( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
>     )
> );
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "additive_closure_morphism", "i", "j" ],
>         variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
>         src_template := "Range( MorphismMatrix( additive_closure_morphism )[i][j] )",
>         dst_template := "ObjectList( Range( additive_closure_morphism ) )[j]",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎
gap> AssertProposition( );


Summing up, we have shown:
AdditiveClosure( a preadditive category ) is equipped with a preadditive structure. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> SizeScreen( [ old_screen_width ] );;

#
gap> STOP_TEST( "AdditiveClosure_has_preadditive_structure" );
