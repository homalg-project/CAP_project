# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

##
InstallGlobalFunction( CreateFilesForCartesianCategoriesPackage,
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
             LeftClosedMonoidalLambda := "CartesianLambda",
             LeftClosedMonoidalEvaluation := "CartesianEvaluation",
             LeftClosedMonoidalCoevaluation := "CartesianCoevaluation",
             MONOIDAL := "CARTESIAN",
             Monoidal := "Cartesian",
             monoidal := "cartesian",
             DISTRIBUTIVE := "DISTRIBUTIVE",
             tensor_object := "direct_product_object",
             tensored := "x",
             otimes := "times",
             oplus := "sqcup",
             tensor_product := "direct_product",
             tensorSproduct := "direct product",
             AdditiveS := "",
             BraidedS := "",
             TensorProductOnObjectsBCcat := "BinaryDirectProduct( cat,",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"CartesianCategories\"",
             replace := [ [ "⊗",
                            "×" ],
                          ],
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
                               ## LeftDistributivityExpanding
                               [ "LeftDistributivityExpanding( opposite",
                                 "LeftCocartesianCodistributivityExpanding( opposite" ],
                               ## LeftDistributivityFactoring
                               [ "LeftDistributivityFactoring( opposite",
                                 "LeftCocartesianCodistributivityFactoring( opposite" ],
                               ## RightDistributivityExpanding
                               [ "RightDistributivityExpanding( opposite",
                                 "RightCocartesianCodistributivityExpanding( opposite" ],
                               ## RightDistributivityFactoring
                               [ "RightDistributivityFactoring( opposite",
                                 "RightCocartesianCodistributivityFactoring( opposite" ],
                               ],
             ),
        "CartesianCategories",
        rec( MonoidalCategoriesTensorProductAndUnit_gd := fail,
             MonoidalCategoriesTensorProductAndUnitTest_gd := fail,
             MonoidalCategories_gd := "CartesianCategories.gd",
             MonoidalCategoriesTest_gd := "CartesianCategoriesTest.gd",
             AdditiveMonoidalCategories_gd := "DistributiveCartesianCategories.gd",
             AdditiveMonoidalCategoriesTest_gd := "DistributiveCartesianCategoriesTest.gd",
             BraidedMonoidalCategories_gd := "BraidedCartesianCategories.gd",
             BraidedMonoidalCategoriesTest_gd := "BraidedCartesianCategoriesTest.gd",
             MonoidalCategoriesTensorProductAndUnitMethodRecord_gi := fail,
             MonoidalCategoriesTensorProductAndUnit_gi := fail,
             MonoidalCategoriesTensorProductAndUnitTest_gi := fail,
             MonoidalCategoriesMethodRecord_gi := fail,
             MonoidalCategories_gi := "CartesianCategories.gi",
             MonoidalCategoriesTest_gi := "CartesianCategoriesTest.gi",
             AdditiveMonoidalCategoriesMethodRecord_gi := fail, 
             AdditiveMonoidalCategories_gi := "DistributiveCartesianCategories.gi",
             AdditiveMonoidalCategoriesTest_gi := "DistributiveCartesianCategoriesTest.gi",
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
WriteFileForLeftClosedMonoidalStructure(
        rec(
             IsMonoidalCategory := "IsCartesianCategory",
             IsStrictMonoidalCategory := "IsStrictCartesianCategory",
             IsBraidedMonoidalCategory := "IsCartesianCategory",
             IsSymmetricMonoidalCategory := "IsCartesianCategory",
             IsLeftClosedMonoidalCategory := "IsCartesianClosedCategory",
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
             LeftClosedMonoidalLambda := "CartesianLambda",
             LeftClosedMonoidalEvaluation := "CartesianEvaluation",
             LeftClosedMonoidalCoevaluation := "CartesianCoevaluation",
             LeftInternalHom := "Exponential",
             LeftClosedMonoidalCategories := "CartesianClosedCategories",
             LEFT_CLOSED_MONOIDAL := "CARTESIAN_CLOSED",
             LeftClosedMonoidal := "Cartesian",
             MONOIDAL := "CARTESIAN",
             Monoidal := "Cartesian",
             monoidal := "cartesian",
             LeftDual := "CartesianDual",
             LeftBidual := "CartesianBidual",
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
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"CartesianCategories\"",
             replace := [ [ "⊗",
                            "×" ],
                          [ "coHom(",
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
                               ## LeftClosedMonoidalCoevaluationMorphismWithGivenRange
                               [ "dual_operation := \"LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource\"",
                                 "dual_operation := \"CocartesianCoevaluationMorphismWithGivenSource\"" ],
                               ## LeftClosedMonoidalCoevaluationMorphism
                               [ "dual_operation := \"LeftCoclosedMonoidalCoevaluationMorphism\"",
                                 "dual_operation := \"CocartesianCoevaluationMorphism\"" ],
                               ## LeftDualOnMorphismsWithGivenLeftDuals
                               [ "dual_operation := \"LeftCoDualOnMorphismsWithGivenLeftCoDuals\"",
                                 "dual_operation := \"CocartesianDualOnMorphismsWithGivenCocartesianDuals\"" ],
                               ## LeftDualOnMorphisms
                               [ "dual_operation := \"LeftCoDualOnMorphisms\"",
                                 "dual_operation := \"CocartesianDualOnMorphisms\"" ],
                               ## LeftDualOnObjects
                               [ "dual_operation := \"LeftCoDualOnObjects\"",
                                 "dual_operation := \"CocartesianDualOnObjects\"" ],
                               ## EvaluationForLeftDualWithGivenTensorProduct
                               [ "dual_operation := \"LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct\"",
                                 "dual_operation := \"CocartesianEvaluationForCocartesianDualWithGivenCoproduct\"" ],
                               ## EvaluationForLeftDual
                               [ "dual_operation := \"LeftCoclosedMonoidalEvaluationForLeftCoDual\"",
                                 "dual_operation := \"CocartesianEvaluationForCocartesianDual\"" ],
                               ## LeftClosedMonoidalEvaluationMorphismWithGivenSource
                               [ "dual_operation := \"LeftCoclosedMonoidalEvaluationMorphismWithGivenRange\"",
                                 "dual_operation := \"CocartesianEvaluationMorphismWithGivenRange\"" ],
                               ## LeftClosedMonoidalEvaluationMorphism
                               [ "dual_operation := \"LeftCoclosedMonoidalEvaluationMorphism\"",
                                 "dual_operation := \"CocartesianEvaluationMorphism\"" ],
                               ## LeftInternalHomOnMorphismsWithGivenLeftInternalHoms
                               [ "dual_operation := \"LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms\"",
                                 "dual_operation := \"CoexponentialOnMorphismsWithGivenCoexponentials\"" ],
                               ## LeftInternalHomOnMorphisms
                               [ "dual_operation := \"LeftInternalCoHomOnMorphisms\"",
                                 "dual_operation := \"CoexponentialOnMorphisms\"" ],
                               ## LeftInternalHomOnObjects
                               [ "dual_operation := \"LeftInternalCoHomOnObjects\"",
                                 "dual_operation := \"CoexponentialOnObjects\"" ],
                               ## LeftInternalHomToTensorProductAdjunctionMap
                               [ "dual_operation := \"LeftInternalCoHomToTensorProductAdjunctionMap\"",
                                 "dual_operation := \"CoexponentialToCoproductAdjunctionMap\"" ],
                               ## LeftInternalHomToTensorProductAdjunctionMapWithGivenTensorProduct
                               [ "dual_operation := \"LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct\"",
                                 "dual_operation := \"CoexponentialToCoproductAdjunctionMapWithGivenCoproduct\"" ],
                               ## IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit
                               [ "dual_operation := \"IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject\"",
                                 "dual_operation := \"IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject\"" ],
                               ## IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject
                               [ "dual_operation := \"IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit\"",
                                 "dual_operation := \"IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject\"" ],
                               ## IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom
                               [ "dual_operation := \"IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom\"",
                                 "dual_operation := \"IsomorphismFromObjectToCoexponentialWithGivenCoexponential\"" ],
                               ## IsomorphismFromLeftInternalHomToObject
                               [ "dual_operation := \"IsomorphismFromObjectToLeftInternalCoHom\"",
                                 "dual_operation := \"IsomorphismFromObjectToCoexponential\"" ],
                               ## IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom
                               [ "dual_operation := \"IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom\"",
                                 "dual_operation := \"IsomorphismFromCoexponentialToObjectWithGivenCoexponential\"" ],
                               ## IsomorphismFromObjectToLeftInternalHom
                               [ "dual_operation := \"IsomorphismFromLeftInternalCoHomToObject\"",
                                 "dual_operation := \"IsomorphismFromCoexponentialToObject\"" ],
                               ## LeftClosedMonoidalLambdaElimination
                               [ "dual_operation := \"LeftCoclosedMonoidalLambdaElimination\"",
                                 "dual_operation := \"CocartesianLambdaElimination\"" ],
                               ## LeftClosedMonoidalLambdaIntroduction
                               [ "dual_operation := \"LeftCoclosedMonoidalLambdaIntroduction\"",
                                 "dual_operation := \"CocartesianLambdaIntroduction\"" ],
                               ## LeftClosedMonoidalPostComposeMorphismWithGivenObjects
                               [ "dual_operation := \"LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects\"",
                                 "dual_operation := \"CocartesianPostCoComposeMorphismWithGivenObjects\"" ],
                               ## LeftClosedMonoidalPostComposeMorphism
                               [ "dual_operation := \"LeftCoclosedMonoidalPostCoComposeMorphism\"",
                                 "dual_operation := \"CocartesianPostCoComposeMorphism\"" ],
                               ## LeftClosedMonoidalPreComposeMorphismWithGivenObjects
                               [ "dual_operation := \"LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects\"",
                                 "dual_operation := \"CocartesianPreCoComposeMorphismWithGivenObjects\"" ],
                               ## LeftClosedMonoidalPreComposeMorphism
                               [ "dual_operation := \"LeftCoclosedMonoidalPreCoComposeMorphism\"",
                                 "dual_operation := \"CocartesianPreCoComposeMorphism\"" ],
                               ## MorphismFromTensorProductToLeftInternalHomWithGivenObjects
                               [ "dual_operation := \"MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects\"",
                                 "dual_operation := \"MorphismFromCoexponentialToCoproductWithGivenObjects\"" ],
                               ## MorphismFromTensorProductToLeftInternalHom
                               [ "dual_operation := \"MorphismFromLeftInternalCoHomToTensorProduct\"",
                                 "dual_operation := \"MorphismFromCoexponentialToCoproduct\"" ],
                               ## MorphismToLeftBidualWithGivenLeftBidual
                               [ "dual_operation := \"MorphismFromLeftCoBidualWithGivenLeftCoBidual\"",
                                 "dual_operation := \"MorphismFromCocartesianBidualWithGivenCocartesianBidual\"" ],
                               ## MorphismToLeftBidual
                               [ "dual_operation := \"MorphismFromLeftCoBidual\"",
                                 "dual_operation := \"MorphismFromCocartesianBidual\"" ],
                               ## TensorProductLeftDualityCompatibilityMorphismWithGivenObjects
                               [ "dual_operation := \"LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects\"",
                                 "dual_operation := \"CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects\"" ],
                               ## TensorProductLeftDualityCompatibilityMorphism
                               [ "dual_operation := \"LeftCoDualityTensorProductCompatibilityMorphism\"",
                                 "dual_operation := \"CocartesianDualityCoproductCompatibilityMorphism\"" ],
                               ## TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects
                               [ "dual_operation := \"LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects\"",
                                 "dual_operation := \"CoexponentialCoproductCompatibilityMorphismWithGivenObjects\"" ],
                               ## TensorProductLeftInternalHomCompatibilityMorphism
                               [ "dual_operation := \"LeftInternalCoHomTensorProductCompatibilityMorphism\"",
                                 "dual_operation := \"CoexponentialCoproductCompatibilityMorphism\"" ],
                               ## TensorProductToLeftInternalHomAdjunctionMap
                               [ "dual_operation := \"TensorProductToLeftInternalCoHomAdjunctionMap\"",
                                 "dual_operation := \"CoproductToCoexponentialAdjunctionMap\"" ],
                               ## TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom
                               [ "dual_operation := \"TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom\"",
                                 "dual_operation := \"CoproductToCoexponentialAdjunctionMapWithGivenCoexponential\"" ],
                               ## UniversalPropertyOfLeftDual
                               [ "dual_operation := \"UniversalPropertyOfLeftCoDual\"",
                                 "dual_operation := \"UniversalPropertyOfCocartesianDual\"" ],
                               ##############################
                               ## Safe replacements for Tests
                               ##############################
                               ## Evalutions
                               [ "LeftCoclosedMonoidalEvaluationMorphism",
                                 "CocartesianEvaluationMorphism" ],
                               [ "LeftCoclosedMonoidalCoevaluationMorphism",
                                 "CocartesianCoevaluationMorphism" ],
                               ## AdjunctionMaps
                               [ "TensorProductToLeftInternalCoHomAdjunctionMap",
                                 "CoproductToCoexponentialAdjunctionMap" ],
                               [ "LeftInternalCoHomToTensorProductAdjunctionMap",
                                 "CoexponentialToCoproductAdjunctionMap" ],
                               ## MonoidalComposeMorphisms
                               [ "LeftCoclosedMonoidalPreCoComposeMorphism",
                                 "CocartesianPreCoComposeMorphism" ],
                               [ "LeftCoclosedMonoidalPostCoComposeMorphism",
                                 "CocartesianPostCoComposeMorphism" ],
                               # Codual
                               [ "LeftCoDualOnObjects",
                                 "CocartesianDualOnObjects" ],
                               [ "LeftCoDualOnMorphisms",
                                 "CocartesianDualOnMorphisms" ],
                               [ "UniversalPropertyOfLeftCoDual",
                                 "UniversalPropertyOfCocartesianDual" ],
                               # LeftCoclosedMonoidalEvaluationForCoDual
                               [ "LeftCoclosedMonoidalEvaluationForLeftCoDual",
                                 "CocartesianEvaluationForCocartesianDual" ],
                               # Cobidual
                               [ "MorphismFromLeftCoBidual",
                                 "MorphismFromCocartesianBidual" ],
                               # CompatibilityMorphisms
                               [ "LeftInternalCoHomTensorProductCompatibilityMorphism",
                                 "CoexponentialCoproductCompatibilityMorphism" ],
                               [ "LeftCoDualityTensorProductCompatibilityMorphism",
                                 "CocartesianDualityCoproductCompatibilityMorphism" ],
                               ## MorphismFromInternalCoHomToDirectProduct
                               [ "MorphismFromLeftInternalCoHomToTensorProduct",
                                 "MorphismFromCoexponentialToCoproduct" ],
                               ## Isomorphisms
                               [ "IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject",
                                 "IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject" ],
                               [ "IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit",
                                 "IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject" ],
                               ## Lambdas
                               [ "LeftCoclosedMonoidalLambdaIntroduction",
                                 "CocartesianLambdaIntroduction" ],
                               [ "LeftCoclosedMonoidalLambdaElimination",
                                 "CocartesianLambdaElimination" ],
                               ## InternalCoHom
                               [ "LeftInternalCoHom",
                                 "Coexponential" ],
                               ## TensorProduct
                               [ "TensorProductOnObjects( opposite",
                                 "Coproduct( opposite" ],
                               [ "TensorProductOnMorphisms( opposite",
                                 "CoproductOnMorphisms( opposite" ],
                               [ "TensorProduct( opposite",
                                 "Coproduct( opposite" ],
                               ],
             ),
        "CartesianCategories",
        rec( LeftClosedMonoidalCategories_gd := "CartesianClosedCategories.gd",
             LeftClosedMonoidalCategoriesTest_gd := "CartesianClosedCategoriesTest.gd",
             RigidSymmetricClosedMonoidalCategories_gd := fail,
             RigidSymmetricClosedMonoidalCategoriesTest_gd := fail,
             LeftClosedMonoidalCategoriesProperties_gi := "CartesianClosedCategoriesProperties.gi",
             LeftClosedMonoidalCategoriesMethodRecord_gi := "CartesianClosedCategoriesMethodRecord.gi",
             LeftClosedMonoidalCategories_gi := "CartesianClosedCategories.gi",
             LeftClosedMonoidalCategoriesTest_gi := "CartesianClosedCategoriesTest.gi",
             SymmetricClosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricClosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricClosedMonoidalCategoriesMethodRecord_gi := fail,
             RigidSymmetricClosedMonoidalCategories_gi := fail,
             RigidSymmetricClosedMonoidalCategoriesTest_gi := fail,
             LeftClosedMonoidalCategoriesDerivedMethods_gi := "CartesianClosedCategoriesDerivedMethods.gi",
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
             LeftCoclosedMonoidalLambda := "CocartesianLambda",
             LeftCoclosedMonoidalEvaluation := "CocartesianEvaluation",
             LeftCoclosedMonoidalCoevaluation := "CocartesianCoevaluation",
             MONOIDAL := "COCARTESIAN",
             Monoidal := "Cocartesian",
             monoidal := "cocartesian",
             DISTRIBUTIVE := "CODISTRIBUTIVE",
             tensor_object := "coproduct_object",
             tensored := "u",
             otimes := "sqcup",
             oplus := "times",
             tensor_product := "coproduct",
             tensorSproduct := "coproduct",
             AdditiveS := "",
             BraidedS := "",
             TensorProductOnObjectsBCcat := "BinaryCoproduct( cat,",
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"CartesianCategories\"",
             replace := [ [ "⊗",
                            "⊔" ],
                          ],
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
                               ## LeftDistributivityExpanding
                               [ "LeftDistributivityExpanding( opposite",
                                 "LeftCartesianDistributivityExpanding( opposite" ],
                               ## LeftDistributivityFactoring
                               [ "LeftDistributivityFactoring( opposite",
                                 "LeftCartesianDistributivityFactoring( opposite" ],
                               ## RightDistributivityExpanding
                               [ "RightDistributivityExpanding( opposite",
                                 "RightCartesianDistributivityExpanding( opposite" ],
                               ## RightDistributivityFactoring
                               [ "RightDistributivityFactoring( opposite",
                                 "RightCartesianDistributivityFactoring( opposite" ],
                               ],
             ),
        "CartesianCategories",
        rec( MonoidalCategoriesTensorProductAndUnit_gd := fail,
             MonoidalCategoriesTensorProductAndUnitTest_gd := fail,
             MonoidalCategories_gd := "CocartesianCategories.gd",
             MonoidalCategoriesTest_gd := "CocartesianCategoriesTest.gd",
             AdditiveMonoidalCategories_gd := "CodistributiveCocartesianCategories.gd",
             AdditiveMonoidalCategoriesTest_gd := "CodistributiveCocartesianCategoriesTest.gd",
             BraidedMonoidalCategories_gd := "BraidedCocartesianCategories.gd",
             BraidedMonoidalCategoriesTest_gd := "BraidedCocartesianCategoriesTest.gd",
             MonoidalCategoriesTensorProductAndUnitMethodRecord_gi := fail,
             MonoidalCategoriesTensorProductAndUnit_gi := fail,
             MonoidalCategoriesTensorProductAndUnitTest_gi := fail,
             MonoidalCategoriesMethodRecord_gi := fail,
             MonoidalCategories_gi := "CocartesianCategories.gi",
             MonoidalCategoriesTest_gi := "CocartesianCategoriesTest.gi",
             AdditiveMonoidalCategoriesMethodRecord_gi := fail,
             AdditiveMonoidalCategories_gi := "CodistributiveCocartesianCategories.gi",
             AdditiveMonoidalCategoriesTest_gi := "CodistributiveCocartesianCategoriesTest.gi",
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
WriteFileForLeftCoclosedMonoidalStructure(
        rec(
             IsMonoidalCategory := "IsCocartesianCategory",
             IsStrictMonoidalCategory := "IsStrictCocartesianCategory",
             IsBraidedMonoidalCategory := "IsCocartesianCategory",
             IsSymmetricMonoidalCategory := "IsCocartesianCategory",
             IsLeftCoclosedMonoidalCategory := "IsCocartesianCoclosedCategory",
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
             LeftCoclosedMonoidalLambda := "CocartesianLambda",
             LeftCoclosedMonoidalEvaluation := "CocartesianEvaluation",
             LeftCoclosedMonoidalCoevaluation := "CocartesianCoevaluation",
             LeftInternalCoHom := "Coexponential",
             LeftCoclosedMonoidalCategories := "CocartesianCoclosedCategories",
             LEFT_COCLOSED_MONOIDAL := "COCARTESIAN_COCLOSED",
             LeftCoclosedMonoidal := "Cocartesian",
             MONOIDAL := "COCARTESIAN",
             Monoidal := "Cocartesian",
             monoidal := "cocartesian",
             LeftCoDual := "CocartesianDual",
             LeftCoBidual := "CocartesianBidual",
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
             CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE := "METHOD_NAME_RECORD, \"CartesianCategories\"",
             replace := [ [ "⊗",
                            "⊔" ],
                          [ "coHom(",
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
                               ## LeftCoclosedMonoidalCoevaluationMorphismWithGivenSource
                               [ "dual_operation := \"LeftClosedMonoidalCoevaluationMorphismWithGivenRange\"",
                                 "dual_operation := \"CartesianCoevaluationMorphismWithGivenRange\"" ],
                               ## LeftCoclosedMonoidalCoevaluationMorphism
                               [ "dual_operation := \"LeftClosedMonoidalCoevaluationMorphism\"",
                                 "dual_operation := \"CartesianCoevaluationMorphism\"" ],
                               ## LeftCoDualOnMorphismsWithGivenLeftCoDuals
                               [ "dual_operation := \"LeftDualOnMorphismsWithGivenLeftDuals\"",
                                 "dual_operation := \"CartesianDualOnMorphismsWithGivenCartesianDuals\"" ],
                               ## LeftCoDualOnMorphisms
                               [ "dual_operation := \"LeftDualOnMorphisms\"",
                                 "dual_operation := \"CartesianDualOnMorphisms\"" ],
                               ## LeftCoDualOnObjects
                               [ "dual_operation := \"LeftDualOnObjects\"",
                                 "dual_operation := \"CartesianDualOnObjects\"" ],
                               ## LeftCoclosedMonoidalEvaluationForLeftCoDualWithGivenTensorProduct
                               [ "dual_operation := \"LeftClosedMonoidalEvaluationForLeftDualWithGivenTensorProduct\"",
                                 "dual_operation := \"CartesianEvaluationForCartesianDualWithGivenDirectProduct\"" ],
                               ## LeftCoclosedMonoidalEvaluationForLeftCoDual
                               [ "dual_operation := \"LeftClosedMonoidalEvaluationForLeftDual\"",
                                 "dual_operation := \"CartesianEvaluationForCartesianDual\"" ],
                               ## LeftCoclosedMonoidalEvaluationMorphismWithGivenRange
                               [ "dual_operation := \"LeftClosedMonoidalEvaluationMorphismWithGivenSource\"",
                                 "dual_operation := \"CartesianEvaluationMorphismWithGivenSource\"" ],
                               ## LeftCoclosedMonoidalEvaluationMorphism
                               [ "dual_operation := \"LeftClosedMonoidalEvaluationMorphism\"",
                                 "dual_operation := \"CartesianEvaluationMorphism\"" ],
                               ## LeftInternalCoHomOnMorphismsWithGivenLeftInternalCoHoms
                               [ "dual_operation := \"LeftInternalHomOnMorphismsWithGivenLeftInternalHoms\"",
                                 "dual_operation := \"ExponentialOnMorphismsWithGivenExponentials\"" ],
                               ## LeftInternalCoHomOnMorphisms
                               [ "dual_operation := \"LeftInternalHomOnMorphisms\"",
                                 "dual_operation := \"ExponentialOnMorphisms\"" ],
                               ## LeftInternalCoHomOnObjects
                               [ "dual_operation := \"LeftInternalHomOnObjects\"",
                                 "dual_operation := \"ExponentialOnObjects\"" ],
                               ## LeftInternalCoHomToTensorProductAdjunctionMap
                               [ "dual_operation := \"LeftInternalHomToTensorProductAdjunctionMap\"",
                                 "dual_operation := \"ExponentialToDirectProductAdjunctionMap\"" ],
                               ## LeftInternalCoHomToTensorProductAdjunctionMapWithGivenTensorProduct
                               [ "dual_operation := \"LeftInternalHomToTensorProductAdjunctionMapWithGivenTensorProduct\"",
                                 "dual_operation := \"ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct\"" ],
                               ## IsomorphismFromLeftInternalCoHomFromTensorUnitToLeftCoDualObject
                               [ "dual_operation := \"IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit\"",
                                 "dual_operation := \"IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject\"" ],
                               ## IsomorphismFromLeftCoDualObjectToLeftInternalCoHomFromTensorUnit
                               [ "dual_operation := \"IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject\"",
                                 "dual_operation := \"IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject\"" ],
                               ## IsomorphismFromObjectToLeftInternalCoHomWithGivenLeftInternalCoHom
                               [ "dual_operation := \"IsomorphismFromLeftInternalHomToObjectWithGivenLeftInternalHom\"",
                                 "dual_operation := \"IsomorphismFromExponentialToObjectWithGivenExponential\"" ],
                               ## IsomorphismFromObjectToLeftInternalCoHom
                               [ "dual_operation := \"IsomorphismFromLeftInternalHomToObject\"",
                                 "dual_operation := \"IsomorphismFromExponentialToObject\"" ],
                               ## IsomorphismFromLeftInternalCoHomToObjectWithGivenLeftInternalCoHom
                               [ "dual_operation := \"IsomorphismFromObjectToLeftInternalHomWithGivenLeftInternalHom\"",
                                 "dual_operation := \"IsomorphismFromObjectToExponentialWithGivenExponential\"" ],
                               ## IsomorphismFromLeftInternalCoHomToObject
                               [ "dual_operation := \"IsomorphismFromObjectToLeftInternalHom\"",
                                 "dual_operation := \"IsomorphismFromObjectToExponential\"" ],
                               ## LeftCoclosedMonoidalLambdaElimination
                               [ "dual_operation := \"LeftClosedMonoidalLambdaElimination\"",
                                 "dual_operation := \"CartesianLambdaElimination\"" ],
                               ## LeftCoclosedMonoidalLambdaIntroduction
                               [ "dual_operation := \"LeftClosedMonoidalLambdaIntroduction\"",
                                 "dual_operation := \"CartesianLambdaIntroduction\"" ],
                               ## LeftCoclosedMonoidalPostCoComposeMorphismWithGivenObjects
                               [ "dual_operation := \"LeftClosedMonoidalPostComposeMorphismWithGivenObjects\"",
                                 "dual_operation := \"CartesianPostComposeMorphismWithGivenObjects\"" ],
                               ## LeftCoclosedMonoidalPostCoComposeMorphism
                               [ "dual_operation := \"LeftClosedMonoidalPostComposeMorphism\"",
                                 "dual_operation := \"CartesianPostComposeMorphism\"" ],
                               ## LeftCoclosedMonoidalPreCoComposeMorphismWithGivenObjects
                               [ "dual_operation := \"LeftClosedMonoidalPreComposeMorphismWithGivenObjects\"",
                                 "dual_operation := \"CartesianPreComposeMorphismWithGivenObjects\"" ],
                               ## LeftCoclosedMonoidalPreCoComposeMorphism
                               [ "dual_operation := \"LeftClosedMonoidalPreComposeMorphism\"",
                                 "dual_operation := \"CartesianPreComposeMorphism\"" ],
                               ## MorphismFromLeftInternalCoHomToTensorProductWithGivenObjects
                               [ "dual_operation := \"MorphismFromTensorProductToLeftInternalHomWithGivenObjects\"",
                                 "dual_operation := \"MorphismFromDirectProductToExponentialWithGivenObjects\"" ],
                               ## MorphismFromLeftInternalCoHomToTensorProduct
                               [ "dual_operation := \"MorphismFromTensorProductToLeftInternalHom\"",
                                 "dual_operation := \"MorphismFromDirectProductToExponential\"" ],
                               ## MorphismFromLeftCoBidualWithGivenLeftCoBidual
                               [ "dual_operation := \"MorphismToLeftBidualWithGivenLeftBidual\"",
                                 "dual_operation := \"MorphismToCartesianBidualWithGivenCartesianBidual\"" ],
                               ## MorphismFromLeftCoBidual
                               [ "dual_operation := \"MorphismToLeftBidual\"",
                                 "dual_operation := \"MorphismToCartesianBidual\"" ],
                               ## LeftCoDualityTensorProductCompatibilityMorphismWithGivenObjects
                               [ "dual_operation := \"TensorProductLeftDualityCompatibilityMorphismWithGivenObjects\"",
                                 "dual_operation := \"DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects\"" ],
                               ## LeftCoDualityTensorProductCompatibilityMorphism
                               [ "dual_operation := \"TensorProductLeftDualityCompatibilityMorphism\"",
                                 "dual_operation := \"DirectProductCartesianDualityCompatibilityMorphism\"" ],
                               ## LeftInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects
                               [ "dual_operation := \"TensorProductLeftInternalHomCompatibilityMorphismWithGivenObjects\"",
                                 "dual_operation := \"DirectProductExponentialCompatibilityMorphismWithGivenObjects\"" ],
                               ## LeftInternalCoHomTensorProductCompatibilityMorphism
                               [ "dual_operation := \"TensorProductLeftInternalHomCompatibilityMorphism\"",
                                 "dual_operation := \"DirectProductExponentialCompatibilityMorphism\"" ],
                               ## TensorProductToLeftInternalCoHomAdjunctionMap
                               [ "dual_operation := \"TensorProductToLeftInternalHomAdjunctionMap\"",
                                 "dual_operation := \"DirectProductToExponentialAdjunctionMap\"" ],
                               ## TensorProductToLeftInternalCoHomAdjunctionMapWithGivenLeftInternalCoHom
                               [ "dual_operation := \"TensorProductToLeftInternalHomAdjunctionMapWithGivenLeftInternalHom\"",
                                 "dual_operation := \"DirectProductToExponentialAdjunctionMapWithGivenExponential\"" ],
                               ## UniversalPropertyOfLeftCoDual
                               [ "dual_operation := \"UniversalPropertyOfLeftDual\"",
                                 "dual_operation := \"UniversalPropertyOfCartesianDual\"" ],
                               [ "LEFT_CLOSED_AND_LEFT_COCLOSED_MONOIDAL_CATEGORIES",
                                 "CARTESIAN_CLOSED_AND_COCARTESIAN_COCLOSED_CATEGORIES" ],
                               [ "LEFT_COCLOSED_MONOIDAL_CATEGORIES_METHOD",
                                 "COCARTESIAN_COCLOSED_CATEGORIES_METHOD" ],
                               [ "LEFT_CLOSED_MONOIDAL_CATEGORIES",
                                 "CARTESIAN_CLOSED_CATEGORIES" ],
                               [ "LeftCoclosedMonoidalCategories.autogen.gd",
                                 "CocartesianCoclosedCategories.autogen.gd" ],
                               [ "\"LeftClosedMonoidalCategories.autogen.gd\", \"Monoidal Categories\"",
                                 "\"CartesianClosedCategories.autogen.gd\", \"Cartesian Categories\"" ],
                               ##############################
                               ## Safe replacements for Tests
                               ##############################
                               ## Evalutions
                               [ " LeftClosedMonoidalEvaluationMorphism",
                                 " CartesianEvaluationMorphism" ],
                               [ " LeftClosedMonoidalCoevaluationMorphism",
                                 " CartesianCoevaluationMorphism" ],
                               ## AdjunctionMaps
                               [ "TensorProductToLeftInternalHomAdjunctionMap",
                                 "DirectProductToExponentialAdjunctionMap" ],
                               [ "LeftInternalHomToTensorProductAdjunctionMap",
                                 "ExponentialToDirectProductAdjunctionMap" ],
                               ## MonoidalComposeMorphisms
                               [ "LeftClosedMonoidalPreComposeMorphism",
                                 "CartesianPreComposeMorphism" ],
                               [ "LeftClosedMonoidalPostComposeMorphism",
                                 "CartesianPostComposeMorphism" ],
                               # Dual
                               [ " LeftDualOnObjects",
                                 " CartesianDualOnObjects" ],
                               [ " LeftDualOnMorphisms",
                                 " CartesianDualOnMorphisms" ],
                               [ "UniversalPropertyOfLeftDual",
                                 "UniversalPropertyOfCartesianDual" ],
                               # EvaluationForDual
                               [ " LeftClosedMonoidalEvaluationForLeftDual",
                                 " CartesianEvaluationForCartesianDual" ],
                               # Bidual
                               [ "MorphismToLeftBidual",
                                 "MorphismToCartesianBidual" ],
                               # CompatibilityMorphisms
                               [ "TensorProductLeftInternalHomCompatibilityMorphism",
                                 "DirectProductExponentialCompatibilityMorphism" ],
                               [ "TensorProductLeftDualityCompatibilityMorphism",
                                 "DirectProductCartesianDualityCompatibilityMorphism" ],
                               ## MorphismFromTensorProductToLeftInternalHom
                               [ "MorphismFromTensorProductToLeftInternalHom",
                                 "MorphismFromDirectProductToExponential" ],
                               ## Isomorphisms
                               [ "IsomorphismFromLeftInternalHomIntoTensorUnitToLeftDualObject",
                                 "IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject" ],
                               [ "IsomorphismFromLeftDualObjectToLeftInternalHomIntoTensorUnit",
                                 "IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject" ],
                               ## Lambdas
                               [ " LeftClosedMonoidalLambdaElimination",
                                 " CartesianLambdaElimination" ],
                               [ " LeftClosedMonoidalLambdaIntroduction",
                                 " CartesianLambdaIntroduction" ],
                               ## InternalHom
                               [ "LeftInternalHom",
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
        "CartesianCategories",
        rec( LeftCoclosedMonoidalCategories_gd := "CocartesianCoclosedCategories.gd",
             LeftCoclosedMonoidalCategoriesTest_gd := "CocartesianCoclosedCategoriesTest.gd",
             RigidSymmetricCoclosedMonoidalCategories_gd := fail,
             RigidSymmetricCoclosedMonoidalCategoriesTest_gd := fail,
             LeftCoclosedMonoidalCategoriesProperties_gi := "CocartesianCoclosedCategoriesProperties.gi",
             LeftCoclosedMonoidalCategoriesMethodRecord_gi := "CocartesianCoclosedCategoriesMethodRecord.gi",
             LeftCoclosedMonoidalCategories_gi := "CocartesianCoclosedCategories.gi",
             LeftCoclosedMonoidalCategoriesTest_gi := "CocartesianCoclosedCategoriesTest.gi",
             SymmetricCoclosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricCoclosedMonoidalCategoriesProperties_gi := fail,
             RigidSymmetricCoclosedMonoidalCategoriesMethodRecord_gi := fail,
             RigidSymmetricCoclosedMonoidalCategories_gi := fail,
             RigidSymmetricCoclosedMonoidalCategoriesTest_gi := fail,
             LeftCoclosedMonoidalCategoriesDerivedMethods_gi := "CocartesianCoclosedCategoriesDerivedMethods.gi",
             SymmetricCoclosedMonoidalCategoriesDerivedMethods_gi := "SymmetricCocartesianCoclosedCategoriesDerivedMethods.gi",
             RigidSymmetricCoclosedMonoidalCategoriesDerivedMethods_gi := fail,
             )
        );

end );
