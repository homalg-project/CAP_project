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
"TensorProductOnMorphisms",
"TensorUnit",
"AssociatorLeftToRight",
"AssociatorRightToLeft",
"LeftUnitor",
"LeftUnitorInverse",
"RightUnitor",
"RightUnitorInverse"
], ~.EveryCategory ),

IsBraidedMonoidalCategory  := Concatenation( [
"Braiding",
"BraidingInverse"
], ~.IsMonoidalCategory ),

IsSymmetricMonoidalCategory  := Concatenation( [ ], ~.IsBraidedMonoidalCategory ),

IsSymmetricClosedMonoidalCategory  := Concatenation( [ 
"InternalHomOnObjects",
"InternalHomOnMorphisms",
"EvaluationMorphism",
"CoevaluationMorphism"
], ~.IsSymmetricMonoidalCategory ),

IsRigidSymmetricClosedMonoidalCategory  := Concatenation( [ 
"TensorProductInternalHomCompatibilityMorphismInverse",
"MorphismFromBidual"
], ~.IsSymmetricClosedMonoidalCategory )

) );

