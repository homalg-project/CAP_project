#! @Chapter Examples and Tests

LoadPackage( "GroupsAsCategoriesForCAP" );;

#! @Example
G := SymmetricGroup( 3 );;
CG := GroupAsCategory( G );;
u := GroupAsCategoryUniqueObject( CG );;
SetOfObjects( CG ) = [ u ];
#! true
SetOfGeneratingMorphisms( CG );
#! [ <(1,2,3)>, <(1,2)> ]
Length( SetOfMorphismsOfFiniteCategory( CG ) ) = Size( G );
#! true
x := (2,3)/CG;;
id := ()/CG;;
IsIdenticalObj( x * x, id );
#! true
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
#! #@if IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" )
Length( HomomorphismStructureOnObjects( u, u ) ) = Size( G );
#! true
InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism(
    u,u,
    PreCompose(
        InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha ), HomomorphismStructureOnMorphisms( gamma, Inverse( gamma ) )
    )
)
=
gamma * alpha * Inverse( gamma );
#! true
#! #@fi
#! @EndExample
