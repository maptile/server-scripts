#!/usr/bin/env bash

images=`docker images | awk '{print $1 ":" $2}'`

for i in $images
do
    if [ $i != "REPOSITORY:TAG" ]; then
        echo "Exporting $i"
        outputfilename=$i
        outputfilename=${outputfilename/\./\_}
        outputfilename=${outputfilename/:/\_}
        outputfilename=${outputfilename/\//\_}
        outputfilename=${outputfilename/\//\_}

        docker image save $i -o ./$outputfilename.tar
    fi
done
