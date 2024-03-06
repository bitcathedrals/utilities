#! /usr/bin/env bash

if [[ -x magick ]]
then
  CMD=magick
else
  CMD=convert
fi

FROM_DIR=$1
TO_DIR=$2

if [[ ! -d $FROM_DIR ]]
then
  echo "to-png.sh: error - first argument must be the directory to convert from."
  exit 1
fi

if [[ ! -d $TO_DIR ]]
then
  if ! mkdir $TO_DIR
  then
    echo "to-png.sh: error - second argument must be the directory to put the converted images into."
    exit 1
  fi
fi

DRY_RUN=""

if [[ $3 == '-dry' ]]
then
  DRY_RUN="dry"
fi

for file in $(ls $FROM_DIR/*)
do
  new_path=`basename $file`
  echo "basename: $new_path"

  new_path=`echo "$new_path" | cut -d '.' -f 1`
  new_path="${TO_DIR}/${new_path}.png"

  echo "converting: $file -> $new_path"

  if [[ -n "$DRY_RUN" ]]
  then
     echo "dry run"
  else
    if ! $CMD "$file" "$new_path"
    then
      echo "conversion of $file failed!"
    fi
  fi
done
