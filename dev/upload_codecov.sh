#!/bin/bash

set -e

# get GPG key
curl -O https://keybase.io/codecovsecops/pgp_keys.asc
# verify fingerprint
if ! gpg --import --import-options show-only --with-fingerprint pgp_keys.asc | grep "2703 4E7F DB85 0E0B BC2C  62FF 806B B28A ED77 9869"; then
    echo "Downloaded GPG key has wrong fingerprint"
    exit 1
fi
# import key into special keyring used by gpgv below
gpg --no-default-keyring --keyring ~/.gnupg/trustedkeys.kbx --import pgp_keys.asc

# get uploader with signatures
curl -O https://cli.codecov.io/latest/linux/codecov
curl -O https://cli.codecov.io/latest/linux/codecov.SHA256SUM
curl -O https://cli.codecov.io/latest/linux/codecov.SHA256SUM.sig

# verify
gpgv codecov.SHA256SUM.sig codecov.SHA256SUM
shasum -a 256 -c codecov.SHA256SUM

# read the token
TOKEN_ARGS=()
if [ -z "$CODECOV_TOKEN" ]; then
  echo -e "\033[0;33mCODECOV_TOKEN is not set. Proceeding without token.\033[0m"
else
  echo -e "\033[0;32mUsing CODECOV_TOKEN from environment variable.\033[0m"
  TOKEN_ARGS=(-t "$CODECOV_TOKEN")
fi

# build extra args for commit/branch/PR override (used by workflow_run context)
EXTRA_ARGS=()
if [ -n "$CODECOV_COMMIT_SHA" ]; then
  EXTRA_ARGS+=("-C" "$CODECOV_COMMIT_SHA")
fi
if [ -n "$CODECOV_BRANCH" ]; then
  EXTRA_ARGS+=("-B" "$CODECOV_BRANCH")
fi
if [ -n "$CODECOV_PR" ]; then
  EXTRA_ARGS+=("-P" "$CODECOV_PR")
fi

# execute
chmod +x codecov

for pkg in \
  CAP \
  ActionsForCAP \
  AdditiveClosuresForCAP \
  AttributeCategoryForCAP \
  CartesianCategories \
  CompilerForCAP \
  ComplexesAndFilteredObjectsForCAP \
  FreydCategoriesForCAP \
  GeneralizedMorphismsForCAP \
  GradedModulePresentationsForCAP \
  GroupRepresentationsForCAP \
  GroupsAsCategoriesForCAP \
  HomologicalAlgebraForCAP \
  InternalExteriorAlgebraForCAP \
  LinearAlgebraForCAP \
  LinearClosuresForCAP \
  ModulePresentationsForCAP \
  ModulesOverLocalRingsForCAP \
  MonoidalCategories \
  ToricSheaves \
; do
  while ! ./codecov -v upload-coverage -s ../ -F "$pkg" "${TOKEN_ARGS[@]}" "${EXTRA_ARGS[@]}"; do
    echo "Codecov upload for $pkg failed, retrying in 60s"
    sleep 60
  done
done
