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

cd _layouts
for i in $packages; do
  sed "s|@@package@@|package${i}|g" < default_template > package${i}.html
done
cd $current_dir

cd _data
echo "package_links:" > packages.yml
for i in $packages; do
  echo "    - name: ${i}" >> packages.yml
done
cd $current_dir

for i in $packages; do
  cp ${i}/_data/package.yml _data/package${i}.yml
  sed "s|@@package@@|package${i}|g" < index_default.template > ${i}/index.md
done
