#!/bin/bash

set -e

# CAP
echo "Simulate release of CAP"
./dev/release-gap-package --srcdir "$PWD/CAP" --webdir "$PWD/gh-pages/CAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ActionsForCAP
echo "Simulate release of ActionsForCAP"
./dev/release-gap-package --srcdir "$PWD/ActionsForCAP" --webdir "$PWD/gh-pages/ActionsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# AttributeCategoryForCAP
echo "Simulate release of AttributeCategoryForCAP"
./dev/release-gap-package --srcdir "$PWD/AttributeCategoryForCAP" --webdir "$PWD/gh-pages/AttributeCategoryForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# CartesianCategories
echo "Simulate release of CartesianCategories"
./dev/release-gap-package --srcdir "$PWD/CartesianCategories" --webdir "$PWD/gh-pages/CartesianCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# CompilerForCAP
echo "Simulate release of CompilerForCAP"
./dev/release-gap-package --srcdir "$PWD/CompilerForCAP" --webdir "$PWD/gh-pages/CompilerForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ComplexesAndFilteredObjectsForCAP
echo "Simulate release of ComplexesAndFilteredObjectsForCAP"
./dev/release-gap-package --srcdir "$PWD/ComplexesAndFilteredObjectsForCAP" --webdir "$PWD/gh-pages/ComplexesAndFilteredObjectsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# DeductiveSystemForCAP
echo "Simulate release of DeductiveSystemForCAP"
./dev/release-gap-package --srcdir "$PWD/DeductiveSystemForCAP" --webdir "$PWD/gh-pages/DeductiveSystemForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# FreydCategoriesForCAP
echo "Simulate release of FreydCategoriesForCAP"
./dev/release-gap-package --srcdir "$PWD/FreydCategoriesForCAP" --webdir "$PWD/gh-pages/FreydCategoriesForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
# creating subsplits is slow and should only rarely result in errors -> do not simulate to keep testing PRs as fast as possible
#git subtree split --prefix=FreydCategoriesForCAP -b FreydCategoriesForCAP-split
echo ""

# GeneralizedMorphismsForCAP
echo "Simulate release of GeneralizedMorphismsForCAP"
./dev/release-gap-package --srcdir "$PWD/GeneralizedMorphismsForCAP" --webdir "$PWD/gh-pages/GeneralizedMorphismsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# GradedModulePresentationsForCAP
echo "Simulate release of GradedModulePresentationsForCAP"
./dev/release-gap-package --srcdir "$PWD/GradedModulePresentationsForCAP" --webdir "$PWD/gh-pages/GradedModulePresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# GroupRepresentationsForCAP
echo "Simulate release of GroupRepresentationsForCAP"
./dev/release-gap-package --srcdir "$PWD/GroupRepresentationsForCAP" --webdir "$PWD/gh-pages/GroupRepresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# HomologicalAlgebraForCAP
echo "Simulate release of HomologicalAlgebraForCAP"
./dev/release-gap-package --srcdir "$PWD/HomologicalAlgebraForCAP" --webdir "$PWD/gh-pages/HomologicalAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# InternalExteriorAlgebraForCAP
echo "Simulate release of InternalExteriorAlgebraForCAP"
./dev/release-gap-package --srcdir "$PWD/InternalExteriorAlgebraForCAP" --webdir "$PWD/gh-pages/InternalExteriorAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# LinearAlgebraForCAP
echo "Simulate release of LinearAlgebraForCAP"
./dev/release-gap-package --srcdir "$PWD/LinearAlgebraForCAP" --webdir "$PWD/gh-pages/LinearAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ModulePresentationsForCAP
echo "Simulate release of ModulePresentationsForCAP"
./dev/release-gap-package --srcdir "$PWD/ModulePresentationsForCAP" --webdir "$PWD/gh-pages/ModulePresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ModulesOverLocalRingsForCAP
echo "Simulate release of ModulesOverLocalRingsForCAP"
./dev/release-gap-package --srcdir "$PWD/ModulesOverLocalRingsForCAP" --webdir "$PWD/gh-pages/ModulesOverLocalRingsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# MonoidalCategories
echo "Simulate release of MonoidalCategories"
./dev/release-gap-package --srcdir "$PWD/MonoidalCategories" --webdir "$PWD/gh-pages/MonoidalCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""

# ToricSheaves
echo "Simulate release of ToricSheaves"
./dev/release-gap-package --srcdir "$PWD/ToricSheaves" --webdir "$PWD/gh-pages/ToricSheaves" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release" --only-tarball
echo ""
