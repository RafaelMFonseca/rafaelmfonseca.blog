#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

hugo

# go to public folder
cd public

# add changes to git
git add .

# commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# pushes the code to GitHub
git push origin main

cd ..