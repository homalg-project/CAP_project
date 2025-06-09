# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallValue( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD, rec( ) );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCapCategory := [
    "PreCompose",
    "IdentityMorphism",
    "IsEqualForObjects",
    "IsEqualForMorphisms",
    "IsCongruentForMorphisms",
];

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsObjectFiniteCategory :=
  DuplicateFreeList(
          Concatenation(
                  ListOfDefiningOperations( "IsCapCategory" ),
                  [ "SetOfObjectsOfCategory" ] ) );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsFiniteCategory :=
  DuplicateFreeList(
          Concatenation(
                  ListOfDefiningOperations( "IsObjectFiniteCategory" ),
                  [ "SetOfMorphismsOfFiniteCategory" ] ) );

#! @Description
#!  The property of <A>C</A> being equivalent to a finite category.
#! @Arguments C
DeclareProperty( "IsEquivalentToFiniteCategory",
        IsCapCategory );

AddCategoricalProperty( [ "IsEquivalentToFiniteCategory", "IsEquivalentToFiniteCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsEquippedWithHomomorphismStructure := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "DistinguishedObjectOfHomomorphismStructure",
        "HomomorphismStructureOnObjects",
        "HomomorphismStructureOnMorphisms",
        "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
        "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithDecidableLifts := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "IsLiftable",
        "Lift",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithDecidableColifts := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "IsColiftable",
        "Colift",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithInitialObject := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "InitialObject",
        "UniversalMorphismFromInitialObject",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithTerminalObject := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "TerminalObject",
        "UniversalMorphismIntoTerminalObject",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithZeroObject := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "ZeroObject",
        "UniversalMorphismFromZeroObject",
        "UniversalMorphismIntoZeroObject",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithEqualizers := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "Equalizer",
        "EmbeddingOfEqualizer",
        "UniversalMorphismIntoEqualizer",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithCoequalizers := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "Coequalizer",
        "ProjectionOntoCoequalizer",
        "UniversalMorphismFromCoequalizer",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsEnrichedOverCommutativeRegularSemigroup := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "AdditionForMorphisms",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbCategory := Concatenation(
    ListOfDefiningOperations( "IsEnrichedOverCommutativeRegularSemigroup" ),
    [
        "ZeroMorphism",
        "IsZeroForMorphisms",
        "SubtractionForMorphisms",
        "AdditiveInverseForMorphisms",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsLinearCategoryOverCommutativeRing := Concatenation(
    ListOfDefiningOperations( "IsAbCategory" ),
    [
        "MultiplyWithElementOfCommutativeRingForMorphisms",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms := Concatenation(
    ListOfDefiningOperations( "IsLinearCategoryOverCommutativeRing" ),
    [
        "BasisOfExternalHom",
        "CoefficientsOfMorphism",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithKernels := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "KernelObject",
        "KernelEmbedding",
        "KernelLift",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithCokernels := Concatenation(
    ListOfDefiningOperations( "IsCapCategory" ),
    [
        "CokernelObject",
        "CokernelProjection",
        "CokernelColift",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAdditiveCategory := Concatenation(
    ListOfDefiningOperations( "IsAbCategory" ),
    ListOfDefiningOperations( "IsCategoryWithZeroObject" ),
    [
        "DirectSum",
        "ProjectionInFactorOfDirectSum",
        "InjectionOfCofactorOfDirectSum",
        "UniversalMorphismIntoDirectSum",
        "UniversalMorphismFromDirectSum",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsPreAbelianCategory := Concatenation(
    ListOfDefiningOperations( "IsAdditiveCategory" ),
    ListOfDefiningOperations( "IsCategoryWithKernels" ),
    ListOfDefiningOperations( "IsCategoryWithCokernels" )
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbelianCategory := Concatenation(
    ListOfDefiningOperations( "IsPreAbelianCategory" ),
    [
        "LiftAlongMonomorphism",
        "ColiftAlongEpimorphism",
        "InverseOfMorphismFromCoimageToImage",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbelianCategoryWithEnoughProjectives := Concatenation(
    ListOfDefiningOperations( "IsAbelianCategory" ),
    [
        "EpimorphismFromSomeProjectiveObject",
        "ProjectiveLift",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbelianCategoryWithEnoughInjectives := Concatenation(
    ListOfDefiningOperations( "IsAbelianCategory" ),
    [
        "MonomorphismIntoSomeInjectiveObject",
        "InjectiveColift",
    ]
);
