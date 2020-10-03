#/bin/bash

base_dir="$PWD"

./release --srcdir ${base_dir} --webdir ${base_dir}/gh-pages --update-file ${base_dir}/gh-pages/update.g $@
