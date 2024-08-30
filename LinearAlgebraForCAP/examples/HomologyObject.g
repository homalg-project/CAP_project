#! @Chapter Examples and Tests

#! @Section Homology object

LoadPackage( "LinearAlgebraForCAP" );

#! @Example
field := HomalgFieldOfRationals( );;
vec := MatrixCategory( field );;
A := MatrixCategoryObject( vec, 1 );;
B := MatrixCategoryObject( vec, 2 );;
C := MatrixCategoryObject( vec, 3 );;

alpha := VectorSpaceMorphism( A, HomalgMatrix( [ [ 1, 0, 0 ] ], 1, 3, field ), C );;
beta := VectorSpaceMorphism( C, HomalgMatrix( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ], 3, 2, field ), B );;
IsZeroForMorphisms( PreCompose( alpha, beta ) );
#! false
IsCongruentForMorphisms(
    IdentityMorphism( HomologyObject( alpha, beta ) ),
    HomologyObjectFunctorial( alpha, beta, IdentityMorphism( C ), alpha, beta )
);
#! true
kernel_beta := KernelEmbedding( beta );;
K := Source( kernel_beta );;
IsIsomorphism(
    HomologyObjectFunctorial( 
        MorphismFromZeroObject( K ), 
        MorphismIntoZeroObject( K ),
        kernel_beta,
        MorphismFromZeroObject( Source( beta ) ),
        beta
    )
);
#! true
cokernel_alpha := CokernelProjection( alpha );;
Co := Range( cokernel_alpha );;
IsIsomorphism(
    HomologyObjectFunctorial( 
        alpha,
        MorphismIntoZeroObject( Range( alpha ) ),
        cokernel_alpha,
        MorphismFromZeroObject( Co ),
        MorphismIntoZeroObject( Co )
    )
);
#! true
op := Opposite( vec );;
alpha_op := Opposite( op, alpha );;
beta_op := Opposite( op, beta );;
IsCongruentForMorphisms(
    IdentityMorphism( HomologyObject( beta_op, alpha_op ) ),
    HomologyObjectFunctorial( beta_op, alpha_op, IdentityMorphism( Opposite( C ) ), beta_op, alpha_op )
);
#! true
kernel_beta := KernelEmbedding( beta_op );;
K := Source( kernel_beta );;
IsIsomorphism(
    HomologyObjectFunctorial( 
        MorphismFromZeroObject( K ), 
        MorphismIntoZeroObject( K ),
        kernel_beta,
        MorphismFromZeroObject( Source( beta_op ) ),
        beta_op
    )
);
#! true
cokernel_alpha := CokernelProjection( alpha_op );;
Co := Range( cokernel_alpha );;
IsIsomorphism(
    HomologyObjectFunctorial( 
        alpha_op,
        MorphismIntoZeroObject( Range( alpha_op ) ),
        cokernel_alpha,
        MorphismFromZeroObject( Co ),
        MorphismIntoZeroObject( Co )
    )
);
#! true
#! @EndExample
