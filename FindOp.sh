#!/bin/bash

#Creating cap_operations
#LoadPackage( "CAP" );
#L := Concatenation( CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForAllCategories, CAP_INTERNAL_CAN_COMPUTE_FILTER_LIST.CanComputeForSpecialCategories );
#LL := List( L, i -> i{[ 11 .. Length( i ) ]} );
#Perform( LL, function( i ) Print( i, " " ); end );
export cap_operations="MonoAsKernelLift EpiAsCokernelColift IdentityMorphism Inverse KernelObject KernelEmb KernelEmbWithGivenKernel KernelLift KernelLiftWithGivenKernel Cokernel CokernelProj CokernelProjW\
ithGivenCokernel CokernelColift CokernelColiftWithGivenCokernel PreCompose PostCompose ZeroObject ZeroMorphism DirectSum TerminalObject UniversalMorphismIntoTerminalObject UniversalM\
orphismIntoTerminalObjectWithGivenTerminalObject InitialObject UniversalMorphismFromInitialObject UniversalMorphismFromInitialObjectWithGivenInitialObject DirectProduct ProjectionInF\
actorOfDirectProduct ProjectionInFactorOfDirectProductWithGivenDirectProduct UniversalMorphismIntoDirectProduct UniversalMorphismIntoDirectProductWithGivenDirectProduct IsEqualForMor\
phisms IsZeroForMorphisms AdditionForMorphisms AdditiveInverseForMorphisms Coproduct InjectionOfCofactorOfCoproduct InjectionOfCofactorOfCoproductWithGivenCoproduct UniversalMorphism\
FromCoproduct UniversalMorphismFromCoproductWithGivenCoproduct EqualityOfSubobjects EqualityOfFactorobjects Dominates Codominates FiberProduct ProjectionInFactorOfFiberProduct Projec\
tionInFactorOfFiberProductWithGivenFiberProduct UniversalMorphismIntoFiberProduct UniversalMorphismIntoFiberProductWithGivenFiberProduct Pushout InjectionOfCofactorOfPushout Injectio\
nOfCofactorOfPushoutWithGivenPushout UniversalMorphismFromPushout UniversalMorphismFromPushoutWithGivenPushout Image ImageEmbedding ImageEmbeddingWithGivenImage IsWellDefinedForMorph\
isms IsWellDefinedForObjects IsZeroForObjects IsMonomorphism IsEpimorphism IsIsomorphism EpiMonoFactorization CoastrictionToImage CoastrictionToImageWithGivenImage UniversalMorphismF\
romImage UniversalMorphismFromImageWithGivenImage DomainAssociatedMorphismCodomainTriple Domain Codomain AssociatedMorphism PseudoInverse KernelObjectFunctorial CokernelFunctorial Te\
rminalObjectFunctorial InitialObjectFunctorial DirectProductFunctorial CoproductFunctorial DirectSumFunctorial FiberProductFunctorial PushoutFunctorial GeneralizedMorphismFromFactorT\
oSubobject HorizontalPreCompose VerticalPreCompose IdentityTwoCell HonestRepresentative IsWellDefinedForTwoCells"

for i in $cap_operations; do

CAPSTR="$(git grep $i"Op" | cat)"
CAPPRINTSTR=$i$' := rec(\n  installation_name := '
if [[ $CAPSTR = gap* ]] 
then 
  echo "$CAPPRINTSTR\""$i$'Op\",\n  filter_list := [ ],\n  cache_name := \"'"$i""Op\" )"$',\n'
else
  echo "$CAPPRINTSTR\""$i$'\",\n  filter_list := [ ],\n  cache_name := \"'"$i""\" )"$',\n'
fi
done
