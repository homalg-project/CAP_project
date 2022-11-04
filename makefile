all: homalg_compatibility doc test

.PHONY: test

homalg_compatibility:
	gap load_cap_sheaves.g
	gap load_sheaves_cap.g

# BEGIN PACKAGE JANITOR
doc: doc_CAP doc_ActionsForCAP doc_AttributeCategoryForCAP doc_CartesianCategories doc_CompilerForCAP doc_ComplexesAndFilteredObjectsForCAP doc_DeductiveSystemForCAP doc_FreydCategoriesForCAP doc_GeneralizedMorphismsForCAP doc_GradedModulePresentationsForCAP doc_GroupRepresentationsForCAP doc_HomologicalAlgebraForCAP doc_InternalExteriorAlgebraForCAP doc_LinearAlgebraForCAP doc_ModulePresentationsForCAP doc_ModulesOverLocalRingsForCAP doc_MonoidalCategories doc_ToricSheaves

doc_CAP:
	$(MAKE) -C CAP doc

doc_ActionsForCAP:
	$(MAKE) -C ActionsForCAP doc

doc_AttributeCategoryForCAP:
	$(MAKE) -C AttributeCategoryForCAP doc

doc_CartesianCategories:
	$(MAKE) -C CartesianCategories doc

doc_CompilerForCAP:
	$(MAKE) -C CompilerForCAP doc

doc_ComplexesAndFilteredObjectsForCAP:
	$(MAKE) -C ComplexesAndFilteredObjectsForCAP doc

doc_DeductiveSystemForCAP:
	$(MAKE) -C DeductiveSystemForCAP doc

doc_FreydCategoriesForCAP:
	$(MAKE) -C FreydCategoriesForCAP doc

doc_GeneralizedMorphismsForCAP:
	$(MAKE) -C GeneralizedMorphismsForCAP doc

doc_GradedModulePresentationsForCAP:
	$(MAKE) -C GradedModulePresentationsForCAP doc

doc_GroupRepresentationsForCAP:
	$(MAKE) -C GroupRepresentationsForCAP doc

doc_HomologicalAlgebraForCAP:
	$(MAKE) -C HomologicalAlgebraForCAP doc

doc_InternalExteriorAlgebraForCAP:
	$(MAKE) -C InternalExteriorAlgebraForCAP doc

doc_LinearAlgebraForCAP:
	$(MAKE) -C LinearAlgebraForCAP doc

doc_ModulePresentationsForCAP:
	$(MAKE) -C ModulePresentationsForCAP doc

doc_ModulesOverLocalRingsForCAP:
	$(MAKE) -C ModulesOverLocalRingsForCAP doc

doc_MonoidalCategories:
	$(MAKE) -C MonoidalCategories doc

doc_ToricSheaves:
	$(MAKE) -C ToricSheaves doc

# END PACKAGE JANITOR

########################################
test: homalg_compatibility doc test_CAP test_ActionsForCAP test_AttributeCategoryForCAP test_CartesianCategories test_CompilerForCAP test_ComplexesAndFilteredObjectsForCAP test_DeductiveSystemForCAP test_FreydCategoriesForCAP test_GeneralizedMorphismsForCAP test_GradedModulePresentationsForCAP test_GroupRepresentationsForCAP test_HomologicalAlgebraForCAP test_InternalExteriorAlgebraForCAP test_LinearAlgebraForCAP test_ModulePresentationsForCAP test_ModulesOverLocalRingsForCAP test_MonoidalCategories test_ToricSheaves

test_CAP:
	$(MAKE) -C CAP test

test_ActionsForCAP:
	$(MAKE) -C ActionsForCAP test

test_AttributeCategoryForCAP:
	$(MAKE) -C AttributeCategoryForCAP test

test_CartesianCategories:
	$(MAKE) -C CartesianCategories test

test_CompilerForCAP:
	$(MAKE) -C CompilerForCAP test

test_ComplexesAndFilteredObjectsForCAP:
	$(MAKE) -C ComplexesAndFilteredObjectsForCAP test

test_DeductiveSystemForCAP:
	$(MAKE) -C DeductiveSystemForCAP test

