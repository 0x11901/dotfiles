#!/usr/bin/env bash

# find all mp3 files in this dir and sub dir
find . -name "*.mp3" >todo

while read line; do
    echo ${line}
done <todo
