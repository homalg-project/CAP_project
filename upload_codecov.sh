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
./codecov -Z -v -s ../ -F CAP || (sleep 30; ./codecov -Z -v -s ../ -F CAP || (sleep 30; ./codecov -Z -v -s ../ -F CAP))
./codecov -Z -v -s ../ -F ActionsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F ActionsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F ActionsForCAP))
./codecov -Z -v -s ../ -F AttributeCategoryForCAP || (sleep 30; ./codecov -Z -v -s ../ -F AttributeCategoryForCAP || (sleep 30; ./codecov -Z -v -s ../ -F AttributeCategoryForCAP))
./codecov -Z -v -s ../ -F CartesianCategories || (sleep 30; ./codecov -Z -v -s ../ -F CartesianCategories || (sleep 30; ./codecov -Z -v -s ../ -F CartesianCategories))
./codecov -Z -v -s ../ -F CompilerForCAP || (sleep 30; ./codecov -Z -v -s ../ -F CompilerForCAP || (sleep 30; ./codecov -Z -v -s ../ -F CompilerForCAP))
./codecov -Z -v -s ../ -F ComplexesAndFilteredObjectsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F ComplexesAndFilteredObjectsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F ComplexesAndFilteredObjectsForCAP))
./codecov -Z -v -s ../ -F DeductiveSystemForCAP || (sleep 30; ./codecov -Z -v -s ../ -F DeductiveSystemForCAP || (sleep 30; ./codecov -Z -v -s ../ -F DeductiveSystemForCAP))
./codecov -Z -v -s ../ -F FreydCategoriesForCAP || (sleep 30; ./codecov -Z -v -s ../ -F FreydCategoriesForCAP || (sleep 30; ./codecov -Z -v -s ../ -F FreydCategoriesForCAP))
./codecov -Z -v -s ../ -F GeneralizedMorphismsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F GeneralizedMorphismsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F GeneralizedMorphismsForCAP))
./codecov -Z -v -s ../ -F GradedModulePresentationsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F GradedModulePresentationsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F GradedModulePresentationsForCAP))
./codecov -Z -v -s ../ -F GroupRepresentationsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F GroupRepresentationsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F GroupRepresentationsForCAP))
./codecov -Z -v -s ../ -F HomologicalAlgebraForCAP || (sleep 30; ./codecov -Z -v -s ../ -F HomologicalAlgebraForCAP || (sleep 30; ./codecov -Z -v -s ../ -F HomologicalAlgebraForCAP))
./codecov -Z -v -s ../ -F InternalExteriorAlgebraForCAP || (sleep 30; ./codecov -Z -v -s ../ -F InternalExteriorAlgebraForCAP || (sleep 30; ./codecov -Z -v -s ../ -F InternalExteriorAlgebraForCAP))
./codecov -Z -v -s ../ -F LinearAlgebraForCAP || (sleep 30; ./codecov -Z -v -s ../ -F LinearAlgebraForCAP || (sleep 30; ./codecov -Z -v -s ../ -F LinearAlgebraForCAP))
./codecov -Z -v -s ../ -F ModulePresentationsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F ModulePresentationsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F ModulePresentationsForCAP))
./codecov -Z -v -s ../ -F ModulesOverLocalRingsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F ModulesOverLocalRingsForCAP || (sleep 30; ./codecov -Z -v -s ../ -F ModulesOverLocalRingsForCAP))
./codecov -Z -v -s ../ -F MonoidalCategories || (sleep 30; ./codecov -Z -v -s ../ -F MonoidalCategories || (sleep 30; ./codecov -Z -v -s ../ -F MonoidalCategories))
./codecov -Z -v -s ../ -F ToricSheaves || (sleep 30; ./codecov -Z -v -s ../ -F ToricSheaves || (sleep 30; ./codecov -Z -v -s ../ -F ToricSheaves))
