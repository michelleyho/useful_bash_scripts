#!/bin/bash
#set -e

########
# Help
########
Help()
{
    # Display Help
    echo "Welcome to the git branch and release automation bash script"
    echo ""
    echo "To run this script:"
    echo ">> ./git_repo_branch_tag.sh <ssh repo url> <source branch> <new branch name> <new tag name>"
    echo ""
    echo "Options:"
    echo "h --> Print this help menu"

}

while getopts ":h" option; do
    case $option in
        h) # display help
            Help
            exit;;
        \?) # invalid option
            echo "Please enter another option"
            exit;;
    esac
done


repo=$1
source_branch=$2
branch_name=$3
tag_name=$4

basename=$(basename $repo)
repo_name=${basename%.*}
echo "Will be performing branching and releasing on repo:${repo} on branch ${source_branch}"
echo "New branch name: ${branch_name}"
echo "New tag name: ${tag_name}"

failCount=0

git clone ${repo}
cd ${repo_name}
git checkout ${source_branch}
git ls-remote -h --exit-code ${repo} ${branch_name}
if [ $? == 2 ]; then
    git checkout -b ${branch_name}
#    git push origin ${branch_name}
else
    echo "New branch name ${branch_name} already exists in remote repo"
    exit
fi

tag_error_message=$( git tag ${tag_name} 2>&1 )
if [ $? == 0 ]; then
    git push origin --tags
    echo "Successfully tagged"
else
    echo "Failed to create tag: ${tag_name}"
    echo ${tag_error_message}
    let "failCount += 1"
fi

echo "Fail: ${failCount}"
