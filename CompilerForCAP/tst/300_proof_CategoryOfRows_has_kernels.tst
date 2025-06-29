gap> START_TEST( "proof_CategoryOfRows_has_kernels" );

# avoid wrapping the output
gap> old_screen_width := SizeScreen( )[1];;
gap> SizeScreen( [ 4096 ] );;

#
gap> LoadPackage( "AdditiveClosuresForCAP", false );
true

#
gap> k := DummyHomalgField( );;

#
gap> cat := CategoryOfRows( k );;

# set a human readable name
gap> cat!.Name := "a category of rows over a field";;

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> CapJitEnableProofAssistantMode( );

#
gap> StateProposition( cat, "has_kernels" );;
Proposition:
A category of rows over a field has kernels.

# KernelObject is well-defined
gap> StateNextLemma( );


Lemma 1:
In a category of rows over a field, kernel objects are objects:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsWellDefinedForObjects( cat, KernelObject( cat, alpha ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    if not IsInt( RankOfObject( A_1 ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ) ) then
        return false;
    elif not RankOfObject( A_1 ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ) >= 0 then
        return false;
    else
        return true;
    fi;
    return;
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    if not RankOfObject( A_1 ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) ) >= 0 then
        return false;
    else
        return true;
    fi;
    return;
end

# CONDITION: alpha : A -> B
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "A", "alpha" ],
>         src_template := "RankOfObject( A ) - RowRankOfMatrix( UnderlyingMatrix( alpha ) ) >= 0",
>         dst_template := "true",
>     )
> );
gap> AssertLemma( );
With this, the claim follows. ∎

# KernelEmbedding is well-defined
gap> StateNextLemma( );


Lemma 2:
In a category of rows over a field, kernel embeddings define morphisms:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, KernelObject( cat, alpha ), KernelEmbedding( cat, alpha ), A );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, alpha_1 )
    return CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                if not IsHomalgMatrix( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) then
                    return false;
                elif not NumberColumns( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) = RankOfObject( A_1 ) then
                    return false;
                else
                    return true;
                fi;
                return;
            end )(  ) and NumberRows( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) = RankOfObject( A_1 ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "matrix" ],
>         src_template := "NumberColumns( SyzygiesOfRows( matrix ) )",
>         dst_template := "NumberRows( matrix )",
>     )
> );

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha" ],
>         variable_filters := [ IsCategoryOfRowsMorphism ],
>         src_template := "NumberRows( UnderlyingMatrix( alpha ) )",
>         dst_template := "RankOfObject( Source( alpha ) )",
>     )
> );

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "matrix" ],
>         src_template := "NumberRows( SyzygiesOfRows( matrix ) )",
>         dst_template := "NumberRows( matrix ) - RowRankOfMatrix( matrix )",
>     )
> );

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha" ],
>         variable_filters := [ IsCategoryOfRowsMorphism ],
>         src_template := "NumberRows( UnderlyingMatrix( alpha ) )",
>         dst_template := "RankOfObject( Source( alpha ) )",
>     )
> );

#
gap> AssertLemma( );
With this, the claim follows. ∎

# KernelEmbedding composes to zero
gap> StateNextLemma( );


Lemma 3:
In a category of rows over a field, the kernel embedding composes to zero:
For two objects A and B and a morphism alpha : A → B we have
function ( cat, A, B, alpha )
    return IsZeroForMorphisms( cat, PreCompose( cat, KernelEmbedding( cat, alpha ), alpha ) );
end

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "matrix" ],
>         src_template := "IsZero( SyzygiesOfRows( matrix ) * matrix )",
>         dst_template := "true",
>     )
> );

#
gap> AssertLemma( );
With this, the claim follows. ∎

# KernelLift is well-defined
gap> StateNextLemma( );


Lemma 4:
In a category of rows over a field, kernel lifts define morphisms:
For three objects A, B, and T and two morphisms alpha : A → B and tau : T → A such that
• IsZeroForMorphisms( cat, PreCompose( cat, tau, alpha ) ),
we have
function ( cat, A, B, T, alpha, tau )
    return IsWellDefinedForMorphismsWithGivenSourceAndRange( cat, T, KernelLift( cat, alpha, T, tau ), KernelObject( cat, alpha ) );
