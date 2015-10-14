#/bin/bash

packages="CAP GeneralizedMorphismsForCAP LinearAlgebraForCAP ModulePresentationsForCAP"

for i in $packages; do
  mkdir ${i}
  mkdir ${i}/doc
  cp -f ../${i}/PackageInfo.g ${i}
  cp -f ../${i}/README ${i}
  cp -r ../${i}/doc/*.{css,html,js,txt} ${i}/doc
done


