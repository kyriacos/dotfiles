#!/bin/bash                                                                                                          
# original credit to http://stackoverflow.com/questions/372506/how-can-i-search-git-branches-for-a-file-or-directory/372654#372654
# usage: "gitfind.sh <regex>"

LOC=refs/remotes/origin
#LOC=refs/heads  # to search local branches only                                                                                                    

for branch in `git for-each-ref --format="%(refname)" $LOC`; do
  found=$(git ls-tree -r --name-only $branch | grep "$1")
  if [ $? -eq 0 ]; then
    echo ${branch#$LOC/}:; echo "  $found"
  fi
done
