all: homalg_compatibility test

.PHONY: test

homalg_compatibility:
	gap load_cap_sheaves.g
	gap load_sheaves_cap.g

test: CAP_test Modules_test Linear_test Generalized_test

CAP_test:
	cd CAP && make test

Modules_test:
	cd ModulePresentationsForCAP && make test

Linear_test:
	cd LinearAlgebraForCAP && make test

Generalized_test:
	cd GeneralizedMorphismsForCAP && make test
