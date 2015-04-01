DeclareGlobalVariable( "CAP_INTERNAL_METHOD_NAME_RECORD" );

InstallValue( CAP_INTERNAL_METHOD_NAME_RECORD, rec( 
MonoAsKernelLift := rec(
  installation_name := "MonoAsKernelLift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "MonoAsKernelLift" ),

EpiAsCokernelColift := rec(
  installation_name := "EpiAsCokernelColift",
  filter_list := [ ],
  cache_name := "EpiAsCokernelColift" ),

IdentityMorphism := rec(
  installation_name := "IdentityMorphism",
  filter_list := [ ],
  cache_name := "IdentityMorphism" ),

Inverse := rec(
  installation_name := "InverseOp",
  filter_list := [ ],
  cache_name := "InverseOp" ),

KernelObject := rec(
  installation_name := "KernelObject",
  filter_list := [ ],
  cache_name := "KernelObject" ),

KernelEmb := rec(
  installation_name := "KernelEmb",
  filter_list := [ ],
  cache_name := "KernelEmb" ),

KernelEmbWithGivenKernel := rec(
  installation_name := "KernelEmbWithGivenKernel",
  filter_list := [ ],
  cache_name := "KernelEmbWithGivenKernel" ),

KernelLift := rec(
  installation_name := "KernelLift",
  filter_list := [ ],
  cache_name := "KernelLift" ),

KernelLiftWithGivenKernel := rec(
  installation_name := "KernelLiftWithGivenKernel",
  filter_list := [ ],
  cache_name := "KernelLiftWithGivenKernel" ),

Cokernel := rec(
  installation_name := "Cokernel",
  filter_list := [ ],
  cache_name := "Cokernel" ),

CokernelProj := rec(
  installation_name := "CokernelProj",
  filter_list := [ ],
  cache_name := "CokernelProj" ),

CokernelProjWithGivenCokernel := rec(
  installation_name := "CokernelProjWithGivenCokernel",
  filter_list := [ ],
  cache_name := "CokernelProjWithGivenCokernel" ),

CokernelColift := rec(
  installation_name := "CokernelColift",
  filter_list := [ ],
  cache_name := "CokernelColift" ),

CokernelColiftWithGivenCokernel := rec(
  installation_name := "CokernelColiftWithGivenCokernel",
  filter_list := [ ],
  cache_name := "CokernelColiftWithGivenCokernel" ),

PreCompose := rec(
  installation_name := "PreCompose",
  filter_list := [ ],
  cache_name := "PreCompose" ),

PostCompose := rec(
  installation_name := "PostCompose",
  filter_list := [ ],
  cache_name := "PostCompose" ),

ZeroObject := rec(
  installation_name := "ZeroObject",
  filter_list := [ ],
  cache_name := "ZeroObject" ),

ZeroMorphism := rec(
  installation_name := "ZeroMorphism",
  filter_list := [ ],
  cache_name := "ZeroMorphism" ),

DirectSum := rec(
  installation_name := "DirectSumOp",
  filter_list := [ ],
  cache_name := "DirectSumOp" ),

TerminalObject := rec(
  installation_name := "TerminalObject",
  filter_list := [ ],
  cache_name := "TerminalObject" ),

UniversalMorphismIntoTerminalObject := rec(
  installation_name := "UniversalMorphismIntoTerminalObject",
  filter_list := [ ],
  cache_name := "UniversalMorphismIntoTerminalObject" ),

UniversalMorphismIntoTerminalObjectWithGivenTerminalObject := rec(
  installation_name := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
  filter_list := [ ],
  cache_name := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" ),

InitialObject := rec(
  installation_name := "InitialObject",
  filter_list := [ ],
  cache_name := "InitialObject" ),

UniversalMorphismFromInitialObject := rec(
  installation_name := "UniversalMorphismFromInitialObject",
  filter_list := [ ],
  cache_name := "UniversalMorphismFromInitialObject" ),

UniversalMorphismFromInitialObjectWithGivenInitialObject := rec(
  installation_name := "UniversalMorphismFromInitialObjectWithGivenInitialObject",
  filter_list := [ ],
  cache_name := "UniversalMorphismFromInitialObjectWithGivenInitialObject" ),

DirectProduct := rec(
  installation_name := "DirectProductOp",
  filter_list := [ ],
  cache_name := "DirectProductOp" ),

ProjectionInFactorOfDirectProduct := rec(
  installation_name := "ProjectionInFactorOfDirectProductOp",
  filter_list := [ ],
  cache_name := "ProjectionInFactorOfDirectProductOp" ),

ProjectionInFactorOfDirectProductWithGivenDirectProduct := rec(
  installation_name := "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
  filter_list := [ ],
  cache_name := "ProjectionInFactorOfDirectProductWithGivenDirectProduct" ),

UniversalMorphismIntoDirectProduct := rec(
  installation_name := "UniversalMorphismIntoDirectProductOp",
  filter_list := [ ],
  cache_name := "UniversalMorphismIntoDirectProductOp" ),

UniversalMorphismIntoDirectProductWithGivenDirectProduct := rec(
  installation_name := "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
  filter_list := [ ],
  cache_name := "UniversalMorphismIntoDirectProductWithGivenDirectProduct" ),

IsEqualForMorphisms := rec(
  installation_name := "IsEqualForMorphisms",
  filter_list := [ ],
  cache_name := "IsEqualForMorphisms" ),

IsZeroForMorphisms := rec(
  installation_name := "IsZeroForMorphisms",
  filter_list := [ ],
  cache_name := "IsZeroForMorphisms" ),

AdditionForMorphisms := rec(
  installation_name := "AdditionForMorphisms",
  filter_list := [ ],
  cache_name := "AdditionForMorphisms" ),

AdditiveInverseForMorphisms := rec(
  installation_name := "AdditiveInverseForMorphisms",
  filter_list := [ ],
  cache_name := "AdditiveInverseForMorphisms" ),

Coproduct := rec(
  installation_name := "CoproductOp",
  filter_list := [ ],
  cache_name := "CoproductOp" ),

InjectionOfCofactorOfCoproduct := rec(
  installation_name := "InjectionOfCofactorOfCoproductOp",
  filter_list := [ ],
  cache_name := "InjectionOfCofactorOfCoproductOp" ),

InjectionOfCofactorOfCoproductWithGivenCoproduct := rec(
  installation_name := "InjectionOfCofactorOfCoproductWithGivenCoproduct",
  filter_list := [ ],
  cache_name := "InjectionOfCofactorOfCoproductWithGivenCoproduct" ),

UniversalMorphismFromCoproduct := rec(
  installation_name := "UniversalMorphismFromCoproductOp",
  filter_list := [ ],
  cache_name := "UniversalMorphismFromCoproductOp" ),

UniversalMorphismFromCoproductWithGivenCoproduct := rec(
  installation_name := "UniversalMorphismFromCoproductWithGivenCoproduct",
  filter_list := [ ],
  cache_name := "UniversalMorphismFromCoproductWithGivenCoproduct" ),

EqualityOfSubobjects := rec(
  installation_name := "EqualityOfSubobjects",
  filter_list := [ ],
  cache_name := "EqualityOfSubobjects" ),

EqualityOfFactorobjects := rec(
  installation_name := "EqualityOfFactorobjects",
  filter_list := [ ],
  cache_name := "EqualityOfFactorobjects" ),

Dominates := rec(
  installation_name := "Dominates",
  filter_list := [ ],
  cache_name := "Dominates" ),

Codominates := rec(
  installation_name := "Codominates",
  filter_list := [ ],
  cache_name := "Codominates" ),

FiberProduct := rec(
  installation_name := "FiberProductOp",
  filter_list := [ ],
  cache_name := "FiberProductOp" ),

ProjectionInFactorOfFiberProduct := rec(
  installation_name := "ProjectionInFactorOfFiberProductOp",
  filter_list := [ ],
  cache_name := "ProjectionInFactorOfFiberProductOp" ),

ProjectionInFactorOfFiberProductWithGivenFiberProduct := rec(
  installation_name := "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
  filter_list := [ ],
  cache_name := "ProjectionInFactorOfFiberProductWithGivenFiberProduct" ),

UniversalMorphismIntoFiberProduct := rec(
  installation_name := "UniversalMorphismIntoFiberProductOp",
  filter_list := [ ],
  cache_name := "UniversalMorphismIntoFiberProductOp" ),

UniversalMorphismIntoFiberProductWithGivenFiberProduct := rec(
  installation_name := "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
  filter_list := [ ],
  cache_name := "UniversalMorphismIntoFiberProductWithGivenFiberProduct" ),

Pushout := rec(
  installation_name := "PushoutOp",
  filter_list := [ ],
  cache_name := "PushoutOp" ),

InjectionOfCofactorOfPushout := rec(
  installation_name := "InjectionOfCofactorOfPushoutOp",
  filter_list := [ ],
  cache_name := "InjectionOfCofactorOfPushoutOp" ),

InjectionOfCofactorOfPushoutWithGivenPushout := rec(
  installation_name := "InjectionOfCofactorOfPushoutWithGivenPushout",
  filter_list := [ ],
  cache_name := "InjectionOfCofactorOfPushoutWithGivenPushout" ),

UniversalMorphismFromPushout := rec(
  installation_name := "UniversalMorphismFromPushoutOp",
  filter_list := [ ],
  cache_name := "UniversalMorphismFromPushoutOp" ),

UniversalMorphismFromPushoutWithGivenPushout := rec(
  installation_name := "UniversalMorphismFromPushoutWithGivenPushout",
  filter_list := [ ],
  cache_name := "UniversalMorphismFromPushoutWithGivenPushout" ),

Image := rec(
  installation_name := "Image",
  filter_list := [ ],
  cache_name := "Image" ),

ImageEmbedding := rec(
  installation_name := "ImageEmbedding",
  filter_list := [ ],
  cache_name := "ImageEmbedding" ),

ImageEmbeddingWithGivenImage := rec(
  installation_name := "ImageEmbeddingWithGivenImage",
  filter_list := [ ],
  cache_name := "ImageEmbeddingWithGivenImage" ),

IsWellDefinedForMorphisms := rec(
  installation_name := "IsWellDefinedForMorphisms",
  filter_list := [ ],
  cache_name := "IsWellDefinedForMorphisms" ),

IsWellDefinedForObjects := rec(
  installation_name := "IsWellDefinedForObjects",
  filter_list := [ ],
  cache_name := "IsWellDefinedForObjects" ),

IsZeroForObjects := rec(
  installation_name := "IsZeroForObjects",
  filter_list := [ ],
  cache_name := "IsZeroForObjects" ),

IsMonomorphism := rec(
  installation_name := "IsMonomorphism",
  filter_list := [ ],
  cache_name := "IsMonomorphism" ),

IsEpimorphism := rec(
  installation_name := "IsEpimorphism",
  filter_list := [ ],
  cache_name := "IsEpimorphism" ),

IsIsomorphism := rec(
  installation_name := "IsIsomorphism",
  filter_list := [ ],
  cache_name := "IsIsomorphism" ),

EpiMonoFactorization := rec(
  installation_name := "EpiMonoFactorization",
  filter_list := [ ],
  cache_name := "EpiMonoFactorization" ),

CoastrictionToImage := rec(
  installation_name := "CoastrictionToImage",
  filter_list := [ ],
  cache_name := "CoastrictionToImage" ),

CoastrictionToImageWithGivenImage := rec(
  installation_name := "CoastrictionToImageWithGivenImage",
  filter_list := [ ],
  cache_name := "CoastrictionToImageWithGivenImage" ),

UniversalMorphismFromImage := rec(
  installation_name := "UniversalMorphismFromImage",
  filter_list := [ ],
  cache_name := "UniversalMorphismFromImage" ),

UniversalMorphismFromImageWithGivenImage := rec(
  installation_name := "UniversalMorphismFromImageWithGivenImage",
  filter_list := [ ],
  cache_name := "UniversalMorphismFromImageWithGivenImage" ),

DomainAssociatedMorphismCodomainTriple := rec(
  installation_name := "DomainAssociatedMorphismCodomainTriple",
  filter_list := [ ],
  cache_name := "DomainAssociatedMorphismCodomainTriple" ),

Domain := rec(
  installation_name := "DomainOp",
  filter_list := [ ],
  cache_name := "DomainOp" ),

Codomain := rec(
  installation_name := "Codomain",
  filter_list := [ ],
  cache_name := "Codomain" ),

AssociatedMorphism := rec(
  installation_name := "AssociatedMorphism",
  filter_list := [ ],
  cache_name := "AssociatedMorphism" ),

PseudoInverse := rec(
  installation_name := "PseudoInverse",
  filter_list := [ ],
  cache_name := "PseudoInverse" ),

KernelObjectFunctorial := rec(
  installation_name := "KernelObjectFunctorial",
  filter_list := [ ],
  cache_name := "KernelObjectFunctorial" ),

CokernelFunctorial := rec(
  installation_name := "CokernelFunctorial",
  filter_list := [ ],
  cache_name := "CokernelFunctorial" ),

TerminalObjectFunctorial := rec(
  installation_name := "TerminalObjectFunctorial",
  filter_list := [ ],
  cache_name := "TerminalObjectFunctorial" ),

InitialObjectFunctorial := rec(
  installation_name := "InitialObjectFunctorial",
  filter_list := [ ],
  cache_name := "InitialObjectFunctorial" ),

DirectProductFunctorial := rec(
  installation_name := "DirectProductFunctorialOp",
  filter_list := [ ],
  cache_name := "DirectProductFunctorialOp" ),

CoproductFunctorial := rec(
  installation_name := "CoproductFunctorialOp",
  filter_list := [ ],
  cache_name := "CoproductFunctorialOp" ),

DirectSumFunctorial := rec(
  installation_name := "DirectSumFunctorialOp",
  filter_list := [ ],
  cache_name := "DirectSumFunctorialOp" ),

FiberProductFunctorial := rec(
  installation_name := "FiberProductFunctorialOp",
  filter_list := [ ],
  cache_name := "FiberProductFunctorialOp" ),

PushoutFunctorial := rec(
  installation_name := "PushoutFunctorialOp",
  filter_list := [ ],
  cache_name := "PushoutFunctorialOp" ),

GeneralizedMorphismFromFactorToSubobject := rec(
  installation_name := "GeneralizedMorphismFromFactorToSubobject",
  filter_list := [ ],
  cache_name := "GeneralizedMorphismFromFactorToSubobject" ),

HorizontalPreCompose := rec(
  installation_name := "HorizontalPreCompose",
  filter_list := [ ],
  cache_name := "HorizontalPreCompose" ),

VerticalPreCompose := rec(
  installation_name := "VerticalPreCompose",
  filter_list := [ ],
  cache_name := "VerticalPreCompose" ),

IdentityTwoCell := rec(
  installation_name := "IdentityTwoCell",
  filter_list := [ ],
  cache_name := "IdentityTwoCell" ),

HonestRepresentative := rec(
  installation_name := "HonestRepresentative",
  filter_list := [ ],
  cache_name := "HonestRepresentative" ),

IsWellDefinedForTwoCells := rec(
  installation_name := "IsWellDefinedForTwoCells",
  filter_list := [ ],
  cache_name := "IsWellDefinedForTwoCells" ) )
);