end
gap> PrintLemma( );
We have to show
function ( cat_1, A_1, B_1, T_1, alpha_1, tau_1 )
    return CAP_JIT_EXPR_CASE_WRAPPER( function (  )
                if not IsHomalgMatrix( UniqueRightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) ) then
                    return false;
                elif not NumberRows( UniqueRightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) ) = RankOfObject( T_1 ) then
                    return false;
                elif not NumberColumns( UniqueRightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) ) = NumberRows( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) then
                    return false;
                else
                    return true;
                fi;
                return;
            end )(  ) and NumberRows( SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) ) ) = RankOfObject( A_1 ) - RowRankOfMatrix( UnderlyingMatrix( alpha_1 ) );
end
gap> AttestValidInputs( );
We let CompilerForCAP assume that all inputs are valid.

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "matrix1", "matrix2" ],
>         src_template := "NumberRows( UniqueRightDivide( matrix1, matrix2 ) )",
>         dst_template := "NumberRows( matrix1 )",
>     )
> );

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha" ],
>         variable_filters := [ IsCategoryOfRowsMorphism ],
>         src_template := "NumberRows( UnderlyingMatrix( alpha ) )",
>         dst_template := "RankOfObject( Source( alpha ) )",
>     )
> );

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "matrix1", "matrix2" ],
>         src_template := "NumberColumns( UniqueRightDivide( matrix1, matrix2 ) )",
>         dst_template := "NumberRows( matrix2 )",
>     )
> );

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "matrix" ],
>         src_template := "NumberRows( SyzygiesOfRows( matrix ) )",
>         dst_template := "NumberRows( matrix ) - RowRankOfMatrix( matrix )",
>     )
> );

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "alpha" ],
>         variable_filters := [ IsCategoryOfRowsMorphism ],
>         src_template := "NumberRows( UnderlyingMatrix( alpha ) )",
>         dst_template := "RankOfObject( Source( alpha ) )",
>     )
> );

#
gap> AssertLemma( );
With this, the claim follows. ∎

# computing KernelLift is an injective operation
gap> StateNextLemma( );


Lemma 5:
In a category of rows over a field, taking the kernel lift is an injective operation:
For three objects A, B, and T and two morphisms alpha : A → B and tau : T → A such that
• IsZeroForMorphisms( cat, PreCompose( cat, tau, alpha ) ),
we have
function ( cat, A, B, T, alpha, tau )
    return IsCongruentForMorphisms( cat, PreCompose( cat, KernelLift( cat, alpha, T, tau ), KernelEmbedding( cat, alpha ) ), tau );
end

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "matrix1", "matrix2" ],
>         src_template := "UniqueRightDivide( matrix1, matrix2 ) * matrix2",
>         dst_template := "matrix1",
>     )
> );

#
gap> AssertLemma( );
With this, the claim follows. ∎

# computing KernelLift is a surjective operation
gap> StateNextLemma( );


Lemma 6:
In a category of rows over a field, taking the kernel lift is a surjective operation:
For three objects A, B, and T and two morphisms alpha : A → B and u : T → KernelObject( cat, alpha ) we have
function ( cat, A, B, T, alpha, u )
    return IsCongruentForMorphisms( cat, KernelLift( cat, alpha, T, PreCompose( cat, u, KernelEmbedding( cat, alpha ) ) ), u );
end

#
gap> ApplyLogicTemplate(
>     rec(
>         variable_names := [ "matrix1", "matrix2" ],
>         src_template := "UniqueRightDivide( matrix1 * matrix2, matrix2 )",
>         dst_template := "matrix1",
>     )
> );

#
gap> AssertLemma( );
With this, the claim follows. ∎

# all lemmata proven
gap> StateNextLemma( );


All lemmata are proven.

#
gap> AssertProposition( );


Summing up, we have shown:
A category of rows over a field has kernels. ∎

#
gap> CapJitDisableProofAssistantMode( );

#
gap> SizeScreen( [ old_screen_width ] );;

#
gap> STOP_TEST( "proof_CategoryOfRows_has_kernels" );
