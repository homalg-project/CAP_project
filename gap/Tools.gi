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
             TensorProductOnObjectsBCcat := "BinaryDirectProduct( cat,",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"Toposes\"",
             safe_replace := [ ##############################
                               ## Safe replacements for Tests
                               ##############################
                               ## TensorProductOnMorphisms
                               [ "TensorProductOnMorphisms( opposite",
                                 "CoproductOnMorphisms( opposite" ],
                               ## Braiding
                               [ "Braiding( opposite",
                                 "CocartesianBraiding( opposite" ],
                               ## BraidingInverse
                               [ "BraidingInverse( opposite",
                                 "CocartesianBraidingInverse( opposite" ],
                               ## LeftUnitor
                               [ "LeftUnitor( opposite",
                                 "CocartesianLeftUnitor( opposite" ],
                               ## LeftUnitorInverse
                               [ "LeftUnitorInverse( opposite",
                                 "CocartesianLeftUnitorInverse( opposite" ],
                               ## RightUnitor
                               [ "RightUnitor( opposite",
                                 "CocartesianRightUnitor( opposite" ],
                               ## RightUnitorInverse
                               [ "RightUnitorInverse( opposite",
                                 "CocartesianRightUnitorInverse( opposite" ],
                               ## AssociatorLeftToRight
                               [ "AssociatorLeftToRight( opposite",
                                 "CocartesianAssociatorLeftToRight( opposite" ],
                               ## AssociatorRightToLeft
                               [ "AssociatorRightToLeft( opposite",
                                 "CocartesianAssociatorRightToLeft( opposite" ],
                               ],
             ),
        "Toposes",
        rec( MonoidalCategoriesTensorProductAndUnit_gd := fail,
             MonoidalCategoriesTensorProductAndUnitTest_gd := fail,
             MonoidalCategories_gd := "CartesianCategories.gd",
             MonoidalCategoriesTest_gd := "CartesianCategoriesTest.gd",
             AdditiveMonoidalCategories_gd := "DistributiveCartesianCategories.gd",
             BraidedMonoidalCategories_gd := "BraidedCartesianCategories.gd",
             BraidedMonoidalCategoriesTest_gd := "BraidedCartesianCategoriesTest.gd",
             MonoidalCategoriesTensorProductAndUnitMethodRecord_gi := fail,
             MonoidalCategoriesTensorProductAndUnit_gi := fail,
             MonoidalCategoriesTensorProductAndUnitTest_gi := fail,
             MonoidalCategoriesMethodRecord_gi := fail,
             MonoidalCategories_gi := "CartesianCategories.gi",
             MonoidalCategoriesTest_gi := "CartesianCategoriesTest.gi",
             AdditiveMonoidalCategoriesMethodRecord_gi := "DistributiveCartesianCategoriesMethodRecord.gi",
             AdditiveMonoidalCategories_gi := "DistributiveCartesianCategories.gi",
             BraidedMonoidalCategoriesProperties_gi := fail,
             BraidedMonoidalCategoriesMethodRecord_gi := fail,
             BraidedMonoidalCategories_gi := "BraidedCartesianCategories.gi",
             BraidedMonoidalCategoriesTest_gi := "BraidedCartesianCategoriesTest.gi",
             SymmetricMonoidalCategoriesProperties_gi := fail,
             MonoidalCategoriesDerivedMethods_gi := "CartesianCategoriesDerivedMethods.gi",
             AdditiveMonoidalCategoriesDerivedMethods_gi := fail,
             BraidedMonoidalCategoriesDerivedMethods_gi := "BraidedCartesianCategoriesDerivedMethods.gi",
             SymmetricMonoidalCategoriesDerivedMethods_gi := "SymmetricCartesianCategoriesDerivedMethods.gi",
             AUTOGENERATED_FROM := "AUTOGENERATED_FROM.md",
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
             TensorProductOnObjectsBCcat := "BinaryDirectProduct( cat,",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"Toposes\"",
             replace := [ [ "coHom(",
                            "Coexp(" ],
                          [ "Cohom(",
                            "Coexp(" ],
                          [ "internal cohom",
                            "coexponential" ],
                          [ "int_cohom",
                            "coexp" ],
                          [ "cohom_",
                            "coexp_" ],
                          [ "Hom(",
                            "Exp(" ],
                          [ "internal hom",
                            "exponential" ],
                          [ "int_hom",
                            "exp" ],
                          [ "hom_",
                            "exp_" ],
                          [ "cocl_",
                            "coca_" ],
                          ],
             safe_replace := [ ######################################
                               ## Safe replacements for MethodRecords
                               ######################################
                               ## BraidingWithGivenTensorProducts
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
                               ##############################
                               ## Safe replacements for Tests
                               ##############################
                               ## Evalutions
                               [ "CoclosedEvaluationMorphism",
                                 "CocartesianEvaluationMorphism" ],
                               [ "CoclosedCoevaluationMorphism",
                                 "CocartesianCoevaluationMorphism" ],
                               ## AdjunctionMaps
                               [ "TensorProductToInternalCoHomAdjunctionMap",
                                 "CoproductToCoexponentialAdjunctionMap" ],
                               [ "InternalCoHomToTensorProductAdjunctionMap",
                                 "CoexponentialToCoproductAdjunctionMap" ],
                               ## MonoidalComposeMorphisms
                               [ "MonoidalPreCoComposeMorphism",
                                 "CocartesianPreCoComposeMorphism" ],
                               [ "MonoidalPostCoComposeMorphism",
                                 "CocartesianPostCoComposeMorphism" ],
                               # Codual
                               [ "CoDualOnObjects",
                                 "CocartesianDualOnObjects" ],
                               [ "CoDualOnMorphisms",
                                 "CocartesianDualOnMorphisms" ],
                               [ "UniversalPropertyOfCoDual",
                                 "UniversalPropertyOfCocartesianDual" ],
                               # CoclosedEvaluationForCoDual
                               [ "CoclosedEvaluationForCoDual",
                                 "CocartesianEvaluationForCocartesianDual" ],
                               # Cobidual
                               [ "MorphismFromCoBidual",
                                 "MorphismFromCocartesianBidual" ],
                               # CompatibilityMorphisms
                               [ "InternalCoHomTensorProductCompatibilityMorphism",
                                 "CoexponentialCoproductCompatibilityMorphism" ],
                               [ "CoDualityTensorProductCompatibilityMorphism",
                                 "CocartesianDualityCoproductCompatibilityMorphism" ],
                               ## MorphismFromInternalCoHomToDirectProduct
                               [ "MorphismFromInternalCoHomToTensorProduct",
                                 "MorphismFromCoexponentialToCoproduct" ],
                               ## Isomorphisms
                               [ "IsomorphismFromInternalCoHomToCoDual",
                                 "IsomorphismFromCoexponentialToCocartesianDual" ],
                               [ "IsomorphismFromCoDualToInternalCoHom",
                                 "IsomorphismFromCocartesianDualToCoexponential" ],
                               ## Lambdas
                               [ "CoLambdaIntroduction",
                                 "CocartesianLambdaIntroduction" ],
                               [ "CoLambdaElimination",
                                 "CocartesianLambdaElimination" ],
                               ## InternalCoHom
                               [ "InternalCoHom",
                                 "Coexponential" ],
                               ## TensorProduct
                               [ "TensorProductOnObjects( opposite",
                                 "Coproduct( opposite" ],
                               [ "TensorProductOnMorphisms( opposite",
                                 "CoproductOnMorphisms( opposite" ],
                               [ "TensorProduct( opposite",
                                 "Coproduct( opposite" ],
                               ]
             ),
        "Toposes",
        rec( ClosedMonoidalCategories_gd := "CartesianClosedCategories.gd",
             ClosedMonoidalCategoriesTest_gd := "CartesianClosedCategoriesTest.gd",
             RigidSymmetricClosedMonoidalCategories_gd := fail,
             RigidSymmetricClosedMonoidalCategoriesTest_gd := fail,
             ClosedMonoidalCategoriesProperties_gi := "CartesianClosedCategoriesProperties.gi",
             ClosedMonoidalCategoriesMethodRecord_gi := "CartesianClosedCategoriesMethodRecord.gi",
             ClosedMonoidalCategories_gi := "CartesianClosedCategories.gi",
             ClosedMonoidalCategoriesTest_gi := "CartesianClosedCategoriesTest.gi",
             SymmetricClosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricClosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricClosedMonoidalCategoriesMethodRecord_gi := fail,
             RigidSymmetricClosedMonoidalCategories_gi := fail,
             RigidSymmetricClosedMonoidalCategoriesTest_gi := fail,
             ClosedMonoidalCategoriesDerivedMethods_gi := "CartesianClosedCategoriesDerivedMethods.gi",
             SymmetricClosedMonoidalCategoriesDerivedMethods_gi := "SymmetricCartesianClosedCategoriesDerivedMethods.gi",
             RigidSymmetricClosedMonoidalCategoriesDerivedMethods_gi := fail,
             HomomorphismStructureDerivedMethods_gi := "HomomorphismStructureDerivedMethods.gi",
             )
        );

