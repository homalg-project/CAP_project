#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

InstallValue( CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD, rec(

EveryCategory := [
  "PreCompose", "IdentityMorphism", "IsEqualForObjects", "IsEqualForMorphisms", "IsCongruentForMorphisms" ],

IsEnrichedOverCommutativeRegularSemigroup := Concatenation(
  [ "AdditionForMorphisms" ], ~.EveryCategory ),

IsAbCategory := Concatenation( [ 
  "ZeroMorphism", 
  "IsZeroForMorphisms", 
  "SubtractionForMorphisms",
  "AdditiveInverseForMorphisms" ], ~.IsEnrichedOverCommutativeRegularSemigroup ),

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

IsMonoidalCategory  := Concatenation( [
"TensorProductOnObjects",
"TensorProductOnMorphismsWithGivenTensorProducts",
"TensorUnit",
"AssociatorLeftToRightWithGivenTensorProducts",
"AssociatorRightToLeftWithGivenTensorProducts",
"LeftUnitorWithGivenTensorProduct",
"LeftUnitorInverseWithGivenTensorProduct",
"RightUnitorWithGivenTensorProduct",
"RightUnitorInverseWithGivenTensorProduct"
], ~.EveryCategory ),

IsBraidedMonoidalCategory  := Concatenation( [
"BraidingWithGivenTensorProducts",
"BraidingInverseWithGivenTensorProducts"
], ~.IsMonoidalCategory ),

IsSymmetricMonoidalCategory  := Concatenation( [ ], ~.IsBraidedMonoidalCategory ),

IsSymmetricClosedMonoidalCategory  := Concatenation( [ 
"InternalHomOnObjects",
"InternalHomOnMorphismsWithGivenInternalHoms",
"EvaluationMorphismWithGivenSource",
"CoevaluationMorphismWithGivenRange"
], ~.IsSymmetricMonoidalCategory ),

IsRigidSymmetricClosedMonoidalCategory  := Concatenation( [ 
"TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
"MorphismFromBidualWithGivenBidual"
], ~.IsSymmetricClosedMonoidalCategory )

) );

