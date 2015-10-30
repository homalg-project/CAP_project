#/bin/bash

packages="CAP GeneralizedMorphismsForCAP LinearAlgebraForCAP ModulePresentationsForCAP"

current_dir=$(pwd)

for i in $packages; do
  cd $i
  cd ..
  mkdir -p tmp
  git archive --format=tar --output=tmp/${i}.tar --prefix=${i}/ HEAD:${i}
  cd tmp
  tar xf ${i}.tar
  cd ${i}
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
  gap makedoc.g
  rm -rf .git*
  rm -f doc/*.{aux,bbl,blg,brf,idx,ilg,ind,lab,log,out,pnr,tex,toc,tst}
  rm -rf bin/
  rm -rf public_html
  cd ..
  tar czvf ${i}-${version}.tar.gz ${i}
  mkdir -p ../gh-pages/${i}
  rm ../gh-pages/${i}/*tar.gz
  mv ${i}-${version}.tar.gz ../gh-pages/${i}
  cd ..
  rm -rf tmp
  cd $current_dir
done

cd gh-pages

for i in $packages; do
  cd ${i}
  git add *
  cd ..
done

for i in $packages; do
  mkdir -p ${i}
  mkdir -p ${i}/doc
  cp -f ../${i}/PackageInfo.g ${i}
  cp -f ../${i}/README ${i}
  cp -r ../${i}/doc/*.{css,html,js,txt} ${i}/doc
done

current_dir=$(pwd)

for i in $packages; do
  cd ${i}
  mkdir -p _data
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

log_output=$(git log -n 1 --oneline | grep "New version of homepage from dist script")

if [ -n "$log_output" ]; then
  git add *
  git commit -a --amend -m "New version of homepage from dist script"
  git push --force homalg gh-pages:gh-pages
else
  git add *
  git commit -a -m "New version of homepage from dist script"
  git push homalg gh-pages:gh-pages
fi
