# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallValue( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD, rec(

EveryCategory := [
  "PreCompose", "IdentityMorphism", "IsEqualForObjects", "IsEqualForMorphisms", "IsCongruentForMorphisms" ],

IsEquippedWithHomomorphismStructure := Concatenation( [
   "DistinguishedObjectOfHomomorphismStructure",
   "HomomorphismStructureOnObjects",
   "HomomorphismStructureOnMorphisms",
   "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
   "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ], ~.EveryCategory ),

IsEnrichedOverCommutativeRegularSemigroup := Concatenation(
  [ "AdditionForMorphisms" ], ~.EveryCategory ),

IsAbCategory := Concatenation( [ 
  "ZeroMorphism", 
  "IsZeroForMorphisms", 
  "SubtractionForMorphisms",
  "AdditiveInverseForMorphisms" ], ~.IsEnrichedOverCommutativeRegularSemigroup ),

IsLinearCategoryOverCommutativeRing := Concatenation( [
  "MultiplyWithElementOfCommutativeRingForMorphisms" ], ~.IsAbCategory ),

IsAdditiveCategory := Concatenation( [
  "ZeroObject",
  "UniversalMorphismFromZeroObject",
  "UniversalMorphismIntoZeroObject",
  "DirectSum",
  "ProjectionInFactorOfDirectSum",
  "InjectionOfCofactorOfDirectSum",
  "UniversalMorphismIntoDirectSum",
  "UniversalMorphismFromDirectSum" ], ~.IsAbCategory ),

IsPreAbelianCategory := Concatenation( [
"KernelObject",
"KernelEmbedding",
"KernelLift",
"CokernelObject",
"CokernelProjection",
"CokernelColift"
], ~.IsAdditiveCategory ),

IsAbelianCategory := Concatenation( [
"LiftAlongMonomorphism",
"ColiftAlongEpimorphism" ], ~.IsPreAbelianCategory ),

IsAbelianCategoryWithEnoughProjectives := Concatenation( [
"EpimorphismFromSomeProjectiveObject",
"ProjectiveLift"
], ~.IsAbelianCategory ),

IsAbelianCategoryWithEnoughInjectives := Concatenation( [
"MonomorphismIntoSomeInjectiveObject",
"InjectiveColift"
], ~.IsAbelianCategory )

) );

