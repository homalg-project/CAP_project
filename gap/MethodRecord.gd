DeclareGlobalVariable( "CAP_INTERNAL_METHOD_NAME_RECORD" );

InstallValue( CAP_INTERNAL_METHOD_NAME_RECORD, rec( 
MonoAsKernelLift := rec(
  installation_name := "MonoAsKernelLift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "MonoAsKernelLift" ),

EpiAsCokernelColift := rec(
  installation_name := "EpiAsCokernelColift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "EpiAsCokernelColift" ),

IdentityMorphism := rec(
  installation_name := "IdentityMorphism",
  filter_list := [ "object" ] ),

Inverse := rec(
  installation_name := "InverseOp",
  filter_list := [ "morphism" ] ),

KernelObject := rec(
  installation_name := "KernelObject",
  filter_list := [ "morphism" ] ),

KernelEmb := rec(
  installation_name := "KernelEmb",
  filter_list := [ "morphism" ] ),

KernelEmbWithGivenKernel := rec(
  installation_name := "KernelEmbWithGivenKernel",
  filter_list := [ "morphism", "object" ],
  cache_name := "KernelEmbWithGivenKernel" ),

KernelLift := rec(
  installation_name := "KernelLift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "KernelLift" ),

KernelLiftWithGivenKernel := rec(
  installation_name := "KernelLiftWithGivenKernel",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "KernelLiftWithGivenKernel" ),

Cokernel := rec(
  installation_name := "Cokernel",
  filter_list := [ "morphism" ] ),

CokernelProj := rec(
  installation_name := "CokernelProj",
  filter_list := [ "morphism" ] ),

CokernelProjWithGivenCokernel := rec(
  installation_name := "CokernelProjWithGivenCokernel",
  filter_list := [ "morphism", "object" ],
  cache_name := "CokernelProjWithGivenCokernel" ),

CokernelColift := rec(
  installation_name := "CokernelColift",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "CokernelColift" ),

CokernelColiftWithGivenCokernel := rec(
  installation_name := "CokernelColiftWithGivenCokernel",
  filter_list := [ "morphism", "object" ],
  cache_name := "CokernelColiftWithGivenCokernel" ),

PreCompose := rec(
  installation_name := "PreCompose",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "PreCompose" ),

PostCompose := rec(
  installation_name := "PostCompose",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "PostCompose" ),

# ZeroObject := rec(
#   installation_name := "ZeroObject",
#   filter_list := [ ],
#   cache_name := "ZeroObject" ),

ZeroMorphism := rec(
  installation_name := "ZeroMorphism",
  filter_list := [ "object", "object" ],
  cache_name := "ZeroMorphism" ),

DirectSum := rec(
  installation_name := "DirectSumOp",
  filter_list := [ IsList, "object" ],
  cache_name := "DirectSumOp" ),

# TerminalObject := rec(
#   installation_name := "TerminalObject",
#   filter_list := [ ],
#   cache_name := "TerminalObject" ),

UniversalMorphismIntoTerminalObject := rec(
  installation_name := "UniversalMorphismIntoTerminalObject",
  filter_list := [ "object" ] ),

UniversalMorphismIntoTerminalObjectWithGivenTerminalObject := rec(
  installation_name := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
  filter_list := [ "object", "object" ],
  cache_name := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" ),

# InitialObject := rec(
#   installation_name := "InitialObject",
#   filter_list := [ ],
#   cache_name := "InitialObject" ),

UniversalMorphismFromInitialObject := rec(
  installation_name := "UniversalMorphismFromInitialObject",
  filter_list := [ "object" ] ),

UniversalMorphismFromInitialObjectWithGivenInitialObject := rec(
  installation_name := "UniversalMorphismFromInitialObjectWithGivenInitialObject",
  filter_list := [ "object", "object" ],
  cache_name := "UniversalMorphismFromInitialObjectWithGivenInitialObject" ),

DirectProduct := rec(
  installation_name := "DirectProductOp",
  filter_list := [ IsList, "object" ],
  cache_name := "DirectProductOp" ),

ProjectionInFactorOfDirectProduct := rec(
  installation_name := "ProjectionInFactorOfDirectProductOp",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfDirectProductOp" ),

ProjectionInFactorOfDirectProductWithGivenDirectProduct := rec(
  installation_name := "ProjectionInFactorOfDirectProductWithGivenDirectProduct",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfDirectProductWithGivenDirectProduct" ),

UniversalMorphismIntoDirectProduct := rec(
  installation_name := "UniversalMorphismIntoDirectProductOp",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoDirectProductOp" ),

UniversalMorphismIntoDirectProductWithGivenDirectProduct := rec(
  installation_name := "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoDirectProductWithGivenDirectProduct" ),

IsEqualForMorphisms := rec(
  installation_name := "IsEqualForMorphisms",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "IsEqualForMorphisms" ),

IsZeroForMorphisms := rec(
  installation_name := "IsZeroForMorphisms",
  filter_list := [ "morphism" ] ),

AdditionForMorphisms := rec(
  installation_name := "\+",
  filter_list := [ "morphism", "morphism" ],
  cache_name := "AdditionForMorphisms" ),

AdditiveInverseForMorphisms := rec(
  installation_name := "AdditiveInverseForMorphisms",
  filter_list := [ "morphism" ] ),

Coproduct := rec(
  installation_name := "CoproductOp",
  filter_list := [ IsList, "object" ],
  cache_name := "CoproductOp" ),

InjectionOfCofactorOfCoproduct := rec(
  installation_name := "InjectionOfCofactorOfCoproductOp",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfCoproductOp" ),

InjectionOfCofactorOfCoproductWithGivenCoproduct := rec(
  installation_name := "InjectionOfCofactorOfCoproductWithGivenCoproduct",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfCoproductWithGivenCoproduct" ),

UniversalMorphismFromCoproduct := rec(
  installation_name := "UniversalMorphismFromCoproductOp",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromCoproductOp" ),

UniversalMorphismFromCoproductWithGivenCoproduct := rec(
  installation_name := "UniversalMorphismFromCoproductWithGivenCoproduct",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromCoproductWithGivenCoproduct" ),

EqualityOfSubobjects := rec(
  installation_name := "EqualityOfSubobjects",
  filter_list := [ [ "morphism", IsSubobject ], [ "morphism", IsSubobject ] ],
  cache_name := "EqualityOfSubobjects" ),

EqualityOfFactorobjects := rec(
  installation_name := "EqualityOfFactorobjects",
  filter_list := [ [ "morphism", IsFactorobject ], [ "morphism", IsFactorobject ] ],
  cache_name := "EqualityOfFactorobjects" ),

Dominates := rec(
  installation_name := "Dominates",
  filter_list := [ [ "morphism", IsSubobject ], [ "morphism", IsSubobject ] ],
  cache_name := "Dominates",
  well_defined_todo := false ),

Codominates := rec(
  installation_name := "Codominates",
  filter_list := [ [ "morphism", IsFactorobject ], [ "morphism", IsFactorobject ] ],
  cache_name := "Codominates",
  well_defined_todo := false ),

FiberProduct := rec(
  installation_name := "FiberProductOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "FiberProductOp" ),

ProjectionInFactorOfFiberProduct := rec(
  installation_name := "ProjectionInFactorOfFiberProductOp",
  filter_list := [ IsList, IsInt, "morphism" ],
  cache_name := "ProjectionInFactorOfFiberProductOp" ),

ProjectionInFactorOfFiberProductWithGivenFiberProduct := rec(
  installation_name := "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "ProjectionInFactorOfFiberProductWithGivenFiberProduct" ),

UniversalMorphismIntoFiberProduct := rec(
  installation_name := "UniversalMorphismIntoFiberProductOp",
  filter_list := [ IsList, IsList, "morphism" ],
  cache_name := "UniversalMorphismIntoFiberProductOp" ),

UniversalMorphismIntoFiberProductWithGivenFiberProduct := rec(
  installation_name := "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismIntoFiberProductWithGivenFiberProduct" ),

Pushout := rec(
  installation_name := "PushoutOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "PushoutOp" ),

InjectionOfCofactorOfPushout := rec(
  installation_name := "InjectionOfCofactorOfPushoutOp",
  filter_list := [ IsList, IsInt, "morphism" ],
  cache_name := "InjectionOfCofactorOfPushoutOp" ),

InjectionOfCofactorOfPushoutWithGivenPushout := rec(
  installation_name := "InjectionOfCofactorOfPushoutWithGivenPushout",
  filter_list := [ IsList, IsInt, "object" ],
  cache_name := "InjectionOfCofactorOfPushoutWithGivenPushout" ),

UniversalMorphismFromPushout := rec(
  installation_name := "UniversalMorphismFromPushoutOp",
  filter_list := [ IsList, IsList, "morphism" ],
  cache_name := "UniversalMorphismFromPushoutOp" ),

UniversalMorphismFromPushoutWithGivenPushout := rec(
  installation_name := "UniversalMorphismFromPushoutWithGivenPushout",
  filter_list := [ IsList, IsList, "object" ],
  cache_name := "UniversalMorphismFromPushoutWithGivenPushout" ),

Image := rec(
  installation_name := "Image",
  filter_list := [ "morphism" ] ),

ImageEmbedding := rec(
  installation_name := "ImageEmbedding",
  filter_list := [ "morphism" ] ),

ImageEmbeddingWithGivenImage := rec(
  installation_name := "ImageEmbeddingWithGivenImage",
  filter_list := [ "morphism", "object" ],
  cache_name := "ImageEmbeddingWithGivenImage" ),

IsWellDefinedForMorphisms := rec(
  installation_name := "IsWellDefinedForMorphisms",
  filter_list := [ "morphism" ],
  well_defined_todo := false ),

IsWellDefinedForObjects := rec(
  installation_name := "IsWellDefinedForObjects",
  filter_list := [ "object" ],
  well_defined_todo := false ),

IsZeroForObjects := rec(
  installation_name := "IsZeroForObjects",
  filter_list := [ "object" ],
  well_defined_todo := false ),

IsMonomorphism := rec(
  installation_name := "IsMonomorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false ),

IsEpimorphism := rec(
  installation_name := "IsEpimorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false ),

IsIsomorphism := rec(
  installation_name := "IsIsomorphism",
  filter_list := [ "morphism" ],
  well_defined_todo := false ),

## TODO: is this function necessary?
EpiMonoFactorization := rec(
  installation_name := "EpiMonoFactorization",
  filter_list := [ "morphism" ],
  cache_name := "EpiMonoFactorization",
  well_defined_todo := false ),

CoastrictionToImage := rec(
  installation_name := "CoastrictionToImage",
  filter_list := [ "morphism" ] ),

CoastrictionToImageWithGivenImage := rec(
  installation_name := "CoastrictionToImageWithGivenImage",
  filter_list := [ "morphism", "object" ],
  cache_name := "CoastrictionToImageWithGivenImage" ),

UniversalMorphismFromImage := rec(
  installation_name := "UniversalMorphismFromImage",
  filter_list := [ "morphism", IsList ],
  cache_name := "UniversalMorphismFromImage" ),

UniversalMorphismFromImageWithGivenImage := rec(
  installation_name := "UniversalMorphismFromImageWithGivenImage",
  filter_list := [ "morphism", IsList, "object" ],
  cache_name := "UniversalMorphismFromImageWithGivenImage" ),

# DomainAssociatedMorphismCodomainTriple := rec(
#   installation_name := "DomainAssociatedMorphismCodomainTriple",
#   filter_list := [  ],
#   cache_name := "DomainAssociatedMorphismCodomainTriple" ),
# 
# Domain := rec(
#   installation_name := "DomainOp",
#   filter_list := [ ],
#   cache_name := "DomainOp" ),
# 
# Codomain := rec(
#   installation_name := "Codomain",
#   filter_list := [ ],
#   cache_name := "Codomain" ),
# 
# AssociatedMorphism := rec(
#   installation_name := "AssociatedMorphism",
#   filter_list := [ ],
#   cache_name := "AssociatedMorphism" ),
# 
# PseudoInverse := rec(
#   installation_name := "PseudoInverse",
#   filter_list := [ ],
#   cache_name := "PseudoInverse" ),

KernelObjectFunctorial := rec(
  installation_name := "KernelObjectFunctorial",
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "KernelObjectFunctorial" ),

CokernelFunctorial := rec(
  installation_name := "CokernelFunctorial",
  filter_list := [ "morphism", "morphism", "morphism" ],
  cache_name := "CokernelFunctorial" ),

# TerminalObjectFunctorial := rec(
#   installation_name := "TerminalObjectFunctorial",
#   filter_list := [ ],
#   cache_name := "TerminalObjectFunctorial" ),
# 
# InitialObjectFunctorial := rec(
#   installation_name := "InitialObjectFunctorial",
#   filter_list := [ ],
#   cache_name := "InitialObjectFunctorial" ),

DirectProductFunctorial := rec(
  installation_name := "DirectProductFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "DirectProductFunctorialOp" ),

CoproductFunctorial := rec(
  installation_name := "CoproductFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "CoproductFunctorialOp" ),

DirectSumFunctorial := rec(
  installation_name := "DirectSumFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "DirectSumFunctorialOp" ),

FiberProductFunctorial := rec(
  installation_name := "FiberProductFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "FiberProductFunctorialOp" ),

PushoutFunctorial := rec(
  installation_name := "PushoutFunctorialOp",
  filter_list := [ IsList, "morphism" ],
  cache_name := "PushoutFunctorialOp" ),

# GeneralizedMorphismFromFactorToSubobject := rec(
#   installation_name := "GeneralizedMorphismFromFactorToSubobject",
#   filter_list := [ ],
#   cache_name := "GeneralizedMorphismFromFactorToSubobject" ),

HorizontalPreCompose := rec(
  installation_name := "HorizontalPreCompose",
  filter_list := [ "twocell", "twocell" ],
  cache_name := "HorizontalPreCompose" ),

VerticalPreCompose := rec(
  installation_name := "VerticalPreCompose",
  filter_list := [ "twocell", "twocell" ],
  cache_name := "VerticalPreCompose" ),

IdentityTwoCell := rec(
  installation_name := "IdentityTwoCell",
  filter_list := [ "twocell" ] ),

# HonestRepresentative := rec(
#   installation_name := "HonestRepresentative",
#   filter_list := [ ],
#   cache_name := "HonestRepresentative" ),

IsWellDefinedForTwoCells := rec(
  installation_name := "IsWellDefinedForTwoCells",
  filter_list := [ "twocell" ],
  well_defined_todo := false ) )
);