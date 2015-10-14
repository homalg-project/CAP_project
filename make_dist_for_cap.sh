#!/bin/bash

packages="CAP GeneralizedMorphismsForCAP LinearAlgebraForCAP ModulePresentationsForCAP"

current_dir=$(pwd)

for i in $packages; do
  cd $i
  eval $(gap -A -q -b <<EOF
# HACK
MakeReadWriteGlobal("SetPackageInfo");
SetPackageInfo:=function(pkg)
  Print("VERSION",pkg.Version);
end;;
Read("PackageInfo.g");
QUIT;
EOF
)
  version=$(cat VERSION)
  rm VERSION
  tar czf ../${i}-${version}.tar.gz .
  cd ..
  rm gh-pages/${i}/*tar.gz
  mv ${i}-${version}.tar.gz gh-pages/${i}
  cd $current_dir
done
