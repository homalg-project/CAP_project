gap> START_TEST( "proof_assistant" );

#
gap> LoadPackage( "FreydCategoriesForCAP", false );
true

#
gap> R := DummyCommutativeRing( );;
gap> cat := RingAsCategory( R );;
gap> cat!.Name := "RingAsCategory( Dummy commutative ring 1 )";;

#
gap> LoadPackage( "CompilerForCAP", false );
true
gap> CapJitEnableProofAssistantMode( );

#
gap> statement := function ( cat, a, b, c, d, e, f, g, i, j, k )
>     
>     return ForAll( [ a, b, c, d, e, f, g, i, j, k ], x -> x in CommutativeRingOfLinearCategory( cat ) );
>     
> end;;

#
gap> StateLemma(
>     "a test statement",
>     statement,
>     cat,
>     Concatenation( [ "category" ], ListWithIdenticalEntries( 10, "element_of_commutative_ring_of_linear_structure" ) ),
>     [ ]
> );
In RingAsCategory( Dummy commutative ring 1 ), a test statement:
For 10 elements a, b, c, d, e, f, g, i, j, and k of the commutative ring of th\
e linear structure we have
function ( cat, a, b, c, d, e, f, g, i, j, k )
    return ForAll( [ a, b, c, d, e, f, g, i, j, k ], function ( x )
            return x in CommutativeRingOfLinearCategory( cat );
        end );
end

#
gap> PrintLemma( );
We have to show
function ( cat_1, a_1, b_1, c_1, d_1, e_1, f_1, g_1, i_1, j_1, k_1 )
    return ForAll( [ a_1, b_1, c_1, d_1, e_1, f_1, g_1, i_1, j_1, k_1 ], 
       function ( x_2 )
            return x_2 in UnderlyingRing( cat_1 );
        end );
end

#
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.

#
gap> AssertLemma( );
With this, the claim follows. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> STOP_TEST( "proof_assistant" );
