#/bin/bash

packages="CAP GeneralizedMorphismsForCAP LinearAlgebraForCAP ModulePresentationsForCAP"

for i in $packages; do
  mkdir ${i}
  mkdir ${i}/doc
  cp -f ../${i}/PackageInfo.g ${i}
  cp -f ../${i}/README ${i}
  cp -r ../${i}/doc/*.{css,html,js,txt} ${i}/doc
done

current_dir=$(pwd)

for i in $packages; do
  cd ${i}
  mkdir _data
  cp ../_data/package.yml _data
  gap ../update.g
  cd $current_dir
done

for i in $packages; do
  cp index_default.md ${i}/index.md
done

