# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
InstallGlobalFunction( CreateFilesForToposesPackage,
  function( )

##
WriteFileForMonoidalStructure(
        rec(
             IsMonoidalCategory := "IsCartesianCategory",
             IsStrictMonoidalCategory := "IsStrictCartesianCategory",
             IsBraidedMonoidalCategory := "IsCartesianCategory",
             IsSymmetricMonoidalCategory := "IsCartesianCategory",
             AdditiveMonoidal := "DistributiveCartesian",
             TensorProductOnObjects := "DirectProduct",
             TensorProduct := "DirectProduct",
             TensorUnit := "TerminalObject",
             Associator := "CartesianAssociator",
             LeftUnitor := "CartesianLeftUnitor",
             RightUnitor := "CartesianRightUnitor",
             Distributivity := "CartesianDistributivity",
             DirectSum := "Coproduct",
             Braiding := "CartesianBraiding",
             Lambda := "CartesianLambda",
             Evaluation := "CartesianEvaluation",
             Coevaluation := "CartesianCoevaluation",
             MONOIDAL := "CARTESIAN",
             Monoidal := "Cartesian",
             monoidal := "cartesian",
             tensor_object := "direct_product_object",
             tensored := "x",
             otimes := "times",
             oplus := "sqcup",
             tensor_product := "direct_product",
             tensorSproduct := "direct product",
             AdditiveS := "",
             BraidedS := "",
             TensorProductOnObjectsBCcat := "DirectProduct(",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"Toposes\"",
             ),
        "Toposes",
        rec( MonoidalCategoriesTensorProductAndUnit_gd := fail,
             MonoidalCategories_gd := "CartesianCategories.gd",
             AdditiveMonoidalCategories_gd := "DistributiveCartesianCategories.gd",
             BraidedMonoidalCategories_gd := "BraidedCartesianCategories.gd",
             MonoidalCategoriesTensorProductAndUnitMethodRecord_gi := fail,
             MonoidalCategoriesTensorProductAndUnit_gi := fail,
             MonoidalCategoriesMethodRecord_gi := "CartesianCategoriesMethodRecord.gi",
             MonoidalCategories_gi := "CartesianCategories.gi",
             AdditiveMonoidalCategoriesMethodRecord_gi := "DistributiveCartesianCategoriesMethodRecord.gi",
             AdditiveMonoidalCategories_gi := "DistributiveCartesianCategories.gi",
             BraidedMonoidalCategoriesProperties_gi := fail,
             BraidedMonoidalCategoriesMethodRecord_gi := "BraidedCartesianCategoriesMethodRecord.gi",
             BraidedMonoidalCategories_gi := "BraidedCartesianCategories.gi",
             SymmetricMonoidalCategoriesProperties_gi := fail,
             MonoidalCategoriesDerivedMethods_gi := "CartesianCategoriesDerivedMethods.gi",
             AdditiveMonoidalCategoriesDerivedMethods_gi := fail,
             BraidedMonoidalCategoriesDerivedMethods_gi := "BraidedCartesianCategoriesDerivedMethods.gi",
             SymmetricMonoidalCategoriesDerivedMethods_gi := "SymmetricCartesianCategoriesDerivedMethods.gi",
             )
        );

##
WriteFileForClosedMonoidalStructure(
        rec(
             IsMonoidalCategory := "IsCartesianCategory",
             IsStrictMonoidalCategory := "IsStrictCartesianCategory",
             IsBraidedMonoidalCategory := "IsCartesianCategory",
             IsSymmetricMonoidalCategory := "IsCartesianCategory",
             IsClosedMonoidalCategory := "IsCartesianClosedCategory",
             IsSymmetricClosedMonoidalCategory := "IsCartesianClosedCategory",
             AdditiveMonoidal := "DistributiveCartesian",
             TensorProductOnObjects := "DirectProduct",
             TensorProduct := "DirectProduct",
             TensorUnit := "TerminalObject",
             Associator := "CartesianAssociator",
             LeftUnitor := "CartesianLeftUnitor",
             RightUnitor := "CartesianRightUnitor",
             Distributivity := "CartesianDistributivity",
             DirectSum := "Coproduct",
             Braiding := "CartesianBraiding",
             Lambda := "CartesianLambda",
             Evaluation := "CartesianEvaluation",
             Coevaluation := "CartesianCoevaluation",
             InternalHom := "Exponential",
             ClosedMonoidalCategories := "CartesianClosedCategories",
             CLOSED_MONOIDAL := "CARTESIAN_CLOSED",
             ClosedMonoidal := "Cartesian",
             MONOIDAL := "CARTESIAN",
             Monoidal := "Cartesian",
             monoidal := "cartesian",
             Dual := "CartesianDual",
             Bidual := "CartesianBidual",
             tensor_object := "direct_product_object",
             tensored := "x",
             otimes := "times",
             oplus := "sqcup",
             tensor_product := "direct_product",
             tensorSproduct := "direct product",
             tensor_hom := "direct product-exponential",
             Hom := "Exponential",
             ClosedSMonoidal := "Cartesian Closed",
             TensorProductOnObjectsBCcat := "DirectProduct(",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"Toposes\"",
             safe_replace := [ ## BraidingWithGivenTensorProducts
                               [ "dual_operation := \"BraidingInverseWithGivenTensorProducts\"",
                                 "dual_operation := \"CocartesianBraidingInverseWithGivenCoproducts\"" ],
                               ## Braiding
                               [ "dual_operation := \"BraidingInverse\"",
                                 "dual_operation := \"CocartesianBraidingInverse\"" ],
                               ## BraidingInverseWithGivenTensorProducts
                               [ "dual_operation := \"BraidingWithGivenTensorProducts\"",
                                 "dual_operation := \"CocartesianBraidingWithGivenCoproducts\"" ],
                               ## BraidingInverse
                               [ "dual_operation := \"Braiding\"",
                                 "dual_operation := \"CocartesianBraiding\"" ],
                               ## CoevaluationMorphismWithGivenRange
                               [ "dual_operation := \"CoclosedCoevaluationMorphismWithGivenSource\"",
                                 "dual_operation := \"CocartesianCoevaluationMorphismWithGivenSource\"" ],
                               ## CoevaluationMorphism
                               [ "dual_operation := \"CoclosedCoevaluationMorphism\"",
                                 "dual_operation := \"CocartesianCoevaluationMorphism\"" ],
                               ## DualOnMorphismsWithGivenDuals
                               [ "dual_operation := \"CoDualOnMorphismsWithGivenCoDuals\"",
                                 "dual_operation := \"CocartesianDualOnMorphismsWithGivenCocartesianDuals\"" ],
                               ## DualOnMorphisms
                               [ "dual_operation := \"CoDualOnMorphisms\"",
                                 "dual_operation := \"CocartesianDualOnMorphisms\"" ],
                               ## DualOnObjects
                               [ "dual_operation := \"CoDualOnObjects\"",
                                 "dual_operation := \"CocartesianDualOnObjects\"" ],
                               ## EvaluationForDualWithGivenTensorProduct
                               [ "dual_operation := \"CoclosedEvaluationForCoDualWithGivenTensorProduct\"",
                                 "dual_operation := \"CocartesianEvaluationForCocartesianDualWithGivenCoproduct\"" ],
                               ## EvaluationForDual
                               [ "dual_operation := \"CoclosedEvaluationForCoDual\"",
                                 "dual_operation := \"CocartesianEvaluationForCocartesianDual\"" ],
                               ## EvaluationMorphismWithGivenSource
                               [ "dual_operation := \"CoclosedEvaluationMorphismWithGivenRange\"",
                                 "dual_operation := \"CocartesianEvaluationMorphismWithGivenRange\"" ],
                               ## EvaluationMorphism
                               [ "dual_operation := \"CoclosedEvaluationMorphism\"",
                                 "dual_operation := \"CocartesianEvaluationMorphism\"" ],
                               ## InternalHomOnMorphismsWithGivenInternalHoms
                               [ "dual_operation := \"InternalCoHomOnMorphismsWithGivenInternalCoHoms\"",
                                 "dual_operation := \"CoexponentialOnMorphismsWithGivenCoexponentials\"" ],
                               ## InternalHomOnMorphisms
                               [ "dual_operation := \"InternalCoHomOnMorphisms\"",
                                 "dual_operation := \"CoexponentialOnMorphisms\"" ],
                               ## InternalHomOnObjects
                               [ "dual_operation := \"InternalCoHomOnObjects\"",
                                 "dual_operation := \"CoexponentialOnObjects\"" ],
                               ## InternalHomToTensorProductAdjunctionMap
                               [ "dual_operation := \"InternalCoHomToTensorProductAdjunctionMap\"",
                                 "dual_operation := \"CoexponentialToCoproductAdjunctionMap\"" ],
                               ## IsomorphismFromDualToInternalHom
                               [ "dual_operation := \"IsomorphismFromInternalCoHomToCoDual\"",
                                 "dual_operation := \"IsomorphismFromCoexponentialToCocartesianDual\"" ],
                               ## IsomorphismFromInternalHomToDual
                               [ "dual_operation := \"IsomorphismFromCoDualToInternalCoHom\"",
                                 "dual_operation := \"IsomorphismFromCocartesianDualToCoexponential\"" ],
                               ## IsomorphismFromInternalHomToObjectWithGivenInternalHom
                               [ "dual_operation := \"IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom\"",
                                 "dual_operation := \"IsomorphismFromObjectToCoexponentialWithGivenCoexponential\"" ],
                               ## IsomorphismFromInternalHomToObject
                               [ "dual_operation := \"IsomorphismFromObjectToInternalCoHom\"",
                                 "dual_operation := \"IsomorphismFromObjectToCoexponential\"" ],
                               ## IsomorphismFromObjectToInternalHomWithGivenInternalHom
                               [ "dual_operation := \"IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom\"",
                                 "dual_operation := \"IsomorphismFromCoexponentialToObjectWithGivenCoexponential\"" ],
                               ## IsomorphismFromObjectToInternalHom
                               [ "dual_operation := \"IsomorphismFromInternalCoHomToObject\"",
                                 "dual_operation := \"IsomorphismFromCoexponentialToObject\"" ],
                               ## LambdaElimination
                               [ "dual_operation := \"CoLambdaElimination\"",
                                 "dual_operation := \"CocartesianLambdaElimination\"" ],
                               ## LambdaIntroduction
                               [ "dual_operation := \"CoLambdaIntroduction\"",
                                 "dual_operation := \"CocartesianLambdaIntroduction\"" ],
                               ## MonoidalPostComposeMorphismWithGivenObjects
                               [ "dual_operation := \"MonoidalPostCoComposeMorphismWithGivenObjects\"",
                                 "dual_operation := \"CocartesianPostCoComposeMorphismWithGivenObjects\"" ],
                               ## MonoidalPostComposeMorphism
                               [ "dual_operation := \"MonoidalPostCoComposeMorphism\"",
                                 "dual_operation := \"CocartesianPostCoComposeMorphism\"" ],
                               ## MonoidalPreComposeMorphismWithGivenObjects
                               [ "dual_operation := \"MonoidalPreCoComposeMorphismWithGivenObjects\"",
                                 "dual_operation := \"CocartesianPreCoComposeMorphismWithGivenObjects\"" ],
                               ## MonoidalPreComposeMorphism
                               [ "dual_operation := \"MonoidalPreCoComposeMorphism\"",
                                 "dual_operation := \"CocartesianPreCoComposeMorphism\"" ],
                               ## MorphismFromTensorProductToInternalHomWithGivenObjects
                               [ "dual_operation := \"MorphismFromInternalCoHomToTensorProductWithGivenObjects\"",
                                 "dual_operation := \"MorphismFromCoexponentialToCoproductWithGivenObjects\"" ],
                               ## MorphismFromTensorProductToInternalHom
                               [ "dual_operation := \"MorphismFromInternalCoHomToTensorProduct\"",
                                 "dual_operation := \"MorphismFromCoexponentialToCoproduct\"" ],
                               ## MorphismToBidualWithGivenBidual
                               [ "dual_operation := \"MorphismFromCoBidualWithGivenCoBidual\"",
                                 "dual_operation := \"MorphismFromCocartesianBidualWithGivenCocartesianBidual\"" ],
                               ## MorphismToBidual
                               [ "dual_operation := \"MorphismFromCoBidual\"",
                                 "dual_operation := \"MorphismFromCocartesianBidual\"" ],
                               ## TensorProductDualityCompatibilityMorphismWithGivenObjects
                               [ "dual_operation := \"CoDualityTensorProductCompatibilityMorphismWithGivenObjects\"",
                                 "dual_operation := \"CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects\"" ],
                               ## TensorProductDualityCompatibilityMorphism
                               [ "dual_operation := \"CoDualityTensorProductCompatibilityMorphism\"",
                                 "dual_operation := \"CocartesianDualityCoproductCompatibilityMorphism\"" ],
                               ## TensorProductInternalHomCompatibilityMorphismWithGivenObjects
                               [ "dual_operation := \"InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects\"",
                                 "dual_operation := \"CoexponentialCoproductCompatibilityMorphismWithGivenObjects\"" ],
                               ## TensorProductInternalHomCompatibilityMorphism
                               [ "dual_operation := \"InternalCoHomTensorProductCompatibilityMorphism\"",
                                 "dual_operation := \"CoexponentialCoproductCompatibilityMorphism\"" ],
                               ## TensorProductToInternalHomAdjunctionMap
                               [ "dual_operation := \"TensorProductToInternalCoHomAdjunctionMap\"",
                                 "dual_operation := \"CoproductToCoexponentialAdjunctionMap\"" ],
                               ## UniversalPropertyOfDual
                               [ "dual_operation := \"UniversalPropertyOfCoDual\"",
                                 "dual_operation := \"UniversalPropertyOfCocartesianDual\"" ],
                               ],
                             ),
        "Toposes",
        rec( ClosedMonoidalCategories_gd := "CartesianClosedCategories.gd",
             RigidSymmetricClosedMonoidalCategories_gd := fail,
             ClosedMonoidalCategoriesProperties_gi := "CartesianClosedCategoriesProperties.gi",
             ClosedMonoidalCategoriesMethodRecord_gi := "CartesianClosedCategoriesMethodRecord.gi",
             ClosedMonoidalCategories_gi := "CartesianClosedCategories.gi",
             SymmetricClosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricClosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricClosedMonoidalCategoriesMethodRecord_gi := fail,
             RigidSymmetricClosedMonoidalCategories_gi := fail,
             ClosedMonoidalCategoriesDerivedMethods_gi := "CartesianClosedCategoriesDerivedMethods.gi",
             SymmetricClosedMonoidalCategoriesDerivedMethods_gi := "SymmetricCartesianClosedCategoriesDerivedMethods.gi",
             RigidSymmetricClosedMonoidalCategoriesDerivedMethods_gi := fail,
             )
        );

##
WriteFileForMonoidalStructure(
        rec(
             IsMonoidalCategory := "IsCocartesianCategory",
             IsStrictMonoidalCategory := "IsStrictCocartesianCategory",
             IsBraidedMonoidalCategory := "IsCocartesianCategory",
             IsSymmetricMonoidalCategory := "IsCocartesianCategory",
             AdditiveMonoidal := "DistributiveCocartesian",
             TensorProductOnObjects := "Coproduct",
             TensorProduct := "Coproduct",
             TensorUnit := "InitialObject",
             Associator := "CocartesianAssociator",
             LeftUnitor := "CocartesianLeftUnitor",
             RightUnitor := "CocartesianRightUnitor",
             Distributivity := "CocartesianDistributivity",
             DirectSum := "DirectProduct",
             Braiding := "CocartesianBraiding",
             CoLambda := "CocartesianLambda",
             CoclosedEvaluation := "CocartesianEvaluation",
             CoclosedCoevaluation := "CocartesianCoevaluation",
             MONOIDAL := "COCARTESIAN",
             Monoidal := "Cocartesian",
             monoidal := "cocartesian",
             tensor_object := "coproduct_object",
             tensored := "u",
             otimes := "sqcup",
             oplus := "times",
             tensor_product := "coproduct",
             tensorSproduct := "coproduct",
             AdditiveS := "",
             BraidedS := "",
             TensorProductOnObjectsBCcat := "Coproduct(",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"Toposes\"",
             ),
        "Toposes",
        rec( MonoidalCategoriesTensorProductAndUnit_gd := fail,
             MonoidalCategories_gd := "CocartesianCategories.gd",
             AdditiveMonoidalCategories_gd := "DistributiveCocartesianCategories.gd",
             BraidedMonoidalCategories_gd := "BraidedCocartesianCategories.gd",
             MonoidalCategoriesTensorProductAndUnitMethodRecord_gi := fail,
             MonoidalCategoriesTensorProductAndUnit_gi := fail,
             MonoidalCategoriesMethodRecord_gi := "CocartesianCategoriesMethodRecord.gi",
             MonoidalCategories_gi := "CocartesianCategories.gi",
             AdditiveMonoidalCategoriesMethodRecord_gi := "DistributiveCocartesianCategoriesMethodRecord.gi",
             AdditiveMonoidalCategories_gi := "DistributiveCocartesianCategories.gi",
             BraidedMonoidalCategoriesProperties_gi := fail,
             BraidedMonoidalCategoriesMethodRecord_gi := "BraidedCocartesianCategoriesMethodRecord.gi",
             BraidedMonoidalCategories_gi := "BraidedCocartesianCategories.gi",
             SymmetricMonoidalCategoriesProperties_gi := fail,
             MonoidalCategoriesDerivedMethods_gi := "CocartesianCategoriesDerivedMethods.gi",
             AdditiveMonoidalCategoriesDerivedMethods_gi := fail,
             BraidedMonoidalCategoriesDerivedMethods_gi := "BraidedCocartesianCategoriesDerivedMethods.gi",
             SymmetricMonoidalCategoriesDerivedMethods_gi := "SymmetricCocartesianCategoriesDerivedMethods.gi",
             )
        );

##
WriteFileForCoclosedMonoidalStructure(
        rec(
             IsMonoidalCategory := "IsCocartesianCategory",
             IsStrictMonoidalCategory := "IsStrictCocartesianCategory",
             IsBraidedMonoidalCategory := "IsCocartesianCategory",
             IsSymmetricMonoidalCategory := "IsCocartesianCategory",
             IsCoclosedMonoidalCategory := "IsCocartesianCoclosedCategory",
             IsSymmetricCoclosedMonoidalCategory := "IsCocartesianCoclosedCategory",
             AdditiveMonoidal := "DistributiveCocartesian",
             TensorProductOnObjects := "Coproduct",
             TensorProduct := "Coproduct",
             TensorUnit := "InitialObject",
             Associator := "CocartesianAssociator",
             LeftUnitor := "CocartesianLeftUnitor",
             RightUnitor := "CocartesianRightUnitor",
             Distributivity := "CocartesianDistributivity",
             DirectSum := "DirectProduct",
             Braiding := "CocartesianBraiding",
             CoLambda := "CocartesianLambda",
             CoclosedEvaluation := "CocartesianEvaluation",
             CoclosedCoevaluation := "CocartesianCoevaluation",
             InternalCoHom := "Coexponential",
             CoclosedMonoidalCategories := "CocartesianCoclosedCategories",
             COCLOSED_MONOIDAL := "COCARTESIAN_COCLOSED",
             CoclosedMonoidal := "Cocartesian",
             MONOIDAL := "COCARTESIAN",
             Monoidal := "Cocartesian",
             monoidal := "cocartesian",
             CoDual := "CocartesianDual",
             CoBidual := "CocartesianBidual",
             tensor_object := "coproduct_object",
             tensored := "u",
             otimes := "sqcup",
             oplus := "times",
             tensor_product := "coproduct",
             tensorSproduct := "coproduct",
             coHom_tensor := "coexponential-coproduct",
             coHom := "Coexponential",
             CoclosedSMonoidal := "Cocartesian Coclosed",
             TensorProductOnObjectsBCcat := "Coproduct(",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"Toposes\"",
             safe_replace := [ ## BraidingWithGivenTensorProducts
                               [ "dual_operation := \"BraidingInverseWithGivenTensorProducts\"",
                                 "dual_operation := \"CartesianBraidingInverseWithGivenDirectProducts\"" ],
                               ## Braiding
                               [ "dual_operation := \"BraidingInverse\"",
                                 "dual_operation := \"CartesianBraidingInverse\"" ],
                               ## BraidingInverseWithGivenTensorProducts
                               [ "dual_operation := \"BraidingWithGivenTensorProducts\"",
                                 "dual_operation := \"CartesianBraidingWithGivenDirectProducts\"" ],
                               ## BraidingInverse
                               [ "dual_operation := \"Braiding\"",
                                 "dual_operation := \"CartesianBraiding\"" ],
                               ## CoclosedCoevaluationMorphismWithGivenSource
                               [ "dual_operation := \"CoevaluationMorphismWithGivenRange\"",
                                 "dual_operation := \"CartesianCoevaluationMorphismWithGivenRange\"" ],
                               ## CoclosedCoevaluationMorphism
                               [ "dual_operation := \"CoevaluationMorphism\"",
                                 "dual_operation := \"CartesianCoevaluationMorphism\"" ],
                               ## CoDualOnMorphismsWithGivenCoDuals
                               [ "dual_operation := \"DualOnMorphismsWithGivenDuals\"",
                                 "dual_operation := \"CartesianDualOnMorphismsWithGivenCartesianDuals\"" ],
                               ## CoDualOnMorphisms
                               [ "dual_operation := \"DualOnMorphisms\"",
                                 "dual_operation := \"CartesianDualOnMorphisms\"" ],
                               ## CoDualOnObjects
                               [ "dual_operation := \"DualOnObjects\"",
                                 "dual_operation := \"CartesianDualOnObjects\"" ],
                               ## CoclosedEvaluationForCoDualWithGivenTensorProduct
                               [ "dual_operation := \"EvaluationForDualWithGivenTensorProduct\"",
                                 "dual_operation := \"CartesianEvaluationForCartesianDualWithGivenDirectProduct\"" ],
                               ## CoclosedEvaluationForCoDual
                               [ "dual_operation := \"EvaluationForDual\"",
                                 "dual_operation := \"CartesianEvaluationForCartesianDual\"" ],
                               ## CoclosedEvaluationMorphismWithGivenRange
                               [ "dual_operation := \"EvaluationMorphismWithGivenSource\"",
                                 "dual_operation := \"CartesianEvaluationMorphismWithGivenSource\"" ],
                               ## CoclosedEvaluationMorphism
                               [ "dual_operation := \"EvaluationMorphism\"",
                                 "dual_operation := \"CartesianEvaluationMorphism\"" ],
                               ## InternalCoHomOnMorphismsWithGivenInternalCoHoms
                               [ "dual_operation := \"InternalHomOnMorphismsWithGivenInternalHoms\"",
                                 "dual_operation := \"ExponentialOnMorphismsWithGivenExponentials\"" ],
                               ## InternalCoHomOnMorphisms
                               [ "dual_operation := \"InternalHomOnMorphisms\"",
                                 "dual_operation := \"ExponentialOnMorphisms\"" ],
                               ## InternalCoHomOnObjects
                               [ "dual_operation := \"InternalHomOnObjects\"",
                                 "dual_operation := \"ExponentialOnObjects\"" ],
                               ## InternalCoHomToTensorProductAdjunctionMap
                               [ "dual_operation := \"InternalHomToTensorProductAdjunctionMap\"",
                                 "dual_operation := \"ExponentialToDirectProductAdjunctionMap\"" ],
                               ## IsomorphismFromInternalCoHomToCoDual
                               [ "dual_operation := \"IsomorphismFromDualToInternalHom\"",
                                 "dual_operation := \"IsomorphismFromCartesianDualToExponential\"" ],
                               ## IsomorphismFromCoDualToInternalCoHom
                               [ "dual_operation := \"IsomorphismFromInternalHomToDual\"",
                                 "dual_operation := \"IsomorphismFromExponentialToCartesianDual\"" ],
                               ## IsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom
                               [ "dual_operation := \"IsomorphismFromInternalHomToObjectWithGivenInternalHom\"",
                                 "dual_operation := \"IsomorphismFromExponentialToObjectWithGivenExponential\"" ],
                               ## IsomorphismFromObjectToInternalCoHom
                               [ "dual_operation := \"IsomorphismFromInternalHomToObject\"",
                                 "dual_operation := \"IsomorphismFromExponentialToObject\"" ],
                               ## IsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom
                               [ "dual_operation := \"IsomorphismFromObjectToInternalHomWithGivenInternalHom\"",
                                 "dual_operation := \"IsomorphismFromObjectToExponentialWithGivenExponential\"" ],
                               ## IsomorphismFromInternalCoHomToObject
                               [ "dual_operation := \"IsomorphismFromObjectToInternalHom\"",
                                 "dual_operation := \"IsomorphismFromObjectToExponential\"" ],
                               ## CoLambdaElimination
                               [ "dual_operation := \"LambdaElimination\"",
                                 "dual_operation := \"CartesianLambdaElimination\"" ],
                               ## CoLambdaIntroduction
                               [ "dual_operation := \"LambdaIntroduction\"",
                                 "dual_operation := \"CartesianLambdaIntroduction\"" ],
                               ## MonoidalPostCoComposeMorphismWithGivenObjects
                               [ "dual_operation := \"MonoidalPostComposeMorphismWithGivenObjects\"",
                                 "dual_operation := \"CartesianPostComposeMorphismWithGivenObjects\"" ],
                               ## MonoidalPostCoComposeMorphism
                               [ "dual_operation := \"MonoidalPostComposeMorphism\"",
                                 "dual_operation := \"CartesianPostComposeMorphism\"" ],
                               ## MonoidalPreCoComposeMorphismWithGivenObjects
                               [ "dual_operation := \"MonoidalPreComposeMorphismWithGivenObjects\"",
                                 "dual_operation := \"CartesianPreComposeMorphismWithGivenObjects\"" ],
                               ## MonoidalPreCoComposeMorphism
                               [ "dual_operation := \"MonoidalPreComposeMorphism\"",
                                 "dual_operation := \"CartesianPreComposeMorphism\"" ],
                               ## MorphismFromInternalCoHomToTensorProductWithGivenObjects
                               [ "dual_operation := \"MorphismFromTensorProductToInternalHomWithGivenObjects\"",
                                 "dual_operation := \"MorphismFromDirectProductToExponentialWithGivenObjects\"" ],
                               ## MorphismFromInternalCoHomToTensorProduct
                               [ "dual_operation := \"MorphismFromTensorProductToInternalHom\"",
                                 "dual_operation := \"MorphismFromDirectProductToExponential\"" ],
                               ## MorphismFromCoBidualWithGivenCoBidual
                               [ "dual_operation := \"MorphismToBidualWithGivenBidual\"",
                                 "dual_operation := \"MorphismToCartesianBidualWithGivenCartesianBidual\"" ],
                               ## MorphismFromCoBidual
                               [ "dual_operation := \"MorphismToBidual\"",
                                 "dual_operation := \"MorphismToCartesianBidual\"" ],
                               ## CoDualityTensorProductCompatibilityMorphismWithGivenObjects
                               [ "dual_operation := \"TensorProductDualityCompatibilityMorphismWithGivenObjects\"",
                                 "dual_operation := \"DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects\"" ],
                               ## CoDualityTensorProductCompatibilityMorphism
                               [ "dual_operation := \"TensorProductDualityCompatibilityMorphism\"",
                                 "dual_operation := \"DirectProductCartesianDualityCompatibilityMorphism\"" ],
                               ## InternalCoHomTensorProductCompatibilityMorphismWithGivenObjects
                               [ "dual_operation := \"TensorProductInternalHomCompatibilityMorphismWithGivenObjects\"",
                                 "dual_operation := \"DirectProductExponentialCompatibilityMorphismWithGivenObjects\"" ],
                               ## InternalCoHomTensorProductCompatibilityMorphism
                               [ "dual_operation := \"TensorProductInternalHomCompatibilityMorphism\"",
                                 "dual_operation := \"DirectProductExponentialCompatibilityMorphism\"" ],
                               ## TensorProductToInternalCoHomAdjunctionMap
                               [ "dual_operation := \"TensorProductToInternalHomAdjunctionMap\"",
                                 "dual_operation := \"DirectProductToExponentialAdjunctionMap\"" ],
                               ## UniversalPropertyOfCoDual
                               [ "dual_operation := \"UniversalPropertyOfDual\"",
                                 "dual_operation := \"UniversalPropertyOfCartesianDual\"" ],
                               ],
             ),
        "Toposes",
        rec( CoclosedMonoidalCategories_gd := "CocartesianCoclosedCategories.gd",
             RigidSymmetricCoclosedMonoidalCategories_gd := fail,
             CoclosedMonoidalCategoriesProperties_gi := "CocartesianCoclosedCategoriesProperties.gi",
             CoclosedMonoidalCategoriesMethodRecord_gi := "CocartesianCoclosedCategoriesMethodRecord.gi",
             CoclosedMonoidalCategories_gi := "CocartesianCoclosedCategories.gi",
             SymmetricCoclosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricCoclosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricCoclosedMonoidalCategoriesMethodRecord_gi := fail,
             RigidSymmetricCoclosedMonoidalCategories_gi := fail,
             CoclosedMonoidalCategoriesDerivedMethods_gi := "CocartesianCoclosedCategoriesDerivedMethods.gi",
             SymmetricCoclosedMonoidalCategoriesDerivedMethods_gi := "SymmetricCocartesianCoclosedCategoriesDerivedMethods.gi",
             RigidSymmetricCoclosedMonoidalCategoriesDerivedMethods_gi := fail,
             )
        );

end );
