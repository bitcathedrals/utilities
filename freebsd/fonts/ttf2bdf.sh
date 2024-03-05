#! /usr/bin/env bash

SIZE=$1
INPUT=$2
OUTPUT=$3

otf2bdf -p $SIZE -c C -o $OUTPUT $INPUT