##
WriteFileForMonoidalStructure(
        rec(
             IsMonoidalCategory := "IsCocartesianCategory",
             IsStrictMonoidalCategory := "IsStrictCocartesianCategory",
             IsBraidedMonoidalCategory := "IsCocartesianCategory",
             IsSymmetricMonoidalCategory := "IsCocartesianCategory",
             AdditiveMonoidal := "CodistributiveCocartesian",
             TensorProductOnObjects := "Coproduct",
             TensorProduct := "Coproduct",
             TensorUnit := "InitialObject",
             Associator := "CocartesianAssociator",
             LeftUnitor := "CocartesianLeftUnitor",
             RightUnitor := "CocartesianRightUnitor",
             Distributivity := "CocartesianCodistributivity",
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
             TensorProductOnObjectsBCcat := "BinaryCoproduct( cat,",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"Toposes\"",
             safe_replace := [ ##############################
                               ## Safe replacements for Tests
                               ##############################
                               ## TensorProductOnMorphisms
                               [ "TensorProductOnMorphisms( opposite",
                                 "DirectProductOnMorphisms( opposite" ],
                               ## Braiding
                               [ "Braiding( opposite",
                                 "CartesianBraiding( opposite" ],
                               ## BraidingInverse
                               [ "BraidingInverse( opposite",
                                 "CartesianBraidingInverse( opposite" ],
                               ## LeftUnitor
                               [ "LeftUnitor( opposite",
                                 "CartesianLeftUnitor( opposite" ],
                               ## LeftUnitorInverse
                               [ "LeftUnitorInverse( opposite",
                                 "CartesianLeftUnitorInverse( opposite" ],
                               ## RightUnitor
                               [ "RightUnitor( opposite",
                                 "CartesianRightUnitor( opposite" ],
                               ## RightUnitorInverse
                               [ "RightUnitorInverse( opposite",
                                 "CartesianRightUnitorInverse( opposite" ],
                               ## AssociatorLeftToRight
                               [ "AssociatorLeftToRight( opposite",
                                 "CartesianAssociatorLeftToRight( opposite" ],
                               ## AssociatorRightToLeft
                               [ "AssociatorRightToLeft( opposite",
                                 "CartesianAssociatorRightToLeft( opposite" ],
                               ],
             ),
        "Toposes",
        rec( MonoidalCategoriesTensorProductAndUnit_gd := fail,
             MonoidalCategoriesTensorProductAndUnitTest_gd := fail,
             MonoidalCategories_gd := "CocartesianCategories.gd",
             MonoidalCategoriesTest_gd := "CocartesianCategoriesTest.gd",
             AdditiveMonoidalCategories_gd := "CodistributiveCocartesianCategories.gd",
             BraidedMonoidalCategories_gd := "BraidedCocartesianCategories.gd",
             BraidedMonoidalCategoriesTest_gd := "BraidedCocartesianCategoriesTest.gd",
             MonoidalCategoriesTensorProductAndUnitMethodRecord_gi := fail,
             MonoidalCategoriesTensorProductAndUnit_gi := fail,
             MonoidalCategoriesTensorProductAndUnitTest_gi := fail,
             MonoidalCategoriesMethodRecord_gi := fail,
             MonoidalCategories_gi := "CocartesianCategories.gi",
             MonoidalCategoriesTest_gi := "CocartesianCategoriesTest.gi",
             AdditiveMonoidalCategoriesMethodRecord_gi := "CodistributiveCocartesianCategoriesMethodRecord.gi",
             AdditiveMonoidalCategories_gi := "CodistributiveCocartesianCategories.gi",
             BraidedMonoidalCategoriesProperties_gi := fail,
             BraidedMonoidalCategoriesMethodRecord_gi := fail,
             BraidedMonoidalCategories_gi := "BraidedCocartesianCategories.gi",
             BraidedMonoidalCategoriesTest_gi := "BraidedCocartesianCategoriesTest.gi",
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
             AdditiveMonoidal := "CodistributiveCocartesian",
             TensorProductOnObjects := "Coproduct",
             TensorProduct := "Coproduct",
             TensorUnit := "InitialObject",
             Associator := "CocartesianAssociator",
             LeftUnitor := "CocartesianLeftUnitor",
             RightUnitor := "CocartesianRightUnitor",
             Distributivity := "CocartesianCodistributivity",
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
             cohom_tensor := "coexponential-coproduct",
             coHom := "Coexponential",
             CoclosedSMonoidal := "Cocartesian Coclosed",
             TensorProductOnObjectsBCcat := "BinaryCoproduct( cat,",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"Toposes\"",
             replace := [ [ "coHom(",
                            "Coexp(" ],
                          [ "Cohom(",
                            "Coexp(" ],
                          [ "internal cohom",
                            "coexponential" ],
                          [ "int_cohom",
                            "coexp" ],
                          [ "cohom_",
                            "coexp_" ],
                          [ "Hom(",
                            "Exp(" ],
                          [ "internal hom",
                            "exponential" ],
                          [ "int_hom",
                            "exp" ],
                          [ "hom_",
                            "exp_" ],
                          [ "cocl_",
                            "coca_" ],
                          [ "coclev",
                            "cocaev" ],
                          [ "coclcoev",
                            "cocacoev" ],
                          [ "coclosed evaluation",
                            "cocartesian evaluation" ],
                          [ "coclosed coevaluation",
                            "cocartesian coevaluation" ],
                          ],
             safe_replace := [ ######################################
                               ## Safe replacements for MethodRecords
                               ######################################
                               ## BraidingWithGivenTensorProducts
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
                               [ "CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES",
                                 "CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES" ],
                               [ "COCLOSED_MONOIDAL_CATEGORIES_METHOD",
                                 "COCARTESIAN_COCLOSED_CATEGORIES_METHOD" ],
                               [ "CLOSED_MONOIDAL_CATEGORIES",
                                 "CARTESIAN_CLOSED_CATEGORIES" ],
                               [ "CoclosedMonoidalCategories.autogen.gd",
                                 "CocartesianCoclosedCategories.autogen.gd" ],
                               [ "\"ClosedMonoidalCategories.autogen.gd\", \"Monoidal Categories\"",
                                 "\"CartesianClosedCategories.autogen.gd\", \"Cartesian Categories\"" ],
                               ##############################
                               ## Safe replacements for Tests
                               ##############################
                               ## Evalutions
                               [ " EvaluationMorphism",
                                 " CartesianEvaluationMorphism" ],
                               [ " CoevaluationMorphism",
                                 " CartesianCoevaluationMorphism" ],
                               ## AdjunctionMaps
                               [ "TensorProductToInternalHomAdjunctionMap",
                                 "DirectProductToExponentialAdjunctionMap" ],
                               [ "InternalHomToTensorProductAdjunctionMap",
                                 "ExponentialToDirectProductAdjunctionMap" ],
                               ## MonoidalComposeMorphisms
                               [ "MonoidalPreComposeMorphism",
                                 "CartesianPreComposeMorphism" ],
                               [ "MonoidalPostComposeMorphism",
                                 "CartesianPostComposeMorphism" ],
                               # Dual
                               [ " DualOnObjects",
                                 " CartesianDualOnObjects" ],
                               [ " DualOnMorphisms",
                                 " CartesianDualOnMorphisms" ],
                               [ "UniversalPropertyOfDual",
                                 "UniversalPropertyOfCartesianDual" ],
                               # EvaluationForDual
                               [ " EvaluationForDual",
                                 " CartesianEvaluationForCartesianDual" ],
                               # Bidual
                               [ "MorphismToBidual",
                                 "MorphismToCartesianBidual" ],
                               # CompatibilityMorphisms
                               [ "TensorProductInternalHomCompatibilityMorphism",
                                 "DirectProductExponentialCompatibilityMorphism" ],
                               [ "TensorProductDualityCompatibilityMorphism",
                                 "DirectProductCartesianDualityCompatibilityMorphism" ],
                               ## MorphismFromTensorProductToInternalHom
                               [ "MorphismFromTensorProductToInternalHom",
                                 "MorphismFromDirectProductToExponential" ],
                               ## Isomorphisms
                               [ "IsomorphismFromInternalHomToDual",
                                 "IsomorphismFromExponentialToCartesianDual" ],
                               [ "IsomorphismFromDualToInternalHom",
                                 "IsomorphismFromCartesianDualToExponential" ],
                               ## Lambdas
                               [ " LambdaIntroduction",
                                 " CartesianLambdaIntroduction" ],
                               [ " LambdaElimination",
                                 " CartesianLambdaElimination" ],
                               ## InternalHom
                               [ "InternalHom",
                                 "Exponential" ],
                               ## TensorProduct
                               [ "TensorProductOnObjects( opposite",
                                 "DirectProduct( opposite" ],
                               [ "TensorProductOnMorphisms( opposite",
                                 "DirectProductOnMorphisms( opposite" ],
                               [ "TensorProduct( opposite",
                                 "DirectProduct( opposite" ],
                               ]
             ),
        "Toposes",
        rec( CoclosedMonoidalCategories_gd := "CocartesianCoclosedCategories.gd",
             CoclosedMonoidalCategoriesTest_gd := "CocartesianCoclosedCategoriesTest.gd",
             RigidSymmetricCoclosedMonoidalCategories_gd := fail,
             RigidSymmetricCoclosedMonoidalCategoriesTest_gd := fail,
             CoclosedMonoidalCategoriesProperties_gi := "CocartesianCoclosedCategoriesProperties.gi",
             CoclosedMonoidalCategoriesMethodRecord_gi := "CocartesianCoclosedCategoriesMethodRecord.gi",
             CoclosedMonoidalCategories_gi := "CocartesianCoclosedCategories.gi",
             CoclosedMonoidalCategoriesTest_gi := "CocartesianCoclosedCategoriesTest.gi",
             SymmetricCoclosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricCoclosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricCoclosedMonoidalCategoriesMethodRecord_gi := fail,
             RigidSymmetricCoclosedMonoidalCategories_gi := fail,
             RigidSymmetricCoclosedMonoidalCategoriesTest_gi := fail,
             CoclosedMonoidalCategoriesDerivedMethods_gi := "CocartesianCoclosedCategoriesDerivedMethods.gi",
             SymmetricCoclosedMonoidalCategoriesDerivedMethods_gi := "SymmetricCocartesianCoclosedCategoriesDerivedMethods.gi",
             RigidSymmetricCoclosedMonoidalCategoriesDerivedMethods_gi := fail,
             )
        );

end );