test_FreydCategoriesForCAP:
	$(MAKE) -C FreydCategoriesForCAP test

test_GeneralizedMorphismsForCAP:
	$(MAKE) -C GeneralizedMorphismsForCAP test

test_GradedModulePresentationsForCAP:
	$(MAKE) -C GradedModulePresentationsForCAP test

test_GroupRepresentationsForCAP:
	$(MAKE) -C GroupRepresentationsForCAP test

test_HomologicalAlgebraForCAP:
	$(MAKE) -C HomologicalAlgebraForCAP test

test_InternalExteriorAlgebraForCAP:
	$(MAKE) -C InternalExteriorAlgebraForCAP test

test_LinearAlgebraForCAP:
	$(MAKE) -C LinearAlgebraForCAP test

test_ModulePresentationsForCAP:
	$(MAKE) -C ModulePresentationsForCAP test

test_ModulesOverLocalRingsForCAP:
	$(MAKE) -C ModulesOverLocalRingsForCAP test

test_MonoidalCategories:
	$(MAKE) -C MonoidalCategories test

test_ToricSheaves:
	$(MAKE) -C ToricSheaves test

########################################
ci-test: homalg_compatibility doc ci-test_CAP ci-test_ActionsForCAP ci-test_AttributeCategoryForCAP ci-test_CartesianCategories ci-test_CompilerForCAP ci-test_ComplexesAndFilteredObjectsForCAP ci-test_DeductiveSystemForCAP ci-test_FreydCategoriesForCAP ci-test_GeneralizedMorphismsForCAP ci-test_GradedModulePresentationsForCAP ci-test_GroupRepresentationsForCAP ci-test_HomologicalAlgebraForCAP ci-test_InternalExteriorAlgebraForCAP ci-test_LinearAlgebraForCAP ci-test_ModulePresentationsForCAP ci-test_ModulesOverLocalRingsForCAP ci-test_MonoidalCategories ci-test_ToricSheaves

ci-test_CAP: doc
	$(MAKE) -C CAP ci-test

ci-test_ActionsForCAP: doc
	$(MAKE) -C ActionsForCAP ci-test

ci-test_AttributeCategoryForCAP: doc
	$(MAKE) -C AttributeCategoryForCAP ci-test

ci-test_CartesianCategories: doc
	$(MAKE) -C CartesianCategories ci-test

ci-test_CompilerForCAP: doc
	$(MAKE) -C CompilerForCAP ci-test

ci-test_ComplexesAndFilteredObjectsForCAP: doc
	$(MAKE) -C ComplexesAndFilteredObjectsForCAP ci-test

ci-test_DeductiveSystemForCAP: doc
	$(MAKE) -C DeductiveSystemForCAP ci-test

ci-test_FreydCategoriesForCAP: doc
	$(MAKE) -C FreydCategoriesForCAP ci-test

ci-test_GeneralizedMorphismsForCAP: doc
	$(MAKE) -C GeneralizedMorphismsForCAP ci-test

ci-test_GradedModulePresentationsForCAP: doc
	$(MAKE) -C GradedModulePresentationsForCAP ci-test

ci-test_GroupRepresentationsForCAP: doc
	$(MAKE) -C GroupRepresentationsForCAP ci-test

ci-test_HomologicalAlgebraForCAP: doc
	$(MAKE) -C HomologicalAlgebraForCAP ci-test

ci-test_InternalExteriorAlgebraForCAP: doc
	$(MAKE) -C InternalExteriorAlgebraForCAP ci-test

ci-test_LinearAlgebraForCAP: doc
	$(MAKE) -C LinearAlgebraForCAP ci-test

ci-test_ModulePresentationsForCAP: doc
	$(MAKE) -C ModulePresentationsForCAP ci-test

ci-test_ModulesOverLocalRingsForCAP: doc
	$(MAKE) -C ModulesOverLocalRingsForCAP ci-test

ci-test_MonoidalCategories: doc
	$(MAKE) -C MonoidalCategories ci-test

ci-test_ToricSheaves: doc
	$(MAKE) -C ToricSheaves ci-test
