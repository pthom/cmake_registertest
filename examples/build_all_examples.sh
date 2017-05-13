#!/usr/bin/env bash
topdir=$(pwd)
for example_dir in $(find . -type d -name "example*"); do
  echo $example_dir
  cd $example_dir
  ./build.sh
  cd $topdir
done