gap> START_TEST( "proof_MonoidAsCategory_has_associative_composition" );

# avoid wrapping the output
gap> old_screen_width := SizeScreen( )[1];;
gap> SizeScreen( [ 4096 ] );;

#
gap> LoadPackage( "FreydCategoriesForCAP", false );
true

#
gap> R := DummyRing( );;
gap> cat := RingAsCategory( R );;
gap> cat!.Name := "RingAsCategory( Dummy ring 1 )";;

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> CapJitEnableProofAssistantMode( );

#
gap> statement := function ( cat, A, B, C, D, m, n, l )
>   local left, right;
>     
>     left := PreCompose( PreCompose( m, n ), l );
>     
>     right := PreCompose( m, PreCompose( n, l ) );
>     
>     return IsCongruentForMorphisms( left, right );
>     
> end;;

#
gap> StateLemma(
>     "composition is associative",
>     statement,
>     cat,
>     [ "category", "object", "object", "object", "object", "morphism", "morphism", "morphism" ],
>     [
>         rec( src_template := "Source( m )", dst_template := "A" ),
>         rec( src_template := "Range( m )", dst_template := "B" ),
>         rec( src_template := "Source( n )", dst_template := "B" ),
>         rec( src_template := "Range( n )", dst_template := "C" ),
>         rec( src_template := "Source( l )", dst_template := "C" ),
>         rec( src_template := "Range( l )", dst_template := "D" ),
>     ]
> );
In RingAsCategory( Dummy ring 1 ), composition is associative:
For four objects A, B, C, and D and three morphisms m : A → B, n : B → C, and l : C → D we have
function ( cat, A, B, C, D, m, n, l )
    local left, right;
    left := PreCompose( PreCompose( m, n ), l );
    right := PreCompose( m, PreCompose( n, l ) );
    return IsCongruentForMorphisms( left, right );
end

#
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, C_1, D_1, m_1, n_1, l_1 )
    return UnderlyingRingElement( m_1 ) * UnderlyingRingElement( n_1 ) * UnderlyingRingElement( l_1 ) = UnderlyingRingElement( m_1 ) * (UnderlyingRingElement( n_1 ) * UnderlyingRingElement( l_1 ));
end

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "a", "b", "c" ],
>         variable_filters := [ RingElementFilter( R ), RingElementFilter( R ), RingElementFilter( R ) ],
>         src_template := "a * (b * c)",
>         dst_template := "(a * b) * c",
>     )
> );

#
gap> AssertLemma( );
With this, the claim follows. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> SizeScreen( [ old_screen_width ] );;

#
gap> STOP_TEST( "proof_MonoidAsCategory_has_associative_composition" );
