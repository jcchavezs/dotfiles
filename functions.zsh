# Open the Pull Request URL for your current directory's branch (base branch defaults to master)
function git_open_pr() {
  github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's@biz:@biz/@' -e 's%\.git$%%' | awk '/github/'`;
  branch_name=`git symbolic-ref HEAD | cut -d"/" -f 3,4`;
  if [[ $branch_name == "master" ]]; then
    echo "It is not possible to open a PR from master. Switch to another branch."
    return 1
  fi
  pr_url=$github_url"/compare/master..."$branch_name
  echo "Creating a PR for '${branch_name}' via ${pr_url}"
  open $pr_url;
}

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

function git_modified_files() {
  if [[ $1 == "" ]]; then
    git status -s | awk '{if ($1 == "M") print $2}'
  else
    git status -s | awk '{if ($1 == "M") print $2}' | grep -n "$1" | awk -F: '{print $2}'
  fi  
}