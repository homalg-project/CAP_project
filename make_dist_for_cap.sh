#/bin/bash

packages="CAP GeneralizedMorphismsForCAP LinearAlgebraForCAP ModulePresentationsForCAP"

current_dir=$(pwd)

for i in $packages; do
  cd $i
gap -A -q -b <<EOF
# HACK
MakeReadWriteGlobal("SetPackageInfo");
SetPackageInfo:=function(pkg)
  PrintTo("VERSION",pkg.Version);
end;;
Read("PackageInfo.g");
QUIT;
EOF

  version=$(cat VERSION)
  rm VERSION
  tar czvf ../${i}-${version}.tar.gz .
  cd ..
  rm gh-pages/${i}/*tar.gz
  mv ${i}-${version}.tar.gz gh-pages/${i}
  cd $current_dir
done

cd gh-pages

for i in $packages; do
  cd ${i}
  git add *
  cd ..
done

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
  sed "s|@@package@@|package${i}|g" < index_default.md > ${i}/index.md
done

git add *
git commit -a -m "New version of homepage"
git push homalg gh-pages:gh-pages
