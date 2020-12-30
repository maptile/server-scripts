#!/usr/bin/env bash

for i in `ls`
do
    echo "Loading $i"
    docker image load -i $i
done
