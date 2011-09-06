#!/usr/bin/env bash
prefix=$1
cd $prefix
shift

dirs=$*
for dir in $dirs; do
 if [[ -d $dir ]]; then
    echo "$dir"
    exit
 fi
done
