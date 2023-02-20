#!/bin/bash

set -e

# CAP
./dev/release-gap-package --srcdir "$PWD/CAP" --webdir "$PWD/gh-pages/CAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# ActionsForCAP
./dev/release-gap-package --srcdir "$PWD/ActionsForCAP" --webdir "$PWD/gh-pages/ActionsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# AttributeCategoryForCAP
./dev/release-gap-package --srcdir "$PWD/AttributeCategoryForCAP" --webdir "$PWD/gh-pages/AttributeCategoryForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# CartesianCategories
./dev/release-gap-package --srcdir "$PWD/CartesianCategories" --webdir "$PWD/gh-pages/CartesianCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# CompilerForCAP
./dev/release-gap-package --srcdir "$PWD/CompilerForCAP" --webdir "$PWD/gh-pages/CompilerForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# ComplexesAndFilteredObjectsForCAP
./dev/release-gap-package --srcdir "$PWD/ComplexesAndFilteredObjectsForCAP" --webdir "$PWD/gh-pages/ComplexesAndFilteredObjectsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# DeductiveSystemForCAP
./dev/release-gap-package --srcdir "$PWD/DeductiveSystemForCAP" --webdir "$PWD/gh-pages/DeductiveSystemForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# FreydCategoriesForCAP
./dev/release-gap-package --srcdir "$PWD/FreydCategoriesForCAP" --webdir "$PWD/gh-pages/FreydCategoriesForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
# creating subsplits is slow and should only rarely result in errors -> do not simulate to keep testing PRs as fast as possible
#git subtree split --prefix=FreydCategoriesForCAP -b FreydCategoriesForCAP-split

# GeneralizedMorphismsForCAP
./dev/release-gap-package --srcdir "$PWD/GeneralizedMorphismsForCAP" --webdir "$PWD/gh-pages/GeneralizedMorphismsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# GradedModulePresentationsForCAP
./dev/release-gap-package --srcdir "$PWD/GradedModulePresentationsForCAP" --webdir "$PWD/gh-pages/GradedModulePresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# GroupRepresentationsForCAP
./dev/release-gap-package --srcdir "$PWD/GroupRepresentationsForCAP" --webdir "$PWD/gh-pages/GroupRepresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# HomologicalAlgebraForCAP
./dev/release-gap-package --srcdir "$PWD/HomologicalAlgebraForCAP" --webdir "$PWD/gh-pages/HomologicalAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# InternalExteriorAlgebraForCAP
./dev/release-gap-package --srcdir "$PWD/InternalExteriorAlgebraForCAP" --webdir "$PWD/gh-pages/InternalExteriorAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# LinearAlgebraForCAP
./dev/release-gap-package --srcdir "$PWD/LinearAlgebraForCAP" --webdir "$PWD/gh-pages/LinearAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# ModulePresentationsForCAP
./dev/release-gap-package --srcdir "$PWD/ModulePresentationsForCAP" --webdir "$PWD/gh-pages/ModulePresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# ModulesOverLocalRingsForCAP
./dev/release-gap-package --srcdir "$PWD/ModulesOverLocalRingsForCAP" --webdir "$PWD/gh-pages/ModulesOverLocalRingsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# MonoidalCategories
./dev/release-gap-package --srcdir "$PWD/MonoidalCategories" --webdir "$PWD/gh-pages/MonoidalCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball

# ToricSheaves
./dev/release-gap-package --srcdir "$PWD/ToricSheaves" --webdir "$PWD/gh-pages/ToricSheaves" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
