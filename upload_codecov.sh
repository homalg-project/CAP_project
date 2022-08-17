#!/bin/bash

set -e

# get GPG key
curl -O https://keybase.io/codecovsecurity/pgp_keys.asc
# verify fingerprint
if ! gpg --import --import-options show-only --with-fingerprint pgp_keys.asc | grep "2703 4E7F DB85 0E0B BC2C  62FF 806B B28A ED77 9869"; then
    echo "Downloaded GPG key has wrong fingerprint"
    exit 1
fi
# import key into special keyring used by gpgv below
gpg --no-default-keyring --keyring ~/.gnupg/trustedkeys.kbx --import pgp_keys.asc

# get uploader with signatures
curl -O https://uploader.codecov.io/latest/linux/codecov
curl -O https://uploader.codecov.io/latest/linux/codecov.SHA256SUM
curl -O https://uploader.codecov.io/latest/linux/codecov.SHA256SUM.sig

# verify
gpgv codecov.SHA256SUM.sig codecov.SHA256SUM
shasum -a 256 -c codecov.SHA256SUM

# execute
chmod +x codecov
./codecov -Z -F CAP || ./codecov -Z -F CAP || ./codecov -Z -F CAP
./codecov -Z -F ActionsForCAP || ./codecov -Z -F ActionsForCAP || ./codecov -Z -F ActionsForCAP
./codecov -Z -F AttributeCategoryForCAP || ./codecov -Z -F AttributeCategoryForCAP || ./codecov -Z -F AttributeCategoryForCAP
./codecov -Z -F CartesianCategories || ./codecov -Z -F CartesianCategories || ./codecov -Z -F CartesianCategories
./codecov -Z -F CompilerForCAP || ./codecov -Z -F CompilerForCAP || ./codecov -Z -F CompilerForCAP
./codecov -Z -F ComplexesAndFilteredObjectsForCAP || ./codecov -Z -F ComplexesAndFilteredObjectsForCAP || ./codecov -Z -F ComplexesAndFilteredObjectsForCAP
./codecov -Z -F DeductiveSystemForCAP || ./codecov -Z -F DeductiveSystemForCAP || ./codecov -Z -F DeductiveSystemForCAP
./codecov -Z -F FreydCategoriesForCAP || ./codecov -Z -F FreydCategoriesForCAP || ./codecov -Z -F FreydCategoriesForCAP
./codecov -Z -F GeneralizedMorphismsForCAP || ./codecov -Z -F GeneralizedMorphismsForCAP || ./codecov -Z -F GeneralizedMorphismsForCAP
./codecov -Z -F GradedModulePresentationsForCAP || ./codecov -Z -F GradedModulePresentationsForCAP || ./codecov -Z -F GradedModulePresentationsForCAP
./codecov -Z -F GroupRepresentationsForCAP || ./codecov -Z -F GroupRepresentationsForCAP || ./codecov -Z -F GroupRepresentationsForCAP
./codecov -Z -F HomologicalAlgebraForCAP || ./codecov -Z -F HomologicalAlgebraForCAP || ./codecov -Z -F HomologicalAlgebraForCAP
./codecov -Z -F InternalExteriorAlgebraForCAP || ./codecov -Z -F InternalExteriorAlgebraForCAP || ./codecov -Z -F InternalExteriorAlgebraForCAP
./codecov -Z -F LinearAlgebraForCAP || ./codecov -Z -F LinearAlgebraForCAP || ./codecov -Z -F LinearAlgebraForCAP
./codecov -Z -F ModulePresentationsForCAP || ./codecov -Z -F ModulePresentationsForCAP || ./codecov -Z -F ModulePresentationsForCAP
./codecov -Z -F ModulesOverLocalRingsForCAP || ./codecov -Z -F ModulesOverLocalRingsForCAP || ./codecov -Z -F ModulesOverLocalRingsForCAP
./codecov -Z -F MonoidalCategories || ./codecov -Z -F MonoidalCategories || ./codecov -Z -F MonoidalCategories
./codecov -Z -F ToricSheaves || ./codecov -Z -F ToricSheaves || ./codecov -Z -F ToricSheaves
