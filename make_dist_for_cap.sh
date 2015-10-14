#!/bin/bash

packages="CAP GeneralizedMorphismsForCAP LinearAlgebraForCAP ModulePresentationsForCAP"

current_dir=$(pwd)

for i in $packages; do
  cd $i
  eval $(gap -A -q -b <<EOF
  # HACK
  MakeReadWriteGlobal("SetPackageInfo");
  SetPackageInfo:=function(pkg)
      Print("PKG=\"",pkg.PackageName,"\"\n");
      Print("VER=\"",pkg.Version,"\"\n");
  end;;
  Read("PackageInfo.g");
  QUIT;
  EOF
  )

  tar czf . ${i}-${VER}.tar.gz
  rm ../gh-pages/${i}/*tar.gz
  mv ${PKG}-${VER}.tar.gz ../gh-pages/${i}
  cd $current_dir
done
