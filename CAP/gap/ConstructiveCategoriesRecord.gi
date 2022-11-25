# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallValue( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD, rec( ) );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory := [
    "PreCompose",
    "IdentityMorphism",
    "IsEqualForObjects",
    "IsEqualForMorphisms",
    "IsCongruentForMorphisms",
];


CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsEquippedWithHomomorphismStructure := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory,
    [
        "DistinguishedObjectOfHomomorphismStructure",
        "HomomorphismStructureOnObjects",
        "HomomorphismStructureOnMorphisms",
        "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
        "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithDecidableLifts := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory,
    [
        "IsLiftable",
        "Lift",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCategoryWithDecidableColifts := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory,
    [
        "IsColiftable",
        "Colift",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsEnrichedOverCommutativeRegularSemigroup := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory,
    [
        "AdditionForMorphisms",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbCategory := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsEnrichedOverCommutativeRegularSemigroup,
    [
        "ZeroMorphism",
        "IsZeroForMorphisms",
        "SubtractionForMorphisms",
        "AdditiveInverseForMorphisms",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsLinearCategoryOverCommutativeRing := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbCategory,
    [
        "MultiplyWithElementOfCommutativeRingForMorphisms",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAdditiveCategory := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbCategory,
    [
        "ZeroObject",
        "UniversalMorphismFromZeroObject",
        "UniversalMorphismIntoZeroObject",
        "DirectSum",
        "ProjectionInFactorOfDirectSum",
        "InjectionOfCofactorOfDirectSum",
        "UniversalMorphismIntoDirectSum",
        "UniversalMorphismFromDirectSum",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsPreAbelianCategory := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAdditiveCategory,
    [
        "KernelObject",
        "KernelEmbedding",
        "KernelLift",
        "CokernelObject",
        "CokernelProjection",
        "CokernelColift",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbelianCategory := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsPreAbelianCategory,
    [
        "LiftAlongMonomorphism",
        "ColiftAlongEpimorphism",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbelianCategoryWithEnoughProjectives := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbelianCategory,
    [
        "EpimorphismFromSomeProjectiveObject",
        "ProjectiveLift",
    ]
);

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbelianCategoryWithEnoughInjectives := Concatenation(
    CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsAbelianCategory,
    [
        "MonomorphismIntoSomeInjectiveObject",
        "InjectiveColift",
    ]
);
