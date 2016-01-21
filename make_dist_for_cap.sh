#/bin/bash

packages="CAP GeneralizedMorphismsForCAP LinearAlgebraForCAP ModulePresentationsForCAP"

base_dir="$PWD"

for i in ${packages}; do
  ./release --srcdir ${base_dir}/${i} --webdir ${base_dir}/gh-pages/${i} --update-file ${base_dir}/gh-pages/update
done

exit 0

git push homalg gh-pages:gh-pages
