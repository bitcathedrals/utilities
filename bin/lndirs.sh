#! /usr/bin/env bash

target=$1
shift

for source in $@
do
  for entry in $(ls $source)
  do
    normalized=$(readlink -f $source/$entry)
    echo >/dev/stderr "linking $entry : $normalized -> $target"
  done
done
