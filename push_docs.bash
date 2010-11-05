#!/bin/bash

set -v

repo=git@github.com:redhatcat/emmett.git
project_dir=$PWD
tmp_dir=/tmp/gh-rdoc

if [ -d $tmp_dir ]; then
    rm -rf $tmp_dir
fi

rake doc:app && \
git clone $repo $tmp_dir && \
cd $tmp_dir && \
if ! git checkout -b gh-pages origin/gh-pages; then
    # No gh-pages branch yet
    git symbolic-ref HEAD refs/heads/gh-pages
    rm .git/index
    git clean -fdx
fi
rsync -rv $project_dir/doc/app/* . &&
git add . && \
git commit . -m 'New docs!' && \
git push origin gh-pages

rm -rf $tmp_dir
