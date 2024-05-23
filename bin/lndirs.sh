#! /usr/bin/env bash

dry='false'

if [[ $1 == '-dry' ]]
then
  dry='true'
  shift
fi

target=$1
shift

for source in $@
do
  for entry in $(ls ${source}/**/* | sort)
  do
    normalized=$(readlink -f $source/$entry)
    echo >/dev/stderr "linking $entry : $normalized -> $target"

    if [[ -d $entry ]]
    then
      mkdir $target/$entry
    else
      if [[ $SOFT == 'true' ]]
      then
        ln -s $normalized $target/$entry
      else
        ln $normalized $target/$entry
      fi
    fi
  done
done
