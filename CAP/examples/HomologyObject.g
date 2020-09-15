#! @Chapter Examples and Tests

#! @Section Homology object

LoadPackage( "LinearAlgebraForCAP" );

#! @Example
field := HomalgFieldOfRationals( );;
A := VectorSpaceObject( 1, field );;
B := VectorSpaceObject( 2, field );;
C := VectorSpaceObject( 3, field );;

alpha := VectorSpaceMorphism( A, HomalgMatrix( [ [ 1, 0, 0 ] ], 1, 3, field ), C );;
beta := VectorSpaceMorphism( C, HomalgMatrix( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ], 3, 2, field ), B );;
IsZero( PreCompose( alpha, beta ) );
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
alpha_op := Opposite( alpha );;
beta_op := Opposite( beta );;
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
