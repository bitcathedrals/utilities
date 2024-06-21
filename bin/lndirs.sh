#! /usr/bin/env zsh

dry='false'

if [[ $1 == '-dry' ]]
then
  dry='true'
  shift
fi

target=$1
shift

for from in $@
do
  for entry in $(ls ${from}/**/* | sort)
  do
    if [[ -d $entry ]]
    then
      echo >/dev/stderr "making directory: $target/$entry"

      if [[ $dry == 'false' ]]
      then
        mkdir $target/$entry
      fi
    else
      link_source=$(readlink -f $entry)
      link_target=$target/$(echo $entry | sed -e "s,$from,,")
      link_target=`echo $link_target | tr -s '/'`

      echo >/dev/stderr "linking $entry : $link_source -> $link_target"

      if [[ $SOFT == 'true' ]]
      then
        if [[ $dry == 'false' ]]
        then
          ln -s $link_source $link_target
        else
          echo "soft link: dry-run"
        fi
      else
        if [[ $dry == 'false' ]]
        then
          ln $link_source $link_target
        else
          echo "hard link: dry-run"
        fi
      fi
    fi
  done
done
