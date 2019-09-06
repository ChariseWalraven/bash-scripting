#!/bin/bash
repos=(
  "CZ-Prod"
  "Just-Test"
  "Just-Accp"
  "Just-Prod"
  "PZP-Test"
  "PZP-Accp"
  "PZP-Prod"
)

echo "changing to correct directory"
cd ~/code/cz/cordova-plugin-onegini-config
echo "In directory $PWD"

echo "starting loop"
for repo in  "${repos[@]}"; do
  echo "checking out $repo"
  git checkout $repo
  git status
  echo "pushing to origin $repo"
  git push -u origin $repo
done