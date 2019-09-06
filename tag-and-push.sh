#!/usr/bin/env bash
# desired use: tap <tagname>

current_branch=`git rev-parse --abbrev-ref HEAD`
remote=`git remote`
# there should only be one argument
# TODO: consider colours. Should I colour code the results? Definitely not necessary, but might be a nice touch, and also helps to communicate if something went well or wrong. Also, how far do we take this?
if [ $# -eq 1 ]
  then 
    echo -e "\e[33mDeleting tag $1 on remote repo...\e[39m"
    git push $remote :refs/tags/$1
    echo -e "\e[33mDeleting $1 on local repo...\e[39m"
    git tag -d $1
    echo -e "\e[33mTagging most recent commit on local branch with tag $1...\e[39m"
    git tag $1
    echo -e "\e[32mDone.\e[39m"
    echo -e "\e[33mPushing commits and tags to branch $remote $current_branch...\e[39m"
    git push -u $remote $current_branch refs/tags/$1
    echo -e "\e[1;34mFinished.\e[39m"
  else 
    echo -e "\e[91mWrong number of arguments supplied. You must only supply the name of the tag you wish to have moved to the current commit and pushed to the current branch on the remote repository.\e[39m"
fi