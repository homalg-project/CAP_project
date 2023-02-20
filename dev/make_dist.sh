#!/bin/bash

set -e

# CAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/CAP" --webdir "$PWD/gh-pages/CAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# ActionsForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ActionsForCAP" --webdir "$PWD/gh-pages/ActionsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# AttributeCategoryForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/AttributeCategoryForCAP" --webdir "$PWD/gh-pages/AttributeCategoryForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# CartesianCategories
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/CartesianCategories" --webdir "$PWD/gh-pages/CartesianCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# CompilerForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/CompilerForCAP" --webdir "$PWD/gh-pages/CompilerForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# ComplexesAndFilteredObjectsForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ComplexesAndFilteredObjectsForCAP" --webdir "$PWD/gh-pages/ComplexesAndFilteredObjectsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# DeductiveSystemForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/DeductiveSystemForCAP" --webdir "$PWD/gh-pages/DeductiveSystemForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# FreydCategoriesForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/FreydCategoriesForCAP" --webdir "$PWD/gh-pages/FreydCategoriesForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
git subtree split --prefix=FreydCategoriesForCAP -b FreydCategoriesForCAP-split
git push https://homalg-project:$SUBSPLIT_PUSH_SECRET@github.com/homalg-project/FreydCategoriesForCAP FreydCategoriesForCAP-split:master

# GeneralizedMorphismsForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GeneralizedMorphismsForCAP" --webdir "$PWD/gh-pages/GeneralizedMorphismsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# GradedModulePresentationsForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GradedModulePresentationsForCAP" --webdir "$PWD/gh-pages/GradedModulePresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# GroupRepresentationsForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GroupRepresentationsForCAP" --webdir "$PWD/gh-pages/GroupRepresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# HomologicalAlgebraForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/HomologicalAlgebraForCAP" --webdir "$PWD/gh-pages/HomologicalAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# InternalExteriorAlgebraForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/InternalExteriorAlgebraForCAP" --webdir "$PWD/gh-pages/InternalExteriorAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# LinearAlgebraForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/LinearAlgebraForCAP" --webdir "$PWD/gh-pages/LinearAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# ModulePresentationsForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ModulePresentationsForCAP" --webdir "$PWD/gh-pages/ModulePresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# ModulesOverLocalRingsForCAP
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ModulesOverLocalRingsForCAP" --webdir "$PWD/gh-pages/ModulesOverLocalRingsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# MonoidalCategories
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/MonoidalCategories" --webdir "$PWD/gh-pages/MonoidalCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"

# ToricSheaves
./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ToricSheaves" --webdir "$PWD/gh-pages/ToricSheaves" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
