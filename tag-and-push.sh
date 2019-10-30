#!/bin/bash
# desired use: tap <tagname>

current_branch=`git rev-parse --abbrev-ref HEAD`
remote=`git remote`
# there should only be one argument
# TODO: consider colours. Should I colour code the results? Definitely not necessary, but might be a nice touch, and also helps to communicate if something went well or wrong. Also, how far do we take this?
if [ $# -eq 1 ]
  then 
    echo -e "\033[33mDeleting tag $1 on remote repo...\033[39m"
    git push $remote :refs/tags/$1
    echo -e "\033[33mDeleting $1 on local repo...\033[39m"
    git tag -d $1
    echo -e "\033[33mTagging most recent commit on local branch with tag $1...\033[39m"
    git tag $1
    echo -e "\033[34mDone tagging\033[39m"
    echo -e "\033[33mPushing commits and tags to branch $remote $current_branch...\033[39m"
    git push -u $remote $current_branch && git push origin refs/tags/$1
    echo -e "\033[1;32mFinished.\033[39m"
  else 
    echo -e "\033[91mWrong number of arguments supplied. You must only supply the name of the tag you wish to have moved to the current commit and pushed to the current branch on the remote repository.\033[39m"
fi
