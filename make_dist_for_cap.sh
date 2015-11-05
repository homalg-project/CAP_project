#/bin/bash

packages="CAP GeneralizedMorphismsForCAP LinearAlgebraForCAP ModulePresentationsForCAP"

function jsonval {
    temp=`echo $release_response | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w id`
    echo ${temp##*|}
}

current_dir=$(pwd)

for i in $packages; do
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
  gap -A <<GAPInput
SetPackagePath("${i}", ".");
Read("makedoc.g");
GAPInput
  rm -rf .git*
  rm -f doc/*.{aux,bbl,blg,brf,idx,ilg,ind,lab,log,out,pnr,tex,toc,tst}
  rm -rf bin/
  rm -rf public_html
  cd ..
  
  oauth_token=$(cat ~/.github_shell_token)
  
  echo "Creating release for ${i}"
  ## check wether release is already there
  
  tag_response=$(curl -X GET https://api.github.com/repos/homalg-project/CAP_project/releases/tags/${i}-${version}?access_token=${oauth_token} | grep "Not Found")
  echo "Tag response: ${tag_response}"
  if [ -n "$tag_response" ]; then
      release_response=$(curl -H "Content-Type: application/json" -X POST --data \
      '{ "tag_name": "'${i}-${version}'", "target_commitish": "master", "name": "'${i}-${version}'", "body": "Release for '${i}'", "draft": false, "prerelease": false }' \
      https://api.github.com/repos/homalg-project/CAP_project/releases?access_token=${oauth_token})
      
      echo "Release response: ${release_response}"
      
      release_id=$(jsonval | sed "s/id:/\n/g" | sed -n 2p | sed "s| ||g")
      
      tar czvf ${i}-${version}.tar.gz ${i}
      curl --fail -s -S -X POST https://uploads.github.com/repos/homalg-project/CAP_project/releases/${release_id}/assets?name=${i}-${version}.tar.gz \
          -H "Accept: application/vnd.github.v3+json" \
          -H "Authorization: token ${oauth_token}" \
          -H "Content-Type: application/tgz" \
          --data-binary @"${i}-${version}.tar.gz"
      
      rm ${i}-${version}.tar.gz
      
      zip -r ${i}-${version}.zip ${i}
      curl --fail -s -S -X POST https://uploads.github.com/repos/homalg-project/CAP_project/releases/${release_id}/assets?name=${i}-${version}.zip \
          -H "Accept: application/vnd.github.v3+json" \
          -H "Authorization: token ${oauth_token}" \
          -H "Content-Type: application/zip" \
          --data-binary @"${i}-${version}.zip"
      
      rm ${i}-${version}.zip
      
  fi
  
  mkdir -p ../gh-pages/${i}
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
