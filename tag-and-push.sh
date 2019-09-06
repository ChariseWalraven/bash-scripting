#!/usr/bin/env bash
# desired use: tap <tagname>

# 1. check number of arguments. Should be only one. If more, abort and log error message in (light) red. else continue.
current_branch=`git rev-parse --abbrev-ref HEAD`
remote=`git remote`
if [ $# -eq 1 ]
  then 
  # a. Delete remote tags by name supplied
    echo "Deleting tag $1 on remote repo..."
    git push $remote :refs/tags/$1
  # b. Delete local tags by name supplied
    echo "Deleting $1 on local repo..."
    git tag -d $1
  # c. tag locally
    echo "Tagging most recent commit on local branch with tag $1"
    git tag $1
  # d. push changes to remote with tags
    echo "Pushing commits and tags to branch $remote $current_branch"
    git push -u $remote $current_branch refs/tags/$1
  else 
    echo "Wrong number of arguments supplied. You must only supply the name of the tag you wish to have moved to the current commit and pushed to the current branch on the remote repository."
fi