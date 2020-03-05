# Undoes the last commit, includes the staged files and redoes the commit.
function git_ammend_last_commit() {
  message=`git log -1 --pretty=%B`
  git --no-pager diff --name-only --staged --exit-code
  if [[ $? == "0" ]]; then
    # if there are not staged changes we can't continue
    echo "Stage your new changes first!"
    return 1
  fi
  git reset HEAD~1 --soft
  git commit -m "$message"
}

# List all added/modified files that are not deleted matching a regex name and a word
# Usage: gmf [filename_pattern [search_word]]
# E.g. : gmf '.kt' avro
function git_modified_files() {
  if [[ $# -gt 2 ]]; then
    echo "Too many arguments, did you pass .* as first argument? pass '.*' instead."
    return 1
  fi
  if [[ $1 == "" || $1 == ".*" ]]; then
    if [[ $2 == "" ]]; then
      # list files | filter in those that are added or modified but not deleted
      git status -s -u | awk '{if ((($1 ~ "M" || $1 ~ "A") && $1 !~ "D") || $1 == "??") print $2}'
    else
      # list files | filter in those that are added or modified but not deleted | filter by extension
      git status -s -u | awk '{if ((($1 ~ "M" || $1 ~ "A") && $1 !~ "D") || $1 == "??") print $2}' | xargs grep -l -w "$2"
    fi
  else
    if [[ $2 == "" ]]; then
      # list files | filter in those that are added or modified but not deleted | filter by extension | remove the bullets
      git status -s -u | awk '{if ((($1 ~ "M" || $1 ~ "A") && $1 !~ "D") || $1 == "??") print $2}' | grep -n "$1" | awk -F: '{print $2}'
    else
      # list files | filter in those that are added or modified but not deleted | filter by extension | remove the bullets | filter by text 
      git status -s -u | awk '{if ((($1 ~ "M" || $1 ~ "A") && $1 !~ "D") || $1 == "??") print $2}' | grep -n "$1" | awk -F: '{print $2}' | xargs grep -l -w "$2"
    fi
  fi  
}

# Creates a wip branch (if not in one already) and a wip commit with all modified/added files.
function git_wip() {
  branch_name=`git symbolic-ref HEAD | cut -d"/" -f 3,4`;
  if [[ ! $branch_name == wip* ]]; then
    gco -b wip_$(date +"%Y-%m-%d")
  fi
  git add .
  git commit -m "wip" --no-verify
  gco master
}