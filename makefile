all: homalg_compatibility doc test

.PHONY: test

homalg_compatibility:
	gap load_cap_sheaves.g
	gap load_sheaves_cap.g

test: CAP_test Modules_test GradedModules_test Linear_test Generalized_test

CAP_test:
	cd CAP && make test

Modules_test:
	cd ModulePresentationsForCAP && make test

GradedModules_test:
	cd GradedModulePresentationsForCAP && make test

Linear_test:
	cd LinearAlgebraForCAP && make test

Generalized_test:
	cd GeneralizedMorphismsForCAP && make test

doc: CAP_doc Modules_doc Linear_doc Generalized_doc

CAP_doc:
	cd CAP && make doc

Modules_doc:
	cd ModulePresentationsForCAP && make doc

Linear_doc:
	cd LinearAlgebraForCAP && make doc

Generalized_doc:
	cd GeneralizedMorphismsForCAP && make doc

ci-test: homalg_compatibility doc
	cd CAP && make ci-test
	cd ModulePresentationsForCAP && make ci-test
	cd GradedModulePresentationsForCAP && make ci-test
	cd LinearAlgebraForCAP && make ci-test
	cd GeneralizedMorphismsForCAP && make ci-test
