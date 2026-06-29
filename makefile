all: doc test

ci-test: ci-test_all_packages

# BEGIN PACKAGE JANITOR
################################
doc: doc_CAP doc_ActionsForCAP doc_AdditiveClosuresForCAP doc_AttributeCategoryForCAP doc_CartesianCategories doc_CompilerForCAP doc_ComplexesAndFilteredObjectsForCAP doc_FreydCategoriesForCAP doc_GeneralizedMorphismsForCAP doc_GradedModulePresentationsForCAP doc_GroupRepresentationsForCAP doc_GroupsAsCategoriesForCAP doc_HomologicalAlgebraForCAP doc_InternalExteriorAlgebraForCAP doc_LinearAlgebraForCAP doc_LinearClosuresForCAP doc_ModulePresentationsForCAP doc_ModulesOverLocalRingsForCAP doc_MonoidalCategories doc_ToricSheaves

doc_CAP:
	$(MAKE) -C CAP doc

doc_ActionsForCAP:
	$(MAKE) -C ActionsForCAP doc

doc_AdditiveClosuresForCAP:
	$(MAKE) -C AdditiveClosuresForCAP doc

doc_AttributeCategoryForCAP:
	$(MAKE) -C AttributeCategoryForCAP doc

doc_CartesianCategories:
	$(MAKE) -C CartesianCategories doc

doc_CompilerForCAP:
	$(MAKE) -C CompilerForCAP doc

doc_ComplexesAndFilteredObjectsForCAP:
	$(MAKE) -C ComplexesAndFilteredObjectsForCAP doc

doc_FreydCategoriesForCAP:
	$(MAKE) -C FreydCategoriesForCAP doc

doc_GeneralizedMorphismsForCAP:
	$(MAKE) -C GeneralizedMorphismsForCAP doc

doc_GradedModulePresentationsForCAP:
	$(MAKE) -C GradedModulePresentationsForCAP doc

doc_GroupRepresentationsForCAP:
	$(MAKE) -C GroupRepresentationsForCAP doc

doc_GroupsAsCategoriesForCAP:
	$(MAKE) -C GroupsAsCategoriesForCAP doc

doc_HomologicalAlgebraForCAP:
	$(MAKE) -C HomologicalAlgebraForCAP doc

doc_InternalExteriorAlgebraForCAP:
	$(MAKE) -C InternalExteriorAlgebraForCAP doc

doc_LinearAlgebraForCAP:
	$(MAKE) -C LinearAlgebraForCAP doc

doc_LinearClosuresForCAP:
	$(MAKE) -C LinearClosuresForCAP doc

doc_ModulePresentationsForCAP:
	$(MAKE) -C ModulePresentationsForCAP doc

doc_ModulesOverLocalRingsForCAP:
	$(MAKE) -C ModulesOverLocalRingsForCAP doc

doc_MonoidalCategories:
	$(MAKE) -C MonoidalCategories doc

doc_ToricSheaves:
	$(MAKE) -C ToricSheaves doc

################################
test: doc test_CAP test_ActionsForCAP test_AdditiveClosuresForCAP test_AttributeCategoryForCAP test_CartesianCategories test_CompilerForCAP test_ComplexesAndFilteredObjectsForCAP test_FreydCategoriesForCAP test_GeneralizedMorphismsForCAP test_GradedModulePresentationsForCAP test_GroupRepresentationsForCAP test_GroupsAsCategoriesForCAP test_HomologicalAlgebraForCAP test_InternalExteriorAlgebraForCAP test_LinearAlgebraForCAP test_LinearClosuresForCAP test_ModulePresentationsForCAP test_ModulesOverLocalRingsForCAP test_MonoidalCategories test_ToricSheaves

test_CAP:
	$(MAKE) -C CAP test

test_ActionsForCAP:
	$(MAKE) -C ActionsForCAP test

test_AdditiveClosuresForCAP:
	$(MAKE) -C AdditiveClosuresForCAP test

test_AttributeCategoryForCAP:
	$(MAKE) -C AttributeCategoryForCAP test

test_CartesianCategories:
	$(MAKE) -C CartesianCategories test

test_CompilerForCAP:
	$(MAKE) -C CompilerForCAP test

test_ComplexesAndFilteredObjectsForCAP:
	$(MAKE) -C ComplexesAndFilteredObjectsForCAP test

