#!/bin/bash

git_url=$1
checkout_branch=${2:-"master"}

if [ $# -eq 0 ]; then
    echo "Please provide at least a git URL to clone"
    exit 1
fi

echo "Cloning ${git_url}"
echo "Checking out branch/tag ${checkout_branch}"
git clone -b $checkout_branch $git_url

