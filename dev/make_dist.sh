#!/bin/bash

set -e

# CAP
echo "Release CAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/CAP" --webdir "$PWD/gh-pages/CAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ActionsForCAP
echo "Release ActionsForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ActionsForCAP" --webdir "$PWD/gh-pages/ActionsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# AttributeCategoryForCAP
echo "Release AttributeCategoryForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/AttributeCategoryForCAP" --webdir "$PWD/gh-pages/AttributeCategoryForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# CartesianCategories
echo "Release CartesianCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/CartesianCategories" --webdir "$PWD/gh-pages/CartesianCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# CompilerForCAP
echo "Release CompilerForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/CompilerForCAP" --webdir "$PWD/gh-pages/CompilerForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ComplexesAndFilteredObjectsForCAP
echo "Release ComplexesAndFilteredObjectsForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ComplexesAndFilteredObjectsForCAP" --webdir "$PWD/gh-pages/ComplexesAndFilteredObjectsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# FreydCategoriesForCAP
echo "Release FreydCategoriesForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/FreydCategoriesForCAP" --webdir "$PWD/gh-pages/FreydCategoriesForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
git subtree split --prefix=FreydCategoriesForCAP -b FreydCategoriesForCAP-split
git push https://homalg-project:$SUBSPLIT_PUSH_SECRET@github.com/homalg-project/FreydCategoriesForCAP FreydCategoriesForCAP-split:master
echo ""

# GeneralizedMorphismsForCAP
echo "Release GeneralizedMorphismsForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GeneralizedMorphismsForCAP" --webdir "$PWD/gh-pages/GeneralizedMorphismsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# GradedModulePresentationsForCAP
echo "Release GradedModulePresentationsForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GradedModulePresentationsForCAP" --webdir "$PWD/gh-pages/GradedModulePresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# GroupRepresentationsForCAP
echo "Release GroupRepresentationsForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GroupRepresentationsForCAP" --webdir "$PWD/gh-pages/GroupRepresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# GroupsAsCategoriesForCAP
echo "Release GroupsAsCategoriesForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/GroupsAsCategoriesForCAP" --webdir "$PWD/gh-pages/GroupsAsCategoriesForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
git subtree split --prefix=GroupsAsCategoriesForCAP -b GroupsAsCategoriesForCAP-split
git push https://homalg-project:$SUBSPLIT_PUSH_SECRET@github.com/homalg-project/GroupsAsCategoriesForCAP GroupsAsCategoriesForCAP-split:master
echo ""

# HomologicalAlgebraForCAP
echo "Release HomologicalAlgebraForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/HomologicalAlgebraForCAP" --webdir "$PWD/gh-pages/HomologicalAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# InternalExteriorAlgebraForCAP
echo "Release InternalExteriorAlgebraForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/InternalExteriorAlgebraForCAP" --webdir "$PWD/gh-pages/InternalExteriorAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# LinearAlgebraForCAP
echo "Release LinearAlgebraForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/LinearAlgebraForCAP" --webdir "$PWD/gh-pages/LinearAlgebraForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ModulePresentationsForCAP
echo "Release ModulePresentationsForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ModulePresentationsForCAP" --webdir "$PWD/gh-pages/ModulePresentationsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ModulesOverLocalRingsForCAP
echo "Release ModulesOverLocalRingsForCAP"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ModulesOverLocalRingsForCAP" --webdir "$PWD/gh-pages/ModulesOverLocalRingsForCAP" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# MonoidalCategories
echo "Release MonoidalCategories"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/MonoidalCategories" --webdir "$PWD/gh-pages/MonoidalCategories" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""

# ToricSheaves
echo "Release ToricSheaves"
GAP_PKG_RELEASE_DATE=$(date -I) ./dev/release-gap-package --skip-existing-release --srcdir "$PWD/ToricSheaves" --webdir "$PWD/gh-pages/ToricSheaves" --update-script "$PWD/gh-pages/update.g" --release-script "$PWD/dev/.release"
echo ""
