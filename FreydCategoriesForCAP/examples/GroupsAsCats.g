#! @Chapter Examples and Tests

#! @Section Groups as categories

LoadPackage( "FreydCategoriesForCAP" );;

#! @Example
G := SymmetricGroup( 3 );;
CG := GroupAsCategory( G );;
u := GroupAsCategoryUniqueObject( CG );;
alpha := GroupAsCategoryMorphism( (1,2,3), CG );;
alpha * Inverse( alpha ) = IdentityMorphism( u );
#! true
beta := GroupAsCategoryMorphism( (1,2,3,5), CG );;
IsWellDefined( beta );
#! false
gamma := GroupAsCategoryMorphism( (1,3), CG );;
IsWellDefined( gamma );
#! true
Lift( alpha, gamma ) * gamma = alpha;
#! true
alpha * Colift( alpha, gamma ) = gamma;
#! true
Length( HomomorphismStructureOnObjects( u, u ) ) = Size( G );
#! true
InterpretMorphismFromDinstinguishedObjectToHomomorphismStructureAsMorphism(
    u,u,
    PreCompose(
        InterpretMorphismAsMorphismFromDinstinguishedObjectToHomomorphismStructure( alpha ), HomomorphismStructureOnMorphisms( gamma, Inverse( gamma ) )
    )
)
=
gamma * alpha * Inverse( gamma );
#! true
#! @EndExample