test_FreydCategoriesForCAP:
	$(MAKE) -C FreydCategoriesForCAP test

test_GeneralizedMorphismsForCAP:
	$(MAKE) -C GeneralizedMorphismsForCAP test

test_GradedModulePresentationsForCAP:
	$(MAKE) -C GradedModulePresentationsForCAP test

test_GroupRepresentationsForCAP:
	$(MAKE) -C GroupRepresentationsForCAP test

test_GroupsAsCategoriesForCAP:
	$(MAKE) -C GroupsAsCategoriesForCAP test

test_HomologicalAlgebraForCAP:
	$(MAKE) -C HomologicalAlgebraForCAP test

test_InternalExteriorAlgebraForCAP:
	$(MAKE) -C InternalExteriorAlgebraForCAP test

test_LinearAlgebraForCAP:
	$(MAKE) -C LinearAlgebraForCAP test

test_LinearClosuresForCAP:
	$(MAKE) -C LinearClosuresForCAP test

test_ModulePresentationsForCAP:
	$(MAKE) -C ModulePresentationsForCAP test

test_ModulesOverLocalRingsForCAP:
	$(MAKE) -C ModulesOverLocalRingsForCAP test

test_MonoidalCategories:
	$(MAKE) -C MonoidalCategories test

test_ToricSheaves:
	$(MAKE) -C ToricSheaves test

################################
ci-test_all_packages: ci-test_CAP ci-test_ActionsForCAP ci-test_AdditiveClosuresForCAP ci-test_AttributeCategoryForCAP ci-test_CartesianCategories ci-test_CompilerForCAP ci-test_ComplexesAndFilteredObjectsForCAP ci-test_FreydCategoriesForCAP ci-test_GeneralizedMorphismsForCAP ci-test_GradedModulePresentationsForCAP ci-test_GroupRepresentationsForCAP ci-test_GroupsAsCategoriesForCAP ci-test_HomologicalAlgebraForCAP ci-test_InternalExteriorAlgebraForCAP ci-test_LinearAlgebraForCAP ci-test_LinearClosuresForCAP ci-test_ModulePresentationsForCAP ci-test_ModulesOverLocalRingsForCAP ci-test_MonoidalCategories ci-test_ToricSheaves

ci-test_CAP:
	$(MAKE) -C CAP ci-test

ci-test_ActionsForCAP:
	$(MAKE) -C ActionsForCAP ci-test

ci-test_AdditiveClosuresForCAP:
	$(MAKE) -C AdditiveClosuresForCAP ci-test

ci-test_AttributeCategoryForCAP:
	$(MAKE) -C AttributeCategoryForCAP ci-test

ci-test_CartesianCategories:
	$(MAKE) -C CartesianCategories ci-test

ci-test_CompilerForCAP:
	$(MAKE) -C CompilerForCAP ci-test

ci-test_ComplexesAndFilteredObjectsForCAP:
	$(MAKE) -C ComplexesAndFilteredObjectsForCAP ci-test

ci-test_FreydCategoriesForCAP:
	$(MAKE) -C FreydCategoriesForCAP ci-test

ci-test_GeneralizedMorphismsForCAP:
	$(MAKE) -C GeneralizedMorphismsForCAP ci-test

ci-test_GradedModulePresentationsForCAP:
	$(MAKE) -C GradedModulePresentationsForCAP ci-test

ci-test_GroupRepresentationsForCAP:
	$(MAKE) -C GroupRepresentationsForCAP ci-test

ci-test_GroupsAsCategoriesForCAP:
	$(MAKE) -C GroupsAsCategoriesForCAP ci-test

ci-test_HomologicalAlgebraForCAP:
	$(MAKE) -C HomologicalAlgebraForCAP ci-test

ci-test_InternalExteriorAlgebraForCAP:
	$(MAKE) -C InternalExteriorAlgebraForCAP ci-test

ci-test_LinearAlgebraForCAP:
	$(MAKE) -C LinearAlgebraForCAP ci-test

ci-test_LinearClosuresForCAP:
	$(MAKE) -C LinearClosuresForCAP ci-test

ci-test_ModulePresentationsForCAP:
	$(MAKE) -C ModulePresentationsForCAP ci-test

