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
x := (2,3) / CG;;
id := () / CG;;
x * x = id;
#! true
IsIdenticalObj( x * x, id );
#! false
alpha := GroupAsCategoryMorphism( CG, (1,2,3) );;
alpha * Inverse( alpha ) = IdentityMorphism( u );
#! true
beta := GroupAsCategoryMorphism( CG, (1,2,3,5) );;
IsWellDefined( beta );
#! false
gamma := GroupAsCategoryMorphism( CG, (1,3) );;
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
                InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( alpha ),
                HomomorphismStructureOnMorphisms( gamma, Inverse( gamma ) ) ) )
=
gamma * alpha * Inverse( gamma );
#! true
#! #@fi
#! @EndExample
