#!/bin/bash
#set -e

#############################################
# Help Menu
#############################################
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

function checkout_repo
{
    if ! (git clone ${repo}) then
        echo >&2 "Fail to clone repo"
        exit 1
    else
        cd ${repo_name}
        git checkout ${source_branch} || { echo >&2 "Failed to checkout branch"; exit 1; }
        echo "Successfully cloned and checkout branch"
    fi
}

function create_new_branch
{
    git ls-remote -h --exit-code ${repo} ${branch_name}
    if [ $? == 2 ]; then
        git checkout -b ${branch_name}
        git push origin ${branch_name}
        echo "Succesfully created new branch ${branch_name}"
    else
        echo "New branch name ${branch_name} already exists in remote repo"
        exit
    fi
}

function create_new_tag
{
    git ls-remote -t --exit-code ${repo} ${tag_name}
    if [ $? == 2 ]; then
        tag_error_message=$( git tag ${tag_name} 2>&1 )
        if [ $? == 0 ]; then
            git push origin --tags
            echo "Successfully tagged"
        else
            echo "Failed to create tag: ${tag_name}"
            echo ${tag_error_message}
            let "failCount += 1"
        fi
    else
        echo "New tag name ${tag_name} already exists in remote repo"
        exit
    fi
}


#############################################
# Main Program
#############################################
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
failCount=0

echo "Will be performing branching and releasing on repo:${repo} on branch ${source_branch}"
echo "New branch name: ${branch_name}"
echo "New tag name: ${tag_name}"


checkout_repo
create_new_branch
create_new_tag

echo "Fail: ${failCount}"
