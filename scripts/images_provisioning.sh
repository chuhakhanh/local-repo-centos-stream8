#!/bin/bash
filename=$1
repo_url=$2
while read line do
    
    docker pull quay.io/$line
    docker tag quay.io/$line $repo_url/$line
    docker push $repo_url/$line
    
done < $filename