ci-test_ModulesOverLocalRingsForCAP:
	$(MAKE) -C ModulesOverLocalRingsForCAP ci-test

ci-test_MonoidalCategories:
	$(MAKE) -C MonoidalCategories ci-test

ci-test_ToricSheaves:
	$(MAKE) -C ToricSheaves ci-test

################################
match_tests_to_examples: match_tests_to_examples_CAP match_tests_to_examples_ActionsForCAP match_tests_to_examples_AdditiveClosuresForCAP match_tests_to_examples_AttributeCategoryForCAP match_tests_to_examples_CartesianCategories match_tests_to_examples_CompilerForCAP match_tests_to_examples_ComplexesAndFilteredObjectsForCAP match_tests_to_examples_FreydCategoriesForCAP match_tests_to_examples_GeneralizedMorphismsForCAP match_tests_to_examples_GradedModulePresentationsForCAP match_tests_to_examples_GroupRepresentationsForCAP match_tests_to_examples_GroupsAsCategoriesForCAP match_tests_to_examples_HomologicalAlgebraForCAP match_tests_to_examples_InternalExteriorAlgebraForCAP match_tests_to_examples_LinearAlgebraForCAP match_tests_to_examples_LinearClosuresForCAP match_tests_to_examples_ModulePresentationsForCAP match_tests_to_examples_ModulesOverLocalRingsForCAP match_tests_to_examples_MonoidalCategories match_tests_to_examples_ToricSheaves

match_tests_to_examples_CAP:
	$(MAKE) -C CAP match_tests_to_examples

match_tests_to_examples_ActionsForCAP:
	$(MAKE) -C ActionsForCAP match_tests_to_examples

match_tests_to_examples_AdditiveClosuresForCAP:
	$(MAKE) -C AdditiveClosuresForCAP match_tests_to_examples

match_tests_to_examples_AttributeCategoryForCAP:
	$(MAKE) -C AttributeCategoryForCAP match_tests_to_examples

match_tests_to_examples_CartesianCategories:
	$(MAKE) -C CartesianCategories match_tests_to_examples

match_tests_to_examples_CompilerForCAP:
	$(MAKE) -C CompilerForCAP match_tests_to_examples

match_tests_to_examples_ComplexesAndFilteredObjectsForCAP:
	$(MAKE) -C ComplexesAndFilteredObjectsForCAP match_tests_to_examples

match_tests_to_examples_FreydCategoriesForCAP:
	$(MAKE) -C FreydCategoriesForCAP match_tests_to_examples

match_tests_to_examples_GeneralizedMorphismsForCAP:
	$(MAKE) -C GeneralizedMorphismsForCAP match_tests_to_examples

match_tests_to_examples_GradedModulePresentationsForCAP:
	$(MAKE) -C GradedModulePresentationsForCAP match_tests_to_examples

match_tests_to_examples_GroupRepresentationsForCAP:
	$(MAKE) -C GroupRepresentationsForCAP match_tests_to_examples

match_tests_to_examples_GroupsAsCategoriesForCAP:
	$(MAKE) -C GroupsAsCategoriesForCAP match_tests_to_examples

match_tests_to_examples_HomologicalAlgebraForCAP:
	$(MAKE) -C HomologicalAlgebraForCAP match_tests_to_examples

match_tests_to_examples_InternalExteriorAlgebraForCAP:
	$(MAKE) -C InternalExteriorAlgebraForCAP match_tests_to_examples

match_tests_to_examples_LinearAlgebraForCAP:
	$(MAKE) -C LinearAlgebraForCAP match_tests_to_examples

match_tests_to_examples_LinearClosuresForCAP:
	$(MAKE) -C LinearClosuresForCAP match_tests_to_examples

match_tests_to_examples_ModulePresentationsForCAP:
	$(MAKE) -C ModulePresentationsForCAP match_tests_to_examples

match_tests_to_examples_ModulesOverLocalRingsForCAP:
	$(MAKE) -C ModulesOverLocalRingsForCAP match_tests_to_examples

match_tests_to_examples_MonoidalCategories:
	$(MAKE) -C MonoidalCategories match_tests_to_examples

match_tests_to_examples_ToricSheaves:
	$(MAKE) -C ToricSheaves match_tests_to_examples
# END PACKAGE JANITOR
