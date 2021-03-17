#!/bin/bash
set -e

repo=$1
source_branch=$2
branch_name=$3
tag_name=$4

echo "Will be performing branching and releasing on repo:${repo} on branch ${source_branch}"
echo "New branch name: ${branch_name}"
echo "New tag name: ${tag_name}"

git clone ${repo}
cd ${repo}
git checkout ${source_branch}
git checkout -b ${branch_name}
git push origin ${branch_name}
git tag ${tag_name}
git push origin --tags
