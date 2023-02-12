#!/bin/bash

set -e

packages="CAP ActionsForCAP AttributeCategoryForCAP CartesianCategories CompilerForCAP ComplexesAndFilteredObjectsForCAP DeductiveSystemForCAP FreydCategoriesForCAP GeneralizedMorphismsForCAP GradedModulePresentationsForCAP GroupRepresentationsForCAP HomologicalAlgebraForCAP InternalExteriorAlgebraForCAP LinearAlgebraForCAP ModulePresentationsForCAP ModulesOverLocalRingsForCAP MonoidalCategories ToricSheaves "

base_dir="$PWD"

for pkg in ${packages}; do
  ./dev/release-gap-package --skip-existing-release --srcdir ${base_dir}/${pkg} --webdir ${base_dir}/gh-pages/${pkg} --update-script ${base_dir}/gh-pages/update.g --release-script ${base_dir}/dev/.release $@
done
